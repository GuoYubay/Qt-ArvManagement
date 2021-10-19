import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.14
import QtGraphicalEffects 1.14

import TaoQuick 1.0
import "./View/Custom"
import "./View/Pane"

Window {
    id:_root_main
    width: 1500
    height: 900
    title: qsTr("射频密集档案调度管理软件")
    visible: true

    TitlePane{
        id:titlePane
        width: parent.width
        height: 60
        anchors {
            top: parent.top
            left:parent.left
        }
        onLoadContent: {
          /*  rightPane.addTabs("qrc:/View/Contents/" + path,name)
            rightPane.tabViewVisible=true
            rightPane.tabVisible=true*/
        }

        onLoadHome: {
        /*    rightPane.tabViewVisible=false
            rightPane.tabVisible=false
            rightPane.closeTabs()*/
        }
    }
    Item {
        id: _root_content
        width: parent.width

        anchors {
            top: titlePane.bottom
            bottom: parent.bottom
        }
        visible: true
        //Component.onCompleted: console.log(height)
        LeftPane{
            id:leftpane
            property real targetW: parent.width * 0.15//0.15
            width: targetW
            anchors {
                top:parent.top
                bottom: bottompane.top
            }
            property bool isOpen: true
            x: isOpen ? 0 : -targetW - 1
            Behavior on x {
                NumberAnimation { duration: 350}
            }
            visible: true
            onLoadContent: {
                rightpane.addTabs("qrc:/View/Contents/" + path,name)
               // console.log("qrc:/View/Contents/" + path)
                rightpane.tabViewVisible=true
                rightpane.tabVisible=true
            }
        }

        BottomPane{
            id:bottompane
            width: parent.width
            anchors.bottom: parent.bottom
        }
        RightPane {
             id: rightpane
             objectName: "contentRect"
             anchors {
                 left: leftpane.right
                 right: parent.right
                 top: parent.top
                 bottom: bottompane.top
             }
             CusButton_ImageColorOverlay {
                 id:_btnn
                 objectName: "menuBtn"
                 anchors{
                     top:rightpane.top
                     topMargin: 350
                     left: rightpane.left
                 }

                 //backgroundColor: parent.color
                 width: 10
                 height: 70
                 Image {
                     id: name
                     anchors.fill:_btnn
                     source:leftpane.isOpen?
                            _btnn.hovered? "qrc:/Icon/left-box-dark.png":"qrc:/Icon/left-box-light.png":
                            _btnn.hovered? "qrc:/Icon/right-box-dark.png":"qrc:/Icon/right-box-light.png"
                 }
                 onClicked: {
                     leftpane.isOpen = !leftpane.isOpen
                 }
             }

        }
    }



}
