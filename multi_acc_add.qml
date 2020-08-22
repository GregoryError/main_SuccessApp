import QtQuick 2.9
import QtQuick.Controls 2.2


Item {

    Connections {
        target: myClient
        onGoodValidation: {
            console.log("goodValidation emited")
            if (myClient.addAccaunt(nameInput.text, passwordInput.text))
                myClient.refreshAccList();
            else
                console.log("trying to add duplicate")

            stackView.pop();
        }
        onAccessDenied: {
            addBtn.text = "Неверная Авторизация!";
            addBtn.font.bold = true;
            deniedTimer.start();
        }
    }

    Timer {
        id: deniedTimer
        running: false
        interval: 2500

        onTriggered: {
            addBtn.text = "Добавить"
            addBtn.font.bold = false;
        }
    }

    Image {
        id: backGroundMA
        source: "qrc:/Menu/start_back.png"
        anchors.fill: parent
    }

    Rectangle {
        id: startform
        color: "transparent"
        width: window.width * 0.6
        height: window.height * 0.5
        anchors.top: backGroundMA.top
        anchors.horizontalCenter: backGroundMA.horizontalCenter
        anchors.topMargin: 30

        OpacityAnimator {
            id: appearstartform
            target: mainStartForm;
            from: 0;
            to: 1;
            duration: 1500
            running: myClient.isAuth()? false : true
            easing.type: Easing.InOutExpo
            onStarted: {
                mainStartForm.visible = true
                startform.visible = true
                nameInput.enabled = true
                passwordInput.enabled = true
            }
        }

        OpacityAnimator {
            id: disappearStartForm
            target: mainStartForm;
            from: 1;
            to: 0;
            duration: 1000
            running: false
            easing.type: Easing.InOutExpo

            onStopped: {
                mainStartForm.visible = false
                startform.visible = false
                nameInput.enabled = false
                passwordInput.enabled = false
            }
        }


        Column {
            anchors.horizontalCenter: startform.horizontalCenter
            Column {
                id: nameField
                TextField{
                    id: nameInput
                    maximumLength: 20
                    implicitWidth: startform.width - 20
                    implicitHeight: startform.height / 5
                    inputMethodHints: Qt.ImhPreferLowercase |
                                      Qt.ImhNoAutoUppercase |
                                      Qt.ImhNoPredictiveText
                    horizontalAlignment: TextInput.AlignHCenter
                    font.bold: true

                    background: Rectangle {
                        opacity: 0
                        anchors.centerIn: parent


                    }

                    onAccepted: passwordInput.forceActiveFocus()
                    color: "#606470"
                    font.pointSize: nameInput.width  * 0.1
                    placeholderText: "Имя"
                    KeyNavigation.tab: passwordInput

                    Rectangle{
                        id: nameLine
                        height: 1
                        width: nameInput.width
                        anchors.top: nameInput.bottom
                        anchors.topMargin: -nameInput.height / 4
                        color: "#606470"
                    }
                }
            }

            Column {
                spacing: 4

                TextField {
                    id: passwordInput
                    anchors.top: nameLine.bottom
                    anchors.horizontalCenter: nameLine.horizontalCenter
                    anchors.topMargin: -10
                    implicitWidth: startform.width - 20
                    implicitHeight: startform.height / 5
                    maximumLength: 20
                    echoMode: TextInput.Password
                    inputMethodHints: Qt.ImhPreferLowercase |
                                      Qt.ImhNoAutoUppercase |
                                      Qt.ImhNoPredictiveText
                    horizontalAlignment: TextInput.AlignHCenter
                    font.bold: true

                    background: Rectangle {
                        opacity: 0
                        anchors.centerIn: parent

                    }
                    onAccepted: login()
                    color: "#606470"
                    font.pointSize: nameInput.width  * 0.1
                    //    font.family: openSansCondensed.name;
                    placeholderText: "Пароль"
                    KeyNavigation.tab: loginButton


                    Image {
                        id: eyeImg
                        opacity: 0.7
                        fillMode: Image.PreserveAspectFit
                        anchors.left: passwordInput.right
                        anchors.verticalCenter: passwordInput.verticalCenter
                        anchors.leftMargin: 4
                        height: passwordInput.height * 0.5
                        source: "qrc:/Menu/eye.png"
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                passwordInput.echoMode === TextInput.Password ? passwordInput.echoMode = TextInput.Normal : passwordInput.echoMode = TextInput.Password
                            }
                        }
                    }

                    Rectangle{
                        id: passLine
                        height: 1
                        width: passwordInput.width
                        anchors.top: passwordInput.bottom
                        anchors.topMargin: -nameInput.height / 4
                        color: "#606470"
                    }
                }
            }

            Column {
                spacing: 14
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    id: loginButton
                    color: "#1d242b"
                    radius: 5

                    clip: true

                    implicitWidth: startform.width - 20
                    implicitHeight: startform.height / 5 - 15
                    Text{
                        id: addBtn
                        anchors.centerIn: parent
                        color: "white"
                        font.pointSize: loginButton.width  * 0.1
                        font.family: openSansCondensed.name;
                        text: "Добавить";
                    }


                    Rectangle {
                        id: loginButtoncolorRect
                        height: 10
                        width: 10
                        visible: false
                        color: "#f7f7f7"

                        transform: Translate {
                            x: -loginButtoncolorRect.width / 2
                            y: -loginButtoncolorRect.height  / 2
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (passwordInput.text.length > 0 && nameInput.text.length > 0)
                            {
                                Qt.inputMethod.hide();
                                bigbusy.running = true
                                loginButtoncolorRect.x = mouseX
                                loginButtoncolorRect.y = mouseY
                                loginButtoncircleAnimation.start()
                                loginButtonOpacityAnimation.start()
                            }
                        }
                    }

                    PropertyAnimation {
                        id: loginButtoncircleAnimation
                        target: loginButtoncolorRect
                        properties: "width,height,radius"
                        from: loginButtoncolorRect.width
                        to: loginButton.width * 2
                        duration: 700

                        onStarted: {
                            loginButtoncolorRect.visible = true
                        }

                        onStopped: {
                            loginButtoncolorRect.width = 10
                            loginButtoncolorRect.height = 10
                            loginButtoncolorRect.visible = false
                            myClient.accauntValidation(nameInput.text, passwordInput.text)
                            myClient.busyOFF();
                        }
                    }

                    PropertyAnimation {
                        id: loginButtonOpacityAnimation
                        target: loginButtoncolorRect
                        properties: "opacity"
                        from: 1
                        to: 0
                        duration: 300

                    }
                }
            }
        }
    }
}





















