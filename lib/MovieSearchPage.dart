import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieSearchPage extends StatefulWidget {
  @override
  _MovieSearchPageState createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Películas'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.blueGrey[900], // Color de fondo oscuro
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Nombre de la Película',
                labelStyle: TextStyle(color: Colors.white),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    searchMovies(_searchController.text);
                  },
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final movie = searchResults[index];
                  return Card(
                    color: Colors.blueGrey[800],
                    elevation: 5.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(
                        movie['Title'],
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        movie['Year'],
                        style: TextStyle(color: Colors.white),
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          movie['Poster'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailPage(imdbID: movie['imdbID']),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> searchMovies(String searchTerm) async {
    final apiKey = 'apiKey';
    final url = Uri.parse('http://www.omdbapi.com/?s=$searchTerm&page=1&apikey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['Response'] == 'True') {
        setState(() {
          searchResults = List<Map<String, dynamic>>.from(data['Search']);
        });
      } else {
        setState(() {
          searchResults = [];
        });
      }
    } else {
      setState(() {
        searchResults = [];
      });
    }
  }
}

class MovieDetailPage extends StatelessWidget {
  final String imdbID;

  MovieDetailPage({required this.imdbID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Película'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: FutureBuilder(
        future: fetchMovieDetails(imdbID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar los detalles de la película.'));
          } else {
            final movieDetails = snapshot.data as Map<String, dynamic>;
            return Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[800],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    movieDetails['Title'],
                    style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    movieDetails['Year'],
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
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
                      child: Image.network(
                        movieDetails['Poster'],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        movieDetails['Plot'],
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // Agrega más detalles según sea necesario
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

Future<Map<String, dynamic>> fetchMovieDetails(String imdbID) async {
  final apiKey = 'apiKey';
  final url = Uri.parse('http://www.omdbapi.com/?i=$imdbID&apikey=$apiKey');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Error al cargar los detalles de la película');
  }
}