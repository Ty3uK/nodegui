#pragma once

#include <napi.h>
#include <stdlib.h>

#include <QPointer>

#include "QtWidgets/QAbstractButton/qabstractbutton_macro.h"
#include "QtWidgets/QWidget/qwidget_macro.h"
#include "nradiobutton.hpp"

class QRadioButtonWrap : public Napi::ObjectWrap<QRadioButtonWrap> {
 private:
  QPointer<NRadioButton> instance;

 public:
  static Napi::Object init(Napi::Env env, Napi::Object exports);
  QRadioButtonWrap(const Napi::CallbackInfo& info);
  ~QRadioButtonWrap();
  NRadioButton* getInternalInstance();
  // class constructor
  static Napi::FunctionReference constructor;
  // wrapped methods

  QABSTRACTBUTTON_WRAPPED_METHODS_DECLARATION
};
