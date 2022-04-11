class Comic {
  late int id;
  late String count;
  late bool done;

  Comic(
    this.id,
    this.count,
    this.done,
  );

  Map toJson() {
    return {
      'id': id,
      'title': count,
      'done': done,
    };
  }

  Comic.fromJson(Map json) {
    id = json['id'];
    count = json['title'];
    done = json['done'];
  }
}
