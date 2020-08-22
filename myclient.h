//#ifndef _MyClient_h_
//#define _MyClient_h_
#pragma once


#include <QClipboard>
#include <QApplication>
#include <QWidget>
#include <QDataStream>
#include <QTime>
#include <QSslSocket>
#include <QString>
#include <QSettings>
#include <QByteArray>
#include <QDateTime>
#include <QStringList>

// ======================================================================


class MyClient : public QObject { //QWidget {
    Q_OBJECT

private:

    QString msgToSend;
    enum add_method{need_hash, no_hash};

public:
    // Q_PROPERTY(QString input WRITE setInputValue
    //                          READ inputValue
    //                          NOTIFY inputValueChanged)

    //QSslSocket* m_pTcpSocket;
    QSharedPointer<QSslSocket> m_pTcpSocket;
    QString m_ptxtInfo;
    QString m_ptxtInput;
    quint16 m_nNextBlockSize;
    QString idNumber, balance, state, pay_day, paket;
    QString payments;
    QString msgs;
    QString issue_msg;
    int Port;
    QVector<QString> times_vct, cashes_vct, comments_vct;
    QString serverDateTime;
    QMap<int, QString> msg_lines;
    QSettings dataSet;
    QString enteredName;
    QString enteredPass;
    QString loginResult = "По каким-то причинам<br>не удается войти в систему.<br>"
                          "Проверьте сетевое подключение.";
    bool isAuthOk = false;        ///////////////////// ?
    bool isConnect = false;
    bool demo = false;
    bool noCert = false;

    QClipboard *buf = QApplication::clipboard();

    bool acc_check = false;

    QString link_str;

    MyClient(QWidget* pwgt = nullptr);
    void Sender(const QString& msg);
    void connectToHost();
    Q_INVOKABLE void setAuthData(QString name, QString pass);
    // Посылает запрос за стартовыми данными getAllData

    void saveToken(const QString tk);

signals:
    void startReadInfo();
    void startReadPays();
    void switchToHomePage();
    void busyON();
    void busyOFF();
    void trustedPayOk();
    void trustedPayDenied();
    // Messages:
    void startReadMsgs();  // можно начинать читать вектора с сообщениями


    void goodValidation();
    void startFillAccList();
    void accessDenied();



public slots:
    bool isAuth();               // Возвращает что в QSettings
    QString authResult();        // Возвращает строку loginResult
    bool isAuthRight();          // Возвращает флажек isAuthOk
    void quitAndClear();         // Очищает все строки с данными и данные в QSettings
    void showPayments();         // Наполняет контейнеры данными из базы
    void askForPayments();       // Посылает (логин#gпароль#askPayments!")
    void askForTrustedPay();     // Посылает (логин#gпароль#requestTrustedPay")
    bool showDemo();
    int payTableLength();        // Возвращает кол-во строк в списке платежей
    void sendToken();

    // void fillHomePage();

    // void fillPaysPage();

    void switchToMe();

    void makeBusyON();
    void makeBusyOFF();

    QString givePayTime(int strN);   // Возвращает строку "время" с заданным индексом
    QString givePayCash(int strN);   // Возвращает строку "cash" с заданным индексом
    QString givePayComm(int strN);   // Возвращает строку "коммент" с заданным индексом

    void slotReadyRead();
    void slotConnected();
    void slotError(QAbstractSocket::SocketError);
    QString showPlan();
    QString showBill();
    QString showId();
    QString showPay_day();
    bool showState();
    void setAuthOn();
    void setAuthNo();

    void copyToBuf();

    // msgs:

    void askForMsgs();
    void showMsgs();
    void sendMsgs(QString str);

    QString giveMsgLine(int index);
    long giveMsgTime(int i) { auto beg = msg_lines.begin(); return (beg + i).key(); }
    int msgMapSize() { return msg_lines.size(); }

    QString convertTime(int val);

    QString serverDate();
    QString serverTime();
    QString nextPayDay();

    void fillHomePage();

    //~MyClient() { m_pTcpSocket->deleteLater(); }

    void checkState();
    void closeIfInProcess();
    bool isConnectingState();

    void addNextIssuePart(QString str);
    void clearIssue_msg();
    void sendIssueMsg();
    bool is_Show_Val_Quest();
    void set_Show_Val_toFalse();
    void postWorker();

    // multi-accaunt

    QString showActiveName();
    bool addAccaunt(QString name, QString pass, add_method need_hs = need_hash);
    int accauntListSize();
    QString getAccauntName(int ind);
    void switchToAccaunt(QString name);
    void accauntValidation(QString name, QString pass);
    void clrAccaunt(QString name);
    void refreshAccList();



};


//#endif  //_MyClient_h_







































