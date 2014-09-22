#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlExtensionPlugin>

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
/// TODO: Q_OS_ANDROID || Q_OS_BLACKBERRY || Q_OS_WINPHONE
#endif
    engine.load(QUrl(mainQml));

    return app.exec();
}
