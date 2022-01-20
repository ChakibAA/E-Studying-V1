// ignore_for_file: file_names
class Module {
  int? termId;
  String? name;
  String? slug;
  int? termTaxonomyId;
  String? taxonomy;
  String? description;

  int? count;

  String? permalink;

  Module(
      {this.name,
      this.slug,
      this.termTaxonomyId,
      this.taxonomy,
      this.description,
      this.count,
      this.permalink});

  Module.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'];
    name = json['name'];
    slug = json['slug'];

    termTaxonomyId = json['term_taxonomy_id'];
    taxonomy = json['taxonomy'];
    description = json['description'];

    count = json['count'];

    permalink = json['permalink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['term_id'] = termId;
    data['name'] = name;
    data['slug'] = slug;

    data['term_taxonomy_id'] = termTaxonomyId;
    data['taxonomy'] = taxonomy;
    data['description'] = description;

    data['count'] = count;

    data['permalink'] = permalink;
    return data;
  }
}
