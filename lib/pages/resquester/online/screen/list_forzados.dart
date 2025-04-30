// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:forzado/core/configs/theme/app_colors.dart';
import 'package:forzado/data/providers/forzados/forzados_provider.dart';
import 'package:forzado/models/forzado/model_forzado.dart';
import 'package:forzado/pages/resquester/online/screen/detail_forzado.dart';
import 'package:provider/provider.dart';

class ListForzadosRequesterLow extends StatefulWidget {
  const ListForzadosRequesterLow({super.key});

  @override
  State<ListForzadosRequesterLow> createState() =>
      _ListForzadosRequesterLowState();
}

class _ListForzadosRequesterLowState extends State<ListForzadosRequesterLow> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ForzadosProvider>(context, listen: false).getForzados();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitud Retiro de forzado'),
      ),
      body: Column(
        children: [
          // _customAppBar(context),
          Expanded(
            child: Container(
              // color: Colors.blue,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // _titleWidget(),
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
      margin: const EdgeInsets.only(bottom: 0),
      width: double.infinity,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Retiro forzado',
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

  // ignore: non_constant_identifier_names
  Widget _ListForzadosRequesterLow() {
    return Consumer<ForzadosProvider>(
      builder: (context, value, child) {
        // Mostrar error si existe un mensaje de error
        if (value.errorMessageGetForzados?.isEmpty == false) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value.errorMessageGetForzados!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: value.getForzados,
                  child: const Text(
                    'Reintentar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }

        // Mostrar mensaje si no hay forzados
        final forzadosEjecutados = value.forzados
            .where((element) =>
                element.estado?.toLowerCase() == 'ejecutado-forzado')
            .toList();

        if (forzadosEjecutados.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 30,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  'No hay solicitudes',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        // Mostrar lista de forzados ejecutados
        return ListView.builder(
          itemCount: forzadosEjecutados.length,
          itemBuilder: (context, index) {
            final f = forzadosEjecutados[index];
            return _cardForzado(f, context);
          },
        );
      },
    );
  }

  Widget _cardForzado(ForzadoItem forzado, BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue.shade100,
              child: Text(
                '${forzado.id}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ID: ${forzado.id}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Descripción
                  Text(
                    forzado.estado!.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                navigateDetailForzado(context, forzado);
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.blue,
                size: 20,
              ),
              splashRadius: 20,
            ),
          ],
        ),
      ),
    );
  }

  void navigateDetailForzado(BuildContext context, ForzadoItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsForzadorRequester(
          detailForzado: item,
        ),
      ),
    );
  }
}
