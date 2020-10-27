import 'package:flutter/material.dart';

Widget criaDropDownButton(List<String> elementos, Function funcao, String itemSelecionado) {
  return DropdownButton<String>(
    style: TextStyle(color: Colors.orange[800], fontSize: 15.0,),
    items: elementos.map((String dropDownStringItem) {
      return DropdownMenuItem<String>(
        value: dropDownStringItem,
        child: Text(dropDownStringItem),
      );
    }).toList(),
    onChanged: funcao,
    value: itemSelecionado,
  );
}