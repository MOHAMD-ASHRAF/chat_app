import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_app/core/color_const.dart';
import 'package:store_app/features/presentation/pages/home_page.dart';
import 'package:store_app/features/presentation/pages/register_page.dart';
import 'package:store_app/features/presentation/widget/Container_image_widget.dart';
import 'package:store_app/features/presentation/widget/container_button_widget.dart';
import 'package:store_app/features/presentation/widget/headerWidget.dart';
import 'package:store_app/features/presentation/widget/row_text_widget.dart';
import 'package:store_app/features/presentation/widget/show_snakbar.dart';
import 'package:store_app/features/presentation/widget/textfield_container_widget.dart';
import 'package:store_app/features/presentation/widget/textfield_password_container_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final  TextEditingController emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  var auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ContainerWithImAge(context),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 35,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const HeaderWidget(
                        tittle: 'Login',
                      ),
                      TextFieldContainerWidget(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        prefixIcon: Icons.email,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldPasswordContainerWidget(
                        keyboardType: TextInputType.phone,
                        controller: _passwordController,
                        prefixIcon: Icons.lock,
                        suffixIcon: Icons.remove_red_eye,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ContainerButtonWidget(
                          title: 'Login',
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              isLoading = true;
                              setState(() {});
                              try {
                                await loginMethod();
                                // ignore: use_build_context_synchronously
                                // ignore: use_build_context_synchronously
                                Navigator.pushNamed(context, HomePage.id,arguments: emailController.text);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  showSnackBar(
                                      context,
                                      'The password provided is too weak.',
                                      Colors.red);
                                } else if (e.code == 'user-not-found') {
                                  showSnackBar(
                                      context,
                                      'user not found.',
                                      Colors.red);
                                } else {
                                  showSnackBar(context, 'There is something error',
                                      Colors.red);
                                }
                              }
                              isLoading = false;
                              setState(() {});
                            }
                          }
                          ),
                      const SizedBox(
                        height: 20,
                      ),
                      RowTextWidget(
                        title1: "I don't have account ",
                        title2: "register",
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginMethod() async {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text, password: _passwordController.text);
  }
  void _loginMethod(){
    if (emailController.text.isEmpty) {
      /// do toast
      return;
    }
    if (_passwordController.text.isEmpty) {
      /// do toast
      return;
    }

  }
}
