import 'dart:math';

import 'package:findatimeplease/src/services/base_service_classes.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/provider_model.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/provider_time_slot.dart';
import 'package:findatimeplease/src/ui/pages/setProviderSchedule/provider_working_day_of_week.dart';

class ProviderRepository extends BaseRepo {
  List<ProviderWorkingDayOfWeek> providerTimeRanges = [];

  Future<List<ProviderModel>> fetchUsersProviders(String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    final providers = [
      const ProviderModel(
        id: '1',
        name: 'Timothy Franklin',
        imageUrl: '',
      ),
      const ProviderModel(
        id: '2',
        name: 'Maria Von Trapp',
        imageUrl: '',
      ),
      const ProviderModel(
        id: '3',
        name: 'Nemo Fishman',
        imageUrl: '',
      ),
    ];
    return providers;
  }

// TODO: Fetch in month batches or something? Is it worth it?
  Future<List<ProviderTimeSlot>> fetchAvailableTimeSlotsForDay({
    required String providerId,
    required DateTime day,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    // start: DateTime(day.year, day.month, day.day, 0, 0),
    // end: DateTime(day.year, day.month, day.day, 23, 59),

    return fetch15MinuteTimeSlotsRandomlyAvailable(
      start: DateTime(day.year, day.month, day.day, 9),
      end: DateTime(day.year, day.month, day.day, 17, 59),
    );
  }

  List<ProviderTimeSlot> fetch15MinuteTimeSlotsRandomlyAvailable({
    required DateTime start,
    required DateTime end,
  }) {
    final timeSlots = <ProviderTimeSlot>[];
    final random = Random();
    for (var i = start;
        i.isBefore(end);
        i = i.add(
      const Duration(minutes: 15),
    ),) {
      var available = random.nextDouble() >= 0.8;
      if (available) {
        timeSlots.add(
          ProviderTimeSlot(
            start: i,
            end: i.add(const Duration(minutes: 15)),
            providerId: 'todoSetMe',
          ),
        );
      }
    }
    return timeSlots;
  }

  setProviderSchedule({
    required String providerId,
    required List<ProviderWorkingDayOfWeek> providerTimeRanges,
  }) async {
    print(
      'This is where we would set the provider schedule. For now, I will put it in a local variable in memory.',
    );
    await Future.delayed(const Duration(seconds: 1));

    this.providerTimeRanges = providerTimeRanges;
    for (var element in providerTimeRanges) {
      final dayOfWeek = element.dayOfWeek;
      final start = element.start;
      final end = element.end;

      print('Day of week: $dayOfWeek. Start: $start. End: $end.');
    }
  }

  Future<void> bookAppointment() async {
    print('Booking appointment mock it up...');
    await Future.delayed(const Duration(seconds: 2));
  }
}
