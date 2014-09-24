TEMPLATE = app

QT += qml quick widgets sql multimedia network

SOURCES += main.cpp \
    src/screenvalues.cpp

RESOURCES += qml.qrc

osx {
    QMAKE_MAC_SDK = macosx10.9
}

ios {
    BUNDLE_DATA.files = $$PWD/ios/AppIcon29x29.png \
$$PWD/ios/AppIcon29x29@2x.png \
$$PWD/ios/AppIcon40x40.png \
$$PWD/ios/AppIcon40x40@2x.png \
$$PWD/ios/AppIcon50x50.png \
$$PWD/ios/AppIcon50x50@2x.png \
$$PWD/ios/AppIcon57x57.png \
$$PWD/ios/AppIcon57x57@2x.png \
$$PWD/ios/AppIcon60x60.png \
$$PWD/ios/AppIcon60x60@2x.png \
$$PWD/ios/AppIcon72x72.png \
$$PWD/ios/AppIcon72x72@2x.png \
$$PWD/ios/AppIcon76x76.png \
$$PWD/ios/AppIcon76x76@2x.png \
$$PWD/ios/Default-568h@2x.png \
$$PWD/ios/Default-480h@2x.png
$$PWD/ios/Default.png
    QMAKE_BUNDLE_DATA += BUNDLE_DATA
    QMAKE_INFO_PLIST = $$PWD/ios/Info.plist
    #QMAKE_IOS_TARGETED_DEVICE_FAMILY = 1


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
    android/src/com/iktwo/qtdevdays14/DevDays.java

lupdate_only{
    SOURCES = qml/*.qml \
        qml/android/*.qml
}

HEADERS += \
    src/screenvalues.h
