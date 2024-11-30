import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/pages/remove_forzado/widgets/custom_search_delegate.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/services/remove_forzado/list_service_remove.dart';

class HomePageRemove extends StatelessWidget {
  const HomePageRemove({super.key});

  @override
  Widget build(BuildContext context) {
    final ListServiceRemove _listServiceRemove = ListServiceRemove(ApiClient());
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Baja forzado',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                IconButton(
                    onPressed: () async {
                      await showSearch(
                          context: context, delegate: CustomSearchDelegate());
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
            Expanded(
              child: FutureBuilder<ModelListRemove>(
                  future: _listServiceRemove
                      .getDataByEndpoint(AppUrl.getListForzados),
                  builder: (BuildContext context,
                      AsyncSnapshot<ModelListRemove> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (snapshot.data!.data.isEmpty) {
                      return const Center(child: Text('No hay datos'));
                    }
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          return const Row(
                            children: [
                              SizedBox(width: 100, height: 100),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nombre: nombre',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Descripcion: descripcion',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              ),
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.arrow_right_alt))
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: snapshot.data!.data.length);
                  }),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.timer), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
      ]),
    );
  }
}
