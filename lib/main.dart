import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String stringReponse;
  Map mapResponse;
  Map dataResponse;
  List listResponse;

  Future apicalls() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      setState(() {
        // stringReponse=response.body;
        mapResponse = json.decode(response.body);
        listResponse = mapResponse["data"];
      });
    }
  }

  @override
  void initState() {
    apicalls();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("API Demo")),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(listResponse[index]["avatar"]),
                  ),
                  // Text(listResponse[index]["id"].toString()),
                  Text(listResponse[index]["first_name"].toString()),
                  SizedBox(width: 10),
                  Text(listResponse[index]["last_name"].toString()),
                ],
              ),
            );
          },
          itemCount: listResponse == null ? 0 : listResponse.length,
        ));
  }
}
