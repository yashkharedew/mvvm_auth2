// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppException implements Exception {
  String? _message;
  String? _prefix;
  AppException([this._message, this._prefix]);

  String toString() {
    return '$_message+$_prefix';
  }
}

// visit https://www.educative.io/answers/what-is-the-super-keyword-in-dart for super() in dart
// super() is use for accessing parent class properties and methods

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Error during fetching data');
}

class BadDataException extends AppException {
  BadDataException([String? message])
      : super(message, 'No internet connection');
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message])
      : super(message, 'Unauthorized request');
}

class InvalidInputRequestException extends AppException {
  InvalidInputRequestException([String? message])
      : super(message, 'Invalid request');
}
