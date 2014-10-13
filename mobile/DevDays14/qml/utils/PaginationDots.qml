import QtQuick 2.0

ListView {
    id: root
    property variant attachTo
    currentIndex: root.attachTo.currentIndex
    anchors.horizontalCenter: parent.horizontalCenter
    width: count * height
    height: 40
    orientation: ListView.Horizontal
    model: root.attachTo.count
    visible: count > 1
    interactive: false

    property color color : "#000000"

    delegate: Item {
        id: _Item_Delegate
        width: ListView.view.height
        height: ListView.view.height
        Rectangle {
            id: _Rectangle_Dot
            anchors.fill: parent
            anchors.margins: 13
            radius: width / 2
            color: root.color
            opacity: 0.6
            states: [
                State {
                    when: index === _Item_Delegate.ListView.view.currentIndex
                    PropertyChanges {
                        target: _Rectangle_Dot
                        opacity: 1.0
                        anchors.margins: 10
                    }
                }
            ]
            transitions: [
                Transition {
                    NumberAnimation {
                        target: _Rectangle_Dot; properties: "opacity, anchors.margins";
                        duration: 300; easing.type: Easing.InOutQuad
                    }
                }
            ]
        }
    }
}
