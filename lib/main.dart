import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Beer>> getBeers() async {
  String url = 'https://api.punkapi.com/v2/beers?per_page=5';
  http.Response response = await http.get(url);

  //try to convert json to dart object
  List<Beer> allBeers = new List();
  List<dynamic> beers = json.decode(response.body);
  for (var beerJson in beers) {
    var beer = Beer.fromJson(beerJson);
    allBeers.add(beer);
  }
  return allBeers;
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

class Beer {
  final int id;
  final String name;
  final imageUrl;

  Beer({this.id, this.name, this.imageUrl});

  @override
  String toString() {
    return '\n(id=$id : name=$name)\n';
  }

  factory Beer.fromJson(Map<String, dynamic> json) {
    return Beer(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }
}