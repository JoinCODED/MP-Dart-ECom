1. Start by creating the needed models:

```dart
class Product {
  final int id;
  final String name;
  final double price;

  const Product({required this.id, required this.name, required this.price});
}
```

```dart
class Item {
  final Product product;
  int quantity;

  Item({required this.product, this.quantity = 1});
}
```

2. Add a getter to the Item class that returns the total price of the item:

```dart
double get totalPrice => product.price * quantity;
```

3. Create a Cart class that has a list of items:

```dart
class Cart {
  List<Item> items = [];
}
```

4. Create a getter to the Cart class that returns the total price of all items in the cart:

```dart
double get total => items.fold(0, (total, item) => total + item.total);
```

5. Create some dummy products:

```dart
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
```

6. In the main function, create a cart:

```dart
void main() {
  final cart = Cart();
}
```

7. Create an infinite loop that prompts the user to choose an option:

```dart
  while (true) {
    stdout.write("What do you want to do? (Cart, Add, Checkout)");
    final line = stdin.readLineSync();
    if (line == "Cart") {
        // Show the cart
    } else if (line == "Add") {
        // Add a product to the cart
    } else if (line == "Checkout") {
       // Checkout
    } else {
      print("Unknown command");
    }
  }
```

8. Create a function to choose a product from the list of products:

```dart
Product chooseProduct() {
  print("Products:");
  for (var i = 0; i < allProducts.length; i++) {
    final product = allProducts[i];
    print("${i + 1}. ${product.name} - ${product.price}");
  }
}
```

9. Prompt the user to choose a product based on the index:

```dart
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
```

10. Back to our loop, create a variable to store the product:

```dart
  final product = chooseProduct();
  if (product != null) {
    print("Added ${product.name} to cart");
  }
```

11. In the cart class, create a function to add an item to the cart:

```dart
  void addProduct(Product product) {
    final item = Item(product: product);
    final isInList = items.any((item) => item.product == product);
    if (isInList) {
      items.firstWhere((item) => item.product == product).quantity++;
    } else {
      items.add(item);
    }
  }
```

12. Call the addProduct function to add the product to the cart:

```dart
  else if (line == "Add") {
      final product = chooseProduct();
      if (product != null) cart.addProduct(product);
```

13. To view the cart, we need to override the toString method:

```dart
  @override
  String toString() {
    if (items.isEmpty) return "Cart is empty";
    return items
            .map((item) => "${item.product.name} x ${item.quantity}")
            .join("\n") +
        " - Total: ${total.toStringAsFixed(2)}";
  }
```

14. Call this function to view the cart:

```dart
  else if (line == "Cart") {
    print(cart);
  }
```

15. Create a function to checkout:

```dart
  bool checkout(Cart cart) {
  stdout.write("How much do you want to pay?: ");
  final line = stdin.readLineSync();
  if (line == null) {
    print("Please enter a number");
    return false;
  }
  final amount = double.parse(line);
  if (amount < cart.totalPrice()) {
    print("Not enough money");
    return false;
  }
  print("Thanks for shopping!");
  return true;
}
```

16. Call this function to checkout:

```dart
  else if (line == "Checkout") {
    if (cart.checkout(cart)) {
      break;
    }
  }
```

17. Complete code:

```dart
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
```
