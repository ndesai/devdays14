#ifndef UIVALUES_H
#define UIVALUES_H

#include <QObject>

class UIValues : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isTablet READ isTablet NOTIFY isTabletChanged)
public:
    explicit UIValues(QObject *parent = 0);

    Q_INVOKABLE void showMessage(const QString &message);

    bool isTablet() const;
    void setIsTablet(bool isTablet);

signals:
    void isTabletChanged();

private:
    bool m_isTablet;
};

#endif // UIVALUES_H
