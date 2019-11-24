import QtQuick 2.9
import QtQuick.Controls 2.2
//import QtQuick 2.11

import QtGraphicalEffects 1.0
import QtQuick.Window 2.3

import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.11





ApplicationWindow {
    id: window
    visible: true


    Component.onCompleted: {
        console.log("Screen data: " + Screen.desktopAvailableHeight);
        console.log("Screen height: " + Screen.height);

    }

    //height: Screen.desktopAvailableHeight
    //width: Screen.desktopAvailableWidth

    // width: 540
    // height: 960
    // width: 430
    // height: 850
    // width: 1080
    // height: 1920
    //    width: Screen.width
    //    height: Screen.height

    FontLoader { id: openSansCondensed; source: "/fonts/openSansCondensed_Light.ttf"; onStatusChanged: if (loader.status === FontLoader.Ready) console.log('Loaded') }


    Rectangle {
        id: user_value_rect
        z: 7
        width: Screen.width
        height: Screen.height
        anchors.fill: parent
        color: "black"
        visible: false
        opacity: 0
        Image {
            id: stars
            source: "qrc:/icons/5stars.png"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            fillMode: Image.PreserveAspectFit
            width: parent.width * 0.7

        }

        Rectangle {
            id: user_val_box
            width: window.width * 0.7
            z: 8
            anchors.top: stars.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 20
            height: user_val_box_txt.paintedHeight + button_row_box.height + 35
            color: "white"
            radius: 3
            Text {
                id: user_val_box_txt
                text: "Нет времени объяснять,<br>
                      пожалуйста, оцените приложение!"
                font.bold: true
                font.family: openSansCondensed.name
                color: "black"
                horizontalAlignment: Text.AlignHCenter
                width: parent.width - 10
                minimumPointSize: 8
                font.pointSize: 20
                fontSizeMode: Text.Fit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 12

            }

            Row {
                id: button_row_box
                width: user_val_box.width
                height: 40
                anchors.top: user_val_box_txt.bottom
                anchors.topMargin: 12
                anchors.horizontalCenter: user_val_box.horizontalCenter
                spacing: 5

                Button {
                    text: "Позже"
                    width: user_val_box.width / 3 - 5
                    onClicked: {
                        val_wnd_anim_off.start()
                    }

                }
                Button {
                    text: "Нет"
                    width: user_val_box.width / 3 - 5
                    onClicked: {
                        val_wnd_anim_off.start()
                        myClient.set_Show_Val_toFalse();
                    }
                }
                Button {
                    text: "Оценить"
                    width: user_val_box.width / 3 - 5
                    onClicked: {
                        val_wnd_anim_off.start()
                        myClient.set_Show_Val_toFalse();
                        BackEnd.goValue();
                    }
                }
            }





        }
    }

    OpacityAnimator {
        id: val_wnd_anim_on
        target: user_value_rect
        from: 0
        to: 0.9
        duration: 400
        onStarted: user_value_rect.visible = true
        running: false
    }

    OpacityAnimator {
        id: val_wnd_anim_off
        target: user_value_rect
        from: 0.9
        to: 0
        duration: 100
        onStopped: user_value_rect.visible = false
        running: false
    }


    Rectangle{
        id: startHead
        visible: myClient.isAuth() ? false : true
        width: window.width
        height: 66
        x: 0
        y: 0
        color: "#1d242b"
        //color: "#212121"
        Image {
            id: startlogo
            source: "qrc:/RotatingLogo.png"
            smooth: true
            scale: 0.4
            anchors.horizontalCenter: startHead.horizontalCenter
            anchors.verticalCenter: startHead.verticalCenter

        }
    }

    Rectangle{
        id: mainStartForm
        anchors.top: startHead.bottom
        anchors.horizontalCenter: window.horizontalCenter
        width: Screen.desktopAvailableWidth //window.width
        height: /*window.height*/ Screen.desktopAvailableHeight - startHead.height
        visible: myClient.isAuth()? false : true
        opacity: 0

        //width: Screen.desktopAvailableWidth
        //height: Screen.desktopAvailableHeight


        Image {
            id: start_back
            anchors.top: mainStartForm.top
            anchors.horizontalCenter: mainStartForm.horizontalCenter
            width: mainStartForm.width
            //height: mainStartForm.height
            fillMode: Image.PreserveAspectFit
            source: "qrc:/Menu/start_back.png"
            opacity: 0.4
        }


        Image {
            id: userLoginImg
            source: "qrc:/user.png"
            width: startform.width * 0.4
            height: width
            anchors.top: mainStartForm.top
            anchors.topMargin: 20
            anchors.horizontalCenter: mainStartForm.horizontalCenter

        }

        Rectangle {
            id: startform
            color: "transparent"
            width: window.width * 0.6
            height: window.height * 0.5
            anchors.top: userLoginImg.bottom
            anchors.horizontalCenter: mainStartForm.horizontalCenter
            anchors.topMargin: -5
            //y:

            // color: "orange"


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
                //anchors.centerIn: parent
                //anchors.topMargin: 50
                anchors.horizontalCenter: startform.horizontalCenter
                //spacing: 5
                Column {
                    id: nameField
                    //spacing: -10
                    TextField{
                        id: nameInput
                        maximumLength: 20
                        implicitWidth: startform.width - 20
                        implicitHeight: startform.height / 5
                        inputMethodHints: Qt.ImhPreferLowercase |
                                          Qt.ImhNoAutoUppercase |
                                          Qt.ImhNoPredictiveText
                        horizontalAlignment: TextInput.AlignHCenter


                        background: Rectangle {
                            opacity: 0
                            anchors.centerIn: parent


                        }

                        onAccepted: passwordInput.forceActiveFocus()
                        color: "#606470"
                        font.pointSize: nameInput.width  * 0.1
                        font.family: openSansCondensed.name;
                        placeholderText: "Имя или л. счет"
                        //  placeholderText: "name"
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

                        background: Rectangle {
                            opacity: 0
                            anchors.centerIn: parent

                        }
                        onAccepted: login()
                        color: "#606470"
                        font.pointSize: nameInput.width  * 0.1
                        font.family: openSansCondensed.name;
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
                            anchors.centerIn: parent
                            color: "white"
                            font.pointSize: loginButton.width  * 0.1
                            font.family: openSansCondensed.name;
                            text: "Войти";
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

                                Qt.inputMethod.hide();

                                bigbusy.running = true

                                loginButtoncolorRect.x = mouseX
                                loginButtoncolorRect.y = mouseY
                                loginButtoncircleAnimation.start()
                                loginButtonOpacityAnimation.start()



                                console.log(nameInput.text, passwordInput.text)

                                //firsttimer.running = true

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
                                myClient.setAuthData(nameInput.text, passwordInput.text);
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

                    //                    Rectangle{
                    //                        id: order
                    //                        radius: 5
                    //                        clip: true
                    //                        color: "#112d4e"


                    //                        implicitWidth: startform.width - 20
                    //                        implicitHeight: startform.height / 5 - 15

                    //                        Text{

                    //                            anchors.centerIn: parent
                    //                            color: "white"
                    //                            font.pointSize: order.width  * 0.1
                    //                            font.family: openSansCondensed.name;
                    //                            text: "Подключиться";
                    //                        }

                    //                        Rectangle {
                    //                            id: ordercolorRect
                    //                            height: 10
                    //                            width: 10
                    //                            visible: false
                    //                            color: "#f7f7f7"

                    //                            transform: Translate {
                    //                                x: -ordercolorRect.width / 2
                    //                                y: -ordercolorRect.height / 2
                    //                            }
                    //                        }

                    //                        MouseArea {
                    //                            anchors.fill: parent
                    //                            onPressed: {

                    //                                Qt.inputMethod.hide();

                    //                                ordercolorRect.x = mouseX
                    //                                ordercolorRect.y = mouseY
                    //                                orderButtonCircleAnimation.start()
                    //                            }


                    //                            onClicked:{
                    //                                //circleAnimation.stop()
                    //                                console.log("guest")
                    //                            }

                    //                        }
                    //                    }


                }
            }
        }
    }


    MessageDialog {
        id: messageDialog
        title: "Вход невозможен"
        onAccepted: {
            // Qt.quit()
        }
        Component.onCompleted: visible = false

    }

    Connections{
        target: myClient
        onSwitchToHomePage: {
            if(myClient.isAuthRight()){
                workItem.visible = true;
                bigbusy.running = false
                disappearStartForm.running = true
                if (myClient.is_Show_Val_Quest()) {
                    val_wnd_anim_on.start()
                    user_val_box.visible = true
                }
                else {
                    user_value_rect.visible = false
                    user_val_box.visible = false
                }
            }else{
                messageDialog.text = myClient.authResult();
                bigbusy.running = false
                messageDialog.visible = true;
            }

        }

        onBusyON:{
            bigbusy.running = true;
        }

        onBusyOFF:{
            bigbusy.running = false;
        }
    }




    //////////////////////////////////////////// END OF START-FORM ///////////////////////////////////////////////




    Item {
        id: workItem
        anchors.fill: parent
        visible: startform.visible? false : true
        enabled: startform.visible? false : true

        // LinearGradient {
        //     id: backGrad
        //     width: window.width
        //     height: window.height * 0.3 + 50
        //     x: 0
        //     y: 0
        //     //visible: false
        //     start: Qt.point(0, 0)
        //     end: Qt.point(window.width, window.width)
        //     gradient: Gradient {
        //         GradientStop { position: 0.0; color: "#93deff" }
        //         GradientStop { position: 0.3; color: "#638AA1" }
        //         GradientStop { position: 0.4; color: "#4B6072" }
        //         GradientStop { position: 0.6; color: "#323643" }
        //         GradientStop { position: 1.0; color: "#212121" }
        //     }


        Image {
            id: backGrad
            source: "qrc:/Menu/backGradImg.png"
            width: window.width
            height: window.height * 0.3 + 50
            x: 0
            y: 0


        }


//        DropShadow {
//            id: backhadow
//            anchors.fill: backGrad
//            cached: true
//            //horizontalOffset: 3
//            verticalOffset: 2
//            radius: 2.0
//            samples: 5
//            color: "#80000000"
//            //smooth: true
//            source: backGrad
//            opacity: 0.4
//        }


        Item{
            id: bar
            x: 0
            y: 0
            width: window.width
            height: 66
            //color: "#323643"
            //opacity: 0
            z: 3
            clip: true


            Image {
                id: logoPic
                source: "qrc:/RotatingLogo.png"
                // smooth: true
                scale: 0.3
                anchors.horizontalCenter: bar.horizontalCenter
                anchors.verticalCenter: bar.verticalCenter

            }


            Rectangle{                     // add background if use "Toolbutton"
                id: toolRect
                anchors.verticalCenter: logoPic.verticalCenter
                color: "transparent"
                radius: 25
                width: toolPic.width * 3.5
                height: toolPic.height * 3.5
                x: 15
                // y: 15
                clip: true
                // smooth: true



                Image {
                    id: toolPic
                    //source: "qrc:/toolPic.png"
                    source: stackView.depth > 1 ? "qrc:/arrow_left.png" : "qrc:/toolPic.png"
                    width: 20
                    height: 15
                    // smooth: true
                    anchors.centerIn: toolRect
                }

                Rectangle {
                    id: toolButtoncolorRect
                    height: 0
                    width: 0
                    anchors.centerIn: toolRect
                    color: "#93deff"

                    transform: Translate {
                        // x: -toolButtoncolorRect.width / 2
                        // y: -toolButtoncolorRect.height / 2
                    }
                }

                MouseArea{
                    id: toolButton
                    anchors.fill: parent
                    onPressed: {

                        //toolButtoncolorRect.x = mouseX
                        //toolButtoncolorRect.y = mouseY
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
                to: toolRect.width * 0.8
                duration: 300

                onStopped: {
                    toolButtoncolorRect.width = 0
                    toolButtoncolorRect.height = 0


                    if (stackView.depth > 1) {
                        stackView.pop()
                    } else {
                        drawer.open()
                    }

                }
            }


            PropertyAnimation {
                id: toolButtonOpacityAnimation
                target: toolButtoncolorRect
                properties: "opacity"
                from: 1
                to: 0
                duration: 300

            }
        }

        Rectangle{
            id: shareRect
            anchors.verticalCenter: logoPic.verticalCenter
            anchors.right: workItem.right
            anchors.rightMargin: 10
            color: "transparent"
            radius: 25
            width: sharePic.width * 3.5
            height: sharePic.height * 3.5
            //x: 40
            // y: 15
            clip: true

            Image {
                id: sharePic
                source: "qrc:/Menu/shareBtn.png"
                width: 18
                height: 18
                anchors.centerIn: shareRect
            }

            Rectangle {
                id: shareButtoncolorRect
                height: 0
                width: 0
                anchors.centerIn: shareRect
                color: "#93deff"

                transform: Translate {
                    // x: -toolButtoncolorRect.width / 2
                    // y: -toolButtoncolorRect.height / 2
                }
            }

            MouseArea{
                id: shareutton
                anchors.fill: parent
                onPressed: {

                    //toolButtoncolorRect.x = mouseX
                    //toolButtoncolorRect.y = mouseY
                    shareButtoncircleAnimation.start()
                    shareButtonOpacityAnimation.start()

                }
            }
        }

        PropertyAnimation {
            id: shareButtoncircleAnimation
            target: shareButtoncolorRect
            properties: "width,height,radius"
            from: 0
            to: shareRect.width * 0.8
            duration: 300

            onStopped: {
                shareButtoncolorRect.width = 0
                shareButtoncolorRect.height = 0
                BackEnd.shareLink();

            }
        }


        PropertyAnimation {
            id: shareButtonOpacityAnimation
            target: shareButtoncolorRect
            properties: "opacity"
            from: 1
            to: 0
            duration: 300
        }


        Drawer {
            id: drawer
            width: window.width * 0.8 + 5
            height: window.height
            dragMargin: 40
            clip: true
            interactive: true
            onClosed: {
                drawLogo.opacity = 0;
            }
            onAboutToShow: logoAnim.running = true

            Rectangle{
                id: drawBack
                anchors.fill: parent
                //color: "#323643"
                color: "#1d242b"


                Image {
                    id: drawLogo
                    source: "qrc:/blurLogo.png"
                    opacity: 0
                    scale: 0.4
                    anchors.horizontalCenter: drawBack.horizontalCenter
                    anchors.top: drawBack.top
                    anchors.topMargin: -190

                    OpacityAnimator{
                        id: logoAnim
                        target: drawLogo
                        from: 0
                        to: 1
                        duration: 1800
                    }


                }




                Rectangle{
                    id: vLine
                    anchors.horizontalCenter: drawLogo.horizontalCenter
                    anchors.top: drawLogo.bottom
                    anchors.topMargin: -210
                    width: 1
                    height: 60
                    color: "#f7f7f7"
                    opacity: 0.7
                }


                Text {
                    id: services
                    font.family: openSansCondensed.name;
                    font.pointSize: 12
                    text: "Интернет<br>Цифровое ТВ<br>Каналы связи"
                    anchors.right: vLine.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: vLine.verticalCenter
                    color: "#f7f7f7"
                    lineHeight: 1.2
                }


                Text {
                    id: telN
                    font.family: openSansCondensed.name;
                    font.pointSize: 12
                    text: "tel: +781378 98098<br>Ленинградское шоссе` 33<br>info@comfort-tv.ru<br>info@arriva.net.ru"

                    color: "#f7f7f7"
                    anchors.left: vLine.right
                    anchors.leftMargin: 10
                    anchors.verticalCenter: vLine.verticalCenter
                    lineHeight: 1.2
                }




                // paysArea
                // p_paysArea
                // trustedArea
                // msgArea
                // callArea


                //
                //
                //   PropertyAnimation{
                //       property: "x"
                //       easing.amplitude: 0.1
                //       easing.type: Easing.OutBack
                //       from: - Screen.width
                //       to: 0
                //       duration: 500
                //       running: drawer.opened? true : false
                //       target: paysArea
                //
                //   }


                MouseArea{
                    id: paysArea
                    enabled: workItem.visible ? true : false
                    anchors.top: vLine.bottom
                    anchors.topMargin: 10
                    width: drawer.width
                    height: 50
                    //  x: - Screen.width


                    onClicked: {
                        drawer.close()
                        myClient.askForPayments();
                        myClient.makeBusyON();
                        stackView.push("payments.qml");
                    }

                    Image {
                        id: paysImg
                        source: "qrc:/Menu/circled-menu.png"
                        anchors.left: paysArea.left
                        anchors.leftMargin: 40
                        anchors.verticalCenter: paysArea.verticalCenter
                        height: 18
                        width: 18

                    }

                    Text {
                        id: pays_name
                        anchors.left: paysImg.right
                        anchors.leftMargin: 20
                        anchors.verticalCenter: paysImg.verticalCenter
                        font.family: openSansCondensed.name;
                        font.pointSize: window.width / 26
                        text: "Платежи"
                        color: "#f7f7f7"

                    }

                    Image {
                        id: ps_arr
                        source: "qrc:/Menu/arrow_forward.png"
                        anchors.verticalCenter: pays_name.verticalCenter
                        anchors.right: paysArea.right
                        anchors.rightMargin: 50
                        height: 18
                        width: 18


                    }

                }

                MouseArea{
                    id: p_paysArea
                    enabled: workItem.visible ? true : false
                    anchors.top: paysArea.bottom
                    width: drawer.width
                    height: 50

                    onClicked: {
                        drawer.close()
                        myClient.makeBusyON();
                        stackView.push("payPoints.qml");
                    }


                    Image {
                        id: pointsImg
                        source: "qrc:/Menu/address.png"
                        anchors.left: p_paysArea.left
                        anchors.leftMargin: 40
                        anchors.verticalCenter: p_paysArea.verticalCenter
                        height: 18
                        width: 18
                    }

                    Text {
                        id: points_name
                        anchors.left: pointsImg.right
                        anchors.leftMargin: 20
                        anchors.verticalCenter: pointsImg.verticalCenter
                        font.family: openSansCondensed.name;
                        font.pointSize: window.width / 26
                        text: "Терминалы"
                        color: "#f7f7f7"

                    }

                    Image {
                        id: pnts_arr
                        source: "qrc:/Menu/arrow_forward.png"
                        anchors.verticalCenter: points_name.verticalCenter
                        anchors.right: p_paysArea.right
                        anchors.rightMargin: 50
                        //height: 30
                        //width: 30
                        height: 18
                        width: 18


                    }


                }

                MouseArea{
                    id: trustedArea
                    enabled: workItem.visible ? true : false
                    anchors.top: p_paysArea.bottom
                    width: drawer.width
                    height: 50

                    onClicked: {
                        drawer.close()
                        stackView.push("trustedPayPage.qml");
                    }

                    Image {
                        id: trustedImg
                        source: "qrc:/Menu/hand.png"
                        anchors.left: trustedArea.left
                        anchors.leftMargin: 40
                        anchors.verticalCenter: trustedArea.verticalCenter
                        height: 18
                        width: 18
                    }

                    Text {
                        id: trusted_name
                        anchors.left: trustedImg.right
                        anchors.leftMargin: 20
                        anchors.verticalCenter: trustedImg.verticalCenter
                        font.family: openSansCondensed.name;
                        font.pointSize: window.width / 26
                        text: "Обещанный"
                        color: "#f7f7f7"

                    }

                    Image {
                        id: tr_arr
                        source: "qrc:/Menu/arrow_forward.png"
                        anchors.verticalCenter: trusted_name.verticalCenter
                        anchors.right: trustedArea.right
                        anchors.rightMargin: 50
                        height: 18
                        width: 18


                    }


                }

                MouseArea{
                    id: msgArea
                    enabled: workItem.visible ? true : false
                    anchors.top: trustedArea.bottom
                    width: drawer.width
                    height: 50

                    onClicked: {
                        drawer.close()
                        myClient.makeBusyON();
                        myClient.askForMsgs();
                        stackView.push("messagePage.qml");
                    }

                    Image {
                        id: msgImg
                        source: "qrc:/Menu/group-message.png"
                        anchors.left: msgArea.left
                        anchors.leftMargin: 40
                        anchors.verticalCenter: msgArea.verticalCenter
                        height: 18
                        width: 18
                    }

                    Text {
                        id: msgs_name
                        anchors.left: msgImg.right
                        anchors.leftMargin: 20
                        anchors.verticalCenter: msgImg.verticalCenter
                        font.family: openSansCondensed.name;
                        font.pointSize: window.width / 26
                        text: "Сообщения"
                        color: "#f7f7f7"

                    }

                    Image {
                        id: msg_arr
                        source: "qrc:/Menu/arrow_forward.png"
                        anchors.verticalCenter: msgs_name.verticalCenter
                        anchors.right: msgArea.right
                        anchors.rightMargin: 50
                        height: 18
                        width: 18


                    }


                }

                MouseArea{
                    id: callArea
                    anchors.top: msgArea.bottom
                    width: drawer.width
                    height: 50

                    onClicked: {
                        drawer.close()
                        BackEnd.callUs();
                    }

                    Image {
                        id: callImg
                        source: "qrc:/Menu/ringer-volume.png"
                        anchors.left: callArea.left
                        anchors.leftMargin: 40
                        anchors.verticalCenter: callArea.verticalCenter
                        height: 18
                        width: 18
                    }

                    Text {
                        id: call_name
                        anchors.left: callImg.right
                        anchors.leftMargin: 20
                        anchors.verticalCenter: callImg.verticalCenter
                        font.family: openSansCondensed.name;
                        font.pointSize: window.width / 26
                        text: "Поддержка"
                        color: "#f7f7f7"

                    }

                    Image {
                        id: call_arr
                        source: "qrc:/Menu/arrow_forward.png"
                        anchors.verticalCenter: call_name.verticalCenter
                        anchors.right: callArea.right
                        anchors.rightMargin: 50
                        height: 18
                        width: 18

                    }

                }

                Rectangle{
                    id: bottomLine
                    anchors.horizontalCenter: drawBack.horizontalCenter
                    anchors.top: callArea.bottom
                    anchors.topMargin: 5
                    width: drawBack.width * 0.8
                    height: 1
                    color: "#fafafa"
                    opacity: 0.7
                }


                MouseArea{
                    id: leftArea
                    anchors.top: bottomLine.bottom
                    anchors.topMargin: 0
                    anchors.right: middleArea.left
                    width: bottomLine.width / 3
                    height: width
                    onClicked: {
                        drawer.close()
                        BackEnd.goUrl();
                    }


                    Image {
                        id: leftImg
                        source: "qrc:/Menu/home.png"
                        anchors.centerIn: parent
                        height: 20
                        width: 20
                    }
                    Text {
                        id: webTxt
                        anchors.horizontalCenter: leftImg.horizontalCenter
                        anchors.top: leftImg.bottom
                        anchors.topMargin: 10
                        font.family: openSansCondensed.name;
                        font.pointSize: 12
                        color: "#f7f7f7"
                        text: "Сайт"

                    }

                }
                MouseArea{
                    id: middleArea
                    anchors.top: bottomLine.bottom
                    anchors.topMargin: 2
                    anchors.horizontalCenter: bottomLine.horizontalCenter
                    width: bottomLine.width / 3
                    height: width

                    onClicked: {
                        drawer.close()
                        BackEnd.social();
                    }

                    Image {
                        id: middleImg
                        source: "qrc:/Menu/social_md.png"
                        anchors.centerIn: parent
                        height: 25
                        width: 25
                    }
                    Text {
                        id: socialTxt
                        anchors.horizontalCenter: middleImg.horizontalCenter
                        anchors.top: middleImg.bottom
                        anchors.topMargin: 10
                        font.family: openSansCondensed.name;
                        font.pointSize: 12
                        color: "#f7f7f7"
                        text: "Сообщество"

                    }



                }
                MouseArea{
                    id: rightArea
                    anchors.top: bottomLine.bottom
                    anchors.topMargin: 2
                    anchors.left: middleArea.right
                    width: bottomLine.width / 3
                    height: width

                    onClicked: {
                        drawer.close()
                        stackView.push("infoPage.qml");
                    }


                    Image {
                        id: rightImg
                        source: "qrc:/Menu/info-popup.png"
                        anchors.centerIn: parent
                        height: 20
                        width: 20
                    }
                    Text {
                        id: aboutTxt
                        anchors.horizontalCenter: rightImg.horizontalCenter
                        anchors.top: rightImg.bottom
                        anchors.topMargin: 10
                        font.family: openSansCondensed.name;
                        font.pointSize: 12
                        color: "#f7f7f7"
                        text: "Инфо"

                    }

                }

                MouseArea{
                    id: quitButton
                    enabled: workItem.visible ? true : false
                    anchors.bottom: drawBack.bottom
                    anchors.bottomMargin: 25
                    anchors.horizontalCenter: drawBack.horizontalCenter
                    width: drawBack.width * 0.75
                    height: 45
                    Rectangle{
                        id: exitBack
                        border.width: 1
                        border.color: "#f7f7f7"
                        color: "transparent"
                        radius: 6
                        anchors.fill: parent

                        Text {
                            id: quitTxt
                            font.family: openSansCondensed.name;
                            font.pointSize: 25
                            anchors.centerIn: parent
                            text: "выйти"
                            color: "#f7f7f7"

                        }
                    }

                    onClicked: {
                        myClient.quitAndClear();
                        startHead.visible = true;
                        mainStartForm.visible = true;
                        appearstartform.running = true;

                        workItem.visible = false;
                        nameInput.clear();
                        passwordInput.clear();
                        drawer.close();

                    }

                }

            }

        }

        Item {
            id: mainField
            anchors.top: bar.bottom
            width: window.width
            height: window.height - bar.height


            StackView {
                id: stackView
                Component.onCompleted: event.accepted = false;



                //   pushEnter: Transition {
                //             PropertyAnimation {
                //                 property: "opacity"
                //                 from: 0
                //                 to:1
                //                 duration: 100
                //             }
                //   }


                //antialiasing: true
                onDepthChanged: {
                    // myClient.closeIfInProcess();
                    if (stackView.depth === 1)
                    {
                        myClient.closeIfInProcess();
                        console.log("NOW")

                        if (!myClient.isConnectingState())
                            myClient.fillHomePage();
                    }
                }

                focus: true
                Keys.onReleased: if (event.key === Qt.Key_Back && stackView.depth > 1) {
                                     stackView.pop();
                                     event.accepted = true;
                                 }

                initialItem: "homePage.qml"
                anchors.fill: parent
            }
        }
    }
    BusyIndicator {
        id: bigbusy
        opacity: 0
        running: false
        width: parent.width / 4
        height: parent.width / 4
        anchors.horizontalCenter: workItem.horizontalCenter
        anchors.bottom: workItem.bottom
        anchors.bottomMargin: 150
        z: 3

        OpacityAnimator {
            id: bigbusyappear
            target: bigbusy;
            from: 0;
            to: 1;
            duration: 600
            running: true
            easing.type: Easing.InOutExpo
        }

        contentItem: Item {
            id: item
            opacity: bigbusy.running ? 1 : 0

            Behavior on opacity {
                OpacityAnimator {
                    duration: 600
                }
            }

            RotationAnimator {
                target: item
                running: bigbusy.visible && bigbusy.running
                from: 0
                to: 360
                loops: Animation.Infinite
                duration: 2000
            }

            Repeater {
                id: repeater
                model: 6
                Rectangle{
                    id: itemRec
                    x: item.width / 2 - width / 2
                    y: item.height / 2 - width / 2
                    implicitWidth: window.width / 22
                    implicitHeight: window.width / 22
                    //radius: 50
                    radius: 10
                    color: "#93deff"
                    transform: [
                        Translate {
                            id: trans
                            y: -Math.min(item.width, item.height) * 0.3

                        },
                        Rotation {
                            angle: index / repeater.count * 360
                            origin.x: width / 2
                            origin.y: height / 2
                        }




                    ]

                    SequentialAnimation{
                        running: bigbusy.running == true ? true : false
                        loops:  Animation.Infinite

                        NumberAnimation {
                            target: trans
                            property: "y";
                            easing.type: Easing.OutQuart
                            from: 0.8
                            to: -Math.min(item.width, item.height) * 0.6
                            duration: 1000

                        }

                        NumberAnimation {
                            target: trans
                            property: "y";
                            easing.type: Easing.InQuart
                            to: 0.8
                            from: -Math.min(item.width, item.height) * 0.6
                            duration: 1000

                        }
                    }
                }
            }
        }
    }
}
























































