import 'package:flutter/material.dart';
import 'package:vetapp/services/firebase.dart';

class ConsultarCitaPage extends StatelessWidget {
  const ConsultarCitaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _firebaseService = FirebaseService();

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Text("Hola"),
            ElevatedButton(
              onPressed: (){
                _firebaseService.consultarCitas();
              }, 
              child: const Text("Consultar")
            )
          ],
        ),
      ),
    );
  }
}