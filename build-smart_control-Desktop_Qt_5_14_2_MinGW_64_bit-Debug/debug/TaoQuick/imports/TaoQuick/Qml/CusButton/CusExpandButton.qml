import QtQuick 2.0
import QtQuick.Controls 2.0
import ".."
import "../.."


CusButton {
    id: expandBtn
    property bool isOpened: true
    contentItem: BasicText {
        x: 0
        text: expandBtn.text
        color: "white"
        horizontalAlignment: Text.AlignLeft
    }
    background: Rectangle {
        width: expandBtn.width
        height: expandBtn.height
        color: expandBtn.pressed ? CusConfig.controlBorderColor_pressed : (expandBtn.hovered ? CusConfig.controlBorderColor_hovered : Qt.darker(CusConfig.themeColor,2.5))
        CusImage {
            source:"qrc:/Icon/expand.png"
            anchors {
                right: parent.right
                rightMargin: 14
            }
            rotation: expandBtn.isOpened ? 180 : 0
            Behavior on rotation {
                NumberAnimation {
                    duration: 200
                }
            }
        }
    }
}
