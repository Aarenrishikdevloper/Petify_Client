class Feedbackmodel {
  final String user;

  final String feedback;
  final DateTime time;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Feedbackmodel({
    required this.user,
    required this.feedback,
    required this.time,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  // From JSON
  factory Feedbackmodel.fromJson(Map<String, dynamic> json) {
    return Feedbackmodel(
      user: json['user'] as String,
      feedback: json['feedback'] as String,
      time: json['time'] != null
          ? DateTime.parse(json['time'] as String)
          : DateTime.now(),
      id: json['_id'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'user': user.trim(),
      'feedback': feedback,
      'time': time.toIso8601String(),
      if (id != null) '_id': id,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }
  static List<Feedbackmodel> fromJsonList(List<Map<String, dynamic>> jsonlist){
    return jsonlist.map((json)=>Feedbackmodel.fromJson(json)).toList();
  }
}