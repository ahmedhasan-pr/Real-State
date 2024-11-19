import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/Provider/FavoriteProvider.dart'; // Adjust path as needed

class Favoritespage extends StatefulWidget {
  const Favoritespage({super.key});

  @override
  State<Favoritespage> createState() => _FavoritespageState();
}

class _FavoritespageState extends State<Favoritespage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
            alignment: Alignment.topRight,
            child: Text(
              "المفضلة",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25, // Font size
              ),
            )),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, favoriteProvider, child) {
          final favorites = favoriteProvider.favorite;
          if (favorites.isEmpty) {
            return const Center(child: Text("لا توجد عناصر مفضلة"));
          }
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final detail = favorites[index];
              return ListTile(
                title: Text(detail.location), // Adjust based on your model
                subtitle:
                    Text("\$${detail.price}"), // Adjust based on your model
                trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      final favoriteProvider =
                          Provider.of<FavoriteProvider>(context, listen: false);

                      // Remove the item from favorites
                      favoriteProvider.toggleFavorite(detail);

                      // Show a Snackbar message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تمت إزالة من المفضلة'),
                        ),
                      );

                      // Optionally, you might want to update the local state here
                    }),

                onTap: () {
                  // Navigate to the details page or perform another action
                },
              );
            },
          );
        },
      ),
    );
  }
}
