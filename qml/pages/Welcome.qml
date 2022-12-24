import QtQuick 2.14
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.14

import "../components"

import Koti 1.0

Page {

    ColumnLayout {
        anchors { centerIn: parent }
        spacing: 104

        Image {
            Layout.fillWidth: true
            Layout.preferredHeight: sourceSize.height
            fillMode: Image.PreserveAspectFit
            source: "qrc:/res/welcome"
        }

        Label {
            Layout.alignment: Qt.AlignHCenter
            font.pixelSize: 24
            text: "Welcome Home, " + kotiModel.activeUsername + "!"
        }

        ColumnLayout {
            Layout.fillWidth: false
            Layout.preferredWidth: parent.width * 0.6
            Layout.alignment: Qt.AlignHCenter
            spacing: 64

            KotiButton {
                Layout.fillWidth: true
                state: "active"
                text: "See Devices"

                onClicked: kotiController.pushPage(KotiPage.RingDoorbell)
            }

            KotiButton {
                Layout.fillWidth: true
                state: "available"
                text: "Not You?"

                onClicked: kotiController.popPage(KotiPage.Login)
            }
        }
    }
}
