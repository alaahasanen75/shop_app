import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'dart:html';

import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/cubit_app.dart/states_shop.dart';
import 'package:flutter_application_1/dio_helper.dart';
import 'package:flutter_application_1/end_point.dart';
import 'package:flutter_application_1/modules.dart/Fav_Modle.dart';
import 'package:flutter_application_1/modules.dart/categories_model.dart';
import 'package:flutter_application_1/modules.dart/categoris.dart';
import 'package:flutter_application_1/modules.dart/change_fav.dart';
import 'package:flutter_application_1/modules.dart/fav_screen.dart';
import 'package:flutter_application_1/modules.dart/home_model.dart';
import 'package:flutter_application_1/modules.dart/prodact_screen.dart';
import 'package:flutter_application_1/modules.dart/profil_screen.dart';
import 'package:flutter_application_1/modules.dart/siting_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(InitialShopState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreen = [
    Prodact(),
    categories(),
    fav(),
    Sitings(),
  ];

  void ChangeBottomNav(int index) {
    index = currentIndex;
    emit(ChangeBottomNavState());
  }

  Map<int, bool>? favorites = {};
  HomeModel? homemodel;
  void GetHomeData() {
    emit(ShoploadingState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homemodel = HomeModel.fromJson(value.data);
      homemodel!.data!.product.forEach((element) {
        favorites!.addAll({element.id!: element.infav!});
      });
      emit(ShopSuccessState());
    }).catchError((onError) {
      emit(ShopErrorState(onError));
    });
  }

  CategotiesModel? categoriesModel;

  void GetCategoriesData() {
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value) {
      categoriesModel = CategotiesModel.fromJson(value.data);

      emit(ShopSuccessCategoryState());
    }).catchError((onError) {
      emit(ShopErrorCategoryState(onError));
    });
  }

  ChangeFavModel? changeFavModel;
  void ChangeFavoritsData(int? prodductId) {
    favorites![prodductId!] = !favorites![prodductId]!;
    emit(ShopChangeFavState());
    DioHelper.postData(data: {
      'product_id': prodductId,
    }, url: FAVORITES, token: token)
        .then((value) {
      changeFavModel = ChangeFavModel.fromjson(value.data);

      if (!changeFavModel!.statuse!) {
        favorites![prodductId] = !favorites![prodductId]!;
      } else {
        GetFavData();
      }
      emit(ShopSuccessChangeFavState(changeFavModel));
    }).catchError((onError) {
      favorites![prodductId] = !favorites![prodductId]!;
      emit(ShopErrorChangeFavState(onError));
    });
  }

  FavModle? favModle;

  void GetFavData() {
    emit(FavloadingState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favModle = FavModle.fromJson(value.data);

      emit(ShopSuccessFavState());
    }).catchError((onError) {
      emit(ShopErrorFavState(onError));
    });
  }

  ProfilModel? profilModel;
  void GetProfileData() {
    emit(LoadingProfileState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      profilModel = ProfilModel.fromJson(value.data);

      emit(SuccessProfileState(profilModel));
    }).catchError((onError) {
      emit(ErrorProfileState(onError));
    });
  }

  void GetUpdateData({
    required String email,
    required String name,
    required String phone,
  }) {
    emit(LoadingUpdateState());
    DioHelper.putData(
      data: {
        'email': email,
        'name': name,
        'phone': phone,
      },
      url: UPDATE_PROFILE,
      token: token,
    ).then((value) {
      profilModel = ProfilModel.fromJson(value.data);

      emit(SuccessUpdateState(profilModel));
    }).catchError((onError) {
      emit(ErrorUpdateState(onError));
    });
  }
}
