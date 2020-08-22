TEMPLATE = app

QT += quick
QT += core
CONFIG += c++11
QT += core gui
QT += core gui sql
QT += positioning
QT += network
QT += widgets





#QT += androidextras

#QT += concurrent
#QT += androidextras

#QT += quick qml network positioning

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS
DEFINES += QTFIREBASE_BUILD_MESSAGING




# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += main.cpp \
    backend.cpp \
    myclient.cpp \
    notificationworker.cpp \
    permissions.cpp

RESOURCES += qml.qrc \
    data.qrc

#INCLUDEPATH += C:/new/prefix1/

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = $$PWD

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    backend.h \
    myclient.h \
    notificationworker.h \
    permissions.h


CONFIG += mobitity
MOBILITY =



contains(ANDROID_TARGET_ARCH,x86_64) {
QT += androidextras
    ANDROID_EXTRA_LIBS = \
   # C:/Users/gregory/source/Qt/SuccessApp/libcrypto_64.so \
   # C:/Users/gregory/source/Qt/SuccessApp/libssl_64.so

    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android
    QMAKE_LFLAGS += -nostdlib++
}


contains(ANDROID_TARGET_ARCH,x86) {
QT += androidextras
    ANDROID_EXTRA_LIBS = \
   # C:/Users/gregory/source/Qt/SuccessApp/libcrypto.so \
   # C:/Users/gregory/source/Qt/SuccessApp/libssl.so

    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android
    QMAKE_LFLAGS += -nostdlib++
}

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
QT += androidextras
    ANDROID_EXTRA_LIBS = \
    C:/Users/gregory/source/Qt/SuccessApp/libcrypto.so \
    C:/Users/gregory/source/Qt/SuccessApp/libssl.so

    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android
    QMAKE_LFLAGS += -nostdlib++
}

contains(ANDROID_TARGET_ARCH,arm64-v8a) {
QT += androidextras
    ANDROID_EXTRA_LIBS = \
    C:/Users/gregory/source/Qt/SuccessApp/libcrypto_64.so \
    C:/Users/gregory/source/Qt/SuccessApp/libssl_64.so

    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android

    QMAKE_LFLAGS += -nostdlib++
#include(android-openssl.pri)
}


android: {

    ANDROID_PACKAGE_SOURCE_DIR = $$PLATFORMS_DIR/android

    FIREBASE_SDK = D:/firebase_cpp_sdk/

    INCLUDEPATH += $${FIREBASE_SDK}/include/

#    QML_IMPORT_PATH += D:/firebase_cpp_sdk/

#    QML2_IMPORT_PATH += D:/firebase_cpp_sdk/


    DISTFILES += \
        $$ANDROID_PACKAGE_SOURCE_DIR/AndroidManifest.xml \
        $$ANDROID_PACKAGE_SOURCE_DIR/build.gradle \
        $$ANDROID_PACKAGE_SOURCE_DIR/settings.gradle \
        $$ANDROID_PACKAGE_SOURCE_DIR/gradle.properties \
        $$ANDROID_PACKAGE_SOURCE_DIR/local.properties \
        $$ANDROID_PACKAGE_SOURCE_DIR/google-services.json \
        $$ANDROID_PACKAGE_SOURCE_DIR/src/com/success/android/firebasetest/Main.java \
        $$ANDROID_PACKAGE_SOURCE_DIR/res/values/apptheme.xml \
        $$ANDROID_PACKAGE_SOURCE_DIR/res/values/strings.xml \
        $$ANDROID_PACKAGE_SOURCE_DIR/res/drawable/splash.xml \
        $$ANDROID_PACKAGE_SOURCE_DIR/gradlew \
        $$ANDROID_PACKAGE_SOURCE_DIR/gradlew.bat \
        $$ANDROID_PACKAGE_SOURCE_DIR/gradle/wrapper/gradle-wrapper.jar \
        $$ANDROID_PACKAGE_SOURCE_DIR/gradle/wrapper/gradle-wrapper.properties
}

DISTFILES += \
    android/AndroidManifest.xml \
    android/RegistrationIntentService.java \
    android/google-services.json \
    android/gradle.properties \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/local.properties \
    android/res/values/color.xml \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    ShowPermissionRationale.java \
    android/settings.gradle \
    android/src/com/success/android/firebasetest/ListenerService.java \
    #android/src/com/success/android/firebasetest/MyFirebaseMessagingService.java \
    android/src/com/success/android/firebasetest/Share.java \
    issue_report_1.qml \
    issue_report_2.qml \



ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

QTFIREBASE_CONFIG += messaging auth


#include(../extensions/QtFirebase/qtfirebase.pri)







































