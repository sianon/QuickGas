import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window{
    id: dialog
    width: 320
    height: 240
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        Rectangle{
            anchors.fill: parent
            color: "#2e2f30"
            radius: 5
            border.color: "pink"

            Rectangle {
                id: top_status
                anchors.left: parent.left
                anchors.top: parent.top

                height: 28
                width: parent.width
                color: "#42424e"
                //top status
                RowLayout {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right

                    Label{
                        font.pixelSize: 16
                        rightPadding: 6
                        color: "#ffffffff"
                        text: "1920x1080   60fps"
                    }
                }
            }
            Rectangle {
                id: video_frame
                anchors.left: parent.left
                anchors.bottom: bottom_btn.top

                height: parent.height - top_status.height - bottom_btn.height
                width: parent.width

                color: "#2c2a38"
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    font.pixelSize: 16
                    color: "#ffffffff"
                    text: "无信号"
                }
            }
            Rectangle{
                id: bottom_btn
                anchors.left: video_frame.left
                anchors.bottom: parent.bottom

                height: 28
                width: parent.width
                color: "#42424e"

                radius: 5
                RowLayout {
                    height: parent.height
                    width: parent.width
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5
                    anchors.fill: bottom_btn
                    anchors.verticalCenter: parent.verticalCenter

                    Rectangle {
                        width: 15
                        height: 15
                        anchors.verticalCenter: parent.verticalCenter
                        color: "red"
                        radius: width / 2
                    }

                    Item {
                        Layout.fillWidth: true
                    }
                    Button {
                        // id: control
                        Layout.preferredWidth: 18
                        Layout.preferredHeight: 18
                        background: Rectangle {
                            radius: 8 // 设置圆角大小
                            color: control.pressed ? "red" : "lightblue"
                            border.color: "blue"
                            border.width: 1
                            anchors.fill: parent
                        }
                        text: qsTr("警")
                    }
                    Button {
                        Layout.preferredWidth: 18
                        Layout.preferredHeight: 18
                        background: Rectangle {
                            radius: 8 // 设置圆角大小
                            color: control.pressed ? "lightgray" : "lightblue"
                            border.color: "blue"
                            border.width: 1
                            anchors.fill: parent
                        }
                        text: "录"
                    }
                    Button {
                        Layout.preferredWidth: 18
                        Layout.preferredHeight: 18
                        background: Rectangle {
                            radius: 8 // 设置圆角大小
                            color: control.pressed ? "lightgray" : "lightblue"
                            border.color: "blue"
                            border.width: 1
                            anchors.fill: parent
                        }
                        text: "设"
                    }
                }
            }
        }

    }
}