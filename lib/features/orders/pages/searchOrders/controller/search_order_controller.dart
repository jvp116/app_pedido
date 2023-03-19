// ignore_for_file: public_member_api_docs, sort_constructors_first

class SearchOrderController {
  final bool searchByCpf = false;
  final bool searchByName = false;
  final List<String> filters = <String>[];
}

enum OrderFilter {
  nome,
  cpf
}
