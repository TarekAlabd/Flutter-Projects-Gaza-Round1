class CategoryItem {
  final String id;
  final String name;
  final String assetPath;

  CategoryItem({
    required this.id,
    required this.name,
    required this.assetPath,
  });
}

List<CategoryItem> categories = [
  CategoryItem(id: '1', name: 'Burger', assetPath: 'assets/images/burger.png'),
  CategoryItem(id: '2', name: 'Pizza', assetPath: 'assets/images/pizza.png'),
  CategoryItem(id: '3', name: 'Pasta', assetPath: 'assets/images/pasta.png'),
  CategoryItem(id: '4', name: 'Chicken', assetPath: 'assets/images/chicken.png'),
  CategoryItem(id: '5', name: 'Drinks', assetPath: 'assets/images/drink.png'),
  CategoryItem(id: '6', name: 'Beef', assetPath: 'assets/images/meat.png'),
];
