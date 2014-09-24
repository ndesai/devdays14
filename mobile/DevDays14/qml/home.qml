import QtQuick 2.3
import "views" as Views
import "utils" as Utils
import DevDays14 1.0 as DD14

Item {
    id: root

    property bool isScreenPortrait: height >= width

    property alias header: _Header

    width:  parent.width
    height: parent.height

    property alias __theme : _QtObject_Theme

    QtObject {
        id: _QtObject_Theme

        property color qtColorLightGreen : "#7fc438"
        property color qtColorDarkGreen : "#026426"
        property color lightGrey : "#f3f3f3"
        property color lightGreyAccent : "#d1d1d0"
        property color lightGreyAccentSecondary : "#eeeeee"
        property alias fontFamily: font.name

        property int headerHeight: 128

        property int dateViewHeight: 100
        property int dateViewPixelSize: 34

        property int scheduleViewPixelSize: 36
        property int scheduleViewTitlePixelSize: 34
        property int colorIndicatorWidth: 10
        property int colorIndicatorBorderWidth: 2

        property int detailPixelSize: 34
        property int detailTitlePixelSize: 40
        property int detailAbstractPixelSize: 30
        property int detailPresenterPixelSize: 36
    }

    StateGroup {
        id: _StateGroup_Theme

        states: [
            State {
                name: "ios"
                when: Qt.platform.os === "ios"
                      || Qt.platform.os === "osx"
                      || Qt.platform.os === "mac"
                PropertyChanges { target: __theme; fontFamily: "Avenir Next" }
                PropertyChanges {
                    target: root
                    width: 750
                    height: 1334
                }
            },
            State {
                name: "android"
                when: Qt.platform.os === "android"
                PropertyChanges { target: fontI; source: "qrc:/fonts/resources/fonts/Muli-Italic.ttf" }
                PropertyChanges { target: fontL; source: "qrc:/fonts/resources/fonts/Muli-Light.ttf" }
                PropertyChanges { target: fontLI; source: "qrc:/fonts/resources/fonts/Muli-LightItalic.ttf" }
                PropertyChanges { target: font; source: "qrc:/fonts/resources/fonts/Muli-Regular.ttf" }
                PropertyChanges { target: __theme; fontFamily: font.name }
                PropertyChanges { target: __theme; dateViewHeight: Math.ceil(DD14.ScreenValues.dp * (DD14.ScreenValues.isTablet ? 56 : (isScreenPortrait ? 48 : 40))) * 0.78 }
                PropertyChanges { target: __theme; dateViewPixelSize: 14 * DD14.ScreenValues.dp }
                PropertyChanges { target: __theme; scheduleViewPixelSize: 16 * DD14.ScreenValues.dp }
                PropertyChanges { target: __theme; scheduleViewTitlePixelSize: 17 * DD14.ScreenValues.dp }
                PropertyChanges { target: __theme; colorIndicatorWidth: 6 * DD14.ScreenValues.dp }
                PropertyChanges { target: __theme; colorIndicatorBorderWidth: 1 * DD14.ScreenValues.dp }
                PropertyChanges { target: __theme; detailPixelSize: 16 * DD14.ScreenValues.dp }
                PropertyChanges { target: __theme; detailTitlePixelSize: 18 * DD14.ScreenValues.dp }
                PropertyChanges { target: __theme; detailAbstractPixelSize: 14 * DD14.ScreenValues.dp }
                PropertyChanges { target: __theme; detailPresenterPixelSize: 16 * DD14.ScreenValues.dp }
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
        property url apiInformation : 'http://api.app.st/devdays14/$1/information'.replace('$1', region)
    }


    Utils.Model { id: _Model }


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
                PropertyChanges {
                    target: _HeaderRegionButton_Europe
                    active: false
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

    Rectangle {
        anchors.fill: parent
        color: "#ffffff"
    }

    Views.Header {
        id: _Header
        Image {
            id: _Image_Logo
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            source: "img/logo-header.png"
            Utils.ClickGuard {
                enabled: !_Timer_Debouncer.running
                onClicked: _StateGroup_Region.state = _StateGroup_Region.state === "" ?
                               "northAmerica"
                             : ""
            }
            Timer {
                id: _Timer_Debouncer
                interval: 10000
            }
        }
        Row {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 20
            layoutDirection: Qt.RightToLeft
            spacing: 20
            Views.HeaderRegionButton {
                id: _HeaderRegionButton_NorthAmerica
                text: qsTr("North America")
                active: false
                onClicked: _StateGroup_Region.state = "northAmerica"
            }
            Views.HeaderRegionButton {
                id: _HeaderRegionButton_Europe
                text: qsTr("Europe")
                active: true
                onClicked: _StateGroup_Region.state = ""
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

    Views.TrackDetailSheet {
        id: _TrackDetailSheet
        onOpening: _UnderSheetDarkener.show()
        onClosing: _UnderSheetDarkener.hide()
        z: 2
    }


    // Tab Bar Controller
    // Footer

    Views.TabBarController {
        id: _TabBarController
        // A.k.a. the footer
        z: 3
        onHideAllPages: {
            // Close all sheets
            _TrackDetailSheet.close()
        }
    }
}
