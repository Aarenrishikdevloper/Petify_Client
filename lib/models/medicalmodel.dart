import 'dart:convert';

class MedicalRecord {
  final String id;
  final String petName;
  final String petId;
  final String owner;
  final DateTime date;
  final String medication;
  final String notes;
  final String status;
  final bool isNotified;
  final bool isNewMedical;

  MedicalRecord({
    required this.id,
    required this.petName,
    required this.owner,
    required this.date,
    required this.medication,
    required this.notes,
    required this.status,
    required this.isNotified,
    required this.isNewMedical,
    required this.petId
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    final pet = json['pet'] ?? {};

    return MedicalRecord(
      id: json['_id'],
      petName: pet['name'] ?? '',
      owner: pet['owner'] ?? '',
      date: DateTime.parse(json['date']),
      medication: json['medication'] ?? '',
      notes: json['notes'] ?? '',
      status: json['status'] ?? '',
      isNotified: json['isNotified'] ?? false,
      isNewMedical: json['isNewMedical'] ?? false,
      petId: pet['_id'] ?? "",
    );
  }
  static List<MedicalRecord>fromJsonList(List<Map<String, dynamic>> jsonList){
    return jsonList.map((json)=>MedicalRecord.fromJson(json)).toList();
  }
}
