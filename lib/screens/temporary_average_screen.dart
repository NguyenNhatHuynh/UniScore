import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemporaryAverageScreen extends StatefulWidget {
  @override
  _TemporaryAverageScreenState createState() => _TemporaryAverageScreenState();
}

class _TemporaryAverageScreenState extends State<TemporaryAverageScreen> {
  final TextEditingController _subjectNameController = TextEditingController();
  final List<TextEditingController> _regularScoreControllers = [];
  final TextEditingController _midTermScoreController = TextEditingController();
  final TextEditingController _finalScoreController = TextEditingController();

  double _temporaryAverage = 0.0;
  String _classification = 'Chưa xác định';

  void _addRegularScoreField() {
    _regularScoreControllers.add(TextEditingController());
    setState(() {});
  }

  void _removeRegularScoreField(int index) {
    _regularScoreControllers.removeAt(index);
    setState(() {});
  }

  double _roundScore(double score) {
    return (score * 10).roundToDouble() / 10;
  }

  Future<void> _calculateTemporaryAverage() async {
    String subjectName = _subjectNameController.text.trim();
    if (subjectName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập tên môn học')),
      );
      return;
    }

    double totalRegularScore = 0.0;
    int regularScoreCount = 0;

    for (var controller in _regularScoreControllers) {
      final double score = double.tryParse(controller.text) ?? 0.0;
      if (score > 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Điểm không được lớn hơn 10')),
        );
        return;
      }
      totalRegularScore += score;
      regularScoreCount++;
    }

    if (regularScoreCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập ít nhất một điểm thường xuyên'),
        ),
      );
      return;
    }

    final double regularScoreAverage = totalRegularScore / regularScoreCount;
    final double midTermScore =
        double.tryParse(_midTermScoreController.text) ?? 0.0;
    final double finalScore =
        double.tryParse(_finalScoreController.text) ?? 0.0;

    if (midTermScore > 10 || finalScore > 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Điểm không được lớn hơn 10')),
      );
      return;
    }

    const double regularWeight = 0.3;
    const double midTermWeight = 0.3;
    const double finalWeight = 0.4;

    setState(() {
      _temporaryAverage = _roundScore((regularScoreAverage * regularWeight +
              midTermScore * midTermWeight +
              finalScore * finalWeight) /
          (regularWeight + midTermWeight + finalWeight));

      if (regularScoreAverage < 4 || midTermScore < 4 || finalScore < 4) {
        _classification = 'F';
      } else if (_temporaryAverage >= 8.5) {
        _classification = 'A';
      } else if (_temporaryAverage >= 8) {
        _classification = 'B+';
      } else if (_temporaryAverage >= 7) {
        _classification = 'B';
      } else if (_temporaryAverage >= 6.5) {
        _classification = 'C+';
      } else if (_temporaryAverage >= 5.5) {
        _classification = 'C';
      } else if (_temporaryAverage >= 5) {
        _classification = 'D+';
      } else if (_temporaryAverage >= 4) {
        _classification = 'D';
      } else {
        _classification = 'F';
      }
    });

    // Save temporary average to history
    await _saveTemporaryAverageToHistory(subjectName);
  }

  Future<void> _saveTemporaryAverageToHistory(String subjectName) async {
    final prefs = await SharedPreferences.getInstance();
    final historyList = prefs.getStringList('temporaryAverageHistory') ?? [];
    historyList.add('$subjectName - $_temporaryAverage - $_classification');
    await prefs.setStringList('temporaryAverageHistory', historyList);
  }

  @override
  void dispose() {
    for (var controller in _regularScoreControllers) {
      controller.dispose();
    }
    _midTermScoreController.dispose();
    _finalScoreController.dispose();
    _subjectNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tính Điểm Trung Bình Môn'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _subjectNameController,
              decoration: const InputDecoration(
                labelText: 'Tên môn học',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Nhập các điểm thường xuyên:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _regularScoreControllers.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _regularScoreControllers[index],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Điểm thường xuyên ${index + 1}',
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle),
                        onPressed: () => _removeRegularScoreField(index),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _addRegularScoreField,
              child: const Text('Thêm điểm thường xuyên'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _midTermScoreController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Điểm giữa kỳ',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _finalScoreController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Điểm cuối kỳ',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateTemporaryAverage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: const Text('Tính Điểm Trung Bình'),
            ),
            const SizedBox(height: 16),
            Text('Điểm trung bình: ${_temporaryAverage.toStringAsFixed(2)}'),
            Text('Xếp loại: $_classification'),
          ],
        ),
      ),
    );
  }
}
