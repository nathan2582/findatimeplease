import 'package:findatimeplease/src/ui/pages/scheduleAppointment/provider_list.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/schedule_appointment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectYourProviderComponent extends StatelessWidget {
  const SelectYourProviderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ScheduleAppointmentViewModel>();
    return vm.busy
        ? const Center(child: CircularProgressIndicator())
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select a provider'),
              const SizedBox(height: 16),
              Expanded(
                child: ProviderList(
                  providerList: vm.providerList,
                  selectedProviderId: vm.selectedProvider?.id,
                  onProviderSelected: vm.setSelectedProvider,
                ),
              ),
            ],
          );
  }
}
