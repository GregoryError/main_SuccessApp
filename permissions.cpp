// Object to request permissions from the Android system
#include "permissions.h"
//#include <QMessageBox>

Permissions::Permissions(QObject *parent) : QObject(parent)
{
}

// Method to request permissions
//void Permissions::requestExternalStoragePermission()
//{
//    #if defined(Q_OS_ANDROID)

//        QtAndroid::PermissionResult request = QtAndroid::checkPermission("android.permission.READ_EXTERNAL_STORAGE");
//        if (request == QtAndroid::PermissionResult::Denied)
//        {
//            QtAndroid::requestPermissionsSync(QStringList() <<  "android.permission.READ_EXTERNAL_STORAGE");
//            request = QtAndroid::checkPermission("android.permission.READ_EXTERNAL_STORAGE");

//            if (request == QtAndroid::PermissionResult::Denied)
//            {
//                this->permissionResult = false;
//                if (QtAndroid::shouldShowRequestPermissionRationale("android.permission.READ_EXTERNAL_STORAGE"))
//                {
//                    ShowPermissionRationale = QAndroidJniObject("org/bytran/bytran/ShowPermissionRationale",
//                                                                "(Landroid/app/Activity;)V",
//                                                                 QtAndroid::androidActivity().object<jobject>()
//                                                               );

//                    // Checking for errors in the JNI
//                    QAndroidJniEnvironment env;
//                    if (env->ExceptionCheck()) {
//                        // Handle exception here.
//                        env->ExceptionClear();
//                    }
//                }
//            }
//            else { this->permissionResult = true; }
//        }
//        else { this->permissionResult = true; }

//    #else

//        this->permissionResult = false;

//    #endif
//}

void Permissions::requestPreciseLocationPermission()
{
#if defined(Q_OS_ANDROID)

    QtAndroid::PermissionResult request = QtAndroid::checkPermission("android.permission.ACCESS_FINE_LOCATION");
    if (request == QtAndroid::PermissionResult::Denied)
    {
        QtAndroid::requestPermissionsSync(QStringList() <<  "android.permission.ACCESS_FINE_LOCATION");
        request = QtAndroid::checkPermission("android.permission.ACCESS_FINE_LOCATION");

        if (request == QtAndroid::PermissionResult::Denied)
        {
            this->permissionResult = false;
            if (QtAndroid::shouldShowRequestPermissionRationale("android.permission.ACCESS_FINE_LOCATION"))
            {
                ShowPermissionRationale = QAndroidJniObject("org/bytran/bytran/ShowPermissionRationale",
                                                            "(Landroid/app/Activity;)V",
                                                             QtAndroid::androidActivity().object<jobject>()
                                                           );

                // Checking for errors in the JNI
                QAndroidJniEnvironment env;
                if (env->ExceptionCheck()) {
                    // Handle exception here.
                    env->ExceptionClear();
                }
            }
        }
        else { this->permissionResult = true; }
    }
    else { this->permissionResult = true; }

#else

    this->permissionResult = false;

#endif
}

void Permissions::requestLocationPermission()
{
#if defined(Q_OS_ANDROID)

    QtAndroid::PermissionResult request = QtAndroid::checkPermission("android.permission.ACCESS_COARSE_LOCATION");
    if (request == QtAndroid::PermissionResult::Denied)
    {
        QtAndroid::requestPermissionsSync(QStringList() <<  "android.permission.ACCESS_COARSE_LOCATION");
        request = QtAndroid::checkPermission("android.permission.ACCESS_COARSE_LOCATION");

        if (request == QtAndroid::PermissionResult::Denied)
        {
            this->permissionResult = false;
            if (QtAndroid::shouldShowRequestPermissionRationale("android.permission.ACCESS_COARSE_LOCATION"))
            {
                ShowPermissionRationale = QAndroidJniObject("org/bytran/bytran/ShowPermissionRationale",
                                                            "(Landroid/app/Activity;)V",
                                                             QtAndroid::androidActivity().object<jobject>()
                                                           );

                // Checking for errors in the JNI
                QAndroidJniEnvironment env;
                if (env->ExceptionCheck()) {
                    // Handle exception here.
                    env->ExceptionClear();
                }
            }
        }
        else { this->permissionResult = true; }
    }
    else { this->permissionResult = true; }

#else

    this->permissionResult = false;

#endif
}

//void Permissions::requestPhoneCallPermission()
//{
//#if defined(Q_OS_ANDROID)

//    QtAndroid::PermissionResult request = QtAndroid::checkPermission("android.permission.CALL_PHONE");
//    if (request == QtAndroid::PermissionResult::Denied)
//    {
//        QtAndroid::requestPermissionsSync(QStringList() <<  "android.permission.CALL_PHONE");
//        request = QtAndroid::checkPermission("android.permission.CALL_PHONE");

//        if (request == QtAndroid::PermissionResult::Denied)
//        {
//            this->permissionResult = false;
//            if (QtAndroid::shouldShowRequestPermissionRationale("android.permission.CALL_PHONE"))
//            {
//                ShowPermissionRationale = QAndroidJniObject("org/bytran/bytran/ShowPermissionRationale",
//                                                            "(Landroid/app/Activity;)V",
//                                                             QtAndroid::androidActivity().object<jobject>()
//                                                           );

//                // Checking for errors in the JNI
//                QAndroidJniEnvironment env;
//                if (env->ExceptionCheck()) {
//                    // Handle exception here.
//                    env->ExceptionClear();
//                }
//            }
//        }
//        else { this->permissionResult = true; }
//    }
//    else { this->permissionResult = true; }

//#else

//    this->permissionResult = false;

//#endif
//}





// Method to get the permission granted state
bool Permissions::getPermissionResult() { return permissionResult; }











































