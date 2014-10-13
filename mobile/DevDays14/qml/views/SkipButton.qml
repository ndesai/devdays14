import QtQuick 2.0
import "../utils" as Utils

Rectangle {
    id: root
    signal clicked
    property bool skeleton : false
    property alias rowWidth : _Row.width
    property alias text : _Label.text
    width: _Row.width
    height: 52
    radius: 10
    property color baseColor : __theme.qtColorMediumGreen
    color: !skeleton ? baseColor : "transparent"
    border { width: !root.skeleton ? 0 : 2; color: root.baseColor }
    transformOrigin: Item.Center
    // There is a painting delay if we hide this icon
    // when not in use. It stutters the animation
    // visible: opacity>0
    clip: true
    layer.enabled: true
    layer.smooth: true
    Row {
        id: _Row
        height: parent.height
        width: childrenRect.width
        Utils.BaseIcon {
            anchors.centerIn: undefined
            anchors.verticalCenter: parent.verticalCenter
            source: "../img/icon-next-fat.png"
            color: _Label.color
            width: 24
            Utils.Fill { color: "pink" }
        }
        Utils.HorizontalSpacer { width: 12 }
        Label {
            id: _Label
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 1
            font.pixelSize: 24
//            font.weight: Font.DemiBold
            color: !skeleton ? "#ffffff" : root.baseColor
            text: qsTr("SKIP")
            style: Text.Raised
            styleColor: !root.skeleton ? "transparent" : root.baseColor
        }
        Utils.HorizontalSpacer { width: 24 }
    }
    Utils.ClickGuard { onClicked: root.clicked() }
}
