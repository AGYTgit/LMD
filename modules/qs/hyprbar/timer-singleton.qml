pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    signal minuteUpdated()
    // New signal for a new day
    signal newDayUpdated()

    property int minuteInterval: 60000

    // Timer for minute-based updates
    Timer {
        interval: root.minuteInterval
        running: true
        repeat: true
        onTriggered: {
            root.minuteUpdated();
            root.minuteInterval = (60 - new Date().getSeconds()) * 1000;
        }
    }

    // Timer for day-based updates
    Timer {
        id: dailyTimer
        // Set the initial interval to the milliseconds remaining until midnight
        interval: {
            var now = new Date();
            var hours = now.getHours();
            var minutes = now.getMinutes();
            var seconds = now.getSeconds();
            var milliseconds = now.getMilliseconds();
            
            var remainingHours = 23 - hours;
            var remainingMinutes = 59 - minutes;
            var remainingSeconds = 59 - seconds;
            var remainingMilliseconds = 999 - milliseconds;
            
            // This is the total delay in milliseconds until the next day
            return (remainingHours * 60 * 60 * 1000) +
                   (remainingMinutes * 60 * 1000) +
                   (remainingSeconds * 1000) +
                   remainingMilliseconds;
        }
        running: true
        repeat: true // We want it to repeat every 24 hours after the first run
        onTriggered: {
            // Emit the signal to notify listeners
            root.newDayUpdated();
            
            // The timer will now automatically be set to its 24-hour interval
            // as its interval property is static after the initial calculation.
        }
    }
    
    Component.onCompleted: {
        // Set the initial interval for the minute timer
        root.minuteInterval = (60 - new Date().getSeconds()) * 1000;
        root.minuteUpdated(); // Initial update
    }
}
