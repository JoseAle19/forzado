import 'package:flutter/material.dart';
import 'package:forzado/core/configs/theme/app_colors.dart';
import 'package:forzado/data/providers/forzados/forzados_provider.dart';
import 'package:forzado/models/forzado/model_forzado.dart';
import 'package:forzado/pages/resquester/online/screen/detail_forzado.dart';
import 'package:provider/provider.dart';

class ListForzadosRequesterLow extends StatelessWidget {
  const ListForzadosRequesterLow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _customAppBar(context),
          Expanded(
            child: Container(
              // color: Colors.blue,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  _titleWidget(),
                  Expanded(
                    child: _futureListForzadosRequesterLow(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Baja forzado',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Lista de forzados ejecutados',
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _customAppBar(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 35),
        alignment: Alignment.topLeft,
        width: double.infinity,
        // margin: const EdgeInsets.all(10),
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)));
  }

  Widget _futureListForzadosRequesterLow() {
    return Consumer<ForzadosProvider>(builder: (context, value, child) {
      return value.loadingGetForzados
          ? const Center(child: CircularProgressIndicator())
          : _ListForzadosRequesterLow();
    });
  }

  Widget _ListForzadosRequesterLow() {
    return Consumer<ForzadosProvider>(
        builder: (context, ForzadosProvider value, child) {
      if (value.errorMessageGetForzados!.isNotEmpty) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value.errorMessageGetForzados!,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              onPressed: () {
                value.getForzados();
              },
              child: const Text(
                'Reintentar',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ));
      }
      if (value.forzados.isEmpty) {
        return const Center(
          child: Text('No hay forzados ejecutados'),
        );
      }
      return ListView.builder(
        itemCount: value.forzados
            .where(
                (element) => element.estado!.toLowerCase() == 'ejecutado-alta')
            .length,
        itemBuilder: (context, index) {
          final f = value.forzados
              .where((element) =>
                  element.estado!.toLowerCase() == 'ejecutado-alta')
              .elementAt(index);
          return _cardForzado(f, context);
        },
      );
    });
  }

  Widget _cardForzado(ForzadoItem f, BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(106, 28, 50, 97),
            spreadRadius: 0.0,
            blurRadius: 5.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        // Colocar id del forzado
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Center(
              child: Text(
            '12',
            style: TextStyle(color: Colors.white),
          )),
        ),
        title: Text(
          f.descripcion ?? 'No especificado',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          f.area.toString(),
          style: const TextStyle(fontSize: 12),
        ),
        trailing: GestureDetector(
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailsForzadorRequester(detailForzado: f),
                  ),
                ),
            child: const Icon(Icons.arrow_forward_ios)),
      ),
    );
  }
}
