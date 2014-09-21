import QtQuick 2.3
import QtQuick.Controls 1.2 as Controls

Controls.ApplicationWindow {
    id: superRoot
    visible: true
    width: 1440
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
        Loader {
            id: _Loader_iOS
            width: 750 / 2
            height: 1334 / 2
            source: "main_ios.qml"
            anchors.verticalCenter: parent.verticalCenter
            Controls.Button {
                width: parent.width
                height: 40
                anchors.top: parent.bottom
                anchors.topMargin: 25
                text: "Show Fills"
                onClicked: {
                    _Loader_iOS.item.showFills ^= 1
                }
            }
        }
    }
}
