import 'package:flutter_application_1/modules.dart/change_fav.dart';
import 'package:flutter_application_1/modules.dart/profil_screen.dart';

abstract class ShopState {}

class InitialShopState extends ShopState {}

class ChangeBottomNavState extends ShopState {}

class ShoploadingState extends ShopState {}

class ShopSuccessState extends ShopState {}

class ShopErrorState extends ShopState {
  final String? error;
  ShopErrorState(this.error);
}

class ShopSuccessCategoryState extends ShopState {}

class ShopErrorCategoryState extends ShopState {
  final String? error;
  ShopErrorCategoryState(this.error);
}

class ShopChangeFavState extends ShopState {}

class ShopSuccessChangeFavState extends ShopState {
  final ChangeFavModel? Model;
  ShopSuccessChangeFavState(this.Model);
}

class ShopErrorChangeFavState extends ShopState {
  final String? error;
  ShopErrorChangeFavState(this.error);
}

class ShopSuccessFavState extends ShopState {}

class ShopErrorFavState extends ShopState {
  final String? error;
  ShopErrorFavState(this.error);
}

class FavloadingState extends ShopState {}

class LoadingProfileState extends ShopState {}

class SuccessProfileState extends ShopState {
  final ProfilModel? Model;
  SuccessProfileState(this.Model);
}

class ErrorProfileState extends ShopState {
  final String? error;
  ErrorProfileState(this.error);
}









class LoadingUpdateState extends ShopState {}

class SuccessUpdateState extends ShopState {
  final ProfilModel? Model;
  SuccessUpdateState(this.Model);
}

class ErrorUpdateState extends ShopState {
  final String? error;
  ErrorUpdateState(this.error);
}
