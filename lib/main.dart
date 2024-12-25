import 'package:flutter/material.dart';
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
      title: 'UniScore',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          color: Colors.blueAccent, // AppBar color
          elevation: 4,
          iconTheme:
              IconThemeData(color: Colors.black), // Icon color in light mode
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.blueAccent, // Color when selected
          unselectedItemColor: Colors.grey, // Color when not selected
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          color: Colors.black87, // AppBar color in dark mode
          elevation: 4,
          iconTheme:
              IconThemeData(color: Colors.white), // Icon color in dark mode
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor:
              Colors.lightBlueAccent, // Selected item color in dark mode
          unselectedItemColor:
              Colors.grey, // Unselected item color in dark mode
        ),
      ),
      themeMode: _themeMode, // Apply the theme mode
      debugShowCheckedModeBanner: false, // Hide the debug banner
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
    HomeContent(),
    DummyScreen(title: 'Tính điểm trung bình môn'),
    DummyScreen(title: 'Tính điểm GPA'),
    DummyScreen(title: 'Lịch sử tính điểm'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update screen when tab is selected
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UniScore'),
        centerTitle: true, // Center the title
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              widget.onThemeChanged(); // Toggle theme
            },
          ),
        ],
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.blueAccent
            : Colors.black87, // Update color based on theme
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Tính điểm trung bình môn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Tính điểm GPA',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Lịch sử tính điểm',
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
                    builder: (context) => TemporaryAverageScreen()),
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
                    builder: (context) => DummyScreen(title: 'Tính điểm GPA')),
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
                    builder: (context) =>
                        DummyScreen(title: 'Lịch sử tính điểm')),
              );
            },
          ),
          _buildCard(
            context,
            'Xếp loại tốt nghiệp',
            Icons.star,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DummyScreen(title: 'Xếp loại tốt nghiệp')),
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
                    builder: (context) =>
                        DummyScreen(title: 'Chuyển đổi hệ điểm')),
              );
            },
          ),
          _buildCard(
            context,
            'Nhắc nhở học tập',
            Icons.notifications,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DummyScreen(title: 'Nhắc nhở học tập')),
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
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.blueAccent
                  : Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.blueAccent
                    : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Dummy Screen for simulated functions
class DummyScreen extends StatelessWidget {
  final String title;

  DummyScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text('Màn hình chi tiết của chức năng: $title'),
      ),
    );
  }
}
