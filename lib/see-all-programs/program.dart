class Program {
  String name;
  String lastUpdate;
  int workoutCount;
  bool isFavorite;

  Program({
    required this.name,
    required this.lastUpdate,
    required this.workoutCount,
    this.isFavorite = false,
  });
}