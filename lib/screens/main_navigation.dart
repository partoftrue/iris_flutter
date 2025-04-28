import 'package:flutter/material.dart';
import 'package:iris/screens/home_screen.dart';
import 'package:iris/screens/all_screen.dart';
import 'package:iris/screens/work_screen.dart';
import 'package:iris/screens/schedule_screen.dart';
import 'package:iris/screens/records_screen.dart';
import 'package:iris/theme/app_theme.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final List<Widget> _screens = [
    const HomeScreen(),
    const WorkScreen(),
    const ScheduleScreen(),
    const RecordsScreen(),
    const AllScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    
    setState(() {
      _selectedIndex = index;
    });
    
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(
              top: BorderSide(
                color: colorScheme.outline.withOpacity(0.08),
                width: 0.5,
              ),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: colorScheme.surface,
            selectedItemColor: colorScheme.primary,
            unselectedItemColor: colorScheme.onSurface.withOpacity(0.4),
            selectedLabelStyle: textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
            unselectedLabelStyle: textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
            ),
            elevation: 0,
            items: [
              _buildNavItem(
                context,
                '홈',
                Icons.home_outlined,
                Icons.home,
              ),
              _buildNavItem(
                context,
                '근무',
                Icons.work_outline,
                Icons.work,
              ),
              _buildNavItem(
                context,
                '일정',
                Icons.calendar_today_outlined,
                Icons.calendar_today,
              ),
              _buildNavItem(
                context,
                '기록',
                Icons.description_outlined,
                Icons.description,
              ),
              _buildNavItem(
                context,
                '전체',
                Icons.menu_outlined,
                Icons.menu,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    BuildContext context,
    String label,
    IconData outlinedIcon,
    IconData filledIcon,
  ) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final bool isSelected = _screens.indexOf(_screens[_selectedIndex]) == _screens.indexOf(_screens[_selectedIndex]);

    return BottomNavigationBarItem(
      icon: AnimatedScale(
        scale: isSelected ? _scaleAnimation.value : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Icon(
          isSelected ? filledIcon : outlinedIcon,
          size: 22,
        ),
      ),
      label: label,
    );
  }
} 