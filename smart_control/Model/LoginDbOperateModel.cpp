#include "LoginDbOperateModel.h"

#include <QSqlDatabase>
#include <QSqlQuery>

#include "QDebug"

LoginDbOperate::LoginDbOperate() { init(); }
//连接默认数据库和打开数据库
void LoginDbOperate::init() {
    QSqlDatabase db = QSqlDatabase::database();
    qDebug() << "数据库是否打开" << db.open();
}
//查询用户名是否正确
bool LoginDbOperate::checkUserExists(const QString LoginName) {
    QSqlQuery query;
    const QString sql = QString("select count(*) from UserInfo where UserName='%1';").arg(LoginName);
    if (query.exec(sql)) {
        if (query.next()) {
            const int counts = query.value(0).toInt();
            if (counts > 0)
                return true;
        }
    } else {
        qDebug() << "db check userinfo failed";
    }
    return false;
}
//查询密码是否正确
bool LoginDbOperate::checkPasswrodExists(const QString& LoginName, const QString& LoginPassword) {
    QSqlQuery query;
    const QString sql = QString("select PassWord from UserInfo where UserName='%1';").arg(LoginName);
    if (query.exec(sql)) {
        if (query.next()) {
            const QString loginPassword = query.value(0).toString();
            if (loginPassword == LoginPassword)
                return true;
        }
    } else {
        qDebug() << "db check user info failed";
    }
    return false;
}
//登录后发射登录窗口隐藏和显示主窗口的信号
void LoginDbOperate::isLogin(bool form1Visible, bool form2Visible) { emit(IsLogined(form1Visible, form2Visible)); }
