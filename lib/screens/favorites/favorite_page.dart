import 'package:flutter/material.dart';
import 'package:travela_mobile/providers/user_provider.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userData = Provider.of<UserProvider>(context, listen: false);
      userData.getFavouriteCities(userId);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Consumer<UserProvider>(
          builder: (context, userData, _) {
            if (favouriteCities == null) {
              return Center(child: CircularProgressIndicator());
            } else if (favouriteCities.isEmpty) {
              return Center(child: Text('No favorite cities found.'));
            } else {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: favouriteCities.length,
                itemBuilder: (context, index) {
                  final city = favouriteCities[index];
                  return ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('${city['cityName']}'),
                    subtitle: Text('${city['country']['countryName']}'),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
