import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProduct extends StatefulWidget {
  static String id = 'addproduct';

  @override
  State<AddProduct> createState() => _AddProductState();

}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _productTagController = TextEditingController();


  //Create a Firestore instance
  final _firestore = FirebaseFirestore.instance;

  void _addProduct() {
    String id = _idController.text;
    String productName = _productNameController.text;
    double price = double.parse(_priceController.text);
    int quantity = int.parse(_quantityController.text);
    String productTag = _productTagController.text;

    if (productName.isNotEmpty && price > 0 && id.isNotEmpty && quantity > 0 && productTag.isNotEmpty) {
      _firestore.collection('items').add({
        'Id':id,
        'item tag': productTag,
        'item name': productName,
        'price(RM)': price,
        'quantity': quantity,
      }).then((value){
        // success to add product
        print('Product added successfully!');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product added successfully!'),
            duration: Duration(seconds: 3), // 设置SnackBar显示的时间
          ),
        );
        // 清空文本框
        _idController.clear();
        _productNameController.clear();
        _priceController.clear();
        _quantityController.clear();
        _productTagController.clear();
      }).catchError((error){
        //fail to add product
        print('Failed to add product: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 500,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  TextField(
                    controller: _idController,
                    decoration: InputDecoration(
                        labelText: 'Id'),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),

            Container(
              width: 500,
              child: TextField(
                controller: _productTagController,
                decoration: InputDecoration(labelText: 'Product Tag'),
              ),
            ),
            SizedBox(height: 20),

            Container(
              width: 500,
              child: TextField(
                controller: _productNameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
            ),
            SizedBox(height: 20,),

            Container(
              width: 500,
              child: TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price (RM)'),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height: 20,),

            Container(
              width: 500,
              child:TextField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
              ),
            ),
            SizedBox(height: 20),

            SizedBox(
              width: 150,
              height: 40,
              child:ElevatedButton(
                onPressed: _addProduct,
                child: Text('Add Product'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

