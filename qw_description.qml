import QtQuick 2.0
import QtQuick.Controls 2.2

Item {
    id: mainwnd

    FontLoader { id: openSansCondensed; source: "/fonts/openSansCondensed_Light.ttf" }


    Flickable {
        id: qwFlick
        anchors.fill: parent
        clip: true
        contentHeight: qw_IMG.height
        contentWidth: qw_IMG.width
        Image {
            id: qw_IMG
            source: "qrc:/PaySystems/materials/qiwi_desc.png"
            width: mainwnd.width
            fillMode: Image.PreserveAspectFit
            //height: backRect.height
            //opacity: 0.6
            //z: 1
        }

        Rectangle{
            id: countRect
            width: ls.width + 10
            height: ls.height + copyButt.height + 30
            anchors.bottom: qw_IMG.bottom
            anchors.bottomMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#93deff"


            Text {
                id: ls
                wrapMode: Text.Wrap
                anchors.horizontalCenter: parent.horizontalCenter

                font.pointSize: 20
                text: "Ваш счет: " + myClient.showId()
                color: "#112d4e"
            }
            Button {
                id: copyButt
                anchors.horizontalCenter: ls.horizontalCenter
                anchors.top: ls.bottom
                anchors.topMargin: 6
                height: ls.height * 0.8
                width: ls.width
                text: "копировать"
                background: Rectangle{
                    id: buttBack
                    anchors.fill: parent
                    color: "#eff0f4"
                    radius: 3
                }
                onClicked: myClient.copyToBuf();

                onPressed: buttBack.color = "#0074e4"

                onReleased: buttBack.color = "#eff0f4"
            }

        }


    }

}
