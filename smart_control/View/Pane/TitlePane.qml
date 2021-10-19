import QtQuick 2.0
import TaoQuick 1.0
Rectangle {
    color: CusConfig.themeColor
    signal loadContent(string path,string name)
    signal loadHome
    Row{
        height: parent.height
        anchors{
            top: parent.top
            topMargin: 7
        }
        Repeater{
            model:MenuModel

         //   delegate{
                Rectangle{
                    id: _delegate
                    width: 120
                    height: 45
                    visible: ((model.group==="0"||model.group==="1")&&!model.isParent)?true:false //  isVisible值由当前条目提供
                    color: {
                            //  鼠标悬浮在子条目，对应颜色变浅
                            if(btn.hovered) return Qt.lighter(CusConfig.themeColor)
                            else return CusConfig.themeColor
                    }
                    CusTextButton{
                        id:btn
                        width: parent.width;height: parent.height
                        anchors {
                            left: parent.left
                            leftMargin: 10
                        }
                       labelText: qsTr(model.name)
                       labelLeftMargin: 40
                       labelcolor: "black"

                       Image {
                           id: _image
                           source: model.imagePath
                           sourceSize.width: 30;sourceSize.height: 30
                           anchors.left: parent.left   //  如果是子条目，则把图片放在左侧
                           anchors.verticalCenter: parent.verticalCenter
                       }
                    }
                }
          //  }
        }
    }
    Rectangle{
        width: 120
        height: 45
        color: {
            //  鼠标悬浮在子条目，对应颜色变浅
            if(login.hovered) return  Qt.lighter(CusConfig.themeColor)
            else return CusConfig.themeColor
            }
        anchors {
            right: parent.right
            top: parent.top
            topMargin: 7
        }
        CusTextButton {
            id: login
            width:120;height: 45
            //  设置按键显示文本
            labelText: "重新登陆"
            labelLeftMargin: 50
            labelcolor: "black"
            //  为该条目添加图片
            Image {
                id: _loginimage

                sourceSize.width: 30;sourceSize.height: 30
                anchors.left:  parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter

                //  根据该条目的属性设置相应的图片源
                source: "qrc:/Icon/LoginIn.png"
            }

            //  对鼠标点击事件作出响应
            onClicked: {
                    loadHome()
                    login_db.isLogin(true,false)
            }
        }
    }
}
