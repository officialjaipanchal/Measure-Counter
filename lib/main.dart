import 'package:flutter/material.dart';

void main() {
  runApp(MeasureConverterApp());
}

// Main application widget
class MeasureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white, // Set title color to white
            fontSize: 20.0, // Set font size for title

          ),
        ),
      ),
      home: MeasureConverterScreen(),
    );
  }
}

// Stateful widget for the Measure Converter screen
class MeasureConverterScreen extends StatefulWidget {
  @override
  _MeasureConverterScreenState createState() => _MeasureConverterScreenState();
}

class _MeasureConverterScreenState extends State<MeasureConverterScreen> {
  // Controller to get the input value
  final TextEditingController _controller = TextEditingController();

  // Default units for conversion
  String _fromUnit = 'meters';
  String _toUnit = 'feet';

  // Variable to store the conversion result
  double _result = 0.0;

  // Map to define available units and their conversion rates (all relative to meters)
  final Map<String, double> _conversionRates = {
    'meters': 1.0,
    'feet': 3.28084,
    'inches': 39.3701,
    'kilometers': 0.001,
  };

  // Method to perform conversion based on selected units and input value
  void _convert() {
    // Parse the input value, default to 0 if parsing fails
    double value = double.tryParse(_controller.text) ?? 0.0;

    // Get the conversion rate for the selected units
    double fromRate = _conversionRates[_fromUnit]!;
    double toRate = _conversionRates[_toUnit]!;

    // Calculate the result and update the state
    setState(() {
      _result = (value * toRate) / fromRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold to create the basic structure of the app
      appBar: AppBar(
        title: Center(child: Text('Measures Converter')), // Centering the title text
        backgroundColor: Colors.blue, // Setting background color to blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Value',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter value to convert',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'From',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            DropdownButtonFormField<String>(
              value: _fromUnit,
              isExpanded: true, // Makes the arrow appear at the end
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.blue), // Setting dropdown text color to blue
              items: _conversionRates.keys.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _fromUnit = newValue!;
                });
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'To',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            DropdownButtonFormField<String>(
              value: _toUnit,
              isExpanded: true, // Makes the arrow appear at the end
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.blue), // Setting dropdown text color to blue
              items: _conversionRates.keys.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _toUnit = newValue!;
                });
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20.0),
            // Centering the result text with TextAlign.center
            Text(
              '${_controller.text} $_fromUnit are $_result $_toUnit',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center, // Aligning text to the center
            ),
          ],
        ),
      ),
    );
  }
}
