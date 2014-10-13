import QtQuick 2.3

Item {
    id: root
    signal opened
    signal closed

    property alias controller : _Connections.target

    anchors.fill: parent
    visible: false

    ClickGuard { }

    Connections {
        id: _Connections
        target: null
        ignoreUnknownSignals: true
        onHideAllPages: {
            console.trace()
            console.log("hide all pages")
            root.closed()
            root.visible = false
        }
    }
    function show()
    {
        root.opened()
        visible = true
    }
}
