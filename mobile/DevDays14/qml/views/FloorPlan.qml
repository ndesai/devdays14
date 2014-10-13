import QtQuick 2.3
import "../utils" as Utils

Utils.BaseTabBarPage {
    id: root

    Flickable {
        id: _Flickable
        anchors.fill: parent
        contentHeight: _Image.sourceSize.height
        contentWidth: _Image.sourceSize.width
        Image {
            id: _Image
            source: "../img/sfo-floorplan.jpg"
            smooth: true
        }
    }
}
