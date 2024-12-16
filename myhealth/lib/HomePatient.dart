// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:myhealth/Nouveau.dart';
// import 'package:myhealth/controller/patient_controller.dart';
// import 'components/UnPatient.dart';

// class HomePatient extends StatefulWidget {
//   const HomePatient({super.key});

//   @override
//   State<HomePatient> createState() => _HomePatientState();
// }

// class _HomePatientState extends State<HomePatient> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffE3DFDF),
//       body: Stack(
//         children: [
//           SvgPicture.asset(
//             "assets/images/bg.svg",
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SizedBox(height: 130),
//               Text(
//                 "Hospitalized patients",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     color: Color(0xFF000000).withOpacity(0.8),
//                     fontStyle: FontStyle.italic,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20),
//               ),
//               SizedBox(height: 30),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 18),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(32),
//                   color: Color(0xffD2CECE),
//                 ),
//                 height: 520,
//                 child: Column(
//                   children: [
//                     Container(
//                         margin:
//                             EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                         height: 460,
//                         width: 340,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(32),
//                         ),
//                         child: StreamBuilder(
//                           stream: NewPatientController()
//                               .affichageNouveauPatientTempsReelController(),
//                           builder: (context, snapshots) {
//                             if (snapshots.hasError) {
//                               return Center(
//                                   child: Text(snapshots.error.toString()));
//                             }
//                             if (!snapshots.hasData) {
//                               return Center(child: CircularProgressIndicator());
//                             }
//                             QuerySnapshot data =
//                                 snapshots.requireData as QuerySnapshot;

//                             return GridView.builder(
//                               gridDelegate:
//                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                 childAspectRatio: 1,
//                                 crossAxisCount: 2,
//                                 crossAxisSpacing: 6,
//                                 mainAxisSpacing: 6,
//                               ),
//                               itemBuilder: (BuildContext context, int index) {
//                                 return UnPatient(
//                                   matricule: data.docs[index].id,
//                                   nom: data.docs[index]["nom"],
//                                   prenom: data.docs[index]["prenom"],
//                                   chambre: data.docs[index]["chambre"],
//                                   lit: data.docs[index]["lit"],
//                                   carte: data.docs[index]["carte"],
//                                 );
//                               },
//                               itemCount: data.size,
//                             );
//                           },
//                         )),
//                     Row(
//                       children: [
//                         SizedBox(width: 10),
//                         Text(
//                           "Add a new patient ",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               color: Color(0xFF000000).withOpacity(0.8),
//                               fontStyle: FontStyle.normal,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18),
//                         ),
//                         Spacer(),
//                         IconButton(
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 CupertinoPageRoute(
//                                     builder: (contex) => Nouveau()));
//                           },
//                           icon: Icon(
//                             CupertinoIcons.add_circled,
//                             color: Color(0xFF000000).withOpacity(0.8),
//                             size: 30,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myhealth/Nouveau.dart';
import 'package:myhealth/controller/patient_controller.dart';
import 'components/UnPatient.dart';

class HomePatient extends StatefulWidget {
  const HomePatient({super.key});

  @override
  State<HomePatient> createState() => _HomePatientState();
}

class _HomePatientState extends State<HomePatient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE3DFDF),
      body: Stack(
        children: [
          SvgPicture.asset(
            "assets/images/bg.svg",
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              Text(
                "List patients",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: const Color(0xFF000000).withOpacity(0.8),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: const Color(0xffD2CECE),
                ),
                height: 520,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: StreamBuilder(
                          stream: NewPatientController()
                              .affichageNouveauPatientTempsReelController(),
                          builder: (context, snapshots) {
                            if (snapshots.hasError) {
                              return Center(
                                  child: Text(snapshots.error.toString()));
                            }
                            if (!snapshots.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            QuerySnapshot data =
                                snapshots.requireData as QuerySnapshot;
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1,
                                crossAxisCount: 2,
                                crossAxisSpacing: 6,
                                mainAxisSpacing: 6,
                              ),
                              itemCount: data.size,
                              itemBuilder: (BuildContext context, int index) {
                                return UnPatient(
                                  matricule: data.docs[index].id,
                                  nom: data.docs[index]["nom"],
                                  prenom: data.docs[index]["prenom"],
                                  chambre: data.docs[index]["chambre"],
                                  lit: data.docs[index]["lit"],
                                  carte: data.docs[index]["carte"],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Text(
                          "Add a new patient ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: const Color(0xFF000000).withOpacity(0.8),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (contex) => const Nouveau()));
                          },
                          icon: Icon(
                            CupertinoIcons.add_circled,
                            color: const Color(0xFF000000).withOpacity(0.8),
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
