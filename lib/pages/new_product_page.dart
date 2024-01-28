import 'package:flutter/material.dart';
import 'package:monocle/models/product_model.dart';
import 'package:monocle/services/database_helper.dart';

class NewProductScreen extends StatelessWidget {
  final Product? product;
  NewProductScreen({Key? key, this.product}) : super(key: key);

  final titleController = TextEditingController();
  final costController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();

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
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        filled: true,
        fillColor: Colors.white,
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
      body: 
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: TextFormField(
                controller: titleController,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: 'Products Title',
                    labelText: 'Title',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: TextFormField(
                controller: costController,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: 'Products Cost',
                    labelText: 'Cost',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: TextFormField(
                controller: priceController,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: 'Products Price',
                    labelText: 'Price',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: TextFormField(
                controller: stockController,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: 'Current Stock',
                    labelText: 'Stock',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      final title = titleController.value.text;
                      final cost = double.parse(costController.value.text);
                      final price = double.parse(priceController.value.text);
                      final stock = int.parse(stockController.value.text);

                      if (title.isEmpty) {
                        return;
                      }

                      final Product model =
                          Product(title: title, id: product?.id, cost: cost, price: price, stock: stock);
                      if (product == null) {
                        await DatabaseHelper.addProduct(model);
                      } else {
                        await DatabaseHelper.updateProduct(model);
                      }

                    Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 0.75,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                )))),
                    child: Text(
                      product == null ? 'Save' : 'Edit',
                      style: const TextStyle(fontSize: 20),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
