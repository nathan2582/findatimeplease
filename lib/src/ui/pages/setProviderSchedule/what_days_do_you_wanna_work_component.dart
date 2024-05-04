// import 'package:findatimeplease/src/ui/pages/scheduleAppointment/date_time_picker_view_model.dart';
// import 'package:findatimeplease/src/ui/pages/setProviderSchedule/days_of_week_schedule_dialog_view_model.dart';
// import 'package:findatimeplease/src/ui/widgets/buttons/app_outlined_button.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class WhatDaysDoYouWannaWorkComponent extends StatelessWidget {
//   const WhatDaysDoYouWannaWorkComponent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const Text(
//           'What days do you wanna work?',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         ChangeNotifierProvider(
//           create: (context) => DaysOfWeekScheduleDialogViewModel(),
//           builder: (context, _) {
//             final vm = context.watch<DaysOfWeekScheduleDialogViewModel>();

//             return Expanded(
//               child: GridView.builder(
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 4,
//                   crossAxisSpacing: 8,
//                   childAspectRatio: 1,
//                 ),
//                 itemCount: DayOfWeek.values.length,
//                 itemBuilder: (context, index) {
//                   final dayOfWeek =
//                       DayOfWeek.values[(index + 1) % DayOfWeek.values.length];

//                   return AppOutlinedButton(
//                     analyticsName: dayOfWeek.shortName,
//                     text: dayOfWeek.shortName,
//                     size: Size(size.width / 6, size.width / 6),
//                     isCircle: true,
//                     backgroundColor: context
//                             .watch<DaysOfWeekScheduleDialogViewModel>()
//                             .selectedDays
//                             .contains(dayOfWeek)
//                         ? Theme.of(context).colorScheme.primary.withOpacity(0.4)
//                         : Colors.transparent,
//                     textColor: context
//                             .watch<DaysOfWeekScheduleDialogViewModel>()
//                             .selectedDays
//                             .contains(dayOfWeek)
//                         ? Colors.white
//                         : null,
//                     borderColor: context
//                             .watch<DaysOfWeekScheduleDialogViewModel>()
//                             .selectedDays
//                             .contains(dayOfWeek)
//                         ? Theme.of(context).colorScheme.primary.withOpacity(0.4)
//                         : Colors.grey,
//                     onTap: () {
//                       context
//                           .read<DaysOfWeekScheduleDialogViewModel>()
//                           .toggleDayOfWeek(dayOfWeek);
//                     },
//                   );
//                 },
//               ),
//             );
//           },
//         )
//       ],
//     );
//   }
// }
