class Recipe {
  final int id;
  final String title;
  final String image;

  // Constructor to initialize the recipe object
  Recipe({required this.id, required this.title, required this.image});

  // Factory constructor to create a recipe object from JSON
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      image: json['image'],
    );
  }
}
