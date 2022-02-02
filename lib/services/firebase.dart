
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vetapp/models/cita_model.dart';

class FirebaseService {

  static final FirebaseService fb = FirebaseService._();
  FirebaseService._();

  static CollectionReference<Cita>? _citas;

  CollectionReference<Cita> get citas {
    if ( _citas != null ) return _citas!;

    _citas = FirebaseFirestore.instance.collection('citas').withConverter<Cita>(
      fromFirestore: (snapshot, _) => Cita.fromJson(snapshot.data()!), 
      toFirestore: (cita, _) => cita.toJson(),
    );
    return _citas!;
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