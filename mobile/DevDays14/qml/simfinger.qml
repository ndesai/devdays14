import QtQuick 2.0
import QtQuick.Window 2.0
import "utils" as Utils

// https://github.com/atebits/SimFinger

Utils.BaseWindow {
    id: superRoot
    width: 600
    height: 1000
    Image {
        id: _Image_Frame
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 40
        source: "img/sim/frame-iphone6.png"
        transformOrigin: Item.Center
        Loader {
            id: _Loader_iOS
            anchors.left: parent.left
            anchors.leftMargin: 167 / 2
            anchors.top: parent.top
            anchors.topMargin: 191 / 2
            width: 750
            height: 1334
            clip: true
            source: "home.qml"
            Scale {
                id: _Scale_iOS
                xScale: 0.5; yScale: 0.5
                origin.x: 0; origin.y: 0
            }
            state: "scaled"
            states: [
                State {
                    name: "scaled"
                    PropertyChanges {
                        target: _Loader_iOS
                        transform: _Scale_iOS
                    }
                }
            ]
        }
    }
//    MouseArea {
//        id: _MouseArea
//        anchors.fill: parent
//        hoverEnabled: true
//        propagateComposedEvents: true
//        onClicked: mouse.accepted = false
//    }
//    Image {
//        x: _MouseArea.mouseX
//        y: _MouseArea.mouseY
//        source: !_MouseArea.pressed ?
//                    "img/sim/cursor-default.png"
//                  : "img/sim/cursor-pressed.png"
//    }
}
