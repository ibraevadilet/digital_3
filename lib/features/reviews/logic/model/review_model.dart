class ReviewModel {
  String? id;
  late Author author;
  late String title;
  late String image;
  late String text;
  late List<Comments> comments;
  late bool isLiked;

  ReviewModel({
    this.id,
    required this.isLiked,
    required this.author,
    required this.title,
    required this.image,
    required this.text,
    required this.comments,
  });

  ReviewModel.fromJson(Map<dynamic, dynamic> json) {
    print(json['id']);
    id = json['id'];
    author = Author.fromJson(json['author']);
    title = json['title'];
    image = json['image'];
    text = json['text'];
    comments = <Comments>[];
    if (json['comments'] != null) {
      json['comments'].forEach((v) {
        comments.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['author'] = author.toJson();
    data['title'] = title;
    data['image'] = image;
    data['text'] = text;
    data['comments'] = comments.map((v) => v.toJson()).toList();

    return data;
  }
}

class Author {
  late String name;
  late String id;
  late String avatar;

  Author({
    required this.name,
    required this.id,
    required this.avatar,
  });

  Author.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    id = json['id'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['avatar'] = avatar;
    return data;
  }
}

class Comments {
  late Author author;
  late String comment;

  Comments({
    required this.author,
    required this.comment,
  });

  Comments.fromJson(Map<dynamic, dynamic> json) {
    author = Author.fromJson(json['author']);
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['author'] = author.toJson();

    data['comment'] = comment;
    return data;
  }
}
