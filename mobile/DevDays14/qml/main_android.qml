import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.1
import com.iktwo.components 1.0
import "android" as Android
import "utils" as Utils

Utils.BaseWindow {
    id: superRoot

    property var resolutions: [
        {"height": 480, "width": 320, "name": "HVGA", "ratio": "3:2"},
        {"height": 640, "width": 360, "name": "nHD", "ratio": "16:9"},
        {"height": 640, "width": 480, "name": "VGA", "ratio": "4:3"},
        {"height": 800, "width": 480, "name": "WVGA", "ratio": "5:3"},
        {"height": 800, "width": 600, "name": "SVGA", "ratio": "4:3"},
        {"height": 960, "width": 540, "name": "qHD", "ratio": "16:9"},
        {"height": 1280, "width": 720, "name": "720p", "ratio": "16:9"},
        {"height": 1280, "width": 800, "name": "WXGA", "ratio": "16:10"},
        {"height": 1920, "width": 1080, "name": "1080p", "ratio": "16:9"}
    ]

    property int currentResolution: 5
    property bool isScreenPortrait: height >= width

    visible: true
    width: resolutions[currentResolution]["width"]
    height: resolutions[currentResolution]["height"]

    TitleBar {
        title: "Qt Developer Days 2014"
        isScreenPortrait: superRoot.isScreenPortrait
    }

    StackView {
        id: stackView
        initialItem: tutorialPage
    }

    Component {
        id: tutorialPage
        Android.TutorialPage { }
    }

    Component.onCompleted: {
        Theme.titleBarColor = "#53ab3a"
        Theme.titleBarTextColor = "#ffffff"

        ui.showMessage("test")
    }


    MainPage {

    }
}
