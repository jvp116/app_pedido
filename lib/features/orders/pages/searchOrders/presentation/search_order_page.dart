import 'package:flutter/material.dart';

enum OrderFilter {
  nome,
  cpf
}

class SearchOrderPage extends StatefulWidget {
  const SearchOrderPage({super.key});

  @override
  State<SearchOrderPage> createState() => _SearchOrderPageState();
}

class _SearchOrderPageState extends State<SearchOrderPage> {
  bool searchByCpf = true;
  bool searchByName = false;
  final List<String> _filters = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextFormField(
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    iconSize: 16,
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      /* Clear the search field */
                    },
                  ),
                  hintText: 'Pesquisar...',
                  border: InputBorder.none),
              autofocus: true,
              enableSuggestions: true,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Wrap(
              spacing: 16.0,
              children: OrderFilter.values.map((OrderFilter orderFilter) {
                return FilterChip(
                  selectedColor: const Color.fromARGB(123, 104, 58, 183),
                  label: Text(orderFilter.name),
                  selected: _filters.contains(orderFilter.name),
                  onSelected: (bool value) {
                    setState(() {
                      if (value) {
                        if (!_filters.contains(orderFilter.name) && _filters.isEmpty) {
                          _filters.add(orderFilter.name);
                        }
                      } else {
                        _filters.removeWhere((String name) {
                          return name == orderFilter.name;
                        });
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
