import QtQuick 2.14
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.14
import QtMultimedia 5.14

Page {

    ColumnLayout {
        anchors { fill: parent }

        Label {
            text: "Ring Doorbell"
        }

        Video {
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: "qrc:/res/security"
            loops: MediaPlayer.Infinite

            Component.onCompleted: play()

            MouseArea {
                anchors { fill: parent }
                drag.target: parent

                onWheel: {
                    var wheelUp = wheel.angleDelta.y > 0
                    parent.scale += wheelUp ? 0.1 : -0.1
                }
            }
        }
    }
}
