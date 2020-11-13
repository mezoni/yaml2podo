# yaml2podo

The `yaml2podo` is a generator and utility (all in one) that generates PODO classes to convert between JSON and Dart objects

Version 0.1.28

### Example of use.

Declarations (simple enough and informative).

[example/json_objects.yaml2podo.yaml](https://github.com/mezoni/yaml2podo/blob/master/example/json_objects.yaml2podo.yaml)

```yaml
Order:  
  date: DateTime
  items: List<OrderItem>
  amount: double
OrderItem:
  product: Product
  quantity.qty: int
  price: double  
Product:
  name: String
  id: int
```

Run utility.

<pre>
pub global run yaml2podo example/json_objects.yaml2podo.yaml
</pre>

Generated code does not contain dependencies and does not import anything.
The same source code that you would write with your hands. Or at least very close to such a code.

[example/json_objects.yaml2podo.dart](https://github.com/mezoni/yaml2podo/blob/master/example/json_objects.yaml2podo.dart)

```dart
// Generated by 'yaml2podo'
// Version: 0.1.28
// https://pub.dev/packages/yaml2podo
// @dart=2.3

class Order {
  final double amount;
  final DateTime date;
  final List<OrderItem> items;

  Order({this.amount, this.date, this.items});

  factory Order.fromJson(Map json) {
    return Order(
      amount: _toDouble(json['amount']),
      date: _toDateTime(json['date']),
      items: _toObjectList(json['items'], (e) => OrderItem.fromJson(e)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'date': _fromDateTime(date),
      'items': _fromList(items, (e) => e.toJson()),
    };
  }
}

class OrderItem {
  final double price;
  final Product product;
  final int quantity;

  OrderItem({this.price, this.product, this.quantity});

  factory OrderItem.fromJson(Map json) {
    return OrderItem(
      price: _toDouble(json['price']),
      product: _toObject(json['product'], (e) => Product.fromJson(e)),
      quantity: json['qty'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'product': product?.toJson(),
      'qty': quantity,
    };
  }
}

class Product {
  final int id;
  final String name;

  Product({this.id, this.name});

  factory Product.fromJson(Map json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

String _fromDateTime(data) {
  if (data == null) {
    return null;
  }
  if (data is DateTime) {
    return data.toIso8601String();
  }
  return data as String;
}

List _fromList(data, Function(dynamic) toJson) {
  if (data == null) {
    return null;
  }
  final result = [];
  for (final element in data) {
    var value;
    if (element != null) {
      value = toJson(element);
    }
    result.add(value);
  }
  return result;
}

DateTime _toDateTime(data) {
  if (data == null) {
    return null;
  }
  if (data is String) {
    return DateTime.parse(data);
  }
  return data as DateTime;
}

double _toDouble(data) {
  if (data == null) {
    return null;
  }
  if (data is int) {
    return data.toDouble();
  }
  return data as double;
}

T _toObject<T>(data, T Function(Map) fromJson) {
  if (data == null) {
    return null;
  }
  return fromJson(data as Map);
}

List<T> _toObjectList<T>(data, T Function(Map) fromJson) {
  if (data == null) {
    return null;
  }
  final result = <T>[];
  for (final element in data) {
    T value;
    if (element != null) {
      value = fromJson(element as Map);
    }
    result.add(value);
  }
  return result;
}

/*
Order:  
  date: DateTime
  items: List<OrderItem>
  amount: double
OrderItem:
  product: Product
  quantity.qty: int
  price: double  
Product:
  name: String
  id: int
*/

```

And, of course, an example of using code.

[example/example.dart](https://github.com/mezoni/yaml2podo/blob/master/example/example.dart)

```dart
import 'json_objects.yaml2podo.dart';

void main() {
  var products = _getProducts();
  var items = _creataOrderItems(products);
  var order = Order(
      amount: _calculateAmount(items),
      date: DateTime(2019, 05, 31),
      items: items);
  var object = order.toJson();
  print(object);
  order = Order.fromJson(object);
  object = order.toJson();
  print(object);
}

List<OrderItem> _creataOrderItems(List<Product> products) {
  var result = <OrderItem>[];
  for (var i = 0; i < products.length; i++) {
    var product = products[i];
    var orderItem =
        OrderItem(price: 10.0 + i, product: product, quantity: i + 1);
    result.add(orderItem);
  }

  return result;
}

double _calculateAmount(List<OrderItem> items) {
  var result = 0.0;
  for (var item in items) {
    result += item.quantity * item.price;
  }

  return result;
}

List<Product> _getProducts() {
  var result = <Product>[];
  for (var i = 0; i < 2; i++) {
    var product = Product(id: i, name: 'Product $i');
    result.add(product);
  }

  return result;
}

```

Result:

<pre>
{amount: 32.0, date: 2019-05-31T00:00:00.000, items: [{price: 10.0, product: {id: 0, name: Product 0}, qty: 1}, {price: 11.0, product: {id: 1, name: Product 1}, qty: 2}]}
{amount: 32.0, date: 2019-05-31T00:00:00.000, items: [{price: 10.0, product: {id: 0, name: Product 0}, qty: 1}, {price: 11.0, product: {id: 1, name: Product 1}, qty: 2}]}

</pre>

### How to install utility `yaml2podo`?

Run the following command in the terminal

<pre>
pub global activate yaml2podo
</pre>
