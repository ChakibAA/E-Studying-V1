// ignore_for_file: file_names
class CourseRar {
  int? iD;
  String? filename;
  int? filesize;
  String? url;
  String? author;
  String? name;
  String? date;
  String? mimeType;
  String? subtype;

  CourseRar({
    required this.iD,
    required this.filename,
    required this.filesize,
    required this.url,
    this.author,
    this.name,
    this.date,
    this.mimeType,
    this.subtype,
  });

  CourseRar.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];

    filename = json['filename'];
    filesize = json['filesize'];
    url = json['url'];

    author = json['author'];

    name = json['name'];

    date = json['date'];

    mimeType = json['mime_type'];

    subtype = json['subtype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['filename'] = filename;
    data['filesize'] = filesize;
    data['url'] = url;

    data['author'] = author;

    data['name'] = name;

    data['date'] = date;

    data['mime_type'] = mimeType;

    data['subtype'] = subtype;
    return data;
  }
}
