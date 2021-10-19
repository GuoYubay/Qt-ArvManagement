import QtQuick 2.2
import QtQuick.Controls 1.2

Rectangle
{
    property int startPage: 1
    property int maxPage: 18
    property int pageSize: 5
    property int curPageNumber
    property int selectedPage: 1
    property int totalRecord: 90
    signal pageClicked(int page )
    onCurPageNumberChanged:
    {
        selectedPage=curPageNumber
    }
    height: row.height
    width: row.width
    Row
    {
        id: row
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 2

        Label
        {
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr( "共" )+totalRecord.toString( ) +
                  qsTr( " 条记录, 每页" ) +
                  pageSize.toString( ) +
                  qsTr( "条" )
        }

        Rectangle
        {
            id: firstPage
            height: innerText_first.height * 2.0
            width: innerText_first.width + height
            border.color: "lightsteelblue"
            border.width: 1

            Text
            {
                id: innerText_first
                anchors.centerIn: parent
                text: qsTr( "首页" )
            }

            MouseArea
            {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onEntered:
                {
                    firstPage.color = "#3B5998";
                    innerText_first.color = "white"
                }
                onExited:
                {
                    firstPage.color = "#FAFBFC";
                    innerText_first.color = "black"
                }
                onClicked:{
                    selectedPage =1;
                    pageClicked( selectedPage );
                }
            }
        }
        Rectangle
        {
            id: delegateRect_1
            height: innerText_1.height * 2.0
            width: innerText_1.width + height
            border.color: "lightsteelblue"
            border.width: 1

            Text
            {
                id: innerText_1
                anchors.centerIn: parent
                text: qsTr( "<<" )
            }

            MouseArea
            {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onEntered:
                {
                    delegateRect_1.color = "#3B5998";
                    innerText_1.color = "white"
                }
                onExited:
                {
                    delegateRect_1.color = "#FAFBFC";
                    innerText_1.color = "black"
                }
                onClicked:{
                    if(selectedPage>1){
                        selectedPage = selectedPage-1;
                        pageClicked( selectedPage );
                    }
                }
            }
        }

        Repeater
        {
            id: repeater
            model:maxPage
            Button
            {
                id:btn
                height: innerText.height * 2.0
                width: innerText.width + height
                visible:((0<(selectedPage-index)&&(selectedPage-index)<4))||((0<=(index-selectedPage)&&(index-selectedPage)<2))?true:false
                Rectangle{
                  id: delegateRect
                  anchors.fill: parent
                  color: ( ((selectedPage === startPage + index))||btn.hovered?
                                  "#3B5998": "#FAFBFC" )
                  border.color: "lightsteelblue"
                  border.width: 1

                  Text
                  {
                      id: innerText
                      anchors.centerIn: parent
                      text: ( startPage + index ).toString( )
                      color: ( ((selectedPage === startPage + index))||btn.hovered?
                                  "white": "black" )
                  }
                 }

               onClicked:
               {
                   selectedPage = startPage + index;
                   pageClicked( selectedPage );
               }
            }
        }

        Rectangle
        {
            id: delegateRect_4
            height: innerText_4.height * 2.0
            width: innerText_4.width + height
            border.color: "lightsteelblue"
            border.width: 1

            Text
            {
                id: innerText_4
                anchors.centerIn: parent
                text: qsTr( ">>" )
            }

            MouseArea
            {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onEntered:
                {
                    delegateRect_4.color = "#3B5998";
                    innerText_4.color = "white"
                }
                onExited:
                {
                    delegateRect_4.color = "#FAFBFC";
                    innerText_4.color = "black"
                }
                onClicked: {
                    if(selectedPage<maxPage){
                        selectedPage = selectedPage+1;
                        pageClicked( selectedPage );
                    }
                }
            }
        }
        Rectangle
        {
            id: lastPage
            height: innerText_last.height * 2.0
            width: innerText_last.width + height
            border.color: "lightsteelblue"
            border.width: 1

            Text
            {
                id: innerText_last
                anchors.centerIn: parent
                text: qsTr( "末页" )
            }

            MouseArea
            {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onEntered:
                {
                    lastPage.color = "#3B5998";
                    innerText_last.color = "white"
                }
                onExited:
                {
                    lastPage.color = "#FAFBFC";
                    innerText_last.color = "black"
                }
                onClicked:{
                    selectedPage =maxPage;
                    pageClicked(selectedPage);
                }
            }
        }
    }
}
