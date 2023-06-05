import 'package:app/Homepage/Homepage.dart';
import 'package:app/Homepage/Wishlist.dart';
import 'package:app/Homepage/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/services/Database.dart';

class Btmnav extends StatefulWidget {
  const Btmnav({Key? key}) : super(key: key);
  _BtmnavState createState() => _BtmnavState();
}

class _BtmnavState extends State<Btmnav> {
  @override
  int _selectedindex = 0;
  List<Widget> _page = [Homepage(), Cart(), Wishlist()];
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart_fill), label: "Wishlist"),
        ],
        selectedItemColor: Colors.blue,
        currentIndex: _selectedindex,
        onTap: (int index) {
          setState(() {
            _selectedindex = index;
          });
        },
      ),
    );
  }
}
