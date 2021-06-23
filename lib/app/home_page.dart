import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, @required this.onSignOut}) : super(key: key);
  final VoidCallback onSignOut;

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      onSignOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 15),
            ),
            onPressed: _signOut,
          )
        ],
      ),
    );
  }
}
