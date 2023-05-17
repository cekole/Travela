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
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                TextEditingController _controller = TextEditingController();
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Text('Send friend request'),
                        content: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Enter username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onSubmitted: (value) {
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
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              title: Text('Success'),
                                              content: Text(
                                                  'Friend request sent successfully'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamedAndRemoveUntil(
                                                            '/home',
                                                            (route) => false);
                                                    pageNum = 2;
                                                  },
                                                  child: Text('Ok'),
                                                ),
                                              ],
                                            );
                                          });
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              title: Text('Error'),
                                              content: Text(
                                                  'An error occured while sending friend request'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Ok'),
                                                ),
                                              ],
                                            );
                                          });
                                    }
                                  });
                                },
                              );
                              //
                            },
                            child: Text('Send'),
                          ),
                        ],
                      );
                    });
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
