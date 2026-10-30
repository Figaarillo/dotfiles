pragma Singleton
import QtQuick
import Quickshell

// Same Nerd Font codepoints the waybar config used
Singleton {
    function g(cp) { return String.fromCodePoint(cp); }

    readonly property string arch: g(0xF303)
    readonly property string cpu: g(0xF626)
    readonly property string memory: g(0xF62A)
    readonly property string disk: g(0xF02CA)
    readonly property var temperature: [g(0xF2C9), g(0xF2C8), g(0xF2C7)]

    readonly property var wifi: [g(0xF092F), g(0xF091F), g(0xF0922), g(0xF0925), g(0xF0928)]
    readonly property string ethernet: g(0xF6FF)
    readonly property string disconnected: g(0x26A0)

    readonly property string headphone: g(0xF7CA)
    readonly property string headset: g(0xF7CD)
    readonly property var speaker: [g(0xF026), g(0xF027), g(0xF028)]
    readonly property string muted: g(0xFA80)
    readonly property string mic: g(0xF130)
    readonly property string micMuted: g(0xF131)

    readonly property var backlight: [g(0xE3D5), g(0xE3D7), g(0xE3DA), g(0xF00DD), g(0xF00DE), g(0xF00DF), g(0xF00E0)]

    readonly property string clipboard: g(0xF429)
    readonly property string bell: g(0xF0A2)
    readonly property string bellDnd: g(0xF1F7)
    readonly property string clock: g(0xF017)
    readonly property string calendar: g(0xF073)
    readonly property string wallpaper: g(0xF0E0C)
    readonly property string power: g(0x23FB)

    // Island views
    readonly property string play: g(0xF040A)
    readonly property string pause: g(0xF03E4)
    readonly property string next: g(0xF04AD)
    readonly property string previous: g(0xF04AE)
    readonly property string music: g(0xF075A)
    readonly property string check: g(0xF012C)
    readonly property string lock: g(0xF033E)
    readonly property string wifiOff: g(0xF092D)
    readonly property string search: g(0xF002)
    readonly property string chevronLeft: g(0xF0141)
    readonly property string chevronRight: g(0xF0142)
    readonly property string sleep: g(0xF04B2)
    readonly property string hibernate: g(0xF0904)
    readonly property string logout: g(0xF0343)
    readonly property string reboot: g(0xF0709)
    readonly property string shutdown: g(0xF0425)
    readonly property string trash: g(0xF01B4)
    readonly property string clipboardText: g(0xF014C)

    readonly property string bluetooth: g(0xF00AF)
    readonly property string bluetoothConnected: g(0xF00B1)
    readonly property string bluetoothOff: g(0xF00B2)
    readonly property string battery: g(0xF0079)
    readonly property string settings: g(0xF0493)
    readonly property string close: g(0xF0156)
    readonly property string crop: g(0xF019E)

    // Picks the icon for a 0..1 level from an ordered list
    function level(list, value) {
        const i = Math.floor(Math.max(0, Math.min(0.999, value)) * list.length);
        return list[i];
    }
}
