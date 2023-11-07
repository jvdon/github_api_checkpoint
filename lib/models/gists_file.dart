class GistFile {
  late String name;
  late String content;
  late int size;

  GistFile({required this.name, required this.content});

  GistFile.fromJSON(Map json){
    name = json["filename"];
    content = json["raw_url"];
    size = json["size"];
  }

  @override
String toString() {
    return name;
}
}
