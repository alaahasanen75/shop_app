import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/cubit/state_screen.dart';
import 'package:flutter_application_1/dio_helper.dart';
import 'package:flutter_application_1/end_point.dart';
import 'package:flutter_application_1/modules.dart/search_model.dart';
import 'package:flutter_application_1/search_cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitSearch extends Cubit<SearchStates> {
  CubitSearch() : super(InitialSearchStates());

  static CubitSearch get(context) => BlocProvider.of(context);
  SearchModel? model;
  void Search(String text) {
    emit(LoadingSearchStates());
    DioHelper.postData(
      token: token,
      
      url: SEARCH, data: {'text': text}).then((value) {
      emit(SuccessSearchStates());
      model = SearchModel.fromJson(value.data);
    }).catchError((onError) {
      emit(ErrorSearchStates(onError));
    });
  }
}
