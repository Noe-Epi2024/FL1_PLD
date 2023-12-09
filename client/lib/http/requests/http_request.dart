import "package:flutter/material.dart";

abstract class HttpRequest<T> {
  @protected
  Uri get uri;

  @protected
  bool get private;
}
