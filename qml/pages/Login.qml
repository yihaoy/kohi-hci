import QtQuick 2.14
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.14

import "../components"

import Koti 1.0

Page {
    id: page

    ColumnLayout {
        anchors { centerIn: parent }
        spacing: 40

        Image {
            Layout.fillWidth: true
            fillMode: Image.PreserveAspectFit
            source: "qrc:/res/welcome"
        }

        KotiLabel {
            Layout.alignment: Qt.AlignHCenter
            state: "h1"
            text: "Sign In"
        }

        ColumnLayout {
            Layout.fillWidth: false
            Layout.leftMargin: 32
            Layout.rightMargin: 32
            Layout.alignment: Qt.AlignHCenter
            spacing: parent.spacing

            RowLayout {
                spacing: 16

                KotiLabel {
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignRight
                    state: "h3"
                    text: "Email"
                }

                TextField {
                    id: emailField
                    Layout.fillWidth: false
                    Layout.preferredWidth: page.width * 0.4
                }
            }

            RowLayout {
                spacing: 16

                KotiLabel {
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignRight
                    state: "h3"
                    text: "Password"
                }

                TextField {
                    id: passwordField
                    Layout.fillWidth: false
                    Layout.preferredWidth: page.width * 0.4
                }
            }
        }

        ColumnLayout {
            Layout.fillWidth: false
            Layout.preferredWidth: parent.width * 0.6
            Layout.alignment: Qt.AlignHCenter
            spacing: 24

            KotiButton {
                Layout.fillWidth: true
                state: "active"
                text: "Sign In"

                onClicked: kotiController.pushPage(KotiPage.Welcome)
            }

            KotiButton {
                enabled: emailField.text && passwordField.text
                Layout.fillWidth: true
                state: "active"
                text: "Register"

                onClicked: kotiController.pushPage(KotiPage.Welcome)
            }
        }
    }
}
