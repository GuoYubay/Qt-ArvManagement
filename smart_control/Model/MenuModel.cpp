#include "MenuModel.h"

#include <QFile>
#include <QSqlRecord>

#include "QDebug"
MenuModel::MenuModel(QObject* parent) : QAbstractListModel(parent) { ReadDataFromSQLite(); }

MenuModel::~MenuModel() {}

void MenuModel::ReadDataFromSQLite() {
    QSqlQuery query;
    QString sqlStatement1 = QString("SELECT * FROM field_module");  //

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
                FieldModelData ChildData;
                ChildData.name = list1.at(0).toString();
                ChildData.group = list1.at(4).toString();
                ChildData.imagePath = list1.at(6).toString();
                ChildData.qmlPath = list1.at(2).toString();
                ChildData.isParent = list1.at(7).toBool();
                ChildData.isVisible = true;
                ChildData.moduleID = list1.at(1).toInt();
                m_nodeList.push_back(ChildData);
            }
            beginInsertRows(QModelIndex(), 0, static_cast<int>(m_nodeList.size()));
            endInsertRows();
        }
    }
}

/**
 * @brief 返回Model的总行数。必须实现
 * @param parent
 * @return
 */
int MenuModel::rowCount(const QModelIndex& parent /* = QModelIndex */) const {
    Q_UNUSED(parent)
    return static_cast<int>(m_nodeList.size());
    return 1;
}

/**
 * @brief 返回该标签的数据。必须实现
 * @param index  该标签在model中的索引值
 * @param role  该标签的角色
 * @return  该标签其角色所对应的数据
 */
QVariant MenuModel::data(const QModelIndex& index, int role /* = Qt::DisplayRole */) const {
    if (!index.isValid())
        return QVariant();

    FieldModelData Data = m_nodeList.at(index.row());

    if (role == NameRole)
        return Data.name;
    else if (role == QmlRole)
        return Data.qmlPath;
    else if (role == ImageRole)
        return Data.imagePath;
    else if (role == GroupRole)
        return Data.group;
    else if (role == IsParentRole)
        return Data.isParent;
    else if (role == IsVisibleRole)
        return Data.isVisible;

    return QVariant();
    return role;
}

/**
 * @brief 设置每条记录的字段在QML中应使用的名称。必须实现
 * @return
 */
QHash<int, QByteArray> MenuModel::roleNames() const {
    QHash<int, QByteArray> roles;

    roles[NameRole] = "name";
    roles[ImageRole] = "imagePath";
    roles[QmlRole] = "qmlPath";
    roles[GroupRole] = "group";
    roles[IsParentRole] = "isParent";
    roles[IsVisibleRole] = "isVisible";

    return roles;
}

/**
 * @brief 反转与该父条目处于同一组的所有子条目的isVisble属性
 * @param GroupNo  父条目所属组
 */
void MenuModel::refresh(const QString& GroupNo) {
    int Start = 0, End = 0;  //  记录该条目的行号
    bool isFirst = true;

    for (int i = 0; i < m_nodeList.size(); i++) {
        //  寻找相应的组号
        if (m_nodeList.at(i).group == GroupNo) {
            //  找到父条目，记录父条目的行号
            if (m_nodeList.at(i).isParent && isFirst) {
                Start = i;
                End = Start;
            }
            //  记录子条目的截止行号，且反转子条目的isVisble属性
            else {
                End++;
                // if (m_nodeList[i].isAllow) {
                //    m_nodeList[i].isVisible = !m_nodeList.at(i).isVisible;
                //} else {
                m_nodeList[i].isVisible = !m_nodeList[i].isVisible;
                //}
            }
        }
    }

    //  一定要发射该信号，否则View不会自动刷新
    emit dataChanged(index(Start), index(End));
}
