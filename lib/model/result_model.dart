// class NewsResult {
//   String? title;
//   String? link;
//   String? description;
//   String? imageUrl;
//   String? sourceName;
//   String? sourceIcon;
//   String? category;
//
//   NewsResult({
//     this.title,
//     this.link,
//     this.description,
//     this.imageUrl,
//     this.sourceName,
//     this.sourceIcon,
//     this.category,
//   });
//
//   NewsResult.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     link = json['link'];
//     description = json['description'];
//     imageUrl = json['image_url'];
//     sourceName = json['source_name'];
//     sourceIcon = json['source_icon'];
//     category = json['category'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['title'] = this.title;
//     data['link'] = this.link;
//     data['description'] = this.description;
//     data['image_url'] = this.imageUrl;
//     data['source_name'] = this.sourceName;
//     data['source_icon'] = this.sourceIcon;
//     data['category'] = this.category;
//     return data; // Return the map here
//   }
// }


class NewsResult {
  final String title;
  final String link;
  final String description;
  final String imageUrl;
  final String sourceName;
  final String sourceIcon;
  final String category;
  final String articleId; // Unique identifier

  NewsResult({
    required this.title,
    required this.link,
    required this.description,
    required this.imageUrl,
    required this.sourceName,
    required this.sourceIcon,
    required this.category,
    required this.articleId,
  });

  // Convert a NewsResult into a Map object
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'link': link,
      'description': description,
      'image_url': imageUrl,
      'source_name': sourceName,
      'source_icon': sourceIcon,
      'category': category,
      'articleId': articleId,
    };
  }

  // Extract a NewsResult object from a Map object
  factory NewsResult.fromMap(Map<String, dynamic> map) {
    return NewsResult(
      title: map['title'],
      link: map['link'],
      description: map['description'],
      imageUrl: map['image_url'],
      sourceName: map['source_name'],
      sourceIcon: map['source_icon'],
      category: map['category'],
      articleId: map['articleId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = this.title;
    data['link'] = this.link;
    data['description'] = this.description;
    data['image_url'] = this.imageUrl;
    data['source_name'] = this.sourceName;
    data['source_icon'] = this.sourceIcon;
    data['category'] = this.category;
    data['articleId'] = this.articleId;
    return data; // Return the map here
  }
}
