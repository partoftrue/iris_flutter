import 'package:flutter/material.dart';
import 'package:iris/theme/app_theme.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  int _selectedIndex = 0;

  final List<String> _categories = [
    '전체',
    '업무',
    '회의',
    '일지',
    '메모',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('기록 관리'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategorySelector(),
          Expanded(
            child: _buildRecordList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddRecordDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(_categories[index]),
              selected: _selectedIndex == index,
              onSelected: (selected) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              selectedColor: AppTheme.primaryColor,
              labelStyle: TextStyle(
                color: _selectedIndex == index ? Colors.white : AppTheme.secondaryColor,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecordList() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildRecordItem(
          '프로젝트 회의록',
          '어제',
          '회의',
          Icons.description_outlined,
          '팀 미팅 내용 및 결정사항',
        ),
        _buildRecordItem(
          '일일 업무 보고서',
          '2일 전',
          '업무',
          Icons.assignment_outlined,
          '오늘 완료한 작업 목록',
        ),
        _buildRecordItem(
          '아이디어 메모',
          '3일 전',
          '메모',
          Icons.lightbulb_outline,
          '새로운 기능 아이디어',
        ),
      ],
    );
  }

  Widget _buildRecordItem(
    String title,
    String date,
    String category,
    IconData icon,
    String preview,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          // TODO: Implement record detail view
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                    child: Icon(icon, color: AppTheme.primaryColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          date,
                          style: TextStyle(
                            color: AppTheme.secondaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Chip(
                    label: Text(
                      category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    backgroundColor: AppTheme.accentColor,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                preview,
                style: TextStyle(
                  color: AppTheme.secondaryColor,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddRecordDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '새 기록 추가',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: '제목',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: '카테고리',
                    border: OutlineInputBorder(),
                  ),
                  items: _categories
                      .skip(1)
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    // TODO: Implement category selection
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: '내용',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement save record
                      Navigator.pop(context);
                    },
                    child: const Text('저장'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 