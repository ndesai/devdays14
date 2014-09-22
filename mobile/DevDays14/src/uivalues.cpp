#include "uivalues.h"

#ifdef Q_OS_ANDROID
#include <QAndroidJniObject>
#endif

#include <QDebug>

UIValues::UIValues(QObject *parent) :
    QObject(parent),
    m_isTablet(false)
{
#ifdef Q_OS_ANDROID
    m_isTablet = QAndroidJniObject::callStaticMethod<jboolean>("com/iktwo/qtdevdays14/DevDays",
                                                               "isTablet", "()Z");
#endif
}

void UIValues::showMessage(const QString &message)
{
#ifdef Q_OS_ANDROID
    QAndroidJniObject::callStaticMethod<void>("com/iktwo/qtdevdays14/DevDays",
                                              "toast", "(Ljava/lang/String;)V",
                                              QAndroidJniObject::fromString(message).object<jstring>());
#else
    qDebug() << Q_FUNC_INFO << "not implemented yet";
    qDebug() << message;
#endif
}

bool UIValues::isTablet() const
{
    return m_isTablet;
}

void UIValues::setIsTablet(bool isTablet)
{
    if (m_isTablet == isTablet)
        return;

    m_isTablet = isTablet;
    emit isTabletChanged();
}
