class Categorys {
  final String name;
  final String image;
  final int id;
  final String free;

  Categorys({
    required this.name,
    required this.image,
    required this.id,
    this.free = "No",
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'id': id,
      'free': free,
    };
  }
}
