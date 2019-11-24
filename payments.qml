import QtQuick 2.9
import QtGraphicalEffects 1.0

Item {
    //anchors.fill: parent
    id: mainwnd

    FontLoader { id: openSansCondensed; source: "/fonts/openSansCondensed_Light.ttf" }


    Rectangle{
        anchors.fill: parent
        id: backRect
        color: "#f8f8ff"
        //color: "#606470"
        Component.onCompleted: focus = true;



        Image {
            id: backGroundTP
            source: "qrc:/trustedBack.png"
            width: backRect.width
            height: backRect.height
            opacity: 0.4
        }

        Connections{
            target: myClient
            onStartReadPays: {
                //paytimer.start()

                payModel.clear()

               // myClient.showPayments();

                for(var i = 0; i < myClient.payTableLength(); ++i)
                {
                    if (myClient.givePayCash(i)[0] !== '0')
                        payModel.append({"date": myClient.givePayTime(i),
                                            "cash": myClient.givePayCash(i),
                                            "comment": myClient.givePayComm(i)})
                }

                payListView.model = payModel;
                myClient.makeBusyOFF();

            }
        }

        ListModel {
            id: payModel
        }

        ListView{
            id: payListView
            visible: true
            anchors.fill: parent
            width: mainwnd.width
            height: mainwnd.height
            smooth: true
            //focus: true
            maximumFlickVelocity: 1000000
            //headerPositioning: ListView.PullBackHeader
            clip: true
            spacing: 15
            //anchors.topMargin: 10
            //anchors.bottomMargin: 10
            delegate: paydelegate

            header: Item {
                width: parent.width
                height: 20
            }
        }


        Component{
            id: paydelegate
            Item {
                width: mainwnd.width
                height: mainwnd.height / 5
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 15
                Rectangle{
                    id: payUnit
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: mainwnd.width - 30
                    height: parent.height - 2
                    radius: 8
                    Rectangle{
                        id: payUnitLine
                        anchors.top: payUnit.top
                        anchors.topMargin: payUnit.height / 3
                        height: 3
                        width: payUnit.width - 20
                        color: backRect.color
                        border.width: 1
                        border.color: "#E3EAEA"
                    }

                    Rectangle{
                        id: kindOfPay
                        width: 12
                        height: 12
                        radius: 30
                        color: cash[0] === '-'? "#93deff" : "lightgreen"
                        anchors.left: payUnit.left
                        anchors.leftMargin: 15
                        y: payUnit.y + (payUnit.height / 3) * 0.4
                    }

                    Text {
                        id: payDate
                        text: date
                        font.family: openSansCondensed.name;
                        font.pointSize: 22
                        color: "#0074e4"
                        anchors.right: payUnit.right
                        anchors.rightMargin: 20
                        anchors.verticalCenter: kindOfPay.verticalCenter
                    }

                    Text {
                        id: payCash
                        text: cash
                        font.family: openSansCondensed.name;
                        font.pointSize: 20
                        color: "gray"
                        anchors.left: payUnit.left
                        anchors.leftMargin: 40
                        anchors.verticalCenter: kindOfPay.verticalCenter
                    }


                    Rectangle{
                        id: commentItem
                        anchors.horizontalCenter: payUnit.horizontalCenter
                        anchors.top: payUnitLine.bottom
                        anchors.topMargin: 6
                        anchors.bottomMargin: 6
                        width: payUnit.width - 45
                        height: (payUnit.height - payUnit.height / 3) - 20
                        color: "transparent"
                        //color: "gray"

                        Text {
                            id: payComment
                            text: comment
                            font.family: openSansCondensed.name;
                            //font.pointSize: 8
                            minimumPointSize: 10
                            font.pointSize: 16
                            fontSizeMode: Text.Fit
                            width: parent.width
                            height: parent.height
                            color: "black"
                            //                            anchors.topMargin: 5
                            anchors.verticalCenter: commentItem.verticalCenter
                            anchors.horizontalCenter: commentItem.horizontalCenter
                        }

                    }



                    border.color: "#E3EAEA"
                    border.width: 0.5



                }
            }
        }

    }

}




















