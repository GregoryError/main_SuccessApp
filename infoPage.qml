import QtQuick 2.0
import QtQuick.Controls 2.0

Item {

    Image {
        id: backGroundTP
        source: "qrc:/trustedBack.png"
        anchors.fill: parent

        Flickable{
            id: trustedFlick
            width: backGroundTP.width
            height: backGroundTP.height
            anchors.horizontalCenter: backGroundTP.horizontalCenter
            contentHeight: aboutTxt.height + e_mail.height + 1000
            contentWidth: parent.width
            smooth: true
            boundsBehavior: Flickable.StopAtBounds
            interactive: true
            maximumFlickVelocity: 1000000
            clip: true


            Text {
                id: aboutTxt
                anchors.top: parent.top
                anchors.topMargin: 10
                width: backGroundTP.width * 0.9
                height: backGroundTP.height * 0.9
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                // 36_armeabi_v7a   38_armeabi_v7a   39_arm_v8a
                // 40_v7a_API_23-28  38_v7a_API_19-22
                text: "    Успех личный кабинет код версии: <br>
                           44_v7_API_19-29 <br>
                           Данное приложение издается как <br>
                           приложение с открытым исходным кодом, <br>
                           оно является бесплатым <br>
                           и может быть использовано Вами <br>
                           в любых законных целях и любым <br>
                           законным способом.<br>
                           В случае, если Вы хотите получить <br>
                           экземпляр исходного кода, напишите <br>
                           об этом разработчику на: <br>
                           errorgrisha@gmail.com <br>
                           Картографические материалы <br>
                           используются под открытой лицензией <br>
                           сообщества creativecommons.org, <br>
                           и являются частью открытого проекта <br>
                           opendatacommons.org.<br>
                           Подробнее: www.openstreetmap.org/copyright <br>

                           This open sourse app is <br>
                           absolutely free for using <br>
                           in any legal purposes. <br>
                           In case you want to get a source code <br>
                           of the application please feel free <br>
                           to ask developer about it: <br>
                           errorgrisha@gmail.com <br>
                           The cartographical materials <br>
                           are licensed under <br>
                           the creativecommons.org community <br>
                           and are part of <br>
                           the open source project opendatacommons.org. <br>
                           Details: www.openstreetmap.org/copyright
                           <br> Любые Ваши вопросы и предложения:"
                color: "white"
            }

            Text {
                id: e_mail
                anchors.top: aboutTxt.bottom
                anchors.topMargin: 50
                anchors.horizontalCenter: aboutTxt.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 18
                color: "white"
                text: "<br><br>errorgrisha@gmail.com"
            }
        }
    }
}
































