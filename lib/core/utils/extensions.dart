import 'package:intl/intl.dart';

extension DateTimeExt on String {
  String formatedYearOfDateTime({String outputFormat = 'yyyy'}) {
    // Parse the date string into a DateTime object
    DateTime dateTime = DateTime.parse(this);

    // Create a DateFormat object with the desired format
    DateFormat formatter = DateFormat(outputFormat);

    // Format the DateTime object
    return formatter.format(dateTime);
  }
}
