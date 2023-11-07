import 'package:flutter/material.dart';
import 'package:github_api_demo/api/github_api.dart';
import 'package:github_api_demo/models/repo.dart';
import 'package:github_api_demo/models/user.dart';

class ReposPage extends StatefulWidget {
  User user;
  ReposPage({Key? key, required this.user}) : super(key: key);

  @override
  State<ReposPage> createState() => _ReposPageState();
}

class _ReposPageState extends State<ReposPage> {
  late Future<List<Repo>> futureRepos;
  @override
  void initState() {
    futureRepos = GitHubApi().getRepos(widget.user.login);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Repo>>(
        future: futureRepos,
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
                    Text("Error fetching repos")
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              List<Repo> repos = snapshot.data!;
              return ListView.builder(
                itemCount: repos.length,
                itemBuilder: (context, index) {
                  Repo repo = repos[index];
                  return ListTile(
                    title: Text(repo.name),
                    subtitle: Text(repo.desc),
                    trailing: Icon((repo.visible)
                        ? Icons.visibility
                        : Icons.visibility_off),
                  );
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
