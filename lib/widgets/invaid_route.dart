import 'package:flutter/material.dart';
import 'package:test_project/utilities/routes/routes.dart';
import 'package:test_project/widgets/widget_methods.dart';

class InvalidRoute extends StatelessWidget {
  const InvalidRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Invalid page",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            sbh(10),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.home);
              },
              child: const Text(
                "Go Home",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
