import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import QtQuick.Controls.Material 2.12
import "."
import QtMultimedia 5.15
import Local 1.0
//import pkg.custom_video_surface 1.0

ApplicationWindow{
    id: mainWindow

    visible: true
    width: 1280
    height: 720
    title: "气体泄漏检测系统"
    color: "#42424e"
    // flags: Qt.FramelessWindowHint

    //QML中的方法可以被cpp调用，也可以作为槽函数
    function qml_method(val_arg){
        cpp_obj.onTestSlot(1, 2)
        console.log("qml method runing", val_arg, "return ok")
        return "ok"
    }

    function showLsDialog(){
        var dialog = LsDialog.showModal();
        dialog.exec();
    }

    Frame{
        id: main_frame
        visible: true
        width: parent.width
        height: parent.height
        leftPadding: 1
        rightPadding: 1
        topPadding: 1
        bottomPadding: 1
        background: Rectangle{
            color: "#42424e"
            // border.color: "#c94f4f"
        }

        ColumnLayout{
            id: main_column_layout
            anchors.fill: parent
            Rectangle{
                color: "#ffd64c"
                border.color: "#ffd64c"
            }
            Pane{
                id: main_first_column_pane
                visible: true
                objectName: "main_window"
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                anchors.left: parent.left
                anchors.top: parent.top

                background: Rectangle{
                    color: "transparent"
                    // border.color: "#21be2b"
                }
            }
            Pane{
                id: main_tab_btn
                Layout.preferredHeight: 38
                Layout.fillWidth: true
                anchors.left: main_first_column_pane.left
                anchors.top: main_first_column_pane.bottom

                background: Rectangle{
                    color: "#2c2a38"
                    // border.color: "#b2b8cc"
                }
                RowLayout{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter

                    TabBar{
                        id: tabBar
                        Layout.preferredHeight: 28
                        background: Rectangle{
                            color: "#2c2a38"
                        }
                        currentIndex: stackView.currentIndex
                        TabButton{
                            anchors.verticalCenter: parent.verticalCenter
                            height: 28
                            width: 68
                            font.family: "Microsoft YaHei"
                            text: "预览"
                        }
                        TabButton{
                            height: 28
                            width: 68
                            anchors.verticalCenter: parent.verticalCenter
                            font.family: "Microsoft YaHei"
                            text: "设备管理"
                        }
                        TabButton{
                            height: 28
                            width: 68
                            anchors.verticalCenter: parent.verticalCenter
                            font.family: "Microsoft YaHei"
                            text: "气体分析"
                        }
                        TabButton{
                            height: 28
                            width: 68
                            anchors.verticalCenter: parent.verticalCenter
                            font.family: "Microsoft YaHei"
                            text: "温度分析"
                        }
                        TabButton{
                            height: 28
                            width: 68
                            anchors.verticalCenter: parent.verticalCenter
                            font.family: "Microsoft YaHei"
                            text: "告警历史"
                        }
                        TabButton{
                            height: 28
                            width: 68
                            anchors.verticalCenter: parent.verticalCenter
                            font.family: "Microsoft YaHei"
                            text: "视频回放"
                        }
                        TabButton{
                            height: 28
                            width: 68
                            anchors.verticalCenter: parent.verticalCenter
                            font.family: "Microsoft YaHei"
                            text: "用户管理"
                        }
                        onCurrentIndexChanged: stack_layout.currentIndex = tabBar.currentIndex
                    }
                }
            }
            Pane{
                id: main_tab_container
                Layout.fillWidth: true
                anchors.left: main_tab_btn.left
                anchors.top: main_tab_btn.bottom
                anchors.bottom: main_status_bottom.top

                leftPadding: 3
                rightPadding: 3
                topPadding: 3
                bottomPadding: 3
                // anchors.margins: 8
                background: Rectangle{
                    color: "#42424e"
                }

                StackLayout{
                    id: stack_layout
                    currentIndex: 0
                    anchors.fill: parent

                    Rectangle{
                        anchors.fill: parent
                        color: "#42424e"
                        RowLayout{
                            anchors.fill: parent
                            spacing: 5
                            Rectangle{
                                id: left_column
                                height: parent.height
                                width: 300
                                anchors.left: parent.left
                                anchors.top: parent.top
                                color: "#42424e"
                                radius: 5
                                //left view
                                ColumnLayout{
                                    anchors.fill: parent
                                    Rectangle{
                                        id: left_column_top
                                        anchors.margins: 5
                                        Layout.alignment: Qt.AlignTop
                                        width: parent.width
                                        height: 300
                                        color: "#2c2a38"
                                        radius: 5
                                        Rectangle{
                                            id: left_column_top_title
                                            anchors.left: parent.left
                                            anchors.top: parent.top
                                            width: parent.width
                                            height: 38
                                            color: "#42424e"
                                            border.color: "#2c2a38"
                                            border.width: 2
                                            radius: 5
                                            Text{
                                                color: "#ffffffff"
                                                font.pixelSize: 16
                                                font.family: "Microsoft YaHei"
                                                anchors.verticalCenter: parent.verticalCenter
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                text: "设备列表"

                                            }
                                        }
                                        ListView{
                                            visible: true
                                            anchors.left: left_column_top_title.left
                                            anchors.top: left_column_top_title.bottom
                                            width: parent.width
                                            height: 300
                                            //                                            anchors.bottom: parent.bottom
                                            anchors.margins: 10
                                            model: ["G800-机位1", "G800-机位2", "G900-机位23", "机位25", "机位27"]
                                            delegate: Text{
                                                text: modelData
                                                font.pixelSize: 14
                                                color: "white"
                                                verticalAlignment: Text.AlignVCenter
                                            }
                                        }
                                    }
                                    //PTZ control panel
                                    Rectangle{
                                        id: left_column_bottom
                                        visible: true
                                        Layout.fillHeight: true
                                        anchors.left: left_column_top.left
                                        anchors.top: left_column_top.bottom
                                        anchors.topMargin: 5
                                        radius: 5
                                        width: parent.width
                                        color: "#2c2a38"
                                        //ptz title
                                        Rectangle{
                                            visible: true
                                            id: left_column_ptz_title
                                            anchors.left: parent.left
                                            anchors.top: parent.top
                                            width: parent.width
                                            height: 38
                                            color: "#42424e"
                                            border.color: "#2c2a38"
                                            border.width: 2
                                            radius: 5
                                            Text{
                                                color: "#ffffffff"
                                                font.pixelSize: 16
                                                font.family: "Microsoft YaHei"
                                                anchors.verticalCenter: parent.verticalCenter
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                text: "云台控制"
                                            }

                                        }
                                        Rectangle{
                                            visible: true
                                            id: left_ptz_control_arrow
                                            anchors.left: left_column_ptz_title.left
                                            anchors.top: left_column_ptz_title.bottom
                                            width: parent.width
                                            color: "#2c2a38"
//                                            border.color: "red"
                                            //ptz arrow
                                            Rectangle{
                                                id: ptz_control_arrow
                                                color: "#2c2a38"
//                                                border.color: "red"
                                                width: 180
                                                height: 180
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                radius: 5
                                                GridLayout{
                                                    anchors.margins: 8
                                                    rows: 3
                                                    columns: 3
                                                    anchors.fill: parent
                                                    Repeater{
                                                        model: 9 // 创建 9 个子项
                                                        Button{
                                                            Layout.preferredWidth: parent.width / 3 - 4
                                                            Layout.preferredHeight: parent.height / 3 - 4
                                                            background: Rectangle{
                                                                radius: 15
                                                                color: parent.pressed ? "#2c2a38" : "#42424e"
                                                                border.color: "blue"
                                                                border.width: 1
                                                                anchors.fill: parent
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            //ptz focus zoom
                                            //                                            Item{ height: 20 }

                                            Rectangle{
                                                visible: true
                                                id: focus_zoom_control
                                                anchors.left: parent.left
                                                anchors.top: ptz_control_arrow.bottom
                                                anchors.topMargin: 15
                                                width: left_column_ptz_title.width
                                                height: 20
                                                color: "transparent"
                                                radius: 5
                                                Rectangle{
                                                    visible: true
                                                    anchors.left: parent.left
                                                    anchors.top: parent.top
                                                    id: focus_zoom_txt
                                                    color: "transparent"
                                                    height: 20
                                                    width: left_column_ptz_title.width
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    Text{
                                                        color: "#ffffffff"
                                                        font.pixelSize: 12
                                                        anchors.horizontalCenter: parent.horizontalCenter
                                                        font.family: "Microsoft YaHei"
                                                        text: "对焦"
                                                    }
                                                }

                                            }
                                            RowLayout{
                                                id: focus_zoom_control_btn
                                                width: parent.width
                                                height: 30
                                                //                                                    color: "red"
                                                anchors.top: focus_zoom_control.bottom
                                                anchors.left: parent.left
                                                //                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                //                                                    anchors.topMargin: 15
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
                                                Item{
                                                    Layout.fillWidth: true
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
                                            //spin speed
                                            Rectangle{
                                                id: spin_speed_control
                                                anchors.top: focus_zoom_control_btn.bottom
                                                anchors.left: parent.left
                                                visible: true
                                                width: left_column_ptz_title.width
                                                height: 30
                                                color: "transparent"
                                                //                                                 border.color: "#42424e"
                                                // border.width: 2
                                                Rectangle{
                                                    id: spin_speed_txt
                                                    anchors.top: parent.top
                                                    anchors.left: parent.left
                                                    height: 30
                                                    width: left_column_ptz_title.width
                                                    color: "transparent"
                                                    Text{
                                                        color: "#ffffffff"
                                                        font.pixelSize: 12
                                                        anchors.horizontalCenter: parent.horizontalCenter
                                                        //                                                        anchors.verticalCenter: parent.verticalCenter
                                                        font.family: "Microsoft YaHei"
                                                        text: "速度"
                                                    }
                                                }
                                                radius: 5
                                            }
                                            Slider{
                                                id: spin_speed_slider
                                                width: parent.width/2
                                                anchors.top: spin_speed_control.bottom
                                                anchors.left: parent.left
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                from: 1
                                                value: 25
                                                to: 100
                                            }
                                            //                                            Item{ height: 10 }

                                            //preserver position
                                            Rectangle{
                                                id: preserver_position_txt
                                                anchors.top: spin_speed_slider.bottom
                                                anchors.left: parent.left
                                                visible: true
                                                width: left_column_bottom.width
                                                height: 30
                                                color: "#2c2a38"
//                                                Rectangle{
//                                                    anchors.top: parent.top
//                                                    anchors.left: parent.left
//                                                    //                                                    id: preserver_position_txt
//                                                    height: 30
//                                                    width: left_column_ptz_title.width
//
//                                                }
                                                Text{
                                                    color: "#ffffffff"
                                                    font.pixelSize: 12
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    font.family: "Microsoft YaHei"
                                                    text: "预置位"
                                                }

                                            }
                                            RowLayout{
                                                visible: true
                                                anchors.top: preserver_position_txt.bottom
                                                anchors.left: parent.left
                                                width: parent.width
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
                                }

                            }
                            //preview video frame
                            Rectangle{
                                anchors.left: left_column.right
                                anchors.top: left_column.top
                                anchors.verticalCenter: parent.verticalCenter
                                height: parent.height
                                width: parent.width - 306
                                //                                color: "#2c2a38"
                                color: "#2c2a38"
                                anchors.margins: 3
                                // border.color: "#aaaaaf"
                                radius: 5
                                GridLayout{
                                    rows: 4
                                    columns: 4
                                    height: parent.height
                                    width: parent.width
                                    anchors.fill: parent
                                    anchors.margins: 3

                                    Repeater{
                                        model: 16 // 创建 16 个子项
                                        Rectangle{
                                            Layout.preferredWidth: parent.width / 4 - 6
                                            Layout.preferredHeight: parent.height / 4 - 3
                                            color: "#42424e"
                                            radius: 5
                                            VideoFrameChild{
                                                child_index: index
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Rectangle{
                        color: "lightgreen"
                        Text{
                            text: "Content for Tab 2"
                        }
                    }

                    Rectangle{
                        color: "lightcoral"
                        Text{
                            text: "Content for Tab 3"
                        }
                    }
                    Rectangle{
                        color: "lightcoral"
                        Text{
                            text: "Content for Tab 4"
                        }
                    }
                    Rectangle{
                        color: "lightcoral"
                        Text{
                            text: "Content for Tab 5"
                        }
                    }
                    Rectangle{
                        color: "lightcoral"
                        Text{
                            text: "Content for Tab 6"
                        }
                    }
                    Rectangle{
                        anchors.fill: parent

                    }
                }
            }
            //bottom status
            Pane{
                id: main_status_bottom
                Layout.fillWidth: true
                Layout.preferredHeight: 26

                anchors.left: parent.left
                anchors.bottom: parent.bottom

                leftPadding: 1 // 左内边距
                rightPadding: 1 // 右内边距
                topPadding: 1 // 上内边距
                bottomPadding: 1 // 下内边距
                anchors.margins: 0
                background: Rectangle{
                    color: "#2c2a38"
                    // border.color: "#21be2b"
                }
                RowLayout{
                    id: row_layout_status_bottom
                    anchors.fill: parent

                    Layout.alignment: Qt.AlignVCenter
                    Item{
                        Layout.minimumWidth: 20 // 自定义间距
                    }
                    Item{
                        anchors.verticalCenter: parent.verticalCenter
                        Rectangle{
                            width: 15
                            height: 15
                            color: "red"
                            radius: width / 2
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    Text{
                        text: "西南服务器:"
                        color: "white"
                        font.pixelSize: 12
                        //                         Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    }
                    Text{
                        text: "未连接..."
                        color: "white"
                        font.pixelSize: 12
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    }
                    Item{
                        Layout.fillWidth: true // 自定义间距
                    }
                    Text{
                        color: "white"
                        text: "处理器:"
                        font.pixelSize: 12
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    }
                    ProgressBar{
                        value: 70
                        padding: 1
                        background: Rectangle{
                            implicitWidth: 100
                            implicitHeight: 14
                            color: "#e6e6e6"
                            radius: 5
                        }
                        contentItem: Item{
                            implicitWidth: 100
                            implicitHeight: 12

                            Rectangle{
                                width: 50
                                height: parent.height
                                radius: 4
                                color: "#c96600"
                            }
                        }
                    }
                    Text{
                        color: "white"
                        text: "内存:"
                        font.pixelSize: 12
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    }
                    ProgressBar{
                        value: 50
                        padding: 1
                        background: Rectangle{
                            implicitWidth: 100
                            implicitHeight: 14
                            color: "#e6e6e6"
                            radius: 5
                        }
                        contentItem: Item{
                            implicitWidth: 100
                            implicitHeight: 12

                            Rectangle{
                                width: 80
                                height: parent.height
                                radius: 4
                                color: "#17a81a"
                            }
                        }
                    }
                    Text{
                        width: 40
                        color: "white"
                        text: "硬盘:"
                        font.pixelSize: 12
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    }
                    ProgressBar{
                        value: 20
                        padding: 1
                        background: Rectangle{
                            implicitWidth: 100
                            implicitHeight: 14
                            color: "#e6e6e6"
                            radius: 5
                        }
                        contentItem: Item{
                            implicitWidth: 100
                            implicitHeight: 12

                            Rectangle{
                                width: 50
                                height: parent.height
                                radius: 4
                                color: "#17a81a"
                            }
                        }
                    }
                    Text{
                        color: "white"
                        text: "网络:"
                        font.pixelSize: 12
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    }
                    ProgressBar{
                        value: 80
                        padding: 1
                        background: Rectangle{
                            implicitWidth: 100
                            implicitHeight: 14
                            color: "#e6e6e6"
                            radius: 5
                        }
                        contentItem: Item{
                            implicitWidth: 100
                            implicitHeight: 12

                            Rectangle{
                                width: 90
                                height: parent.height
                                radius: 4
                                color: "#17a81a"
                            }
                        }
                    }
                    Item{
                        Layout.minimumWidth: 8 // 自定义间距
                    }
                }
            }
        }
    }
}
