import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class NouveauPatient {
  NouveauPatient({
    this.nom,
    this.prenom,
    this.matricule,
    this.chambre,
    this.lit,
    this.carte,
  });

  String? nom;
  String? prenom;
  String? matricule;
  String? chambre;
  String? lit;
  String? carte;

  factory NouveauPatient.fromJson(Map<String, dynamic> json) => NouveauPatient(
        nom: json["nom"],
        prenom: json["prenom"],
        matricule: json["matricule"],
        chambre: json["chambre"],
        lit: json["lit"],
        carte: json["carte"],
      );

  Map<String, dynamic> toJson() => {
        "nom": nom,
        "prenom": prenom,
        "matricule": matricule,
        "chambre": chambre,
        "lit": lit,
        "carte": carte,
      };

  Future<void> createPatient(NouveauPatient nouveauPatient) async {
    try {
      await _firebaseFirestore
          .collection('new patient')
          .doc(nouveauPatient.matricule)
          .set(nouveauPatient.toJson());
    } catch (e) {
      print(e);
    }
  }

  affichageNouveauPatientTempsReel() {
    return _firebaseFirestore.collection('new patient').snapshots();
  }

  Future<NouveauPatient?> affichageNouveauPatient(String matricule) async {
    final doc = _firebaseFirestore.collection('new patient').doc(matricule);
    final snapshot = await doc.get();
    if (snapshot.exists) {
      return NouveauPatient.fromJson(snapshot.data()!);
    }
    return null;
  }
}

class NewPatientController {
  Future<void> createNewPatientController(
    String nom,
    String prenom,
    String matricule,
    String chambre,
    String lit,
    String carte,
  ) async {
    NouveauPatient nouveauPatient = NouveauPatient(
      nom: nom,
      prenom: prenom,
      matricule: matricule,
      chambre: chambre,
      lit: lit,
      carte: carte,
    );
    nouveauPatient.createPatient(nouveauPatient);
  }

  affichageNouveauPatientTempsReelController() {
    NouveauPatient nouveauPatient = NouveauPatient();
    return nouveauPatient.affichageNouveauPatientTempsReel();
  }

  Future<NouveauPatient?> affichageNouveauPatientController(
      String matricule) async {
    NouveauPatient nouveauPatient = NouveauPatient();
    return nouveauPatient.affichageNouveauPatient(matricule);
  }
}
