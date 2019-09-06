import 'package:hands_on_url_launcher/favor.dart';
import 'package:hands_on_url_launcher/friend.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

final mockPendingFavors = [
  Favor(
    uuid: uuid.v4(),
    description: "go to the supermarket",
    dueDate: DateTime.now().add(Duration(days: 1)),
    friend: Friend(
      name: "My cat",
      number: "11111111111",
      photoURL: "https://placekitten.com/g/200/300",
    ),
  ),
  Favor(
    uuid: uuid.v4(),
    description: "call mom",
    dueDate: DateTime.now().add(Duration(hours: 5)),
    friend: Friend(
      name: "Wife",
      number: "9292992929",
      photoURL: "https://placekitten.com/200/286",
    ),
  ),
  Favor(
    uuid: uuid.v4(),
    description: "go to the supermarket now!",
    dueDate: DateTime.now(),
    friend: Friend(
      name: "My cat",
      number: "11111111111",
      photoURL: "https://placekitten.com/g/200/300",
    ),
  ),
  Favor(
    uuid: uuid.v4(),
    description: "go to the supermarket now!",
    dueDate: DateTime.now(),
    friend: Friend(
      name: "My cat",
      number: "11111111111",
      photoURL: "https://placekitten.com/g/200/300",
    ),
  ),
];

// accepted favors
final mockDoingFavors = [
  Favor(
    uuid: uuid.v4(),
    description: "eat a watermelon",
    dueDate: DateTime.now().add(Duration(days: 1)),
    accepted: true,
    friend: Friend(
      name: "Dude 1",
      number: "99999999900",
      photoURL: "https://placekitten.com/g/300/300",
    ),
  ),
  Favor(
    uuid: uuid.v4(),
    description: "cut the grass",
    dueDate: DateTime.now().add(Duration(hours: 1)),
    accepted: true,
    friend: Friend(
      name: "Dad",
      number: "99999999999",
      photoURL: "https://placekitten.com/200/200",
    ),
  )
];

// completed favors
final mockCompletedFavors = [
  Favor(
    uuid: uuid.v4(),
    description: "make the dinner",
    dueDate: DateTime.now().add(Duration(days: 1)),
    completed: DateTime.now(),
    accepted: true,
    friend: Friend(
      name: "Mom",
      number: "99999999991",
      photoURL: "https://placekitten.com/g/400/400",
    ),
  ),
];

// refused favors
final mockRefusedFavors = [
  Favor(
    uuid: uuid.v4(),
    description: "find a job",
    dueDate: DateTime.now().add(Duration(days: 1)),
    accepted: false,
    friend: Friend(
      name: "Dad",
      number: "99999999999",
      photoURL: "https://placekitten.com/200/200",
    ),
  ),
];

final mockFriends = [
  Friend(
    name: "My cat",
    number: "11111111111",
    photoURL: "https://placekitten.com/g/200/300",
  ),
  Friend(
    name: "Mom",
    number: "99999999991",
    photoURL: "https://placekitten.com/g/400/400",
  ),
  Friend(
    name: "Dad",
    number: "99999999999",
    photoURL: "https://placekitten.com/200/200",
  ),
];
