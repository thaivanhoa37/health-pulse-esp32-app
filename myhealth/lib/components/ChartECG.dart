import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:oscilloscope/oscilloscope.dart';

class ChartECG extends StatefulWidget {
  const ChartECG({super.key});

  @override
  State<ChartECG> createState() => _ChartECGState();
}

class _ChartECGState extends State<ChartECG> {
  List<int> trace = [];
  Timer? _timer;
  final Future<FirebaseApp> fApp = Firebase.initializeApp();
  late DatabaseReference? dbref;
  var ecg;

  @override
  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child("1");
    dataChange();
    _timer = Timer.periodic(const Duration(milliseconds: 90), _generateTrace);
  }

  dataChange() {
    dbref?.onValue.listen((event) {
      ecg = event.snapshot.child("ecg").value;
      print("ECG FIREBASE = $ecg ");
      trace.add(ecg);
    });
  }

  _generateTrace(Timer t) {
    setState(() {
      //trace.add(ecg);
      //print("ECG CHART = $ecg ");
    });
  }

  @override
  Widget build(BuildContext context) {
    Oscilloscope scope = Oscilloscope(
      showYAxis: false,
      margin: const EdgeInsets.symmetric(vertical: 10),
      strokeWidth: 1,
      backgroundColor: Colors.white,
      traceColor: Colors.red.withOpacity(1),
      yAxisMax: 5000.0,
      yAxisMin: -3.0,
      dataSet: trace,
    );
    return Expanded(flex: 1, child: scope);
  }
}
