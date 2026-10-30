pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris

// Picks the player shown by the collapsed pill and the player view.
Singleton {
    id: root

    // playerctld is a proxy that mirrors another player, so it's skipped.
    readonly property var players: Mpris.players.values.filter(p => !p.dbusName.endsWith(".playerctld"))

    // Priority: Spotify playing > anything playing > Spotify > first player.
    readonly property var player: {
        const isSpotify = p => p.dbusName.endsWith(".spotify");
        return players.find(p => isSpotify(p) && p.isPlaying)
            ?? players.find(p => p.isPlaying)
            ?? players.find(isSpotify)
            ?? players[0]
            ?? null;
    }

    // Track info, preferring Quickshell's MPRIS data and falling back to a
    // playerctl read when it went stale (see `fallback` below)
    function title(p) { return p?.trackTitle || fallback[instanceOf(p)]?.title || ""; }
    function artist(p) { return p?.trackArtist || fallback[instanceOf(p)]?.artist || ""; }
    function art(p) { return p?.trackArtUrl || fallback[instanceOf(p)]?.art || ""; }

    readonly property string label: {
        const t = title(player);
        if (!t) return "";
        const a = artist(player);
        return a ? `${t} — ${a}` : t;
    }

    function formatTime(seconds) {
        const s = Math.max(0, Math.floor(seconds));
        return `${Math.floor(s / 60)}:${String(s % 60).padStart(2, "0")}`;
    }

    // ---------- stale metadata fallback ----------
    // Leaving Spotify's video mode, it announces a Metadata change without the
    // new values; Quickshell only rebuilds track info from pushed values, so it
    // stays empty while playerctl (which re-reads) sees the real track. While a
    // playing player has no title, re-read every player through playerctl.
    property var fallback: ({}) // playerInstance -> { title, artist, art }

    function instanceOf(p) {
        return p ? p.dbusName.replace("org.mpris.MediaPlayer2.", "") : "";
    }

    readonly property bool stale: players.some(p => p.isPlaying && !p.trackTitle)
    onStaleChanged: if (!stale) fallback = ({})

    Process {
        id: reader
        command: ["playerctl", "-a", "metadata", "--format", "{{playerInstance}}\t{{title}}\t{{artist}}\t{{mpris:artUrl}}"]
        stdout: StdioCollector {
            onStreamFinished: {
                const next = {};
                for (const line of text.split("\n")) {
                    const [instance, title, artist, art] = line.split("\t");
                    if (instance) next[instance] = { title, artist, art };
                }
                root.fallback = next;
            }
        }
    }

    Timer {
        interval: 3000
        repeat: true
        triggeredOnStart: true
        running: root.stale
        onTriggered: if (!reader.running) reader.running = true
    }
}
