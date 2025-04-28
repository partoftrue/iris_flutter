import 'package:flutter/material.dart';
import 'package:iris/theme/app_theme.dart';
import 'package:iris/screens/work_screen.dart';
import 'package:iris/screens/schedule_screen.dart';
import 'package:iris/screens/records_screen.dart';

class AllScreen extends StatelessWidget {
  const AllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text('메뉴', style: textTheme.headlineLarge),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: colorScheme.onBackground,
            ),
            onPressed: () {
              // TODO: Show notifications
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _buildSection(
            context,
            '근무',
            [
              _buildMenuItem(
                context,
                '근무 일정',
                '근무 일정을 확인하고 관리해요',
                Icons.calendar_today_outlined,
                Icons.arrow_forward_ios,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WorkScreen()),
                  );
                },
              ),
              _buildMenuItem(
                context,
                '근무 신청',
                '추가 근무를 신청해요',
                Icons.add_circle_outline,
                Icons.arrow_forward_ios,
                () {
                  // TODO: Navigate to work request form
                },
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildSection(
            context,
            '일정',
            [
              _buildMenuItem(
                context,
                '일정 목록',
                '전체 일정을 확인해요',
                Icons.event_outlined,
                Icons.arrow_forward_ios,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ScheduleScreen()),
                  );
                },
              ),
              _buildMenuItem(
                context,
                '일정 추가',
                '새로운 일정을 추가해요',
                Icons.add_circle_outline,
                Icons.arrow_forward_ios,
                () {
                  // TODO: Show add schedule dialog
                },
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildSection(
            context,
            '기록',
            [
              _buildMenuItem(
                context,
                '기록 목록',
                '전체 기록을 확인해요',
                Icons.description_outlined,
                Icons.arrow_forward_ios,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RecordsScreen()),
                  );
                },
              ),
              _buildMenuItem(
                context,
                '기록 추가',
                '새로운 기록을 추가해요',
                Icons.add_circle_outline,
                Icons.arrow_forward_ios,
                () {
                  // TODO: Show add record dialog
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.sm),
          child: Text(
            title,
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.onBackground,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Card(
          elevation: 0,
          color: colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            side: BorderSide(
              color: colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData leadingIcon,
    IconData trailingIcon,
    VoidCallback onTap,
  ) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                leadingIcon,
                color: colorScheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              trailingIcon,
              color: colorScheme.onSurfaceVariant,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
} 