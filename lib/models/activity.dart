import 'package:flutter/material.dart';

class Activity {
  final String id;
  final String title;
  final String description;
  final String category;
  final String? targetAudience;
  final String date;
  final String time;
  final String location;
  final String street;
  final int? number;
  final String neighborhood;
  final String city;
  final String cep;
  final int? vacancies;
  final double? fee;
  final List<String>? accessibilityResources;
  final String? accessibilityDescription;
  final String? documentUrl;
  final String userId;
  final String status;

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
    required this.status,
    this.targetAudience,
    this.number,
    this.vacancies,
    this.fee,
    this.accessibilityResources,
    this.accessibilityDescription,
    this.documentUrl,
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
    int? number,
    String? neighborhood,
    String? city,
    String? cep,
    String? targetAudience,
    int? vacancies,
    double? fee,
    List<String>? accessibilityResources,
    String? accessibilityDescription,
    String? documentUrl,
    String? userId,
    String? status,
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
      vacancies: vacancies ?? this.vacancies,
      fee: fee ?? this.fee,
      accessibilityResources:
          accessibilityResources ?? this.accessibilityResources,
      accessibilityDescription:
          accessibilityDescription ?? this.accessibilityDescription,
      documentUrl: documentUrl ?? this.documentUrl,
      userId: userId ?? this.userId,
      status: status ?? this.status,
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
      number: map['number'],
      neighborhood: map['neighborhood'] ?? '',
      city: map['city'] ?? '',
      cep: map['cep'] ?? '',
      targetAudience: map['targetAudience'],
      vacancies: map['vacancies'],
      fee: map['fee'] != null ? (map['fee'] as num).toDouble() : null,
      accessibilityResources: map['accessibilityResources'] != null
          ? List<String>.from(map['accessibilityResources'])
          : null,
      accessibilityDescription: map['accessibilityDescription'],
      documentUrl: map['documentUrl'],
      userId: map['userId'] ?? "",
      status: map['status'] ?? "",
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
      'vacancies': vacancies,
      'fee': fee,
      'accessibilityResources': accessibilityResources,
      'accessibilityDescription': accessibilityDescription,
      'documentUrl': documentUrl,
      'userId': userId,
      'status': status,
    };
  }
}
