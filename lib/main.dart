import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/cubit_app.dart/cubit_shop.dart';
import 'package:flutter_application_1/cubit_app.dart/states_shop.dart';
import 'package:flutter_application_1/dio_helper.dart';
import 'package:flutter_application_1/modules.dart/home.dart';
import 'package:flutter_application_1/modules.dart/layout_screen.dart';
import 'package:flutter_application_1/modules.dart/login_scrren.dart';
import 'package:flutter_application_1/shared_prefrance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CachHelper.init();
  bool? onbording = CachHelper.getData(
    key: 'onBording',
  );
  Widget widget;
  token = CachHelper.getData(
    key: 'token',
  );
  if (onbording != null) {
    if (token != null) {
      widget = const LayoutScreen();
    } else {
      widget = Shoplogin();
    }
  } else {
    widget = onboardingScreen();
  }

  runApp(MyApp(
    startewidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startewidget;
  MyApp({required this.startewidget});

  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: ((context) => ShopCubit()
                ..GetHomeData()
                ..GetCategoriesData()..GetFavData()..GetProfileData()))
        ],
        child: BlocConsumer<ShopCubit, ShopState>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false,
              darkTheme: ThemeData(
                scaffoldBackgroundColor: HexColor('333739'),
                primarySwatch: Colors.deepOrange,
                // scaffoldBackgroundColor: Colors.white,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: HexColor('333739'),
                ),
                appBarTheme: AppBarTheme(
                  titleSpacing: 20,
                  iconTheme: IconThemeData(color: Colors.white),
                  backgroundColor: HexColor('333739'),
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.light,
                      statusBarColor: HexColor('333739')),
                  // ignore: deprecated_member_use
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  elevation: 0,
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
              theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.white,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                ),
                appBarTheme: const AppBarTheme(
                  titleSpacing: 20,

                  iconTheme: IconThemeData(color: Colors.black),
                  backgroundColor: Colors.white,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.dark,
                      statusBarColor: Colors.white),
                  // ignore: deprecated_member_use
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  elevation: 0,
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
              ),
              home: startewidget,
            );
          },
        ));
  }
}
