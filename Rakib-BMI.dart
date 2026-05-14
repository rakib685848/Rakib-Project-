import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BMIScreen(),
    );
  }
}

class BMIScreen extends StatefulWidget {
  @override
  _BMIScreenState createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final TextEditingController weightController = TextEditingController();

  // Height in feet and inch
  final TextEditingController feetController = TextEditingController();
  final TextEditingController inchController = TextEditingController();

  double bmi = 0;
  String result = "";

  void calculateBMI() {
    double weight = double.tryParse(weightController.text) ?? 0;
    double feet = double.tryParse(feetController.text) ?? 0;
    double inch = double.tryParse(inchController.text) ?? 0;

    if (weight > 0 && (feet > 0 || inch > 0)) {
      // Convert feet + inch to meter
      double totalInches = (feet * 12) + inch;
      double heightInMeter = totalInches * 0.0254;

      bmi = weight / (heightInMeter * heightInMeter);

      if (bmi < 18.5) {
        result = "Underweight";
      } else if (bmi < 24.9) {
        result = "Normal";
      } else if (bmi < 29.9) {
        result = "Overweight";
      } else {
        result = "Obese";
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Weight
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Weight (kg)",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            // Feet
            TextField(
              controller: feetController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Height (Feet)",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            // Inch
            TextField(
              controller: inchController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Height (Inch)",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: calculateBMI,
              child: Text("Calculate BMI"),
            ),

            SizedBox(height: 30),

            Text(
              bmi == 0 ? "" : "Your BMI: ${bmi.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              result,
              style: TextStyle(
                fontSize: 22,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}