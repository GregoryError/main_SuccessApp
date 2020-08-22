import QtQuick 2.9
import QtQuick.Controls 2.2

import QtGraphicalEffects 1.0
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.11


Item {
    // anchors.fill: parent
    id: mainwnd
    //    height: Screen.desktopAvailableHeight
    //    width: Screen.desktopAvailableWidth

    FontLoader { id: poiretOneRegular; source: "/fonts/poiretOneRegular.ttf"; }
    FontLoader { id: openSansCondensed; source: "/fonts/openSansCondensed_Light.ttf"; }


    Connections{
        target: myClient
        onStartReadInfo: {

            // check if push was received
            if (BackEnd.getAct() === "rec")
            {
                myClient.makeBusyON();
                myClient.askForMsgs();
                stackView.push("messagePage.qml", {"objectName": "messagePage"});
            }
            else
            {

                billVal.text = myClient.showBill();
                billVal.color = myClient.showState() ? "#f7f7f7" : "#f31010"
                planName.text = "Ваш пакет: " + myClient.showPlan();
                countTxt.text = "Личный счет: " + myClient.showId();
                dateTxt.text = "Расчетный день: " + myClient.showPay_day() + "  (" + myClient.nextPayDay() + ")";

                bill.text = "Внесено на баланс. Данные на " + myClient.serverTime();

                //console.log(myClient.nextPayDay() + " - NEXT DATE FOR PAY");

                myClient.switchToMe();

                infoRectcolorRect.y = 15
                infoRectcolorRect.x = 15
                infoRectcolorRectcleAnimation.start()
                infoRectcolorRectOpacityAnimation.start()
            }
        }
    }

    Item{
        id: infoRect
        width: mainwnd.width
        height: (mainwnd.height * 0.3) + 10
        anchors.top: mainwnd.top
        anchors.horizontalCenter: parent.horizontalCenter
        Component.onCompleted: focus = true

        Image {
            id: walletPic
            z: 4
            scale: mainwnd.height / 1530
            width: 75
            height: 65
            source: "qrc:/Wallet.png"
            // smooth: true
            anchors.verticalCenter: billVal.verticalCenter
            anchors.horizontalCenter: infoPic.horizontalCenter
            //anchors.right: billVal.left
            //anchors.margins: 40
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    myClient.makeBusyON(); stackView.push("qrc:/payDescribe.qml");
                }
            }
        }

        Text{
            id: billVal
            anchors.horizontalCenter: infoRect.horizontalCenter
            anchors.top: infoRect.top
            anchors.topMargin: -17           /////// controversal <<<<<<<<<<<<<<<<<<<<
            font.family: openSansCondensed.name;
            font.pointSize: 55
            //  color: myClient.showState() ? "#f7f7f7" : "#f31010"
            //color: "#9ab5d5"
            //text: "550 ₽"
            text: myClient.showBill()
            //wrapMode: Text.WordWrap

        }

        Image {
            id: rubPic
            width: billVal.height * 0.4
            height: billVal.height * 0.5
            source: "qrc:/Menu/rub.png"
            anchors.verticalCenter: billVal.verticalCenter
            anchors.left: billVal.right
            anchors.margins: 5
        }

        Text{
            id: bill
            // y: billVal.y + billVal.height
            anchors.top: billVal.bottom
            anchors.topMargin: -10
            //anchors.topMargin:
            anchors.horizontalCenter: infoRect.horizontalCenter
            color: "#f7f7f7"
            //color: "#9ab5d5"
            font.family: openSansCondensed.name;
            font.pointSize: 14
            width: infoline.width
            horizontalAlignment: Text.AlignHCenter
            minimumPointSize: 8
            fontSizeMode: Text.Fit
            font.bold: true
            // text: "Баланс на сегодня " + myClient.serverTime();
        }

        Text{
            id: planName
            anchors.top: bill.bottom
            anchors.topMargin: -4
            anchors.horizontalCenter: infoline.horizontalCenter
            font.family: openSansCondensed.name;
            font.pointSize: 20
            color: "#f7f7f7"
            width: infoline.width
            horizontalAlignment: Text.AlignHCenter
            minimumPointSize: 8
            fontSizeMode: Text.Fit
            //text: "Комплекс 550"

        }

        Rectangle{
            id: infoline
            opacity: 0.7
            width: bigMenu.width
            height: 1
            anchors.horizontalCenter: infoRect.horizontalCenter
            anchors.top: planName.bottom
            anchors.topMargin: 0
            //y:  bill.y + bill.height + 3
            color: "white"
        }

        Image {
            id: infoPic
            anchors.verticalCenter: countItem.bottom
            anchors.right: countItem.left
            anchors.rightMargin: 14
            width: 25
            height: 25
            source: "qrc:/infoPic.png"
            //smooth: true

        }


        Item {
            id: countItem
            // anchors.horizontalCenter: infoline.horizontalCenter
            x: dateTxt.x
            anchors.top: infoline.bottom
            anchors.topMargin: 3
            height: countTxt.height
            width: infoline.width
            z: 4


            MouseArea{
                id: bufArea
                //z: 4
                anchors.fill: parent
                onPressed: {
                    console.log("copyed");
                    countBack.color = "#95c9e8"
                    countBack.opacity = 1
                    copyTxt.visible = true
                    myClient.copyToBuf();
                }
                onReleased: {
                    countBackDiss.running = true
                }


                OpacityAnimator{
                    id: countBackDiss
                    target: countBack
                    from: 1
                    to: 0
                    duration: 2500
                    running: false
                    onStopped: {
                        countBack.color = "transparent"
                        copyTxt.visible = false
                    }

                }
            }

            Text {
                id: countTxt
                anchors.top: countItem.top
                // anchors.top: infoline.bottom
                // anchors.topMargin: 10
                // anchors.horizontalCenter: countItem.horizontalCenter
                anchors.left: countItem.left
                //font.family: openSansCondensed.name;
                horizontalAlignment: Text.AlignHCenter
                minimumPointSize: 14
                fontSizeMode: Text.Fit
                font.pointSize: 18
                font.bold: true
                color: "#f7f7f7"
                // color: "#70859e"

                Rectangle{
                    id: countBack
                    anchors.fill: parent
                    radius: 4
                    color: "transparent"
                    Text {
                        id: copyTxt
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: openSansCondensed.name;
                        font.pointSize: 16
                        text: "скопировано"
                        visible: false
                        color: "white"

                    }
                }
            }

            Image {
                id: copyImg
                source: "qrc:/Menu/copyimg.png"
                anchors.left: countTxt.right
                anchors.leftMargin: 8
                width: 18
                height: 18
                anchors.verticalCenter: countTxt.verticalCenter
            }

            Text {
                id: copyComment
                anchors.left: copyImg.right
                anchors.verticalCenter: copyImg.verticalCenter
                anchors.leftMargin: 4
                font.family: openSansCondensed.name;
                font.pointSize: 14
                color: "#f7f7f7"
                // color: "#70859e"
                text: "копировать"
            }

        }

        Text{
            id: dateTxt
            anchors.top: countItem.bottom
            anchors.topMargin: 3
            anchors.horizontalCenter: infoRect.horizontalCenter
            font.family: openSansCondensed.name;
            font.pointSize: 15
            color: "#f7f7f7"

        }


        Rectangle {
            id: infoRectcolorRect
            height: 0
            width: 0

            color: "#95c9e8"

            transform: Translate {
                x: -infoRectcolorRect.width / 2
                y: -infoRectcolorRect.height / 2
            }
        }
        MouseArea{
            id: infoArea
            z: 2
            anchors.fill: infoRect
            // enabled: false
            onPressed: {

                infoRectcolorRectcleAnimation.stop();
                infoRectcolorRectOpacityAnimation.stop();

                infoRectcolorRect.x = mouseX
                infoRectcolorRect.y = mouseY
                infoRectcolorRectcleAnimation.start()
                infoRectcolorRectOpacityAnimation.start()

            }
        }

        PropertyAnimation {
            id: infoRectcolorRectcleAnimation
            target: infoRectcolorRect
            properties: "width,height,radius"
            from: 0
            to: infoRect.width * 10
            duration: 900

            onStopped: {
                infoRectcolorRect.width = 0
                infoRectcolorRect.height = 0

            }
        }

        PropertyAnimation {
            id: infoRectcolorRectOpacityAnimation
            target: infoRectcolorRect
            properties: "opacity"
            from: 1
            to: 0
            duration: 1000

            onStopped: {
                myClient.postWorker();
            }

        }

    }

    /////////////////////////////////// BUTTONS ////////////////////////////////////////////


    ListModel {
        id: myModel

        ListElement {
            mycolor: "#2cbaf1"
            backdata: "qrc:/Menu/payhistory.png"
            active: true
            mtext: "Платежи"
        }
        ListElement {
            mycolor: "#2cbaf1"
            backdata: "qrc:/Menu/gps.png"
            active: true
            mtext: "Оплата"
        }

        ListElement {
            mycolor: "#2cbaf1"
            backdata: "qrc:/Menu/trusted.png"
            active: true
            mtext: "Временный платеж"
        }

        ListElement {
            mycolor: "#2cbaf1"
            backdata: "qrc:/Menu/msg.png"
            active: true
            mtext: "Сообщения"
        }

        ListElement {
            mycolor: "#2cbaf1"
            backdata: "qrc:/Menu/call.png"
            active: true
            mtext: "Позвонить нам"
        }

        ListElement {
            mycolor: "#2cbaf1"
            backdata: "qrc:/Menu/report_issue.png"
            active: true
            mtext: "Решить проблему"
        }

    }

    Rectangle{
        id: bigMenu
        width: infoRect.width - 30
        height: mainwnd.height - infoRect.height -5
        anchors.horizontalCenter: infoRect.horizontalCenter
        radius: 2
        anchors.top: infoRect.bottom
        anchors.topMargin: -20         // WTF

        GridView{
            id: cells
            interactive: false
            opacity: 0
            //visible: false
            anchors.centerIn: parent
            // smooth: true

            width: cellWidth * 2
            height: cellHeight * 3

            cellHeight: bigMenu.height / 3
            cellWidth: bigMenu.width / 2

            model: myModel

            delegate: Component{
                id: cellDelegat
                Item {
                    id: oneCell
                    width: cells.cellWidth
                    height: cells.cellHeight
                    // smooth: true

                    MouseArea{
                        id: buttons
                        enabled: active
                        width: oneCell.width
                        height: oneCell.height
                        clip: true
                        anchors.fill: parent

                        Rectangle{
                            id: backOfCell
                            color: "#f8f8f8"
                            // smooth: true
                            anchors.fill: parent
                            radius: 3
                            anchors.margins: 1

                            Rectangle {
                                id: bigMenucolorRect
                                height: 0
                                width: 0
                                visible: false
                                color: "#93deff"
                                opacity: 0.6


                                transform: Translate {
                                    x: -bigMenucolorRect.width / 2
                                    y: -bigMenucolorRect.height  / 2
                                }
                            }

                            Image {
                                id: buttImg
                                //  smooth: true
                                //anchors.fill: parent
                                opacity: 0.9
                                anchors.centerIn: parent
                                fillMode: Image.PreserveAspectFit
                                // width: Screen.width / 9 - 4
                                width: 28
                                //Component.onCompleted: console.log("Value: " + Screen.width / 9)
                                // height: 30
                                source: backdata


                                Behavior on width {
                                    NumberAnimation {
                                        easing.period: 0.35
                                        easing.amplitude: 3
                                        duration: 1000
                                        easing.type: Easing.OutElastic

                                    }

                                }

                                Component.onCompleted: buttImg.width = Screen.width / 9 - 5

                            }

                            Text {
                                id: cellButtonTxt
                                anchors.top: buttImg.bottom
                                anchors.topMargin: 10
                                anchors.horizontalCenter: buttImg.horizontalCenter
                                color: "#1d242b"
                                font.family: poiretOneRegular.name;
                                font.bold: true
                                font.pointSize: 17
                                text: mtext
                                // smooth: true
                            }

                        }

                        onPressed: {
                            //backOfCell.color = "#C4EDFF"    // color: "#f7f7f7"
                            onPressedAnim.running = true
                            backOfCell.opacity = 0.7

                        }

                        onReleased: {
                            //game_engine.soundTap()


                            bigMenucolorRect.x = mouseX
                            bigMenucolorRect.y = mouseY

                            if(cellButtoncircleAnimation.running)
                                cellButtoncircleAnimation.stop()

                            cellButtoncircleAnimation.start()

                        }

                        ColorAnimation {
                            id: onPressedAnim
                            running: false
                            target: backOfCell
                            property: "color"
                            duration: 200
                            from: "#f7f7f7"
                            to: "#C4EDFF"
                            //easing.type: Easing.InExpo;
                        }

                        Timer{
                            id: operationTimer
                            running: false
                            interval: 250
                            onTriggered: {
                                switch (index) {
                                case 0: myClient.askForPayments(); myClient.makeBusyON();
                                    stackView.push("payments.qml"); break;
                                case 1: myClient.makeBusyON(); stackView.push("qrc:/payDescribe.qml"); break;
                                case 2: stackView.push("trustedPayPage.qml"); break;
                                case 3: myClient.makeBusyON();
                                    myClient.askForMsgs();
                                    stackView.push("messagePage.qml", {"objectName": "messagePage"}); break;
                                case 4: BackEnd.callUs(); break;
                                case 5: stackView.push("issue_report.qml"); break;                  //BackEnd.goUrl(); break;
                                }
                            }
                        }


                        ParallelAnimation {
                            id: cellButtoncircleAnimation

                            NumberAnimation {
                                //id: cellButtoncircleAnimation
                                target: bigMenucolorRect;
                                properties: "width,height,radius";
                                from: bigMenucolorRect.width;
                                to: buttons.width;
                                duration: 1100;
                                easing.type: Easing.OutExpo

                            }


                            NumberAnimation {
                                id: cellButtonOpacityAnimation
                                target: bigMenucolorRect;
                                //easing.type: Easing.InExpo;
                                properties: "opacity";
                                from: 0.6;
                                to: 0;
                                duration: 800;


                            }


                            ColorAnimation {
                                target: backOfCell
                                property: "color"
                                duration: 1100
                                from: "#C4EDFF"
                                to: "#f7f7f7"
                                easing.type: Easing.InExpo;


                            }


                            onStarted: {
                                bigMenucolorRect.visible = true
                                operationTimer.running = true

                            }

                            onStopped: {
                                backOfCell.color = "#f7f7f7"    // color: "#f7f7f7"
                                backOfCell.opacity = 1

                                bigMenucolorRect.width = 0
                                bigMenucolorRect.height = 0
                                bigMenucolorRect.visible = false

                                // if (index === 1) { stackView.push("payPoints.qml"); }



                            }
                        }

                    }

                }

            }


            OpacityAnimator{
                id: cellAppear
                target: cells
                running: cells.visible
                from: 0
                to: 1
                duration: 50
                easing.type: Easing.InExpo
                onStopped: {
                    // some soundeffects
                    // game_engine.soundBegin()
                    //backgroundAppear.start()
                }
            }



            // SequentialAnimation{
            //     id: cellsExit
            //     running: false
            //
            //
            //     ParallelAnimation{
            //
            //         NumberAnimation{
            //             target: cells
            //             properties: "scale"
            //             from: 1
            //             to: 150
            //             duration: 700
            //             easing.type: Easing.InExpo
            //
            //
            //         }
            //         NumberAnimation{
            //             target: cells
            //             properties: "opacity"
            //             from: 1
            //             to: 0
            //             duration: 800
            //             easing.type: Easing.InExpo
            //
            //         }
            //
            //     }
            //
            //     onStopped: {
            //
            //
            //     }
            //
            // }

        }

    }

}


