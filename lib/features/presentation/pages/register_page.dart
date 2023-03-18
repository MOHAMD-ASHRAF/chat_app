import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_app/core/color_const.dart';
import 'package:store_app/features/presentation/pages/home_page.dart';
import 'package:store_app/features/presentation/widget/Container_image_widget.dart';
import 'package:store_app/features/presentation/widget/container_button_widget.dart';
import 'package:store_app/features/presentation/widget/headerWidget.dart';
import 'package:store_app/features/presentation/widget/row_text_widget.dart';
import 'package:store_app/features/presentation/widget/show_snakbar.dart';
import 'package:store_app/features/presentation/widget/textfield_container_widget.dart';
import 'package:store_app/features/presentation/widget/textfield_password_container_widget.dart';
import 'package:store_app/generated/assets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  var auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
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
                        tittle: 'Create New Account',
                      ),
                      TextFieldContainerWidget(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
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
                      const SizedBox(
                        height: 20,
                      ),
                      ContainerButtonWidget(
                          title: 'Register',
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              isLoading = true;
                              setState(() {});
                              try {
                                await registerMethod();
                                Navigator.pushNamed(context, HomePage.id);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  showSnackBar(
                                      context,
                                      'The password provided is too weak.',
                                      Colors.red);
                                } else if (e.code == 'email-already-in-use') {
                                  showSnackBar(
                                      context,
                                      'The account already exists for that email.',
                                      Colors.red);
                                } else {
                                  showSnackBar(context, 'The is something error',
                                      Colors.red);
                                }
                              }
                              isLoading = false;
                              setState(() {});
                            }
                          }),
                    ],
                  ),
                ),
              ),
              Row(
                  children: const <Widget>[
                    Expanded(
                        child: Divider()
                    ),
                    Text("or sign with",style: TextStyle(color: Colors.grey,fontSize: 14),),
                    Expanded(
                        child: Divider()
                    ),
                  ]
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: ()async{
                      try{
                        await signInWithGoogle();
                        Navigator.pushNamed(context, HomePage.id);
                      }on FirebaseAuthException catch (e) {
                        print(e);
                      }


                    },
                    child: Image.asset(Assets.imageGoogle,fit: BoxFit.cover,
                        height: 45,
                        width:45),
                  ),
                  const SizedBox(width: 30,),
                  InkWell(
                    onTap: (){},
                    child: Image.asset(Assets.imageFacebook,fit: BoxFit.cover,
                        height: 45,
                        width:45),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              RowTextWidget(
                title1: "I have account ",
                title2: "Login",
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }


  Future<void> registerMethod() async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

}
