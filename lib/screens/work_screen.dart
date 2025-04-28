import 'package:flutter/material.dart';
import 'package:iris/theme/app_theme.dart';

class WorkScreen extends StatefulWidget {
  const WorkScreen({super.key});

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  bool isEmployer = false; // TODO: Replace with actual user role

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('근무 관리'),
        actions: [
          IconButton(
            icon: Icon(
              isEmployer ? Icons.person_outline : Icons.business_outlined,
            ),
            onPressed: () {
              setState(() {
                isEmployer = !isEmployer;
              });
            },
          ),
        ],
      ),
      body: isEmployer ? _buildEmployerView() : _buildEmployeeView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add work schedule/request
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmployerView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('근무 일정 관리'),
          const SizedBox(height: 16),
          _buildScheduleCard(),
          const SizedBox(height: 24),
          _buildSectionTitle('근무 신청 현황'),
          const SizedBox(height: 16),
          _buildWorkRequestCard(),
        ],
      ),
    );
  }

  Widget _buildEmployeeView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('내 근무 일정'),
          const SizedBox(height: 16),
          _buildMyScheduleCard(),
          const SizedBox(height: 24),
          _buildSectionTitle('근무 신청'),
          const SizedBox(height: 16),
          _buildRequestWorkCard(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildScheduleCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildScheduleItem(
              '김직원',
              '09:00 - 18:00',
              '정규 근무',
              Icons.check_circle_outline,
              Colors.green,
            ),
            const Divider(),
            _buildScheduleItem(
              '이직원',
              '13:00 - 22:00',
              '정규 근무',
              Icons.check_circle_outline,
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkRequestCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildRequestItem(
              '박직원',
              '추가 근무 신청',
              '18:00 - 20:00',
              '대기중',
              Icons.pending_outlined,
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyScheduleCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildScheduleItem(
              '오늘',
              '09:00 - 18:00',
              '정규 근무',
              Icons.check_circle_outline,
              Colors.green,
            ),
            const Divider(),
            _buildScheduleItem(
              '내일',
              '09:00 - 18:00',
              '정규 근무',
              Icons.check_circle_outline,
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestWorkCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.add_circle_outline),
              title: const Text('추가 근무 신청하기'),
              subtitle: const Text('날짜와 시간을 선택하여 신청'),
              onTap: () {
                // TODO: Implement work request form
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleItem(
    String name,
    String time,
    String type,
    IconData icon,
    Color color,
  ) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(name),
      subtitle: Text(time),
      trailing: Text(
        type,
        style: TextStyle(
          color: AppTheme.secondaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildRequestItem(
    String name,
    String requestType,
    String time,
    String status,
    IconData icon,
    Color color,
  ) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(name),
      subtitle: Text('$requestType\n$time'),
      trailing: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
} 