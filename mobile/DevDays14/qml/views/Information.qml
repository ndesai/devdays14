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
        contentHeight: _Column.height + 60
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
                font.pixelSize: 36
                wrapMode: Text.WordWrap
                text: getData('title')
            }
            Label {
                id: _Label_Date
                width: parent.width
                font.pixelSize: 34
                wrapMode: Text.WordWrap
                text: getData('date')
                color: "#444444"
            }
            Utils.VerticalSpacer { height: 20 }
            Item {
                width: parent.width
                height: 240
                clip: true
                // parallax effect while scrolling
                Image {
                    id: _Image_Venue
                    width: parent.width
                    height: 240
                    clip: true
                    fillMode: Image.PreserveAspectCrop
                    source: (getData('location').image||"")!==""?
                                "../img/static/"+getData('location').image
                              : ""
                    y: Math.min((sourceSize.height - 240) / 2, 0.07*_Flickable.contentY)
                }
                visible: _Image_Venue.source !== ""
            }
            Utils.VerticalSpacer { height: 20 }
            Label {
                id: _Label_Address
                width: parent.width
                wrapMode: Text.WordWrap
                text: getData('location').name || ""
                color: "#444444"
            }
            Utils.VerticalSpacer { height: 20 }
            Label {
                id: _Label_VenueDescription
                width: parent.width
                font.pixelSize: 28
                wrapMode: Text.WordWrap
                text: getData('location').detail || ""
            }
            Utils.VerticalSpacer { height: 30 }
            Rectangle {
                width: parent.width
                height: 1
                color: __theme.lightGreyAccentSecondary
            }
            Rectangle {
                width: parent.width
                height: 1
                color: __theme.lightGreyAccent
            }
            Utils.VerticalSpacer { height: 40 }
            Label {
                id: _Label_DescriptionText
                width: parent.width
                font.pixelSize: 34
                wrapMode: Text.WordWrap
                text: qsTr("About the Event")
            }
            Utils.VerticalSpacer { height: 10 }
            Label {
                id: _Label_Description
                width: parent.width
                font.pixelSize: 28
                wrapMode: Text.WordWrap
                text: getData('description')
            }
            Utils.VerticalSpacer { height: 40 }
            Rectangle {
                width: parent.width
                height: 1
                color: __theme.lightGreyAccentSecondary
            }
            Rectangle {
                width: parent.width
                height: 1
                color: __theme.lightGreyAccent
            }
            Utils.VerticalSpacer { height: 40 }
            Label {
                id: _Label_AppDescriptionText
                width: parent.width
                font.pixelSize: 34
                wrapMode: Text.WordWrap
                text: qsTr("About this App")
            }
            Utils.VerticalSpacer { height: 10 }
            Label {
                id: _Label_AppDescription
                width: parent.width
                font.pixelSize: 28
                wrapMode: Text.WordWrap
                text: getData('app').description || ""
            }
        }
    }
}
