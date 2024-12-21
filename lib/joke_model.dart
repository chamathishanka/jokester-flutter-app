class Joke {
  final String category;
  final String type;
  final String joke;
  final String setup;
  final String delivery;
  final bool safe;

  Joke({
    required this.category,
    required this.type,
    required this.joke,
    required this.setup,
    required this.delivery,
    required this.safe,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      category: json['category'],
      type: json['type'],
      joke: json['joke'] ?? '',
      setup: json['setup'] ?? '',
      delivery: json['delivery'] ?? '',
      safe: json['safe'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'type': type,
      'joke': joke,
      'setup': setup,
      'delivery': delivery,
      'safe': safe,
    };
  }
}