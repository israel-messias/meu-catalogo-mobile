enum ReadingStatus { want, reading, finished }

extension ReadingStatusLabel on ReadingStatus {
  String get label => switch (this) {
        ReadingStatus.want => 'Quero ler',
        ReadingStatus.reading => 'Lendo',
        ReadingStatus.finished => 'Concluído',
      };
}

class Book {
  const Book(
      {required this.id,
      required this.title,
      required this.author,
      required this.year,
      required this.status,
      this.notes = ''});
  final String id;
  final String title;
  final String author;
  final int year;
  final ReadingStatus status;
  final String notes;
}
