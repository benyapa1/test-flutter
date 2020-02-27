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
      home: FirstPage(title: 'My Beers'),
    );
  }
}

class FirstPage extends StatelessWidget {
  final String title;
  const FirstPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Beer>>(
          future: getBeers(),
          builder: (context,result) {
            if (result.hasError) print(result.error);
            return result.hasData
              ? BeerList(beers: result.data)
              : Center(child: CircularProgressIndicator());
          }
        ),
    );
  }
}

class BeerList extends StatelessWidget {
  final List<Beer> beers;
  const BeerList({Key key, this.beers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        children: List.generate(beers.length, (index) {
          return Center(
            child: Image.network(beers[index].imageUrl),
          );
        }),
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