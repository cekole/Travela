import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Paris, France'),
                  subtitle: Text('Paris is the capital city of France'),
                ),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('London, UK'),
                  subtitle: Text('London is the capital city of the UK'),
                ),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('New York, USA'),
                  subtitle: Text('New York is the capital city of the USA'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
