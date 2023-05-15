import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travela_mobile/providers/user_provider.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProvider>(context, listen: false);
    //userData.getFavouriteCities(userId); // method gelince ekle
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: favouriteCities.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.favorite),
                //title: Text(
                //'${favouriteCities[index].city}, ${favouriteCities[index].country}'),
                //subtitle: Text(
                //'${favouriteCities[index].city}, ${favouriteCities[index].country}'),
              );
            },
          ),
        ),
      ),
    );
  }
}
