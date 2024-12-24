import 'package:flutter/material.dart';

class TemporaryAverageScreen extends StatefulWidget {
  @override
  _TemporaryAverageScreenState createState() => _TemporaryAverageScreenState();
}

class _TemporaryAverageScreenState extends State<TemporaryAverageScreen> {
  final TextEditingController _regularScoreController = TextEditingController();
  final TextEditingController _midTermScoreController = TextEditingController();
  final TextEditingController _finalScoreController = TextEditingController();

  double _temporaryAverage = 0.0;
  String _classification = 'Chưa xác định';
  double _requiredForA = 0.0;
  double _requiredForBPlus = 0.0;
  double _requiredForB = 0.0;

  void _calculateTemporaryAverage() {
    final double regularScore =
        double.tryParse(_regularScoreController.text) ?? 0.0;
    final double midTermScore =
        double.tryParse(_midTermScoreController.text) ?? 0.0;
    final double finalScore =
        double.tryParse(_finalScoreController.text) ?? 0.0;

    // Constants for weighting
    const double regularWeight = 0.3;
    const double midTermWeight = 0.3;
    const double finalWeight = 0.4;

    if (regularScore > 10 || midTermScore > 10 || finalScore > 10) {
      // Alert if any score is greater than 10
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Điểm không được lớn hơn 10')));
      return;
    }

    setState(() {
      _temporaryAverage = (regularScore * regularWeight +
              midTermScore * midTermWeight +
              finalScore * finalWeight) /
          (regularWeight + midTermWeight + finalWeight);

      // Classifying
      if (regularScore < 4 || midTermScore < 4 || finalScore < 4) {
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

      // Required scores to achieve certain grades
      _requiredForA =
          (8.5 - regularScore * regularWeight - midTermScore * midTermWeight) /
              finalWeight;
      _requiredForBPlus =
          (8.0 - regularScore * regularWeight - midTermScore * midTermWeight) /
              finalWeight;
      _requiredForB =
          (7.0 - regularScore * regularWeight - midTermScore * midTermWeight) /
              finalWeight;
    });
  }

  @override
  void dispose() {
    _regularScoreController.dispose();
    _midTermScoreController.dispose();
    _finalScoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tính Điểm Trung Bình Tạm Thời'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nhập các điểm sau:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _regularScoreController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Điểm thường xuyên',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.check_circle),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _midTermScoreController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Điểm giữa kỳ',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.school),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _finalScoreController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Điểm cuối kỳ',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.grade),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculateTemporaryAverage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: const Text(
                'Tính Điểm Trung Bình',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  Text(
                    'Điểm trung bình: ${_temporaryAverage.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Xếp loại: $_classification',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Điểm cuối kỳ cần để đạt:',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Điểm A: ${_requiredForA.toStringAsFixed(1)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    'Điểm B+: ${_requiredForBPlus.toStringAsFixed(1)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    'Điểm B: ${_requiredForB.toStringAsFixed(1)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
