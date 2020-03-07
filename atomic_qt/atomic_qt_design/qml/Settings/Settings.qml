import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0
import "../Components"
import "../Constants"

Item {
    function disconnect() {
        API.get().disconnect()
        onDisconnect()
    }

    function reset() {

    }

    property var languages: (["USD", "EUR"])

    ColumnLayout {
        anchors.centerIn: parent
        DefaultText {
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: Style.textSize2
            text: qsTr("Settings")
        }

        Rectangle {
            color: Style.colorTheme7
            radius: Style.rectangleCornerRadius

            Layout.alignment: Qt.AlignHCenter

            width: layout.childrenRect.width + layout.anchors.leftMargin * 2
            height: layout.childrenRect.height + layout.anchors.topMargin * 2

            ColumnLayout {
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.top: parent.top
                anchors.topMargin: anchors.leftMargin
                id: layout

                ComboBoxWithTitle {
                    id: combo_lang
                    title: qsTr("Fiat")
                    Layout.fillWidth: true

                    field.model: languages
                    field.onCurrentIndexChanged: {
                        API.get().fiat = languages[field.currentIndex]
                    }
                    Component.onCompleted: {
                        field.currentIndex = languages.indexOf(API.get().fiat)
                    }
                }

                HorizontalLine {
                    Layout.fillWidth: true
                }

                DangerButton {
                    text: qsTr("Delete Wallet")
                    Layout.fillWidth: true
                    onClicked: {
                        API.get().delete_wallet(API.get().wallet_default_name)
                        disconnect()
                    }
                }

                DefaultButton {
                    Layout.fillWidth: true
                    text: qsTr("Log out")
                    onClicked: disconnect()
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
