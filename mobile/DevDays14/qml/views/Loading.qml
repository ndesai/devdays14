import QtQuick 2.0
import QtGraphicalEffects 1.0 as QGE
import "../utils" as Utils
Item {
    id: root
    property variant attachTo
    anchors.fill: parent
    Utils.ClickGuard { }
    Rectangle {
        id: _Rectangle
        anchors.fill: parent
        color: "#ffffff"
        opacity: 0.85
    }
    Spinner {
        anchors.centerIn: parent
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
