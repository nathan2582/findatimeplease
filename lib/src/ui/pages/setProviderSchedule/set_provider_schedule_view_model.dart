import 'package:findatimeplease/src/locator/locator.dart';
import 'package:findatimeplease/src/services/base_service_classes.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/date_time_picker_view_model.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/provider_model.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/provider_repository.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/selected_date_extension.dart';
import 'package:findatimeplease/src/ui/pages/setProviderSchedule/provider_working_day_of_week.dart';
import 'package:flutter/material.dart';

class SetProviderScheduleViewModel extends BaseState {
  SetProviderScheduleViewModel() {
    init();
  }

  final providerRepo = locator<ProviderRepository>();

  final pageController = PageController();

  final duration = const Duration(milliseconds: 300);
  final curve = Curves.easeInOut;
  bool fetchingDates = false;

  bool get nextButtonEnabled {
    return providerTimeRanges.any((element) => element.selected);
  }

  final List<ProviderWorkingDayOfWeek> providerTimeRanges = List.generate(
    DayOfWeek.values.length,
    (index) => ProviderWorkingDayOfWeek(
      dayOfWeek: DayOfWeek.values[index],
      start: const TimeOfDay(hour: 9, minute: 0),
      end: const TimeOfDay(hour: 17, minute: 0),
      selected: false,
      controller: ExpansionTileController(),
    ),
  );

  init() async {
    setBusy(true);
    selectedDateTime = DateTime.now();
    providerList = await providerRepo.fetchUsersProviders('todo');

    setBusy(false);
  }

  List<ProviderModel> providerList = [];

  String? get selectedDateTimeDisplay => selectedDateTime?.toDisplayText;

  DateTime? _selectedDateTime;
  DateTime? get selectedDateTime => _selectedDateTime;
  set selectedDateTime(DateTime? value) {
    _selectedDateTime = value;
    notifyListeners();
  }

  void nextPage() {
    if (pageController.page == 2) return;
    pageController.nextPage(duration: duration, curve: curve);
  }

  void previousPage() {
    if (pageController.page == 0) return;
    pageController.previousPage(duration: duration, curve: curve);
  }

  handleDateSelected(DateTime date) async {
    _selectedDateTime = date;
    fetchingDates = true;
    await _fetchTimesForDate(providerId: 'todo', date: date);
    notifyListeners();
  }

  _fetchTimesForDate({
    required String providerId,
    required DateTime date,
  }) async {
    try {
      fetchingDates = true;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 2));
      final dateRange = await providerRepo.fetchProviderTimeSlots(
        providerId: providerId,
        day: date,
      );

      fetchingDates = false;
      notifyListeners();
    } on Exception catch (e) {
      logger.logError(e);
    }
  }

  selectedDayOfWeek(
    DayOfWeek dayOfWeek,
    bool? selected,
  ) {
    for (var element in providerTimeRanges) {
      if (element.controller.isExpanded) {
        element.controller.collapse();
      }
    }

    final index = providerTimeRanges
        .indexWhere((element) => element.dayOfWeek == dayOfWeek);

    if (index >= 0) {
      final providerTimeRange = providerTimeRanges[index];
      providerTimeRange.selected = selected ?? false;
      providerTimeRange.controller.expand();
    }

    notifyListeners();
  }

  startChanged(
    DayOfWeek dayOfWeek,
    TimeOfDay start,
  ) {
    final index = providerTimeRanges
        .indexWhere((element) => element.dayOfWeek == dayOfWeek);

    if (index >= 0) {
      final providerTimeRange = providerTimeRanges[index];
      providerTimeRange.start = start;
      providerTimeRange.selected = true;
    }
    notifyListeners();
  }

  endChanged(
    DayOfWeek dayOfWeek,
    TimeOfDay end,
  ) {
    final index = providerTimeRanges
        .indexWhere((element) => element.dayOfWeek == dayOfWeek);

    if (index >= 0) {
      final providerTimeRange = providerTimeRanges[index];
      providerTimeRange.end = end;
      providerTimeRange.selected = true;
    }
    notifyListeners();
  }

  handleExpansionChanged(DayOfWeek dayOfWeek, bool expanded) {
    for (var element in providerTimeRanges) {
      print('dayOfWeek: $dayOfWeek, element.dayOfWeek: ${element.dayOfWeek}');
      if (element.dayOfWeek != dayOfWeek && element.controller.isExpanded) {
        element.controller.collapse();
      }
    }
  }
}
