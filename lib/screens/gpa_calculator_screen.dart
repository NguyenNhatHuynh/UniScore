import 'package:flutter/material.dart';

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
  }

  double _convertToScale4(double score) {
    if (score >= 8.5) return 4.0;
    if (score >= 7.0) return 3.0;
    if (score >= 5.5) return 2.0;
    if (score >= 4.0) return 1.0;
    return 0.0;
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
              SizedBox(height: 16.0),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Danh sách môn học',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      if (_subjects.isEmpty)
                        Center(
                          child: Text(
                            'Chưa có môn học nào được thêm!',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                          ),
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _subjects.length,
                          separatorBuilder: (context, index) =>
                              Divider(height: 1.0),
                          itemBuilder: (context, index) {
                            final subject = _subjects[index];
                            return ListTile(
                              title: Text(subject['name']),
                              subtitle: Text(
                                  'Điểm: ${subject['score']} - Tín chỉ: ${subject['credits']}'),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    _subjects.removeAt(index);
                                    _calculateGPA();
                                  });
                                },
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kết quả GPA',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text('GPA (Thang 10): ${_gpa10.toStringAsFixed(2)}'),
                      Text('GPA (Thang 4): ${_gpa4.toStringAsFixed(2)}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
