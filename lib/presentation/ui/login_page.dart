import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    final emailController = TextEditingController();
    final emailFormKey = GlobalKey<FormState>();

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                key: emailFormKey,
                child: TextFormField(
                  cursorColor: Colors.deepOrange,
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email';
                    }
                    if (EmailValidator.validate(value)){
                      return "Please enter a valid email";
                    }
                    return null ;

                  },
                  autocorrect: false,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: "Email",
                    hintStyle: (TextStyle(color: Colors.white30)),
                    icon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white30,
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 15),
                ),
                onPressed: () {
                  if (emailFormKey.currentState!.validate()) {

                  }
                },
                child: const Text('Submit',
                style: TextStyle(
                  color: Colors.white
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
