// Object to request permissions from the Android system
#ifndef PERMISSIONS_H
#define PERMISSIONS_H

#include <QObject>
#include <QApplication>


#ifdef Q_OS_ANDROID
    #include <QAndroidJniObject>
    #include <QAndroidJniEnvironment>
    #include <QtAndroid>
#endif

class Permissions : public QObject
{
    Q_OBJECT
public:
    explicit Permissions(QObject *parent = nullptr);

    // Method to request permissions
   // void requestExternalStoragePermission();
    void requestLocationPermission();
    void requestPreciseLocationPermission();
   // void requestPhoneCallPermission();

    // Method to get the permission granted state
    bool getPermissionResult();

public slots:

private:

    // Variable indicating if the permission to read / write has been granted
    int permissionResult = 0;  //  true - "Granted", false - "Denied"

#if defined(Q_OS_ANDROID)

    // Object used to obtain permissions on Android Marshmallow
    QAndroidJniObject ShowPermissionRationale;

#endif

};

#endif // PERMISSIONS_H
