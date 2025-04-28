import 'package:flutter/material.dart';
import 'package:iris/theme/app_theme.dart';

class AllScreen extends StatelessWidget {
  const AllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('전체'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileSection(),
            _buildQuickActions(),
            _buildSettingsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: AppTheme.surfaceColor,
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
            child: const Icon(
              Icons.person_outline,
              size: 30,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '홍길동',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '직원',
                  style: TextStyle(
                    color: AppTheme.secondaryColor,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              // TODO: Implement profile edit
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '빠른 실행',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildQuickActionItem(
                Icons.add_circle_outline,
                '일정 추가',
                () {
                  // TODO: Implement quick schedule add
                },
              ),
              _buildQuickActionItem(
                Icons.note_add_outlined,
                '기록 추가',
                () {
                  // TODO: Implement quick record add
                },
              ),
              _buildQuickActionItem(
                Icons.work_outline,
                '근무 신청',
                () {
                  // TODO: Implement quick work request
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem(
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '설정',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                _buildSettingsItem(
                  Icons.notifications_outlined,
                  '알림 설정',
                  Icons.chevron_right,
                  () {
                    // TODO: Implement notification settings
                  },
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  Icons.lock_outline,
                  '보안',
                  Icons.chevron_right,
                  () {
                    // TODO: Implement security settings
                  },
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  Icons.help_outline,
                  '도움말',
                  Icons.chevron_right,
                  () {
                    // TODO: Implement help
                  },
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  Icons.info_outline,
                  '앱 정보',
                  Icons.chevron_right,
                  () {
                    // TODO: Implement app info
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement logout
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('로그아웃'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    IconData leadingIcon,
    String title,
    IconData trailingIcon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(leadingIcon, color: AppTheme.primaryColor),
      title: Text(title),
      trailing: Icon(trailingIcon, color: AppTheme.secondaryColor),
      onTap: onTap,
    );
  }
} 