import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/cubit_app.dart/cubit_shop.dart';
import 'package:flutter_application_1/cubit_app.dart/states_shop.dart';
import 'package:flutter_application_1/modules.dart/Fav_Modle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class fav extends StatelessWidget {
  const fav({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: ((context, state) {}),
      builder: ((context, state) {
        return ConditionalBuilder(
          condition: state is! FavloadingState,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => BuildFavItem(
                  ShopCubit.get(context).favModle!.data!.data![index], context),
              separatorBuilder: (context, index) => MyProvider(),
              itemCount: ShopCubit.get(context).favModle!.data!.data!.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      }),
    );
  }

  Widget BuildFavItem(FavData? modle, context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: 120,
          child: Row(
            children: [
              Stack(
                children: [
                  Image(
                    image: NetworkImage('${modle!.product!.image}'),
                    width: 120,
                    height: 120.0,
                  ),
                  if (modle.product!.discount != 0)
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
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${modle.product!.name}',
                      style: TextStyle(fontSize: 14, height: 1.3),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${modle.product!.price.round()}',
                          style: TextStyle(fontSize: 12, color: defaulltColor),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (modle.product!.discount != 0)
                          Text(
                            '${modle.product!.oldPrice.round()}',
                            style: TextStyle(
                                fontSize: 12,
                                color: defaulltColor,
                                decoration: TextDecoration.lineThrough),
                          ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .ChangeFavoritsData(modle.product!.id);
                            },
                            padding: EdgeInsets.zero,
                            icon: CircleAvatar(
                              backgroundColor: ShopCubit.get(context)
                                      .favorites![modle.product!.id]!
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
              ),
            ],
          ),
        ),
      );
}
