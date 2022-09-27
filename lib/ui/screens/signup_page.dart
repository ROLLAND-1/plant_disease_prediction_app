import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/service/firebase_auth.dart';
import 'package:flutter_onboarding/ui/root_page.dart';
import 'package:flutter_onboarding/ui/screens/widgets/custom_textfield.dart';
import 'package:flutter_onboarding/ui/screens/signin_page.dart';
import 'package:page_transition/page_transition.dart';

import 'home_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  late bool isLoading;

  void onSignUp()async{
    setState(() {
      isLoading = true;
    });
    var res = await AuthService.instance.signUp(emailController.text, passwordController.text,nameController.text);
    setState(() {
      isLoading = false;
    });
    if(res is String){
      showDialog(context: context, builder: (_)=>AlertDialog(
        title: const Text('Error'),
        content: Text(res),
        actions: [
          TextButton(onPressed: ()=>Navigator.pop(context),child: const Text('OK'),)
        ],
      ));
      return;
    }
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>const RootPage  ()), (route) => false);
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: '');
    passwordController = TextEditingController(text: '');
    nameController = TextEditingController(text: '');
    isLoading = false;
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/signup.png'),
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextfield(
                textEditingController: emailController,
                obscureText: false,
                hintText: 'Enter Email',
                icon: Icons.alternate_email,
              ),
              CustomTextfield(
                textEditingController: nameController,
                obscureText: false,
                hintText: 'Enter Full name',
                icon: Icons.person,
              ),
              CustomTextfield(
                textEditingController: passwordController,
                obscureText: true,
                hintText: 'Enter Password',
                icon: Icons.lock,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: isLoading?null:onSignUp,
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child:  Center(
                    child: 
                    isLoading?
                    const CircularProgressIndicator(
                      color: Colors.white,
                    )
                    :
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Row(
              //   children: const [
              //     Expanded(child: Divider()),
              //     Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 10),
              //       child: Text('OR'),
              //     ),
              //     Expanded(child: Divider()),
              //   ],
              // ),
              const SizedBox(
                height: 20,
              ),
              // Container(
              //   width: size.width,
              //   decoration: BoxDecoration(
              //       border: Border.all(color: Constants.primaryColor),
              //       borderRadius: BorderRadius.circular(10)),
              //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       SizedBox(
              //         height: 30,
              //         child: Image.asset('assets/images/google.png'),
              //       ),
              //       Text(
              //         'Sign Up with Google',
              //         style: TextStyle(
              //           color: Constants.blackColor,
              //           fontSize: 18.0,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const SignIn(),
                          type: PageTransitionType.bottomToTop));
                },
                child: Center(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: 'Have an Account? ',
                        style: TextStyle(
                          color: Constants.blackColor,
                        ),
                      ),
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          color: Constants.primaryColor,
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
