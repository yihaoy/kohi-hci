#include "KotiController.h"

KotiController::KotiController(KotiModel *kotiModel, QObject *parent)
    : QObject { parent }
    , m_kotiModel { kotiModel }
{

}

bool KotiController::desktopMode() const
{
    return m_desktopMode;
}

void KotiController::setDesktopMode(bool newDesktopMode)
{
    if (m_desktopMode == newDesktopMode)
        return;
    m_desktopMode = newDesktopMode;
    emit desktopModeChanged();
}
