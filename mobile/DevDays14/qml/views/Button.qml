import QtQuick 2.0
import "../utils" as Utils

Rectangle {
    id: root

    signal clicked
    property alias text : _Label.text
    property color buttonColor : __theme.qtColorLightGreen

    width: parent.width
    height: 80
    radius: 10
    color: !_ClickGuard.pressed ? buttonColor : Qt.darker(buttonColor)

    Label {
        id: _Label
        anchors.fill: parent
        anchors.margins: 12
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "#ffffff"
        font.pixelSize: 30
        font.weight: Font.DemiBold
        elide: Text.ElideRight
    }
    Utils.ClickGuard {
       id: _ClickGuard
       onClicked: {
           root.clicked()
       }
    }
}
