// lib/data_model.dart
class PathData {
  final String id;
  final Map<String, dynamic> start;
  final Map<String, dynamic> end;
  final List<List<dynamic>> field;

  PathData({
    required this.id,
    required this.start,
    required this.end,
    required this.field,
  });

  factory PathData.fromJson(Map<String, dynamic> json) {
    return PathData(
      id: json['id'],
      start: json['start'],
      end: json['end'],
      field: (json['field'] as List<dynamic>).map((e) => (e as List<dynamic>).toList()).toList(),
    );
  }
}
