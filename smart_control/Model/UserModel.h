#ifndef USERMODEL_H
#define USERMODEL_H

#include <QAbstractItemModel>
#include <QObject>
#include <QString>
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlQuery>

class UserModelFieldData {
  public:
    QString username;
    QString userpassword;
    QString userrole;
};

class UserModel : public QAbstractListModel {
    Q_OBJECT
  public:
    explicit UserModel(QObject* parent = nullptr);
    virtual ~UserModel() override;

    Q_PROPERTY(QString CurUser READ curuser WRITE setcuruser)//存储当前登录的用户
    Q_PROPERTY(QString CurRole READ cursole NOTIFY soleChanged)//存储当前登录的用户

    enum Roles { NameRole = Qt::UserRole + 1, PasswordRole, UserRole };
    // 3个实例化需要重写的虚函数
    QVariant data(const QModelIndex& index, int role) const override;
    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    QHash<int, QByteArray> roleNames() const override;  //重新实现roleNames()
    void ReadDataFromSQLite();
    QString curuser();
    void setcuruser(QString user);
    QString cursole();

signals:
    void soleChanged();

  private:
    QList<UserModelFieldData> m_data;  //总数据
    QString CurUser;
    QString CurRole;
};
#endif  // USERMODEL_H
