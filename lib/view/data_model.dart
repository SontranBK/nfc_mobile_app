import 'package:hive/hive.dart';

 part 'data_model.g.dart';

@HiveType(typeId: 0)
class DataModel{
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? description;
  @HiveField(2)
  final bool? complete;

  DataModel({this.title, this.description, this.complete});

}