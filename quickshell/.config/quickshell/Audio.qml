pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

// Default sink/source shared by the bar, the controls view and the OSD.
Singleton {
    id: root

    readonly property var sink: Pipewire.defaultAudioSink
    readonly property var source: Pipewire.defaultAudioSource
    readonly property var sinks: Pipewire.nodes.values.filter(n => n.audio && n.isSink && !n.isStream)

    PwObjectTracker { objects: [root.sink, root.source] }

    function percent(node) {
        return node?.audio ? Math.round(node.audio.volume * 100) : 0;
    }

    function isMuted(node) {
        return !!node?.audio?.muted;
    }

    function setVolume(node, value) {
        if (node?.audio) node.audio.volume = Math.max(0, value);
    }

    function step(node, direction) {
        if (!node?.audio) return;
        const v = node.audio.volume;
        // Never jump down when already boosted above 100% by something else
        node.audio.volume = Math.max(0, Math.min(Math.max(v, 1.0), v + direction * 0.05));
    }

    function toggleMute(node) {
        if (node?.audio) node.audio.muted = !node.audio.muted;
    }

    function sinkIcon() {
        if (!sink?.audio || sink.audio.muted) return Icons.muted;
        const formFactor = sink.properties["device.form-factor"] ?? "";
        if (formFactor === "headphone") return Icons.headphone;
        if (formFactor === "headset") return Icons.headset;
        return Icons.level(Icons.speaker, sink.audio.volume);
    }

    function nodeName(node) {
        return node.description || node.nickname || node.name;
    }

    // ---------- OSD ----------
    // Binding a node fires a change burst; ignore it so the OSD only reacts
    // to real user changes (keys, scroll, other apps).
    property bool settled: false
    Timer { id: settle; interval: 1500; running: true; onTriggered: root.settled = true }
    onSinkChanged: { settled = false; settle.restart(); }
    onSourceChanged: { settled = false; settle.restart(); }

    Connections {
        target: root.sink?.audio ?? null
        function onVolumesChanged() { if (root.settled) ShellState.osd("volume"); }
        function onMutedChanged() { if (root.settled) ShellState.osd("volume"); }
    }

    Connections {
        target: root.source?.audio ?? null
        function onMutedChanged() { if (root.settled) ShellState.osd("mic"); }
    }
}
