import QtQuick 2.0
import "../utils" as Utils

Rectangle {
    id: root

    signal clicked
    property alias text : _Label.text
    property color buttonColor : __theme.qtColorLightGreen
    property bool skeleton : false

    width: parent.width
    height: 80
    radius: 10
    color: !skeleton ? !_ClickGuard.pressed ? buttonColor : Qt.darker(buttonColor)
    : !_ClickGuard.pressed ? "transparent" : "#f3f3f3"

    border { width: root.skeleton ? 2 : 0; color: root.buttonColor }
    Label {
        id: _Label
        anchors.fill: parent
        anchors.margins: 12
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: !root.skeleton ? "#ffffff" : root.buttonColor
        font.pixelSize: 30
        font.weight: !root.skeleton ? Font.DemiBold : Font.Normal
        elide: Text.ElideRight
        style: Text.Raised
        styleColor: !root.skeleton ? "transparent" : root.buttonColor
    }
    Utils.ClickGuard {
       id: _ClickGuard
       onClicked: {
           root.clicked()
       }
    }
}
