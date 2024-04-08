import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 5.15
import Local 1.0

Item{
    id: dialog
    anchors.fill: parent
    property var global_pro: ""
    property var url_rtsp: ""
    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 1
        spacing: 0
        Rectangle{
            id: top_status
            Layout.alignment: Qt.AlignRight
            Layout.preferredHeight: 23
            Layout.fillWidth: true
            color: "#42424e"
            radius: 6
            Label{
                anchors.centerIn: parent
                font.pixelSize: 16
                rightPadding: 6
                color: "#ffffffff"
                text: "1920x1080   60fps"
            }
        }
        //video frame
        Rectangle{
            id: video_frame
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            Layout.fillHeight: true

            FrameProvider{
                id: providers
            }
//            Component.onCompleted:{
//                global_pro = providers.moGetProvider();
//            }
            VideoOutput{
                id: video_outputs
                anchors.fill: parent
                source: providers
            }
            Timer{
                id: myTimer
                interval: 1000 /25
                running: true
                repeat: true

                onTriggered:{
                    providers.mvRanderImage(url_rtsp);
                }
            }
            Timer{
                id: signal_timer
                interval: 1000
                running: true
                repeat: true

                onTriggered:{
                    if(!providers.mbIsNoSignal()) signal_status.text = ""; else signal_status.text = "无信号";
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

        RowLayout{
            Layout.preferredHeight: 23
            Layout.fillWidth: true
            Layout.fillHeight: true
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
