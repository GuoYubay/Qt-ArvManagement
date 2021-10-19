import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

Button {
    id: cusButton
    height: CusConfig.fixedHeight

    property alias tipText: toolTip.text
    property alias tipItem: toolTip
    property alias tipVisible: toolTip.visible
    property alias tipDelay: toolTip.delay
    property int btnLeftMargin: 0

    property color backgroundColorNormal: CusConfig.controlColor
    property color backgroundColorHovered: CusConfig.controlColor_hovered
    property color backgroundColorPressed: CusConfig.controlColor_pressed
    property color backgroundColorDisable: CusConfig.controlColor_disabled
    property bool selected: false
    property color borderColor: {
        if (!cusButton.enabled) {
            return CusConfig.controlBorderColor_disabled
        } else if (cusButton.pressed || selected) {
            return CusConfig.controlBorderColor_pressed
        } else if (cusButton.hovered) {
            return CusConfig.controlBorderColor_hovered
        } else {
            return CusConfig.controlBorderColor
        }
    }

    property int borderWidth: 1
    property int radius: CusConfig.controlBorderRadius
    property color textColor: {
        if (!cusButton.enabled) {
            return CusConfig.textColor_disabled
        } else if (cusButton.pressed || selected) {
            return CusConfig.textColor_pressed
        } else if (cusButton.hovered) {
            return CusConfig.textColor_hovered
        } else {
            return CusConfig.textColor
        }
    }
    property color backgroundColor: {
        if (!cusButton.enabled) {
            return backgroundColorDisable
        } else if (cusButton.pressed || selected) {
            return backgroundColorPressed
        } else if (cusButton.hovered) {
            return backgroundColorHovered
        } else {
            return backgroundColorNormal
        }
    }

    BasicTooltip {
        id: toolTip
        visible: cusButton.hovered && String(text).length
        delay: 500
    }
    contentItem: BasicText {
        text: cusButton.text
        color: cusButton.textColor
    }
    property int labelLeftMargin: 0   //  控制文字距离左边界的位置
    property alias labelText:_label.text
    property color labelcolor:_label.color

    background:
        Label{
        id: _label
        anchors.left: parent.left
        anchors.leftMargin: labelLeftMargin
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.family: "微软雅黑"
        font.pixelSize: 15
        color:labelcolor
    }

    TransArea {
    }
}
