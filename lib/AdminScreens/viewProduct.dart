import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_checkout_system/AdminScreens//editProduct.dart';

class Product {
  final String id;
  final String tag;
  final String name;
  final double price;
  final int quantity;

  Product({
    required this.id,
    required this.tag,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory Product.fromDocument(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      tag: data['item tag'] ?? '',
      name: data['item name'] ?? '',
      price: (data['price(RM)'] ?? 0).toDouble(),
      quantity: data['quantity'] ?? 0,
    );
  }
}

class ViewProduct extends StatefulWidget {
  static String id = 'viewproduct';
  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  final _firestore = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Products'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                // 在这里处理搜索逻辑
                // 可以根据value过滤显示的商品
              },
              decoration: InputDecoration(
                hintText: 'Search products...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('items').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final docs = snapshot.data?.docs;

                if (docs == null || docs.isEmpty) {
                  return Center(child: Text('No products available.'));
                }

                return ListView(
                  children: docs
                      .where((doc) {
                    // 在这里处理过滤逻辑
                    // 例如，如果搜索框不为空，只显示名称包含搜索词的商品
                    if (_searchController.text.isNotEmpty) {
                      final productName = doc['item name'].toString().toLowerCase();
                      final searchTerm = _searchController.text.toLowerCase();
                      return productName.contains(searchTerm);
                    }
                    return true; // 如果搜索框为空，显示所有商品
                  })
                      .map((doc) {
                    final id = doc['Id'];
                    final productTag = doc['item tag'];
                    final productName = doc['item name'];
                    final price = doc['price(RM)'];
                    final quantity = doc['quantity'];

                    return GestureDetector(
                      onTap: () {
                        // 打开新页面进行商品信息更新
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProductScreen(
                              product: Product(
                                id: id,
                                tag: productTag,
                                name: productName,
                                price: price,
                                quantity: quantity,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text('ID: $id'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Product Tag: ${productTag ?? 'N/A'}'),
                              Text('Product Name: $productName'),
                              Text('Price: RM $price'),
                              Text('Quantity: $quantity'),
                            ],
                          ),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'delete') {
                                // 弹出确认对话框
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Confirm Delete'),
                                      content: Text('Are you sure you want to delete $productName?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // 在这里处理删除逻辑
                                            _firestore.collection('items').doc(id).delete();
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text('$productName deleted'),
                                            ));
                                          },
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'delete',
                                child: ListTile(
                                  leading: Icon(Icons.delete),
                                  title: Text('Delete'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
