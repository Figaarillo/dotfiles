pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Mpris

// Picks the player shown by the collapsed pill and the player view.
Singleton {
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

    readonly property string label: {
        if (!player || !player.trackTitle) return "";
        return player.trackArtist ? `${player.trackTitle} — ${player.trackArtist}` : player.trackTitle;
    }

    function formatTime(seconds) {
        const s = Math.max(0, Math.floor(seconds));
        return `${Math.floor(s / 60)}:${String(s % 60).padStart(2, "0")}`;
    }
}
