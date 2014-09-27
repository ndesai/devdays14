import QtQuick 2.0
import "../utils" as Utils
Rectangle {
    id: root

    property alias text : _Label.text
    signal clicked
    property color buttonColor : __theme.qtColorLightGreen
    width: parent.width
    height: visible ? 80 : 0
    radius: 10
    color: !_ClickGuard.pressed ? buttonColor : Qt.darker(buttonColor)
    visible: false
    Behavior on height {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }
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
           root.visible = false
       }
    }
}
