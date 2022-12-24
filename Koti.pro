QT += quick multimedia sql

SOURCES += $$files(*.cpp, true)

HEADERS += $$files(*.h, true)

RESOURCES += $$files(*.qrc, true)

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
