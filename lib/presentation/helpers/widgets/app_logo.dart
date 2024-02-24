import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Color(0xFF4A148C)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [BoxShadow(
            color: Colors.black,
            blurRadius: 50,
          ),],
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(150),
            bottomLeft: Radius.circular(150),
          ),
        ),
        height: MediaQuery.of(context).size.height / 4,
        width: double.infinity,
        child: const Center(
            child: Text("Login",
              style: TextStyle(fontSize: 50,
              fontWeight: FontWeight.w800),)),
        // child: Container(
        //   width: MediaQuery.of(context).size.width * 0.25,
        //   margin: const EdgeInsets.all(20),
        //   decoration: const BoxDecoration(
        //       shape: BoxShape.circle,
        //       image: DecorationImage(
        //         image: AssetImage("assets/logo/tMusic.png"),
        //       )),
        // )
    );
  }
}
