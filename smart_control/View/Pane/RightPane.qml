import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.14
import QtQml 2.14

Item {
    property bool tabViewVisible:true
    property bool tabVisible:true

    anchors{
        left: parent.left
        right: parent.right
        top: parent.top
        bottom: parent.bottom
    }


    TabView{
        id: _tabView
        anchors{
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }
        Tab {
            title: "Red"
            Rectangle {
                MouseArea{
                    anchors.fill: parent
                    onClicked: console.log(_tabView.currentIndex)
                }
            }
        }
        Tab {
            title: "Blue"
            Rectangle {
                MouseArea{
                    anchors.fill: parent
                    onClicked: console.log(_tabView.currentIndex)
                }
            }
        }
        Tab {
            title: "Green"
            Rectangle {
                MouseArea{
                    anchors.fill: parent
                    onClicked: {

                        console.log(_tabView.currentIndex)
                    }
                }
            }
        }

        tabPosition: Qt.BottomEdge     //设置标签位于底部
        frameVisible:tabViewVisible    //设置tab面板是否可见
        tabsVisible:tabVisible       //设置tab标签是否可见

        style: TabViewStyle {
            frameOverlap: 1
            tab: Rectangle {
                id:_tab
                color: styleData.selected ?  "#D3D3D3" : (styleData.hovered ? "aliceblue" : Qt.lighter("#D3D3D3"))
                border.width: 2
                border.color: "#D3D3D3"
                implicitWidth: Math.max(text.width + 30, 80)
                implicitHeight: 25
                radius: 7
                Text {
                    id: text
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    text: styleData.title
                    color: styleData.selected ? "black" :"#3f3d3d"
                }
                MouseArea{
                    anchors.left: parent.left
                    anchors.right: _close_rct.left
                    implicitHeight: 20
                    onClicked:{
                      // ToolModel.refresh(styleData.title)
                       getTabs(styleData.title)
                    }
                }
                Rectangle{
                    id:_close_rct
                    width:16
                    height:16
                    color:parent.color
                    anchors{
                        right: _tab.right
                        rightMargin: 2
                        top: _tab.top
                        topMargin: 3
                    //    bottom: _tab.bottom
                    }
                    Image {
                        id: _closeImage
                        anchors.centerIn: parent
                        //  根据该条目的属性设置相应的图片源
                        source: "qrc:/Icon/close.png"

                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                             getTabs(styleData.title)
                            _tabView.removeTab(_tabView.currentIndex)
                        }
                    }
                }

            }

        }
    }
    function getTabs(name)
    {
      var i = 0
       if (name.length >= 0) {
           //tab若已存在则不再创建，选中要显示tab
            for ( i = 0; i < _tabView.count; ++i)
            {
               var obj = _tabView.getTab(i);
               if(name===obj.title){
                _tabView.currentIndex=i
                return
            }
          }
       }
     }
    //添加左侧导航栏相应的标签窗口
    function addTabs(source,name)
    {
      var i = 0
       if (name.length >= 0)
       {
           //tab若已存在则不再创建，选中要显示tab
            for ( i = 0; i < _tabView.count; ++i)
            {
               var obj = _tabView.getTab(i);
               if(name===obj.title)
               {
                _tabView.currentIndex=i
                return
               }
            }
            //若不存在则创建一个新的标签
            if(source!==null)
            {
               var compoment = Qt.createComponent(source);
               _tabView.insertTab(_tabView.count,name,compoment);
              // console.log("obj....."+_tabView.count)
               _tabView.currentIndex = _tabView.count-1;
               //var obj = _tabView.getTab(_tabView.currentIndex);
            }
           else{
               console.log("TabView Source is null")
            }
       }
    }
}
