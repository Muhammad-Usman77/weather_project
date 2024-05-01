import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // bool loading = true;
  @override
  void initState() {
   // getData();
    super.initState();
  }

  
  getData() async {
    final String url = "https://yahoo-weather5.p.rapidapi.com/weather";
    final Map<String, String> headers = {
      'X-RapidAPI-Key': '1355123370msh800f1b7a9259b6dp1a9598jsn8e1a684aac21',
      'X-RapidAPI-Host': 'yahoo-weather5.p.rapidapi.com'
    };
    final Map<String, String> params = {'location': 'karachi', 'u': 'c'};

    Uri uri = Uri.parse(url);
    uri = uri.replace(queryParameters: params);
    try {
      final response = await http.get(uri, headers: headers);
      Map<String, dynamic> res = await jsonDecode(response.body);
   
      return res;
      
    } catch (e) {
      print(e);
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather App"),
        ),
        body: FutureBuilder(
            future: getData(),
            builder: ((context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListTile(
                    title: Column(
                  children: [
                     Text(snapshot.data['location']['country']),
                     SizedBox(height: 20,),
                     Text(snapshot.data['location']['city']),
                      SizedBox(height: 20,),
                    Text(snapshot.data['current_observation']['atmosphere']['humidity'].toString()),
                  ],
                ));
              } else {
                return Text('loading....');
              }
            })));
  }
}
