import 'package:flutter/material.dart';
import 'package:Journix/nav_pages/bagpage.dart';
import 'package:Journix/nav_pages/fashionsale.dart';
import 'package:Journix/nav_pages/profilepage.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int _selectedIndex = 1;
  int _selectedTabIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
    // Navigate to different pages based on tab
    // Add your page navigation logic here
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Categories', style: TextStyle(fontFamily: 'Metropolis')),
            centerTitle: true,
            floating: true,
            pinned: true,
            expandedHeight: 100.0,
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(),
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TabButton(
                        label: 'Women',
                        isSelected: _selectedTabIndex == 0,
                        onTap: () => _onTabTapped(0),
                      ),
                      TabButton(
                        label: 'Men',
                        isSelected: _selectedTabIndex == 1,
                        onTap: () => _onTabTapped(1),
                      ),
                      TabButton(
                        label: 'Kids',
                        isSelected: _selectedTabIndex == 2,
                        onTap: () => _onTabTapped(2),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // Summer Sales Banner
                Container(
                  width: screenWidth,
                  color: Colors.red,
                  padding: const EdgeInsets.all(16.0),
                  child: const Column(
                    children: [
                      Text(
                        'SUMMER SALES',
                        style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Metropolis'),
                      ),
                      Text(
                        'Up to 50% off',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Metropolis'),
                      ),
                    ],
                  ),
                ),
                // Categories List
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildCategoryCard('New', 'assets/images/new_sp.png'),
                    _buildCategoryCard('Clothes', 'assets/images/clothes_sp.png'),
                    _buildCategoryCard('Shoes', 'assets/images/shoes_sp.png'),
                    _buildCategoryCard('Accessories', 'assets/images/accessories_sp.png'),
                  ],
                ),
              ],
            ),
          ),
        ],
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

  Widget _buildCategoryCard(String title, String imagePath) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(fontSize: 18, fontFamily: 'Metropolis'),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  TabButton({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.red : Colors.black,
            fontSize: 16,
            fontFamily: 'Metropolis',
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for the app bar (e.g. clear search query)
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon for the app bar (e.g. back button)
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Results based on the search query
    return Center(
      child: Text(
        'Search Results for "$query"',
        style: const TextStyle(fontFamily: 'Metropolis'),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions when typing in the search field
    final suggestions = query.isEmpty
        ? []
        : ['New', 'Shoes', 'Accessories']; // Replace with your suggestions

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestions[index],
            style: const TextStyle(fontFamily: 'Metropolis'),
          ),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}
