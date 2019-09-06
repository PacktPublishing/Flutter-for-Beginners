import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hands_on_firebase/favor.dart';
import 'package:hands_on_firebase/friend.dart';
import 'package:hands_on_firebase/pages/login_page.dart';
import 'package:hands_on_firebase/pages/request_favors_page.dart';
import 'package:intl/intl.dart';

class FavorsPage extends StatefulWidget {
  FavorsPage({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FavorsPageState();
}

class FavorsPageState extends State<FavorsPage> {
  // using mock values from mock_favors dart file for now
  List<Favor> pendingAnswerFavors;
  List<Favor> acceptedFavors;
  List<Favor> completedFavors;
  List<Favor> refusedFavors;
  Set<Friend> friends;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.currentUser().then((user) {
      if (user == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    });

    pendingAnswerFavors = List();
    acceptedFavors = List();
    completedFavors = List();
    refusedFavors = List();
    friends = Set();

    watchFavorsCollection();
  }

  void watchFavorsCollection() async {
    final currentUser = await FirebaseAuth.instance.currentUser();

    Firestore.instance
        .collection('favors')
        .where('to', isEqualTo: currentUser.phoneNumber)
        .snapshots()
        .listen((snapshot) {
      List<Favor> newCompletedFavors = List();
      List<Favor> newRefusedFavors = List();
      List<Favor> newAcceptedFavors = List();
      List<Favor> newPendingAnswerFavors = List();
      Set<Friend> newFriends = Set();

      snapshot.documents.forEach((document) {
        Favor favor = Favor.fromMap(document.documentID, document.data);

        if (favor.isCompleted) {
          newCompletedFavors.add(favor);
        } else if (favor.isRefused) {
          newRefusedFavors.add(favor);
        } else if (favor.isDoing) {
          newAcceptedFavors.add(favor);
        } else {
          newPendingAnswerFavors.add(favor);
        }

        newFriends.add(favor.friend);
      });

      // update our lists
      setState(() {
        this.completedFavors = newCompletedFavors;
        this.pendingAnswerFavors = newPendingAnswerFavors;
        this.refusedFavors = newRefusedFavors;
        this.acceptedFavors = newAcceptedFavors;
        this.friends = newFriends;
      });
    });
  }

  static FavorsPageState of(BuildContext context) {
    return context.ancestorStateOfType(TypeMatcher<FavorsPageState>());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Your favors"),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              _buildCategoryTab("Requests"),
              _buildCategoryTab("Doing"),
              _buildCategoryTab("Completed"),
              _buildCategoryTab("Refused"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FavorsList(title: "Pending Requests", favors: pendingAnswerFavors),
            FavorsList(title: "Doing", favors: acceptedFavors),
            FavorsList(title: "Completed", favors: completedFavors),
            FavorsList(title: "Refused", favors: refusedFavors),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "request_favor",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RequestFavorPage(
                      friends: friends.toList(),
                    ),
              ),
            );
          },
          tooltip: 'Ask a favor',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildCategoryTab(String title) {
    return Tab(child: Text(title));
  }

  void refuseToDo(Favor favor) {
    _updateFavorOnFirebase(favor.copyWith(accepted: false));
  }

  void acceptToDo(Favor favor) {
    _updateFavorOnFirebase(favor.copyWith(
      accepted: true,
    ));
  }

  void giveUp(Favor favor) {
    _updateFavorOnFirebase(favor.copyWith(
      accepted: false,
    ));
  }

  void complete(Favor favor) {
    _updateFavorOnFirebase(favor.copyWith(
      completed: DateTime.now(),
    ));
  }

  void _updateFavorOnFirebase(Favor favor) async {
    await Firestore.instance
        .collection('favors')
        .document(favor.uuid)
        .setData(favor.toJson());
  }
}

class FavorsList extends StatelessWidget {
  final String title;
  final List<Favor> favors;

  const FavorsList({Key key, this.title, this.favors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.title;

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          child: Text(
            title,
            style: titleStyle,
          ),
          padding: EdgeInsets.only(top: 16.0),
        ),
        Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: favors.length,
            itemBuilder: (BuildContext context, int index) {
              final favor = favors[index];
              return FavorCardItem(favor: favor);
            },
          ),
        ),
      ],
    );
  }
}

class FavorCardItem extends StatelessWidget {
  final Favor favor;

  const FavorCardItem({Key key, this.favor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyStyle = Theme.of(context).textTheme.headline;
    return Card(
      key: ValueKey(favor.uuid),
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      child: Padding(
        child: Column(
          children: <Widget>[
            _itemHeader(context, favor),
            Text(
              favor.description,
              style: bodyStyle,
            ),
            _itemFooter(context, favor)
          ],
        ),
        padding: EdgeInsets.all(8.0),
      ),
    );
  }

  Widget _itemFooter(BuildContext context, Favor favor) {
    if (favor.isCompleted) {
      final format = DateFormat();
      return Container(
        margin: EdgeInsets.only(top: 8.0),
        alignment: Alignment.centerRight,
        child: Chip(
          label: Text(
            "Completed at: ${format.format(favor.completed)}",
          ),
        ),
      );
    }
    if (favor.isRequested) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            child: Text("Refuse"),
            onPressed: () {
              FavorsPageState.of(context).refuseToDo(favor);
            },
          ),
          FlatButton(
            child: Text("Do"),
            onPressed: () {
              FavorsPageState.of(context).acceptToDo(favor);
            },
          )
        ],
      );
    }
    if (favor.isDoing) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            child: Text("give up"),
            onPressed: () {
              FavorsPageState.of(context).giveUp(favor);
            },
          ),
          FlatButton(
            child: Text("complete"),
            onPressed: () {
              FavorsPageState.of(context).complete(favor);
            },
          )
        ],
      );
    }

    return Container();
  }

  Widget _itemHeader(BuildContext context, Favor favor) {
    final headerStyle = Theme.of(context).textTheme.subhead;

    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: favor.friend.photoURL != null
              ? NetworkImage(
                  favor.friend.photoURL,
                )
              : AssetImage('assets/default_avatar.png'),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              "${favor.friend.name} asked you to... ",
              style: headerStyle,
            ),
          ),
        )
      ],
    );
  }
}
