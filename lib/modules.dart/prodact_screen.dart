import 'dart:html';
import 'dart:js';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/cubit_app.dart/cubit_shop.dart';
import 'package:flutter_application_1/cubit_app.dart/states_shop.dart';
import 'package:flutter_application_1/modules.dart/categories_model.dart';
import 'package:flutter_application_1/modules.dart/home_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Prodact extends StatelessWidget {
  const Prodact({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: ((context, state) {
        if (state is ShopSuccessChangeFavState) {
          if (!state.Model!.statuse!) {
            ShowToast(msg: state.Model!.massage, states: ToastStates.ERROR);
          }
        }
      }),
      builder: ((context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homemodel != null &&
                ShopCubit.get(context).categoriesModel != null,
            builder: ((context) => ProductBuider(
                ShopCubit.get(context).homemodel,
                ShopCubit.get(context).categoriesModel,
                context)),
            fallback: ((context) => Center(
                  child: CircularProgressIndicator(),
                )));
      }),
    );
  }

  Widget ProductBuider(HomeModel? model, CategotiesModel? Model, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model!.data?.banner
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  viewportFraction: 1.0,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                )),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'categories',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) =>
                            BuildCategories(Model.data!.data![index])),
                        separatorBuilder: ((context, index) => SizedBox(
                              width: 10,
                            )),
                        itemCount: Model!.data!.data!.length),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'new product',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.58,
                children: List.generate(
                  model.data!.product.length,
                  (index) =>
                      BuildGridProduct(model.data!.product[index], context),
                  // BuildGridProduct(  model!.data!.product[index])
                ),
              ),
            )
          ],
        ),
      );

  Widget BuildGridProduct(ProductModel? model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image(
                  image: NetworkImage('${model!.image}'),
                  width: double.infinity,
                  height: 200.0,
                ),
                if (model.discount! != 0)
                  Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    style: TextStyle(fontSize: 14, height: 1.3),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(fontSize: 12, color: defaulltColor),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount! != 0)
                        Text(
                          '${model.oldprice.round()}',
                          style: TextStyle(
                              fontSize: 12,
                              color: defaulltColor,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context).ChangeFavoritsData(model.id);
                          },
                          padding: EdgeInsets.zero,
                          icon: CircleAvatar(
                            backgroundColor:
                                ShopCubit.get(context).favorites![model.id]!
                                    ? defaulltColor
                                    : Colors.grey,
                            radius: 15,
                            child: Icon(
                              Icons.favorite_border,
                              size: 14,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
  // ignore: non_constant_identifier_names
  Widget BuildCategories(DataGModel? category) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage('${category!.image}'),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Container(
              color: Colors.black.withOpacity(.8),
              width: 100,
              child: Text(
                '${category.name}',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))
        ],
      );
}
