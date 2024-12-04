import 'package:flutter/material.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/pages/aprobador/screen/detail_shutdown_forzado.dart';

class ListShutdownForzado extends StatelessWidget {
  const ListShutdownForzado({super.key, required this.data});
  final List<ForzadoM> data;

  void navigateDetailsShutdownForzado(BuildContext context, ForzadoM item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailShutdownForzado(
          detailForzado: item,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final item = data[index];
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
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
                      item.descripcion ?? '',
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
              IconButton(
                onPressed: () {
                  navigateDetailsShutdownForzado(context, item);
                },
                icon: const Icon(
                  Icons.arrow_right_alt_sharp,
                  size: 30,
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 1,
          color: Colors.black,
        );
      },
      itemCount: data.length,
    );
  }
}
