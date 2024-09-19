import 'package:flutter/material.dart';
import 'api_service.dart';
import 'database_helper.dart';

class RecipeDetailScreen extends StatelessWidget {
  final int recipeId;

  RecipeDetailScreen({required this.recipeId});

  final ApiService apiService = ApiService();
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Details'),
      ),
      body: FutureBuilder(
        future: apiService.fetchRecipeDetails(recipeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading recipe details'));
          } else {
            final recipe = snapshot.data;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(recipe['title'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Image.network(recipe['image']),
                    SizedBox(height: 16),
                    Text('Ingredients:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(recipe['extendedIngredients'].map((ingredient) => ingredient['original']).join('\n')),
                    SizedBox(height: 16),
                    Text('Instructions:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(recipe['instructions']),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        databaseHelper.insertFavorite({
                          'id': recipe['id'],
                          'title': recipe['title'],
                          'image': recipe['image'],
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Recipe saved as favorite')),
                        );
                      },
                      child: Text('Save as Favorite'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
