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
                font.pixelSize: __theme.informationTitlePixelSize
                wrapMode: Text.WordWrap
                text: getData('title')
            }
            Label {
                id: _Label_Date
                width: parent.width
                font.pixelSize: __theme.informationDatePixelSize
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
            Utils.VerticalSpacer { height: 30 }
            Item {
                id: _Item_Address
                height: _Label_Address.height
                width: parent.width
                Utils.BaseIcon {
                    id: _BaseIcon_Maps
                    anchors.centerIn: undefined
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: 64
                    color: _Label_Address.color
                    source: "../img/icon-maps.png"
                }
                Label {
                    id: _Label_Address
                    anchors.left: _BaseIcon_Maps.right
                    anchors.leftMargin: 20
                    anchors.right: parent.right
                    wrapMode: Text.WordWrap
                    color: !_ClickGuard_Address.pressed ? "#444444" : "#777777"
                    font.pixelSize: __theme.informationAddressPixelSize
                    text: getData('location').name || ""
                    Utils.Fill { color: "red" }
                }
                Utils.ClickGuard {
                    id: _ClickGuard_Address
                    onClicked: {
                        _Rectangle_MapsButton.visible ^= 1
                    }
                }
            }
            Utils.VerticalSpacer { height: 20 }
            Rectangle {
                id: _Rectangle_MapsButton
                width: parent.width
                height: visible ? 60 : 0
                radius: 10
                color: !_ClickGuard_MapsButton.pressed ? __theme.qtColorLightGreen : __theme.qtColorMediumGreen
                visible: false
                Behavior on height {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }
                Label {
                    anchors.fill: parent
                    anchors.margins: 12
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: "#ffffff"
                    font.pixelSize: 30
                    font.weight: Font.DemiBold
                    elide: Text.ElideRight
                    text: qsTr("Open Maps Application")
                }
                Utils.ClickGuard {
                   id: _ClickGuard_MapsButton
                   onClicked: {
                       _config.openMaps()
                       _Rectangle_MapsButton.visible = false
                   }
                }
            }
            Utils.VerticalSpacer { height: _Rectangle_MapsButton.visible ? 30 : 20 }
            Label {
                id: _Label_VenueDescription
                width: parent.width
                font.pixelSize: __theme.informationVenueDescriptionPixelSize
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
                font.pixelSize: __theme.informationDatePixelSize
                wrapMode: Text.WordWrap
                text: qsTr("About the Event")
            }
            Utils.VerticalSpacer { height: 10 }
            Label {
                id: _Label_Description
                width: parent.width
                font.pixelSize: __theme.informationVenueDescriptionPixelSize
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
                font.pixelSize: __theme.informationDatePixelSize
                wrapMode: Text.WordWrap
                text: qsTr("About this App")
            }
            Utils.VerticalSpacer { height: 10 }
            Label {
                id: _Label_AppDescription
                width: parent.width
                font.pixelSize: __theme.informationVenueDescriptionPixelSize
                wrapMode: Text.WordWrap
                text: getData('app').description || ""
            }
        }
    }
}
