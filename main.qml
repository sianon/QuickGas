import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import QtQuick.Controls.Material 2.12

import QtMultimedia 5.15

//import pkg.producer 1.0
//import pkg.custom_video_surface 1.0

ApplicationWindow {
    id:mainWindow
    visible: true
    width: 1280
    height: 720
    title: "气体泄漏检测系统"
    color: "#42424e"
    // flags: Qt.FramelessWindowHint

    //QML中的方法可以被cpp调用，也可以作为槽函数
    function qml_method(val_arg){
        cpp_obj.onTestSlot(1,2)
        console.log("qml method runing",val_arg,"return ok")
        return "ok"
    }
    function showLsDialog(){
        var dialog = LsDialog.showModal();
        dialog.exec();
    }
    Frame {
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
            id:main_column_layout
            anchors.fill: parent
            Rectangle{
                color: "#ffd64c"
                border.color: "#ffd64c"
            }
            Pane {
                id: main_first_column_pane
                visible: true
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                anchors.left: parent.left
                anchors.top: parent.top

                background: Rectangle{
                    color: "transparent"
                    // border.color: "#21be2b"
                }
            }
            Pane {
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

                    TabBar {
                        id: tabBar
                        Layout.preferredHeight: 28
                        background: Rectangle{
                            color: "#2c2a38"
                        }
                        currentIndex: stackView.currentIndex
                        TabButton {
                            anchors.verticalCenter: parent.verticalCenter
                            height: 28
                            width: 68
                            font.family: "Microsoft YaHei"
                            text: "预览"
                        }
                        TabButton {
                            height: 28
                            width: 68
                            anchors.verticalCenter: parent.verticalCenter
                            font.family: "Microsoft YaHei"
                            text: "设备管理" }
                        TabButton {
                            height: 28
                            width: 68
                            anchors.verticalCenter: parent.verticalCenter
                            font.family: "Microsoft YaHei"
                            text: "气体分析" }
                        TabButton {
                            height: 28
                            width: 68
                            anchors.verticalCenter: parent.verticalCenter
                            // contentItem: Text {
                            //     text: control.text
                            //     font: control.font
                            //     opacity: enabled ? 1.0 : 0.3
                            //     color: control.down ? "#17a81a" : "#21be2b"
                            //     horizontalAlignment: Text.AlignHCenter
                            //     verticalAlignment: Text.AlignVCenter
                            //     elide: Text.ElideRight
                            // }
                            // background: Rectangle {
                            //     // implicitWidth: parent.width
                            //     // implicitHeight: parent.height
                            //     // opacity: enabled ? 1 : 0.3
                            //     radius: 5
                            //     // color: "#42424e"
                            //     border.color: control.down ? "#17a81a" : "#21be2b"
                            //     color: enabled ? "#42424e" : "#2c2a38"
                            // }
                            font.family: "Microsoft YaHei"
                            text: "温度分析" }
                        TabButton {
                            height: 28
                            width: 68
                            anchors.verticalCenter: parent.verticalCenter
                            font.family: "Microsoft YaHei"
                            text: "告警历史" }
                        TabButton {
                            height: 28
                            width: 68
                            anchors.verticalCenter: parent.verticalCenter
                            font.family: "Microsoft YaHei"
                            text: "视频回放" }
                        TabButton {
                            height: 28
                            width: 68
                            anchors.verticalCenter: parent.verticalCenter
                            font.family: "Microsoft YaHei"
                            text: "用户管理" }
                        onCurrentIndexChanged: stack_layout.currentIndex = tabBar.currentIndex
                    }
                }
            }
            Pane {
                id: main_tab_container
                visible: true
                Layout.fillWidth: true
                anchors.left: main_tab_btn.left
                anchors.top: main_tab_btn.bottom
                anchors.bottom: main_status_bottom.top

                leftPadding: 3
                rightPadding: 3
                topPadding: 3
                bottomPadding: 3

                background: Rectangle{
                    color: "#42424e"
                }

                StackLayout {
                    id: stack_layout
                    currentIndex: 0
                    anchors.fill: parent

                    Rectangle {
                        anchors.fill: parent
                        color: "#42424e"
                        RowLayout {
                            anchors.fill: parent
                            Rectangle{
                                id: left_column
                                height: parent.height
                                width: 300
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                color: "#42424e"
                                radius: 5
                                //left view
                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    Rectangle {
                                        id: left_column_top
                                        anchors.left: parent.left
                                        anchors.top: parent.top
                                        width: parent.width
                                        height: 400
                                        color: "#2c2a38"
                                        border.color: "#42424e"
                                        radius: 5
                                        Rectangle {
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
                                        ListView {
                                            anchors.left: left_column_top_title.left
                                            anchors.top: left_column_top_title.bottom
                                            anchors.bottom: parent.bottom
                                            anchors.margins: 10
                                            model: ["G800-机位1", "G800-机位2", "G900-机位23", "机位25", "机位27"]
                                            delegate: Text {
                                                text: modelData
                                                font.pixelSize: 14
                                                color: "white"
                                                verticalAlignment: Text.AlignVCenter
                                            }
                                        }
                                    }
                                    Rectangle {
                                        id: left_column_bottom
                                        anchors.left: left_column_top.left
                                        anchors.top: left_column_top.bottom
                                        anchors.bottom: parent.bottom
                                        width: parent.width
                                        color: "#2c2a38"

                                        radius: 5
                                        Rectangle {
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
                                    }
                                }
                            }

                            Rectangle {
                                anchors.left: left_column.right
                                anchors.top: left_column.top
                                height: parent.height
                                width: parent.width
                                color: "#2c2a38"
                                border.color: "#42424e"
                                radius: 5
                                GridLayout {
                                    rows: 4
                                    columns: 4
                                    height: parent.height
                                    width: parent.width
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    Repeater {
                                        model: 16 // 创建 16 个子项
                                        Rectangle {
                                            width: 320
                                            height: 240
                                            Text {
                                                anchors.verticalCenter: parent.verticalCenter
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                text: "Content for Tab 1"
                                            }
                                            color: "#24486c"
                                        }
                                    }
                                }
                            }

                        }
                    }
                    Rectangle {
                        color: "lightgreen"
                        Text {
                            text: "Content for Tab 2"
                        }
                    }

                    Rectangle {
                        color: "lightcoral"
                        Text {
                            text: "Content for Tab 3"
                        }
                    }
                    Rectangle {
                        color: "lightcoral"
                        Text {
                            text: "Content for Tab 4"
                        }
                    }
                    Rectangle {
                        color: "lightcoral"
                        Text {
                            text: "Content for Tab 5"
                        }
                    }
                    Rectangle {
                        color: "lightcoral"
                        Text {
                            text: "Content for Tab 6"
                        }
                    }
                    Rectangle {

                    }
                }
            }
            //bottom status
            Pane {
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
                    id:row_layout_status_bottom
                    anchors.fill: parent

                    Layout.alignment: Qt.AlignVCenter
                    Item {
                        Layout.minimumWidth: 20 // 自定义间距
                    }
                    Item {
                        anchors.verticalCenter: parent.verticalCenter
                        Rectangle {
                            width: 15
                            height: 15
                            color: "red"
                            radius: width / 2
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    Text {
                        text: "西南服务器:"
                        color: "white"
                        font.pixelSize: 12
                        // Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    }
                    Text {
                        text: "未连接..."
                        color: "white"
                        font.pixelSize: 12
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    }
                    Item {
                        Layout.fillWidth: true // 自定义间距
                    }
                    Text {
                        color: "white"
                        text: "处理器:"
                        font.pixelSize: 12
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    }
                    ProgressBar {
                        value: 70
                        padding: 1
                        background: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 14
                            color: "#e6e6e6"
                            radius: 5
                        }
                        contentItem: Item {
                            implicitWidth: 100
                            implicitHeight: 12

                            Rectangle {
                                width: 50
                                height: parent.height
                                radius: 4
                                color: "#c96600"
                            }
                        }
                    }
                    Text {
                        color: "white"
                        text: "内存:"
                        font.pixelSize: 12
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    }
                    ProgressBar {
                        value: 50
                        padding: 1
                        background: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 14
                            color: "#e6e6e6"
                            radius: 5
                        }
                        contentItem: Item {
                            implicitWidth: 100
                            implicitHeight: 12

                            Rectangle {
                                width: 80
                                height: parent.height
                                radius: 4
                                color: "#17a81a"
                            }
                        }
                    }
                    Text {
                        width: 40
                        color: "white"
                        text: "硬盘:"
                        font.pixelSize: 12
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    }
                    ProgressBar {
                        value: 20
                        padding: 1
                        background: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 14
                            color: "#e6e6e6"
                            radius: 5
                        }
                        contentItem: Item {
                            implicitWidth: 100
                            implicitHeight: 12

                            Rectangle {
                                width: 50
                                height: parent.height
                                radius: 4
                                color: "#17a81a"
                            }
                        }
                    }
                    Text {
                        color: "white"
                        text: "网络:"
                        font.pixelSize: 12
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    }
                    ProgressBar {
                        value: 80
                        padding: 1
                        background: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 14
                            color: "#e6e6e6"
                            radius: 5
                        }
                        contentItem: Item {
                            implicitWidth: 100
                            implicitHeight: 12

                            Rectangle {
                                width: 90
                                height: parent.height
                                radius: 4
                                color: "#17a81a"
                            }
                        }
                    }
                    Item {
                        Layout.minimumWidth: 8 // 自定义间距
                    }
                }
            }
        }
    }
}
