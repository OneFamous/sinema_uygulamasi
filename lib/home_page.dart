import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  fetchMovies() async {
    var url;
    url = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=1500496dcaf1512b62894bd98ba83f9d&language=en-US"));
    return json.decode(url.body)['results'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff191826),
      appBar: AppBar(
        backgroundColor: Color(0xff191826),
        title: Text(
          'FİLMLER',
          style: TextStyle(
            fontSize: 25,
            color: Color(0xfff43370),
          ),
        ),
        elevation: 0.0,
        centerTitle: false,
      ),
      body: FutureBuilder(
        future: fetchMovies(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("HATA!"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Container(
                      child: Card(
                        child: Image.network("https://image.tmdb.org/t/p/w500" +
                            snapshot.data[index]["poster_path"]),
                      ),
                    ),
                    Container(),
                  ],
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
