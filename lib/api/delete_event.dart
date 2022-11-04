import 'package:flutter/material.dart';

import '../const.dart';

Future<void> deleteLibro({
  required BuildContext context,
  required String libroId,
}) async {
  await client.records.delete('books', libroId);
}
