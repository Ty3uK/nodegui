# Adds Qt support
# make sure you include this at the top of whichever Cmakelist file you are going to use.
# Need for automatic moc. Moc executable path is set in qt.cmake
set(CMAKE_AUTOMOC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(QT_VERSION_MAJOR 5)
set(QT_VERSION_MINOR 13)
add_executable(Qt5::moc IMPORTED)

function(AddQtSupport addonName)
    execute_process(COMMAND node -p "require('@nodegui/qode').qtHome"
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE QT_HOME_DIR
    )

    if(DEFINED ENV{QT_INSTALL_DIR})
        # Allows to use custom Qt installation via QT_INSTALL_DIR env variable
        message(STATUS "Using Custom QT installation for ${addonName} QT_INSTALL_DIR:$ENV{QT_INSTALL_DIR}")
        set(QT_HOME_DIR "$ENV{QT_INSTALL_DIR}")
    endif()

    string(REPLACE "\n" "" QT_HOME_DIR "${QT_HOME_DIR}")
    string(REPLACE "\"" "" QT_HOME_DIR "${QT_HOME_DIR}")

    if(APPLE) 
        set(CUSTOM_QT_MOC_PATH "${QT_HOME_DIR}/bin/moc")

        target_include_directories(${addonName} PRIVATE
            "${QT_HOME_DIR}/include"
            "${QT_HOME_DIR}/lib/QtCore.framework/Versions/5/Headers"
            "${QT_HOME_DIR}/lib/QtGui.framework/Versions/5/Headers"
            "${QT_HOME_DIR}/lib/QtWidgets.framework/Versions/5/Headers"
            "${QT_HOME_DIR}/lib/QtSvg.Framework/Versions/5/Headers"
        )
        target_link_libraries(${addonName} PRIVATE
            "${QT_HOME_DIR}/lib/QtCore.framework/Versions/5/QtCore"
            "${QT_HOME_DIR}/lib/QtGui.framework/Versions/5/QtGui"
            "${QT_HOME_DIR}/lib/QtWidgets.framework/Versions/5/QtWidgets"
            "${QT_HOME_DIR}/lib/QtSvg.framework/Versions/5/QtSvg"
        )
    endif()

    if (WIN32)
        set(CUSTOM_QT_MOC_PATH "${QT_HOME_DIR}\\bin\\moc.exe")
       
        target_include_directories(${addonName} PRIVATE
            "${QT_HOME_DIR}\\include"
            "${QT_HOME_DIR}\\include\\QtCore"
            "${QT_HOME_DIR}\\include\\QtGui"
            "${QT_HOME_DIR}\\include\\QtWidgets"
            "${QT_HOME_DIR}\\include\\QtSvg"
        )
        target_link_libraries(${addonName} PRIVATE
            "${QT_HOME_DIR}\\lib\\Qt5Core.lib"
            "${QT_HOME_DIR}\\lib\\Qt5Gui.lib"
            "${QT_HOME_DIR}\\lib\\Qt5Widgets.lib"
            "${QT_HOME_DIR}\\lib\\Qt5Svg.lib"
        )
    endif()

    if(UNIX AND NOT APPLE)
        set(LINUX TRUE)
    endif()

    if(LINUX)
        set(CUSTOM_QT_MOC_PATH "${QT_HOME_DIR}/bin/moc")
        target_include_directories(${addonName} PRIVATE
            "${QT_HOME_DIR}/include"
            "${QT_HOME_DIR}/include/QtCore"
            "${QT_HOME_DIR}/include/QtGui"
            "${QT_HOME_DIR}/include/QtWidgets"
            "${QT_HOME_DIR}/include/QtSvg"
        )
        target_link_libraries(${addonName} PRIVATE
            "${QT_HOME_DIR}/lib/libQt5Core.so"
            "${QT_HOME_DIR}/lib/libQt5Gui.so"
            "${QT_HOME_DIR}/lib/libQt5Widgets.so"
            "${QT_HOME_DIR}/lib/libQt5Svg.so"
        )
    endif()    
    
    # set custom moc executable location
    set_target_properties(Qt5::moc PROPERTIES IMPORTED_LOCATION "${CUSTOM_QT_MOC_PATH}")
    
endfunction(AddQtSupport addonName)
