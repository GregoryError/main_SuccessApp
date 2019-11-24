#include "qtfirebasemessaging.h"

#include <QGuiApplication>
#include <QQmlParserStatus>

#include <stdint.h>
#include "firebase/app.h"
#include "firebase/internal/common.h"
#include "firebase/messaging.h"
#include "firebase/util.h"

namespace messaging = ::firebase::messaging;


MessageListener::MessageListener(QObject* parent)
    : QObject(parent)
{
}

void MessageListener::OnMessage(const messaging::Message &message)
{
    // When messages are received by the server, they are placed into an
    // internal queue, waiting to be consumed. When ProcessMessages is called,
    // this OnMessage function is called once for each queued message.

    QVariantMap data;

    if (message.notification) {
        if (!message.notification->title.empty()) {
            const QString key = QStringLiteral("nTitle");
            const QString value = QString::fromStdString(message.notification->title.c_str());
            data.insert(key, value);
        }
        if (!message.notification->body.empty()) {
            const QString key = QStringLiteral("nBody");
            const QString value = QString::fromStdString(message.notification->body.c_str());
            data.insert(key, value);
        }
        if (!message.notification->icon.empty()) {
            const QString key = QStringLiteral("nIcon");
            const QString value = QString::fromStdString(message.notification->icon.c_str());
            data.insert(key, value);
        }
        if (!message.notification->tag.empty()) {
            const QString key = QStringLiteral("nTag");
            const QString value = QString::fromStdString(message.notification->tag.c_str());
            data.insert(key, value);
        }
        if (!message.notification->color.empty()) {
            const QString key = QStringLiteral("nColor");
            const QString value = QString::fromStdString(message.notification->color.c_str());
            data.insert(key, value);
        }
        if (!message.notification->sound.empty()) {
            const QString key = QStringLiteral("nSound");
            const QString value = QString::fromStdString(message.notification->sound.c_str());
            data.insert(key, value);
        }
        if (!message.notification->click_action.empty()) {
            const QString key = QStringLiteral("nClickAction");
            const QString value = QString::fromStdString(message.notification->click_action.c_str());
            data.insert(key, value);
        }
    }

    if (message.notification_opened) {
        const QString key = QStringLiteral("launchnotification");
        data.insert(key, true);
    }

    for (const auto& field : message.data)
    {
        const QString key = QString::fromStdString(field.first);
        const QString value = QString::fromStdString(field.second);

        data.insert(key, value);
    }

    setData(data);
}

void MessageListener::OnTokenReceived(const char *token)
{
    setToken(QString::fromUtf8(token));
}

void MessageListener::connectNotify(const QMetaMethod &signal)
{
    if (signal == QMetaMethod::fromSignal(&MessageListener::onMessageReceived)) {
        _messageReceivedConnected = true;

        if(_notifyMessageReceived) {
            emit onMessageReceived();
            _notifyMessageReceived = false;
        }
    }

    if (signal == QMetaMethod::fromSignal(&MessageListener::onTokenReceived)) {
        _tokenReceivedConnected = true;

        if(_notifyTokenReceived) {
            emit onTokenReceived();
            _notifyTokenReceived = false;
        }
    }
}

QVariantMap MessageListener::data()
{
    return _data;
}

void MessageListener::setData(const QVariantMap &data)
{
    if (_data != data) {
        _notifyMessageReceived = true;
        _data = data;

        if(_messageReceivedConnected) {
            emit onMessageReceived();
            _notifyMessageReceived = false;
        }
    }
}

QString MessageListener::token()
{
    return _token;
}

void MessageListener::setToken(const QString &token)
{
    if (_token != token) {
        _notifyTokenReceived = true;
        _token = token;

        if(_tokenReceivedConnected) {
            emit onTokenReceived();
            _notifyTokenReceived = false;
        }
    }
}
