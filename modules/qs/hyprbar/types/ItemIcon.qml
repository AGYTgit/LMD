import QtQuick

Item {
    required property string source
    required property int iconWidth
    property int iconHeight: iconWidth

    implicitWidth: iconWidth
    implicitHeight: iconHeight

    Image {
        source: parent.source

        width: parent.width
        height: parent.height

        sourceSize.width: width
        sourceSize.height: height

        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
