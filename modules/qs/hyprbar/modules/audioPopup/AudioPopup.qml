import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

Scope {
    PwObjectTracker {
        objects: [
            Pipewire.defaultAudioSink,
            // Pipewire.defaultAudioSource
        ]
    }

    Connections {
        target: Pipewire.defaultAudioSink?.audio

        function onVolumeChanged() {
            panel.isVisible = true
            hideTimer.restart();
        }
    }

    Timer { id: hideTimer
        interval: 1000
        onTriggered: panel.isVisible = false
    }

    PanelWindow { id: panel
        exclusionMode: ExclusionMode.Ignore
        aboveWindows: true
        focusable: false
        mask: Region {}

        anchors {
            left: true
        }

        property bool isVisible: false
        margins.left: isVisible ? 1920 - width : 1920

        Behavior on margins.left {
            NumberAnimation {
                duration: 150
                easing.type: Easing.OutCubic
            }
        }

        implicitWidth: 48
        implicitHeight: 416 / 2

        color: "#00000000"

        Rectangle { id: bg
            anchors.fill: parent

            topLeftRadius: parent.width
            bottomLeftRadius: parent.width

            color: "#0b0a0f"
            // add blur
        }

        Slider { id: outputSlider
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
                leftMargin: (parent.width - width) / 2
            }

            from: 0
            to: 100
            value: Math.round((Pipewire.defaultAudioSink?.audio.volume ?? 0) * 100)

            orientation: Qt.Vertical

            width: 12
            height: 150

            background: Rectangle {
                implicitWidth: parent.availableWidth
                implicitHeight: parent.availableHeight
                radius: width
                color: "#bdbebf"

                Rectangle {
                    width: parent.width
                    height: (1 - parent.parent.visualPosition) * parent.height
                    x: parent.x
                    y: parent.height * parent.parent.visualPosition
                    radius: width
                    color: "#33ccff"
                }
            }

            handle: Rectangle {
                x: parent.availableWidth / 2 - width / 2
                y: parent.visualPosition * (parent.availableHeight - height)
                implicitWidth: parent.availableWidth
                implicitHeight: parent.availableHeight / 4
                radius: width
                color: "#5d5e5f"

                Behavior on y {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }
    }
}
