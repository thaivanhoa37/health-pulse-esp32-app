import 'package:flutter/material.dart';

class IncidentJour extends StatefulWidget {
  final String date;
  final String pic;

  final String valeur;
  const IncidentJour({
    Key? key,
    required this.date,
    required this.pic,
    required this.valeur,
  }) : super(key: key);

  @override
  _IncidentJourState createState() => _IncidentJourState();
}

class _IncidentJourState extends State<IncidentJour> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Row(
          children: [
            Text(
              "${widget.date}:",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: const Color(0xFF000000).withOpacity(0.8),
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  fontSize: 16),
            ),
            const Spacer(),
            Text(
              widget.pic,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: const Color(0xFF000000).withOpacity(0.8),
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  fontSize: 16),
            ),
            const Spacer(),
            Text(
              "(${widget.valeur})",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: const Color(0xFF000000).withOpacity(0.8),
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
