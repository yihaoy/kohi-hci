import QtQuick 2.14
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.14
import QtQuick.Window 2.14

import "pages"

Window {
    id: window
    visible: true
    flags: kotiController.desktopMode ? Qt.Window : Qt.SplashScreen
    width: kotiController.desktopMode ? 1366 : 524
    height: kotiController.desktopMode ? 768 : 1000
    title: qsTr("Koti")
    color: "transparent"

    Shortcut { sequence: "X"; onActivated: kotiController.desktopMode = !kotiController.desktopMode }

    Loader {
        id: loader
        anchors { fill: parent }
        source: kotiController.desktopMode ? "Koti.qml" : "KotiMobile.qml"
    }
}
