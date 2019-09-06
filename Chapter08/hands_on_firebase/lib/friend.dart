class Friend {
  final String uuid;
  final String name;
  final String number;
  final String photoURL;

  Friend({
    this.uuid,
    this.name,
    this.number,
    this.photoURL,
  });

  Friend.fromMap(Map<dynamic, dynamic> data)
      : this(
          uuid: data['uuid'],
          name: data['name'],
          number: data['number'],
          photoURL: data['photoURL'],
        );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'name': name,
        'number': number,
        'photoURL': photoURL,
      };

  bool operator ==(o) => o is Friend && o.name == name && o.number == number;

  @override
  int get hashCode => name.hashCode ^ number.hashCode;
}
