import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.label,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        side: BorderSide(color: Theme.of(context).colorScheme.primary),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath, height: 20, width: 20),
          const SizedBox(width: 12),
          Text(label),
        ],
      ),
    );
  }
}
