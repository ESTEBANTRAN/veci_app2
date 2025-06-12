import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
     
        appBar: AppBar(title: const Text('Welcome')),
        body: Center(
          child: Column(
            children: [
              Text('Welcome'),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed("/login");
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      
    );
  }
}