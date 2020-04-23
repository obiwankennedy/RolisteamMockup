import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.14

ApplicationWindow {
    id: window
    visible: true
    width: 540
    height: 1120
    title: qsTr("Rolisteam Workflow")

    Rolisteam {
        anchors.fill: parent
        onQuit: window.close()
    }

}
