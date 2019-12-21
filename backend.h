#pragma once


//#include "myclient.h" //////////////////////////////////////////////////////////////////

#include <QMainWindow>
#include <QObject>
#include <QString>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QApplication>
#include <QGeoPositionInfoSource>
#include <QDesktopServices>
#include <QWindow>
#include <QGuiApplication>
#include <cmath>


//#include <QSplashScreen>
//#include <QPixmap>

class location
{
public:
    double longitude, latitude;
    QString address;
    double t_long, t_lat;

    location() = default;
    location(const double &lon, const double &lat):longitude(lon), latitude(lat){}
    location(const double &lon, const double &lat,
             const QString &addr, const double &t_long, const double &t_lat):
        longitude(lon), latitude(lat), address(addr), t_long(t_long), t_lat(t_lat) {}

    double ShowDiff(const location &first, const location &second) const {
        return std::abs(pow(pow((second.latitude - first.latitude), 2)
                            + pow((second.longitude - first.longitude), 2), 0.5));
    }

    bool operator <(const location &obj) const {
        location temp(this->longitude, this->latitude);
        location own(t_long, t_lat);
        return ShowDiff(own, temp) < ShowDiff(own, obj);
    }

    bool operator >(const location &obj) const {
        location temp(this->longitude, this->latitude);
        location own(t_long, t_lat);
        return ShowDiff(own, temp) > ShowDiff(own, obj);
    }

};


class BackEnd : public QObject
{
    Q_OBJECT
    //Q_PROPERTY(QString userName READ userName WRITE setUserName NOTIFY userNameChanged)
    //Q_PROPERTY(QString text MEMBER m_text NOTIFY textChanged)

public:
    BackEnd(QObject *parent = nullptr);
    QQmlContext *cont;
    QQmlApplicationEngine engine;

    QVector<location> cashpoints;

    location owner;
    QGeoPositionInfoSource *source = QGeoPositionInfoSource::createDefaultSource(this);
    QRect displaySize;


public slots:
    void trustedPay();
    QString showATM();
    void callUs();
    void goUrl();
    void goValue();
    void social();
    void go_OSM_url();
    double p_point_long(int i);
    double p_point_lat(int i);
    double p_owner_long();
    double p_owner_lat();

    QString getToken();
    int p_count();
    void shareLink();

};














