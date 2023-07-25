import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/cubit/register_cubit.dart';
import 'package:flutter_application_1/cubit/register_state.dart';
import 'package:flutter_application_1/modules.dart/layout_screen.dart';
import 'package:flutter_application_1/shared_prefrance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var namecontroller = TextEditingController();
    var phonecontroller = TextEditingController();
    var emailcontroller = TextEditingController();
    var passwordcontroller = TextEditingController();

    return BlocProvider(
        create: (context) => RegisterCubitApp(),
        child: BlocConsumer<RegisterCubitApp, RegisterShopAppStates>(
            listener: (context, state) {
          if (state is SuccessfulyRegisterShopAppState) {
            if (state.model!.status!) {
              print(state.model!.masage!);
              print(state.model!.Data!.token!);
              CachHelper.SaveData(
                      value: state.model!.Data!.token!, key: 'token')
                  .then((value) {
                token = state.model!.Data!.token!;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: ((context) => LayoutScreen())),
                    (route) => false);
              });
            } else {
              print(state.model!.masage!);
              ShowToast(msg: state.model!.masage!, states: ToastStates.ERROR);
            }
          }
        }, builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REGISTER',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black),
                          ),
                          SizedBox(height: 15),
                          Text('register now to browser our hot offers',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.grey)),
                          SizedBox(height: 40),
                          TextFormField(
                              controller: namecontroller,
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                              ),
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Name must not be empty ';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                              controller: emailcontroller,
                              decoration: const InputDecoration(
                                labelText: 'Email Address',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email must not be empty ';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                              controller: passwordcontroller,
                              decoration: InputDecoration(
                                  labelText: 'password',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.lock_clock_outlined),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        RegisterCubitApp.get(context)
                                            .changePsswordRegisterVisibility();
                                      },
                                      icon: Icon(
                                         RegisterCubitApp.get(context).suffix,
                                      ))
                                  //  Icon(Icons.visibility_outlined),
                                  ),
                              obscureText:  RegisterCubitApp.get(context).ispassword,
                             
             
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'password is to short ';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                              controller: phonecontroller,
                              decoration: const InputDecoration(
                                labelText: 'Phone',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.phone),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Phone must not be empty ';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 35,
                          ),
                          ConditionalBuilder(
                              condition: state is! LoadingRegisterShopAppState,
                              builder: ((context) => Container(
                                    decoration: BoxDecoration(
                                        color: defaulltColor,
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    height: 60,
                                    width: double.infinity,
                                    child: MaterialButton(
                                      child: Text(
                                        'REGISTER',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      onPressed: () {
                                        if (formkey.currentState!.validate()) {
                                           RegisterCubitApp.get(context). Register(
                                             email: emailcontroller.text,
                                      password: passwordcontroller.text,
                                      name: namecontroller.text,
                                      phone: phonecontroller.text,);
                                        }
                                      },
                                    ),
                                  )),
                              fallback: ((context) =>
                                  Center(child: CircularProgressIndicator()))),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              // body: ,
              );
        }));
  }
}
