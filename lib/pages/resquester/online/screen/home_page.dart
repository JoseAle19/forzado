import 'package:flutter/material.dart';
import 'package:forzado/data/providers/forzados/forzados_provider.dart';
import 'package:forzado/models/forzado/model_forzado.dart';
import 'package:forzado/pages/resquester/online/widgets/custom_search_delegate.dart';
import 'package:forzado/pages/resquester/online/widgets/list_forzado.dart';
import 'package:provider/provider.dart';

class HomePageRemove extends StatefulWidget {
  const HomePageRemove({super.key});

  @override
  State<HomePageRemove> createState() => _HomePageRemoveState();
}

class _HomePageRemoveState extends State<HomePageRemove> {
  late List<ForzadoItem> listData;

  @override
  Widget build(BuildContext context) {
      final providerForzados = Provider.of<ForzadosProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await showSearch(
                context: context,
                delegate: listData.isEmpty
                    ? CustomSearchDelegate(searchList: [])
                    : CustomSearchDelegate(searchList: listData),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Forzados - ejecutado alta ',
          style: TextStyle(fontFamily: 'noto', fontSize: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<List<ForzadoItem>>(
          future: providerForzados.getForzados('solicitante'),
          builder: (BuildContext context,
              AsyncSnapshot<List<ForzadoItem>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              // Manejando errores si el Future falla
              String errorMessage = snapshot.error.toString();
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 50),
                  const SizedBox(height: 10),
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Reintentar'),
                  ),
                ],
              );
            } else if (snapshot.hasData && snapshot.data != null) {
             
              return const Expanded(
                child: ListForzado(),
              );
            } else {
              // Caso en que no hay datos disponibles
              return const Center(
                child: Text(
                  "No hay forzados disponibles.",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
