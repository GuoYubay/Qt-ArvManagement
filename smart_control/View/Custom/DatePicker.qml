import QtQuick 2.0
import QtQuick.Controls 1.2
Rectangle {
    id:control
    radius: 6
    border.width: 1 //control.activeFocus ? 2 : 1
    color: "white"
    border.color: control.activeFocus
                  ? Qt.rgba(22/255,155/255,213/255,1)
                  : Qt.rgba(208/255,201/255,201/255,1)
    property string dateValue
TextField
{
    id:textDate
    anchors.fill: parent

    Calendar{
        id: calendar
        anchors.topMargin: 0
        anchors.top: parent.bottom
        visible: false
        activeFocusOnTab: true
        onReleased: {
            textDate.text = date;
            textDate.text =textDate.text.substr(0, 10);
            dateValue = textDate.text;
            visible = false;
        }
    }

    Button{
        id: downBtn
        width: 22
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        iconSource: "qrc:/Icon/down.png"
        onClicked: calendar.visible = !calendar.visible
    }





}
onDateValueChanged: {
    textDate.text = dateValue;
    calendar.selectedDate = dateValue;
}
}
