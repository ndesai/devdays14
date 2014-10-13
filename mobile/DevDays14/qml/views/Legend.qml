import QtQuick 2.3
import "../utils" as Utils

Utils.BaseTabBarPage {
    id: root

    function getData(key)
    {
        if(typeof _Model.information !== "undefined"
                && typeof _Model.information[key] !== "undefined")
        {
            return _Model.information[key]
        }
        return ""
    }

    Flickable {
        id: _Flickable
        anchors.fill: parent
        contentHeight: _Column.height + 40
        contentWidth: width
        Column {
            id: _Column
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.right: parent.right
            anchors.rightMargin: anchors.leftMargin
            height: childrenRect.height
            Utils.VerticalSpacer { height: 40 }
            Label {
                id: _Label_Title
                width: parent.width
                font.pixelSize: __theme.informationTitlePixelSize
                wrapMode: Text.WordWrap
                text: qsTr("Tracks")
            }
        }
    }
}
