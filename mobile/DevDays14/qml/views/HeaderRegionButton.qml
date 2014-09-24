import QtQuick 2.3
import "../utils" as Utils

Rectangle {
    id: root
    signal clicked
    property bool active : false
    property alias text : _Label.text
    radius: 15
    color: active ? "#dddddd" : "transparent"
    width: childrenRect.width + 30
    height: childrenRect.height + 20
    anchors.verticalCenter: parent.verticalCenter
    Label {
        id: _Label
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 2
        font.pixelSize: 28
    }
    Utils.ClickGuard {
        onClicked: root.clicked()
    }
}
