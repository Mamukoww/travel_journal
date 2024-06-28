import 'package:flutter/material.dart';
import '../models/trip.dart';
import 'package:intl/intl.dart';

class AddEditTripScreen extends StatefulWidget {
  @override
  _AddEditTripScreenState createState() => _AddEditTripScreenState();
}

class _AddEditTripScreenState extends State<AddEditTripScreen> {
  final _formKey = GlobalKey<FormState>();
  String _tripTitle = '';
  String _tripDate = '';
  String _tripDescription = '';
  String _photoUrl = '';

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _tripDate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить поездку'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Название поездки'),
                onSaved: (value) {
                  _tripTitle = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите название поездки';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Дата поездки'),
                      controller: TextEditingController(text: _tripDate.isEmpty ? '' : DateFormat('dd-MM-yyyy').format(DateTime.parse(_tripDate))),
                      readOnly: true,
                      onTap: () => _selectDate(context),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Описание поездки'),
                onSaved: (value) {
                  _tripDescription = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите описание поездки';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'URL фотографии'),
                onSaved: (value) {
                  _photoUrl = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите URL фотографии';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Trip newTrip = Trip(
                      title: _tripTitle,
                      date: _tripDate,
                      description: _tripDescription,
                      photoUrl: _photoUrl,
                    );
                    Navigator.pop(context, newTrip);
                  }
                },
                child: Text('Сохранить поездку'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
