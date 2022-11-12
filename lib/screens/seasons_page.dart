import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Seasons extends StatelessWidget {
  const Seasons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final seasonIndex = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: seasonIndex == 0
            ? Text('Winter')
            : seasonIndex == 1
                ? Text('Spring')
                : seasonIndex == 2
                    ? Text('Summer')
                    : seasonIndex == 3
                        ? Text('Fall')
                        : Text('Seasons'),
      ),
      body: Center(
        child: Text('Seasons'),
      ),
    );
  }
}
