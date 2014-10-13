import QtQuick 2.3
import "../utils" as Utils

Sheet {
    id: root
    sourceComponent: Rectangle {
        color: "#ffffff"
        Label {
            id: _Label_Welcome
            anchors.top: parent.top
            anchors.topMargin: 100
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 100
            anchors.rightMargin: 100
            font.pixelSize: 64
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            lineHeight: 0.85
            color: __theme.tankGreen
            text: qsTr("Welcome to DevDays '14")
            Utils.Fill { color: "yellow" }
        }
        ListView {
            id: _ListView
            anchors.top: _Label_Welcome.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            highlightRangeMode: ListView.StrictlyEnforceRange
            preferredHighlightBegin: 0
            preferredHighlightEnd: width
            orientation: ListView.Horizontal
            snapMode: ListView.SnapOneItem
            model: [
                {
                    image : "../img/tutorial/01-home.jpg",
                    description : "The schedule view allows you to quickly glance at all available sessions. \nSwipe left and right to navigate between days."
                },
                {
                    image : "../img/tutorial/02-detail.jpg",
                    description : "The session detail page can be accessed by clicking the session in the schedule view. This page describes the session in more detail. \nYou can also bookmark this session using the ribbon on the top right of the page."
                },
                {
                    image : "../img/tutorial/03-detail-author.jpg",
                    description : "The session detail page also presents a short biography of each presenter – including their accomplishments and contributions to the Qt community."
                },
                {
                  image: "../img/tutorial/01b-home-favs.jpg",
                   description: "Your favorited and bookmarked sessions will appear with a green ribbon on the schedule view. \nUse the \"Now\" button to quickly jump to the current session from anywhere in the app."
                },

                {
                    image : "../img/tutorial/04-floorplan.jpg",
                    description : "The floor plan section shows a simple overview of the hotel's floorplan – including each session room, registrations centers, and major banquet halls."
                },
                {
                    image : "../img/tutorial/05-about.jpg",
                    description : "The about section includes information about the hotel venue as well as information about this event and application."
                }
            ]
            delegate: Item {
                width: ListView.view.width
                height: ListView.view.height
                Label {
                    id: _Label_Description
                    anchors.top: parent.top
                    anchors.topMargin: 40
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 60
                    anchors.rightMargin: 60
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WordWrap
                    font.pixelSize: 30
                    color: __theme.tankGreen
                    height: 240
                    maximumLineCount: 6
                    elide: Text.ElideRight
                    text: modelData.description
                    Utils.Fill { color: "blue" }
                }

                Rectangle {
                    radius: 20
                    color: "#c3c5c0"
                    anchors.top: _Label_Description.bottom
                    anchors.topMargin: 26
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 90
                    anchors.rightMargin: anchors.leftMargin
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -1*radius
                    Item {
                        anchors.fill: parent
                        anchors.margins: 25
                        layer.enabled: true
                        Image {
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectCrop
                            verticalAlignment: Image.AlignTop
                            asynchronous: true
                            cache: false
                            sourceSize.width: width
                            sourceSize.height: height
                            source: modelData.image
                        }
                        clip: true
                    }

                }

                Utils.Fill { color: index%2===0?"blue":"green" }
            }
        }
        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 80
            color: "#f3f3f3"
            opacity: 0.90
            Utils.PaginationDots {
                id: _PaginationDots
                attachTo: _ListView
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                color: __theme.qtColorMediumGreen
            }
            SkipButton {
                text: getProperty("buttonLabel") ? getProperty("buttonLabel") : _ListView.currentIndex === _ListView.count - 1 ? qsTr("Start") : qsTr("Skip")
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    _Model.insertSetting(_Model.keyEducated, true)
                    root.close()
                }
            }
        }
    }
}
