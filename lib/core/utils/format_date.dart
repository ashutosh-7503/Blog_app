import 'package:intl/intl.dart';

String formatDatebyddMMYYYY(DateTime date) {
  return DateFormat("d MMM,yyyy").format(date);
}
