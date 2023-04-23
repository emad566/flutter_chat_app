import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/chat/chat_screen.dart';
import 'package:flutter_chat_app/screens/register/register_screen.dart';
import 'package:flutter_chat_app/shared/constants.dart';
import 'package:flutter_chat_app/widgets/components.dart';
import 'package:flutter_chat_app/widgets/custom_button.dart';
import 'package:flutter_chat_app/widgets/custom_text_field.dart';
import 'package:flutter_chat_app/widgets/theme_colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isVisiblePassword = false;
  bool isAsyncState = false;

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    isAsyncState = false;
    return Scaffold(
      appBar: buildRegisterAppBar(setState: setState, context: context),
      // backgroundColor: Get.isDarkMode? darkGreyClr : primaryClr,
      body: ModalProgressHUD(
        inAsyncCall: isAsyncState,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(logoPath),
                  Text(
                    'Scholar Chat',
                    style: GoogleFonts.pacifico(
                      fontSize: 32,
                      color: whiteClr,
                    ),
                  ),
                  const SizedBox(height: 50,),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    width: double.infinity,
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.lato(
                        fontSize: 30,
                        color: whiteClr,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  CustomTextField(
                    hintText: 'Email',
                    controller: _emailController,
                    validator: _emailController.text == ''? 'Email is required' : null,
                    suffixIcon: Icon(
                      !isVisiblePassword? Icons.visibility : Icons.visibility_off,
                      size: 30,
                      color: whiteClr,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  CustomTextField(
                    obscureText: isVisiblePassword? false : true,
                    hintText: 'Password',
                    controller: _passwordController,
                    validator: _passwordController.text == ''? 'Password is required' : null,
                    suffixIcon: IconButton(
                      icon: Icon(
                        !isVisiblePassword? Icons.visibility : Icons.visibility_off,
                        size: 30,
                        color: whiteClr,
                      ),
                      onPressed: () => setState(() => isVisiblePassword = !isVisiblePassword),
                    ),
                  ),
                  const SizedBox(height: 20,),

                  CustomButton(
                    label: 'Login',
                    onTab: (){
                      loginWithFireBase();
                    },
                  ),

                  GestureDetector(
                    onTap: () => Get.to(()=>const RegisterScreen()),
                    child: Text(
                      'Don\'t have an account? Sign Up',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        color: whiteClr,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void loginWithFireBase() async{
    setState(() {
      isAsyncState =true;
    });
    try {
      await loginFirebase();
      // ignore: use_build_context_synchronously
      showSnackBar(text: 'Success', state: SnackBarState.success, context: context);
    } on FirebaseAuthException catch (e) {
      showSnackBar(text: e.code, state: SnackBarState.fail, context: context);
    } catch (e) {
      showSnackBar(text: 'Error try again!', state: SnackBarState.fail, context: context);
      if (kDebugMode) {
        print(e.toString());
      }
    }
    setState(() {
      isAsyncState =false;
    });
  }

  Future<void> loginFirebase() async {
    if(formKey.currentState!.validate()){
      var auth = FirebaseAuth.instance;
      UserCredential credential  = await auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if(credential.user == null) return;

      String userId = credential.user!.uid;
      final GetStorage box = GetStorage();
      box.write(Caches.cacheUserId, userId);
      Get.to(()=>const ChatScreen());

      if (kDebugMode) {
        print('credential.credential!.accessToken: ${credential.user?.uid}');
      }
    }
  }
}


