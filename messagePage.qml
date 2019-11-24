import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    id: mainMsg
    FontLoader { id: openSansCondensed; source: "/fonts/openSansCondensed_Light.ttf" }

    //    Component.onDestroyed: {
    //        myClient.closeIfInProcess();
    //    }

    //    Component.onDestruction: {
    //        myClient.closeIfInProcess();
    //    }


    Connections{
        target: myClient
        onStartReadMsgs: {

            msgModel.clear();
            inputLine.clear();

            //msgView.update()

            for (var i = 0; i < myClient.msgMapSize(); ++i) {

                msgModel.append({"txt": myClient.giveMsgLine(myClient.giveMsgTime(i)),
                                    "time": myClient.convertTime(myClient.giveMsgTime(i))});
            }

            myClient.makeBusyOFF();

            msgView.model = msgModel


            msgView.positionViewAtIndex(msgModel.rowCount() -1, msgView.End)
            msgView.positionViewAtEnd()
            //            msgView.positionViewAtEnd()

        }
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
            opacity: 0.6
        }

        Timer {
            interval: 4500;
            running: inputLine.focus ?
                         false : !msgView.moving && !(msgView.indexAt(msgView.width / 2, msgView.contentY) < (msgModel.rowCount() - 12))
                         ? true : false
            repeat: true
            onTriggered:{
                console.log("Timer trigered");

                if (!myClient.isConnectingState())
                {
                    myClient.askForMsgs();

                    console.log("indexAt  = " + msgView.indexAt(msgView.width / 2, msgView.contentY))
                    console.log("rowCount = " + (msgModel.rowCount() - 10))

                }
            }
        }

        ListModel {
            id: msgModel

        }

        ListView{
            id: msgView
            anchors.top: backRect.top
            //            anchors.topMargin: 3
            //            anchors.bottomMargin: 3
            anchors.bottom: inputLine.top
            anchors.left: backRect.left
            anchors.right: backRect.right
            clip: true
            maximumFlickVelocity: 1000000
            spacing: 10
            delegate: msgDelegate
            footer: Item {
                width: parent.width
                height: 20
            }

            onModelChanged: {
                msgView.positionViewAtIndex(msgModel.rowCount() -1, msgView.End)
                msgView.positionViewAtEnd()
            }



        }

        Component{
            id: msgDelegate


            Rectangle{
                id: msgUnit
                radius: 5
                color: content.text[0] !== "<"? "#f7f7f7" : "#93deff"
                opacity: 0.9
                height: content.paintedHeight + msgTime.height + logoInMsg.height + 25
                width:  msgTime.paintedWidth > content.paintedWidth? msgTime.paintedWidth + 25 :
                                                                     content.paintedWidth + 25
                x: content.text[0] === "<"? 12 : mainMsg.width - (width + 12)

                Image {
                    id: logoInMsg
                    visible: msgUnit.x === 12
                    opacity: 0.9
                    source: "qrc:/Menu/redLogo.png"
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 6
                    anchors.topMargin: 6
                    fillMode: Image.PreserveAspectFit
                    width: content.text[0] === "<"? 50 : 0 // parent.width * 0.2 < 50 ? 50 : parent.width * 0.2
                }

                Rectangle{
                    id: onlyTxtRect
                    anchors.left: msgUnit.left
                    anchors.right: msgUnit.right
                    anchors.top: logoInMsg.bottom
                    anchors.bottom: msgUnit.bottom
                    anchors.topMargin: 8
                    anchors.rightMargin: 12
                    anchors.leftMargin: 9
                    anchors.bottomMargin: 30
                    color: "transparent"
                    // color: "red"

                    Text {
                        id: content
                        font.pointSize: 15
                        width: txt[0] === "<" ? mainMsg.width - 40 :
                                                mainMsg.width - 100

                        wrapMode: Text.Wrap
                        anchors.margins: 6
                        //anchors.centerIn: msgUnit
                        color: "#323643"
                        text: txt
                    }
                }

                Text {
                    id: msgTime
                    //anchors.top: onlyTxtRect.bottom
                    anchors.topMargin: 6
                    anchors.right: msgUnit.right
                    anchors.rightMargin: 6
                    anchors.bottom: msgUnit.bottom
                    anchors.bottomMargin: 6
                    wrapMode: Text.Wrap
                    font.family: openSansCondensed.name;
                    font.pointSize: 17
                    fontSizeMode: Text.Fit
                    color: "#606470"
                    text: time

                }
            }
        }

        Rectangle{
            id: textBack
            anchors.bottom: inputLine.bottom
            width: mainMsg.width
            height: inputLine.height
            color: "#f7f7f7"

        }

        TextField{
            id: inputLine
            width: mainMsg.width - sendButt.width
            height: mainMsg.height * 0.1 - 8
            anchors.bottom: backRect.bottom
            anchors.left: backRect.left
            background: Rectangle{
                anchors.fill: parent
                color: "transparent"
            }
            color: "#323643"
            font.pointSize: 18
            font.family: openSansCondensed.name;
            placeholderText: "Сообщение... "
            maximumLength: 300
            wrapMode: Text.Wrap


            //  onTextChanged: {
            //      if (!sendButt.opacity > 0)
            //          arrowAnim.running = true
            //      if (!inputLine.text.length > 0)
            //          arrowDisAnim.running = true
            //  }


        }
        Button{
            id: sendButt
            enabled: false
            opacity: 0
            visible: false
            width: inputLine.height
            height: width
            anchors.bottom: backRect.bottom
            anchors.right: backRect.right
            background: Image {
                id: sendArrow
                anchors.centerIn: parent
                source: "qrc:/Menu/right-arrow-icon.png"
                width: sendButt.width * 0.8
                height: sendButt.height * 0.8
            }
            onPressed: {

                if (inputLine.text.length > 0)
                    myClient.sendMsgs(inputLine.text);
                inputLine.clear();



                myClient.checkState();  // debug

                myClient.askForMsgs();

            }

            OpacityAnimator{
                id: arrowAnim
                running: inputLine.focus? true : false
                target: sendButt
                from: 0
                to: 1
                duration: 500
                onStarted: {
                    sendButt.visible = true
                }

                onStopped: {
                    sendButt.enabled = true
                }


            }

            OpacityAnimator{
                id: arrowDisAnim
                target: sendButt
                from: 1
                to: 0
                duration: 400
                running: inputLine.focus? false : true
                onStopped: {
                    sendButt.visible = false
                    sendButt.enabled = false
                }
            }
        }
    }
}













