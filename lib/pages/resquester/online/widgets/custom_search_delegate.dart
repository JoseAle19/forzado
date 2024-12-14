import 'package:flutter/material.dart';
import 'package:forzado/models/forzado/model_forzado.dart';
import 'package:forzado/pages/resquester/online/screen/form_remove.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<ForzadoItem> searchList;

  CustomSearchDelegate({required this.searchList});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<ForzadoItem> searchResults = searchList
        .where(
            (item) => item.nombre!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(searchResults[index].nombre??'N/A'),
            onTap: () => close(context, searchResults[index].id.toString()),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<ForzadoItem> suggestionList = query.isEmpty
        ? []
        : searchList
            .where((item) =>
                item.nombre!.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, i) {
        return ListTile(
          title: Hero(
              tag: suggestionList[i].id.toString(),
              child: Text(suggestionList[i].nombre??'N/A')),
          onTap: () {
            ForzadoItem removeForzado = suggestionList[i];
            query = suggestionList[i].nombre??'N/A';
            handleNavigate(context, removeForzado);
          },
        );
      },
    );
  }

  void handleNavigate(BuildContext context, ForzadoItem detailForzado) {
    final route = MaterialPageRoute(
        builder: (_) => FormRemoveForzado(
              detailForzado: detailForzado,
            ));
    Navigator.push(context, route);
  }
}
