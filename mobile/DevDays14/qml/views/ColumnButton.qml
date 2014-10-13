import QtQuick 2.0
import "../utils" as Utils
Button {
    id: root
    visible: false
    height: visible ? 80 : 0
    Behavior on height {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }
}
