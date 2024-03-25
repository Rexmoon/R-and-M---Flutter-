final class InfoModel {
  int count;
  int pages;
  String next;
  String? prev;

  InfoModel({
    required this.count,
    required this.pages,
    required this.next,
    this.prev = '',
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) => InfoModel(
      count: json['count'],
      pages: json['pages'],
      next: json['next'],
      prev: json['prev']);

  Map<String, dynamic> toJson() => {
        'count': count,
        'pages': pages,
        'next': next,
        'prev': prev,
      };
}
