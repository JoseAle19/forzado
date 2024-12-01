import 'package:flutter/material.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';

class ListForzado extends StatelessWidget {
  const ListForzado({
    super.key,
    required this.data,
  });

  final List<Datum> data;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
    );
  }
}
