import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/providers/destinations_provider.dart';
import 'package:travela_mobile/providers/user_provider.dart';
import 'package:travela_mobile/widgets/home/popular_places.dart';
import 'package:travela_mobile/widgets/home/suggestions.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  TextEditingController _searchController = TextEditingController();

  List<String> filteredCities = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
        [
          Provider.of<DestinationsProvider>(context, listen: false)
              .fetchAndSetCities(),
          Provider.of<DestinationsProvider>(context, listen: false)
              .getPopularCities(),
          Provider.of<UserProvider>(context, listen: false)
              .getTripSuggestions(userId),
        ],
      ).then(
        (value) => Future.delayed(Duration(seconds: 1)),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildBodyShimmer(context);
        } else
          return buildBody(context);
      },
    );
  }

  CustomScrollView buildBodyShimmer(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Travela',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          pinned: true,
          backgroundColor: Colors.white,
          floating: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: TextField(
                    onTap: () {},
                    controller:
                        _searchController, // TODO: Implement search functionality
                    decoration: InputDecoration(
                      hintText: 'Where Do You Want To Go?',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                      /* suffixIcon: IconButton(
                        icon: Icon(Icons.filter_list),
                        onPressed: () {
                          _filterModal(context);
                        },
                      ), */
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 0,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: PopularPlaces(
                      isArranged: false,
                    ),
                  ),
                ),
                Divider(),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: SuggestionsForYou(
                      isArranged: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  CustomScrollView buildBody(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Travela',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          pinned: true,
          backgroundColor: Colors.white,
          floating: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: TextField(
                    onTap: () {},
                    controller:
                        _searchController, // TODO: Implement search functionality
                    decoration: InputDecoration(
                      hintText: 'Where Do You Want To Go?',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                      /* suffixIcon: IconButton(
                        icon: Icon(Icons.filter_list),
                        onPressed: () {
                          _filterModal(context);
                        },
                      ), */
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 0,
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: PopularPlaces(
                    isArranged: false,
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: SuggestionsForYou(
                    isArranged: false,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
