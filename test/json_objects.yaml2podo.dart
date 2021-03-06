// Generated by 'yaml2podo'
// Version: 0.1.31
// https://pub.dev/packages/yaml2podo
// ignore_for_file: unused_element
// @dart = 2.12

class Alias {
  final String? clazz;

  Alias({this.clazz});

  factory Alias.fromJson(Map json) {
    return Alias(
      clazz: json['class'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'class': clazz,
    };
  }
}

class Bar {
  final int? i;

  Bar({this.i});

  factory Bar.fromJson(Map json) {
    return Bar(
      i: json['i'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'i': i,
    };
  }
}

class Foo {
  final Map<String?, Bar?>? bars;

  Foo({this.bars});

  factory Foo.fromJson(Map json) {
    return Foo(
      bars: _toObjectMap(json['bars'], (e) => Bar.fromJson(e)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bars': _fromMap(bars, (Bar? e) => e?.toJson()),
    };
  }
}

class ObjectWithObjects {
  final List<Object?>? list;
  final Map<String?, Object?>? map;

  ObjectWithObjects({this.list, this.map});

  factory ObjectWithObjects.fromJson(Map json) {
    return ObjectWithObjects(
      list: _toList(json['list'], (e) => e),
      map: _toMap(json['map'], (e) => e),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'list': _fromList(list, (Object? e) => e),
      'map': _fromMap(map, (Object? e) => e),
    };
  }
}

class Order {
  final double? amount;
  final DateTime? date;
  final bool? isShipped;
  final List<OrderItem?>? items;

  Order({this.amount, this.date, this.isShipped, this.items});

  factory Order.fromJson(Map json) {
    return Order(
      amount: _toDouble(json['amount']),
      date: _toDateTime(json['date']),
      isShipped: json['is_shipped'] as bool?,
      items: _toObjectList(json['items'], (e) => OrderItem.fromJson(e)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'date': _fromDateTime(date),
      'is_shipped': isShipped,
      'items': _fromList(items, (OrderItem? e) => e?.toJson()),
    };
  }
}

class OrderItem {
  final num? price;
  final Product? product;
  final int? quantity;

  OrderItem({this.price, this.product, this.quantity});

  factory OrderItem.fromJson(Map json) {
    return OrderItem(
      price: json['price'] as num?,
      product: _toObject(json['product'], (e) => Product.fromJson(e)),
      quantity: json['quantity'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'product': product?.toJson(),
      'quantity': quantity,
    };
  }
}

class Product {
  final int? id;
  final String? name;

  Product({this.id, this.name});

  factory Product.fromJson(Map json) {
    return Product(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Super {
  final bool? boolean;
  final DateTime? date;
  final double? float;
  final Foo? foo;
  final Foo? foo2;
  final int? integer;
  final List<Map<String?, Bar?>?>? list;
  final Map<int?, List<Bar?>?>? map;
  final Map<String?, List<int?>?>? map2;
  final String? string;

  Super(
      {this.boolean,
      this.date,
      this.float,
      this.foo,
      this.foo2,
      this.integer,
      this.list,
      this.map,
      this.map2,
      this.string});

  factory Super.fromJson(Map json) {
    return Super(
      boolean: json['boolean'] as bool?,
      date: _toDateTime(json['date']),
      float: _toDouble(json['float']),
      foo: _toObject(json['foo'], (e) => Foo.fromJson(e)),
      foo2: _toObject(json['foo2'], (e) => Foo.fromJson(e)),
      integer: json['integer'] as int?,
      list:
          _toList(json['list'], (e) => _toObjectMap(e, (e) => Bar.fromJson(e))),
      map: _toMap(json['map'], (e) => _toObjectList(e, (e) => Bar.fromJson(e))),
      map2: _toMap(json['map2'], (e) => _toList(e, (e) => e as int?)),
      string: json['string'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'boolean': boolean,
      'date': _fromDateTime(date),
      'float': float,
      'foo': foo?.toJson(),
      'foo2': foo2?.toJson(),
      'integer': integer,
      'list': _fromList(list,
          (Map<String?, Bar?>? e) => _fromMap(e, (Bar? e) => e?.toJson())),
      'map': _fromMap(
          map, (List<Bar?>? e) => _fromList(e, (Bar? e) => e?.toJson())),
      'map2': _fromMap(map2, (List<int?>? e) => _fromList(e, (int? e) => e)),
      'string': string,
    };
  }
}

T _checkType<T>(value) {
  if (value is T) {
    return value;
  }
  throw StateError(
      'Value of type ${value.runtimeType} is not a subtype of \'${T}\'');
}

String? _fromDateTime(data) {
  if (data == null) {
    return null;
  }
  if (data is DateTime) {
    return data.toIso8601String();
  }
  return _checkType<String>(data);
}

String? _fromEnum<T>(T? value) {
  if (value == null) {
    return null;
  }
  final str = '\$value';
  final offset = str.indexOf('.');
  if (offset == -1) {
    throw ArgumentError('The value is not an enum: \$value');
  }
  return str.substring(offset + 1);
}

List<O?>? _fromList<I, O>(List<I?>? data, O Function(I) toJson) {
  if (data == null) {
    return null;
  }
  final result = <O?>[];
  for (final element in data) {
    O? value;
    if (element != null) {
      value = toJson(element);
    }
    result.add(value);
  }
  return result;
}

Map<K?, O?>? _fromMap<K, I, O>(Map<K?, I?>? data, O Function(I) toJson) {
  if (data == null) {
    return null;
  }
  final result = <K?, O?>{};
  for (final key in data.keys) {
    O? value;
    final element = data[key];
    if (element != null) {
      value = toJson(element);
    }
    result[key] = value;
  }
  return result;
}

DateTime? _toDateTime(data) {
  if (data == null) {
    return null;
  }
  if (data is String) {
    return DateTime.parse(data);
  }
  return _checkType<DateTime>(data);
}

double? _toDouble(data) {
  if (data == null) {
    return null;
  }
  if (data is int) {
    return data.toDouble();
  }
  return _checkType<double>(data);
}

T? _toEnum<T>(String? name, Iterable<T> values) {
  if (name == null) {
    return null;
  }
  final offset = '\$T.'.length;
  for (final value in values) {
    final key = '\$value'.substring(offset);
    if (name == key) {
      return value;
    }
  }

  throw ArgumentError(
      'The getter \'\$name\' isn\'t defined for the class \'\$T\'');
}

List<T?>? _toList<T>(data, T? Function(dynamic) fromJson) {
  if (data == null) {
    return null;
  }
  final result = <T?>[];
  final sequence = _checkType<List>(data);
  for (final element in sequence) {
    T? value;
    if (element != null) {
      value = fromJson(element);
    }
    result.add(value);
  }
  return result;
}

Map<K?, V?>? _toMap<K, V>(data, V? Function(dynamic) fromJson) {
  if (data == null) {
    return null;
  }
  final result = <K?, V?>{};
  final map = _checkType<Map<K?, dynamic>>(data);
  for (final key in map.keys) {
    V? value;
    final element = map[key];
    if (element != null) {
      value = fromJson(element);
    }
    result[key] = value;
  }
  return result;
}

T? _toObject<T>(data, T Function(Map) fromJson) {
  if (data == null) {
    return null;
  }
  final json = _checkType<Map>(data);
  return fromJson(json);
}

List<T?>? _toObjectList<T>(data, T Function(Map) fromJson) {
  if (data == null) {
    return null;
  }
  final result = <T?>[];
  final sequence = _checkType<Iterable>(data);
  for (final element in sequence) {
    T? value;
    if (element != null) {
      final json = _checkType<Map>(element);
      value = fromJson(json);
    }
    result.add(value);
  }
  return result;
}

Map<K?, V?>? _toObjectMap<K, V>(data, V Function(Map) fromJson) {
  if (data == null) {
    return null;
  }
  final result = <K?, V?>{};
  final map = _checkType<Map<K?, dynamic>>(data);
  for (final key in map.keys) {
    V? value;
    final element = map[key];
    if (element != null) {
      final json = _checkType<Map>(element);
      value = fromJson(json);
    }
    result[key] = value;
  }
  return result;
}

/*
Alias:
  clazz.class: String

Bar:
  i: int

Foo:
  bars: Map<String, Bar>

Order:
  amount: double
  date: DateTime
  items: List<OrderItem>
  is_shipped: bool

OrderItem:
  product: Product
  quantity: int
  price: num

Product:
  id: int
  name: String

ObjectWithObjects:
  list: List<Object>
  map: Map<String, Object>

Super:
  boolean: bool
  date: DateTime 
  float: double
  foo: Foo
  foo2: Foo
  integer: int
  string: String
  list: List<Map<String, Bar>>
  map: Map<int, List<Bar>>
  map2: Map<String, List<int>>
*/
