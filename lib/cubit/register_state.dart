import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules.dart/login_model.dart';

abstract class RegisterShopAppStates {}

class InitialRegisterShopAppState extends RegisterShopAppStates {}

class LoadingRegisterShopAppState extends RegisterShopAppStates {}

class SuccessfulyRegisterShopAppState extends RegisterShopAppStates {
  final LoginModel? model;
  SuccessfulyRegisterShopAppState(this.model);
}

class ErrorRegisterShopAppState extends RegisterShopAppStates {
  final String error;
  ErrorRegisterShopAppState(this.error);
}

class ChangePasswordRegisterState extends RegisterShopAppStates {}
