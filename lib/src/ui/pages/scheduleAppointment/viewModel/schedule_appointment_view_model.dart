import 'dart:async';

import 'package:collection/collection.dart';
import 'package:findatimeplease/src/locator/locator.dart';
import 'package:findatimeplease/src/services/base_service_classes.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/components/client_side_time_cell_model.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/countdownTimer/countdown_timer.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/models/provider_model.dart';
import 'package:findatimeplease/src/repos/provider_repository.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/components/provider_time_slot.dart';
import 'package:flutter/material.dart';

class ScheduleAppointmentViewModel extends BaseState {
  ScheduleAppointmentViewModel(this.countdownTimer) {
    init();
  }

  StreamController<void> expiredStreamController =
      StreamController<void>.broadcast();
  Stream<void> get expiredStream => expiredStreamController.stream;

  CountdownTimer countdownTimer;

  // String get remainingTimeText => countdownTimer.displayTime;
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

  TimeOfDay? get selectedTime => _providerTimeAvailability
      .firstWhereOrNull((element) => element.selected)
      ?.time;

  bool _fetchingDates = false;
  bool get fetchingDates => _fetchingDates;
  set fetchingDates(bool value) {
    _fetchingDates = value;
    notifyListeners();
  }

  bool _fetchingProviders = false;
  bool get fetchingProviders => _fetchingProviders;
  set fetchingProviders(bool value) {
    _fetchingProviders = value;
    notifyListeners();
  }

  bool _bookingAppointment = false;

  bool get bookingAppointment => _bookingAppointment;

  set bookingAppointment(bool value) {
    _bookingAppointment = value;
    notifyListeners();
  }

  bool get primaryButtonEnabled {
    if (busy || fetchingDates || fetchingProviders) return false;
    if (!pageController.hasClients) return false;
    final noodle = pageController.page?.toInt();
    switch (noodle) {
      case 0:
        return _selectedProvider != null;
      case 1:
        return _selectedDate != null && selectedTime != null;
      default:
        return true;
    }
  }

// TODO: need access to BuildContext to easily localize text
  String primaryButtonText = 'Next';

  ProviderModel? _selectedProvider;
  ProviderModel? get selectedProvider => _selectedProvider;

  List<ClientSideTimeCellModel> _providerTimeAvailability = [];

  List<ClientSideTimeCellModel> get morningTimeSlots =>
      _providerTimeAvailability
          .where((element) => element.time.hour < 12)
          .toList();

  List<ClientSideTimeCellModel> get afternoonTimeSlots =>
      _providerTimeAvailability
          .where((element) => element.time.hour >= 12 && element.time.hour < 17)
          .toList();

  List<ClientSideTimeCellModel> get eveningTimeSlots =>
      _providerTimeAvailability
          .where((element) => element.time.hour >= 17)
          .toList();

  List<ProviderTimeSlot> providerTimeSlots = [];

  void setSelectedProvider(ProviderModel provider) {
    _selectedProvider = provider;
    notifyListeners();
  }

  bool onConfirmPage = false;
  bool appointmentBooked = false;

  init() async {
    try {
      fetchingProviders = true;

      providerList =
          await providerRepo.fetchUsersProviders('theUserIdGoesHere');

      initTimer();
    } on Exception catch (e) {
      logger.logError(e);
    } finally {
      fetchingProviders = false;
    }
  }

  void initTimer() {
    countdownTimer.addListener(_handleCountdownListener);

    countdownTimer.startCountdown();
  }

  _handleCountdownListener() {
    if (countdownTimer.isExpired) {
      expiredStreamController.add(null);
    }
  }

  chooseTime(ClientSideTimeCellModel time) {
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

  Future<void> nextPage() async {
    await pageController.nextPage(duration: duration, curve: curve);
    notifyListeners();
  }

  Future<void> previousPage() async {
    if (pageController.page == 0) return;
    await pageController.previousPage(duration: duration, curve: curve);
    notifyListeners();
  }

  Future<void> handlePrimaryButtonTapped() async {
    if (onConfirmPage) {
      await _bookAppointment();
    } else {
      await nextPage();
    }
  }

  Future<void> _bookAppointment() async {
    try {
      bookingAppointment = true;
      final time = selectedTime;
      if (time == null) return;

      final providerId = _selectedProvider?.id;
      if (providerId == null) return;

      final date = _selectedDate;
      if (date == null) return;

      final timeSlot = _providerTimeAvailability.firstWhereOrNull(
        (element) => element.selected,
      );

      if (timeSlot == null) return;
      await providerRepo.bookAppointment();
      // countdownTimer?.stopCountdown();
      appointmentBooked = true;
      primaryButtonText = 'Done';

      await nextPage();
    } on Exception catch (e) {
      logger.logError(e);
    } finally {
      bookingAppointment = false;
    }
  }

  onPageChanged(int? page) {
    onConfirmPage = page == 2;
    primaryButtonText = onConfirmPage
        ? 'Confirm Appointment'
        : appointmentBooked
            ? 'Done'
            : 'Next';
    notifyListeners();
  }

  Future<void> handleDateSelected(DateTime date) async {
    _selectedDate = date;
    _providerTimeAvailability.clear();
    fetchingDates = true;
    await _fetchTimesForDate(providerId: 'todo', date: date);
    notifyListeners();
  }

  Future<void> _fetchTimesForDate({
    required String providerId,
    required DateTime date,
  }) async {
    try {
      fetchingDates = true;
      final dateRange = await providerRepo.fetchAvailableTimeSlotsForDay(
        providerId: providerId,
        day: date,
      );

      providerTimeSlots = dateRange;

      providerTimeSlots.removeWhere(
        (element) => element.start.isBefore(
          DateTime.now().add(
            const Duration(days: 1),
          ),
        ),
      );

      final twentyFourHoursFromNow =
          DateTime.now().add(const Duration(days: 1));
      _providerTimeAvailability = dateRange.map(
        (e) {
          return ClientSideTimeCellModel(
            time: TimeOfDay.fromDateTime(e.start),
            selected: false,
            minutes: 15,
            enabled: e.start.isAfter(twentyFourHoursFromNow),
          );
        },
      ).toList();

      fetchingDates = false;
      notifyListeners();
    } on Exception catch (e) {
      logger.logError(e);
    } finally {
      fetchingDates = false;
    }
  }

  @override
  void dispose() {
    print('Dispose me please');
    super.dispose();
  }
}
