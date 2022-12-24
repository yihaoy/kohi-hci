import QtQuick 2.14
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.14

import Koti 1.0

Rectangle {
    clip: true

    StackView {
        id: stackView
        anchors { fill: parent }

        Component.onCompleted: push(pageItem(kotiModel.activePage))

        function pageItem(page) {
            switch (page) {
            case KotiPage.Login: return "pages/Login.qml"
            case KotiPage.Welcome: return "pages/Welcome.qml"
            case KotiPage.Devices: return "pages/Devices.qml"
            case KotiPage.RingDoorbell: return "pages/RingDoorbell.qml"
            }
        }

        Connections {
            target: kotiController

            function onPushPage(page) { stackView.push(stackView.pageItem(page)) }

            function onPopPage() { stackView.pop() }

            function onReplacePage(page) { stackView.replace(stackView.pageItem(page)) }
        }
    }
}
