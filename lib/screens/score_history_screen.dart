import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreHistoryScreen extends StatefulWidget {
  @override
  _ScoreHistoryScreenState createState() => _ScoreHistoryScreenState();
}

class _ScoreHistoryScreenState extends State<ScoreHistoryScreen> {
  List<Map<String, String>> _gpaHistory = [];

  @override
  void initState() {
    super.initState();
    _loadGPAHistory();
  }

  Future<void> _loadGPAHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyList = prefs.getStringList('gpaHistory') ?? [];

    setState(() {
      _gpaHistory = historyList.map((history) {
        final parts = history.split(' - ');
        return {'subject': parts[0], 'gpa': parts[1]};
      }).toList();
    });
  }

  // Function to delete the GPA history
  Future<void> _deleteHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('gpaHistory');
    setState(() {
      _gpaHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử tính điểm'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: _deleteHistory,
          ),
        ],
      ),
      body: _gpaHistory.isEmpty
          ? Center(child: Text('Chưa có lịch sử tính điểm'))
          : ListView.builder(
              itemCount: _gpaHistory.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      'Môn học: ${_gpaHistory[index]['subject']}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('GPA: ${_gpaHistory[index]['gpa']}'),
                  ),
                );
              },
            ),
    );
  }
}
