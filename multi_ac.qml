import QtQuick 2.0

Item {
    id: mainMA
    FontLoader { id: openSansCondensed; source: "/fonts/openSansCondensed_Light.ttf" }

    function fillModel(){
        console.log("onStartFillAccList");

        accModel.clear()

        mcTXT.text = "Активный: " + myClient.showActiveName()

        for(var i = 0; i < myClient.accauntListSize(); ++i)
        {
            console.log("Name: " + myClient.getAccauntName(i))
            accModel.append({"acc_name": myClient.getAccauntName(i)});
        }

        accListView.model = accModel;
        myClient.makeBusyOFF();
    }


    Connections {
        target: myClient
        onStartFillAccList: {
            fillModel();
        }
    }

    Component.onCompleted: {
        fillModel();
    }


    Image {
        id: backGroundMA
        source: "qrc:/Menu/start_back.png"
        anchors.fill: parent

        Text {
            id: mcTXT
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.leftMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: openSansCondensed.name;
            font.pointSize: 26
            minimumPointSize: 18
            fontSizeMode: Text.Fit
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            width: parent.width * 0.9
            color: "#1d242b"
            text: "Активный: " + myClient.showActiveName()
        }

        ListModel {
            id: accModel
        }

        ListView{
            id: accListView
            visible: true
            anchors.top: mcTXT.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            width: backGroundMA.width - 40
            height: backGroundMA.height - (mcTXT.height * 2) - addButt.height - 50
            smooth: true
            maximumFlickVelocity: 1000000
            clip: true
            spacing: 10
            delegate: accDelegate

            Component{
                id: accDelegate
                Item {
                    width: accListView.width
                    height: accListView.height / 6
                    anchors.horizontalCenter: parent.horizontalCenter
                    Rectangle {
                        anchors.fill: parent
                        color: "#1d242b"
                        radius: 4
                        opacity: 0.9
                    }


                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            myClient.switchToAccaunt(acc_name);
                            stackView.pop();

                        }

                        Text {
                            id: accName
                            text: acc_name
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            font.pointSize: 20
                            color: "white"

                        }

                        Image {
                            enabled: !(myClient.showActiveName() === acc_name)
                            visible: !(myClient.showActiveName() === acc_name)
                            source: "qrc:/Menu/wt_cross.png"
                            anchors.right: parent.right
                            anchors.rightMargin: 4
                            width: parent.height * 0.6
                            height: width
                            anchors.verticalCenter: parent.verticalCenter

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    myClient.clrAccaunt(acc_name);
                                    fillModel();
                                }
                            }
                        }
                    }
                }
            }
        }



        MouseArea {
            id: addButt
            clip: true
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.7
            height: width * 0.3
            Rectangle {
                id: addButtBack
                anchors.fill: parent
                radius: 4
                color: "#50a5f5"
                Rectangle {
                    id: addButtcolorRect
                    height: 0
                    width: 0
                    visible: false
                    color: "white"
                    opacity: 0

                    transform: Translate {
                        x: -addButtcolorRect.width / 2
                        y: -addButtcolorRect.height  / 2
                    }
                }


                Text {
                    font.family: openSansCondensed.name;
                    font.pointSize: 20
                    anchors.centerIn: parent
                    color: "white"
                    text: "+ Добавить адрес"
                    font.bold: true
                }
            }

            onPressed: {
                onPressedAnim.running = true
            }

            onReleased: {
                addButtcolorRect.x = mouseX
                addButtcolorRect.y = mouseY
                if(addButtCircleAnimation.running)
                    addButtCircleAnimation.stop()
                addButtCircleAnimation.start()
            }


            ColorAnimation {
                id: onPressedAnim
                running: false
                target: addButtBack
                property: "color"
                duration: 200
                from: "#50a5f5"
                to: "#06081f"
            }

            ParallelAnimation {
                id: addButtCircleAnimation

                NumberAnimation {
                    target: addButtcolorRect;
                    properties: "width,height,radius";
                    from: addButtcolorRect.width;
                    to: addButt.width;
                    duration: 1100;
                    easing.type: Easing.OutExpo
                }

                NumberAnimation {
                    target: addButtcolorRect;
                    properties: "opacity";
                    from: 1;
                    to: 0;
                    duration: 800;
                }

                ColorAnimation {
                    target: addButtBack
                    property: "color"
                    duration: 1100
                    from: addButtBack.color
                    to: "#50a5f5"
                    easing.type: Easing.InExpo;
                }

                onStarted: {
                    addButtcolorRect.visible = true

                }

                onStopped: {
                    addButtcolorRect.width = 0
                    addButtcolorRect.height = 0
                    addButtcolorRect.visible = false
                    addButtBack.color = "#50a5f5"
                    stackView.push("multi_acc_add.qml");

                }
            }
        }
    }
}















