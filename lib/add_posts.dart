import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'dart:io';

// AddPostPage (This is the screen for creating a post)
class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final _formKey = GlobalKey<FormState>();
  String _description = '';
  XFile? _image;
  final List<String> _foodTypes = [];
  DateTime? _expiryDate;
  String _location = '';
  List<Placemark>? _placemarks;

  final List<String> _allFoodTypes = [
    'Vegan', 'Vegetarian', 'Gluten Free', 'Fruits', 'Grains',
    'Canned Goods', 'Protein', 'Other'
  ];

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future<void> _getAddressFromCoordinates() async {
    if (_placemarks != null && _placemarks!.isNotEmpty) {
      Placemark placemark = _placemarks![0];
      setState(() {
        _location =
            "${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.postalCode}, ${placemark.country}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: _image != null
                        ? Image.file(File(_image!.path), fit: BoxFit.cover)
                        : const Icon(Icons.add_a_photo, size: 50),
                  ),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              Row(
                children: [
                  Text(_expiryDate == null
                      ? 'Expiry Date: Not set'
                      : 'Expiry Date: ${DateFormat('yyyy-MM-dd').format(_expiryDate!)}'),
                  IconButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != _expiryDate) {
                        setState(() {
                          _expiryDate = picked;
                        });
                      }
                    },
                    icon: const Icon(Icons.calendar_today),
                  ),
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Location (Address)'),
                onChanged: (value) {
                  _location = value;
                },
              ),
              const Text('Type of Food:'),
              Wrap(
                children: _allFoodTypes.map((type) {
                  return CheckboxListTile(
                    title: Text(type),
                    value: _foodTypes.contains(type),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value!) {
                          _foodTypes.add(type);
                        } else {
                          _foodTypes.remove(type);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      final postData = {
                        'description': _description,
                        'imagePath': _image?.path,
                        'expiryDate': _expiryDate?.toIso8601String(),
                        'location': _location,
                        'foodTypes': _foodTypes,
                      };

                      Navigator.pop(context, postData);
                    }
                  },
                  child: const Text('Create Post'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


