import QtQuick 2.14
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.14
import QtGraphicalEffects 1.15

Button {
    Layout.preferredHeight: 48
    opacity: enabled ? 1 : 0.5
    font.pixelSize: 20
    state: "active"

    readonly property color blue: "#2B80FF"
    readonly property color green: "#2BFF59"
    readonly property color lightBlue: "#B8D4FF"

    states: [
        State {
            name: "available"
            PropertyChanges { target: background; color: down ? Qt.lighter(lightBlue, 1.2) : lightBlue }
        },
        State {
            name: "active"
            PropertyChanges { target: background; color: down ? Qt.lighter(blue, 1.2) : blue }
            PropertyChanges { target: contentItem; color: "white" }
        },
        State {
            name: "hinted"
            PropertyChanges { target: background; color: down ? Qt.lighter(green, 1.2) : green }
            PropertyChanges { target: contentItem; color: "white" }
        }
    ]

    background: Item {

        Rectangle {
            id: background
            anchors { fill: parent }
            radius: height / 2
        }

        DropShadow {
            visible: enabled
            anchors { fill: background }
            horizontalOffset: 0
            verticalOffset: 3
            radius: 8.0
            samples: 17
            color: "#80000000"
            source: background
        }
    }

    contentItem: KotiLabel {
        id: contentItem
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        text: parent.text
    }
}
