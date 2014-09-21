import QtQuick 2.0
import "views" as Views
import "utils" as Utils

Item {
    width: 750
    height: 1334

    Rectangle {
        anchors.fill: parent
        color: "#ffffff"
    }

    Views.Header {
        id: _Header
        Image {
            anchors.centerIn: parent
            source: "img/logo-header.png"
        }
        z: 2
    }

    Item {
        id: _Item_PageContainer
        anchors.top: _Header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: _TabBarController.top



        Views.Schedule {
            id: _Schedule
            controller: _TabBarController
        }
        z: 1
    }

    Views.TabBarController {
        id: _TabBarController
        // A.k.a. the footer
        z: 2
    }
}
