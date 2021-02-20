import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class Home extends StatelessWidget {
  Future<List<User>> getUsersHandler() async {
    final response =
        await http.get("https://jsonplaceholder.typicode.com/users");

    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body) as List;
      return <User>[for (var user in extractedData) User.fromJson(user)];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Network Request Handling"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<User>>(
        future: getUsersHandler(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    final List<User> user = snapshot.data;
                    return ListTile(
                      title: Text(user[i].name),
                      subtitle: Text(user[i].email),
                    );
                  });
            } else {
              return _Error("${snapshot.error}");
            }
          } else {
            return _Error("${snapshot.error}");
          }
        },
      ),
    );
  }
}

class _Error extends StatelessWidget {
  final String message;

  const _Error(this.message);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
    );
  }
}
