import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog{
    id: dialog
    modal: true
    width: 200
    height: 150

    background:Rectangle {
        color: "#1e2129"
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 15
        RadioButton {
            text: TestObject.getAuthor
            checked: true
            onCheckedChanged: {
                if (checked) {
                    console.log("Group 1, Option 1 selected");
                }
            }
        }
        RadioButton {
            text: "Group 1, Option 2"
            onCheckedChanged: {
                if (checked) {
                    console.log("Group 1, Option 2 selected");
                }
            }
        }
        RadioButton {
            text: "Group 2, Option 1"
            onCheckedChanged: {
                if (checked) {
                    console.log("Group 2, Option 1 selected");
                }
            }
        }
        RadioButton {
            text: "Group 2, Option 2"
            onCheckedChanged: {
                if (checked) {
                    console.log("Group 2, Option 2 selected");
                }
            }
        }
    }
}
