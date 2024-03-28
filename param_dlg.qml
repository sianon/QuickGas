import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog{
    id: dialog
    modal: true
    width: 200
    height: 150
    x: 100
    y: 100
    background:Rectangle {
        color: "#1e2129"
    }
    GridLayout {
        anchors.centerIn: parent
        columns: 2
        Text {
            id: first_val
            Layout.preferredWidth: 40
            text: "val:" + slider_1.value
            color: "#ffffffff"
        }
        Slider {
            id:slider_1
            width: 100
            from: 0
            to: 100
            value: 50
            stepSize: 1
            onValueChanged: {
                console.log("Slider value:", value);
                first_val.text = "val:" + value.toFixed(0)
            }
        }
        Text {
            id: second_val
            Layout.preferredWidth: 40
            text: "val:" + slider_2.value
            color: "#ffffffff"
        }
        Slider {
            id:slider_2
            width: 100
            from: 0
            to: 100
            value: 50
            onValueChanged: {
                console.log("Slider value:", value);
                second_val.text = "val:" + value.toFixed(0)
            }
        }
        Text {
            id: third_val
            Layout.preferredWidth: 40
            text: "val:" + slider_3.value
            color: "#ffffffff"
        }
        Slider {
            id:slider_3
            width: 100
            from: 0
            to: 100
            value: 50
            onValueChanged: {
                console.log("Slider value:", value);
                third_val.text = "val:" + value.toFixed(0)
            }
        }
        Text {
            id: four_val
            Layout.preferredWidth: 40
            text: "val:" + slider_4.value
            color: "#ffffffff"
        }
        Slider {
            id:slider_4
            width: 100
            from: 0
            to: 100
            value: 50
            onValueChanged: {
                console.log("Slider value:", value);
                four_val.text = "val:" + value.toFixed(0)
            }
        }
    }
}
