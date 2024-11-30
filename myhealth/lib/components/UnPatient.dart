// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:myhealth/Home.dart';

// class UnPatient extends StatefulWidget {
//   final String matricule;
//   final String nom;
//   final String prenom;
//   final String chambre;
//   final String lit;
//   final String carte;

//   const UnPatient(
//       {super.key,
//       required this.matricule,
//       required this.nom,
//       required this.prenom,
//       required this.chambre,
//       required this.lit,
//       required this.carte});

//   @override
//   State<UnPatient> createState() => _UnPatientState();
// }

// class _UnPatientState extends State<UnPatient> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(30),
//         color: const Color(0xffffffff),
//       ),
//       height: 150,
//       width: 150,
//       child: InkWell(
//         child: Container(
//           child: Column(
//             children: [
//               Container(
//                 margin:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 child: SvgPicture.asset(
//                   "assets/images/Patient.svg",
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Text(
//                   "${widget.nom} ${widget.prenom}",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color: const Color(0xFF000000).withOpacity(0.8),
//                       fontStyle: FontStyle.normal,
//                       fontWeight: FontWeight.normal,
//                       fontSize: 20),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "ch: ${widget.chambre}",
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                         color: const Color(0xFF000000).withOpacity(0.8),
//                         fontStyle: FontStyle.normal,
//                         fontWeight: FontWeight.normal,
//                         fontSize: 20),
//                   ),
//                   const SizedBox(width: 10),
//                   Text(
//                     "Lit: ${widget.lit}",
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                         color: const Color(0xFF000000).withOpacity(0.8),
//                         fontStyle: FontStyle.normal,
//                         fontWeight: FontWeight.normal,
//                         fontSize: 20),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//         onTap: () {
//           Navigator.push(
//               context,
//               CupertinoPageRoute(
//                   builder: (contex) => Home(matricule: widget.matricule)));
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myhealth/Home.dart';

class UnPatient extends StatefulWidget {
  final String matricule;
  final String nom;
  final String prenom;
  final String chambre;
  final String lit;
  final String carte;

  const UnPatient(
      {super.key,
      required this.matricule,
      required this.nom,
      required this.prenom,
      required this.chambre,
      required this.lit,
      required this.carte});

  @override
  State<UnPatient> createState() => _UnPatientState();
}

class _UnPatientState extends State<UnPatient> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xffffffff),
      ),
      height: 150,
      width: 150,
      child: InkWell(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SvgPicture.asset(
                  "assets/images/Patient.svg",
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "${widget.nom} ${widget.prenom}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: const Color(0xFF000000).withOpacity(0.8),
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "room: ${widget.chambre}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: const Color(0xFF000000).withOpacity(0.8),
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    "Bed: ${widget.lit}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: const Color(0xFF000000).withOpacity(0.8),
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ],
              ),
            )
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (contex) => Home(matricule: widget.matricule)));
        },
      ),
    );
  }
}
