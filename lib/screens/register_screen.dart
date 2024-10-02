import 'package:flutter/material.dart';
import 'package:kpie_practical/screens/auth_screen.dart';

class RegisterScreen extends StatelessWidget {
 
  const RegisterScreen({super.key,  });

  @override
  Widget build(BuildContext context) {
    return const AuthScreen( isSignUp: true,);
  }
}


 