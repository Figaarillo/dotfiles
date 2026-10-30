pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

// Polls the same sources waybar's builtin modules read, every 2s like waybar.
Singleton {
    id: root

    property int cpu: 0
    property int memory: 0
    property string diskFree: ""
    property int diskUsed: 0
    property int temperature: 0
    readonly property bool temperatureCritical: temperature >= 40 // waybar critical-threshold
    property real brightness: 0

    property var lastCpu: null

    function refresh() {
        stat.reload();
        const fields = stat.text().split("\n")[0].trim().split(/\s+/).slice(1).map(Number);
        const idle = fields[3] + fields[4];
        const total = fields.reduce((a, b) => a + b, 0);
        if (lastCpu && total > lastCpu.total)
            cpu = Math.round(100 * (1 - (idle - lastCpu.idle) / (total - lastCpu.total)));
        lastCpu = { idle, total };

        meminfo.reload();
        const mem = {};
        for (const line of meminfo.text().split("\n")) {
            const m = line.match(/^(\w+):\s+(\d+)/);
            if (m) mem[m[1]] = Number(m[2]);
        }
        if (mem.MemTotal) memory = Math.round(100 * (1 - mem.MemAvailable / mem.MemTotal));

        thermal.reload();
        temperature = Math.round(Number(thermal.text()) / 1000);

        refreshBacklight();

        if (!df.running) df.running = true;
    }

    // Optimistic: the slider moves instantly, the next poll corrects it
    function setBrightness(value) {
        const pct = Math.max(1, Math.min(100, Math.round(value * 100)));
        brightness = pct / 100;
        Quickshell.execDetached(["brightnessctl", "-q", "set", `${pct}%`]);
    }

    function refreshBacklight() {
        backlightNow.reload();
        backlightMax.reload();
        const max = Number(backlightMax.text());
        if (max > 0) brightness = Number(backlightNow.text()) / max;
    }

    FileView { id: stat; path: "/proc/stat"; blockLoading: true }
    FileView { id: meminfo; path: "/proc/meminfo"; blockLoading: true }
    FileView { id: thermal; path: "/sys/class/thermal/thermal_zone0/temp"; blockLoading: true }
    FileView { id: backlightNow; path: "/sys/class/backlight/intel_backlight/brightness"; blockLoading: true }
    FileView { id: backlightMax; path: "/sys/class/backlight/intel_backlight/max_brightness"; blockLoading: true }

    Process {
        id: df
        command: ["df", "-B1", "--output=avail,size", "/"]
        stdout: StdioCollector {
            onStreamFinished: {
                const [avail, size] = text.trim().split("\n")[1].trim().split(/\s+/).map(Number);
                if (!size) return;
                root.diskFree = (avail / 1024 ** 3).toFixed(1) + "GiB";
                root.diskUsed = Math.round(100 * (1 - avail / size));
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.refresh()
    }
}
