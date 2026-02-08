import 'package:intl/intl.dart';

String formatDate(String isoDate) {
  final dateTime = DateTime.parse(isoDate);
  return DateFormat('yyyy-MM-dd').format(dateTime);
}
