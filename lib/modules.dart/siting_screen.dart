import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/cubit_app.dart/cubit_shop.dart';
import 'package:flutter_application_1/cubit_app.dart/states_shop.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Sitings extends StatelessWidget {
  const Sitings({super.key});

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var namecontroller = TextEditingController();
    var emailcontroller = TextEditingController();
    var phonecontroller = TextEditingController();
    return BlocConsumer<ShopCubit, ShopState>(
      listener: ((context, state) {}),
      builder: ((context, state) {
        var model = ShopCubit.get(context).profilModel;
        emailcontroller.text = model!.Data!.email!;
        namecontroller.text = model.Data!.name!;
        phonecontroller.text = model.Data!.phone!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).profilModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  if (state is LoadingUpdateState) LinearProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        labelText: 'name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty ';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        labelText: 'email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'emailAddress must not be empty ';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: phonecontroller,
                      decoration: InputDecoration(
                        labelText: 'phone',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty ';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: defaulltColor,
                        borderRadius: BorderRadius.circular(15.0)),
                    height: 60,
                    width: double.infinity,
                    child: MaterialButton(
                      child: Text(
                        'SIGN OUT',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        SignOut(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: defaulltColor,
                        borderRadius: BorderRadius.circular(15.0)),
                    height: 60,
                    width: double.infinity,
                    child: MaterialButton(
                      child: Text(
                        'UP DATE',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          ShopCubit.get(context).GetUpdateData(
                              email: emailcontroller.text,
                              name: namecontroller.text,
                              phone: phonecontroller.text);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      }),
    );
  }
}
