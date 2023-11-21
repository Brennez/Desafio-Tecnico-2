class NotFoundError implements Exception {
  final String message;

  NotFoundError({
    required this.message,
  });
}
