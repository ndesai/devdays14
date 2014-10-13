import QtQuick 2.3
import "views" as Views
import "utils" as Utils
import DevDays14 1.0 as DD14

Rectangle {
    id: root

    property bool isScreenPortrait: height >= width

    property alias header: _Header

    color: "#ffffff"
    width:  parent.width
    height: parent.height
    focus: true

    property alias __theme : _QtObject_Theme

    QtObject {
        id: _QtObject_Theme

        property color qtColorLightGreen : "#7fc438"
        property color qtColorDarkGreen : "#026426"
        property color qtColorMediumGreen : "#5c9c1c"
        property color tankGreen : "#484f40"
        property color lightGrey : "#f3f3f3"
        property color lightGreyAccent : "#d1d1d0"
        property color lightGreyAccentSecondary : "#eeeeee"
        property alias fontFamily: font.name
        property int topMargin: 40

        property int headerHeight: 128
        property int headerRegionButtonFontSize : 28

        property int dateViewHeight: 100
        property int dateViewPixelSize: 34

        property int scheduleViewPixelSize: 36
        property int scheduleViewTitlePixelSize: 34
        property int scheduleViewTrackNamePixelSize : 22
        property int scheduleViewPresenterPixelSize : 30

        property int colorIndicatorWidth: 10
        property int colorIndicatorBorderWidth: 2

        property int detailPixelSize: 34
        property int detailTitlePixelSize: 40
        property int detailAbstractPixelSize: 30
        property int detailPresenterPixelSize: 36

        property int informationAddressPixelSize: 32
        property int informationTitlePixelSize: 36
        property int informationDatePixelSize: 34
        property int informationVenueDescriptionPixelSize: 28

        function shadeColor(c, percent) {
            var color = c.toString()
            var R = parseInt(color.substring(1,3),16);
            var G = parseInt(color.substring(3,5),16);
            var B = parseInt(color.substring(5,7),16);

            R = parseInt(R * (100 + percent) / 100);
            G = parseInt(G * (100 + percent) / 100);
            B = parseInt(B * (100 + percent) / 100);

            R = (R<255)?R:255;
            G = (G<255)?G:255;
            B = (B<255)?B:255;

            var RR = ((R.toString(16).length==1)?"0"+R.toString(16):R.toString(16));
            var GG = ((G.toString(16).length==1)?"0"+G.toString(16):G.toString(16));
            var BB = ((B.toString(16).length==1)?"0"+B.toString(16):B.toString(16));

            return "#"+RR+GG+BB;
        }
    }

    property bool isApple : Qt.platform.os === "ios"
                            || Qt.platform.os === "osx"
                            || Qt.platform.os === "mac"
    StateGroup {
        id: _StateGroup_Theme
        states: [
            State {
                name: "iphone5"
                extend: "ios"
                when: root.isApple && root.width === 640
                PropertyChanges {
                    target: __theme
                    dateViewPixelSize: 30
                }
            },
            State {
                name: "iphone6"
                extend: "ios"
                when: root.isApple && root.width > 640
            },
            State {
                name: "ios"
                PropertyChanges {
                    target: __theme;
                    fontFamily: "Avenir Next"
                }
            },
            State {
                name: "android"
                when: Qt.platform.os === "android"
                PropertyChanges { target: fontI; source: "qrc:/fonts/resources/fonts/Muli-Italic.ttf" }
                PropertyChanges { target: fontL; source: "qrc:/fonts/resources/fonts/Muli-Light.ttf" }
                PropertyChanges { target: fontLI; source: "qrc:/fonts/resources/fonts/Muli-LightItalic.ttf" }
                PropertyChanges { target: font; source: "qrc:/fonts/resources/fonts/Muli-Regular.ttf" }
                PropertyChanges {
                    target: __theme
                    fontFamily: font.name
                    headerRegionButtonFontSize: 14 * DD14.ScreenValues.dp
                    dateViewHeight: Math.ceil(DD14.ScreenValues.dp * (DD14.ScreenValues.isTablet ? 56 : (isScreenPortrait ? 48 : 40))) * 0.78
                    dateViewPixelSize: 14 * DD14.ScreenValues.dp
                    scheduleViewPixelSize: 16 * DD14.ScreenValues.dp
                    scheduleViewTitlePixelSize: 16 * DD14.ScreenValues.dp
                    scheduleViewTrackNamePixelSize : 12 * DD14.ScreenValues.dp
                    scheduleViewPresenterPixelSize : 14 * DD14.ScreenValues.dp
                    colorIndicatorWidth: 6 * DD14.ScreenValues.dp
                    colorIndicatorBorderWidth: 1 * DD14.ScreenValues.dp
                    detailPixelSize: 16 * DD14.ScreenValues.dp
                    detailTitlePixelSize: 18 * DD14.ScreenValues.dp
                    detailAbstractPixelSize: 14 * DD14.ScreenValues.dp
                    detailPresenterPixelSize: 16 * DD14.ScreenValues.dp
                    informationAddressPixelSize: 17 * DD14.ScreenValues.dp
                    informationTitlePixelSize: 17 * DD14.ScreenValues.dp
                    informationDatePixelSize: 15 * DD14.ScreenValues.dp
                    informationVenueDescriptionPixelSize: 14 * DD14.ScreenValues.dp
                    topMargin: 0
                }
                PropertyChanges {
                    target: _config
                    maps: _config.maps_android
                }
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
        property string region : 'north-america'
        property url apiRoute : 'http://50.116.22.180:8080/devdays14-route/route'
        property string apiBaseUrl : 'http://api.app.st/devdays14/'
        property url apiSchedule : '$0$1/schedule'.replace('$0', apiBaseUrl).replace('$1', region)
        property url apiTracks : '$0$1/tracks'.replace('$0', apiBaseUrl).replace('$1', region)
        property url apiLegend : '$0$1/legend'.replace('$0', apiBaseUrl).replace('$1', region)
        property url apiInformation : '$0$1/information'.replace('$0', apiBaseUrl).replace('$1', region)

        property string coordinates : "37.602478,-122.370559"
        property variant maps_ios : [
            "comgooglemaps://?center=$coordinates$&zoom=14",
            "http://maps.apple.com/?ll=$coordinates$"
        ].map(function(e) { return e.replace("$coordinates$", coordinates) })

        property variant maps_android : [
            "geo:$coordinates$",
        ].map(function(e) { return e.replace("$coordinates$", coordinates) })

        property variant maps : maps_ios

        function openMaps()
        {
            /// TODO: Check for reachability
            // If network is available, use the address,
            // if not, use the lat/long coordinates
            for(var i = 0; i < maps.length; i++)
            {
                console.log("maps[i]="+maps[i])
                if(Qt.openUrlExternally(maps[i]))
                    break;
            }
        }
    }

    Timer {
        id: _Timer_Date
        interval: 4000; running: true; repeat: true
        onTriggered: {
            // Test case
//            var d = _Model.today.getDate()
//            var h = _Model.today.getHours() + 1
//            if(h >= 24)
//            {
//                d += 1
//                h = 0
//            }
//            _Model.today = new Date(2014, 10, d, h, 13, 09)
//            _Schedule.showToday()

            _Model.today = new Date()
        }
    }

    Utils.Model {
        id: _Model
        onApiStatusChanged: {
            if(apiStatus === Loader.Loading)
            {
                _Loading.show()
            }
            else if(apiStatus === Loader.Ready)
            {
                _Loading.hide()
            }
        }
        onDateReady: {
            _Schedule.showToday()
        }
    }

    StateGroup {
        id: _StateGroup_Region
        state: ""
        states: [
            State {
                name: "northAmerica"
                PropertyChanges {
                    target: _config
                    region: "north-america"
                }
                PropertyChanges {
                    target: _HeaderRegionButton_NorthAmerica
                    active: true
                }
            }
        ]
        transitions: [
            Transition {
                from: "*"
                to: "*"
                SequentialAnimation {
                    PropertyAction { target: _config; property: "region" }
                    ScriptAction { script: _Model.reload() }
                }
            }
        ]
    }

    // UI

    Views.Header {
        id: _Header
        Image {
            id: _Image_Logo
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            source: "img/logo-header.png"
            Timer {
                id: _Timer_Debouncer
                interval: 10000
            }
        }
        Views.RightNowIcon {
            id: _RightNowIcon
            anchors.right: parent.right
            anchors.rightMargin: 24
            Utils.ClickGuard {
                anchors.fill: parent
                anchors.margins: -10
                Utils.Fill { color: "blue" }
                onClicked: {
                    _Schedule.showToday()
                    _TabBarController.showView(_Schedule)
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
        clip: true
        Behavior on scale { NumberAnimation { duration: 350; easing.type: Easing.OutCubic} }
        Views.Schedule {
            id: _Schedule
            controller: _TabBarController
        }
        Views.FloorPlan {
            id: _FloorPlan
            controller: _TabBarController
        }
        Views.Information {
            id: _Information
            controller: _TabBarController
        }
        z: 1
    }

    // Sheets
    Views.UnderSheetDarkener {
        id: _UnderSheetDarkener
        onShowing: _Item_PageContainer.scale = 0.95
        onHiding: _Item_PageContainer.scale = 1.0
        z: 2
    }

    Keys.onBackPressed: {
        //Exit app when at the top level, this rejects the event
        //and lets the system handle it
        if (_TrackDetailSheet.state === "hidden" && !_Information.visible) {
            event.accepted = false;
        }
        else if (_TrackDetailSheet.state === "")
            _TrackDetailSheet.close()
        else if (_Information.visible)
            _TabBarController.clickFirstTab()

    }

    Views.TrackDetailSheet {
        id: _TrackDetailSheet
        onOpening: _UnderSheetDarkener.show()
        onClosing: _UnderSheetDarkener.hide()
        z: 2
    }

    Views.Loading {
        id: _Loading
        anchors.fill: _Item_PageContainer
        attachTo: _Item_PageContainer
        onClicked: {
            if(_Model.apiStatus === Loader.Error || _Model.apiStatus === Loader.Null)
            {
                _Model.reload()
            }
        }
        z: 4
    }

    // Tab Bar Controller
    // Footer
    Views.TabBarController {
        id: _TabBarController
        // A.k.a. the footer
        z: 3
        enabled: !_Loading.visible
        onHideAllPages: {
            // Close all sheets
            _TrackDetailSheet.close()
        }
    }

    Views.TutorialSheet {
        id: _TutorialSheet

        z: 10
    }

    Component.onCompleted: {
        _Model.getSettingForKey(_Model.keyEducated, function(key, value) {
            if(!key || !value)
            {
                _TutorialSheet.open()
            }
        })

    }
}
