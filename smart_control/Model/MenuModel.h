#ifndef MENUMODEL_H
#define MENUMODEL_H

#include <QAbstractListModel>
#include <QtSql/QSqlQuery>

#include "QObject"
//  Model的每一条记录的字段信息
class FieldModelData {
  public:
    QString name;
    QString imagePath;
    QString qmlPath;
    QString group;
    bool isParent;
    bool isVisible;
    bool isAllow;
    int moduleID;
};

class MenuModel : public QAbstractListModel {
    Q_OBJECT
  public:
    MenuModel(QObject* parent = nullptr);
    ~MenuModel();

    //  定义枚举变量，为每条记录的字段都声明一个相应的role
    enum DataRoles {
        NameRole = Qt::UserRole + 1,
        ImageRole,
        QmlRole,
        GroupRole,
        IsParentRole,
        IsVisibleRole,
        ModuleID
    };

    int rowCount(const QModelIndex& parent /* = QModelIndex */) const;
    QVariant data(const QModelIndex& index, int role /* = Qt::DisplayRole */) const;
    Q_INVOKABLE void refresh(const QString& GroupNo);

  private:
    void ReadDataFromSQLite();  //   读数据库文件

  protected:
    QHash<int, QByteArray> roleNames() const;

  private:
    QList<FieldModelData> m_nodeList;
};
#endif  // MENUMODEL_H
