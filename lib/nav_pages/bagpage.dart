import 'package:flutter/material.dart';
import 'package:Journix/nav_pages/fashionsale.dart';
import 'package:Journix/nav_pages/profilepage.dart';
import 'package:Journix/nav_pages/shoppage.dart';

class BagPage extends StatefulWidget {
  @override
  _BagPageState createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  int _selectedIndex = 2;

  // List of bag items
  final List<BagItem> _bagItems = [
    BagItem(
      title: 'Pullover',
      subtitle1: 'Color: Black',
      subtitle2: 'Size: L',
      imagePath: 'assets/images/product1.png',
      price: 51.0,
      quantity: 1,
    ),
    BagItem(
      title: 'T-Shirt',
      subtitle1: 'Color: Gray',
      subtitle2: 'Size: L',
      imagePath: 'assets/images/product2.png',
      price: 30.0,
      quantity: 1,
    ),
    BagItem(
      title: 'Sport Dress',
      subtitle1: 'Color: Black',
      subtitle2: 'Size: M',
      imagePath: 'assets/images/product1.png',
      price: 43.0,
      quantity: 1,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _incrementQuantity(int index) {
    setState(() {
      _bagItems[index].quantity++;
    });
  }

  void _decrementQuantity(int index) {
    if (_bagItems[index].quantity > 1) {
      setState(() {
        _bagItems[index].quantity--;
      });
    }
  }

  double _calculateTotalAmount() {
    return _bagItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bag', style: TextStyle(fontFamily: 'Metropolis')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ..._bagItems.map((item) => _buildBagItem(item, _bagItems.indexOf(item))).toList(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter your promo code',
                  labelStyle: TextStyle(fontFamily: 'Metropolis'),
                  suffixIcon: Icon(Icons.arrow_forward),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total amount:',
                    style: TextStyle(fontSize: 18, fontFamily: 'Metropolis'),
                  ),
                  Text(
                    '${_calculateTotalAmount().toStringAsFixed(2)}\$',
                    style: const TextStyle(fontSize: 18, fontFamily: 'Metropolis'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(screenWidth, 50),
                ),
                child: const Text(
                  'CHECK OUT',
                  style: TextStyle(color: Colors.white, fontFamily: 'Metropolis'),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => FashionSalePage()));
              },
              child: const Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ShopPage()));
              },
              child: const Icon(Icons.shop),
            ),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => BagPage()));
              },
              child: const Icon(Icons.shopping_bag),
            ),
            label: 'Bag',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ProfilePage()));
              },
              child: const Icon(Icons.person),
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildBagItem(BagItem item, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 4,
            offset: const Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            item.imagePath,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(fontSize: 18, fontFamily: 'Metropolis'),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle1,
                  style: const TextStyle(color: Colors.grey, fontFamily: 'Metropolis'),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle2,
                  style: const TextStyle(color: Colors.grey, fontFamily: 'Metropolis'),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text('${item.price}\$', style: const TextStyle(fontFamily: 'Metropolis')),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => _decrementQuantity(index),
                  ),
                  Text('${item.quantity}', style: const TextStyle(fontFamily: 'Metropolis')),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => _incrementQuantity(index),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BagItem {
  String title;
  String subtitle1;
  String subtitle2;
  String imagePath;
  double price;
  int quantity;

  BagItem({
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.imagePath,
    required this.price,
    required this.quantity,
  });
}
