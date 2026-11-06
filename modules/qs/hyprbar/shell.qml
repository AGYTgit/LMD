import Quickshell
import QtQuick
import qs.modules.audioPopup
import qs.modules.hyprbar

ShellRoot {
    id: root

    Loader {
        active: true
        sourceComponent: Hyprbar {
            screen: Quickshell.screens.find(s => s.name === "DP-1") || Quickshell.screens[0]
        }
    }
    Loader {
        active: true
        sourceComponent: AudioPopup {}
    }
}
