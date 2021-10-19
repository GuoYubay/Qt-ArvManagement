import QtQuick 2.0
import QtQuick.Controls 2.2
Button {
    id: buttonImage

    property alias tipText: toolTip.text
    property alias tipItem: toolTip
    property alias tipVisible: toolTip.visible
    property alias tipDelay: toolTip.delay
    property alias tipTimeout: toolTip.timeout

    property string btnImgUr
    property color backgroundColor: "transparent"
    property color backgroundColor_pressed
    property color backgroundColor_hovered

    background: Rectangle {
        width: buttonImage.width
        height: buttonImage.height
        color: buttonImage.pressed ? backgroundColor_pressed : ( buttonImage.hovered ? backgroundColor_hovered : backgroundColor)
        Image {
            anchors.centerIn: parent
            width: buttonImage.width
            height: buttonImage.height
            source: btnImgUr
        }
    }
}
