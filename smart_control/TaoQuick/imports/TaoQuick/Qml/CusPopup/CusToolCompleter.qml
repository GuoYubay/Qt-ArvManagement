import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Controls.Styles 1.3
//自定义提示框
T.Popup {
    id: control

    property color textColor: "black"
    property color currentItemColor: Qt.rgba(0.8,0.8,0.8)
    property color borderColor: "gray"
    property color backgroundColor: Qt.rgba(0.95,0.95,0.95,1)
    property int radius: 6
    property alias model: item_list.model

    signal selectText(string text)
    signal setModuleAuth()
    signal selectAll(bool checked)
    signal setStatusByRow(int index,bool checked)

    implicitWidth: (contentWidth + leftPadding + rightPadding)>=operateBar.width?(contentWidth + leftPadding + rightPadding):operateBar.width
    //model没数据则不显示
    implicitHeight:contentHeight + topPadding + bottomPadding+operateBar.height-40

    font{
        family: "SimSun"
        pixelSize: 14
    }
    padding: 10
    //closePolicy:Popup.CloseOnPressOutsideParent|Popup.CloseOnReleaseOutsideParent|Popup.CloseOnEscape

    contentItem:Column{
        spacing: 2
        Rectangle{
            id:selectAll
            implicitWidth: 120
            implicitHeight: 30
            color: control.backgroundColor
            anchors.left: parent.Left
            anchors.top: parent.Top
            CheckBox {
                id:selectAllCheck
                anchors{
                    left: parent.left
                    leftMargin:3
                    top:parent.top
                    topMargin:5
               }
                height:20
                width: 20
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        selectAllCheck.checked = !selectAllCheck.checked;
                        control.selectAll(selectAllCheck.checked)
                    }
                }
            }
        }
        ListView {
            id: item_list
            //clip: true
            spacing: 2
            implicitHeight: contentHeight
            implicitWidth: 120
            //snapMode: ListView.SnapToItem
            delegate:Item{
                implicitHeight: item_text.implicitHeight+12
                implicitWidth: ListView.view.width
                Rectangle{
                    id:_check
                    height: parent.height
                    width: parent.height
                    CheckBox {
                        anchors.centerIn: parent
                        height:20
                        width: 20
                        checked:model.isCheck;
                        onVisibleChanged:model.isCheck
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                 control.setStatusByRow(index, !model.isCheck)
                            }
                        }
                    }
                }

                Rectangle{
                 anchors.left: _check.right
                 anchors.leftMargin: 20
                implicitHeight: item_text.implicitHeight+12
                implicitWidth: ListView.view.width
                color:ListView.isCurrentItem
                      ?control.currentItemColor
                      :"transparent"
                radius: control.radius
                Text{
                    id: item_text
                    anchors{
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                        margins: 6
                    }
                    text: model.toolName
                    font: control.font
                    color: control.textColor
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        item_list.currentIndex=index;
                        control.selectText(item_text.text);
                        control.close();
                    }
                }
            }

            }
            onCurrentSectionChanged: {
                console.log(currentSection)
            }
        }
        Rectangle{
           id:operateBar
           width:item_list.width+200
           height: 40
           color:control.backgroundColor
           anchors.right: parent.right
           anchors.rightMargin: 20
           Row{
               spacing: 20
               anchors.right: parent.right
               anchors.top:parent.top
               anchors.topMargin: 10
           Button {
               id: button1
               text: qsTr("OK")
               font.pointSize:10

               width: 65
               height: 20
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

                  control.setModuleAuth()
                  control.close()
               }
           }
           Button {
               id: button2
               text: qsTr("Cancel")
               font.pointSize:10
               width: 65
               height: 20

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
                   control.close()
               }
           }
           }
        }
    }
    background: Rectangle {
        color: control.backgroundColor
        border.width: 1
        border.color: control.borderColor
        radius: control.radius
    }

    T.Overlay.modal: Rectangle {
        color: Color.transparent(control.palette.shadow, 0.5)
    }

    T.Overlay.modeless: Rectangle {
        color: Color.transparent(control.palette.shadow, 0.12)
    }

}
