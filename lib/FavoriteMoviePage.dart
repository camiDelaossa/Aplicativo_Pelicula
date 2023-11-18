import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class FavoriteMoviePage extends StatefulWidget {
  const FavoriteMoviePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<FavoriteMoviePage> createState() => _FavoriteMoviePageState();
}

class _FavoriteMoviePageState extends State<FavoriteMoviePage> {
  final String url = 'http://www.omdbapi.com/?i=tt0167260&apikey=6363e229';
  late Map<String, dynamic> film;
  bool dataOK = false;

  @override
  void initState() {
    recupFilm();
    super.initState();
  }

  Future<void> recupFilm() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      film = convert.jsonDecode(response.body);
      setState(() {
        dataOK = !dataOK;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: dataOK ? visualizacion() : espera(),
      backgroundColor: Colors.blueGrey[900],
    );
  }

  Widget espera() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Esperando datos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget visualizacion() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueGrey[900]!, Colors.blueGrey[800]!],
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (film != null)
                Text(
                  '${film['Title']}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              else
                Text('Ningún dato', style: TextStyle(color: Colors.white)),
              SizedBox(height: 12.0),
              if (film != null)
                Text(
                  '${film['Year']}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                )
              else
                Text('Ningún dato', style: TextStyle(color: Colors.white)),
              SizedBox(height: 20.0),
              if (film != null)
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0.0, 7.0),
                        spreadRadius: 3.0,
                        blurRadius: 15.0,
                      ),
                    ],
                  ),
                  child: Image.network('${film['Poster']}'),
                )
              else
                Text('Ningún dato', style: TextStyle(color: Colors.white)),
              SizedBox(height: 20.0),
              if (film != null)
                Text(
                  '${film['Plot']}',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                )
              else
                Text('Ningún dato', style: TextStyle(color: Colors.white)),
              SizedBox(height: 20.0),
              if (film != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Detalle('Director', film['Director']),
                    Detalle('Actores', film['Actors']),
                    Detalle('Género', film['Genre']),
                    Detalle('Clasificación', film['Rated']),
                    Detalle('Duración', film['Runtime']),
                    Detalle('Idioma', film['Language']),
                    Detalle('País', film['Country']),
                    Detalle('Premios', film['Awards']),
                    Detalle('Puntuación IMDb', film['imdbRating']),
                  ],
                )
              else
                Text('Ningún dato', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget Detalle(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.0),
        Text(
          '$label:',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          value,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}