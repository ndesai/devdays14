import QtQuick 2.0
import QtGraphicalEffects 1.0
import "../utils" as Utils
Rectangle {
    id: root
    signal opening
    signal opened
    signal closing
    signal closed
    property Item attachTo
    property variant dataObject
    property Component sourceComponent
    function getProperty(propertyName)
    {
        if(typeof dataObject !== "undefined"
                && dataObject
                && typeof dataObject[propertyName] !== "undefined")
        {
            return dataObject[propertyName];
        }
        return "";
    }
    width: parent.width
    height: parent.height
    z: (attachTo) ? attachTo.z + 2 : 1
    layer.enabled: true
    layer.smooth: true
    anchors.top: parent.top
    Utils.ClickGuard { }
    color: "#ffffff"
    Item {
        id: _Dummy
    }
    Loader {
        id: _Loader
        anchors.fill: parent
        onLoaded: root.state = "";
        z: 2
    }
    state: "hidden"
    states: [
        State {
            name: "hidden"
            PropertyChanges {
                target: root
                anchors.topMargin: root.height
                visible: false
            }
        }
    ]
    transitions: [
        Transition {
            from: "hidden"
            to: ""
            SequentialAnimation {
                ScriptAction { script: root.opening() }
                NumberAnimation {
                    target: root; property: "anchors.topMargin";
                    duration: 400; easing.type: Easing.OutCubic
                }
                ScriptAction { script: root.opened() }
            }
        },
        Transition {
            from: ""
            to: "hidden"
            SequentialAnimation {
                ScriptAction { script: root.closing() }
                NumberAnimation {
                    target: root; property: "anchors.topMargin";
                    duration: 400; easing.type: Easing.OutCubic
                }
                PropertyAction { target: root; property: "visible" }
                ScriptAction { script: _Loader.sourceComponent = undefined; }
                ScriptAction { script: root.closed() }

            }
        }
    ]
    function open()
    {
        _Loader.sourceComponent = root.sourceComponent
    }
    function openWithObject(obj)
    {
        if(!obj) return;
        dataObject = obj;
        open();
    }
    function close()
    {
        state = "hidden"
    }
    Utils.GestureArea {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 10
        onSwipeRight: root.close()
        z: 3
    }
}
