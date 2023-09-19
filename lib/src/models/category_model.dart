//TODO: crate a model for category to use in firebase

class CategoryModel {
  final String uid;
  final String categoryName;
  final String description;

  CategoryModel({
    required this.uid,
    required this.categoryName,
    required this.description,
  });

  Map<String, dynamic> categoryModel() {
    return {
      'id': uid,
      'categoryName': categoryName,
      'email': description,
    };
  }
}
