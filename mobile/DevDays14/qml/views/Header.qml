import QtQuick 2.3
import "../utils" as Utils
Rectangle {
    id: root

    default property alias content : _Item_Container.data
    property alias leftContent : _Item_ContainerLeft.data
    property alias rightContent : _Item_ContainerRight.data
    property bool enableLeftAndRightContainers : false

    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: __theme.headerHeight
    color: __theme.lightGrey
    clip: true

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 2
        color: __theme.lightGreyAccent
    }

    Item {
        id: _Item_Container
        anchors.top: parent.top
        anchors.topMargin: 40
        anchors.bottom: parent.bottom
        anchors.left: enableLeftAndRightContainers ? _Item_ContainerLeft.right : parent.left
        anchors.right: enableLeftAndRightContainers ? _Item_ContainerRight.left : parent.right
        anchors.leftMargin: 10
        anchors.rightMargin: anchors.leftMargin
        Utils.Fill { }
    }

    Item {
        id: _Item_ContainerLeft
        anchors.top: parent.top
        anchors.topMargin: 40
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: 110
        Utils.Fill { color: "yellow" }
    }

    Item {
        id: _Item_ContainerRight
        anchors.top: parent.top
        anchors.topMargin: 40
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: 110
        Utils.Fill { color: "red" }
    }
}
