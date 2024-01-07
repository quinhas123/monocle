import 'package:firebase_auth/firebase_auth.dart';
import 'package:monocle/auth.dart';
import 'package:flutter/material.dart';

class HomePageStateless extends StatefulWidget {
  const HomePageStateless({super.key});

  @override
  State<HomePageStateless> createState() => HomePage();
}

class HomePage extends State<HomePageStateless> {
  final User? user = Auth().currentUser;

  bool userPressed = true;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  AppBar _title() {
    return AppBar(
      toolbarHeight: 100.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/monaclev-white.png',
              fit: BoxFit.cover, scale: 1.5),
          const Padding(padding: EdgeInsets.all(4.0)),
          Image.asset('assets/monacle-title.png',
              fit: BoxFit.cover, scale: 1.5),
          const Padding(padding: EdgeInsets.all(16.0)),
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<CircleBorder>(
                const CircleBorder(
                  side: BorderSide(
                    color: Colors.teal,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            child: const Text('U'),
            onPressed: () {
              setState(() {
                userPressed = !userPressed;
              });
            },
          ),
        ],
      ),
      backgroundColor: const Color(0XFF00A3FF),
    );
  }

  Widget _userUid() {
    return Text(
      user?.email ?? 'User email',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget _signOutButton() {
    return ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Color(0XFFAF3C3C)),
          foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
        ),
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _title(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color(0XFF00D1FF),
              Color(0XFF00A3FF),
            ],
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userPressed ? Text('Olá Usuário!', style: TextStyle(color: Colors.white),) : Text(''),
            const Padding(padding: EdgeInsets.all(4.0)),
            userPressed ? _userUid() : Text(''),
            userPressed ? _signOutButton() : Text(''),
          ],
        ),
      ),
    );
  }
}
