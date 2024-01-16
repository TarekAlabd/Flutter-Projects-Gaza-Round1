class FoodItem {
  final String id;
  final String name;
  final String imgUrl;
  final double price;
  final String estimatedTime;
  final int numberOfSales;
  final String category;
  final bool isFavorite;

  FoodItem({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.price,
    required this.category,
    this.estimatedTime = '30 Mins',
    this.numberOfSales = 2,
    this.isFavorite = false,
  });

  FoodItem copyWith({bool? isFavorite}) {
    return FoodItem(
      id: id,
      name: name,
      imgUrl: imgUrl,
      price: price,
      category: category,
      estimatedTime: estimatedTime,
      numberOfSales: numberOfSales,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

List<FoodItem> food = [
  FoodItem(
      id: '1',
      category: 'Burger',
      name: 'Beef Burger',
      imgUrl:
          'https://static.vecteezy.com/system/resources/thumbnails/022/911/694/small/cute-cartoon-burger-icon-free-png.png',
      price: 6.99),
  FoodItem(
      id: '2',
      category: 'Burger',
      name: 'Chicken Burger',
      imgUrl: 'https://assets.stickpng.com/images/58824b33e81acb96424ffab9.png',
      price: 5.99),
  FoodItem(
      id: '3',
      category: 'Burger',
      name: 'Cheese Burger',
      imgUrl:
          'https://upload.wikimedia.org/wikipedia/commons/1/11/Cheeseburger.png',
      price: 7.99),
  FoodItem(
      id: '4',
      category: 'Pizza',
      name: 'Chicken Pizza',
      imgUrl:
          'https://www.pngkey.com/png/full/70-701336_california-chicken-pizza-butter-chicken-pizza-png.png',
      price: 9.99),
  FoodItem(
      id: '5',
      category: 'Pizza',
      name: 'Margreta Pizza',
      imgUrl:
          'https://upload.wikimedia.org/wikipedia/commons/e/ee/Eq_it-na_pizza-margherita_sep2005_sml-2.png',
      price: 8.99),
  FoodItem(
      id: '6',
      category: 'Pasta',
      name: 'Lazania',
      imgUrl:
          'https://www.pngkey.com/png/full/155-1551891_0-chicken-lasagna-pasta-png.png',
      price: 8.99),
  FoodItem(
      id: '7',
      category: 'Pasta',
      name: 'Koshary',
      imgUrl:
          'https://static.wixstatic.com/media/7f9493_a6e4ce2c09dc4b1e8f878029fc18fd13~mv2.png/v1/fill/w_440,h_438,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/7f9493_a6e4ce2c09dc4b1e8f878029fc18fd13~mv2.png',
      price: 6.99),
  FoodItem(
      id: '8',
      category: 'Chicken',
      name: 'Fried Chicken',
      imgUrl:
          'https://www.freepnglogos.com/uploads/fried-chicken-png/crispy-fried-chicken-png-0.png',
      price: 7.99),
  FoodItem(
      id: '9',
      category: 'Chicken',
      name: 'Grilled Chicken',
      imgUrl:
          'https://static.vecteezy.com/system/resources/previews/021/665/568/original/delicious-grilled-chicken-cutout-png.png',
      price: 9.99),
];
