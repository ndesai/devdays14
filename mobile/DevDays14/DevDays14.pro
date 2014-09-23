TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    src/screenvalues.cpp

RESOURCES += qml.qrc

osx {
    QMAKE_MAC_SDK = macosx10.9
}

ios {
    LIBS += -framework MobileCoreServices
    LIBS += -framework MessageUI
    LIBS += -framework iAd
    LIBS += -L/Users/niraj/SDK/QtEnterprise/5.3/ios/qml/st/app/platform/ -lPlatformPlugin
}

android {
    QT += androidextras
}

include(deployment.pri)

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += \
    android/AndroidManifest.xml \
    android/src/com/iktwo/qtdevdays14/DevDays.java

lupdate_only{
    SOURCES = qml/*.qml \
        qml/android/*.qml
}

HEADERS += \
    src/screenvalues.h
