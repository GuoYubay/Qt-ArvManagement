#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSqlDatabase>
#include <QSqlQuery>
#include "QDebug"
#include <QDir>
#include "./Model/LoginDbOperateModel.h"
#include "./Model/MenuModel.h"
#include "./Model/UserModel.h"

int main(int argc, char* argv[]) {
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    //定义数据库路径
    QSqlDatabase mydatabase=QSqlDatabase::addDatabase("QSQLITE");
    QString currentPath;
    currentPath=QCoreApplication::applicationDirPath();
    mydatabase.setDatabaseName(QString("%1/ArvInfo.db").arg(currentPath));
    qDebug()<<"currentPaht is "<<currentPath;



    //TaoQuickImportPath 指向TaoQuick核心库的qmldir文件所在路径，
    engine.addImportPath(TaoQuickImportPath);
    engine.rootContext()->setContextProperty("taoQuickImagePath", TaoQuickImagePath);
    LoginDbOperate loginModel;
    engine.rootContext()->setContextProperty("LoginModel",&loginModel);

    //菜单模型
    MenuModel menuModel;
    engine.rootContext()->setContextProperty("MenuModel", &menuModel);

    UserModel userModel;
    userModel.setcuruser("admin");
    engine.rootContext()->setContextProperty("UserModel", &userModel);

    // 加载登陆界面   写主页面先把登陆界面注释掉 111
   // engine.load(QUrl(QStringLiteral("qrc:/View/LoginPage/LoginPage.qml")));
    // 加载主界面
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
   // QList<QObject*> objs = engine.rootObjects();
    //登陆界面可见
   // objs.at(0)->setProperty("visible", true);
    //主界面不可见
   // objs.at(1)->setProperty("visible", false);
   // IsLogin isLogin(objs);
  //  QObject::connect(&loginModel, &LoginDbOperate::IsLogined,
  //                   &isLogin,&IsLogin::openMainWindow);
    //const QUrl url();
   /* QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &app,
        [url](QObject* obj, const QUrl& objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);*/


    return app.exec();
}
