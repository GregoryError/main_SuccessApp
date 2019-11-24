import QtQuick 2.0

import QtLocation 5.6
import QtPositioning 5.6

import QtQuick 2.9



Item {
    id: mainField

    FontLoader { id: openSansCondensed; source: "/fonts/openSansCondensed_Light.ttf" }

    Plugin {
        id: mapPlugin
        name: "osm"

    }

    Rectangle {
        id: mapItem
        anchors.fill: parent
        color: "#f7f7f7"

        Text {
            id: header
            anchors.top: mapItem.top
            anchors.topMargin: 10
            anchors.horizontalCenter: mapItem.horizontalCenter
            font.family: openSansCondensed.name;
            font.pointSize: 16
            color: "#0074e4"
            text: "Сейчас ближайшие точки оплаты: ";


        }

        Image {
            id: markerImg
            source: "qrc:/map_item.png"
            //anchors.verticalCenter: pointsList_1.verticalCenter
            anchors.top: pointsList_1.top
            anchors.left: mapItem.left
            anchors.leftMargin: 10
            height: pointsList_1.paintedHeight - 10
            width: height


        }

        Text {
            id: pointsList_1
            anchors.top: header.bottom
            anchors.topMargin: 8
            anchors.horizontalCenter: mapItem.horizontalCenter
            font.family: openSansCondensed.name;
            font.pointSize: 14
            text: BackEnd.showATM();

        }

        Text {
            id: rights_txt
            anchors.top: pointsList_1.bottom
            anchors.topMargin: 2
            anchors.horizontalCenter: mapItem.horizontalCenter
            font.family: openSansCondensed.name;
            width: mapItem.width - 16
            minimumPointSize: 7
            font.pointSize: 12
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            //text: "Map (C) GIScience Research Group @ University of Heidelberg | Data (C) OpenStreetMap contributors | Style (C) Maxim Rylov"
            text: "© Участники OpenStreetMap   © OpenStreetMap contributors"
        }


        Map {
            id: osmap
            color: "steelblue"
            //width: mapItem.width
            implicitWidth: mapItem.width

            //height: mapItem.height * 0.8
            anchors.bottom: mapItem.bottom
            anchors.top: rights_txt.bottom
            anchors.topMargin: 10
            plugin: mapPlugin
            // 51.507294, -0.127719 - London
            center: QtPositioning.coordinate(BackEnd.p_owner_long(), BackEnd.p_owner_lat())
            tilt: 30
            Component.onCompleted:{
                myClient.makeBusyOFF();
                ownerPointcircleAnimation.start();
                focus = true;
                console.log("BackEnd.p_owner_long() = " + BackEnd.p_owner_long() + " BackEnd.p_owner_lat() = " + BackEnd.p_owner_lat())
            }
            zoomLevel: 15
            onCopyrightLinkActivated: {
                BackEnd.go_OSM_url();
            }

            // onZoomLevelChanged: ownerPointcircleAnimation.start()


            MapQuickItem {
                id: ownerMarker
                // anchorPoint.x: image.width/2
                // anchorPoint.y: image.height
                coordinate: QtPositioning.coordinate(BackEnd.p_owner_long(), BackEnd.p_owner_lat());


                sourceItem: Rectangle{
                    id: ownerPoint
                    width: 20
                    height: 20
                    radius: 50
                    color: "#0074e4"
                    transform: Translate {
                        x: -ownerPoint.width / 2
                        y: -ownerPoint.height / 2
                    }

                    Image {
                        id: owner_image
                        anchors.centerIn: ownerPoint
                        anchors.horizontalCenter: ownerPoint.horizontalCenter
                        source: "qrc:/you_re_here.png"
                        width: 35
                        height: 35
                    }
                }


                ParallelAnimation {
                    id: ownerPointcircleAnimation
                    loops: 3

                    running: false
                    NumberAnimation {
                        id: ownerPointAnimation
                        target: ownerPoint;
                        properties: "width,height,radius";
                        from: ownerPoint.width;
                        to: ownerPoint.width * 12;
                        duration: 800;
                        easing.type: Easing.OutExpo

                    }

                    NumberAnimation {
                        id: ownerPointOpacityAnimation
                        target: ownerPoint;
                        //easing.type: Easing.InExpo;
                        properties: "opacity";
                        from: 0.6;
                        to: 0;
                        duration: 750;

                    }

                    onStopped: {
                        ownerPoint.width = 100
                        ownerPoint.height = 100
                        ownerPoint.radius = 50
                        ownerPoint.opacity = 0.4
                    }

                }

            }


            Repeater{
                id: p_rep
                model: BackEnd.p_count();

                MapQuickItem {
                    id: p_item
                    coordinate: QtPositioning.coordinate(BackEnd.p_point_long(index), BackEnd.p_point_lat(index));
                    sourceItem: Image {
                        id: p_image
                        source: "qrc:/map_item.png"
                        width: 40
                        height: 40
                    }
                }

            }

        }

    }

}
































