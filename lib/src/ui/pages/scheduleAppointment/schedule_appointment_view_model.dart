import 'package:collection/collection.dart';
import 'package:findatimeplease/src/locator/locator.dart';
import 'package:findatimeplease/src/services/base_service_classes.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/provider_model.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/provider_repository.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/time_cell_model.dart';
import 'package:flutter/material.dart';

class ScheduleAppointmentViewModel extends BaseState {
  ScheduleAppointmentViewModel() {
    init();
  }

  final providerRepo = locator<ProviderRepository>();
  final pageController = PageController();

  final duration = const Duration(milliseconds: 300);
  final curve = Curves.easeInOut;

  List<ProviderModel> providerList = [];

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;
  set selectedDate(DateTime? value) {
    _selectedDate = value;
    notifyListeners();
  }

  TimeOfDay? get _selectedTime => _providerTimeAvailability
      .firstWhereOrNull((element) => element.selected)
      ?.time;

  bool fetchingDates = false;

  bool get nextButtonEnabled {
    if (busy) return false;
    if (!pageController.hasClients) return true;
    final noodle = pageController.page?.toInt();
    switch (noodle) {
      case 0:
        return _selectedProvider != null;
      case 1:
        return _selectedDate != null;
      default:
        return true;
    }
  }

  ProviderModel? _selectedProvider;
  ProviderModel? get selectedProvider => _selectedProvider;

  List<TimeCellModel> _providerTimeAvailability = [];

  List<TimeCellModel> get morningTimeSlots => _providerTimeAvailability
      .where((element) => element.time.hour < 12)
      .toList();

  List<TimeCellModel> get afternoonTimeSlots => _providerTimeAvailability
      .where((element) => element.time.hour >= 12 && element.time.hour < 17)
      .toList();

  List<TimeCellModel> get eveningTimeSlots => _providerTimeAvailability
      .where((element) => element.time.hour >= 17)
      .toList();

  void setSelectedProvider(ProviderModel provider) {
    _selectedProvider = provider;
    nextPage();
    notifyListeners();
  }

  init() async {
    setBusy(true);
    selectedDate = DateTime.now();
    _providerTimeAvailability = _buildTimeCells(
      DateTime(2024, 1, 1, 8, 0),
      DateTime(2024, 1, 1, 18, 0),
    );

    providerList = await providerRepo.fetchUsersProviders('theUserIdGoesHere');

    setBusy(false);
  }

  chooseTime(TimeCellModel time) {
    int index = _providerTimeAvailability.indexWhere(
      (element) => element.time == time.time,
    );

    if (index >= 0) {
      for (var timeCell in _providerTimeAvailability) {
        if (timeCell.selected && timeCell != _providerTimeAvailability[index]) {
          timeCell.selected = false;
        }
      }

      _providerTimeAvailability[index].selected =
          !_providerTimeAvailability[index].selected;

      notifyListeners();
    }
  }

  List<TimeCellModel> _buildTimeCells(
    DateTime start,
    DateTime end,
  ) {
    final List<TimeCellModel> timeCells = [];
    for (var i = start;
        i.isBefore(end);
        i = i.add(const Duration(minutes: 15))) {
      timeCells.add(
        TimeCellModel(
          time: TimeOfDay.fromDateTime(i),
          selected: false,
        ),
      );
    }
    return timeCells;
  }

  void nextPage() {
    if (pageController.page == 2) return;
    pageController.nextPage(duration: duration, curve: curve);
  }

  void previousPage() {
    if (pageController.page == 0) return;
    pageController.previousPage(duration: duration, curve: curve);
  }

  Future<void> handleDateSelected(DateTime date) async {
    _selectedDate = date;
    fetchingDates = true;
    await _fetchTimesForDate(providerId: 'todo', date: date);
    notifyListeners();
  }

  Future<void> _fetchTimesForDate({
    required String providerId,
    required DateTime date,
  }) async {
    // simulate fetching time slots

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
}
