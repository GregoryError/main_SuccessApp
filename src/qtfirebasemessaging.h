#ifndef QTFIREBASE_MESSAGING_H
#define QTFIREBASE_MESSAGING_H

#include "firebase/app.h"
#include "firebase/messaging.h"
#include "firebase/util.h"


#include <QDebug>
#include <QObject>
#include <QString>
#include <QVariantMap>
#include <QVariantList>
#include <QQmlParserStatus>
#include <QMetaMethod>



class MessageListener : public QObject, public firebase::messaging::Listener
{
    Q_OBJECT

public:
    MessageListener(QObject* parent = nullptr);

    virtual void OnMessage(const ::firebase::messaging::Message& message) override;
    virtual void OnTokenReceived(const char* token) override;

    QVariantMap data();
    void setData(const QVariantMap &data);

    QString token();
    void setToken(const QString &token);

protected:
    void connectNotify(const QMetaMethod &signal) override;

signals:
    void emitMessageReceived();
    void onMessageReceived();
    void onTokenReceived();
    void onConnected();

private:
    QVariantMap _data;
    QString _token;
    bool _messageReceivedConnected = false;
    bool _tokenReceivedConnected = false;

    bool _notifyMessageReceived = false;
    bool _notifyTokenReceived = false;
};


#endif // QTFIREBASE_MESSAGING_H
