import QtQuick 2.3
import "../utils" as Utils

Rectangle {
    id: root
    signal clicked
    property bool enabled : _ClickGuard.enabled
    property bool active : false
    property alias text : _Label.text
    radius: 15
    color: active ? "#dddddd" : "transparent"
    width: _Label.width + 30
    height: _Label.height + 20
    anchors.verticalCenter: parent.verticalCenter
    Label {
        id: _Label
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 2
        font.pixelSize: __theme.headerRegionButtonFontSize
    }
    Utils.ClickGuard {
        id: _ClickGuard
        onClicked: root.clicked()
    }
}
