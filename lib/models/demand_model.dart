// import 'package:app_pedido/features/customer/models/customer_model.dart';
// import 'package:app_pedido/models/items_model.dart';

// class Demand {
//   int? id;
//   String? data;
//   CustomerModel? customer;
//   List<Items>? items;

//   Demand({this.id, this.data, this.customer, this.items});

//   Demand.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     data = json['data'];
//     customer = json['customer'] != null
//         ? CustomerModel.fromJson(json['customer'])
//         : null;
//     if (json['items'] != null) {
//       items = <Items>[];
//       json['items'].forEach((v) {
//         items!.add(Items.fromJson(v));
//       });
//     }
//   }
// }
