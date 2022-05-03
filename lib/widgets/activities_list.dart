import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Food.dart';

class ActivitiesList extends StatelessWidget {
  final List<Activity> _foods;
  final Function(Activity) _deleteActivity;
  ActivitiesList(this._foods, this._deleteActivity);

  void delete(){
    _foods.remove(0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _foods.map((activity) {
        return Card(
          child: Row(
            children: [
              Container(
                child: Text(
                  '${activity.kcal.toString()} kcal',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 3,
                  ),
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                padding: EdgeInsets.all(12),
              ),
              Column(
                children: [
                  Text(
                    activity.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy hh:mm:ss').format(activity.date),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
