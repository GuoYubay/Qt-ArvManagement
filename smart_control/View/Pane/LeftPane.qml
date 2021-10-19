import QtQuick 2.14
import TaoQuick 1.0
Rectangle{
    id:leftpane
    signal loadContent(string path,string name)
    signal loadHome
    color: Qt.darker(CusConfig.themeColor,2.2)

    Rectangle{
        id:home
        width: parent.width
        height: CusConfig.fixedHeight
        color:listview.currentIndex==-1 ? Qt.darker(CusConfig.themeColor,2.6) :(btn_home.hovered?Qt.darker(CusConfig.themeColor,2.6):Qt.darker(CusConfig.themeColor,2.2))
        opacity: 0.8
        anchors {
            top: parent.top
        }
        CusTextButton {
            id:btn_home
            labelText: qsTr("首页")
            labelLeftMargin: 80
            labelcolor: "white"
            objectName: "homeBtn"
            width: parent.width
            onClicked: {
          //      listView.currentIndex = -1
         //       loadHome()
            }
        }
    }

    CusListView{
        id:listview
        model:MenuModel
        width:parent.width
        anchors {
            top: home.bottom
            topMargin:0
            bottom: parent.bottom
        }
        currentIndex: -1
        delegate: Rectangle{
            id:_delegate
            width: listview.width
            height:{
                if(visible){
                    if(isParent)    return 40
                    else    return 30
                }
                else    return 0
            }
            color:{

                if(isParent)
                {
                    //  鼠标悬浮在子条目，对应颜色变浅
                    if(btn.hovered) return CusConfig.controlBorderColor_hovered
                    else return Qt.darker(CusConfig.themeColor,2.8)
                }
                else
                {
                    //  鼠标悬浮在子条目，对应颜色变浅
                    if(btn.hovered) return CusConfig.controlBorderColor_hovered
                    else return Qt.darker(CusConfig.themeColor,2.2)
                }
            }

            visible: isVisible
            CusTextButton{
                id:btn
                anchors {
                    top: parent.top
                    left: parent.left
                    leftMargin:isParent ? 10 : 20
                    right: parent.right
                    bottom: parent.bottom

                }
                Text{
                    text:  qsTr(model.name)
                    color: "white"
                    anchors{
                        left:{
                            if(isParent)    return parent.left
                            else    return _image.right
                        }
                        leftMargin:{
                            if(isParent)    return 0
                            else return 8
                        }

                        verticalCenter: parent.verticalCenter
                    }
                    //leftMargin: isParent ? 0 : 40
                    font.pixelSize: isParent ? 20 : 16
                }

               // labelText: qsTr(model.name)
               // labelcolor: "white"
               // labelLeftMargin: isParent ? 0 : 40  //  设置文本距离左边界的距离


                Image {
                    id: _image

                    sourceSize.width: 30;sourceSize.height: 30

                    anchors.right: if(isParent) return parent.right  //  如果是父条目，则把图片放在右侧
                    anchors.rightMargin: isParent ? 20 : 0
                    anchors.left: if(!isParent) return parent.left   //  如果是子条目，则把图片放在左侧
                    anchors.verticalCenter: parent.verticalCenter

                    property bool isCollapsed: false  //  该属性用于显示或隐藏相关的子条目
                    source: {

                        if(isParent)
                        {
                            //  如果是父条目，根据折叠状态改变图片
                            if(isCollapsed)  return "qrc:/Icon/chevron-down.png"
                            else return "qrc:/Icon/chevron-up.png"
                        }
                        else return imagePath  //  如果是子条目，直接返回图片路径
                    }
                }

                onClicked:{
                    listview.currentIndex = index
                    if(isParent){
                        _image.isCollapsed = !_image.isCollapsed
                        MenuModel.refresh(group)    //刷新组可见性
                    }else{
                        //显示相应界面.
                       // ToolModel.refresh(model.name)
                        loadContent(model.qmlPath,model.name)
                    }
                }
                contentItem: Item {
                    width: btn.width
                    height: btn.height
                    BasicText {
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        text:btn.text
                        color: btn.textColor
                    }
                }
            }
            //????????
            Behavior on x {

                NumberAnimation { duration: 350}
            }
        }
    }
}
