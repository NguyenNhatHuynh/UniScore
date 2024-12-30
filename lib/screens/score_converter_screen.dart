import 'package:flutter/material.dart';

class ScoreConverterScreen extends StatefulWidget {
  @override
  _ScoreConverterScreenState createState() => _ScoreConverterScreenState();
}

class _ScoreConverterScreenState extends State<ScoreConverterScreen> {
  String _selectedScale = '4'; // Default to scale 4
  TextEditingController _scoreController = TextEditingController();
  String _convertedScore = '';

  void _convertScore() {
    final inputScore = double.tryParse(_scoreController.text);

    if (inputScore == null) {
      setState(() {
        _convertedScore = 'Vui lòng nhập điểm hợp lệ!';
      });
      return;
    }

    double result;
    if (_selectedScale == '4') {
      result = (inputScore / 10) * 4;
      setState(() {
        _convertedScore = 'Điểm hệ 4: ${result.toStringAsFixed(2)}';
      });
    } else {
      result = (inputScore / 4) * 10;
      setState(() {
        _convertedScore = 'Điểm hệ 10: ${result.toStringAsFixed(2)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chuyển đổi hệ điểm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Chọn hệ điểm',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Hệ 4'),
                    leading: Radio<String>(
                      value: '4',
                      groupValue: _selectedScale,
                      onChanged: (value) {
                        setState(() {
                          _selectedScale = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Hệ 10'),
                    leading: Radio<String>(
                      value: '10',
                      groupValue: _selectedScale,
                      onChanged: (value) {
                        setState(() {
                          _selectedScale = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _scoreController,
              decoration: InputDecoration(
                labelText: 'Nhập điểm cần chuyển đổi',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convertScore,
              child: Text('Chuyển đổi'),
            ),
            SizedBox(height: 16),
            Text(
              _convertedScore,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
