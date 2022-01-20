// ignore_for_file: file_names
class Category {
  int? termId;
  String? name;
  String? slug;
  String? description;
  int? count;

  Category({
    this.termId,
    this.name,
    this.slug,
    this.description,
    this.count,
  });

  Category.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'];
    name = json['name'];
    slug = json['slug'];

    description = json['description'];

    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['term_id'] = termId;
    data['name'] = name;
    data['slug'] = slug;

    data['description'] = description;

    data['count'] = count;

    return data;
  }
}
