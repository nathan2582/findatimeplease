import 'package:findatimeplease/src/ui/pages/scheduleAppointment/models/provider_model.dart';
import 'package:flutter/material.dart';

class ProviderList extends StatelessWidget {
  const ProviderList(
      {super.key,
      required this.providerList,
      required this.onProviderSelected,
      required this.selectedProviderId});

  final List<ProviderModel> providerList;
  final String? selectedProviderId;

  final void Function(ProviderModel) onProviderSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: providerList.length,
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16);
      },
      itemBuilder: (context, index) {
        final provider = providerList[index];
        return ListTile(
          title: Text(provider.name),
          titleTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          onTap: () => onProviderSelected(provider),
          selectedColor: Theme.of(context).colorScheme.onPrimary,
          selected: provider.id == selectedProviderId,
          selectedTileColor: Theme.of(context).colorScheme.secondary,
          tileColor: const Color.fromARGB(255, 232, 242, 240),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
      },
    );
  }
}
