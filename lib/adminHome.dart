import 'package:flutter/material.dart';
import 'package:smart_checkout_system/welcome.dart';
import 'package:smart_checkout_system/addProduct.dart';


class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Smart One-Time Checkout',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: AdminHome(),
    );
  }
}

class Product {
  final String name;
  final double price;
  final String description;
  final String image;

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.image,
  });
}

class AdminHome extends StatefulWidget {
  static String id = 'adminlogin';

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _selectedIndex = 0;

  void _openAddProductForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProduct(
        ),
      ),
    );
  }


  Future<void> _showLogoutConfimation(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Confirm Logout'),
            content: Text('Are you sure want to logout ?'),
            actions: <Widget>[
              TextButton(
                child: Text('Yes'),
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Welcome()),);
                },
              ),
              TextButton(
                child: Text('No'),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

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
                    if (index == 5) {
                      _showLogoutConfimation(context);

                    } else {
                      setState(() {
                        _selectedIndex = index;
                      });
                    }
                  },
                  labelType: NavigationRailLabelType.selected,
                  backgroundColor: Colors.deepOrange,
                  groupAlignment: 0.0,
                  destinations: const <NavigationRailDestination>[
                    NavigationRailDestination(
                      icon: Icon(Icons.dashboard_rounded),
                      selectedIcon: Icon(Icons.dashboard),
                      label: Text('Dashboard'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.category_rounded),
                      selectedIcon: Icon(Icons.category),
                      label: Text('Products'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.inventory_rounded),
                      selectedIcon: Icon(Icons.inventory),
                      label: Text('Inventory'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.analytics_rounded),
                      selectedIcon: Icon(Icons.analytics),
                      label: Text('Sale Report'),
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
                    if (_selectedIndex == 1)
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        size: 40.0,
                                      ),
                                      Text(
                                        'Add Product',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: (){
                                  setState(() {
                                    _openAddProductForm();
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.view_list_outlined,
                                        size: 40.0,
                                      ),
                                      Text(
                                        'View Product',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: (){
                                  setState(() {

                                  });
                                },
                              ),),
                          ],

                        ),
                      ),
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