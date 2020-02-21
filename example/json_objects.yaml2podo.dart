// Generated by 'yaml2podo'
// Version: 0.1.23
// https://pub.dev/packages/yaml2podo

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

T _toObject<T>(data, T Function(Map<String, dynamic>) fromJson) {
  if (data == null) {
    return null;
  }
  return fromJson(data as Map<String, dynamic>);
}

List<T> _toObjectList<T>(data, T Function(Map<String, dynamic>) fromJson) {
  if (data == null) {
    return null;
  }
  var result = <T>[];
  for (var element in data) {
    T value;
    if (element != null) {
      value = fromJson(element as Map<String, dynamic>);
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
