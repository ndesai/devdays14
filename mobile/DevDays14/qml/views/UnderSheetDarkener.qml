import QtQuick 2.0

Rectangle {
    id: root

    signal showing
    signal hiding

    anchors.fill: parent
    color: "#99000000"

    function show()
    {
        state = ""
    }

    function hide()
    {
        state = "hidden"
    }

    state: "hidden"
    states: [
        State {
            name: "hidden"
            PropertyChanges {
                target: root
                color: "#00000000"
                visible: false
            }
        }
    ]
    transitions: [
        Transition {
            from: "hidden"
            to: ""
            SequentialAnimation {
                PropertyAction {
                    target: root
                    property: "visible"
                }
                ScriptAction { script: root.showing() }
                ColorAnimation {
                    target: root
                    property: "color"
                    duration: 350
                }
            }
        },
        Transition {
            from: ""
            to: "hidden"
            SequentialAnimation {
                ScriptAction { script: root.hiding() }
                ColorAnimation {
                    target: root
                    property: "color"
                    duration: 250
                }
                PropertyAction {
                    target: root
                    property: "visible"
                }
            }
        }
    ]
}
