import 'package:hands_on_url_launcher/friend.dart';

class Favor {
  final String uuid;
  final String description;
  final DateTime dueDate;
  final bool accepted;
  final DateTime completed;
  final Friend friend;
  final String to;

  Favor(
      {this.uuid,
      this.description,
      this.dueDate,
      this.accepted,
      this.completed,
      this.friend,
      this.to});

  Favor.fromMap(String uid, Map<String, dynamic> data)
      : this(
          uuid: uid,
          description: data['description'],
          dueDate: DateTime.fromMillisecondsSinceEpoch(data['dueDate']),
          accepted: data['accepted'],
          completed: data['completed'] != null
              ? DateTime.fromMillisecondsSinceEpoch(data['completed'])
              : null,
          friend: Friend.fromMap(data['friend']),
          to: data['to'],
        );

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
    String to,
  }) {
    return Favor(
      uuid: uuid ?? this.uuid,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      accepted: accepted ?? this.accepted,
      completed: completed ?? this.completed,
      friend: friend ?? this.friend,
      to: to ?? this.to,
    );
  }

  Map<String, dynamic> toJson() => {
        'description': this.description,
        'dueDate': this.dueDate?.millisecondsSinceEpoch ?? null,
        'accepted': this.accepted,
        'completed': this.completed?.millisecondsSinceEpoch ?? null,
        'friend': this.friend.toJson(),
        'to': this.to
      };
}
