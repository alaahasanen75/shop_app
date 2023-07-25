import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/cubit_app.dart/cubit_shop.dart';
import 'package:flutter_application_1/cubit_app.dart/states_shop.dart';
import 'package:flutter_application_1/modules.dart/categories_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class categories extends StatelessWidget {
  const categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: ((context, state) {}),
      builder: ((context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => BuildCatItem(
                ShopCubit.get(context).categoriesModel!.data!.data![index]),
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                ),
            itemCount:
                ShopCubit.get(context).categoriesModel!.data!.data!.length);
      }),
    );
  }

  Widget BuildCatItem(DataGModel category) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${category.image}'),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              '${category.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
