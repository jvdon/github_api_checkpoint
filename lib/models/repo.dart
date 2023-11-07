import 'package:github_api_demo/models/user.dart';

class Repo {
  late String name;
  late User owner;
  late String desc;
  late int size;
  late String language;
  late bool visible;

  Repo(
      {required this.name,
      required this.owner,
      required this.desc,
      required this.size,
      required this.language,
      required this.visible});

  Repo.fromJSON(Map json) {
    name = json["name"];
    owner = User.fromJson(json["owner"]);
    desc = json["description"] ?? "None";
    size = json["size"];
    language = json["language"] ?? "None";
    visible = json["visibility"] == "public";
  }
}
