import 'package:fingerauthentication_demo/api/local_auth_api.dart';
import 'package:fingerauthentication_demo/main.dart';
import 'package:fingerauthentication_demo/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintPage extends StatelessWidget {
  const FingerprintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildAvailability(context),
              SizedBox(height: 24),
              buildAuthenticate(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAvailability(BuildContext context) => buildButton(
        text: 'Check Availability',
        icon: Icons.event_available,
        onClicked: () async {
          // ? To check the phone has biomatrics or not
          final isAvailable = await LocalApi.hasBioMatrics();

          // ? get the list of  biomatrics which a phone has
          final biometric = await LocalApi.getBiometrics();

          final hasFingerprint = biometric.contains(BiometricType.fingerprint);

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                'Availability',
                style: TextStyle(color: Colors.black),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildText('Biometrics', isAvailable),
                  buildText('Fingerprint', hasFingerprint),
                ],
              ),
            ),
          );
        },
      );

  Widget buildText(String text, bool checked) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          checked
              ? const Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 24,
                )
              : const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 34,
                ),
          const SizedBox(
            width: 12,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          )
        ],
      ),
    );
  }

  Widget buildAuthenticate(BuildContext context) {
    return buildButton(
        text: 'Authenticate',
        icon: Icons.lock_open,
        onClicked: () async {
          final isAuthenticated = await LocalApi.authenticate();

          if (isAuthenticated) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
          }
        });
  }

  Widget buildButton(
      {required String text,
      required IconData icon,
      required VoidCallback onClicked}) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
        onPressed: onClicked,
        icon: Icon(
          icon,
          size: 26,
        ),
        label: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ));
  }
}
