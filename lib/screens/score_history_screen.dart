import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreHistoryScreen extends StatefulWidget {
  @override
  _ScoreHistoryScreenState createState() => _ScoreHistoryScreenState();
}

class _ScoreHistoryScreenState extends State<ScoreHistoryScreen> {
  List<String> _temporaryAverageHistory = [];
  String _historyType = 'GPA';

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyList = prefs.getStringList(
            _historyType == 'GPA' ? 'gpaHistory' : 'temporaryAverageHistory') ??
        [];
    setState(() {
      _temporaryAverageHistory = historyList;
    });
  }

  Future<void> _clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(
        _historyType == 'GPA' ? 'gpaHistory' : 'temporaryAverageHistory');
    setState(() {
      _temporaryAverageHistory.clear();
    });
  }

  void _deleteHistoryItem(int index) async {
    final prefs = await SharedPreferences.getInstance();
    _temporaryAverageHistory.removeAt(index);
    await prefs.setStringList(
        _historyType == 'GPA' ? 'gpaHistory' : 'temporaryAverageHistory',
        _temporaryAverageHistory);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử tính điểm'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: _clearHistory,
          ),
        ],
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: _historyType,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _historyType = newValue;
                  _loadHistory();
                });
              }
            },
            items: <String>['GPA', 'Điểm trung bình môn']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _temporaryAverageHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_temporaryAverageHistory[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteHistoryItem(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
