import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12

//自定义输入框
T.TextField{
    id: control
    color: "black"
    font{
        family: "SimSun"
        pixelSize: 15
    }
    signal selectText(string text)
    property alias  comboxPoupModel: comboxPoup.model
    property  bool poupEnable:false
    property string lastText: ""
    property string currentText: ""
    property color poupbackgroundColor: Qt.rgba(0.95,0.95,0.95,1)
    padding: 6
    leftPadding: padding+4
    //placeholderText: "Input Password"
    placeholderTextColor: "gray"
    verticalAlignment: TextInput.AlignVCenter

    selectByMouse: true
    selectedTextColor: "white"
    selectionColor: "black"

    //作为密码框
    //显示模式：Normal普通文本，Password密码，NoEcho无显示，
    //PasswordEchoOnEdit显示在编辑时输入的字符，否则与相同TextInput.Password
    //echoMode: TextInput.Password
    //passwordCharacter: "*"
//    passwordMaskDelay: 10
//    validator: RegExpValidator{
//        regExp:/[a-zA-Z0-9]+/
//    }
    //clip: true
    //inputMethodHints: Qt.ImhUrlCharactersOnly
    //renderType: Text.NativeRendering
    renderType: Text.QtRendering

    PlaceholderText {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)

        text: control.placeholderText
        font: control.font
        color: control.placeholderTextColor
        verticalAlignment: control.verticalAlignment
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        elide: Text.ElideRight
        renderType: control.renderType
    }
    background: Rectangle {
        radius: 6
        border.width: 1 //control.activeFocus ? 2 : 1
        color: "white"
        border.color: control.activeFocus
                      ? Qt.rgba(22/255,155/255,213/255,1)
                      : Qt.rgba(208/255,201/255,201/255,1)
    }
    Image{
        visible: poupEnable
        source: comboxPoup.visible
                ?"qrc:/Icon/up.png"
                :"qrc:/Icon/down.png"
        anchors{
            right: parent.right
            rightMargin: 4
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: 3 //下的图标是顶部对齐的
        }
        MouseArea{
            anchors.fill: parent
            onClicked: comboxPoup.open();
        }
    }
    ComboxPoup{
        id: comboxPoup
        width: parent.width
        backgroundColor: poupbackgroundColor
        y: parent.height+2
        onSelectText: {
            control.selectText(text)
        }
    }

}
