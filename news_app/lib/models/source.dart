class Source {
  final String id;
  final String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromMap(Map<String, dynamic> map) {
    return Source(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }
}