import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/providers/user_provider.dart';
import 'package:travela_mobile/widgets/friend_card.dart';
import 'package:travela_mobile/widgets/request_card.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: [
          FriendCard(
            title: 'Friends',
            friendNames: currentFriendUsernames,
            friendIds: currentFriendIds,
          ),
          RequestCard(
            title: 'Requests',
            requestNames: currentRequestUsernames,
            requestIds: currentRequestIds,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                TextEditingController _controller = TextEditingController();
                showDialog(
                  context: context,
                  builder: (context) {
                    return Theme.of(context).platform == TargetPlatform.iOS
                        ? CupertinoAlertDialog(
                            title: Text('Send friend request'),
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CupertinoTextField(
                                controller: _controller,
                                placeholder: 'Enter username',
                                onChanged: (value) {
                                  print(value);
                                },
                              ),
                            ),
                            actions: [
                              Theme.of(context).platform == TargetPlatform.iOS
                                  ? CupertinoDialogAction(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel'),
                                    )
                                  : TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel'),
                                    ),
                              CupertinoDialogAction(
                                onPressed: () {
                                  print(currentUser.name);
                                  print('$userId');
                                  print('friend username' + _controller.text);

                                  final userData = Provider.of<UserProvider>(
                                      context,
                                      listen: false);
                                  userData
                                      .getUserIdByUsername(_controller.text)
                                      .then(
                                    (value) {
                                      print('friend id' + friendId);
                                      userData
                                          .sendFriendRequest(userId, friendId)
                                          .then((value) {
                                        Navigator.of(context).pop();
                                        if (value) {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Theme.of(context)
                                                          .platform ==
                                                      TargetPlatform.iOS
                                                  ? CupertinoAlertDialog(
                                                      title: Text('Success'),
                                                      content: Text(
                                                          'Friend request sent successfully'),
                                                      actions: [
                                                        CupertinoDialogAction(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamedAndRemoveUntil(
                                                              '/home',
                                                              (route) => false,
                                                            );
                                                            pageNum = 2;
                                                          },
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    )
                                                  : AlertDialog(
                                                      title: Text('Success'),
                                                      content: Text(
                                                          'Friend request sent successfully'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamedAndRemoveUntil(
                                                              '/home',
                                                              (route) => false,
                                                            );
                                                            pageNum = 2;
                                                          },
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    );
                                            },
                                          );
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Theme.of(context)
                                                          .platform ==
                                                      TargetPlatform.iOS
                                                  ? CupertinoAlertDialog(
                                                      title: Text('Error'),
                                                      content: Text(
                                                          'An error occurred while sending friend request'),
                                                      actions: [
                                                        CupertinoDialogAction(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    )
                                                  : AlertDialog(
                                                      title: Text('Error'),
                                                      content: Text(
                                                          'An error occurred while sending friend request'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    );
                                            },
                                          );
                                        }
                                      });
                                    },
                                  );
                                },
                                child: Text('Send'),
                              ),
                            ],
                          )
                        : AlertDialog(
                            title: Text('Send friend request'),
                            content: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: 'Enter username',
                              ),
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  print(currentUser.name);
                                  print('$userId');
                                  print('friend username' + _controller.text);

                                  final userData = Provider.of<UserProvider>(
                                      context,
                                      listen: false);
                                  userData
                                      .getUserIdByUsername(_controller.text)
                                      .then(
                                    (value) {
                                      print('friend id' + friendId);
                                      userData
                                          .sendFriendRequest(userId, friendId)
                                          .then((value) {
                                        Navigator.of(context).pop();
                                        if (value) {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('Success'),
                                                content: Text(
                                                    'Friend request sent successfully'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushNamedAndRemoveUntil(
                                                        '/home',
                                                        (route) => false,
                                                      );
                                                      pageNum = 2;
                                                    },
                                                    child: Text('Ok'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('Error'),
                                                content: Text(
                                                    'An error occurred while sending friend request'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('Ok'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      });
                                    },
                                  );
                                },
                                child: Text('Send'),
                              ),
                            ],
                          );
                  },
                );
              },
              child: Icon(Icons.add),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
