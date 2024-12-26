import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GPACalculatorScreen extends StatefulWidget {
  @override
  _GPACalculatorScreenState createState() => _GPACalculatorScreenState();
}

class _GPACalculatorScreenState extends State<GPACalculatorScreen> {
  final List<Map<String, dynamic>> _subjects = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();
  final TextEditingController _creditController = TextEditingController();

  double _gpa10 = 0.0;
  double _gpa4 = 0.0;

  List<String> _gpaHistory = [];

  @override
  void initState() {
    super.initState();
    _loadGPAHistory();
  }

  void _addSubject() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _subjects.add({
          'name': _subjectController.text,
          'score': double.parse(_scoreController.text),
          'credits': double.parse(_creditController.text),
        });
        _subjectController.clear();
        _scoreController.clear();
        _creditController.clear();
        _calculateGPA();
      });
    }
  }

  void _calculateGPA() {
    double totalCredits = 0.0;
    double totalPoints10 = 0.0;
    double totalPoints4 = 0.0;

    for (var subject in _subjects) {
      totalCredits += subject['credits'];
      totalPoints10 += subject['score'] * subject['credits'];
      totalPoints4 += _convertToScale4(subject['score']) * subject['credits'];
    }

    setState(() {
      _gpa10 = totalCredits > 0 ? totalPoints10 / totalCredits : 0.0;
      _gpa4 = totalCredits > 0 ? totalPoints4 / totalCredits : 0.0;
    });

    _saveGPAHistory();
  }

  double _convertToScale4(double score) {
    if (score >= 8.5) return 4.0;
    if (score >= 7.0) return 3.0;
    if (score >= 5.5) return 2.0;
    if (score >= 4.0) return 1.0;
    return 0.0;
  }

  // Save GPA history to local storage
  Future<void> _saveGPAHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final subjectName = _subjects.last['name'];
    final historyEntry = '$subjectName - GPA 10: $_gpa10, GPA 4: $_gpa4';

    setState(() {
      _gpaHistory.add(historyEntry);
    });
    prefs.setStringList('gpaHistory', _gpaHistory);
  }

  // Load GPA history from local storage
  Future<void> _loadGPAHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _gpaHistory = prefs.getStringList('gpaHistory') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tính điểm GPA'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          'Thêm Môn Học',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _subjectController,
                          decoration: InputDecoration(
                            labelText: 'Tên môn học',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.book),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập tên môn học';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _scoreController,
                          decoration: InputDecoration(
                            labelText: 'Điểm số (thang 10)',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.score),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập điểm số';
                            }
                            if (double.tryParse(value) == null ||
                                double.parse(value) < 0 ||
                                double.parse(value) > 10) {
                              return 'Điểm số phải trong khoảng 0 - 10';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _creditController,
                          decoration: InputDecoration(
                            labelText: 'Số tín chỉ',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.school),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập số tín chỉ';
                            }
                            if (double.tryParse(value) == null ||
                                double.parse(value) <= 0) {
                              return 'Số tín chỉ phải lớn hơn 0';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton.icon(
                          onPressed: _addSubject,
                          icon: Icon(Icons.add),
                          label: Text('Thêm môn học'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Điểm GPA:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              Text('GPA 10: $_gpa10', style: TextStyle(fontSize: 16.0)),
              Text('GPA 4: $_gpa4', style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 20),
              Text(
                'Lịch sử tính điểm:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              ..._gpaHistory.map((history) {
                return Card(
                  margin: EdgeInsets.only(top: 10),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      history,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
