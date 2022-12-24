import QtQuick 2.14
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.14

import ".."

Item {
    anchors { fill: parent }

    Koti {
        anchors { centerIn: parent }
        width: background.screenWidth
        height: background.screenHeight
        radius: 30
    }

    Image {
        id: background
        anchors { fill: parent }
        fillMode: Image.PreserveAspectFit
        source: "../res/iPhone"

        property int screenWidth: 614 * xRatio
        property int screenHeight: 1330 * yRatio

        property real xRatio: (width / sourceSize.width)
        property real yRatio: (height / sourceSize.height)

        MouseArea {
            width: parent.width
            height: parent.height * 0.10

            property point lastMouse

            onPressed: lastMouse = Qt.point(mouse.x, mouse.y)

            onPositionChanged: {
                window.x += (mouse.x - lastMouse.x)
                window.y += (mouse.y - lastMouse.y)
            }
        }
    }
}
