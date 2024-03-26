import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 5.15
import pkg.producer 1.0
import pkg.custom_video_surface 1.0

ApplicationWindow {
    id:mainWindow
    visible: true
    width: 1280
    height: 720
    title: "气体泄漏检测系统"
    color: "#2c2a38"
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
    background: Rectangle {

        // VideoOutput {
        //     id: video_output
        //     anchors.fill: parent
        //     source: _provider
        // }
        // Timer{
        //     id: myTimer
        //     interval: 580 // 每隔一秒触发一次定时器
        //     running: true   // 启动定时器
        //     repeat: true    // 重复执行
        //
        //     onTriggered: {
        //         _provider.test();
        //     }
        // }
    }
    Frame {
        id: main_table_btn
        visible: true
        width: parent.width
        height: 35
        background: Rectangle{
            color: "#42424e"
            //            border.color: "#21be2b"
        }
        // RowLayout{
        //     anchors.horizontalCenter: parent.horizontalCenter
        //     Button {
        //         //                Layout.fillWidth: true
        //         Layout.preferredWidth: 34
        //         Layout.preferredHeight: 34
        //         id:mybutton
        //
        //         onClicked: {
        //             qml_method(123);
        //         }
        //         Image {
        //             anchors.fill: parent  // 图片充满整个 Rectangle 区域
        //             source: "./images/back.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
        //         }
        //     }
        //     Button {
        //         //                Layout.fillWidth: true
        //         Layout.preferredWidth: 34
        //         Layout.preferredHeight: 34
        //         onClicked: {
        //             var component = Qt.createComponent("iso_dlg.qml");
        //             var dialog = component.createObject(mainWindow);
        //             dialog.open();
        //         }
        //         Rectangle {
        //             implicitHeight:parent.height
        //             implicitWidth:parent.height
        //             color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
        //             Image {
        //                 anchors.fill: parent  // 图片充满整个 Rectangle 区域
        //                 source: "./images/iso.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
        //             }
        //         }
        //     }
        //     Button {
        //         id:ls
        //         //                Layout.fillWidth: true
        //         Layout.preferredWidth: 34
        //         Layout.preferredHeight: 34
        //         MouseArea {
        //             anchors.fill: parent
        //             onClicked: {
        //                 // 在点击时创建并显示新窗口
        //                 var component = Qt.createComponent("ls_mode_dlg.qml");
        //                 var dialog = component.createObject(mainWindow);
        //                 dialog.open();
        //             }
        //         }
        //         Rectangle {
        //             implicitHeight:parent.height
        //             implicitWidth:parent.height
        //             color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
        //             Image {
        //                 anchors.fill: parent  // 图片充满整个 Rectangle 区域
        //                 source: "./images/ls.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
        //             }
        //         }
        //     }
        //     Button {
        //         Layout.preferredWidth: 34
        //         Layout.preferredHeight: 34
        //         onClicked: {
        //             // 在点击时创建并显示新窗口
        //             var component = Qt.createComponent("ls_dlg.qml");
        //             var dialog = component.createObject(mainWindow);
        //             dialog.open();
        //         }
        //         Rectangle {
        //             implicitHeight:parent.height
        //             implicitWidth:parent.height
        //             color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
        //             Image {
        //                 anchors.fill: parent  // 图片充满整个 Rectangle 区域
        //                 source: "./images/color.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
        //             }
        //         }
        //     }
        //     Button {
        //         Layout.preferredWidth: 34
        //         Layout.preferredHeight: 34
        //         onClicked: {
        //             var component = Qt.createComponent("param_dlg.qml");
        //             var dialog = component.createObject(mainWindow);
        //             dialog.open();
        //         }
        //         Rectangle {
        //             implicitHeight:parent.height
        //             implicitWidth:parent.height
        //             color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
        //             Image {
        //                 anchors.fill: parent  // 图片充满整个 Rectangle 区域
        //                 source: "./images/param.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
        //             }
        //         }
        //     }
        //     Button {
        //         Layout.preferredWidth: 34
        //         Layout.preferredHeight: 34
        //         onClicked: {
        //             var component = Qt.createComponent("param_dlg.qml");
        //             var dialog = component.createObject(mainWindow);
        //             dialog.open();
        //         }
        //         Rectangle {
        //             implicitHeight:parent.height
        //             implicitWidth:parent.height
        //             color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
        //             Image {
        //                 anchors.fill: parent  // 图片充满整个 Rectangle 区域
        //                 source: "./images/settings.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
        //             }
        //         }
        //     }
        //     ColumnLayout{
        //         Timer {
        //             id: timer
        //             interval: 1000  // 更新间隔为 1000 毫秒 (1 秒)
        //             running: true
        //             repeat: true
        //             onTriggered: updateTime()
        //
        //             function padZero(value) {
        //                 return (value < 10) ? "0" + value : value;
        //             }
        //             function updateTime() {
        //                 var currentDate = new Date();
        //                 var hours = currentDate.getHours();
        //                 var minutes = currentDate.getMinutes();
        //                 var seconds = currentDate.getSeconds();
        //
        //                 var formattedTime = padZero(hours) + ":" + padZero(minutes) + ":" + padZero(seconds);
        //                 timeLabel.text = formattedTime;
        //                 // 通过Qt调用UI线程更新Text元素的文本
        //                 //                        Qt.callLater(function() {
        //                 //                            timeLabel.text = + formattedTime;
        //                 //                        });
        //             }
        //         }
        //
        //         Text{
        //             id:timeLabel
        //             text: ""
        //             font.pixelSize: 8
        //             color: "#ffffff"
        //         }
        //     }
        // }
    }
    Pane {
        id: floating_subcontrol_mid
        visible: true
        height: 65
        Layout.fillWidth: true
        anchors.left: floating_subcontrol_left.right
        anchors.bottom: floating_subcontrol_left.bottom

        background: Rectangle{
            color: "transparent"
        }
        RowLayout{
            id:grid_right
            Layout.fillWidth: true
            Layout.fillHeight: true
            anchors.horizontalCenter: parent.horizontalCenter
            ColumnLayout{
                Label{
                    text: "辐射率：1.00"
                    font.pixelSize: 8
                }
                Label{
                    text: "距离：1.00"
                    font.pixelSize: 8
                }
                Label{
                    text: "环境湿度：25.0°C"
                    font.pixelSize: 8
                }
            }

            Button {
                Layout.fillWidth: true
                Layout.preferredWidth: 44
                Layout.preferredHeight: 44
                onClicked: {
                    var component = Qt.createComponent("gas_enhance_dlg.qml");
                    var dialog = component.createObject(mainWindow);
                    dialog.open();
                }
                text: "增强"
            }
            Button {
                Layout.fillWidth: true
                Layout.preferredWidth: 44
                Layout.preferredHeight: 44
                onClicked: {
                    qml_method(123);
                }
                text: "曝光"
            }
            Button {
                Layout.fillWidth: true
                Layout.preferredWidth: 44
                Layout.preferredHeight: 44
                onClicked: {
                    qml_method(123);
                }
                text: "锁定"
            }
            Button {
                Layout.fillWidth: true
                Layout.preferredWidth: 44
                Layout.preferredHeight: 44
                onClicked: {
                    qml_method(123);
                }
                text: "激光"
            }
        }
    }
    Pane {
        id: main_status_bottom
        visible: true
        width: parent.width
        height: 28
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        leftPadding: 0 // 左内边距
        rightPadding: 0 // 右内边距
        topPadding: 0 // 上内边距
        bottomPadding: 0 // 下内边距

        RowLayout{
            Rectangle {
                width: parent.width
                height: parent.height
                color: "#2c2a38" // 设置背景色
            }
            id:row_layout_status_bottom
            Layout.fillWidth: true
            Layout.fillHeight: true
            anchors.fill: parent
            // spacing: 10
            Image {
                Layout.fillHeight: true
                Layout.preferredWidth: 23
                Layout.preferredHeight: 23
                // Image {
                //     // anchors.fill: parent  // 图片充满整个 Rectangle 区域
                //     source: "./images/take_shot.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                // }
            }
            Item { // 占位符
                width: 10
            }
            Text {
                // Layout.preferredWidth: 23
                // Layout.preferredHeight: 23
                text: "西南服务器:"
                color: "white"
                font.pixelSize: 12
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            }
            Text {
                Layout.preferredWidth: 23
                Layout.preferredHeight: 23
                text: "已连接"
                color: "white"
                font.pixelSize: 12
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            }
            // Item { // 占位符
            //     Layout.fillWidth: true
            // }
            Text {
                Layout.preferredWidth: 23
                Layout.preferredHeight: 23
                color: "white"
                text: "处理器:"
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
                        width: 50
                        height: parent.height
                        radius: 4
                        color: "#17a81a"
                    }
                }
            }
            Text {

                Layout.preferredWidth: 40
                Layout.preferredHeight: 23
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
                        width: 50
                        height: parent.height
                        radius: 4
                        color: "#17a81a"
                    }
                }
            }
            Text {
                width: 40
                Layout.preferredHeight: 23
                color: "white"
                text: "硬盘:"
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
                        width: 50
                        height: parent.height
                        radius: 4
                        color: "#17a81a"
                    }
                }
            }
            Text {

                width: 40
                Layout.preferredHeight: 23
                color: "white"
                text: "网络:"
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
                        width: 50
                        height: parent.height
                        radius: 4
                        color: "#17a81a"
                    }
                }
            }

        }
    }
}
