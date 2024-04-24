import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false; // Inicializa como não favorito

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isFavorite
          ? Icons.favorite
          : Icons.favorite_border), // Alterna entre os ícones
      color: Colors.red,
      iconSize: 40,
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite; // Alterna o estado de isFavorite
        });
      },
      style: IconButton.styleFrom(
        foregroundColor: Colors.red,
        shape: CircleBorder(),
        padding: EdgeInsets.all(16),
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}
