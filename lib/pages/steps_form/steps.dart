import 'package:flutter/material.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/services/center_service.dart';
import 'package:forzado/widgets/custom_ropdown_button.dart';

class Steps extends StatefulWidget {
  const Steps({super.key});

  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  int currentStep = 0;

  final CenterService centerService = new CenterService(ApiClient());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text(
            'IPERC',
            style: TextStyle(fontFamily: 'noto'),
          ),
        ),
        body: PageView(
          scrollDirection: Axis.horizontal,
          children: [
            TabOne(
              centerService: centerService,
            ),
            TabTwo(
              centerService: centerService,
            ),
            TabThree(
              centerService: centerService,
            ),
          ],
        ));
  }
}

class TabOne extends StatelessWidget {
  const TabOne({super.key, this.centerService});
  final centerService;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Tag y Subfijo',
                style: TextStyle(
                    fontSize: 18, fontFamily: 'noto', color: Color(0xff0F2851)),
              ),
            ),
            // DropDown Buttons
            CustomDropDownButton(
              service: centerService,
              hintText: 'Prefijo del Tag o Sub Área',
              descriptionField: 'Tag (Prefijo)*',
            ),
            CustomDropDownButton(
              service: centerService,
              hintText: 'Parte Central  del Tag Asoc. al instrumento o Equipo',
              descriptionField: 'Tag (Centro) *',
            ),

            CustomDropDownButton(
              service: centerService,
              hintText: 'SubFijo del Tag',
              descriptionField: 'Tag (Sub Fijo) *',
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Text('Descripción *'),
                TextFormField(
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Agregar descripción',
                  ),
                ),
              ],
            ),

            CustomDropDownButton(
              service: centerService,
              hintText: 'Disciplina que solicita el Forzado',
              descriptionField: 'Disciplina *',
            ),

            CustomDropDownButton(
              service: centerService,
              hintText: 'Disciplina que solicita el Forzado',
              descriptionField: 'Turno *',
            ),

            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color(0xff009283),
                  borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: const Text(
                'Continuar',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'noto',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabTwo extends StatelessWidget {
  const TabTwo({super.key, this.centerService});
  final centerService;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Responsable y riesgo',
                style: TextStyle(
                    fontSize: 18, fontFamily: 'noto', color: Color(0xff0F2851)),
              ),
            ),
            // DropDown Buttons
            CustomDropDownButton(
              service: centerService,
              descriptionField: 'Interlock Seguridad*',
              hintText: 'Seleccion Interlock',
            ),
            CustomDropDownButton(
              service: centerService,
              descriptionField: 'Responsable*',
              hintText: 'Seleccione Gerencia Responsable del Forzado',
            ),

            CustomDropDownButton(
              service: centerService,
              descriptionField: 'Riesgo A*',
              hintText: 'Riesgo',
            ),

            CustomDropDownButton(
              service: centerService,
              descriptionField: 'Probabilidad*',
              hintText: 'Categoria de Consecuencias',
            ),

            CustomDropDownButton(
              service: centerService,
              descriptionField: 'Impacto*',
              hintText: 'Seleccione Impacto de la Secuencia',
            ),
            CustomDropDownButton(
              service: centerService,
              descriptionField: 'Riesgo*',
              hintText: 'Riesgo',
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color(0xff009283),
                  borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: const Text(
                'Continuar',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'noto',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabThree extends StatelessWidget {
  const TabThree({super.key, this.centerService});
  final centerService;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Autorización',
                style: TextStyle(
                    fontSize: 18, fontFamily: 'noto', color: Color(0xff0F2851)),
              ),
            ),
            // DropDown Buttons
            CustomDropDownButton(
              service: centerService,
              descriptionField: 'Solicitante (AN) *',
              hintText: 'Seleccione Solicitante del Forzado',
            ),
            CustomDropDownButton(
              service: centerService,
              descriptionField: 'Aprobador *',
              hintText: 'Seleccione Aprobador del Forzado',
            ),

            CustomDropDownButton(
              service: centerService,
              descriptionField: 'Ejecutor *',
              hintText: 'Seleccione Ejecutor',
            ),

            CustomDropDownButton(
              service: centerService,
              descriptionField: 'Autorización *',
              hintText: 'Carlos Meneses Garcia',
            ),

            CustomDropDownButton(
              service: centerService,
              descriptionField: 'Tipo de Forzado*',
              hintText: 'Seleccione Tipo de Forzado',
            ),

            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color(0xff21378C),
                  borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: const Text(
                'Finalizar',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'noto',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
