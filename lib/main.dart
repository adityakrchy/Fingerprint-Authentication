import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final _auth = LocalAuthentication();
  static Future<bool> hasBiometrics() async {
    try {
      return _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;
    try {
      return await _auth.authenticate(
        localizedReason: "Scan fingerprint to authenticate",
        options: const AuthenticationOptions(
            useErrorDialogs: true, stickyAuth: true),
      );
    } on PlatformException catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Local Auth",
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Local Auth",
            ),
          ),
          backgroundColor: Colors.purple.shade600,
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: Colors.purple.shade600),
                  onPressed: null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.library_add_check_outlined),
                      Text(
                        "Check Availability",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: Colors.purple.shade600),
                onPressed: () async {
                  final isAuthenticated = await authenticate();
                  if (isAuthenticated) {
                    print("Authenticated");
                    Fluttertoast.showToast(msg: "arey baba maza aa gya");
                  } else if (isAuthenticated == false) {
                    print("Not authenticated");
                    Fluttertoast.showToast(msg: "User unauthenticated");
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.lock_open),
                    Text(
                      "Authenticate",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecretFolder extends StatelessWidget {
  const SecretFolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Secret Folder"),
          backgroundColor: Colors.purple.shade600,
        ),
        body: const Center(
          child: Text("Secret Folder"),
        ),
      ),
    );
  }
}
