#include "UserModel.h"

#include <QAbstractTableModel>
#include <QDateTime>
#include <QDebug>
#include <QSqlRecord>
#include <QString>

UserModel::UserModel(QObject* parent) : QAbstractListModel(parent) {
    ReadDataFromSQLite();
    /* setPageSize(10);
     QStringList userFeild;
     userFeild.push_back("LoginName");
     userFeild.push_back("UserName");
     userFeild.push_back("Department");
     setRoles(userFeild);*/
}

UserModel::~UserModel() {}

int UserModel::rowCount(const QModelIndex& parent) const {
    Q_UNUSED(parent);
    return m_data.size();
}

QVariant UserModel::data(const QModelIndex& index, int role) const {
    if (!index.isValid())
        return QVariant();

    UserModelFieldData Data = m_data.at(index.row());

    if (role == NameRole)
        return Data.username;
    else if (role == PasswordRole)
        return Data.userpassword;
    else if (role == UserRole)
        return Data.userrole;

    return QVariant();
    return role;
}

/**
 * @brief 设置每条记录的字段在QML中应使用的名称。必须实现
 * @return
 */
QHash<int, QByteArray> UserModel::roleNames() const {
    QHash<int, QByteArray> roles;

    roles[NameRole] = "name";
    roles[PasswordRole] = "password";
    roles[UserRole] = "userrole";

    return roles;
}

void UserModel::ReadDataFromSQLite() {
    QSqlQuery query;
    QString sqlStatement1 = QString("SELECT * FROM UserInfo");

    if (query.exec(sqlStatement1)) {
        int numberOfRows = 0;
        if (query.last()) {
            numberOfRows = query.at();
            query.first();
            query.previous();
        }
        //取当前表格到rec
        QSqlRecord rec = query.record();

        for (int i = 0; i < numberOfRows; i++) {
            while (query.next()) {
                QVariantList list1;
                //把每一条记录的内容存到list1中
                for (int j = 0; j < rec.count(); j++) {
                    list1.push_back(query.value(j).toString());
                }
                //再将每一条记录放到m_nodelist文件列表中，元素是每一条记录
                UserModelFieldData ChildData;
                ChildData.username = list1.at(1).toString();
                ChildData.userpassword = list1.at(2).toString();
                ChildData.userrole = list1.at(4).toString();

                m_data.push_back(ChildData);
            }
            beginInsertRows(QModelIndex(), 0, static_cast<int>(m_data.size()));
            endInsertRows();
        }
    }
}

QString UserModel::curuser() { return CurUser; }

void UserModel::setcuruser(QString user) {
    CurUser = user;
    QString role;
    for (int i = 0; i < m_data.size(); i++) {
        if (m_data[i].username == CurUser) {
            role = m_data[i].userrole;
            break;
        }
    }
    CurRole = role;
    emit soleChanged();
}
QString UserModel::cursole() { return CurRole; }
