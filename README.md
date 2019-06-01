# yaml2podo

The `yaml2podo` is a generator and utility (all in one) that generates PODO classes from object prototypes specified in `yaml` format

Version 0.1.1

### Example of use.

Declarations (simple enough and informative).

[example/json_objects.yaml](https://github.com/mezoni/yaml2podo/blob/master/example/json_objects.yaml)

```yaml
Messages:
  messages : List<Iterable<String>>
ObjectWithMap:
  products: Map<String, Product>
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
pub global run yaml2podo example/json_objects.yaml
</pre>

Generated code does not contain dependencies and does not import anything.
The same source code that you would write with your hands. Or at least very close to such a code.

[example/json_objects.dart](https://github.com/mezoni/yaml2podo/blob/master/example/json_objects.dart)

```dart
// Generated by 'yaml2podo', https://pub.dev/packages/yaml2podo

final _jc = _JsonConverter();

class Messages {
  List<Iterable<String>> messages;

  Messages();

  factory Messages.fromJson(Map map) {
    var result = Messages();
    result.messages =
        _jc.toList(map['messages'], (e) => _jc.toList(e, (e) => e as String));
    return result;
  }

  Map<String, dynamic> toJson() {
    var result = <String, dynamic>{};
    result['messages'] =
        _jc.fromList(messages, (e) => _jc.fromList(e, (e) => e));
    return result;
  }
}

class ObjectWithMap {
  Map<String, Product> products;

  ObjectWithMap();

  factory ObjectWithMap.fromJson(Map map) {
    var result = ObjectWithMap();
    result.products =
        _jc.toMap(map['products'], (e) => Product.fromJson(e as Map));
    return result;
  }

  Map<String, dynamic> toJson() {
    var result = <String, dynamic>{};
    result['products'] = _jc.fromMap(products, (e) => e?.toJson());
    return result;
  }
}

class Order {
  double amount;
  DateTime date;
  List<OrderItem> items;

  Order();

  factory Order.fromJson(Map map) {
    var result = Order();
    result.amount = _jc.toDouble(map['amount']);
    result.date = _jc.toDateTime(map['date']);
    result.items =
        _jc.toList(map['items'], (e) => OrderItem.fromJson(e as Map));
    return result;
  }

  Map<String, dynamic> toJson() {
    var result = <String, dynamic>{};
    result['amount'] = amount;
    result['date'] = date?.toIso8601String();
    result['items'] = _jc.fromList(items, (e) => e?.toJson());
    return result;
  }
}

class OrderItem {
  int quantity;
  double price;
  Product product;

  OrderItem();

  factory OrderItem.fromJson(Map map) {
    var result = OrderItem();
    result.quantity = map['qty'] as int;
    result.price = _jc.toDouble(map['price']);
    result.product = Product.fromJson(map['product'] as Map);
    return result;
  }

  Map<String, dynamic> toJson() {
    var result = <String, dynamic>{};
    result['qty'] = quantity;
    result['price'] = price;
    result['product'] = product?.toJson();
    return result;
  }
}

class Product {
  String name;
  int id;

  Product();

  factory Product.fromJson(Map map) {
    var result = Product();
    result.name = map['name'] as String;
    result.id = map['id'] as int;
    return result;
  }

  Map<String, dynamic> toJson() {
    var result = <String, dynamic>{};
    result['name'] = name;
    result['id'] = id;
    return result;
  }
}

class _JsonConverter {
  List fromList(dynamic data, dynamic Function(dynamic) toJson) {
    if (data == null) {
      return null;
    }

    var result = [];
    for (var element in data) {
      var value;
      if (element != null) {
        value = toJson(element);
      }

      result.add(value);
    }

    return result;
  }

  Map<String, dynamic> fromMap(dynamic data, dynamic Function(dynamic) toJson) {
    if (data == null) {
      return null;
    }

    var result = <String, dynamic>{};
    for (var key in data.keys) {
      var value = data[key];
      if (value != null) {
        value = toJson(data[key]);
      }

      result[key.toString()] = value;
    }

    return result;
  }

  DateTime toDateTime(dynamic data) {
    if (data == null) {
      return null;
    }

    if (data is String) {
      return DateTime.parse(data);
    }

    return data as DateTime;
  }

  double toDouble(dynamic data) {
    if (data == null) {
      return null;
    }

    if (data is int) {
      return data.toDouble();
    }

    return data as double;
  }

  List<T> toList<T>(dynamic data, T Function(dynamic) fromJson) {
    if (data == null) {
      return null;
    }

    var result = <T>[];
    for (var element in data) {
      T value;
      if (element != null) {
        value = fromJson(element);
      }

      result.add(value);
    }

    return result;
  }

  Map<K, V> toMap<K extends String, V>(
      dynamic data, V Function(dynamic) fromJson) {
    if (data == null) {
      return null;
    }

    var result = <K, V>{};
    for (var key in data.keys) {
      V value;
      var element = data[key];
      if (element != null) {
        value = fromJson(element);
      }

      result[key.toString() as K] = value;
    }

    return result;
  }
}

```

And, of course, an example of using code.

[example/example.dart](https://github.com/mezoni/yaml2podo/blob/master/example/example.dart)

```dart
import 'json_objects.dart';

void main() {
  // Order
  var products = _getProducts();
  var order = _createOrder();
  _addItemsToOrder(order, products);
  var jsonOrder = order.toJson();
  print(jsonOrder);
  order = Order.fromJson(jsonOrder);
  // Messages
  var messages = Messages();
  messages.messages = [];
  messages.messages.add(['Hello', 'Goodbye']);
  messages.messages.add(['Yes', 'No']);
  var jsonMessages = messages.toJson();
  print(jsonMessages);
  // ObjectWithMap
  var objectWithMap = ObjectWithMap();
  objectWithMap.products = {};
  for (var product in products) {
    objectWithMap.products[product.name] = product;
  }

  var jsonObjectWithMap = objectWithMap.toJson();
  print(jsonObjectWithMap);
  objectWithMap = ObjectWithMap.fromJson(jsonObjectWithMap);
}

void _addItemsToOrder(Order order, List<Product> products) {
  for (var i = 0; i < products.length; i++) {
    var product = products[i];
    var orderItem = OrderItem();
    orderItem.product = product;
    orderItem.quantity = i + 1;
    orderItem.price = 10.0 + i;
    order.items.add(orderItem);
    order.amount += orderItem.quantity * orderItem.price;
  }
}

Order _createOrder() {
  var result = Order();
  result.amount = 0;
  result.date = DateTime.now();
  result.items = [];
  return result;
}

List<Product> _getProducts() {
  var result = <Product>[];
  for (var i = 0; i < 2; i++) {
    var product = Product();
    product.id = i;
    product.name = 'Product $i';
    result.add(product);
  }

  return result;
}

```