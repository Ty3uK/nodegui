#pragma once

#include <napi.h>
#include <stdlib.h>

#include <QMouseEvent>

#include "core/Component/component_macro.h"

class QMouseEventWrap : public Napi::ObjectWrap<QMouseEventWrap> {
 private:
  QMouseEvent* instance;

 public:
  static Napi::Object init(Napi::Env env, Napi::Object exports);
  QMouseEventWrap(const Napi::CallbackInfo& info);
  ~QMouseEventWrap();
  QMouseEvent* getInternalInstance();
  // class constructor
  static Napi::FunctionReference constructor;
  // wrapped methods
  Napi::Value button(const Napi::CallbackInfo& info);
  Napi::Value x(const Napi::CallbackInfo& info);
  Napi::Value y(const Napi::CallbackInfo& info);
  Napi::Value globalX(const Napi::CallbackInfo& info);
  Napi::Value globalY(const Napi::CallbackInfo& info);

  COMPONENT_WRAPPED_METHODS_DECLARATION
};