TEMPLATE = app

QT += qml quick widgets sql multimedia network

SOURCES += main.cpp \
    src/screenvalues.cpp

RESOURCES += qml.qrc

osx {
    QMAKE_MAC_SDK = macosx10.9
}


ios {
    # isa = XCBuildConfiguration;
    # ASSETCATALOG_COMPILER_APPICON_NAME = "AppIcon";

    BUNDLE_DATA.files = $$PWD/ios/LaunchScreen.xib \
    $$PWD/ios/Images.xcassets

    QMAKE_BUNDLE_DATA += BUNDLE_DATA
    QMAKE_INFO_PLIST = $$PWD/ios/Info.plist

    LIBS += -framework MobileCoreServices
    LIBS += -framework MessageUI
    LIBS += -framework iAd
    LIBS += -framework AudioToolbox
    LIBS += -L/Users/niraj/SDK/QtEnterprise/5.3/ios/qml/st/app/models/ -lModelsPlugin
    LIBS += -L/Users/niraj/SDK/QtEnterprise/5.3/ios/qml/st/app/platform/ -lPlatformPlugin
}

android {
    QT += androidextras
}

include(deployment.pri)

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += \
    android/AndroidManifest.xml \
    android/src/com/iktwo/qtdevdays14/DevDays.java \
    qml/views/TutorialSheet.qml

lupdate_only{
    SOURCES = qml/*.qml \
        qml/android/*.qml
}

HEADERS += \
    src/screenvalues.h
