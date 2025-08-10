class Activity {
  final String id;
  final String title;
  final String description;
  final String category;
  final String targetAudience;
  final String date;
  final String time;
  final String location;
  final String street;
  final String number;
  final String neighborhood;
  final String city;
  final String cep;
  final String remainingVacancies;
  final String vacancies;
  final String fee;
  final String accessibilityResources;
  final String accessibilityDescription;
  final String image;
  final String userId;
  final String? userName;
  final String status;
  final List<String> comments;

  const Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.time,
    required this.location,
    required this.street,
    required this.neighborhood,
    required this.city,
    required this.cep,
    required this.userId,
    this.userName,
    required this.status,
    required this.targetAudience,
    required this.number,
    required this.remainingVacancies,
    required this.vacancies,
    required this.fee,
    required this.accessibilityResources,
    required this.accessibilityDescription,
    required this.image,
    required this.comments,
  });

  Activity copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? date,
    String? time,
    String? location,
    String? street,
    String? number,
    String? neighborhood,
    String? city,
    String? cep,
    String? targetAudience,
    String? remainingVacancies,
    String? vacancies,
    String? fee,
    String? accessibilityResources,
    String? accessibilityDescription,
    String? image,
    String? userId,
    String? userName,
    String? status,
    List<String>? comments,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      date: date ?? this.date,
      time: time ?? this.time,
      location: location ?? this.location,
      street: street ?? this.street,
      number: number ?? this.number,
      neighborhood: neighborhood ?? this.neighborhood,
      city: city ?? this.city,
      cep: cep ?? this.cep,
      targetAudience: targetAudience ?? this.targetAudience,
      remainingVacancies: remainingVacancies ?? this.remainingVacancies,
      vacancies: vacancies ?? this.vacancies,
      fee: fee ?? this.fee,
      accessibilityResources: accessibilityResources ?? this.accessibilityResources,
      accessibilityDescription: accessibilityDescription ?? this.accessibilityDescription,
      image: image ?? this.image,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      status: status ?? this.status,
      comments: comments ?? this.comments,
    );
  }

  factory Activity.fromMap(Map<String, dynamic> map, String id) {
    return Activity(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      location: map['location'] ?? '',
      street: map['street'] ?? '',
      number: map['number'] ?? '',
      neighborhood: map['neighborhood'] ?? '',
      city: map['city'] ?? '',
      cep: map['cep'] ?? '',
      targetAudience: map['targetAudience'] ?? '',
      remainingVacancies: map['remainingVacancies'] ?? '',
      vacancies: map['vacancies'] ?? '',
      fee: map['fee'] ?? '',
      accessibilityResources: map['accessibilityDescription'] ?? '',
      accessibilityDescription: map['accessibilityDescription'] ?? '',
      image: map['image'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'],
      status: map['status'] ?? '',
      comments: List<String>.from(map['comments'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'date': date,
      'time': time,
      'location': location,
      'street': street,
      'number': number,
      'neighborhood': neighborhood,
      'city': city,
      'cep': cep,
      'targetAudience': targetAudience,
      'remainingVacancies': remainingVacancies,
      'vacancies': vacancies,
      'fee': fee,
      'accessibilityResources': accessibilityResources,
      'accessibilityDescription': accessibilityDescription,
      'image': image,
      'userId': userId,
      'userName': userName,
      'status': status,
    };
  }
}