import QtQuick 2.3
import QtQuick.Controls 1.2
import com.iktwo.components 1.0 as IC

IC.Page {
    id: root

    property bool readyForAnimation: active && imageIcon.status === Image.Ready
    property bool initialAnimationFinished: false

    onReadyForAnimationChanged: {
        if (readyForAnimation)
            IC.Theme.nextNumericState(root)
    }

    StackView {
        id: fakeStackView

        anchors.fill: parent
    }

    Flickable {
        id: flickable

        property bool hasFlicked: false

        anchors.fill: parent

        enabled: initialAnimationFinished
        contentHeight: columnContainer.height
        boundsBehavior: Flickable.StopAtBounds

        onMovementStarted: hasFlicked = true

        onMovementEnded: {
            if (contentY < root.height / 2) {
                contentYAnimation.enabled = true
                contentY = 0
            } else {
                contentYAnimation.enabled = true
                contentY = contentHeight - height
            }
        }

        onAtYEndChanged: {
            if (hasFlicked && atYEnd)
                enabled = false
        }

        onContentYChanged: {
            if (flickable.contentY < root.height)
                initialPageContainer.opacity = 1 - (flickable.contentY / root.height)
        }

        Behavior on contentY {
            id: contentYAnimation
            enabled: false

            SequentialAnimation {
                alwaysRunToEnd: true
                NumberAnimation { }
                ScriptAction { script: contentYAnimation.enabled = false }
            }
        }

        Column {
            id: columnContainer

            width: parent.width

            Rectangle {
                id: initialPageContainer

                height: root.height
                width: root.width
                color: IC.Theme.backgroundColor

                Behavior on opacity { NumberAnimation { duration: 150 } }

                Image {
                    id: imageIcon

                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "qrc:/images/" + IC.Theme.getBestIconSize(imageIcon.height) + "icon" // "qrc:/images/icon"

                    height: 0.8 * (isScreenPortrait ? parent.width : parent.height)
                    width: height
                    fillMode: Image.PreserveAspectFit
                    antialiasing: true
                    opacity: 0
                }

                Label {
                    id: welcomeLabel
                    anchors {
                        horizontalCenter: imageIcon.horizontalCenter
                        top: imageIcon.bottom
                    }

                    width: 0.8 * (isScreenPortrait ? parent.width : parent.height)

                    color: "#808080"
                    font.pixelSize: IC.ScreenValues.dp * 24
                    text: "Welcome to Qt Developer Days 2014"
                    wrapMode: Text.Wrap
                    horizontalAlignment: "AlignHCenter"
                    antialiasing: true
                    opacity: 0
                    renderType: Text.NativeRendering
                    MouseArea {
                        anchors.fill: parent
                        onClicked: welcomeLabel.update()
                    }
                }

                Column {
                    id: column

                    anchors {
                        top: welcomeLabel.bottom; topMargin: IC.ScreenValues.dp * 16
                        horizontalCenter: parent.horizontalCenter
                    }

                    width: 0.08 * (isScreenPortrait ? root.width : root.height)
                    opacity: 0

                    Repeater {
                        id: repeater

                        model: 3

                        Arrow {
                            id: arrow

                            property bool firstAnimation: true

                            function animate() {
                                animation.start()
                            }

                            height: column.width
                            width: column.width

                            opacity: 1 - (0.25 * (repeater.count - index))

                            SequentialAnimation on opacity {
                                id: animation

                                loops: Animation.Infinite
                                running: false

                                PauseAnimation { duration: arrow.firstAnimation ? 0 : 500 }

                                PropertyAnimation {
                                    to: 1
                                    duration: 1250
                                    easing.type: Easing.InOutQuad
                                }
                                PropertyAnimation {
                                    to: 0
                                    duration: 750
                                    easing.type: Easing.InOutQuad
                                }
                                ScriptAction {
                                    script: arrow.firstAnimation = false
                                }
                            }
                        }
                    }
                }

                Label {
                    id: swipeLabel
                    anchors {
                        horizontalCenter: imageIcon.horizontalCenter
                        top: column.bottom; topMargin: IC.ScreenValues.dp * 16
                    }

                    width: 0.8 * (isScreenPortrait ? parent.width : parent.height)

                    color: "#808080"
                    font.pixelSize: IC.ScreenValues.dp * 12
                    text: "Swipe up to begin"
                    wrapMode: Text.Wrap
                    horizontalAlignment: "AlignHCenter"
                    antialiasing: true
                    opacity: 0
                    renderType: Text.NativeRendering
                }

                Timer {
                    id: timer
                    property int activated: 0

                    repeat: true
                    interval: 250
                    onTriggered: {
                        if (activated < repeater.count) {
                            column.children[repeater.count - 1 - activated].animate()
                            activated++
                        } else {
                            repeat = false
                        }
                    }
                }
            }

            Item {
                height: root.height
                width: root.width
            }
        }
    }

    states: [
        State {
            name: "0"
            PropertyChanges {
                target: imageIcon
                opacity: 1
            }
        },
        State {
            name: "1"
            extend: "0"
            PropertyChanges {
                target: welcomeLabel
                opacity: 1
            }
        },
        State {
            name: "2"
            extend: "1"
            PropertyChanges {
                target: imageIcon
                height: 0.25 * (isScreenPortrait ? parent.width : parent.height)
                width: 0.25 * (isScreenPortrait ? parent.width : parent.height)
            }
        },
        State {
            name: "3"
            extend: "2"
            PropertyChanges {
                target: column
                opacity: 1
            }

            PropertyChanges {
                target: swipeLabel
                opacity: 1
            }
        }

    ]

    transitions: [
        Transition {
            from: ""
            to: "0"
            SequentialAnimation {
                PauseAnimation { duration: 200 }
                NumberAnimation { properties: "opacity"; duration: 500 }
                ScriptAction { script: IC.Theme.nextNumericState(root) }
            }
        },
        Transition {
            from: "0"
            to: "1"
            SequentialAnimation {
                PauseAnimation { duration: 150 }
                NumberAnimation { properties: "opacity"; duration: 500 }
                ScriptAction { script: IC.Theme.nextNumericState(root) }
            }
        },
        Transition {
            from: "1"
            to: "2"
            SequentialAnimation {
                PauseAnimation { duration: 150 }
                NumberAnimation { properties: "height, width"; duration: 750; easing.type: Easing.OutQuad }
                ScriptAction { script: IC.Theme.nextNumericState(root) }
            }
        },
        Transition {
            from: "2"
            to: "3"
            SequentialAnimation {
                ScriptAction { script: timer.restart() }
                PauseAnimation { duration: 150 }
                NumberAnimation { properties: "opacity"; duration: 500 }
                ScriptAction { script: initialAnimationFinished = true }
            }
        }
    ]
}
