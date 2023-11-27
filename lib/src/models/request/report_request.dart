class ReportRaw {
  final String reportReason;
  final int reviewId;

  ReportRaw({
    required this.reportReason,
    required this.reviewId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reviewId'] = reviewId;
    data['reportReason'] = reportReason;
    return data;
  }
}
