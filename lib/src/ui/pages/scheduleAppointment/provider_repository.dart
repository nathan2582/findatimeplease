import 'package:findatimeplease/src/services/base_service_classes.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/provider_model.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/provider_time_slot.dart';

class ProviderRepository extends BaseRepo {
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
  Future<List<ProviderTimeSlot>> fetchProviderTimeSlots({
    required String providerId,
    required DateTime day,
  }) async {
    return [];
  }
}
