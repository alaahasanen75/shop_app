import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/state_screen.dart';
import 'package:flutter_application_1/dio_helper.dart';
import 'package:flutter_application_1/end_point.dart';
import 'package:flutter_application_1/modules.dart/login_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitApp extends Cubit<LoginShopAppStates> {
  CubitApp() : super(InitialLoginShopAppState());

  static CubitApp get(context) => BlocProvider.of(context);
  LoginModel? model;
  void UseLogin({required String email, required String password}) {
    emit(LoadingLoginShopAppState());

    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      print(value.data);
      model = LoginModel.fromJson(value.data);
      print(model!.masage);
      print(model!.status);
      print(model!.Data!.token);

      emit(SuccessfulyLoginShopAppState(model));
    }).catchError((error) {
      print(error!.toString());
      emit(ErrorLoginShopAppState(error.toString()));
    });

// alaahasanen75@gmail.com
  }

  var ispassword = true;
  IconData suffix = Icons.visibility_outlined;
  void changePsswordVisibility() {
    ispassword = !ispassword;

    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordShopAppState());
  }
}
//  