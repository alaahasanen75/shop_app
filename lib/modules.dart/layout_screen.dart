import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/cubit_app.dart/cubit_shop.dart';
import 'package:flutter_application_1/modules.dart/login_scrren.dart';
import 'package:flutter_application_1/modules.dart/search_screen.dart';
import 'package:flutter_application_1/shared_prefrance.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: ((context) => Search())),
                    );
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 60.0,
            items: <Widget>[
              Icon(
                Icons.home,
                size: 30,
                semanticLabel: 'Home',
              ),
              Icon(
                Icons.apps,
                size: 30,
                semanticLabel: 'Categories',
              ),
              Icon(
                Icons.favorite,
                size: 30,
                semanticLabel: 'favorite',
              ),
              Icon(
                Icons.settings,
                size: 30,
                semanticLabel: 'settings',
              ),
            ],
            color: Colors.white,
            buttonBackgroundColor: Colors.white,
            backgroundColor: defaulltColor,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              cubit.ChangeBottomNav(index);
            },
            letIndexChange: (index) => true,
          ),
        );
      },
    );
  }
}
