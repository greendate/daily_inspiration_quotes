class Quote {
  String? text;
  String? author;

  Quote({this.text, this.author});

  Quote.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    author = json['author'];
    if (author == null) author = "Unknown Author";
  }
}
