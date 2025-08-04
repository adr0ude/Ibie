class SummaryActivity {
  final String id;
  final String title;
  final String image;
  final String userId;
  final String userName;
  final String status;

  const SummaryActivity({
    required this.id,
    required this.title,
    required this.userId,
    required this.userName,
    required this.status,
    required this.image,
  });

  SummaryActivity copyWith({
    String? id,
    String? title,
    String? image,
    String? userId,
    String? userName,
    String? status,
  }) {
    return SummaryActivity(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      status: status ?? this.status,
    );
  }

  factory SummaryActivity.fromMap(Map<String, dynamic> map, String id) {
    return SummaryActivity(
      id: id,
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      status: map['status'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'userId': userId,
      'userName': userName,
      'status': status,
    };
  }
}