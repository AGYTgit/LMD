import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes
import Qt5Compat.GraphicalEffects

RowLayout { id: workspaces
    spacing: 12

    property var primaryModel: []
    property var secondaryModel: []

    Process {
        running: true
        command: ["zsh", Quickshell.configDir + "/scripts/get-workspaces.sh", "left", "1", "0"]
        stdout: SplitParser {
            onRead: data => {
                let trimmed = data.trim();
                if (trimmed.length > 0) {
                    try {
                        let parsed = JSON.parse(trimmed);
                        if (Array.isArray(parsed)) {
                            workspaces.primaryModel = parsed;
                        }
                    } catch (e) {
                        console.error("Failed to parse workspaces JSON: ", e);
                    }
                }
            }
        }
    }

    Process {
        running: true
        command: ["zsh", Quickshell.configDir + "/scripts/get-workspaces.sh", "right", "1", "0"]
        stdout: SplitParser {
            onRead: data => {
                let trimmed = data.trim();
                if (trimmed.length > 0) {
                    try {
                        let parsed = JSON.parse(trimmed);
                        if (Array.isArray(parsed)) {
                            workspaces.secondaryModel = parsed;
                        }
                    } catch (e) {
                        console.error("Failed to parse workspaces JSON: ", e);
                    }
                }
            }
        }
    }

    ColumnLayout { id: wsMain
        Layout.alignment: Qt.AlignVCenter
        spacing: 10

        Repeater {
            model: workspaces.primaryModel

            Image {
                source: modelData.dummy 
                    ? Quickshell.configDir + "/assets/workspaces/dummy.png" 
                    : Quickshell.configDir + "/assets/workspaces/circle-" + Math.min(modelData.windows, 4) + ".png"
                
                width: 11
                height: width
                sourceSize.width: 11
                sourceSize.height: 11

                opacity: modelData.active ? 1.0 : (modelData.occupied ? 0.7 : 0.4)
            }
        }
    }

    ColumnLayout { id: wsSec
        Layout.alignment: Qt.AlignVCenter
        spacing: 10

        Repeater {
            model: workspaces.secondaryModel

            Image {
                source: modelData.dummy 
                    ? Quickshell.configDir + "/assets/workspaces/dummy.png" 
                    : Quickshell.configDir + "/assets/workspaces/circle-" + Math.min(modelData.windows, 4) + ".png"
                
                width: 11
                height: width
                sourceSize.width: 11
                sourceSize.height: 11

                opacity: modelData.active ? 1.0 : (modelData.occupied ? 0.7 : 0.4)
            }
        }
    }
}
