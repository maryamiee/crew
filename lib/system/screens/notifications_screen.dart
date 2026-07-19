import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../models/profile_user.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // TODO: replace with a real-time feed once backend/push is connected.
  final List<NotificationItem> _items = [
    NotificationItem(
      title: 'Report status updated',
      body: 'Your report "Broken hallway light" is now Under Review.',
      time: '2h ago',
      read: false,
    ),
    NotificationItem(
      title: 'New campus alert',
      body: 'Maintenance work scheduled near Block C, 3–5 PM today.',
      time: '5h ago',
      read: false,
    ),
    NotificationItem(
      title: 'Report resolved',
      body: 'Your report "Wi-Fi outage, Library" has been marked Resolved.',
      time: 'Yesterday',
      read: true,
    ),
    NotificationItem(
      title: 'Welcome to CREW',
      body: 'Thanks for joining — you can report campus issues anytime.',
      time: '3 days ago',
      read: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {
              final updated = [
                for (final n in _items)
                  NotificationItem(
                    title: n.title,
                    body: n.body,
                    time: n.time,
                    read: true,
                  ),
              ];
              setState(() {
                _items
                  ..clear()
                  ..addAll(updated);
              });
            },
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: _items.isEmpty
          ? const Center(
              child: Text(
                'No notifications yet',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          : ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: _items.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, i) => _NotificationTile(item: _items[i]),
            ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationItem item;
  const _NotificationTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: item.read
            ? null
            : Border.all(
                color: AppColors.integrationPurple.withValues(alpha: 0.25),
              ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  item.read ? Colors.transparent : AppColors.integrationPurple,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight:
                              item.read ? FontWeight.w600 : FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Text(
                      item.time,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.body,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
