import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 5.15
import Local 1.0

Item{
    id: dialog
    width: parent.width
    height: parent.height

    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 1
        Rectangle{
            anchors.fill: parent
            color: "#ffffffff"
            radius: 5
            // border.color: "pink"
            border.width: 1
            Rectangle{
                id: top_status
                anchors.left: parent.left
                anchors.top: parent.top

                height: 28
                width: parent.width
                color: "#42424e"
                //top status
                RowLayout{
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
            //video frame
            Rectangle{
                id: video_frame
                anchors.left: parent.left
                anchors.bottom: bottom_btn.top

                height: parent.height - top_status.height - bottom_btn.height
                width: parent.width
                FrameProvider{
                    id: provider
                }
                VideoOutput{
                    id: video_outputs
                    anchors.fill: parent
                    source: provider
                }
                Timer{
                    id: myTimer
                    interval: 1000 / 25
                    running: true
                    repeat: true

                    onTriggered:{
                        provider.test();
                    }
                }
                Timer{
                    id: signal_timer
                    interval: 1000
                    running: true
                    repeat: true

                    onTriggered:{
                        if(!provider.mbIsNoSignal()) signal_status.text = ""; else signal_status.text = "无信号";
                    }
                }
                color: "#2c2a38"
                Text{
                    id: signal_status
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

                // radius: 15
                RowLayout{
                    height: parent.height
                    width: parent.width
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5

                    anchors.fill: bottom_btn
                    anchors.verticalCenter: parent.verticalCenter

                    Rectangle{
                        width: 15
                        height: 15
//                        anchors.verticalCenter: parent.verticalCenter
                        color: "red"
                        radius: width / 2
                    }

                    Item{
                        Layout.fillWidth: true
                    }
                    Button{
                        // id: control
                        Layout.preferredWidth: 18
                        Layout.preferredHeight: 18
                        background: Rectangle{
                            radius: 8 // 设置圆角大小
                            color: parent.pressed ? "red" : "lightblue"
                            border.color: "blue"
                            border.width: 1
                            anchors.fill: parent
                        }
                        text: qsTr("警")
                    }
                    Button{
                        id: fucks
                        Layout.preferredWidth: 38
                        Layout.preferredHeight: 18
                        background: Rectangle{
                            radius: 8 // 设置圆角大小
                            color: parent.pressed ? "lightgray" : "lightblue"
                            border.color: "blue"
                            border.width: 1
                            anchors.fill: parent
                        }
                        //                        style: ButtonStyle {
                        //                            background: Rectangle {
                        //                                implicitWidth: control.width
                        //                                implicitHeight: control.height
                        //                                color: control.pressed ? "lightblue" : "lightgray" // 设置按下时的颜色
                        //                            }
                        //                        }
                        text: "录"
                        onClicked:{
                        }
                    }
                    Button{
                        Layout.preferredWidth: 18
                        Layout.preferredHeight: 18
                        background: Rectangle{
                            radius: 8 // 设置圆角大小
                            color: parent.pressed ? "lightgray" : "lightblue"
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
