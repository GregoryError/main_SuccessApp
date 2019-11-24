import QtQuick 2.3



Item {
    id: issueItem_2
    FontLoader { id: openSansCondensed; source: "/fonts/openSansCondensed_Light.ttf" }

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
            font.pointSize: 24
            minimumPointSize: 8
            fontSizeMode: Text.Fit
            color: "#f7f7f7"
            anchors.topMargin: 20
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Пожалуйста, укажите актуальный<br>контактный номер телефона:"
        }

        Rectangle {
            id: telRect
            anchors.top: mainHeader.bottom
            anchors.topMargin: 15
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            height: 50
            width: parent.width * 0.8
            radius: 3
            clip: true

            TextInput {
                id: telInput
                //anchors.fill: parent
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width
                height: parent.height * 0.8
                font.pointSize: 28
                font.bold: true
                horizontalAlignment: TextInput.AlignHCenter
                inputMethodHints: Qt.ImhDigitsOnly
                selectionColor: "#236cb1"
                selectedTextColor: "#ffffff"
                maximumLength: 10
                inputMask: "+7(000) 000-00-00"
                cursorVisible: false
                cursorDelegate: Rectangle {
                    width: 0
                    height: 0
                }

                Component.onCompleted: {
                    telInput.forceActiveFocus();
                    telRectcircleAnimation.start();
                    telRectOpacityAnimation.start();
                }

            }


            Rectangle {
                id: telRectcolorRect
                height: 0
                width: 0
                color: "#0074e4"
                y: telRect.y + telRect.height * 0.5
                x: telRect.x + telRect.width * 0.5
                transform: Translate {
                    x: -telRectcolorRect.width / 2
                    y: -telRectcolorRect.height / 2
                }
            }

            PropertyAnimation {
                id: telRectcircleAnimation
                target: telRectcolorRect
                properties: "width,height,radius"
                from: 0
                to: telRect.width * 4
                duration: 1500

                onStopped: {
                    telRectcolorRect.width = 0
                    telRectcolorRect.height = 0

                    telInput.focus = true
                    telInput.cursorPosition = 2

                }
            }
            PropertyAnimation {
                id: telRectOpacityAnimation
                target: telRectcolorRect
                properties: "opacity"
                from: 1
                to: 0
                duration: 600

            }


        }

        Text {
            id: bottomTxt
            anchors.top: telRect.bottom
            anchors.topMargin: 15
            horizontalAlignment: Text.AlignHCenter
            font.family: openSansCondensed.name;
            font.pointSize: 24
            minimumPointSize: 8
            fontSizeMode: Text.Fit
            color: "#f7f7f7"
            anchors.horizontalCenter: parent.horizontalCenter
            text: "С Вами свяжется первый<br>освободившийся сотрудник!"

        }

        Rectangle {
            id: forwardButton
            width: parent.width * 0.6
            height: 80
            clip: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: bottomTxt.bottom
            anchors.topMargin: 20
            radius: 7
            opacity: telInput.text.length >= 12 ? 1 : 0.5
            color: "white"

            Text {
                anchors.centerIn: parent
                font.pointSize: 20
                text: "ДАЛЕЕ"
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
                myClient.addNextIssuePart("Мой контактный номер:         " + telInput.text)
                stackView.push("issue_report_2.qml");

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
















