import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const KalkulatorApp());
}

class KalkulatorApp extends StatelessWidget {
  const KalkulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "KALKULATOR BMI",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      home: const KalkulatorScreen(),
    );
  }
}

class KalkulatorScreen extends StatefulWidget {
  const KalkulatorScreen({super.key});

  @override
  State<KalkulatorScreen> createState() => _KalkulatorScreenState();
}

class _KalkulatorScreenState extends State<KalkulatorScreen> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  double? _bmiResult;
  String _bmiInterpretation = "Silakan masukkan data Anda!";
  String _gender = "Laki-laki";

  void _calculateBMI() {
    final double weight = double.tryParse(_weightController.text) ?? 0;
    final double heightInCM = double.tryParse(_heightController.text) ?? 0;

    if (weight <= 0 || heightInCM <= 0) {
      setState(() {
        _bmiResult = null;
        _bmiInterpretation = "Masukkan data yang valid!";
      });
      return;
    }

    final double heightInM = heightInCM / 100;
    final double bmi = weight / (heightInM * heightInM);

    setState(() {
      _bmiResult = bmi;

      if (_gender == "Laki-laki") {
        if (bmi < 18.5) {
          _bmiInterpretation = "Kekurangan berat badan";
        } else if (bmi < 25) {
          _bmiInterpretation = "Berat badan ideal";
        } else if (bmi < 30) {
          _bmiInterpretation = "Kelebihan berat badan";
        } else {
          _bmiInterpretation = "Obesitas";
        }
      } else {
        if (bmi < 18) {
          _bmiInterpretation = "Kekurangan berat badan";
        } else if (bmi < 24) {
          _bmiInterpretation = "Berat badan ideal";
        } else if (bmi < 29) {
          _bmiInterpretation = "Kelebihan berat badan";
        } else {
          _bmiInterpretation = "Obesitas";
        }
      }
    });
  }

  void _resetFields() {
    setState(() {
      _weightController.clear();
      _heightController.clear();
      _bmiResult = null;
      _bmiInterpretation = "Silakan masukkan data Anda!";
    });
  }

  Color _getBMIColor() {
    if (_bmiResult == null) return Colors.grey;
    if (_bmiResult! < 18.5) return Colors.pink[300]!;
    if (_bmiResult! < 25) return Colors.pinkAccent;
    if (_bmiResult! < 30) return Colors.deepOrangeAccent;
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFB6C1), Color(0xFFFF69B4)], // pink muda → pink terang
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "KALKULATOR BMI",
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Card input
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.shade200.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Pilih Jenis Kelamin",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Laki-laki
                          Row(
                            children: [
                              Radio<String>(
                                value: "Laki-laki",
                                groupValue: _gender,
                                activeColor: Colors.pinkAccent,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value!;
                                  });
                                },
                              ),
                              const Icon(Icons.male, color: Colors.blueGrey),
                              const SizedBox(width: 4),
                              const Text(
                                "Laki-laki",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          // Perempuan
                          Row(
                            children: [
                              Radio<String>(
                                value: "Perempuan",
                                groupValue: _gender,
                                activeColor: Colors.pinkAccent,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value!;
                                  });
                                },
                              ),
                              const Icon(Icons.female, color: Colors.pinkAccent),
                              const SizedBox(width: 4),
                              const Text(
                                "Perempuan",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _weightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Berat Badan (kg)",
                          prefixIcon:
                              const Icon(Icons.monitor_weight, color: Colors.pinkAccent),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.pinkAccent),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _heightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Tinggi Badan (cm)",
                          prefixIcon:
                              const Icon(Icons.height, color: Colors.pinkAccent),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.pinkAccent),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _calculateBMI,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            icon: const Icon(Icons.calculate, color: Colors.white),
                            label: const Text(
                              "Hitung",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: _resetFields,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.pinkAccent,
                              side: const BorderSide(color: Colors.pinkAccent),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            icon: const Icon(Icons.refresh),
                            label: const Text(
                              "Reset",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // Hasil BMI
                AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: _getBMIColor().withOpacity(0.5),
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "HASIL PERHITUNGAN",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _bmiResult != null
                            ? _bmiResult!.toStringAsFixed(1)
                            : "--",
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: _getBMIColor(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _bmiInterpretation,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "($_gender)",
                        style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}