import QtQuick 2.0
import QtGraphicalEffects 1.0 as QGE
import "../utils" as Utils
Item {
    id: root
    signal clicked
    property variant attachTo
    anchors.fill: parent
    Utils.ClickGuard {
        onClicked: root.clicked()
    }
    Rectangle {
        id: _Rectangle
        anchors.fill: parent
        color: "#ffffff"
        opacity: 0.85
    }
    Spinner {
        id: _Spinner
        anchors.centerIn: parent
    }
    Label {
        anchors.top: _Spinner.bottom
        anchors.topMargin: 40
        anchors.horizontalCenter: _Spinner.horizontalCenter
        text: qsTr("Network unavailable")
        visible: _Model.apiStatus === Loader.Error
    }

    function hide()
    {
        visible = false
    }

    function show()
    {
        visible = true
    }
}
