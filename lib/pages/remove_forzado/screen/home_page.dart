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
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'IPERC',
          style: TextStyle(fontFamily: 'noto'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<ModelListRemove>(
          future: _listServiceRemove.getDataByEndpoint(AppUrl.getListForzados),
          builder:
              (BuildContext context, AsyncSnapshot<ModelListRemove> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.data!.data.isEmpty) {
              return const Center(child: Text('No hay datos'));
            }

            final List<Datum> data = snapshot.data!.data;

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Baja forzado',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await showSearch(
                          context: context,
                          delegate: CustomSearchDelegate(searchList: data),
                        );
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            color: const Color(0xFF009283),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.nombre,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${item.descripcion}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          const IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.arrow_right_alt_sharp,
                              size: 30,
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: data.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
    );
  }
}
