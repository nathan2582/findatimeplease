import 'package:intl/intl.dart';

extension SelectedDateExtension on DateTime {
  String get toDisplayText => DateFormat('EEEE, MMMM d').format(this);
  String get hourMinuteText => DateFormat('h:mm a').format(this);
}
