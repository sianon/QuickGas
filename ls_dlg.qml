import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window{
    id: dialog
    width: 320
    height: 240
    flags: Qt.framelessWindowHint
    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            Text {
                text: "伪彩设置"
                color: "#ffffffff"
            }
        }
        Button {
            text: "反羽红"
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            onClicked: dialog.close()
        }
    }
}
