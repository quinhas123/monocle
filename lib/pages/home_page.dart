import 'package:firebase_auth/firebase_auth.dart';
import 'package:monocle/auth.dart';
import 'package:flutter/material.dart';
import 'package:monocle/db_widgets/product_widget.dart';
import 'package:monocle/models/product_model.dart';
import 'package:monocle/pages/manage_account_page.dart';
import 'package:monocle/pages/new_product_page.dart';
import 'package:monocle/services/database_helper.dart';


class HomePageStateless extends StatefulWidget {
  const HomePageStateless({Key? key}) : super(key: key);

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
          const Padding(padding: EdgeInsets.only(top: 16.0))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _title(),
      body: FutureBuilder<List<Product>?>(
          future: DatabaseHelper.getAllProduct(),
          builder: (context, AsyncSnapshot<List<Product>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemBuilder: (context, index) => ProductWidget(
                    product: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewProductScreen(
                                product: snapshot.data![index],
                              )));
                      setState(() {});
                    },
                    onLongPress: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                  'Tem certeza que quer deletar esse produto?'),
                              actions: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          Colors.red)),
                                  onPressed: () async {
                                    await DatabaseHelper.deleteProduct(
                                        snapshot.data![index]);
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: const Text('Yes'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('No'),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                  itemCount: snapshot.data!.length,
                );
              }
              return const Center(
                child: Text('No Products yet'),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NewProductScreen()));
          setState(() {});
        },
        child: const Icon(Icons.add),
        backgroundColor: Color(0XFF1CE076),
        foregroundColor: Colors.white,
        ),
    );
  }
}
