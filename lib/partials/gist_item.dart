import 'package:flutter/material.dart';
import 'package:github_api_demo/models/gist.dart';
import 'package:github_api_demo/models/gists_file.dart';
import 'package:github_api_demo/partials/gist_detail.dart';

import 'package:http/http.dart' as http;

class GistItem extends StatefulWidget {
  Gist gist;
  GistItem({Key? key, required this.gist}) : super(key: key);

  @override
  State<GistItem> createState() => _GistItemState();
}

class _GistItemState extends State<GistItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.gist.id),
      subtitle: Text("File: ${widget.gist.files.join(', ')}"),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => GistDetail(files: widget.gist.files),
        ));
      },
    );
  }
}
