import QtQuick 2.14
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.14

Label {
    id: label

    states: [
        State {
            name: "h1"
            PropertyChanges { target: label; font.pixelSize: 24 }
        },
        State {
            name: "h2"
            PropertyChanges { target: label; font.pixelSize: 20 }
        },
        State {
            name: "h3"
            PropertyChanges { target: label; font.pixelSize: 18 }
        },
        State {
            name: "h4"
            PropertyChanges { target: label; font.pixelSize: 16 }
        }
    ]
}

