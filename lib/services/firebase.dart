
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vetapp/models/admin_model.dart';
import 'package:vetapp/models/cita_model.dart';

class FirebaseService {

  static final FirebaseService fb = FirebaseService._();
  FirebaseService._();

  static CollectionReference<Cita>? _citas;
  static CollectionReference<Admin>? _admins;

  CollectionReference<Cita> get citas {
    if ( _citas != null ) return _citas!;

    _citas = FirebaseFirestore.instance.collection('citas').withConverter<Cita>(
      fromFirestore: (snapshot, _) => Cita.fromJson(snapshot.data()!), 
      toFirestore: (cita, _) => cita.toJson(),
    );
    return _citas!;
  }

  CollectionReference<Admin> get admins {
    if ( _admins != null ) return _admins!;

    _admins = FirebaseFirestore.instance.collection('admins').withConverter<Admin>(
      fromFirestore: (snapshot, _) => Admin.fromJson(snapshot.data()!), 
      toFirestore: (admin, _) => admin.toJson(),
    );
    return _admins!;
  }

  Future <bool> getAdmin(String userId) async{
    try {
      DocumentSnapshot<Admin> usuarioAdmin = await admins.doc(userId).get();
      if (usuarioAdmin.exists) return(true);
      return false;
    } catch (e) { 
      return false;
    }
  }

  Future <String> addCita(Cita citaSave) async{
    try {
      DocumentReference cita = await citas.add(citaSave);
      return cita.id;
    } catch (e) {
      
      return "Error"; 
    }
  }

  Future <List<Cita?>> consultarCitas() async{
    try {
      QuerySnapshot<Cita?> citasResult = await citas.get();
      List<Cita?> listCitas = citasResult.docs.map((doc) => doc.data()).toList();
      return listCitas;

    } catch (e) {
      return [];
    }
  }

  Future <Cita?> consultarCita(String id) async {
    try {
      DocumentSnapshot<Cita> citaResult =  await citas.doc(id).get();
      return citaResult.data();
    } catch (e) {
      return null;
    }
  }
}