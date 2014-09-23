#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlExtensionPlugin>
#include <QQmlContext>

#include "src/uivalues.h"

#define QML_DEVELOPMENT "qrc:/qml/dev.qml"

#if defined(Q_OS_IOS)
Q_IMPORT_PLUGIN(PlatformPlugin)
#endif

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QString mainQml = QStringLiteral(QML_DEVELOPMENT);

#ifdef Q_OS_IOS
    mainQml = QStringLiteral("qrc:/qml/main_ios.qml");
#elif defined(Q_OS_ANDROID)
    mainQml = QStringLiteral("qrc:/qml/main_android.qml");
/// TODO: Q_OS_BLACKBERRY || Q_OS_WINPHONE
#endif
    UIValues uiValues;
    engine.rootContext()->setContextProperty(QStringLiteral("ui"), &uiValues);

    engine.load(QUrl(mainQml));

    return app.exec();
}
