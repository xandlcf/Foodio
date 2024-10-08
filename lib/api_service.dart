import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiKey = ''; // Insert API key here
  static const String baseUrl = 'https://api.spoonacular.com';

  // Method to fetch recipes based on a search query
  Future<List<dynamic>> fetchRecipes(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/recipes/complexSearch?query=$query&apiKey=$apiKey'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  // Method to fetch details of a specific recipe by its ID
  Future<dynamic> fetchRecipeDetails(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/recipes/$id/information?apiKey=$apiKey'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load recipe details');
    }
  }
}
