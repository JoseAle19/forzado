import 'package:flutter/material.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<Datum> searchList;

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
    final List<Datum> searchResults = searchList
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
    final List<Datum> suggestionList = query.isEmpty
        ? []
        : searchList
            .where((item) =>
                item.nombre.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index].nombre),
          onTap: () {
            query = suggestionList[index].nombre;
            close(context, suggestionList[index].id.toString());
          },
        );
      },
    );
  }
}
