import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Smart One-Time Checkout',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home(),
    );
  }
}


class Home extends StatefulWidget {
  static String id = 'home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<Product> products = [
    Product(
      name: 'Win2 Potato Crisp (Tomato flavour) - 20g',
      price: '0.50',
      image: 'images/win2 crisp tomato.jpeg',
    ),
    Product(
      name: 'Win2 Potato Crisp (Vegatable flavour) - 20g',
      price: '0.50',
      image: 'images/win2 crisp vegatable.jpeg',
    ),
    Product(
      name: 'Win2 Potato Crisp (BBQ flavour) - 20g',
      price: '0.50',
      image: 'images/win2 crisp bbq.jpg',
    ),
    Product(
      name: 'Win2 Potato Crisp (Sweet Potato flavour) - 20g',
      price: '0.50',
      image: 'images/win2 crisp sweet potato.jpg',
    ),
    // Add more products here
  ];


  List<PurchaseRecord> purchaseHistory = [
    // Add purchase history items here...
    PurchaseRecord(productName: 'Win2 Potato Crisp (Tomato flavour) - 20g', date: '21/8/2023', price: 0.50)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.selected,
                  backgroundColor: Colors.green,
                  groupAlignment: 0.0,
                  destinations: const <NavigationRailDestination>[
                    NavigationRailDestination(
                      icon: Icon(Icons.home_rounded),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.shopping_cart_outlined),
                      selectedIcon: Icon(Icons.shopping_cart),
                      label: Text('Cart'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.history_rounded),
                      selectedIcon: Icon(Icons.history),
                      label: Text('Purchase History'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline_rounded),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Account'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.logout_rounded),
                      selectedIcon: Icon(Icons.logout),
                      label: Text('Logout'),
                    ),
                  ],
                  selectedIconTheme: IconThemeData(color: Colors.white),
                  unselectedIconTheme: IconThemeData(color: Colors.black),
                  selectedLabelTextStyle: TextStyle(color: Colors.white),
                ),
              ),
              const VerticalDivider(thickness: 1, width: 2),
              Expanded(
                flex: 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/person.jpg'),
                          radius: 30,
                        ),
                      ),
                    ),
                    if (_selectedIndex == 0)
                      Expanded(child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: ListView.builder(itemCount: products.length,itemBuilder: (context, index){
                            return ProductCard(product: products[index]);
                          },))
                      ),

                    if (_selectedIndex == 2 && purchaseHistory.isEmpty)
                      Center(child: Text('No purchase history available.'),
                      ),
                    if (_selectedIndex == 2 && purchaseHistory.isNotEmpty)
                    // Display purchase history items...
                      Expanded(child: ListView.builder(itemCount: purchaseHistory.length,itemBuilder: (context, index){
                        return PurchaseRecordCard(record: purchaseHistory[index]);
                      },))
                  ],
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
class Product {
  final String name;
  final String price;
  final String image;

  Product({required this.name, required this.price, required this.image});
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Image.asset(product.image),
        title: Text(product.name),
        subtitle: Text('RM${product.price}'),
      ),
    );
  }
}

class PurchaseRecord {
  final String productName;
  final String date;
  final double price;

  PurchaseRecord({required this.productName, required this.date, required this.price});
}

class PurchaseRecordCard extends StatelessWidget {
  final PurchaseRecord record;

  PurchaseRecordCard({required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        title: Text(record.productName),
        subtitle: Text('Date: ${record.date}\nPrice: RM${record.price.toStringAsFixed(2)}'),
      ),
    );
  }
}
