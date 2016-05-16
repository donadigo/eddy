# Install script for directory: /home/donadigo/Projects/eddy/po

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/es/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/es.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/nl/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/nl.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/na/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/na.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ak/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ak.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/bi/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/bi.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/bg/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/bg.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/nb/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/nb.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/sq/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/sq.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/li/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/li.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/mr/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/mr.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/as/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/as.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/zh_CN/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/zh_CN.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/tr/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/tr.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ky/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ky.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/gl/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/gl.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/sn/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/sn.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/br/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/br.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/st/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/st.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/mo/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/mo.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ff/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ff.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/cy/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/cy.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/kw/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/kw.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/en_AU/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/en_AU.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/sa/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/sa.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/aa/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/aa.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ml/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ml.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/zh/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/zh.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/gn/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/gn.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/kn/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/kn.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/cu/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/cu.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/kl/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/kl.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/is/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/is.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ks/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ks.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/am/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/am.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ko/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ko.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/bn/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/bn.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/mi/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/mi.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/to/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/to.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/gd/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/gd.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/av/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/av.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/so/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/so.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/tw/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/tw.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/eu/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/eu.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/pt/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/pt.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/hz/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/hz.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/sg/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/sg.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/lb/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/lb.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ba/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ba.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ms/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ms.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/da/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/da.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/cv/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/cv.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ii/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ii.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ia/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ia.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/th/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/th.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/el/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/el.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/tt/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/tt.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/su/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/su.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/km/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/km.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ca/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ca.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ch/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ch.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/nn/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/nn.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/de/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/de.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/vo/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/vo.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/co/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/co.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/az/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/az.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/yo/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/yo.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/fj/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/fj.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/vi/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/vi.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/cr/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/cr.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/kg/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/kg.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ur/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ur.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ae/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ae.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/sm/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/sm.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/lo/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/lo.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/sc/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/sc.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/fi/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/fi.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/lu/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/lu.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/bm/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/bm.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/oc/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/oc.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/sd/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/sd.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/id/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/id.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ng/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ng.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/xh/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/xh.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/hi/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/hi.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/pa/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/pa.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ts/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ts.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/sl/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/sl.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/en_GB/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/en_GB.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/io/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/io.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/yi/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/yi.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/an/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/an.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/tk/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/tk.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/en_CA/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/en_CA.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/tn/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/tn.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/tl/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/tl.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/wo/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/wo.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/bh/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/bh.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ru/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ru.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ig/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ig.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/lg/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/lg.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/mt/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/mt.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ce/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ce.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/la/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/la.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/sma/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/sma.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/mh/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/mh.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/nv/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/nv.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/kr/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/kr.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ik/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ik.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/si/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/si.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/zu/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/zu.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ab/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ab.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/te/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/te.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/cs/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/cs.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ay/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ay.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ny/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ny.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/bs/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/bs.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ckb/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ckb.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/jv/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/jv.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/fr_CA/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/fr_CA.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/kj/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/kj.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ja/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ja.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ty/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ty.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/zh_HK/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/zh_HK.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/af/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/af.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/uk/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/uk.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/nr/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/nr.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/mk/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/mk.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/za/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/za.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/os/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/os.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ti/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ti.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ka/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ka.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/pt_BR/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/pt_BR.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ga/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ga.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/mg/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/mg.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/pi/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/pi.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ee/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ee.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/fa/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/fa.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ho/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ho.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ve/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ve.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ug/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ug.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/lv/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/lv.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/nd/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/nd.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/fo/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/fo.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/eo/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/eo.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ar/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ar.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/gv/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/gv.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/sr/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/sr.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/dz/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/dz.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/bo/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/bo.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/sw/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/sw.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/no/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/no.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ln/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ln.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/or/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/or.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/kk/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/kk.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ss/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ss.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ie/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ie.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ast/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ast.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/et/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/et.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/oj/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/oj.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/my/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/my.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ht/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ht.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/rn/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/rn.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/be/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/be.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/om/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/om.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/rm/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/rm.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ha/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ha.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/lt/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/lt.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/mn/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/mn.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/fr/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/fr.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/hy/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/hy.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ps/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ps.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ki/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ki.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/sv/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/sv.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/hu/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/hu.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/it/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/it.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/zh_TW/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/zh_TW.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ro/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ro.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/dv/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/dv.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/kv/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/kv.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/qu/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/qu.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/iu/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/iu.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/uz/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/uz.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/he/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/he.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/se/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/se.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/tg/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/tg.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/pl/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/pl.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/rw/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/rw.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/gu/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/gu.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/sk/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/sk.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/rue/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/rue.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/hr/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/hr.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ta/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ta.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/wa/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/wa.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ku/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ku.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/fy/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/fy.mo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale-langpack/ne/LC_MESSAGES" TYPE FILE RENAME "eddy.mo" FILES "/home/donadigo/Projects/eddy/build/po/ne.mo")
endif()

