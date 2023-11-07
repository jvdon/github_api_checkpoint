import 'package:github_api_demo/models/gists_file.dart';
import 'package:github_api_demo/models/user.dart';

class Gist {
  late String id;
  late String url;
  late DateTime created;
  late User owner;
  late List<GistFile> files;

  Gist({
    required this.id,
    required this.url,
    required this.created,
    required this.owner,
    required this.files
  });

  Gist.fromJSON(Map json){
    id = json["id"];
    url = json["url"];
    created = DateTime.parse(json["created_at"]);
    owner = User.fromJson(json["owner"]);
    files = [];
    
    
    for (var file in (json["files"] as Map).keys) {
      files.add(GistFile.fromJSON(json["files"][file]));

      // print(file);
    }

    // files = GistFile(json["files"]); ( as List<Map<dynamic, dynamic>>).map((e) => GistFile.fromJSON(e)).toList();

  }
}