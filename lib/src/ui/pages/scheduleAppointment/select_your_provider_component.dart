import 'package:findatimeplease/src/ui/pages/scheduleAppointment/provider_list.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/schedule_appointment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectYourProviderComponent extends StatelessWidget {
  const SelectYourProviderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ScheduleAppointmentViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            vm.fetchingProviders ? '' : 'Select you provider',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Expanded(
          child: vm.fetchingProviders
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Getting Providers'),
                      SizedBox(height: 16),
                      CircularProgressIndicator(),
                    ],
                  ),
                )
              : ProviderList(
                  providerList: vm.providerList,
                  selectedProviderId: vm.selectedProvider?.id,
                  onProviderSelected: vm.setSelectedProvider,
                ),
        ),
      ],
    );
  }
}
