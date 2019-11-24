import QtQuick 2.0

Item {
    id: mainListItem


    Component.onCompleted:
    {
        myClient.makeBusyOFF();
        focus = true;
    }


    Rectangle{
        id: backRect
        anchors.fill: parent
        color: "#e6f8ff"
        z: 0


        Image {
            id: backGroundTP
            source: "qrc:/trustedBack.png"
            width: backRect.width
            height: backRect.height
            opacity: 0.6
            z: 1
        }

        Image {
            id: offiseList
            opacity: 0.8
            anchors.fill: parent
            width: mainListItem.width * 0.9
            height: mainListItem.height  * 0.9
            fillMode: Image.PreserveAspectFit
            source: "qrc:/PaySystems/materials/PayPointsList.png"
            z: 3
        }
    }

}
