import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    Key? key,
    required this.destination,
    required this.image,
  }) : super(key: key);

  final String destination;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          useRootNavigator: true,
          context: context,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.85,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30,
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      destination,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: (destination.split(', ')[0] == 'London')
                        ? Text(
                            'London is the capital city of England. It is the most populous city in the United Kingdom, with a metropolitan area of over 13 million inhabitants.',
                          )
                        : (destination.split(', ')[0] == 'Paris')
                            ? Text(
                                'Paris is the capital and most populous city of France. The city is situated on the river Seine, in the north of the country, at the heart of the Île-de-France region.',
                              )
                            : (destination.split(', ')[0] == 'Rome')
                                ? Text(
                                    'Rome is the capital city and a special comune of Italy (named Comune di Roma Capitale). Rome also serves as the capital of the Lazio region. With 2,860,009 residents in 1,285 km2 (496.1 sq mi), it is also the country\'s most populated comune.',
                                  )
                                : SizedBox(),
                  ),
                  //Suggested Activities
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Suggested Activities',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/svg/face-svgrepo-com.svg',
                          height: 50,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          'assets/images/svg/straight-face.svg',
                          height: 50,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          'assets/images/svg/sad-face.svg',
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 8),
              width: MediaQuery.of(context).size.width * 0.35,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                destination.split(', ')[0],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                destination.split(', ')[1],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
