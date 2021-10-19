#ifndef LOGINDBOPERATEMODEL_H
#define LOGINDBOPERATEMODEL_H

#include <QDebug>
#include <QObject>
class LoginDbOperate : public QObject {
    Q_OBJECT
  public:
    LoginDbOperate();
    virtual ~LoginDbOperate(){};
    Q_INVOKABLE bool checkUserExists(const QString LoginName);
    Q_INVOKABLE bool checkPasswrodExists(const QString& LoginName, const QString& LoginPassword);
    Q_INVOKABLE void isLogin(bool form1Visible, bool form2Visible);
  signals:
    void IsLogined(bool form1Visible, bool form2Visible);

  private:
    void init(void);
};

class IsLogin : public QObject {
    Q_OBJECT
  public:
    IsLogin(QList<QObject*> objs) { m_objs = objs; }
    void openMainWindow(bool form1Visible, bool form2Visible) {
        m_objs.at(0)->setProperty("visible", form1Visible);
        m_objs.at(1)->setProperty("visible", form2Visible);
    }

  private:
    QList<QObject*> m_objs;
};

#endif  // LOGINDBOPERATEMODEL_H
