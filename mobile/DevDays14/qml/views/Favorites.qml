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
                text: qsTr("Favorites")
            }
            ColumnDivider { topSpacer: 20 }
            Label {
                id: _Label_NoFavorites_Description
                anchors.left: _Image_NoFavorites.left
                anchors.right: _Image_NoFavorites.right
                font.pixelSize: __theme.informationAddressPixelSize
                wrapMode: Text.WordWrap
                text: qsTr("Add your favorite sessions by navigating to a session's information page and tapping the ribbon.")
            }
            Utils.VerticalSpacer { height: 20 }
            Image {
                id: _Image_NoFavorites
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.75*sourceSize.width
                height: 0.75*sourceSize.height
                source: "../img/tutorial/favorites-01a.png"
                Image {
                    id: _Image_NoFavorites_Alternate
                    anchors.fill: parent
                    source: "../img/tutorial/favorites-01b.png"
                    visible: false
                }
                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    border { width: 2; color: __theme.lightGreyAccent }
                }
                Timer {
                    id: _Timer_NoFavorites
                    interval: 2400; repeat: true
                    onTriggered: _Image_NoFavorites_Alternate.visible ^= 1
                }
                Connections {
                    target: root
                    onOpened: _Timer_NoFavorites.restart()
                    onClosed: _Timer_NoFavorites.stop()
                }
            }
            Utils.VerticalSpacer { height: 40 }
            Button {
                anchors.left: _Image_NoFavorites.left
                anchors.right: _Image_NoFavorites.right
                text: qsTr("View Schedule")
                onClicked: {
                    _TabBarController.showView(_Schedule)
                }
            }
        }
    }
}
