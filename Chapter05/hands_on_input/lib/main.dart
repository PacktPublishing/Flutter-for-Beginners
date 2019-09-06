import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hands_on_layouts/favor.dart';
import 'package:hands_on_layouts/friend.dart';
import 'package:hands_on_layouts/mock_values.dart';
import 'package:flutter/services.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // home: RequestFavorPage( // uncomment this and comment 'home' below to change the visible page for now
      //   friends: mockFriends,
      // ),
      home: FavorsPage(),
    );
  }
}

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

  @override
  void initState() {
    super.initState();

    pendingAnswerFavors = List();
    acceptedFavors = List();
    completedFavors = List();
    refusedFavors = List();

    loadFavors();
  }

  void loadFavors() {
    pendingAnswerFavors.addAll(mockPendingFavors);
    acceptedFavors.addAll(mockDoingFavors);
    completedFavors.addAll(mockCompletedFavors);
    refusedFavors.addAll(mockRefusedFavors);
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
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RequestFavorPage(
                      friends: mockFriends,
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
    return Tab(
      child: Text(title),
    );
  }

  void refuseToDo(Favor favor) {
    setState(() {
      pendingAnswerFavors.remove(favor);

      refusedFavors.add(favor.copyWith(accepted: false));
    });
  }

  void acceptToDo(Favor favor) {
    setState(() {
      pendingAnswerFavors.remove(favor);

      acceptedFavors.add(favor.copyWith(accepted: true));
    });
  }

  void giveUp(Favor favor) {
    setState(() {
      acceptedFavors.remove(favor);

      refusedFavors.add(favor.copyWith(
        accepted: false,
      ));
    });
  }

  void complete(Favor favor) {
    setState(() {
      acceptedFavors.remove(favor);

      completedFavors.add(favor.copyWith(
        completed: DateTime.now(),
      ));
    });
  }
}

class FavorsList extends StatelessWidget {
  final String title;
  final List<Favor> favors;

  const FavorsList({Key key, this.title, this.favors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          child: Text(title),
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
    return Card(
      key: ValueKey(favor.uuid),
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      child: Padding(
        child: Column(
          children: <Widget>[
            _itemHeader(favor),
            Text(favor.description),
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
          label: Text("Completed at: ${format.format(favor.completed)}"),
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

  Widget _itemHeader(Favor favor) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(
            favor.friend.photoURL,
          ),
        ),
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text("${favor.friend.name} asked you to... ")),
        )
      ],
    );
  }
}

class RequestFavorPage extends StatefulWidget {
  List<Friend> friends;

  RequestFavorPage({Key key, this.friends}) : super(key: key);

  @override
  RequestFavorPageState createState() {
    return new RequestFavorPageState();
  }
}

class RequestFavorPageState extends State<RequestFavorPage> {
  final _formKey = GlobalKey<FormState>();
  Friend _selectedFriend = null;

  static RequestFavorPageState of(BuildContext context) {
    return context.ancestorStateOfType(TypeMatcher<RequestFavorPageState>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Requesting a favor"),
        leading: CloseButton(),
        actions: <Widget>[
          Builder(
            builder: (context) => FlatButton(
                  child: Text("SAVE"),
                  textColor: Colors.white,
                  onPressed: () {
                    RequestFavorPageState.of(context).save();
                  },
                ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DropdownButtonFormField<Friend>(
                value: _selectedFriend,
                onChanged: (friend) {
                  setState(() {
                   _selectedFriend = friend; 
                  });
                },
                items: widget.friends
                    .map(
                      (f) => DropdownMenuItem<Friend>(
                            value: f,
                            child: Text(f.name),
                          ),
                    )
                    .toList(),
                validator: (friend) {
                  if (friend == null) {
                    return "You must select a friend to ask the favor";
                  }
                  return null;
                },
              ),
              Container(
                height: 16.0,
              ),
              Text("Favor description:"),
              TextFormField(
                maxLines: 5,
                inputFormatters: [LengthLimitingTextInputFormatter(200)],
                validator: (value) {
                  if (value.isEmpty) {
                    return "You must detail the favor";
                  }
                  return null;
                },
              ),
              Container(
                height: 16.0,
              ),
              Text("Due Date:"),
              DateTimePickerFormField(
                inputType: InputType.both,
                format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
                editable: false,
                decoration: InputDecoration(
                    labelText: 'Date/Time', hasFloatingPlaceholder: false),
                validator: (dateTime) {
                  if (dateTime == null) {
                    return "You must select a due date time for the favor";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void save() {
    if (_formKey.currentState.validate()) {
      // store the favor request on firebase
      Navigator.pop(context);
    }
  }
}
