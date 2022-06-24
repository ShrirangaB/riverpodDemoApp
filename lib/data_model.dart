import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 1)
class Data {
  @HiveField(0)
  String? color;

  @HiveField(1)
  int? size;

  Data({required this.color, required this.size});
}
