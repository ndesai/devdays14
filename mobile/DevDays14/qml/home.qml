import QtQuick 2.3
import "views" as Views
import "utils" as Utils
import DevDays14 1.0 as DD14


Item {
    id: root

    property bool isScreenPortrait: height >= width

    property alias header: _Header

    height: Qt.platform.os === "ios" ? 750 : parent.height
    width:  Qt.platform.os === "ios" ? 1334 : parent.width

    property alias __theme : _QtObject_Theme

    QtObject {
        id: _QtObject_Theme

        property color qtColorLightGreen : "#7fc438"
        property color qtColorDarkGreen : "#026426"
        property color lightGrey : "#f3f3f3"
        property color lightGreyAccent : "#d1d1d0"
        property color lightGreyAccentSecondary : "#eeeeee"
        property alias fontFamily: font.name

        property int dateViewHeight: 100
        property int dateViewPixelSize: 34

        property int scheduleViewPixelSize: 36
        property int scheduleViewTitlePixelSize: 34
        property int colorIndicatorWidth: 10
        property int colorIndicatorBorderWidth: 2
    }

    StateGroup {
        id: _StateGroup_Theme

        state: "android"

        states: [
            State {
                name: "ios"
                when: Qt.platform.os === "ios"
                PropertyChanges { target: fontI; source: "Avenir Next" }
                PropertyChanges { target: fontL; source: "Avenir Next" }
                PropertyChanges { target: fontLI; source: "Avenir Next" }
                PropertyChanges { target: font; source: "Avenir Next" }
            },
            State {
                name: "android"
                when: Qt.platform.os === "android"
                PropertyChanges { target: fontI; source: "qrc:/fonts/resources/fonts/Muli-Italic.ttf" }
                PropertyChanges { target: fontL; source: "qrc:/fonts/resources/fonts/Muli-Light.ttf" }
                PropertyChanges { target: fontLI; source: "qrc:/fonts/resources/fonts/Muli-LightItalic.ttf" }
                PropertyChanges { target: font; source: "qrc:/fonts/resources/fonts/Muli-Regular.ttf" }
                PropertyChanges { target: __theme; dateViewHeight: Math.ceil(DD14.ScreenValues.dp * (DD14.ScreenValues.isTablet ? 56 : (isScreenPortrait ? 48 : 40))) * 0.78 }
                PropertyChanges { target: __theme; dateViewPixelSize: 14 * DD14.ScreenValues.dp }
                PropertyChanges { target: __theme; scheduleViewPixelSize: 16 * DD14.ScreenValues.dp }
                PropertyChanges { target: __theme; scheduleViewTitlePixelSize: 17 * DD14.ScreenValues.dp }
                PropertyChanges { target: __theme; colorIndicatorWidth: 6 * DD14.ScreenValues.dp }
                PropertyChanges { target: __theme; colorIndicatorBorderWidth: 1 * DD14.ScreenValues.dp }
            }
        ]
    }

    FontLoader { id: fontI }
    FontLoader { id: fontL }
    FontLoader { id: fontLI }
    FontLoader { id: font }

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
