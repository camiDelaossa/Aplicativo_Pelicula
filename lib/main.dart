import 'package:aplicativo_pelicula/FavoriteMoviePage.dart';
import 'package:aplicativo_pelicula/MovieSearchPage.dart';
import 'package:aplicativo_pelicula/UserProfile.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyAppMovie(title: ""));

class MyAppMovie extends StatelessWidget {
  const MyAppMovie({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {

    UserProfile userProfile = UserProfile(
      username: 'Camila',
      email: 'tucamila@example.com',
      name: 'Camila Pérez',
      occupation: 'Desarrolladora de Software',
      profilePicture: 'https://example.com/camila_profile.jpg',
      description: '¡Hola! Soy Camila, una apasionada desarrolladora de software con experiencia en Flutter.',
      preferences: ['Flutter', 'Dart', 'Mobile Development', 'UI/UX Design'],
    );

    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey[500],  // Ajusta el color según tus preferencias
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.account_circle), text: 'Perfil'),
                Tab(icon: Icon(Icons.favorite), text: 'Pelicula Favorita'),
                Tab(icon: Icon(Icons.movie), text: 'Películas'),
              ],
            ),
            title: const Text('Aplicativo peliculitas'),
          ),
          body: TabBarView(
            children: [
              UserProfilePage(userProfile: userProfile),
              FavoriteMoviePage(title: ""),
              MovieSearchPage(),
            ],
          ),
        ),
      ),
    );
  }
}


