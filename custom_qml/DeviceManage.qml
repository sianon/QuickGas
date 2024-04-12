import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle{
    id: dialog
    height: 480
    width: 640
    Layout.minimumWidth: 480
    Layout.minimumHeight: 320
    color: "#42424e"
    //    anchors.fill: parent
    property var child_index: parent.index
    property var url_rtsp: "rtsp://mobliestream.c3tv.com:554/live/goodtv.sdp"
    property var total_leak: "15L"
    property var target_distance: "15M"
    property var concentration: "800ppm"
    property var temperature: "30C"
    property var humidity: "80%"
    property var radiance: "30"
    Component.onCompleted:{

    }

    RowLayout{
        anchors.fill: parent
        ColumnLayout{
            Layout.preferredWidth: parent.width/5
            Rectangle{
                anchors.fill: parent
                color: "#2c2a38"
                radius: 6
            }
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height

            Rectangle{
                Layout.alignment: Qt.AlignTop
                Layout.preferredHeight: 38
                Layout.fillWidth: true
                height: 38
                color: "#42424e"
                border.color: "#2c2a38"
                border.width: 2
                radius: 5
                Text{
                    color: "#ffffffff"
                    font.pixelSize: 16
                    font.family: "Microsoft YaHei"
                    anchors.centerIn: parent
                    text: "设备列表"
                }
            }

            ListView{
                visible: true
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignTop
                model: ["G800-机位1", "G800-机位2", "G900-机位23", "机位25", "机位27"]

                delegate: Text{
                    text: modelData
                    font.pixelSize: 14
                    color: "white"
                }
            }
            //PTZ control panel
            ColumnLayout{
                id: left_column_bottom
                visible: false
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop
                Rectangle{
                    Layout.alignment: Qt.AlignTop
                    Layout.preferredHeight: 38
                    Layout.fillWidth: true
                    height: 38
                    color: "#42424e"
                    border.color: "#2c2a38"
                    border.width: 2
                    radius: 5
                    Text{
                        color: "#ffffffff"
                        font.pixelSize: 16
                        font.family: "Microsoft YaHei"
                        anchors.centerIn: parent
                        text: "云台控制"
                    }
                }
                GridLayout{
                    Layout.fillWidth: true
                    anchors.margins: 8
                    Layout.alignment: Qt.AlignHCenter
                    rows: 3
                    columns: 3
                    Repeater{
                        model: 9 // 创建 9 个子项
                        Button{
                            //                            Layout.preferredWidth: parent.width / 3 - 4
                            //                            Layout.preferredHeight: parent.height / 3 - 4
                            Layout.preferredWidth: 50
                            Layout.preferredHeight: 50
                            background: Rectangle{
                                anchors.fill: parent
                                radius: 15
                                color: parent.pressed ? "#2c2a38" : "#42424e"
                                border.color: "blue"
                                border.width: 1
                            }
                        }
                    }
                }
                Text{
                    color: "#ffffffff"
                    font.pixelSize: 12
                    font.family: "Microsoft YaHei"
                    Layout.alignment: Qt.AlignHCenter
                    text: "对焦"
                }
                RowLayout{
                    id: focus_zoom_control_btn
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                    Button{
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 30
                        background: Rectangle{
                            radius: 15 // 设置圆角大小
                            color: parent.pressed ? "red" : "lightblue"
                            border.color: "blue"
                            border.width: 1
                            anchors.fill: parent
                        }
                        text: "+"
                    }
                    Button{
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 30
                        background: Rectangle{
                            radius: 15 // 设置圆角大小
                            color: parent.pressed ? "red" : "lightblue"
                            border.color: "blue"
                            border.width: 1
                            anchors.fill: parent
                        }
                        text: "-"
                    }
                    Button{
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 30
                        background: Rectangle{
                            radius: 15 // 设置圆角大小
                            border.color: "blue"
                            border.width: 1
                            anchors.fill: parent
                        }
                        text: "+"
                        font.pixelSize: 16
                    }
                    Button{
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 30
                        background: Rectangle{
                            radius: 15 // 设置圆角大小
                            color: parent.pressed ? "red" : "lightblue"
                            border.color: "blue"
                            border.width: 1
                            anchors.fill: parent
                        }
                        text: "-"
                    }
                }
                Text{
                    color: "#ffffffff"
                    font.pixelSize: 12
                    font.family: "Microsoft YaHei"
                    Layout.alignment: Qt.AlignHCenter
                    text: "速度"
                }
                Slider{
                    id: spin_speed_slider
                    Layout.alignment: Qt.AlignHCenter
                    width: parent.width
                    from: 1
                    value: 25
                    to: 100
                }
                Text{
                    color: "#ffffffff"
                    font.pixelSize: 12
                    font.family: "Microsoft YaHei"
                    Layout.alignment: Qt.AlignHCenter
                    text: "预置位"
                }
                RowLayout{
                    visible: true
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                    Button{
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 30
                        background: Rectangle{
                            radius: 15 // 设置圆角大小
                            color: parent.pressed ? "red" : "lightblue"
                            border.color: "blue"
                            border.width: 1
                            anchors.fill: parent
                        }
                        text: "1"
                    }
                    Button{
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 30
                        background: Rectangle{
                            radius: 15 // 设置圆角大小
                            color: parent.pressed ? "red" : "lightblue"
                            border.color: "blue"
                            border.width: 1
                            anchors.fill: parent
                        }
                        text: "2"
                    }
                    Button{
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 30
                        background: Rectangle{
                            radius: 15 // 设置圆角大小
                            // color: "#42424e"
                            border.color: "blue"
                            border.width: 1
                            anchors.fill: parent
                        }
                        text: "3"
                        font.pixelSize: 16
                    }
                    Button{
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 30
                        background: Rectangle{
                            radius: 15 // 设置圆角大小
                            color: parent.pressed ? "red" : "lightblue"
                            border.color: "blue"
                            border.width: 1
                            anchors.fill: parent
                        }
                        text: "4"
                    }
                }
            }
        }
        ColumnLayout{
            visible: true
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.6
            spacing: 0
            Layout.alignment: Qt.AlignTop
            Rectangle{
                id: top_status
                Layout.preferredHeight: 23
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop
                color: "#2c2a38"
                Label{
                    anchors.fill: parent
                    font.pixelSize: 16
                    rightPadding: 6
                    color: "#ffffffff"
                    horizontalAlignment: Text.AlignRight
                    text: "1920x1080 60fps"
                }
            }
            RowLayout{
                Layout.preferredHeight: 23
                Layout.fillWidth: true
                Layout.fillHeight: true
                Rectangle{
                    anchors.fill: parent
//                    Layout.fillWidth: true
                    color: "#2c2a38"
                }
                Item{
                    width: 3
                }
                Rectangle{
                    width: 15
                    height: 15
                    color: "red"
                    radius: width / 2
                }

                Item{
                    Layout.fillWidth: true
                }
                Button{
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
                    Layout.alignment: Qt.AlignVCenter
                    background: Rectangle{
                        radius: 8 // 设置圆角大小
                        color: parent.pressed ? "lightgray" : "lightblue"
                        border.color: "blue"
                        border.width: 1
                        anchors.fill: parent
                    }
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
                Item{
                    width: 3
                }
            }
        }
    }
}