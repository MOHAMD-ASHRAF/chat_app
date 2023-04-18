import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:store_app/features/presentation/pages/home_page.dart';
import 'package:store_app/features/presentation/pages/register_page.dart';
import 'package:store_app/features/presentation/widget/Container_image_widget.dart';
import 'package:store_app/features/presentation/widget/container_button_widget.dart';
import 'package:store_app/features/presentation/widget/headerWidget.dart';
import 'package:store_app/features/presentation/widget/row_text_widget.dart';
import 'package:store_app/features/presentation/widget/show_snakbar.dart';
import 'package:store_app/features/presentation/widget/textfield_container_widget.dart';
import 'package:store_app/features/presentation/widget/textfield_password_container_widget.dart';

class LoginPage extends StatelessWidget {
  static String id = 'LoginPage';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  var auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          isLoading = true;
        } else if (state is LoginSuccessState) {
          Navigator.pushNamed(context, HomePage.id);
        } else if (state is LoginFailureState) {
          showSnackBar(context, 'Something went wrong', Colors.red);
          isLoading = false;
        }
      },
      child: ModalProgressHUD(
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
                          controller: passwordController,
                          prefixIcon: Icons.lock,
                          suffixIcon: Icons.remove_red_eye,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ContainerButtonWidget(
                            title: 'Login',
                            onTap: () async {
                             BlocProvider.of<AuthBloc>(context).add(LoginEvent(email: emailController.text, password: passwordController.text));
                            }),
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
      ),
    );
  }
}
