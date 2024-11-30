// import 'dart:async';
// import 'dart:ffi';
// import 'dart:math';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:oscilloscope/oscilloscope.dart';

// class ChartHeatRate extends StatefulWidget {
//   const ChartHeatRate({super.key});

//   @override
//   State<ChartHeatRate> createState() => _ChartHeatRateState();
// }

// class _ChartHeatRateState extends State<ChartHeatRate> {
//   List<num> trace = [];
//   Timer? _timer;
//   final Future<FirebaseApp> fApp = Firebase.initializeApp();
//   late DatabaseReference? dbref;
//   var heartRate;

//   List<double> traceSine = [];
//   double radians = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     dbref = FirebaseDatabase.instance.ref().child("1");
//     dataChange();
//     _timer = Timer.periodic(const Duration(milliseconds: 100), _generateTrace);
//   }

//   dataChange() {
//     dbref?.onValue.listen((event) {
//       heartRate = event.snapshot.child("heartRate").value;
//       print("HEARTRATE FIREBASE= $heartRate");
//       trace.add(heartRate);
//       print("TRACE= $trace");
//     });
//   }

//   _generateTrace(Timer t) {
//     setState(() {
//       print("SEEEEEEEET");
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Oscilloscope scope = Oscilloscope(
//       showYAxis: false,
//       yAxisColor: Colors.white,
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       strokeWidth: 1.5,
//       backgroundColor: Colors.white,
//       traceColor: Colors.red.withOpacity(1),
//       yAxisMax: 300,
//       yAxisMin: -10,
//       dataSet: trace,
//     );
//     return Expanded(flex: 1, child: scope);
//   }
// }
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartHeatRate extends StatefulWidget {
  const ChartHeatRate({super.key});

  @override
  State<ChartHeatRate> createState() => _ChartHeatRateState();
}

class _ChartHeatRateState extends State<ChartHeatRate> {
  List<num> trace = [];
  Timer? _timer;
  final Future<FirebaseApp> fApp = Firebase.initializeApp();
  late DatabaseReference? dbref;
  var heartRate;

  @override
  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child("1");
    dataChange();
    _timer = Timer.periodic(const Duration(milliseconds: 100), _generateTrace);
  }

  dataChange() {
    dbref?.onValue.listen((event) {
      heartRate = event.snapshot.child("heartRate").value;
      print("HEARTRATE FIREBASE= $heartRate");
      setState(() {
        trace.add(heartRate);
      });
      print("TRACE= $trace");
    });
  }

  _generateTrace(Timer t) {
    setState(() {
      // Dữ liệu mới có thể được cập nhật ở đây nếu cần
    });
  }

  @override
  Widget build(BuildContext context) {
    var colors = Colors;
    return Expanded(
      flex: 1,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: _generateStepPoints(trace),
              isCurved: false,
              barWidth: 2,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  // Tạo các điểm cho biểu đồ bước
  List<FlSpot> _generateStepPoints(List<num> trace) {
    List<FlSpot> spots = [];
    for (int i = 0; i < trace.length; i++) {
      if (i == 0) {
        spots.add(FlSpot(i.toDouble(), trace[i].toDouble()));
      } else {
        spots.add(FlSpot(i.toDouble(), trace[i].toDouble()));
        spots.add(FlSpot((i + 1).toDouble(), trace[i].toDouble()));
      }
    }
    return spots;
  }
}
