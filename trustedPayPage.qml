import QtQuick 2.7
import QtQuick.Controls 2.2


Item {
    id: mainTP

    FontLoader { id: openSansCondensed; source: "/fonts/openSansCondensed_Light.ttf" }

    Connections{
        target: myClient
        onTrustedPayDenied:{

            resultAnim.running = true
            trustButton.visible = false
            control.visible = false
            resultTxt.text = "Услуга уже была<br>
                           предоставлена."
            toolButton.enabled = true


        }

        onTrustedPayOk:{
            resultAnim.running = true
            trustButton.visible = false
            control.visible = false
            resultTxt.text = "Услуга активирована!"
            toolButton.enabled = true

        }
    }

    Image {
        id: backGroundTP
        source: "qrc:/trustedBack.png"
        anchors.fill: parent


        Component.onCompleted: focus = true;

        Flickable{
            id: trustedFlick
            width: backGroundTP.width
            height: backGroundTP.height
            anchors.horizontalCenter: backGroundTP.horizontalCenter
            contentHeight: trustButton.y + trustButton.height + 100
            contentWidth: parent.width
            smooth: true
            boundsBehavior: Flickable.StopAtBounds
            interactive: true
            maximumFlickVelocity: 1000000
            clip: true

            Text {
                id: trustedTXT
                anchors.top: parent.top
                anchors.topMargin: 50
                anchors.leftMargin: 50
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: openSansCondensed.name;
                font.pointSize: 19
                minimumPointSize: 14
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                width: parent.width * 0.9
                color: "white"
                //font.bold: true
                text: "- Обещанный платеж это бесплатная услуга.<br>
- Подключив обещанный платеж,<br>
вы обязуетесь внести плату за текущий месяц.<br><br>
УСЛОВИЯ ИСПОЛЬЗОВАНИЯ УСЛУГИ:<br><br>
1. Услуга «Обещанный платеж» предоставляется<br>
Абонентам, у которых на начало нового расчетного<br>
периода не хватает денежных средств для списания<br>
платы за услуги связи.<br><br>

2. Услуга «Обещанный платёж» предоставляет<br>
временный доступ к услугам на срок до 3 суток.<br><br>

3. С момента подключения Услуги<br>
«Обещанный платеж», с Лицевого счета<br>
Абонента взимается абонентская плата<br>
в полном размере, согласно выбранному<br>
Абонентом тарифному плану.<br><br>

4. Если в течение пользования услугой<br>
«Обещанный платеж» Абонент не внесет<br>
на Лицевой счет денежные средства<br>
в размере не менее полной абонентской платы<br>
за Услуги за один расчетный период,<br>
предоставление Услуг Абоненту<br>
будет приостановлено.<br>
Для возобновления оказания Услуг<br>
Абоненту необходимо будет внести<br>
на Лицевой счет денежные средства<br>
в размере полной абонентской платы<br>
за Услуги за один расчетный период.<br><br>

5. Абонент не может воспользоваться услугой<br>
«Обещанный платеж» дважды в течение<br>
одного расчетного периода.<br><br>

6. Администрация оставляет за собой право<br>
отказать Абоненту в предоставлении<br>
Услуги «Обещанный платеж»."
            }

            CheckBox{
                id: control
                //anchors.horizontalCenter: trustedTXT.horizontalCenter
                anchors.left: trustButton.left
                anchors.top: trustedTXT.bottom
                anchors.topMargin: 15

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.right
                    anchors.leftMargin: 5
                    font.family: openSansCondensed.name;
                    font.pointSize: 18
                    color: "white"
                    text: " Условия принимаю"
                }



                indicator: Rectangle {
                    implicitWidth: 60
                    implicitHeight: 60
                    x: control.leftPadding
                    y: parent.height / 2 - height / 2
                    radius: 3
                    border.color: "#0074e4"
                    color: "white"

                    Rectangle {
                        width: 50
                        height: 50
                        anchors.centerIn: parent
                        x: 6
                        y: 6
                        radius: 2
                        color: "#0074e4"
                        visible: control.checked
                    }
                }

                contentItem: Text {
                    text: control.text
                    font: control.font
                    opacity: enabled ? 1.0 : 0.3
                    color: "#0074e4"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: control.indicator.width + control.spacing
                }

            }
            MouseArea{
                id: trustButton
                clip: true
                enabled: control.checked ? true : false
                anchors.horizontalCenter: trustedTXT.horizontalCenter
                anchors.top: control.bottom
                anchors.topMargin: 30
                width: backGroundTP.width * 0.4
                height: backGroundTP.width / 5

                Rectangle{
                    id: backOfButton
                    color: "#1d242b" //  93deff  //50a5f5
                    smooth: true
                    anchors.fill: parent
                    radius: 6
                    anchors.margins: 1


                    Rectangle {
                        id: backOfButtoncolorRect
                        height: 0
                        width: 0
                        visible: false
                        color: "#50a5f5"
                        opacity: 0

                        transform: Translate {
                            x: -backOfButtoncolorRect.width / 2
                            y: -backOfButtoncolorRect.height  / 2
                        }
                    }

                    Text {
                        id: trButtTxt
                        anchors.centerIn: parent
                        font.family: openSansCondensed.name;
                        font.pointSize: 25
                        color: "white"
                        text: "Подключить"
                    }

                }

                onPressed: {
                    onPressedAnim.running = true
                    //backOfButton.opacity = 0.7
                }

                onReleased: {

                    backOfButtoncolorRect.x = mouseX
                    backOfButtoncolorRect.y = mouseY

                    if(cellButtoncircleAnimation.running)
                        cellButtoncircleAnimation.stop()

                    cellButtoncircleAnimation.start()


                }

                ColorAnimation {
                    id: onPressedAnim
                    running: false
                    target: backOfButton
                    property: "color"
                    duration: 200
                    from: "#93deff"
                    to: "#75bbfb"
                    //easing.type: Easing.InExpo;
                }

                ParallelAnimation {
                    id: cellButtoncircleAnimation

                    NumberAnimation {
                        target: backOfButtoncolorRect;
                        properties: "width,height,radius";
                        from: backOfButtoncolorRect.width;
                        to: trustButton.width;
                        duration: 1100;
                        easing.type: Easing.OutExpo
                    }

                    NumberAnimation {
                        target: backOfButtoncolorRect;
                        //easing.type: Easing.InExpo;
                        properties: "opacity";
                        from: 1;
                        to: 0;
                        duration: 800;
                    }

                    ColorAnimation {
                        target: backOfButton
                        property: "color"
                        duration: 1100
                        from: backOfButton.color
                        to: "#93deff"
                        easing.type: Easing.InExpo;
                    }

                    onStarted: {
                        backOfButtoncolorRect.visible = true

                    }

                    onStopped: {
                        backOfButtoncolorRect.width = 0
                        backOfButtoncolorRect.height = 0
                        backOfButtoncolorRect.visible = false
                        myClient.askForTrustedPay();

                    }

                }

            }

            Rectangle{
                id: resultMsg
                opacity: 0
                width: mainTP.width * 0.7
                height: width * 0.7
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: trustedTXT.bottom
                anchors.topMargin: 30
                radius: 6
                color: "#f7f7f7"
                //clip: true
                Text {
                    id: resultTxt
                    anchors.horizontalCenter: resultMsg.horizontalCenter
                    anchors.verticalCenter: resultMsg.verticalCenter
                    //anchors.top: resultMsg.top
                    //anchors.topMargin: 15
                    font.family: openSansCondensed.name
                    font.pointSize: 20
                    color: "#0074e4"

                }
                OpacityAnimator{
                    id: resultAnim
                    running: false
                    target: resultMsg
                    from: 0
                    to: 0.8
                    duration: 1000
                    onStarted: {
                        //resultMsg.visible = true
                    }
                }


                Rectangle{                     // add background if use "Toolbutton"
                    id: toolRect
                    opacity: 0.9
                    anchors.top: resultMsg.bottom
                    anchors.topMargin: 15
                    anchors.horizontalCenter: resultMsg.horizontalCenter
                    color: "#93deff"
                    radius: 25
                    width: 45
                    height: 45
                    x: 15
                    // y: 15
                    //clip: true
                    smooth: true



                    Image {
                        id: toolPic
                        //source: "qrc:/toolPic.png"
                        source: "qrc:/arrow_left.png"
                        width: 30
                        height: 30
                        smooth: true
                        anchors.centerIn: toolRect
                    }

                    Rectangle {
                        id: toolButtoncolorRect
                        height: 0
                        width: 0
                        anchors.centerIn: toolRect
                        color: "#0074e4"

                        transform: Translate {
                            // x: -toolButtoncolorRect.width / 2
                            // y: -toolButtoncolorRect.height / 2
                        }
                    }

                    MouseArea{
                        id: toolButton
                        anchors.fill: parent
                        enabled: false
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
                    to: toolRect.width * 5
                    duration: 450

                    onStopped: {
                        toolButtoncolorRect.width = 0
                        toolButtoncolorRect.height = 0
                        stackView.pop()

                    }
                }


                PropertyAnimation {
                    id: toolButtonOpacityAnimation
                    target: toolButtoncolorRect
                    properties: "opacity"
                    from: 1
                    to: 0
                    duration: 400

                }

            }

        }

    }

}


















































