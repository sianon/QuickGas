import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


Dialog{
    id: dialog
    modal: true
    width: 320
    height: 250
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    background:Rectangle {
        color: "#42424e"
    }

    ColumnLayout {
        anchors.centerIn: parent
        Switch {
            id: control
            text: qsTr("Switch")

            indicator: Rectangle {
                implicitWidth: 32
                implicitHeight: 16
                x: control.leftPadding
                y: parent.height / 2 - height / 2
                radius: 13
                color: control.checked ? "#17a81a" : "#ffffff"
                border.color: control.checked ? "#17a81a" : "#cccccc"

                Rectangle {
                    x: control.checked ? parent.width - width : 0
                    width: 16
                    height: 16
                    radius: 13
                    color: control.down ? "#cccccc" : "#ffffff"
                    border.color: control.checked ? (control.down ? "#17a81a" : "#21be2b") : "#999999"
                }
            }

            contentItem: Text {
                text: control.text
                font: control.font
                opacity: enabled ? 1.0 : 0.3
                // color: control.down ? "#17a81a" : "#21be2b"
                color: control.checked ? "#17a81a" : "#ffffff"
                verticalAlignment: Text.AlignVCenter
                leftPadding: control.indicator.width + control.spacing
            }
        }
    }
}
