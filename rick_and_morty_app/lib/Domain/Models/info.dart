final class Info {
  int count;
  int pages;
  String next;
  String? prev;

  Info({
    required this.count,
    required this.pages,
    required this.next,
    this.prev = '',
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
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
