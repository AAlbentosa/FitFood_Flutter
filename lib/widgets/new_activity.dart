import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewActivity extends StatefulWidget {
  final Function(String, int, DateTime) _addNewActivityHandler;

  NewActivity(this._addNewActivityHandler);

  @override
  State<NewActivity> createState() => _NewActivityState();
}

class _NewActivityState extends State<NewActivity> {
  final foodnameController = TextEditingController();
  final kcalController = TextEditingController();
  var _selectedDate;

  void _submit() {
    final foodname = foodnameController.text;
    final calorias = int.parse(kcalController.text);

    widget._addNewActivityHandler(
        foodname,
        calorias,
        _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((value) {
      print(value);
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          children: [
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
            child: TextFormField(
              controller: foodnameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'El campo nombre comida debe ser completado';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre comida',
              ),
            ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              child: TextFormField(
                controller: kcalController,
                validator: (value) {
                  if (value == null || value.isEmpty || int.parse(value) < 0 ||
                      int.parse(value) > 5000) {
                    return 'Las calorias deben estar entre 0 y 5000';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Calorias',
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "Sin fecha seleccionada"
                          : DateFormat.yMd().format(_selectedDate),
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Seleccionar fecha',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _showDatePicker,
                  ),
                ],
              ),
              height: 80,
            ),
            ElevatedButton(
              child: Text('Guardar'),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              onPressed: () {
                _submit();
              },
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
        padding: EdgeInsets.all(20),
      ),
      elevation: 8,
    );
  }
}
