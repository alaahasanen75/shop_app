import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/cubit_app.dart/cubit_shop.dart';
import 'package:flutter_application_1/modules.dart/search_model.dart';
import 'package:flutter_application_1/search_cubit/cubit_search.dart';
import 'package:flutter_application_1/search_cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var searchcontroller = TextEditingController();

    return BlocProvider(
        create: (context) => CubitSearch(),
        child: BlocConsumer<CubitSearch, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: searchcontroller,
                        decoration: const InputDecoration(
                          labelText: 'Search',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Search not be empty ';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) =>
                            CubitSearch.get(context).Search(value),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (state is LoadingSearchStates)
                        LinearProgressIndicator(),
                      if (state is SuccessSearchStates)
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) => BuildFavItem(
                                  CubitSearch.get(context)
                                      .model!
                                      .data!
                                      .data![index],
                                  context,
                                  Oldprice: false),
                              separatorBuilder: (context, index) =>
                                  MyProvider(),
                              itemCount: CubitSearch.get(context)
                                  .model!
                                  .data!
                                  .data!
                                  .length),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  Widget BuildFavItem(Product? modle, context, {bool Oldprice = true}) =>
      Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: 120,
          child: Row(
            children: [
              Stack(
                children: [
                  Image(
                    image: NetworkImage('${modle!.image}'),
                    width: 120,
                    height: 120.0,
                  ),
                  if (modle.discount != 0 && Oldprice)
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
                      '${modle.name}',
                      style: TextStyle(fontSize: 14, height: 1.3),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${modle.price.round()}',
                          style: TextStyle(fontSize: 12, color: defaulltColor),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (modle.discount != 0 && Oldprice)
                          Text(
                            '${modle.oldPrice.round()}',
                            style: TextStyle(
                                fontSize: 12,
                                color: defaulltColor,
                                decoration: TextDecoration.lineThrough),
                          ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .ChangeFavoritsData(modle.id);
                            },
                            padding: EdgeInsets.zero,
                            icon: CircleAvatar(
                              backgroundColor:
                                  ShopCubit.get(context).favorites![modle.id]!
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
