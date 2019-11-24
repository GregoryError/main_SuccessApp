import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Dialogs 1.3

Item {
    id: issueItem_3
    FontLoader { id: openSansCondensed; source: "/fonts/openSansCondensed_Light.ttf" }


    MessageDialog {
        id: messageDialog
        title: "Ваше обращение передано!"
        text: "Спасибо за Ваше обращение."
        onAccepted: {
            stackView.pop();
            stackView.pop();
            stackView.pop();
        }
        visible: false
    }

    Rectangle{
        id: backRect
        anchors.fill: parent
        color: "#e6f8ff"

        Component.onCompleted: focus = true;
        Image {
            id: backGroundTP
            source: "qrc:/trustedBack.png"
            width: backRect.width
            height: backRect.height
            opacity: 0.8
        }

        Text {
            id: mainHeader
            horizontalAlignment: Text.AlignHCenter
            font.family: openSansCondensed.name;
            width: backRect.width * 0.8
            font.pointSize: 24
            minimumPointSize: 10
            fontSizeMode: Text.Fit
            color: "#f7f7f7"
            anchors.topMargin: 10
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Если считаете нужным,<br>дополнительно добавьте описание проблемы."
        }

        TextArea {
            id: userDesc
            width: parent.width * 0.8
            height: width * 0.4 - 5

            anchors.top: mainHeader.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: mainHeader.horizontalCenter
            placeholderText: "Описание (необязательно)..."
            font.italic: true
            font.pixelSize: 18
            wrapMode: TextEdit.Wrap

            background: Rectangle{
                color: "#fefefe"
                anchors.fill: parent
                radius: 4
            }

        }


        Rectangle {
            id: forwardButton
            width: parent.width * 0.6
            height: 80
            clip: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: userDesc.bottom
            anchors.topMargin: 10
            radius: 7
            opacity: telInput.text.length >= 12 ? 1 : 0.5
            color: "white"

            Text {
                anchors.centerIn: parent
                font.pointSize: 20
                text: "ГОТОВО"
            }


            Rectangle {
                id: toolButtoncolorRect
                height: 0
                width: 0
                color: "#0074e4"

                transform: Translate {
                    x: -toolButtoncolorRect.width / 2
                    y: -toolButtoncolorRect.height / 2
                }
            }

            MouseArea{
                id: toolButton
                anchors.fill: parent
                enabled: telInput.text.length >= 12 ? true : false
                onPressed: {
                    //                    telInput.cursorPosition = 2
                    //                    telInput.focus = true


                    toolButtoncolorRect.x = mouseX
                    toolButtoncolorRect.y = mouseY
                    toolButtoncircleAnimation.start()
                    toolButtonOpacityAnimation.start()
                }
            }
        }

        PropertyAnimation {
            id: toolButtoncircleAnimation
            target: toolButtoncolorRect
            properties: "width,height,radius"
            from: 0
            to: forwardButton.width * 5
            duration: 700

            onStopped: {
                toolButtoncolorRect.width = 0
                toolButtoncolorRect.height = 0
                if (userDesc.text.length > 1)
                myClient.addNextIssuePart("   - Дополнительная информация о проблеме: " + userDesc.text)
                else myClient.addNextIssuePart("   - Дополнительная информация о проблеме не предоставлена.")
               // stackView.push("homePage.qml");
                myClient.sendIssueMsg();
                messageDialog.visible = true

            }
        }
        PropertyAnimation {
            id: toolButtonOpacityAnimation
            target: toolButtoncolorRect
            properties: "opacity"
            from: 1
            to: 0
            duration: 450

        }

    }


}
