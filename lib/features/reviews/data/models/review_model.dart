class ReviewModel {
  final String title;
  final List<DirectionModel> direction;
  ReviewModel(this.title, this.direction);
}

class DirectionModel {
  final String title;
  final String instructions;
  final String date;
  final List<StepModel> items;
  DirectionModel(this.title, this.items, this.instructions, this.date);
}

class StepModel {
  final String title;
  final String description;
  StepModel(this.title, this.description);
}
