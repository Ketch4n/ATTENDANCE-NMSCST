import 'package:attendance_nmscst/src/pages/establishment/functions/delete.dart';
import 'package:flutter/material.dart';

DataCell dataRowCell(cell, {bool? logo}) {
  return DataCell(
    Row(
      children: [
        logo == true
            ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  "assets/img/estab.png",
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                ),
              )
            : const SizedBox(),
        const SizedBox(width: 10),
        Text(
          cell,
          style: const TextStyle(fontSize: 18),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

dataRowCellWidget(context, id, reload) {
  return DataCell(
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {},
          child: const Icon(Icons.settings),
        ),
        GestureDetector(
          onTap: () async {
            removeEstablishment(context, id, reload);
          },
          child: const Icon(Icons.delete),
        ),
      ],
    ),
  );
}
