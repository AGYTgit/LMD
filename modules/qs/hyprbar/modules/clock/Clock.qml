import QtQuick
import QtQuick.Controls
import qs.types

StyledLabel { id: root
    required property string format
    property int interval: 60000
    property bool use12HourCycle: false

    Timer {
        interval: root.interval
        running: true
        repeat: true
        onTriggered: updateTime();
    }

    Component.onCompleted: {
        updateTime()
    }

    function updateTime() {
        var now = new Date();
        root.interval = (60 - now.getSeconds()) * 1000;
        var timeString = Qt.formatDateTime(now, root.format);

        if (use12HourCycle) {
            var hour24 = now.getHours();
            var minute = now.getMinutes();
            var second = now.getSeconds();

            var hour12 = hour24 % 12;
            if (hour12 === 0) {
                hour12 = 12;
            }

            var formattedHour12;
            if (root.format.includes("hh")) {
                formattedHour12 = hour12 < 10 ? "0" + hour12 : hour12.toString();
            } else {
                formattedHour12 = hour12.toString();
            }

            var hour24String = hour24 < 10 ? "0" + hour24 : hour24.toString();

            root.text = timeString.replace(hour24String, formattedHour12);
        } else {
            root.text = timeString;
        }
    }
}
