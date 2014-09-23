import QtQuick 2.3
import "../utils" as Utils
Utils.BaseTabBarPage {
    id: root

    Rectangle {
        id: _Rectangle_DateView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 100
        color: __theme.qtColorLightGreen

        ListView {
            id: _ListView_DateView
            property int delegateWidth : width / 1.5
            anchors.fill: parent
            orientation: ListView.Horizontal
            snapMode: ListView.SnapOneItem
            highlightRangeMode: ListView.StrictlyEnforceRange
            preferredHighlightBegin: ((width - delegateWidth) / 2)
            preferredHighlightEnd: preferredHighlightBegin + delegateWidth
            highlightMoveDuration: 400

            onCurrentIndexChanged: {
                _ListView_ScheduleView.currentIndex = currentIndex
            }
            model: __models.schedule && __models.schedule.schedule ?
                       __models.schedule.schedule
                     : 0

            delegate: Item {
                id: _Item_Delegate
                property variant dataModel : modelData
                width: ListView.view.delegateWidth
                height: ListView.view.height

                Item {
                    id: _Item_DateView
                    width: parent.width
                    height: _Rectangle_DateView.height
                    Label {
                        anchors.fill: parent
                        anchors.margins: 15
                        anchors.topMargin: 18
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: modelData.day.date.formatted
                        color: "#ffffff"
                        Utils.Fill { }
                    }
                    Rectangle {
                        width: parent.width
                        height: 4
                        anchors.bottom: parent.bottom
                        color: __theme.qtColorDarkGreen
                        opacity: _Item_Delegate.ListView.isCurrentItem ? 1 : 0
                        Behavior on opacity { NumberAnimation { duration: 100 } }
                    }
                    Utils.Fill { color: index%2==0?"red":"yellow" }
                }
                Utils.ClickGuard {
                    onClicked: _Item_Delegate.ListView.view.currentIndex = index
                }
            }
        }
    }

    ListView {
        id: _ListView_ScheduleView
        // This ListView has one delegate per day of schedule
        anchors.top: _Rectangle_DateView.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange
        preferredHighlightBegin: 0
        preferredHighlightEnd: 1*width
        highlightMoveDuration: _ListView_DateView.highlightMoveDuration
        cacheBuffer: 2*width*count

        onCurrentIndexChanged: {
            _ListView_DateView.currentIndex = currentIndex
        }
        model: _ListView_DateView.model
        delegate: Item {
            id: _Item_ScheduleView
            width: ListView.view.width
            height: ListView.view.height
            layer.enabled: true
            layer.smooth: true
            Flickable {
                anchors.fill: parent
                flickableDirection: Flickable.VerticalFlick
                contentWidth: width
                contentHeight: _Column_Sessions.height
                clip: true
                Column {
                    id: _Column_Sessions
                    width: parent.width
                    height: childrenRect.height
                    Repeater {
                        id: _Repeater_Sessions
                        model: modelData.sessions
                        delegate: Item {
                            id: _Item_ScheduleDelegate
                            width: _Column_Sessions.width
                            height: _Rectangle_SessionTime.height + _Column_Tracks.height
                            //                            clip: true
                            Rectangle {
                                id: _Rectangle_SessionTime
                                width: parent.width - 2
                                height: 80
                                color: __theme.lightGrey
                                Label {
                                    anchors.fill: parent
                                    anchors.leftMargin: 30
                                    anchors.rightMargin: 30
                                    verticalAlignment: Text.AlignVCenter
                                    text: modelData.date.formatted
                                    color: "#222222"
                                    style: Text.Raised
                                    styleColor: "#ffffff"
                                    font.pixelSize: 36
                                    elide: Text.ElideRight
                                }
                                Utils.AccentTop {
                                    color: __theme.lightGreyAccent
                                }
                                Utils.AccentBottom {
                                    color: __theme.lightGreyAccentSecondary
                                }
                            }
                            Column {
                                id: _Column_Tracks
                                anchors.top: _Rectangle_SessionTime.bottom
                                anchors.left: parent.left
                                anchors.right: parent.right
                                height: childrenRect.height
                                clip: true
                                Repeater {
                                    id: _Repeater_Tracks
                                    model: modelData.tracks
                                    delegate: Rectangle {
                                        id: _Rectangle_Track
                                        property variant trackDetail : __models.legend[modelData.track] || { }
                                        height: Math.max(80, _Column_TrackInformation.height + 30)
                                        width: _Column_Tracks.width
                                        color: _ClickGuard_Track.pressed ? "#dddddd" : "#ffffff"

                                        Rectangle {
                                            id: _Rectangle_TrackColor
                                            width: 10
                                            anchors.top: parent.top
                                            anchors.topMargin: 20
                                            anchors.bottom: parent.bottom
                                            anchors.bottomMargin: 20
                                            anchors.left: parent.left
                                            anchors.leftMargin: 20
                                            color: _Rectangle_Track.trackDetail.color || __theme.qtColorLightGreen
                                            radius: 5
                                            Rectangle {
                                                radius: parent.radius
                                                anchors.fill: parent
                                                opacity: 0.25
                                                border { width: 2; color: Qt.darker(_Rectangle_TrackColor.color) }
                                            }
                                        }

                                        Column {
                                            id: _Column_TrackInformation
                                            anchors.left: _Rectangle_TrackColor.right
                                            anchors.right: parent.right
                                            anchors.leftMargin: 20
                                            anchors.rightMargin: 30
                                            anchors.verticalCenter: parent.verticalCenter
                                            Label {
                                                id: _Label_TrackTitle
                                                anchors.left: parent.left
                                                anchors.right: parent.right
                                                font.pixelSize: 34
                                                wrapMode: Text.WordWrap
                                                text: modelData.title
                                                Utils.Fill { color: index%2===0?"blue":"green" }
                                            }
                                            Item { width: 1; height: 4; visible: _Label_TrackPresenter.visible }
                                            Label {
                                                id: _Label_TrackPresenter
                                                anchors.left: parent.left
                                                anchors.right: parent.right
                                                font.pixelSize: 30
                                                wrapMode: Text.WordWrap
                                                visible: text !== ""
                                                text: modelData.presenter
                                                color: "#525252"
                                                font.italic: true
                                            }
                                            Item { width: 1; height: 4; visible: _Label_TrackLocation.visible }
                                            Label {
                                                id: _Label_TrackLocation
                                                anchors.left: parent.left
                                                anchors.right: parent.right
                                                font.pixelSize: 28
                                                wrapMode: Text.WordWrap
                                                visible: text !== ""
                                                text: modelData.location
                                                color: "#525252"
                                            }
                                        }
                                        Utils.ClickGuard {
                                            id: _ClickGuard_Track
                                            onClicked: {
                                                console.log(JSON.stringify(_Rectangle_Track.trackDetail))
                                                console.log(JSON.stringify(__models.track[modelData.id], null, 2))
                                            }
                                        }

                                        Utils.AccentBottom {
                                            color: __theme.lightGreyAccent
                                            visible: index<_Repeater_Tracks.count-1
                                        }
                                        Utils.Fill { color: index%2===0?"yellow":"red" }
                                    }
                                }
                            }
                            Utils.Fill { color: "blue"; anchors.fill: _Column_Tracks }
                        }
                    }
                }
            }
        }
    }
}
