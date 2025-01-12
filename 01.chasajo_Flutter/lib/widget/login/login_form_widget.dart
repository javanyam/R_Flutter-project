import 'package:cha_sa_jo_flutter/constants/sizes.dart';
import 'package:cha_sa_jo_flutter/constants/text_strings.dart';
import 'package:cha_sa_jo_flutter/view/Home/Home.dart';
import 'package:cha_sa_jo_flutter/view/chatting/chat_screen.dart';
import 'package:cha_sa_jo_flutter/view/login/login_forget.dart';
import 'package:cha_sa_jo_flutter/view/signup/singup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    String loginEmail = "";
    String loginPassword = "";
    return Form(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  loginEmail = value;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: tEmail,
                  hintText: tEmail,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: tFormHeight - 20),
              TextFormField(
                onChanged: (value) {
                  loginPassword = value;
                },
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.fingerprint),
                  labelText: tPassword,
                  hintText: tPassword,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: tFormHeight - 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    // forget password
                    onPressed: () {
                      //비밀번호찾기 화면 추가
                      Get.to(loginForget());
                    },
                    child: const Text(tForgetPassword)),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // login 실행
                  onPressed: () async {
                    try {
                      final newUser = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: loginEmail,
                        password: loginPassword,
                      );
                      if (newUser.user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Home(
                                tabIndex: 0,
                              );
                            },
                          ),
                        );
                      }
                    } catch (e) {
                      print(e);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please check your ID password."),
                        ),
                      );
                    }
                  },
                  child: Text(tLogin.toUpperCase()),
                ),
              ),
              const Text("OR"),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (context) {
                      //     return SignupScreen();
                      //   },
                      // ));
                      Get.to(SignupScreen());
                    },
                    child: Text('SING UP')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
