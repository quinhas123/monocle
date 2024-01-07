import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:monocle/auth.dart';

class RecoverAccountStateless extends StatefulWidget {
  const RecoverAccountStateless({super.key});

  @override
  State<RecoverAccountStateless> createState() => RecoverAccount();
}

class RecoverAccount extends State<RecoverAccountStateless> {
  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();

  Future<void> sendPasswordResetEmail() async {
    try {
      await Auth().sendPasswordResetEmail(
        email: _controllerEmail.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'ERROR: $errorMessage');
  }

  AppBar _title() {
    return AppBar(
      toolbarHeight: 60.0,
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

  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        filled: true,
        fillColor: Colors.white,
        icon:
            title == 'Insira seu Email' ? const Icon(Icons.email) : const Icon(Icons.key),
        iconColor: Colors.white,
      ),
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Color(0XFF1CE076)),
          foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
        ),
        onPressed: sendPasswordResetEmail,
        child: const Text('Recuperar'));
  }

  Widget _pageTitle() {
    return Image.asset('assets/recover_account.png',
        fit: BoxFit.cover);
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
            Container(
              margin: const EdgeInsets.only(bottom: 6.0),
              child: _entryField('Insira seu Email', _controllerEmail),
            ),
            _errorMessage(),
            _submitButton(),
          ],
        ),
      ),
    );
  }
}
