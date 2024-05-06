// import 'package:findatimeplease/src/ui/pages/scheduleAppointment/schedule_appointment_view_model.dart';
// import 'package:findatimeplease/src/ui/pages/scheduleAppointment/selected_date_extension.dart';
// import 'package:findatimeplease/src/ui/pages/scheduleAppointment/time_cell.dart';
// import 'package:flutter/material.dart';

// class TimeGridViewWithRangeAsParameters extends StatelessWidget {
//   const TimeGridViewWithRangeAsParameters({
//     super.key,
//     required this.start,
//     required this.end,
//   });

//   final DateTime start;
//   final DateTime end;

//   List<Widget> _buildTimeCellsEveryThirtyMinutesFromTimeRange(
//     DateTime start,
//     DateTime end,
//   ) {
//     final List<Widget> timeCells = [];
//     for (var i = start;
//         i.isBefore(end);
//         i = i.add(const Duration(minutes: 30))) {
//       timeCells.add(
//         TimeCell(
//           time: TimeOfDay.fromDateTime(i),
//           selected: false,
//           timeSelected: () {
//             print('selected ${i.hourMinuteText}');
//           },
//         ),
//       );
//     }
//     return timeCells;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       shrinkWrap: true,
//       padding: const EdgeInsets.only(top: 16),
//       physics: const NeverScrollableScrollPhysics(),
//       crossAxisSpacing: 16,
//       mainAxisSpacing: 16,
//       crossAxisCount: 3,
//       childAspectRatio: 2,
//       children: _buildTimeCellsEveryThirtyMinutesFromTimeRange(start, end),
//     );
//   }
// }
