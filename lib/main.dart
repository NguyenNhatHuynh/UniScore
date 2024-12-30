import 'package:flutter/material.dart';
import 'package:uni_score/screens/gpa_calculator_screen.dart';
import 'package:uni_score/screens/score_converter_screen.dart';
import 'package:uni_score/screens/score_history_screen.dart';
import 'package:uni_score/screens/temporary_average_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light; // Default theme

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uni Score',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black), // Light mode icons
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white), // Dark mode icons
      ),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(onThemeChanged: _toggleTheme),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final Function onThemeChanged;

  HomeScreen({required this.onThemeChanged});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Current index of selected tab

  final List<Widget> _screens = [
    HomeContent(), // Trang chính
    TemporaryAverageScreen(), // Tính điểm trung bình môn
    GPACalculatorScreen(), // Tính điểm GPA
    ScoreHistoryScreen(), // Lịch sử tính điểm
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Cập nhật màn hình khi chuyển tab
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uni Score'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              widget.onThemeChanged(); // Chuyển đổi chế độ sáng/tối
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Theme.of(context).iconTheme.color),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school, color: Theme.of(context).iconTheme.color),
            label: 'Tính điểm trung bình',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(Icons.calculate, color: Theme.of(context).iconTheme.color),
            label: 'Tính GPA',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, color: Theme.of(context).iconTheme.color),
            label: 'Lịch sử',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: [
          _buildCard(
            context,
            'Tính điểm trung bình môn',
            Icons.school,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TemporaryAverageScreen(),
                ),
              );
            },
          ),
          _buildCard(
            context,
            'Tính điểm GPA',
            Icons.calculate,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GPACalculatorScreen(),
                ),
              );
            },
          ),
          _buildCard(
            context,
            'Lịch sử tính điểm',
            Icons.history,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScoreHistoryScreen(),
                ),
              );
            },
          ),
          _buildCard(
            context,
            'Chuyển đổi hệ điểm',
            Icons.loop,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScoreConverterScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).iconTheme.color),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
