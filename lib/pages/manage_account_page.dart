import 'package:flutter/material.dart';

class ManageAccountStateless extends StatefulWidget {
  const ManageAccountStateless({super.key});

  @override
  State<ManageAccountStateless> createState() => ManageAccount();
}

class ManageAccount extends State<ManageAccountStateless> {
  final TextEditingController _controllerUserName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerEmailConfirm = TextEditingController();
  final TextEditingController _controllerPasswordConfirm =
      TextEditingController();

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

  Widget _pageTitle() {
    return Image.asset('assets/manage_account.png', fit: BoxFit.cover);
  }

  Widget _submitButton() {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Color(0XFF1CE076)),
        foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
      ),
      onPressed: () {},
      child: const Text('Salvar'),
    );
  }

  Widget _entryField(String title, TextEditingController controller) {
    Icon getIcon() {
      switch (title) {
        case 'Nome do Usuário':
          return const Icon(Icons.person);
        case 'Email':
        case 'Confirmar Email':
          return const Icon(Icons.email);
        case 'Senha':
        case 'Confirmar Senha Anterior':
          return const Icon(Icons.key);
        default:
          return const Icon(Icons.circle);
      }
    }

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        filled: true,
        fillColor: Colors.white,
        icon: getIcon(),
        iconColor: Colors.white,
      ),
      style: const TextStyle(
        color: Colors.black,
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
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _pageTitle(),
            const Padding(padding: EdgeInsets.all(4.0)),
            _entryField('Nome do Usuário', _controllerUserName),
            const Padding(padding: EdgeInsets.all(4.0)),
            _entryField('Email', _controllerEmail),
            const Padding(padding: EdgeInsets.all(4.0)),
            _entryField('Confirmar Email', _controllerEmailConfirm),
            const Padding(padding: EdgeInsets.all(4.0)),
            _entryField('Senha Atual', _controllerPassword),
            const Padding(padding: EdgeInsets.all(4.0)),
            _entryField('Nova Senha', _controllerPasswordConfirm),
            _submitButton(),
          ],
        ),
      ),
    );
  }
}
