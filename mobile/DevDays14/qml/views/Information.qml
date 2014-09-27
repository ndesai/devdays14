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
                    color: !_ClickGuard_Address.pressed ? "#444444" : "#555555"
                    font.pixelSize: __theme.informationAddressPixelSize
                    text: getData('location').name || ""
                    Utils.Fill { color: "red" }
                }
                Utils.ClickGuard {
                    id: _ClickGuard_Address
                    onClicked: {
                        _ColumnButton_Maps.visible ^= 1
                    }
                }
            }
            Utils.VerticalSpacer { height: 20 }
            ColumnButton {
                id: _ColumnButton_Maps
                text: qsTr("Open Maps Application")
                onClicked: _config.openMaps()
            }
            Utils.VerticalSpacer { height: _ColumnButton_Maps.visible ? 30 : 20 }
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
                color: !_ClickGuard_AboutThisApp.pressed ? "#444444" : "#555555"
                text: getData('app').v2
                      && getData('app').v2.description
                      && getData('app').v2.description.ios || ""
                Utils.ClickGuard {
                    id: _ClickGuard_AboutThisApp
                    onClicked: {
                        _ColumnButton_AboutThisApp.visible ^= 1
                    }
                }
            }
            Utils.VerticalSpacer { height: 20 }
            ColumnButton {
                id: _ColumnButton_AboutThisApp
                text: qsTr("Open http://app.st/qt14")
                buttonColor: "#63d6db"
                onClicked: Qt.openUrlExternally("http://app.st/qt14")
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
                id: _Label_PolicyText
                width: parent.width
                font.pixelSize: __theme.informationDatePixelSize
                wrapMode: Text.WordWrap
                text: qsTr("Policy & Attribution")
                visible: _Label_Policy.text !== ""
            }
            Utils.VerticalSpacer { height: 10 }
            Label {
                id: _Label_Policy
                width: parent.width
                font.pixelSize: __theme.informationVenueDescriptionPixelSize
                wrapMode: Text.WordWrap
                color: !_ClickGuard_Policy.pressed ? "#444444" : "#555555"
                text: getData('app').v2
                      && getData('app').v2.policy
                      && getData('app').v2.policy.ios || ""
                Utils.ClickGuard {
                    id: _ClickGuard_Policy
                    onClicked: {
                        _ColumnButton_Mail.visible ^= 1
                    }
                }
            }
            Utils.VerticalSpacer { height: 20 }
            ColumnButton {
                id: _ColumnButton_Mail
                text: qsTr("Email Us")
                buttonColor: "#ffbc40"
                onClicked: Qt.openUrlExternally("mailto:support@app.st?subject=DevDays '14 (" + Qt.platform.os + ")")
            }
            Utils.VerticalSpacer { height: 20 }
        }
    }
}
