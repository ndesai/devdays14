import QtQuick 2.3
import "../utils" as Utils

Utils.TabBarController {
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    height: 100

    tabBarModel: [
        {
            icon : "../img/icon-calendar.png",
            sourceComponent: _Schedule
        },
        {
            icon : "../img/icon-list.png",
            sourceComponent: _Schedule
        },
        {
            icon : "../img/icon-list.png",
            sourceComponent: _Schedule
        }
    ]
    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 2
        color: "#d1d1d0"
        z: 2
    }
}
