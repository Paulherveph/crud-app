import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_to_do_list/screen/add_note_screen.dart';
import 'package:flutter_to_do_list/screen/login.dart';
import 'package:flutter_to_do_list/widgets/stream_note.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

bool show = true;

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      floatingActionButton: Stack(
        alignment: Alignment.bottomRight,
        children: [
          // Bouton de déconnexion
          FloatingActionButton(
            onPressed: () async {
              bool confirm = await _showLogoutConfirmation(context);
              if (confirm) {
                // Logique pour se déconnecter
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LogIN_Screen(() {}),
                ));
              }
            },
            backgroundColor: Colors.redAccent,
            child: Icon(Icons.logout, size: 30),
          ),
          // Bouton d'ajout
          SizedBox(height: 60), // espace pour le bouton d'ajout
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Add_creen(),
              ));
            },
            backgroundColor: const Color.fromARGB(255, 240, 105, 197),
            child: Icon(Icons.add, size: 30),
          ),
        ],
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            setState(() {
              show = notification.direction == ScrollDirection.forward;
            });
            return true;
          },
          child: ListView(
            children: [
              Stream_note(false),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Finished Tasks',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Stream_note(true),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _showLogoutConfirmation(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Déconnexion', style: TextStyle(color: Colors.black)),
            content: Text('Êtes-vous sûr de vouloir vous déconnecter ?', style: TextStyle(color: Colors.black)),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Annuler', style: TextStyle(color: Colors.blue)),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Se déconnecter', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false; // retourne false si le dialogue est annulé
  }
}