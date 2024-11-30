import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myhealth/HomePatient.dart';
import 'package:myhealth/controller/patient_controller.dart';

TextEditingController _nom = TextEditingController();
TextEditingController _prenom = TextEditingController();
TextEditingController _matricule = TextEditingController();
TextEditingController _chambre = TextEditingController();
TextEditingController _lit = TextEditingController();
TextEditingController _carte = TextEditingController();

NewPatientController newPatientController = NewPatientController();

class Nouveau extends StatefulWidget {
  const Nouveau({super.key});

  @override
  State<Nouveau> createState() => _NouveauState();
}

class _NouveauState extends State<Nouveau> {
  final _PatientKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffE3DFDF),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SvgPicture.asset(
                "assets/images/bg.svg",
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(CupertinoIcons.arrow_left)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Medical Record",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color(0xFF000000).withOpacity(0.8),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "New Patient",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color(0xFF000000).withOpacity(0.8),
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                        fontSize: 18),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Form(
                        key: _PatientKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nom,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                hintText: "Lastname",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter the lastname';
                                }
                                if (!RegExp(
                                        r'^[a-zA-ZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿĀāĂăĄąĆćĈĉĊċČčĎďĐđĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħĨĩĪīĬĭĮįİıĲĳĴĵĶķĸĹĺĻļĽľĿŀŁłŃńŅņŇňŉŌōŎŏŐőŒœŔŕŖŗŘřŚśŜŝŞşŠšŢţŤťŦŧŨũŪūŬŭŮůŰűŲųŴŵŶŷŸŹźŻżŽžƠơƯưẮắẰằẲẳẴẵẶặẤấẦầẨẩẪẫẬậẺẻẼẽẾếỀềỂểỄễỆệỈỉỊịỌọỎỏỐốỒồỔổỖỗỘộỚớỜờỞởỠỡỢợỤụỦủỨứỪừỬửỮữỰự ]+$')
                                    .hasMatch(value)) {
                                  return 'Invalid lastname';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _prenom,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                hintText: "Firstname",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter the firstname';
                                }
                                if (!RegExp(
                                        r'^[a-zA-ZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿĀāĂăĄąĆćĈĉĊċČčĎďĐđĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħĨĩĪīĬĭĮįİıĲĳĴĵĶķĸĹĺĻļĽľĿŀŁłŃńŅņŇňŉŌōŎŏŐőŒœŔŕŖŗŘřŚśŜŝŞşŠšŢţŤťŦŧŨũŪūŬŭŮůŰűŲųŴŵŶŷŸŹźŻżŽžƠơƯưẮắẰằẲẳẴẵẶặẤấẦầẨẩẪẫẬậẺẻẼẽẾếỀềỂểỄễỆệỈỉỊịỌọỎỏỐốỒồỔổỖỗỘộỚớỜờỞởỠỡỢợỤụỦủỨứỪừỬửỮữỰự ]+$')
                                    .hasMatch(value)) {
                                  return 'Invalid firstname';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _matricule,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                hintText: "Id Number",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter the Id Number';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _chambre,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      hintStyle:
                                          TextStyle(color: Colors.grey[600]),
                                      hintText: "Room",
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter the room number';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: TextFormField(
                                    controller: _lit,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      hintStyle:
                                          TextStyle(color: Colors.grey[600]),
                                      hintText: "Bed",
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter the bed number';
                                      }
                                      if (!RegExp(r'^[0-9 ]+$')
                                          .hasMatch(value)) {
                                        return 'Invalid bed number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: TextFormField(
                                    controller: _carte,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      hintStyle:
                                          TextStyle(color: Colors.grey[600]),
                                      hintText: "Card",
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter the card number';
                                      }
                                      if (!RegExp(r'^[0-9 ]+$')
                                          .hasMatch(value)) {
                                        return 'Invalid card number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                const SizedBox(width: 20),
                                Expanded(
                                  child: CupertinoButton(
                                    color: const Color(0xFF0094FF)
                                        .withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(50),
                                    onPressed: () async {
                                      if (_PatientKey.currentState!
                                          .validate()) {
                                        newPatientController
                                            .createNewPatientController(
                                                _nom.text,
                                                _prenom.text,
                                                _matricule.text,
                                                _chambre.text,
                                                _lit.text,
                                                _carte.text)
                                            .then((value) => Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (contex) =>
                                                        const HomePatient())));
                                      } else {
                                        print("failed");
                                      }
                                    },
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Color(0xFFFFFDFD)
                                              .withOpacity(0.8)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
