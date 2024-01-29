import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:monocle/auth.dart';

class UserPageStateless extends StatefulWidget {
  const UserPageStateless({super.key});

  @override
  State<UserPageStateless> createState() => UserPage();
}

class UserPage extends State<UserPageStateless> {
  String? errorMessage = '';
  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'ERROR: $errorMessage');
  }

  Future<void> signOut() async {
    await Auth().signOut();
    Navigator.pop(context);
  }

  AppBar _title() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/monaclev-white.png',
              fit: BoxFit.cover, scale: 1.5),
          const Padding(padding: EdgeInsets.all(4.0)),
          Image.asset('assets/monacle-title.png',
              fit: BoxFit.cover, scale: 1.5),
        ],
      ),
      backgroundColor: const Color(0XFF00A3FF),
    );
  }

  Widget _exitButton() {
    return ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 206, 47, 7)),
          foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
        ),
        onPressed: signOut,
        child: const Text('Sair'));
  }

  Widget _pageTitle() {
    return Text(
      "Olá, usuário!",
      style: const TextStyle(
        fontSize: 34,
        color: Colors.white,
      ));
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
            _pageTitle(),
            const Padding(padding: EdgeInsets.all(20)),
            _errorMessage(),
            _exitButton(),
          ],
        ),
      ),
    );
  }
}
