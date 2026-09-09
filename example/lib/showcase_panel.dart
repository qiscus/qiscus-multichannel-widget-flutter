import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';

class ShowcasePanel extends ConsumerWidget {
  const ShowcasePanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final multichannel = ref.watch(QMultichannel.provider);
    final account = multichannel.account;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Showcase Controls',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),
            _buildInfoRow(
              'Account Info',
              account.when(
                data: (a) => a.name,
                error: (_, __) => 'Error loading account',
                loading: () => 'Loading...',
              ),
            ),
            _buildInfoRow('Room ID', multichannel.roomId?.toString() ?? 'N/A'),
            _buildInfoRow('Message Count', multichannel.messages.length.toString()),
            const SizedBox(height: 20),
            const Text(
              'Actions',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ActionChip(
                  avatar: const Icon(Icons.title, size: 16),
                  label: const Text('Update Title'),
                  onPressed: () => _showUpdateTitleDialog(context, ref),
                ),
                ActionChip(
                  avatar: const Icon(Icons.face, size: 16),
                  label: const Text('Toggle Avatar'),
                  onPressed: () {
                    // This is just a showcase, we don't have a direct setter for avatar in provider yet
                    // but we can show how state changes would propagate if were using them.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Avatar toggle demo triggered')),
                    );
                  },
                ),
                ActionChip(
                  backgroundColor: Colors.red.shade50,
                  avatar: const Icon(Icons.logout, size: 16, color: Colors.red),
                  label: const Text('Logout', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    multichannel.clearUser();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  void _showUpdateTitleDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Room Title'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter new title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Note: Package might not expose immediate refresh of title from provider
              // but we can trigger internal state updates if they existed.
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}

void showShowcasePanel(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const ShowcasePanel(),
  );
}
