import 'package:findatimeplease/src/locator/locator.dart';
import 'package:findatimeplease/src/services/base_service_classes.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/datePicker/date_time_picker_view_model.dart';
import 'package:findatimeplease/src/repos/provider_repository.dart';
import 'package:findatimeplease/src/ui/pages/setProviderSchedule/components/provider_working_day_of_week.dart';
import 'package:flutter/material.dart';

class SetProviderScheduleViewModel extends BaseState {
  SetProviderScheduleViewModel() {
    init();
  }

  final providerRepo = locator<ProviderRepository>();

  final pageController = PageController();

  bool _fetchingDates = false;
  bool get fetchingDates => _fetchingDates;
  set fetchingDates(bool value) {
    _fetchingDates = value;
    notifyListeners();
  }

  bool get primaryButtonEnabled =>
      providerTimeRanges.any((element) => element.selected);

//TODO: We need access to the context for localized text.
  String get primaryText {
    if (!pageController.hasClients || pageController.page == 0) {
      return 'Next';
    } else {
      return 'Set Schedule';
    }
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
    // _providerList = await providerRepo.fetchUsersProviders('todo');

    setBusy(false);
  }

  // List<ProviderModel> _providerList = [];

  DateTime? _selectedDateTime;
  DateTime? get selectedDateTime => _selectedDateTime;
  set selectedDateTime(DateTime? value) {
    _selectedDateTime = value;
    notifyListeners();
  }

  void nextPage() {
    if (pageController.page == 2) return;
    const duration = Duration(milliseconds: 300);
    const curve = Curves.easeInOut;
    pageController.nextPage(duration: duration, curve: curve);
  }

  void previousPage() {
    if (pageController.page == 0) return;
    const duration = Duration(milliseconds: 300);
    const curve = Curves.easeInOut;
    pageController.previousPage(duration: duration, curve: curve);
  }

  Future<void> handleDateSelected(DateTime date) async {
    _selectedDateTime = date;
    await _fetchTimesForDate(providerId: 'todo', date: date);
  }

  Future<void> _fetchTimesForDate({
    required String providerId,
    required DateTime date,
  }) async {
    try {
      fetchingDates = true;
      await Future.delayed(const Duration(seconds: 2));
      // final dateRange = await providerRepo.fetchAvailableTimeSlotsForDay(
      //   providerId: providerId,
      //   day: date,
      // );
    } on Exception catch (e) {
      logger.logError(e);
    } finally {
      fetchingDates = false;
    }
  }

  void selectedDayOfWeek(
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

// MARK: Expansion Tile
  void startChanged(
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

  void endChanged(
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

  void handleExpansionChanged(DayOfWeek dayOfWeek, bool expanded) {
    for (var element in providerTimeRanges) {
      if (element.dayOfWeek != dayOfWeek && element.controller.isExpanded) {
        element.controller.collapse();
      }
    }
  }

  Future<void> setProviderSchedule() async {
    try {
      setBusy(true);

      await providerRepo.setProviderSchedule(
        providerId: 'todo',
        providerTimeRanges: providerTimeRanges,
      );
    } on Exception catch (e) {
      logger.logError(e);
    } finally {
      setBusy(false);
    }
  }

  void handlePrimaryButton() {
    if (!pageController.hasClients) return;
    if (pageController.page == 0) {
      nextPage();
    } else {
      setProviderSchedule();
    }
  }
}
