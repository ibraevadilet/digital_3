import 'package:digital_3/widgets/buttom_navigator.dart';
import 'package:digital_3/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('AuthScreen'),
            const SizedBox(height: 12),
            CustomButton(
              text: 'Войти',
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavigatorScreen(),
                  ),
                  (protected) => false,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
