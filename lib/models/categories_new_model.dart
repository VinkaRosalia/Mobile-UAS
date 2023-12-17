// Kelas CategoriesNewsModel merepresentasikan data kategori berita.
class CategoriesNewsModel {
  String? status;
  int? totalResults;
  List<Articles>? articles;

  CategoriesNewsModel({this.status, this.totalResults, this.articles});

  // Metode untuk mengonversi data JSON menjadi objek CategoriesNewsModel.
  CategoriesNewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(new Articles.fromJson(v));
      });
    }
  }

  // Metode untuk mengonversi objek CategoriesNewsModel menjadi format JSON.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalResults'] = this.totalResults;
    if (this.articles != null) {
      data['articles'] = this.articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// Kelas Articles merepresentasikan informasi tentang artikel berita.
class Articles {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Articles(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  // Metode untuk mengonversi data JSON menjadi objek Articles.
  Articles.fromJson(Map<String, dynamic> json) {
    source =
        json['source'] != null ? new Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  // Metode untuk mengonversi objek Articles menjadi format JSON.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.source != null) {
      data['source'] = this.source!.toJson();
    }
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlToImage'] = this.urlToImage;
    data['publishedAt'] = this.publishedAt;
    data['content'] = this.content;
    return data;
  }
}

// Kelas Source merepresentasikan sumber (source) dari artikel berita.
class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  // Metode untuk mengonversi data JSON menjadi objek Source.
  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  // Metode untuk mengonversi objek Source menjadi format JSON.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
