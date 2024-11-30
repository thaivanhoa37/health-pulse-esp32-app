import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:oscilloscope/oscilloscope.dart';

class ChartTemperature extends StatefulWidget {
  const ChartTemperature({super.key});

  @override
  State<ChartTemperature> createState() => _ChartTemperatureState();
}

class _ChartTemperatureState extends State<ChartTemperature> {
  List<int> trace = [];
  Timer? _timer;
  final Future<FirebaseApp> fApp = Firebase.initializeApp();
  late DatabaseReference? dbref;
  var Temperature;

  @override
  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child("1");
    dataChange();
    _timer = Timer.periodic(const Duration(milliseconds: 90), _generateTrace);
  }

  dataChange() {
    dbref?.onValue.listen((event) {
      Temperature = event.snapshot.child("temperature").value;
      trace.add(Temperature);
      print("TEMPERATURE FIREBASE= $Temperature");
    });
  }

  _generateTrace(Timer t) {
    setState(() {
      //trace.add(Temperature);
      print("TEMPERATURE CHART= $Temperature");
    });
  }

  @override
  Widget build(BuildContext context) {
    Oscilloscope scope = Oscilloscope(
      showYAxis: false,
      // yAxisColor: Colors.orange,
      margin: const EdgeInsets.symmetric(vertical: 10),
      strokeWidth: 1.5,
      backgroundColor: Colors.white,
      traceColor: Colors.red.withOpacity(1),
      yAxisMax: 50.0,
      yAxisMin: 30.0,
      dataSet: trace,
    );
    return Expanded(flex: 1, child: scope);
  }
}
