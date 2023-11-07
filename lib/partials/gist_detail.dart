import 'package:flutter/material.dart';
import 'package:github_api_demo/models/gists_file.dart';
import 'package:http/http.dart' as http;

class GistDetail extends StatefulWidget {
  late List<GistFile> files;
  GistDetail({Key? key, required this.files}) : super(key: key);

  @override
  State<GistDetail> createState() => _GistDetailState();
}

class _GistDetailState extends State<GistDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 5,
            color: Colors.deepPurple,
          );
        },
        itemCount: widget.files.length,
        itemBuilder: (context, index) {
          GistFile file = widget.files[index];
          Future<http.Response> fileContent =
              http.get(Uri.parse((file.content)));

          return FutureBuilder<http.Response>(
            future: fileContent,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return const Center(
                        child: Column(
                      children: [
                        Icon(Icons.error),
                        Text("Unable to load file")
                      ],
                    ));
                  } else {
                    return Expanded(
                      // height: 500,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  file.name,
                                  style: TextStyle(fontSize: 24),
                                ),
                                Text(
                                  "${(file.size / 1024).toString()} Kb",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Text(snapshot.data!.body)
                          ],
                        ),
                      ),
                    );
                  }
                default:
                  return const Text("Unknown state");
              }
            },
          );
        },
      ),
    );
  }
}
