import 'package:flutter/material.dart';
import 'package:forzado/pages/steps_form/steps.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CustomBotttomNavigation(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Hola Jose!',
            style: TextStyle(fontFamily: 'noto', fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text('Nueva solicitud de IPERC'),
              subtitle: const Text(
                  'Crea una nueva solicitud de IPERC para una tarea específica'),
              leading: const Icon(
                Icons.note_add_rounded,
                color: Colors.green,
              ),
              onTap: () {
                final route = MaterialPageRoute(builder: (_) => const Steps());

                Navigator.push(context, route);
              },
            ),
            ListTile(
              title: Text('Baja solicitud de IPERC'),
              subtitle: const Text(
                  'Eliminar una solicitud de IPERC para una tarea específica'),
              leading: const Icon(
                Icons.cleaning_services_sharp,
                color: Colors.red,
              ),
              onTap: () {
                // Navigator.pushNamed(context, '/steps');
              },
            )
          ],
        ));
  }
}

class CustomBotttomNavigation extends StatelessWidget {
  const CustomBotttomNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
      BottomNavigationBarItem(
          icon: Icon(Icons.settings), label: 'Configuración'),
    ]);
  }
}
