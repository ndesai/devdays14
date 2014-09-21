import QtQuick 2.3
import "../utils" as Utils
Rectangle {
    id: root

    default property alias content : _Item_Container.data

    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 164
    color: "#f3f3f3"

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 2
        color: "#d1d1d0"
    }

    Item {
        id: _Item_Container
        anchors.fill: parent
        anchors.topMargin: 40
        Utils.Fill { }
    }
}
