import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules.dart/login_model.dart';

abstract class LoginShopAppStates {}

class InitialLoginShopAppState extends LoginShopAppStates {}

class LoadingLoginShopAppState extends LoginShopAppStates {}

class SuccessfulyLoginShopAppState extends LoginShopAppStates {
  final LoginModel? model;
  SuccessfulyLoginShopAppState(this.model);
}

class ErrorLoginShopAppState extends LoginShopAppStates {
  final String error;
  ErrorLoginShopAppState(this.error);
}

class ChangePasswordShopAppState extends LoginShopAppStates {}
