#pragma once

#include "KotiModel.h"

#include <QObject>

class KotiController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool desktopMode READ desktopMode WRITE setDesktopMode NOTIFY desktopModeChanged)

public:
    explicit KotiController(KotiModel *kotiModel, QObject *parent = nullptr);

    // Q_PROPERTY READ
    bool desktopMode() const;

    // Q_PROPERTY WRITE
    void setDesktopMode(bool newDesktopMode);

signals:
    // Q_PROPERTY NOTIFY
    void desktopModeChanged();

    void pushPage(KotiModel::KotiPage page);
    void popPage();
    void replacePage(KotiModel::KotiPage page);

private:
    KotiModel *m_kotiModel { nullptr };
    bool m_desktopMode { false };
};
