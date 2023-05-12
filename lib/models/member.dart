class Member{
  final int id;
  final String name;
  final int age;

  Member({
    required this.id, 
    required this.name,
    required this.age
    });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      name: json['name'],
      age: json['age'],
    );
}
Map<String, dynamic> toJson() => {
    'name': name,
    'age': age,
  };
}