import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow{
    id: dialog
//    modal: true
    width: 200
    height: 150
    x: 500
    y: 502
    background:Rectangle {
        color: "#1e2129"
    }
    GridLayout {
        anchors.fill: parent
        columns: 4
        width: dialog.width
        height: dialog.height
        Rectangle {
//            Layout.columnSpan: 4
//            anchors.left: parent.left
            Layout.fillWidth: true
            Layout.preferredHeight: 10
            Text {
                text: "伪彩设置"
                color: "#ffffffff"
            }
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                // 此 Item 是占位布局，不显示内容
            }
            Button {
                height: 10
                anchors.centerIn: dialog.right
                text: "X"
                onClicked: dialog.close()
            }
        }
    }
}
