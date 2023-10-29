import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_checkout_system/AdminScreens/viewProduct.dart';

class EditProductScreen extends StatefulWidget {
  static String id = 'viewproduct';
  final Product product;

  EditProductScreen({required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  //Create a Firestore instance
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _idController.text = widget.product.id;
    _tagController.text = widget.product.tag;
    _nameController.text = widget.product.name;
    _priceController.text = widget.product.price.toString();
    _quantityController.text = widget.product.quantity.toString();
  }

  void _saveChanges() {
    String newId = _idController.text;
    String newTag = _tagController.text;
    String newName = _nameController.text;
    double newPrice = double.parse(_priceController.text);
    int newQuantity = int.parse(_quantityController.text);

    // 使用set()方法替换现有文档或创建新文档
    _firestore.collection('items').doc(newId).set({
      'Id': newId,
      'item tag': newTag,
      'item name': newName,
      'price(RM)': newPrice,
      'quantity': newQuantity,
    }).then((_) {
      // 操作成功，返回到上一个页面
      Navigator.pop(context);
    }).catchError((error) {
      // 处理错误
      print('Failed to save changes: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: 'ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _tagController,
              decoration: InputDecoration(labelText: 'Product Tag'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
