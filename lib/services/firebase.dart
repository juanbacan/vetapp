
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vetapp/models/cita_model.dart';

class FirebaseService {
    CollectionReference citas = FirebaseFirestore.instance.collection('citas');

    Future <String> addCita(Cita citaSave) async{
      try {
        DocumentReference cita = await citas.add({
            "correo": citaSave.correo,
            "nombre": citaSave.nombre,
            "fecha": citaSave.dia,
            "hora": citaSave.hora,
            "completado": citaSave.completado
          }
        );
        return cita.id;
      } catch (e) {
        return "Error";
      }
    }

    Future <void> consultarCitas() async{
      try {
        QuerySnapshot<Object?> citasResult = await citas.get();
        print(citasResult.docs);
      } catch (e) {
        print(e);
      }
    }

}