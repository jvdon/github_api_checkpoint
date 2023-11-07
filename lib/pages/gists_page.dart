import 'package:flutter/material.dart';
import 'package:github_api_demo/api/github_api.dart';
import 'package:github_api_demo/models/gist.dart';
import 'package:github_api_demo/models/user.dart';
import 'package:github_api_demo/partials/gist_item.dart';

class GistsPage extends StatefulWidget {
  User user;
  GistsPage({Key? key, required this.user}) : super(key: key);

  @override
  State<GistsPage> createState() => _GistsPageState();
}

class _GistsPageState extends State<GistsPage> {
  late Future<List<Gist>> futureGists;
  @override
  void initState() {
    futureGists = GitHubApi().getGists(widget.user.login);
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Gist>>(
        future: futureGists,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.error,
                      size: 64,
                    ),
                    Text("Error fetching gists")
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              List<Gist> gists = snapshot.data!;
              return ListView.builder(
                itemCount: gists.length,
                itemBuilder: (context, index) {
                  Gist gist = gists[index];
                  return GistItem(gist: gist);
                },
              );
            }
          }
          return Center(
            child: Text("Unkown state!"),
          );
        },
      ),
    );
  }
}