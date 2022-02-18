import 'package:flutter/material.dart';
import 'package:vetapp/models/cita_model.dart';
import 'package:vetapp/services/firebase.dart';

class ConsultarCitaPage extends StatefulWidget {
  const ConsultarCitaPage({Key? key}) : super(key: key);

  @override
  State<ConsultarCitaPage> createState() => _ConsultarCitaPageState();
}

class _ConsultarCitaPageState extends State<ConsultarCitaPage> {

  List<Cita?>? citas;

  @override
  void initState() {
    _obtenerCitas();
    super.initState();
  }

  void _obtenerCitas () async {
    final _firebaseService = FirebaseService.fb;
    citas = await _firebaseService.consultarCitas();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: citas == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
            shrinkWrap: true,
            itemCount: citas?.length,
            itemBuilder: (BuildContext context, int index){

              final cita = citas?[index];

              return(
                InkWell(
                  child: Row(
                    children: [
                      Text(cita!.correo),
                      Text(cita.nombre)
                    ],
                  ),
                )
              );
            },
          )
      ),
    );
  }
}