import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12


Item {
    id: root
    signal quit()

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: selectProfile
    }

    QtObject {
        id: profile
        property string profile_name: ""
        property string player_name: ""
        property bool gamemaster: false
        property bool hosting: false
        property string address: ""
        property int port: 6660
    }


    Component {
        id: addProfile

        Frame {
            spacing: 10
            ColumnLayout {
               anchors.fill: parent
                GroupBox {
                    id: group
                    title: profile.profile_name
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ColumnLayout {
                        anchors.fill: parent
                        RowLayout {
                            Label {
                                text: "Profile name:"
                            }
                            TextEdit {
                                text: profile.profile_name
                                Layout.fillWidth: true
                            }
                        }

                        GroupBox {
                            id: playerGroup
                            title: "Player"
                            Layout.fillWidth: true

                            ColumnLayout {
                                RowLayout {
                                    Label {
                                        text: "Name:"
                                    }
                                    TextEdit {
                                        text: profile.player_name
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                    }
                                }

                                RowLayout {
                                    Label {
                                        text: "Color:"
                                    }
                                    Rectangle {
                                        color: group.profile.player.color
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                    }
                                }

                                RowLayout {
                                    Label {
                                        text: "I'm the game master:"
                                    }
                                    CheckBox {
                                        checked: profile.gamemaster
                                        onClicked: profile.gamemaster = checked
                                    }
                                }
                            }
                        }

                        GroupBox {
                            id: charactersGroup
                            title: "Characters"
                            visible: !profile.gamemaster
                            Layout.fillWidth: true

                            ColumnLayout {
                                Repeater {
                                    model: ListModel {
                                        ListElement {
                                            name: "Treeman"
                                            color: Qt.green
                                            avatar: "qrc:/resources/images/arbre_square_mini.jpg"
                                        }
                                        ListElement {
                                            name: "Woodman"
                                            color: Qt.red
                                            avatar: "qrc:/resources/images/arbre_square_mini.jpg"
                                        }
                                    }
                                    RowLayout {
                                        Image {
                                            source: avatar
                                            sourceSize.width: 60
                                            sourceSize.height: 60
                                        }
                                        ColumnLayout {
                                            RowLayout {
                                                Label {
                                                    text: "Name:"
                                                }
                                                TextEdit {
                                                    text: name
                                                    Layout.fillWidth: true
                                                    Layout.fillHeight: true
                                                }
                                            }
                                            RowLayout {
                                                Label {
                                                    text: "Color:"
                                                }
                                                Rectangle {
                                                    color: color
                                                    Layout.fillWidth: true
                                                    Layout.fillHeight: true
                                                }
                                            }
                                        }
                                    }
                                }






                            }
                        }

                        GroupBox {
                            id: connectionGroup
                            title: "Connection"
                            Layout.fillWidth: true

                            ColumnLayout {
                                RowLayout {
                                    Label {
                                        text: "Address:"
                                    }
                                    TextEdit {
                                        text: profile.address
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                    }
                                }

                                RowLayout {
                                    Label {
                                        text: "Port:"
                                    }
                                    TextEdit {
                                        text: profile.port
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                    }
                                }

                                RowLayout {
                                    Label {
                                        text: "Password:"
                                    }
                                    TextEdit {
                                        text: group.profile.connection.password
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                    }
                                }
                            }
                        }
                        Item {
                            // hack filler to be replace by alignment.
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        RowLayout {
                            Layout.fillWidth: true
                            Button {
                                text: "Add"
                                onClicked: stack.pop()
                                Layout.fillWidth: true
                            }
                            Button {
                                text: "Cancel"
                                onClicked: stack.pop()
                            }
                        }
                    }
                }
            }
        }
    }


    Component {
        id: profileGM

        Frame {
            spacing: 10
            ColumnLayout {
                anchors.fill: parent
                Label {
                    text: "To do"
                    Layout.fillHeight: true
                }

                RowLayout {
                    Layout.fillWidth: true
                    Button {
                        text: "Disconnect"
                        onClicked: stack.pop()
                    }
                }
            }
        }
    }

    Component {
        id: profilePlayer

        Frame {
            spacing: 10
            ColumnLayout {
                anchors.fill: parent
                Label {
                     Layout.fillHeight: true
                    text: "To do"
                }

                RowLayout {
                    Layout.fillWidth: true
                    Button {
                        text: "Disconnect"
                        onClicked: stack.pop()
                    }
                }
            }
        }
    }

    Component {
        id: selectProfile

        Frame {
            spacing: 10
            ColumnLayout {
                anchors.fill: parent
                ListView {
                    id: listProfile
                    model: ListModel {
                        ListElement {
                            name: "profileGM"
                            page: 0
                        }
                        ListElement {
                            name: "profilePlayer"
                            page: 1
                        }
                    }

                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    property var pageArray: [profileGM, profilePlayer]
                    delegate: Rectangle {
                        color: index % 2 == 0 ? "white" : "gray"
                        width: parent.width
                        height: label.implicitHeight*2 // add margin
                        Label {
                            id: label
                            text: name
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: stack.push(listProfile.pageArray[page])
                        }
                    }
                }

                RowLayout{
                    Layout.fillWidth: true
                    Button {
                        text: "Add Profile"
                        onClicked: stack.push(addProfile)
                        Layout.fillWidth: true
                    }
                    Button {
                        text: "Remove Profile"
                    }
                    Button {
                        text: "Quit"
                        onClicked: root.quit()

                    }
                }
            }
        }
    }





}
