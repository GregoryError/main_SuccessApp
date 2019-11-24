import QtQuick 2.0
import QtQuick.Controls 2.1



Item {
    id: issueItem
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
            text: "В данный момент у меня проблема<br>по услуге:"
        }

        Column {
            id: checkBoxColumn
            anchors.top: mainHeader.bottom
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.topMargin: 50
            spacing: 25

            CheckBox {
                id: i_net_chb

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.right
                    font.pointSize: 26
                    minimumPointSize: 8
                    fontSizeMode: Text.Fit
                    color: "#f7f7f7"
                    text: "Интернет"
                }

                indicator: Rectangle {
                    implicitWidth: 50
                    implicitHeight: 50
                    x: i_net_chb.leftPadding
                    y: parent.height / 2 - height / 2

                    radius: 3
                    border.color: "white"
                    Image {
                        width: 80
                        height: 80
                        x: 6
                        y: 6
                        anchors.centerIn: parent
                        source: "qrc:/Menu/tick.png"
                        visible: i_net_chb.checked
                    }


                }



            }
            CheckBox {
                id: ktv_chb
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.right
                    font.pointSize: 26
                    minimumPointSize: 8
                    fontSizeMode: Text.Fit
                    color: "#f7f7f7"
                    text: "Кабельное ТВ"
                }

                indicator: Rectangle {
                    implicitWidth: 50
                    implicitHeight: 50
                    x: ktv_chb.leftPadding
                    y: parent.height / 2 - height / 2

                    radius: 3
                    border.color: "white"
                    Image {
                        width: 80
                        height: 80
                        x: 6
                        y: 6
                        anchors.centerIn: parent
                        source: "qrc:/Menu/tick.png"
                        visible: ktv_chb.checked
                    }


                }
            }
            CheckBox {
                id: other_chb
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.right
                    font.pointSize: 26
                    minimumPointSize: 8
                    fontSizeMode: Text.Fit
                    color: "#f7f7f7"
                    text: "Другое"
                }

                indicator: Rectangle {
                    implicitWidth: 50
                    implicitHeight: 50
                    x: other_chb.leftPadding
                    y: parent.height / 2 - height / 2

                    radius: 3
                    border.color: "white"
                    Image {
                        width: 80
                        height: 80
                        x: 6
                        y: 6
                        anchors.centerIn: parent
                        source: "qrc:/Menu/tick.png"
                        visible: other_chb.checked
                    }


                }

            }

        }

        Rectangle {
            id: forwardButton
            width: parent.width * 0.6
            height: 80
            clip: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: checkBoxColumn.bottom
            anchors.topMargin: 40
            radius: 7
            opacity: i_net_chb.checked || ktv_chb.checked || other_chb.checked ? 1 : 0.5
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
                //anchors.centerIn: forwardButton
                color: "#0074e4"

                transform: Translate {
                     x: -toolButtoncolorRect.width / 2
                     y: -toolButtoncolorRect.height / 2
                }
            }

            MouseArea{
                id: toolButton
                anchors.fill: parent
                enabled: i_net_chb.checked || ktv_chb.checked || other_chb.checked ? true : false
                onPressed: {
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
                myClient.clearIssue_msg();
                if (i_net_chb.checked)
                    myClient.addNextIssuePart("- Наблюдается проблема с интернетом. ")
                if (ktv_chb.checked)
                    myClient.addNextIssuePart("- Наблюдается проблема с КТВ. ")
                if (other_chb.checked)
                    myClient.addNextIssuePart("- Имеется не стандартная проблема. ")
                stackView.push("issue_report_1.qml");

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












