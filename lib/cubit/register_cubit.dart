import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/register_state.dart';
import 'package:flutter_application_1/cubit/state_screen.dart';
import 'package:flutter_application_1/dio_helper.dart';
import 'package:flutter_application_1/end_point.dart';
import 'package:flutter_application_1/modules.dart/login_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubitApp extends Cubit<RegisterShopAppStates> {
  RegisterCubitApp() : super(InitialRegisterShopAppState());

  static RegisterCubitApp get(context) => BlocProvider.of(context);
  LoginModel? model;
  void Register({required String email, required String password,
  required String name,
  required String phone,
  
  
  }) {
    emit(LoadingRegisterShopAppState());

    DioHelper.postData(
        url: REGISTER,

        data: {'email': email, 'password': password,


'name': name,
'phone': phone,




        }).then((value) {
    
      model = LoginModel.fromJson(value.data);
      print(model!.masage);
      print(model!.status);
      print(model!.Data!.token);

      emit(SuccessfulyRegisterShopAppState(model));
    }).catchError((error) {
      print(error!.toString());
      emit(ErrorRegisterShopAppState(error.toString()));
    });

// alaahasanen75@gmail.com
  }

  var ispassword = true;
  IconData suffix = Icons.visibility_outlined;
  void changePsswordRegisterVisibility() {
    ispassword = !ispassword;

    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordRegisterState());
  }
}
//   alaamohamed@#123