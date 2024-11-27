class ItemModel {
  final int? id;
  final bool? deleted;
  final String? type;
  final String? by;
  final int? time;
  final String? text;
  final bool? dead;
  final int? parent;
  final List<int>? kids;
  final String? url;
  final int? score;
  final String? title;
  final int? descendants;

  ItemModel({
    this.id,
    this.deleted,
    this.type,
    this.by,
    this.time,
    this.text,
    this.dead,
    this.parent,
    this.kids,
    this.url,
    this.score,
    this.title,
    this.descendants,
  });

  ItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        deleted = json['deleted'],
        type = json['type'],
        by = json['by'],
        time = json['time'],
        text = json['text'],
        dead = json['dead'],
        parent = json['parent'],
        kids = json['kids'] != null
            ? (json['kids'] as List).map((e) => e as int).toList()
            : null,
        url = json['url'],
        score = json['score'],
        title = json['title'],
        descendants = json['descendants'];
}
