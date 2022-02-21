import 'package:fingerauthentication_demo/main.dart';
import 'package:fingerauthentication_demo/pages/fingerprint_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Home',
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(height: 48),
              buildLogoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLogoutButton(BuildContext context) => ElevatedButton(
      onPressed: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const FingerprintPage())),
      child: const Text(
        'Logout',
        style: TextStyle(fontSize: 20),
      ));
}
