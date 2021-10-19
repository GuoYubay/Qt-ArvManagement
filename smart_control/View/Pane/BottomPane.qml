import QtQuick 2.0
import TaoQuick 1.0
Rectangle {
    color: CusConfig.themeColor
    height: 30
    signal loadContent(string path)
    signal loadHome

    Text {
        id:text1
        anchors{
            left: parent.left
            verticalCenter: parent.verticalCenter
       }
      text: qsTr("当前用户：")
      font{
          pixelSize: 17
     }
    }
    Text {
        id:text2
        anchors{
           left: text1.right
           verticalCenter: parent.verticalCenter
       }
       text: qsTr(UserModel.CurRole)
       font{
          pixelSize: 17
      }
    }

    Timer {
        interval: 500; running: true; repeat: true
        onTriggered: time.text = Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss")
    }

    Text {
        id: time
        anchors{
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        font{
           pixelSize: 17
       }

    }
    Text{
        anchors{
            right: time.left
            verticalCenter: parent.verticalCenter
        }
        text: qsTr("当前时间：")
        font{
            pixelSize: 17
       }
    }
    Text{
        anchors{
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        text: qsTr("XX档案设备有限公司")
        font{
            pixelSize: 17
       }
    }
}
