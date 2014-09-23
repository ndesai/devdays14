#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlExtensionPlugin>
#include <QQmlContext>
#include <qqml.h>

#include "src/screenvalues.h"

#define QML_DEVELOPMENT "qrc:/qml/dev.qml"

#if defined(Q_OS_IOS)
Q_IMPORT_PLUGIN(PlatformPlugin)
#endif

static QObject *screen_values_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    ScreenValues *screenValues = new ScreenValues();
    return screenValues;
}

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QString mainQml = QStringLiteral(QML_DEVELOPMENT);

    qmlRegisterSingletonType<ScreenValues>("DevDays14", 1, 0, "ScreenValues", screen_values_provider);

    /// TODO: Q_OS_BLACKBERRY || Q_OS_WINPHONE

#ifdef Q_OS_IOS
    mainQml = QStringLiteral("qrc:/qml/main_ios.qml");
#elif defined(Q_OS_ANDROID)
    mainQml = QStringLiteral("qrc:/qml/main_android.qml");
#endif

    engine.load(QUrl(mainQml));

    return app.exec();
}
