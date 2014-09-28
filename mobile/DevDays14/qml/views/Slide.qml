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
        console.log("property " + propertyName + " not available")
        return "";
    }
    x: 0
    width: parent.width
    height: parent.height
    z: (attachTo) ? attachTo.z + 2 : 1
    layer.enabled: true
    layer.smooth: true
    Utils.ClickGuard { }
    color: "#ffffff"
    Item {
        id: _Dummy
    }
    Loader {
        id: _Loader
        anchors.fill: parent
        onLoaded: {
            root.state = "visible";
        }
    }
    state: "hidden"
    states: [
        State {
            name: "hidden"
            PropertyChanges {
                target: root
                x: root.width
                visible: false
            }
        },
        State {
            name: "visible"
            PropertyChanges {
                target: root
                x: 0
                visible: true
            }
        }
    ]
    transitions: [
        Transition {
            from: "hidden"
            to: "visible"
            SequentialAnimation {
                ScriptAction { script: root.opening() }
                NumberAnimation {
                    target: root; property: "x";
                    duration: 400; easing.type: Easing.OutCubic
                }
                ScriptAction { script: root.opened() }
            }
        },
        Transition {
            from: "visible"
            to: "hidden"
            SequentialAnimation {
                ScriptAction { script: root.closing() }
                NumberAnimation {
                    target: root; property: "x";
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

    Utils.Fill { anchors.fill: _MouseArea_Drag; color: "#ff00ff" }

    Behavior on x {
        id: _Behavior_X
        enabled: false
        NumberAnimation {
            duration: 400
            easing.type: Easing.OutCubic
        }
    }
    Timer {
        id: _Timer_DisableBehavior
        interval: 400
        onTriggered: _Behavior_X.enabled = false
    }

    MouseArea {
        id: _MouseArea_Drag
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 30
        drag.target: root
        drag.axis: Drag.XAxis
        drag.minimumX: 0
        drag.maximumX: root.width
        onPressed: {
            _Behavior_X.enabled = true
            _Timer_EarlyRelease.restart()
        }
        onReleased: {
            if(_Timer_EarlyRelease.running || root.x > 0.60*root.width)
            {
                _Behavior_X.enabled = false
                _Timer_EarlyRelease.stop()
                root.close()
            }
            else
            {
                root.x = 0
                _Timer_DisableBehavior.restart()
            }
        }
        Timer {
            id: _Timer_EarlyRelease
            interval: 300
            // Use this to measure velocity of the flick
        }
    }
}
