import 'package:flutter/material.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/pages/solicitante/online/screen/form_remove.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<ForzadoM> searchList;

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
    final List<ForzadoM> searchResults = searchList
        .where(
            (item) => item.nombre.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(searchResults[index].nombre),
            onTap: () => close(context, searchResults[index].id.toString()),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<ForzadoM> suggestionList = query.isEmpty
        ? []
        : searchList
            .where((item) =>
                item.nombre.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, i) {
        return ListTile(
          title: Hero(
              tag: suggestionList[i].id.toString(),
              child: Text(suggestionList[i].nombre)),
          onTap: () {
            ForzadoM removeForzado = suggestionList[i];
            query = suggestionList[i].nombre;
            handleNavigate(context, removeForzado);
          },
        );
      },
    );
  }

  void handleNavigate(BuildContext context, ForzadoM detailForzado) {
    final route = MaterialPageRoute(
        builder: (_) => FormRemoveForzado(
              detailForzado: detailForzado,
            ));
    Navigator.push(context, route);
  }
}
