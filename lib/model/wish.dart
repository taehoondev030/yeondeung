class Hope {
  int? id;
  String? message;
  String? date;

  Hope({this.id, this.message, this.date});

  // 장고 wish 모델의 message 필드값을 추가
  Map<String, dynamic> toJson() =>
      {'message': message};

  factory Hope.fromJson(Map<String, dynamic> json) {
    return Hope(
        id: json['id'],
        message: json['message'],
        date: json['created_at']
    );
  }
}