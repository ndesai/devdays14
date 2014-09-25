import QtQuick 2.3
import "../utils" as Utils
Utils.BaseIcon {
    id: root
    width: 128
    color: __theme.qtColorLightGreen
    source: "../img/icon-spinner.png"
    property alias duration : _NumberAnimation.duration
    transformOrigin: Item.Center
    SequentialAnimation {
        loops: Animation.Infinite
        running: root.visible
        NumberAnimation {
            id: _NumberAnimation
            target: root
            property: "rotation"
            from: 0; to: 360;
            duration: 1200
        }
    }
}
