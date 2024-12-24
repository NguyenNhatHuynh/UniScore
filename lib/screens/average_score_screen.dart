import 'package:flutter/material.dart';

class AverageScoreScreen extends StatefulWidget {
  @override
  _AverageScoreScreenState createState() => _AverageScoreScreenState();
}

class _AverageScoreScreenState extends State<AverageScoreScreen> {
  final List<TextEditingController> _subjectControllers = [];
  final List<TextEditingController> _creditControllers = [];
  final List<TextEditingController> _scoreControllers = [];
  double _averageScore = 0.0;

  void _calculateAverageScore() {
    double totalScore = 0;
    int totalCredits = 0;

    for (int i = 0; i < _subjectControllers.length; i++) {
      final score = double.tryParse(_scoreControllers[i].text) ?? 0.0;
      final credits = int.tryParse(_creditControllers[i].text) ?? 0;

      totalScore += score * credits;
      totalCredits += credits;
    }

    setState(() {
      _averageScore = totalCredits > 0 ? totalScore / totalCredits : 0.0;
    });
  }

  void _addSubjectField() {
    setState(() {
      _subjectControllers.add(TextEditingController());
      _creditControllers.add(TextEditingController());
      _scoreControllers.add(TextEditingController());
    });
  }

  @override
  void dispose() {
    for (var controller in _subjectControllers) {
      controller.dispose();
    }
    for (var controller in _creditControllers) {
      controller.dispose();
    }
    for (var controller in _scoreControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tính Điểm Trung Bình Môn'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _subjectControllers.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _subjectControllers[index],
                            decoration: InputDecoration(
                              labelText: 'Tên môn học',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.book),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _creditControllers[index],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Số tín chỉ',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.calculate),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _scoreControllers[index],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Điểm số',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.grade),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: _addSubjectField,
              icon: Icon(Icons.add),
              label: const Text('Thêm môn học'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateAverageScore,
              child: const Text('Tính điểm trung bình'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Điểm trung bình: ${_averageScore.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
