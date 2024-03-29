import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import QtQuick.Controls.Material 2.12
import "."
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
                                    // width: 300
                                    Rectangle {
                                        id: left_column_top
                                        anchors.left: parent.left
                                        anchors.top: parent.top
                                        anchors.bottom: left_column_bottom.top
                                        width: parent.width

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
                                    //PTZ control panel
                                    Rectangle {
                                        id: left_column_bottom
                                        anchors.left: left_column_top.left
                                        anchors.bottom: parent.bottom
                                        radius: 5
                                        width: parent.width
                                        height: 500
                                        color: "#2c2a38"
                                        //ptz title
                                        Rectangle {
                                            id: left_column_ptz_title
                                            anchors.left: parent.left
                                            anchors.top: parent.top
                                            width: parent.width
                                            height: 38
                                            color: "#42424e"
                                            border.color: "#2c2a38"
                                            border.width: 2
                                            radius: 5
                                            Text {
                                                color: "#ffffffff"
                                                font.pixelSize: 16
                                                font.family: "Microsoft YaHei"
                                                anchors.verticalCenter: parent.verticalCenter
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                text: "云台控制"
                                            }

                                        }
                                        ColumnLayout {
                                            id: left_ptz_control_arrow
                                            anchors.left: left_column_ptz_title.left
                                            anchors.top: left_column_ptz_title.bottom
                                            //ptz arrow
                                            Rectangle{
                                                anchors.left: parent.left
                                                anchors.top: parent.top
                                                width: left_column_ptz_title.width
                                                height: 216
                                                color: "#2c2a38"
                                                // border.color: "#42424e"
                                                // border.width: 2
                                                radius: 5
                                                GridLayout {
                                                    rows: 3
                                                    columns: 3
                                                    // anchors.left: parent.left
                                                    // anchors.top: parent.top
                                                    anchors.fill: parent
                                                    // // anchors.margins: 10
                                                    // anchors.verticalCenter: parent.verticalCenter
                                                    // anchors.horizontalCenter: parent.horizontalCenter
                                                    Repeater {
                                                        model: 9 // 创建 16 个子项
                                                        Rectangle {
                                                            Layout.preferredWidth: parent.width/3
                                                            Layout.preferredHeight: parent.height/3
                                                            color: "#42424e"
                                                            radius: 5
                                                        }
                                                    }
                                                }
                                            }
                                            //ptz focus zoom
                                            Item { height: 20 }
                                            Item {
                                                height: 20
                                                width: left_column_ptz_title.width
                                                Text{
                                                    color: "#ffffffff"
                                                    font.pixelSize: 12
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    font.family: "Microsoft YaHei"
                                                    text: "对焦"
                                                }
                                            }
                                            Rectangle{
                                                width: left_column_ptz_title.width
                                                height: 30
                                                color: "#2c2a38"
                                                // border.color: "#42424e"
                                                // border.width: 2
                                                radius: 5

                                                RowLayout {
                                                    anchors.centerIn: parent
                                                    Button{
                                                        Layout.preferredWidth: 30
                                                        Layout.preferredHeight: 30
                                                        background: Rectangle {
                                                            radius: 15 // 设置圆角大小
                                                            color: control.pressed ? "red" : "lightblue"
                                                            border.color: "blue"
                                                            border.width: 1
                                                            anchors.fill: parent
                                                        }
                                                        text: "+"
                                                    }
                                                    Button{
                                                        Layout.preferredWidth: 30
                                                        Layout.preferredHeight: 30
                                                        background: Rectangle {
                                                            radius: 15 // 设置圆角大小
                                                            color: control.pressed ? "red" : "lightblue"
                                                            border.color: "blue"
                                                            border.width: 1
                                                            anchors.fill: parent
                                                        }
                                                        text: "-"
                                                    }
                                                    Item {
                                                        Layout.fillWidth: true
                                                    }
                                                    Button{
                                                        Layout.preferredWidth: 30
                                                        Layout.preferredHeight: 30
                                                        background: Rectangle {
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
                                                        background: Rectangle {
                                                            radius: 15 // 设置圆角大小
                                                            color: control.pressed ? "red" : "lightblue"
                                                            border.color: "blue"
                                                            border.width: 1
                                                            anchors.fill: parent
                                                        }
                                                        text: "-"
                                                    }
                                                }
                                            }
                                            Item { height: 20 }
                                            Item {
                                                height: 20
                                                width: left_column_ptz_title.width
                                                Text{
                                                    color: "#ffffffff"
                                                    font.pixelSize: 12
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    font.family: "Microsoft YaHei"
                                                    text: "速度"
                                                }
                                            }
                                            //spin speed
                                            Rectangle{
                                                width: left_column_ptz_title.width
                                                height: 30
                                                color: "#2c2a38"
                                                // border.color: "#42424e"
                                                // border.width: 2

                                                radius: 5
                                                Slider {
                                                    anchors.centerIn: parent
                                                    from: 1
                                                    value: 25
                                                    to: 100
                                                }
                                            }
                                            Item { height: 10 }
                                            Item {
                                                height: 20
                                                width: left_column_ptz_title.width
                                                Text{
                                                    color: "#ffffffff"
                                                    font.pixelSize: 12
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    font.family: "Microsoft YaHei"
                                                    text: "预置位"
                                                }
                                            }
                                            //preserver position
                                            Rectangle{
                                                anchors.left: left_ptz_control_arrow.left
                                                anchors.bottom: left_ptz_control_arrow.bottom
                                                width: left_column_bottom.width
                                                height: 30
                                                color: "#2c2a38"
                                                RowLayout {
                                                    anchors.centerIn: parent
                                                    Button{
                                                        Layout.preferredWidth: 30
                                                        Layout.preferredHeight: 30
                                                        background: Rectangle {
                                                            radius: 15 // 设置圆角大小
                                                            color: control.pressed ? "red" : "lightblue"
                                                            border.color: "blue"
                                                            border.width: 1
                                                            anchors.fill: parent
                                                        }
                                                        text: "1"
                                                    }
                                                    Button{
                                                        Layout.preferredWidth: 30
                                                        Layout.preferredHeight: 30
                                                        background: Rectangle {
                                                            radius: 15 // 设置圆角大小
                                                            color: control.pressed ? "red" : "lightblue"
                                                            border.color: "blue"
                                                            border.width: 1
                                                            anchors.fill: parent
                                                        }
                                                        text: "2"
                                                    }
                                                    Button{
                                                        Layout.preferredWidth: 30
                                                        Layout.preferredHeight: 30
                                                        background: Rectangle {
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
                                                        background: Rectangle {
                                                            radius: 15 // 设置圆角大小
                                                            color: control.pressed ? "red" : "lightblue"
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

                            }
                            //preview video frame
                            Rectangle {
                                anchors.left: left_column.right
                                anchors.top: left_column.top
                                height: parent.height
                                width: parent.width - 306
                                color: "#2c2a38"
                                anchors.margins: 3
                                // border.color: "#aaaaaf"
                                radius: 5
                                GridLayout {
                                    rows: 4
                                    columns: 4
                                    height: parent.height
                                    width: parent.width
                                    anchors.fill: parent
                                    anchors.margins: 3
                                    Repeater {
                                        model: 16 // 创建 16 个子项
                                        Rectangle {
                                            Layout.preferredWidth: parent.width/4 - 6
                                            Layout.preferredHeight: parent.height/4 -3
                                            color: "#42424e"
                                            radius: 5
                                            VideoFrameChild{
                                                //                            width: 320
                                                //                            height: 240
                                            }

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
                        anchors.fill: parent
                        VideoOutput {
                            id: video_outputs
                            anchors.fill: parent
                            source: _provider
                        }
                        Timer{
                            id: myTimer
                            interval: 800
                            running: true
                            repeat: true

                            onTriggered: {
                                _provider.test();
                            }
                        }
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
