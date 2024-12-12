class Option {
  final String id;
  final String name;
  final String imageUrl;
  bool isCorrect;

  Option({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isCorrect = false,
  });
}

final List<Option> options = [
  Option(
    id: '1',
    name: 'Harimau',
    imageUrl: 'assets/images/harimau.jpg',
    isCorrect: true,
  ),
  Option(
    id: '2',
    name: 'Kuda Nil',
    imageUrl: 'assets/images/kuda_nil.jpg',
    isCorrect: true,
  ),
  Option(
    id: '3',
    name: 'Singa',
    imageUrl: 'assets/images/singa.jpg',
    isCorrect: false,
  ),
];
