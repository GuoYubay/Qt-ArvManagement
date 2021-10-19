import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
Popup {
    id: popup
    width: 250
    height: 100
    background: Rectangle{
      border.color: "#0095E1"
    }
    property alias popup: popup
    property alias tipsImageSource: tipsImage.source  //图片
    property alias tipsLabel: tipsLabel.text          //标题
    property alias description: description.text      //内容
    property alias button1: button1.text
    signal button1Clicked
    property alias button2: button2.text
    signal button2Clicked
    property alias button1Visible: button1.visible
    property alias button2Visible: button2.visible
    //右上角关闭按钮
    Rectangle{
        width:35
        height:16
        color:"#DE4242"
        anchors{
            right:parent.right
            rightMargin: -6
            top:parent.top
            topMargin: -11
        }
        Image {
            id: _closeImage
            anchors.centerIn: parent
            source: "qrc:/Icon/window-close.png"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                popup.close()
            }
        }
    }
    //标题
    Rectangle{
        id: tips
        anchors.left: parent.left
        anchors.leftMargin: 80
        anchors.top: parent.top
        anchors.topMargin: -9
        Label {
            id: tipsLabel
            text: qsTr("Title")
            font.pointSize:10
            font.bold: true
        }
    }
    //信息
    Rectangle {
        id:infoLab
        width: 237
        height:72
        anchors.left: parent.left
        anchors.leftMargin: -6
        anchors.top: parent.top
        anchors.topMargin: 8
        color: "#FBFBFB"
        border.width: 1
        border.color: Qt.darker("#FBFBFB",1.4)
        Image {
            id: tipsImage
            anchors.left: parent.left
            anchors.leftMargin:0
            anchors.top: parent.top
            anchors.topMargin: 0
            source: "qrc:/Icon/alert-error.png"
        }
        Label {
            id: description
            text: qsTr("Text")
            font.pointSize: 10
            font.bold: true

            anchors.left: tipsImage.right
            anchors.leftMargin:10
            anchors.top: parent.top
            anchors.topMargin:15

        }
        //按钮
        Rectangle {
            id: buttonGroup
            anchors.right: parent.right
            anchors.rightMargin:168
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 7
            height: 20
                Button {
                    id: button1
                    text: qsTr("OK")
                    font.pointSize:10

                    width: 65
                    height:parent.height
                    x:0
                    y:0
                    contentItem: Rectangle {
                        implicitWidth: 50
                        implicitHeight: 20
                        color: button1.down ? Qt.darker("#EBEBEB",1.4): (button1.pressed?Qt.darker("#EBEBEB",1.2):"#EBEBEB")
                        opacity: enabled ? 1 : 0.3
                        radius: 1
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter

                        Text {
                            text: button1.text
                            font: button1.font
                            opacity: enabled ? 1.0 : 0.3
                            color: "black"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            elide: Text.ElideRight
                        }
                    }
                    background: Rectangle {
                        implicitWidth: 50
                        implicitHeight: 20
                        color: button1.down ? Qt.darker("#EBEBEB",1.4): (button1.pressed?Qt.darker("#EBEBEB",1.2):"#EBEBEB")
                        opacity: enabled ? 1 : 0.3
                        border.color:"#0095E1"
                        border.width: 1
                        radius: 1
                    }

                    onClicked: {
                        popup.button1Clicked()
                        popup.close()
                    }
                }
                Button {
                    id: button2
                    text: qsTr("OK")
                    font.pointSize:10

                    width: 65
                    height:parent.height
                    x:95
                    y:0
                    contentItem: Rectangle {
                        implicitWidth: 50
                        implicitHeight: 20
                        color: button2.down ? Qt.darker("#EBEBEB",1.4): (button2.pressed?Qt.darker("#EBEBEB",1.2):"#EBEBEB")
                        opacity: enabled ? 1 : 0.3
                        radius: 1
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter

                        Text {
                            text: button2.text
                            font: button2.font
                            opacity: enabled ? 1.0 : 0.3
                            color: "black"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            elide: Text.ElideRight
                        }
                    }
                    background: Rectangle {
                        implicitWidth: 50
                        implicitHeight: 20
                        color: button2.down ? Qt.darker("#EBEBEB",1.4): (button2.pressed?Qt.darker("#EBEBEB",1.2):"#EBEBEB")
                        opacity: enabled ? 1 : 0.3
                        border.color:"#0095E1"
                        border.width: 1
                        radius: 1
                    }

                    onClicked: {
                        popup.button2Clicked()
                        popup.close()
                    }
                }
        }



  }
}


