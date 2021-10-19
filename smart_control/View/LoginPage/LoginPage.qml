import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.14
import QtGraphicalEffects 1.14

import TaoQuick 1.0
import "../Custom"

Window {
    id:_root_login
    visible: true
    width: 400
    height: 260
    minimumWidth: 400
    maximumWidth: 400
    minimumHeight: 260
    maximumHeight: 260
    title: qsTr("智能存储系统控制管理软件")
    Item{
        anchors.fill: parent

        Rectangle{
            id:login_page
            anchors.fill: parent
            color: "aliceblue"
            CusPopupDialog{
                id:error_admin
                width: 250
                height: 100
                visible: false
                anchors.centerIn: parent
                tipsImageSource: "qrc:/Icon/alert-error.png"
                tipsLabel: qsTr("错误信息")
                description: qsTr("用户名错误")
                button1Visible: false
                button2: qsTr("确定")
            }
            CusPopupDialog{
                id:error_password
                width: 250
                height: 100
                visible: false
                anchors.centerIn: parent
                tipsImageSource: "qrc:/Icon/alert-error.png"
                tipsLabel: qsTr("错误信息")
                description: qsTr("密码错误")
                button1Visible: false
                button2: qsTr("确定")
            }

        }
        Text {
            id: login_title
            anchors{
                horizontalCenter: parent.horizontalCenter
                top:parent.top
                topMargin:15
            }
            color:"dodgerblue"
            text:"欢  迎  登  录"
            font{
                bold: true
                pixelSize: 30
                family: "微软雅黑"
            }
            renderType: Text.QtRendering
        }

        ComboxTextField{
            id:login_admin
            width: 250;
            height: 36
            anchors{
                horizontalCenter: login_title.horizontalCenter
                horizontalCenterOffset: 20        //居中后往右平移
                top: login_title.bottom
                topMargin: 20
            }
            placeholderText: "请输入账号"
        }
        ComboxTextField{
            id:login_password
            width: 250;
            height: 36
            anchors{
                horizontalCenter: login_admin.horizontalCenter
                top: login_admin.bottom
                topMargin: 15
            }
            placeholderText: "请输入密码"
            property bool passwordVisible: false
            passwordCharacter: "*"
            echoMode: passwordVisible?TextInput.Normal:TextInput.Password
            Image {
                source: login_password.passwordVisible
                        ?"qrc:/Icon/visible.png"
                        :"qrc:/Icon/invisible.png"
                anchors{
                    right: login_password.right
                    rightMargin: 4
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked:  login_password.passwordVisible=!login_password.passwordVisible;
                }

            }

        }

        Text {
             text: qsTr("用户名")
             anchors{
                verticalCenter: login_admin.verticalCenter
                right: login_admin.left
                rightMargin: 10
                }
             font.pointSize: 11
            }

        Text {
             text: qsTr("密  码")
             anchors{
                verticalCenter: login_password.verticalCenter
                right: login_password.left
                rightMargin: 10
                }
             font.pointSize: 11
            }
        Row {
            anchors{
                top: login_password.bottom
                horizontalCenter: login_title.horizontalCenter
                topMargin: 35

            }
            spacing: 50

            CusButton_Blue{
                id:button_login
                width: 250;
                height: 40
                Text {
                    text: qsTr("登录")
                    color: "white"
                    font.pointSize: 15
                    anchors{
                        horizontalCenter: button_login.horizontalCenter
                        verticalCenter: button_login.verticalCenter
                    }
                }
                onClicked:{
                    if(LoginModel.checkUserExists(login_admin.text)){
                        if(LoginModel.checkPasswrodExists(login_admin.text,login_password.text)){
                            console.log("登入")
                            LoginModel.isLogin(false,true)  //隐藏登陆页面，开启主页面
                        }
                        else{
                            error_password.visible=true
                            login_password.text=""
                        }
                    }
                    else{
                        error_admin.visible=true
                        login_password.text=""
                    }
                }
            }
        }
        DropShadow {
            anchors.fill: login_title
            horizontalOffset: 1
            verticalOffset: 1
            radius: 1
            samples: 10
            color: "blue"
            source: login_title
        }

    }
}
