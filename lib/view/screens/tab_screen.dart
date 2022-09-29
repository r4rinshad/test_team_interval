import 'package:test_team_interval/view/tabs/alcoholic_tab.dart';
import 'package:test_team_interval/view/tabs/category_tab.dart';
import 'package:test_team_interval/view/tabs/glass_tab.dart';
import 'package:test_team_interval/view/tabs/ingredient_tab.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  void _onPageChanged(int page) {
    setState(() {
      _selectedIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocktail'),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: _onPageChanged,
        children: const [

          CategoryTab(),
          GlassTab(),
          AlcoholicTab(),
          IngredientTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
         
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_bar),
            label: 'Glass',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop),
            label: 'Optional',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Ingredients',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightGreen,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
