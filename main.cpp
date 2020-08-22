#include "myclient.h"
#include "backend.h"
#include "permissions.h"
#include <QPointer>
#include <QMessageBox>


int main(int argc, char *argv[])
{

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);
    QApplication app(argc, argv);

    Permissions permission;

    // permission.requestExternalStoragePermission();

    permission.requestLocationPermission();
    permission.requestPreciseLocationPermission();

    app.setApplicationDisplayName("Успех");
    app.setOrganizationName("Success");
    app.setOrganizationDomain("www.comfort-tv.ru/");
    app.setApplicationName("Success");

    //MyClient* client = new MyClient;
    // BackEnd* obj = new BackEnd;

    QPointer<MyClient> client(new MyClient);
    QPointer<BackEnd> obj (new BackEnd);

    obj->cont->setContextProperty("myClient", client);



    if (!permission.getPermissionResult() && !client->isAuth())
    {
        QMessageBox msgBox;
        msgBox.setText("Доступ к местоположению не разрешен Вами. "
                       "Одна из функций приложения не будет работать.");
        msgBox.exec();
        app.quit();
    }

    client->saveToken(obj->getTok());   // FCM token

    return app.exec();
}




