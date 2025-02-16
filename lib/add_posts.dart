import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

// AddPostPage (Create Post Screen)Error: XMLHttpRequest error.
class AddPostPage extends StatefulWidget {




  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final _formKey = GlobalKey<FormState>();
  String _description = '';
  XFile? _image;
  late List<bool> _foodTypes;
  DateTime? _expiryDate;
  String _location = '';
  List<Placemark>? _placemarks;

  final List<String> _allFoodTypes = [
    'Vegan', 'Vegetarian', 'Gluten Free', 'Fruits', 'Grains',
    'Canned Goods', 'Protein', 'Other'
  ];

  @override
  void initState() {
    super.initState();
    _foodTypes = List.filled(_allFoodTypes.length, false);
  }

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
  Future<void> _runPostPhp(String description, String location, String vegan, String vegetarian, String glutenFree, String fruits, String grains, String canned, String protein, String other) async {
  final headers = {
    'description': description,
    "location": location,
    "vegan": vegan,
    "vegetarian": vegetarian,
    "glutenFree": glutenFree,
    "fruits": fruits,
    "grains": grains,
    "canned": canned,
    "protein": protein,
    "other": other,
  };
  print('Sending headers: $headers');
  
  try {
    final request = http.Request('POST', Uri.parse('http://127.0.0.1:8000/post.php'));
    request.headers.addAll(headers);
    
    // Print the full request details
    print('Full request:');
    print('URL: ${request.url}');
    print('Method: ${request.method}');
    print('Headers: ${request.headers}');
    
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  } catch (e) {
    print('Error: $e');
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
              // ... (Image, description, expiry date, location fields)
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
                  final index = _allFoodTypes.indexOf(type);
                  return CheckboxListTile(
                    title: Text(type),
                    value: _foodTypes[index],
                    onChanged: (bool? value) {
                      setState(() {
                        _foodTypes[index] = value!;
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
                        'foodTypes': _foodTypes, // Store the boolean list
                      };
                      _runPostPhp(_description, _location, _foodTypes[0].toString(), _foodTypes[1].toString(), _foodTypes[2].toString(), _foodTypes[3].toString(), _foodTypes[4].toString(), _foodTypes[5].toString(), _foodTypes[6].toString(), _foodTypes[7].toString());
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


