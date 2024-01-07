import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:monocle/auth.dart';
import 'package:flutter/material.dart';
import 'package:monocle/pages/manage_account_page.dart';

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
                    color: Color(0XFF00631C),
                    width: 2.0,
                  ),
                ),
              ),
            ),
            child: const Text(
              'U',
              style: TextStyle(
                color: Color(0XFF00631C),
              ),
            ),
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
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget _manageAccountButton() {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Color(0XFF00631C)),
        foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ManageAccountStateless()));
      },
      child: const Text('Gerenciar Conta'),
    );
  }

  Widget _signOutButton() {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Color(0XFFAF3C3C)),
        foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
      ),
      onPressed: signOut,
      child: const Text('Sair'),
    );
  }

  Widget _loadInfo() {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            userPressed
                ? const Text(
                    'Olá Usuário!',
                    style: TextStyle(color: Colors.white),
                  )
                : const Text(''),
            const Padding(padding: EdgeInsets.all(4.0)),
            userPressed ? _userUid() : const Text(''),
            userPressed ? _manageAccountButton() : const Text(''),
            userPressed ? _signOutButton() : const Text(''),
            const Padding(padding: EdgeInsets.only(top: 16.0)),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
              'Produtos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Container(
                width: 300.0,
                height: 60.0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                  ),
                ),
              ),
            ),
          ],
        ),
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
        child: _loadInfo(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
          },
          child: Icon(Icons.add),
          backgroundColor: Color(0XFF1CE076),
          foregroundColor: Colors.white,
        ),
    );
  }
}
