import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import ".."
import "../.."

ComboBox {
    id: cusComboBox
    height: CusConfig.fixedHeightdelegateModel
    leftPadding: 4
    rightPadding: 4
    currentIndex: 0
    property color currentItemColor: Qt.rgba(0.8,0.8,0.8)

    property int inputStatus:-1
    property string  displayTextinit: ""
    property real defaultHeight: CusConfig.fixedHeight * 6
    displayText:qsTr(currentText) + CusConfig.transString
    background: Rectangle {
        color: cusComboBox.enabled ? CusConfig.controlColor : CusConfig.controlColor_disabled
        radius: CusConfig.controlBorderRadius
        border.width: 1
        border.color: cusComboBox.focus
                      ? Qt.rgba(22/255,155/255,213/255,1)
                      : Qt.rgba(208/255,201/255,201/255,1)
    }
    contentItem: CusLabel {
        leftPadding: cusComboBox.leftPadding
        rightPadding: cusComboBox.indicator.width + cusComboBox.spacing
        text: cusComboBox.displayText
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        color: cusComboBox.enabled ? CusConfig.textColor : CusConfig.textColor_disabled
        TransArea {
            enabled: cusComboBox.enabled
        }
    }
    property color colorNormal: CusConfig.imageColor
    property color colorHovered: CusConfig.imageColor_hovered
    property color colorPressed: CusConfig.imageColor_pressed
    property color colorDisable: CusConfig.imageColor_disabled
    CusImage {
        id: baseImage
        source:cusComboBox.popup.visible ?"qrc:/Icon/up.png":"qrc:/Icon/down.png"
        smooth: true
        visible: false
    }
    indicator: Item {
        height: cusComboBox.height - cusComboBox.topPadding - cusComboBox.bottomPadding
        width: height
        x: cusComboBox.width - width - cusComboBox.rightPadding
        y: (cusComboBox.height - height) / 2
        ColorOverlay {
            anchors {
                centerIn: parent
            }
            source: baseImage
            width: baseImage.width
            height: baseImage.height
            cached: true
            color: {
                if (!cusComboBox.enabled) {
                    return colorDisable
                } else if (cusComboBox.pressed) {
                    return colorPressed
                } else if (cusComboBox.hovered) {
                    return colorHovered
                } else {
                    return colorNormal
                }
            }

        }
    }

    popup: Popup {
        y: cusComboBox.height 
        width: cusComboBox.width
        implicitHeight: Math.min(contentItem.implicitHeight, defaultHeight)
        height: visible ? implicitHeight : 0

        padding: 0

        contentItem: ListView {
            id: list
            clip: true
            implicitHeight: contentHeight
            model: cusComboBox.popup.visible ? cusComboBox.delegateModel : null
            currentIndex: cusComboBox.highlightedIndex
            ScrollBar.vertical: CusScrollBar {
                opacity: cusComboBox.popup.contentHeight >= cusComboBox.popup.height ? 1.0 : 0.0
                visible: opacity > 0
                active: visible
            }
        }

        background: Rectangle {
            color: CusConfig.controlColor
            radius: CusConfig.controlBorderRadius
            border.width: 1
            border.color: CusConfig.controlBorderColor
        }
    }
    property int hoveredIndex: -1
    delegate: ItemDelegate {
        width: cusComboBox.width
        height: cusComboBox.height
        contentItem: CusLabel {
            leftPadding: cusComboBox.leftPadding
            rightPadding: cusComboBox.indicator.width + cusComboBox.spacing
            text: qsTr(String(modelData)) + CusConfig.transString
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
            color: cusComboBox.hoveredIndex
                   === index ? CusConfig.textColor_pressed : CusConfig.textColor
        }
        highlighted: cusComboBox.hoveredIndex === index
        background: Item {
            width: cusComboBox.width
            height: cusComboBox.height
            Rectangle {
                anchors {
                    fill: parent
                    leftMargin: 2
                    rightMargin: 16
                }
                radius: CusConfig.controlBorderRadius
                color: cusComboBox.hoveredIndex === index ?
                           Qt.lighter(CusConfig.controlColor_pressed,2.5) :
                           (cusComboBox.currentIndex === index ? Qt.lighter(CusConfig.controlColor_pressed,2): "transparent")
            }

        }
        TransArea {
            enabled: cusComboBox.enabled
            onContainsMouseChanged: {
                if (containsMouse) {
                    cusComboBox.hoveredIndex = index
                } else {
                    cusComboBox.hoveredIndex = -1
                }
            }
        }
    }
}
