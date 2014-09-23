import QtQuick 2.3
import "views" as Views
import "utils" as Utils

Item {
    id: root

    property alias __theme : _QtObject_Theme
    property alias header: _Header

    height: Qt.platform.os === "ios" ? 750 : parent.height
    width:  Qt.platform.os === "ios" ? 1334 : parent.width

    QtObject {
        id: _QtObject_Theme

        property color qtColorLightGreen : "#7fc438"
        property color qtColorDarkGreen : "#026426"
        property color lightGrey : "#f3f3f3"
        property color lightGreyAccent : "#d1d1d0"
        property color lightGreyAccentSecondary : "#eeeeee"
        property alias fontFamily: font.name
    }

    FontLoader { source: Qt.platform.os === "ios" ? "Avenir Next" : "qrc:/fonts/resources/fonts/Muli-Italic.ttf" }
    FontLoader { source: Qt.platform.os === "ios" ? "Avenir Next" : "qrc:/fonts/resources/fonts/Muli-Light.ttf" }
    FontLoader { source: Qt.platform.os === "ios" ? "Avenir Next" : "qrc:/fonts/resources/fonts/Muli-LightItalic.ttf" }
    FontLoader { id: font; source: Qt.platform.os === "ios" ? "Avenir Next" : "qrc:/fonts/resources/fonts/Muli-Regular.ttf" }

    property alias _config : _QtObject_Config
    QtObject {
        id: _QtObject_Config
        property string region : 'europe'
        property url apiSchedule : 'http://api.app.st/devdays14/$1/schedule'.replace('$1', region)
        property url apiTracks : 'http://api.app.st/devdays14/$1/tracks'.replace('$1', region)
        property url apiLegend : 'http://api.app.st/devdays14/$1/legend'.replace('$1', region)
    }

    property alias __models : _QtObject_Models
    QtObject {
        id: _QtObject_Models
        property variant schedule
        property variant track
        property variant legend

        function reload()
        {
            _Timer_Debouncer.restart()

            webRequest(_config.apiLegend, function(response, request, requestUrl) {

                var legend = new Object
                response.map(function(e) {
                    legend[e.id] = e
                })
                __models.legend = legend

                webRequest(_config.apiSchedule, function(response, request, requestUrl) {
                    __models.schedule = response
                    _Timer_Debouncer.stop()
                })
                webRequest(_config.apiTracks, function(response, request, requestUrl) {
                    __models.track = response
                    _Timer_Debouncer.stop()
                })
            })
        }
    }

    StateGroup {
        id: _StateGroup_Region
        states: [
            State {
                name: "northAmerica"
                PropertyChanges {
                    target: _config
                    region: "north-america"
                }
                PropertyChanges {
                    target: _Image_Logo
                    source: "img/logo-header-northamerica.png"
                }
            }
        ]
        transitions: [
            Transition {
                from: "*"
                to: "*"
                SequentialAnimation {
                    ScriptAction { script: __models.reload() }
                }
            }
        ]
    }

    // UI

    Rectangle {
        anchors.fill: parent
        color: "#ffffff"
    }

    Views.Header {
        id: _Header
        Image {
            id: _Image_Logo
            anchors.centerIn: parent
            source: "img/logo-header-europe.png"
            Utils.ClickGuard {
                enabled: !_Timer_Debouncer.running
                onClicked: _StateGroup_Region.state = _StateGroup_Region.state === "" ?
                               "northAmerica"
                             : ""
                Timer {
                    id: _Timer_Debouncer
                    interval: 10000
                }
            }
        }
        z: 2
    }

    Item {
        id: _Item_PageContainer
        anchors.top: _Header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: _TabBarController.top

        Views.Schedule {
            id: _Schedule
            controller: _TabBarController
        }
        z: 1
    }

    Views.TabBarController {
        id: _TabBarController
        // A.k.a. the footer
        z: 2
    }


    // Temporary model retriever

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

    Component.onCompleted: _StateGroup_Region.state = "northAmerica"
}
