import QtQuick 2.3
import QtQuick.Controls 1.2 as Controls
import QtQuick.Window 2.0
import "utils" as Utils

Utils.BaseWindow {
    id: superRoot
    visible: true
    width: 600
    height: 900
    color: "#000000"
    Image {
        anchors.fill: parent
        source: "img/triangular.png"
        fillMode: Image.Tile
    }
    Item {
        id: _Item_Container
        anchors.fill: parent
        anchors.margins: 50
        Item {
            id: _Item_Container_iOS
            width: 750 / 2
            height: 1334 / 2
            Loader {
                id: _Loader_iOS
                width: 750
                height: 1334
                anchors.left: parent.left;
                anchors.top: parent.top
                source: "home.qml"
                clip: true
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
        Controls.Button {
            width: _Item_Container_iOS.width
            height: 40
            anchors.top: _Item_Container_iOS.bottom
            anchors.topMargin: 25
            text: "Show Fills"
            onClicked: {
                superRoot.showFills ^= 1
            }
        }

    }
}
