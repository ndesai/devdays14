import QtQuick 2.0
import "../utils" as Utils

Utils.BaseIcon {
    id: root
    property bool isRightNow : _Model.date_isRightNow(modelData.date.plain.starting,
                                                      modelData.date.plain.ending)
    anchors.centerIn: undefined
    anchors.left: parent.left
    anchors.leftMargin: 20
    anchors.verticalCenter: parent.verticalCenter
    width: 36
    source: "../img/icon-clock.png"
    color: "#222222"
    transformOrigin: Item.Center
    visible: opacity>0
    state: "hidden"
    states: [
        State {
            name: "hidden"
            when: !root.isRightNow
            PropertyChanges {
                target: root
                scale: 0
                opacity: 0
                width: 0
            }
        },
        State {
            name: "visible"
            when: root.isRightNow
            PropertyChanges {
                target: root
                scale: 1
                opacity: 1
                width: 36
            }
        }
    ]
    transitions: [
        Transition {
            ParallelAnimation {
                NumberAnimation {
                    target: root; property: "scale";
                    duration: 450; easing.type: Easing.OutBack
                }
                NumberAnimation {
                    target: root; property: "opacity";
                    duration: 450; easing.type: Easing.OutBack
                }
                NumberAnimation {
                    target: root; property: "width";
                    duration: 300; easing.type: Easing.OutBack
                }
            }
        }
    ]
    Utils.Fill { color: "red" }
}
