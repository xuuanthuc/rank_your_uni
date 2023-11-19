class Pageable {
  int pageNumber;
  int pageSize;

  Pageable({
    required this.pageNumber,
    required this.pageSize,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) {
    final pageNumber = json['pageNumber'];
    final pageSize = json['pageSize'];

    return Pageable(
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }
}
