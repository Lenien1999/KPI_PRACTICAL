import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _buildSocialButton(
            label: 'GOOGLE',
            icon: FontAwesomeIcons.google,
            onPressed: () {
              // Google login functionality
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildSocialButton(
            label: 'FACEBOOK',
            icon: FontAwesomeIcons.facebook,
            onPressed: () {
              // Facebook login functionality
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 2,
          color: const Color.fromARGB(255, 3, 33, 131),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton.icon(
        onPressed: onPressed,
        label: Text(
          label,
          style: const TextStyle(color: Color.fromARGB(255, 3, 33, 131)),
        ),
        icon: Icon(icon, color: const Color.fromARGB(255, 3, 33, 131)),
      ),
    );
  }
}
