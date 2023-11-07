import 'dart:convert';

import 'package:github_api_demo/models/gist.dart';
import 'package:github_api_demo/models/repo.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class GitHubApi {
  final String baseUrl = 'https://api.github.com/';
  final String token = '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';

  Future<User?> findUser(String userName) async {
    final url = '${baseUrl}users/$userName';
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var user = User.fromJson(json);

      return user;
    } else {
      return null;
    }
  }

  Future<List<User>> getFollowing(String username) async {
    final url = '${baseUrl}users/$username/following';
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var jsonList = jsonDecode(response.body);
        var users = jsonList.map<User>((json) => User.fromJson(json)).toList();

        return users ?? [];
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Failed to get following");
    }
  }

  Future<List<Repo>> getRepos(String username) async {
    final url = '${baseUrl}users/$username/repos';
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var jsonList = jsonDecode(response.body);
        var repos = jsonList.map<Repo>((json) => Repo.fromJSON(json)).toList();

        return repos ?? [];
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Failed to get repos");
    }
  }

  Future<List<Repo>> getStarred(String username) async {
    final url = '${baseUrl}users/$username/starred';
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var jsonList = jsonDecode(response.body);
        var repos = jsonList.map<Repo>((json) => Repo.fromJSON(json)).toList();

        return repos ?? [];
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Failed to get starred repos");
    }
  }

  Future<List<Gist>> getGists(String username) async {
    final url = '${baseUrl}users/$username/gists';
    // try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var jsonList = jsonDecode(response.body);
        var repos = jsonList.map<Gist>((json) => Gist.fromJSON(json)).toList();

        return repos ?? [];
      } else {
        return [];
      }
    // } catch (e) {
    //   throw Exception("Failed to get gists ${e}");
    // }
  }
}
