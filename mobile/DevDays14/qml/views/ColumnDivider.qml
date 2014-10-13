import QtQuick 2.0
import "../utils" as Utils
Column {
    property alias topSpacer : _VSTop.height
    property alias bottomSpacer : _VSBot.height
    width: parent.width
    height: childrenRect.height
    Utils.VerticalSpacer { id: _VSTop; height: 40 }
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
    Utils.VerticalSpacer { id: _VSBot; height: 40 }
}
