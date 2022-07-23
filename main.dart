import 'dart:io';

const allProducts = [
  Product(
    id: 1,
    name: 'Iphone X',
    price: 750,
  ),
  Product(
    id: 2,
    name: 'Iphone XS',
    price: 850,
  ),
  Product(
    id: 3,
    name: 'Iphone XS Max',
    price: 950,
  ),
  Product(
    id: 4,
    name: 'Iphone XR',
    price: 950,
  ),
  Product(
    id: 5,
    name: 'Macbook Pro 13"',
    price: 1300,
  ),
  Product(
    id: 6,
    name: 'Macbook Pro 16"',
    price: 1500,
  ),
  Product(
    id: 7,
    name: 'Macbook Air',
    price: 999,
  ),
];
void main() {
  final cart = Cart();
  while (true) {
    stdout.write("What do you want to do? (Cart, Add, Checkout)");
    final line = stdin.readLineSync();
    if (line == "Cart") {
      print(cart);
    } else if (line == "Add") {
      final product = chooseProduct();
      if (product != null) cart.addProduct(product);
    } else if (line == "Checkout") {
      if (checkout(cart)) {
        break;
      }
      ;
    } else {
      print("Unknown command");
    }
  }
}

class Product {
  final int id;
  final String name;
  final double price;

  const Product({required this.id, required this.name, required this.price});
}

class Item {
  final Product product;
  int quantity;

  Item({required this.product, this.quantity = 1});
  double get total => product.price * quantity;
}

class Cart {
  final List<Item> items = [];
  void addProduct(Product product) {
    final item = Item(product: product);
    final isInList = items.any((item) => item.product == product);
    if (isInList) {
      items.firstWhere((item) => item.product == product).quantity++;
    } else {
      items.add(item);
    }
  }

  @override
  String toString() {
    if (items.isEmpty) return "Cart is empty";
    return items
            .map((item) => "${item.product.name} x ${item.quantity}")
            .join("\n") +
        " - Total: ${totalPrice.toStringAsFixed(2)}";
  }

  double get totalPrice {
    return items.fold(0, (total, item) => total + item.total);
  }
}

Product? chooseProduct() {
  print("Products:");
  for (var i = 0; i < allProducts.length; i++) {
    final product = allProducts[i];
    print("${i + 1}. ${product.name} - ${product.price}");
  }
  final line = stdin.readLineSync();
  if (line == "0") {
    return null;
  }
  final index = int.parse(line!) - 1;
  if (index < 0 || index >= allProducts.length) {
    print("Invalid product");
    return null;
  }
  return allProducts[index];
}

bool checkout(Cart cart) {
  stdout.write("How much do you want to pay?: ");
  final line = stdin.readLineSync();
  if (line == null) {
    print("Please enter a number");
    return false;
  }
  final amount = double.parse(line);
  if (amount < cart.totalPrice) {
    print("Not enough money");
    return false;
  }
  print("Thanks for shopping!");
  return true;
}
