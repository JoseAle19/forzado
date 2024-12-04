import 'package:flutter/material.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/pages/aprobador/screen/detail_approve_forzado.dart';

class ListApproveForzado extends StatelessWidget {
  const ListApproveForzado({
    super.key,
    required this.data,
    required this.isAlta,
  });
  final bool isAlta;
  final List<ForzadoM> data;

  void navigateDetailsApproveForzado(
      BuildContext context, ForzadoM item, bool isAltaF) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailApproveForzado(detailForzado: item, isAlta: isAltaF),
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
                      item.id.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      item.nombre ?? '',
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
                  navigateDetailsApproveForzado(context, item, isAlta);
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
