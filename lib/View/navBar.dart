import 'package:crypto1_app/View/Components/item1.dart';
import 'package:crypto1_app/View/home.dart';
import 'package:crypto1_app/View/selected_Item.dart';
import 'package:crypto1_app/View/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;
  int _currentindex = 0;

  List<Widget> pages = [
    Home(),
    Home(),
    Home(),
  ]; 

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
         body:pages.elementAt(_currentindex),
         
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentindex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.grey.shade100,
          type: BottomNavigationBarType.fixed,
          onTap: ((value) {
            setState(() {
              _currentindex = value;
              _currentindex = _selectedIndex;
              _onItemTapped(value);
            });
          }),
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  color: Colors.grey,
                  'assets/icons/1.1.png',
                  height: myHeight * 0.03,
                ),
                label: '',
                activeIcon: Image.asset(
                  color: Colors.grey,
                  'assets/icons/1.2.png',
                  height: myHeight * 0.03,
                )),
            BottomNavigationBarItem(
                icon: Image.asset(
                  color: Colors.grey,
                  'assets/icons/2.1.png',
                  height: myHeight * 0.03,
                ),
                label: '',
                activeIcon: Image.asset(
                  color: Colors.amber,
                  'assets/icons/2.2.png',
                  height: myHeight * 0.03,
                )),
            BottomNavigationBarItem(
                icon: Image.asset(
                  color: Colors.grey,
                  'assets/icons/3.1.png',
                  height: myHeight * 0.03,
                ),
                label: '',
                activeIcon: Image.asset(
                  color: Colors.amber,
                  'assets/icons/3.2.png',
                  height: myHeight * 0.03,
                )),
            BottomNavigationBarItem(
                icon: Image.asset(
                  color: Colors.grey,
                  'assets/icons/4.1.png',
                  height: myHeight * 0.03,
                ),
                label: '',
                activeIcon: Image.asset(
                  color: Colors.amber,
                  'assets/icons/4.2.png',
                  height: myHeight * 0.03,
                )),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Splash()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Splash()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Splash()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Splash()));
        break;
    }
  }
}
