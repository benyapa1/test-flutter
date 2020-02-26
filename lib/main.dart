import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List> getBeers() async {
  String url = 'https://api.punkapi.com/v2/beers?per_page=5';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

void main() async {
  List beers = await getBeers();
  print(beers);
  runApp(HelloApp());
}

class HelloApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello Flutter'),
        ),
        body: Center(
          child: Text(
            'Hello Flutter World',
            textDirection: TextDirection.ltr,
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
          ),
        ),
      )
    );
  }
}
