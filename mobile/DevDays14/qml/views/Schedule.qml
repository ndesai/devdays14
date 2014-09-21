import QtQuick 2.3
import "../utils" as Utils
Utils.BaseTabBarPage {
    id: root

    ListView {
        id: _ListView
        anchors.fill: parent
        clip: true
        header: Item {
            width: _ListView.width
            height: 30
        }
        footer: Item {
            width: _ListView.width
            height: 80
        }

        delegate: Rectangle {
            height: _Item_Header_Day.height + _Column.height + 40
            Item {
                id: _Item_Header_Day
                width: parent.width
                height: 85
                Label {
                    anchors.fill: parent
                    anchors.margins: 25
                    anchors.verticalCenter: parent.verticalCenter
                    text: modelData.day.date.formatted
                    Utils.Fill { }
                }
            }
            Column {
                id: _Column
                anchors.top: _Item_Header_Day.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: childrenRect.height
                Repeater {
                    model: modelData.sessions
                    delegate: Item {
                        height: _Item_Header_Sessions.height + _ListView_Tracks.height + 60
                        width: root.width
                        Item {
                            id: _Item_Header_Sessions
                            height: 65
                            width: root.width
                            Label {
                                anchors.fill: parent
                                anchors.margins: 25
                                text: modelData.date.formatted
                                Utils.Fill { }
                            }
                        }

                        ListView {
                            id: _ListView_Tracks
                            anchors.top: _Item_Header_Sessions.bottom
                            anchors.topMargin: 20
                            model: modelData.tracks
                            width: root.width
                            height: count*120
                            interactive: false
                            delegate: Item {
                                id: _Item_Header_Tracks
                                height: 80
                                width: root.width
                                Label {
                                    id: _Label_TrackTitle
                                    anchors.left: parent.left
                                    anchors.leftMargin: 30
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: modelData.title
                                    wrapMode: Text.WordWrap
                                    font.pixelSize: 28
                                    Utils.Fill { }
                                }
                            }
                        }
                    }
                }
            }

        }
    }

    Component.onCompleted: {
        webRequest("http://api.app.st/devdays14/days", function(response, request, requestUrl) {
            _ListView.model = response
        })
    }

    function webRequest(requestUrl, callback){
        var request = new XMLHttpRequest();
        request.onreadystatechange = function() {
            var response;
            if(request.readyState === XMLHttpRequest.DONE) {
                if(request.status === 200) {
                    response = JSON.parse(request.responseText);
                } else {
                    console.log("Server: " + request.status + "- " + request.statusText);
                    response = ""
                }
                callback(response, request, requestUrl)
            }
        }
        request.open("GET", requestUrl, true); // only async supported
        request.send();
    }
}
