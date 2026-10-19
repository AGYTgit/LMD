import QtQuick
import Quickshell
import Quickshell.Io
import qs.types

StyledLabel { id: root
    text: "--"

    property string batteryPath: "/sys/class/power_supply/BAT1"
    // property string batteryPath: "/home/agyt/projects/qs/hyprbar/bat"
    property real capacity: -1
    property string status: "unknown"

    property bool capacityActive: false
    property bool statusActive: false

    Process { id: capacityProcess
        command: ["cat", root.batteryPath + "/capacity"]
        running: capacityActive

        stdout: StdioCollector {
            onStreamFinished: {
                var capacity = parseInt(text.trim())

                root.capacity = capacity
                console.log("Updated battery capacity: " + capacity)
            }
        }
    }

    Process { id: statusProcess
        command: ["cat", root.batteryPath + "/status"]
        running: statusActive

        stdout: StdioCollector {
            onStreamFinished: {
                var status = text.trim()

                root.status = status
                console.log("Updated battery status: " + status)
            }
        }
    }

    Component.onCompleted: {

    }

    Timer { id: capacityTimer
        interval: 60000
        running: capacityActive
        repeat: true

        onTriggered: capacityProcess.running = true
    }

    Timer { id: statusTimer
        interval: 60000
        running: capacityActive
        repeat: true

        onTriggered: statusProcess.running = true
    }
}
