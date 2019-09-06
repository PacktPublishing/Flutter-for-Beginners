import 'package:hands_on_themes/friend.dart';

class Favor {
  final String uuid;
  final String description;
  final DateTime dueDate;
  final bool accepted;
  final DateTime completed;
  final Friend friend;

  Favor({
    this.uuid,
    this.description,
    this.dueDate,
    this.accepted,
    this.completed,
    this.friend,
  });

  /// returns true if the favor is active ( the user is doing it )
  get isDoing => accepted == true && completed == null;

  /// returns true if the user has not answered the request yet
  get isRequested => accepted == null;

  /// returns true if the favor is already completed
  get isCompleted => completed != null;

  /// returns true if the favor was not accepted
  get isRefused => accepted == false;

  Favor copyWith({
    String uuid,
    String description,
    DateTime dueDate,
    bool accepted,
    DateTime completed,
    Friend friend,
  }) {
    return Favor(
      uuid: uuid ?? this.uuid,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      accepted: accepted ?? this.accepted,
      completed: completed ?? this.completed,
      friend: friend ?? this.friend,
    );
  }
}
