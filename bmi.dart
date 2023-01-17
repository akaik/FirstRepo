class Bmi {
  final double bmi;
  final String health;
  final String healthyBmiRange;

  Bmi({
    required this.bmi,
    required this.health,
    required this.healthyBmiRange,
  });

  //TODO implement Bmi.fromJson
  factory Bmi.fromJson(Map<String, dynamic> json) {
    //int healthyBmiRange = json['data']['healthyBmiRange'];
    return Bmi(
      bmi: json['data']['bmi'],
      healthyBmiRange: json['data']['healthy_bmi_range'],
      health: json['data']['health'],
    );
  }
}
