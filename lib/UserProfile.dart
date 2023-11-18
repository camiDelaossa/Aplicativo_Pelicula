import 'package:flutter/material.dart';

class UserProfile {
  String username;
  String email;
  String name;
  String occupation;
  String profilePicture;
  String description;
  List<String> preferences;

  UserProfile({
    required this.username,
    required this.email,
    required this.name,
    required this.occupation,
    required this.profilePicture,
    required this.description,
    required this.preferences,
  });
}

class UserProfilePage extends StatelessWidget {
  final UserProfile userProfile;

  UserProfilePage({required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(userProfile.profilePicture),
              ),
              SizedBox(height: 16.0),
              Text('Nombre: ${userProfile.name}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text('Ocupación: ${userProfile.occupation}', style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 8.0),
              Text('Username: ${userProfile.username}', style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 8.0),
              Text('Email: ${userProfile.email}', style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 16.0),
              Text('Descripción:', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text('${userProfile.description}', style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 16.0),
              Text('Preferencias:', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: userProfile.preferences
                    .map((preference) => Text('- $preference', style: TextStyle(fontSize: 16.0)))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}