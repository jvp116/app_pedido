// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_pedido/features/orders/models/item_model.dart';
import 'package:flutter/material.dart';

class ListOrderController {
  List<TableRow> renderTableItems(List<ItemModel> items) {
    List<TableRow> rows = [];

    for (var item in items) {
      rows.add(renderRowItem(item));
    }

    return rows;
  }

  TableRow renderRowItem(ItemModel item) {
    return TableRow(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 32,
          child: Text("${item.quantity}",
              style: const TextStyle(
                fontSize: 16,
              )),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            alignment: Alignment.center,
            height: 32,
            width: 32,
            child: Text(item.product.description, style: const TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
