import 'dart:convert';

import 'package:floor/floor.dart';

class ListStringConverter extends TypeConverter<List<String>, String>  {
  @override
  List<String> decode( String databaseValue ) => (jsonDecode(databaseValue) as List<dynamic>).map((e) => e as String).toList();

  @override
  String encode( List<String> value ) => jsonEncode(value);
  
}