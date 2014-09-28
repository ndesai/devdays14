import QtQuick 2.0
import "../utils" as Utils

Component {
    Column {
        width: parent ? parent.width : 0
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
        Utils.VerticalSpacer { height: 30 }
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
        Utils.VerticalSpacer { height: 80 }
        Button {
            anchors.left: _Image_NoFavorites.left
            anchors.right: _Image_NoFavorites.right
            text: qsTr("View Schedule")
            buttonColor: __theme.qtColorMediumGreen
            skeleton: true
            onClicked: {
                _TabBarController.showView(_Schedule)
            }
        }
    }
}
