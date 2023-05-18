import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/providers/accomodation_provider.dart';
import 'package:travela_mobile/widgets/home/place_card.dart';

class AccomodationList extends StatelessWidget {
  const AccomodationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accomodation'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        itemCount: currentAccomodations.length,
        itemBuilder: (context, index) {
          final price = currentAccomodations[index][1] as String;

          return Container(
            padding: const EdgeInsets.all(4.0),
            height: MediaQuery.of(context).size.height * 0.25,
            child: Container(
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    currentAccomodations[index][2],
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        currentAccomodations[index][0] +
                            ', ' +
                            price.substring(1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
