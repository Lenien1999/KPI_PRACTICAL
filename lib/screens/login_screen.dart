import 'package:flutter/material.dart';
import 'package:kpie_practical/screens/auth_screen.dart';

class LoginScreen extends StatelessWidget {
 
  const LoginScreen({super.key,  });

  @override
  Widget build(BuildContext context) {
    return const AuthScreen( isSignUp: false,);
  }
}
