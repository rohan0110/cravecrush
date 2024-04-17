import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cravecrush/screens/home_screen.dart'; // Import your home page

class GetStartedPage extends StatefulWidget {
  final String uid;

  const GetStartedPage({Key? key, required this.uid}) : super(key: key);

  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  final List<Map<String, dynamic>> _userData = [
    {},
    {},
    {
      'times_to_smoke': [],
      'reasons_started': [],
      'reasons_to_quit': [],
      'other_reason_started': '',
      'other_reason_quit': ''
    },
  ];

  void _submitForm(BuildContext context) {
    final form = _formKeys[_currentPageIndex].currentState;
    if (form != null && form.validate()) {
      form.save();

      if (_currentPageIndex == _formKeys.length - 1) {
        try {
          FirebaseFirestore.instance.collection('users').doc(widget.uid).set({
            'first_name': _userData[0]['first_name'],
            'last_name': _userData[0]['last_name'],
            'age': _userData[0]['age'],
            'gender': _userData[0]['gender'],
            'num_cigarettes': _userData[1]['num_cigarettes'],
            'price_per_cigarette': _userData[1]['price_per_cigarette'],
            'times_to_smoke': _userData[2]['times_to_smoke'],
            'reasons_started': _userData[2]['reasons_started'],
            'other_reason_started': _userData[2]['other_reason_started'],
            'reasons_to_quit': _userData[2]['reasons_to_quit'],
            'other_reason_quit': _userData[2]['other_reason_quit'],
          }).then((_) {
            print('User data saved to Firestore');
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
                  (Route<dynamic> route) => false,
            );
          }).catchError((error) {
            print('Failed to save user data: $error');
          });
        } catch (error) {
          print('Failed to save user data: $error');
        }
      } else {
        _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
        setState(() {
          _currentPageIndex++;
        });
      }
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        final String formattedTime = '${pickedTime.hour}:${pickedTime.minute}';

        // Ensure _userData[2]['times_to_smoke'] is of type List<String>
        List<String> timesToSmoke = List<String>.from(_userData[2]['times_to_smoke']);
        timesToSmoke.add(formattedTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Started'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildNameSection(),
                _buildSmokingProfileSection(),
                _buildReasonsSection(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => _submitForm(context),
              child: Text(_currentPageIndex == _formKeys.length - 1 ? 'Submit' : 'Next'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameSection() {
    return Form(
      key: _formKeys[0],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'First Name'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your first name';
              }
              return null;
            },
            onSaved: (value) => _userData[0]['first_name'] = value ?? '',
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Last Name'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your last name';
              }
              return null;
            },
            onSaved: (value) => _userData[0]['last_name'] = value ?? '',
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your age';
              }
              return null;
            },
            onSaved: (value) => _userData[0]['age'] = int.tryParse(value ?? '') ?? 0,
          ),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Gender'),
            items: ['Male', 'Female', 'Other'].map((gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: Text(gender),
              );
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your gender';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _userData[0]['gender'] = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSmokingProfileSection() {
    return Form(
      key: _formKeys[1],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Number of cigarettes per day'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter the number of cigarettes';
              }
              return null;
            },
            onSaved: (value) => _userData[1]['num_cigarettes'] = int.tryParse(value ?? '') ?? 0,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Price per cigarette'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter the price per cigarette';
              }
              return null;
            },
            onSaved: (value) => _userData[1]['price_per_cigarette'] = double.tryParse(value ?? '') ?? 0.0,
          ),
          if (_userData[2]['times_to_smoke'] != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Select the time you smoke more oftenly:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Wrap(
                  spacing: 8.0,
                  children: List.generate(
                    _userData[2]['times_to_smoke'].length,
                        (index) => Chip(
                      label: Text(_userData[2]['times_to_smoke'][index]),
                      onDeleted: () {
                        setState(() {
                          _userData[2]['times_to_smoke'].removeAt(index);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ElevatedButton(
            onPressed: () => _selectTime(context),
            child: Text('Add Time'),
          ),
        ],
      ),
    );
  }

  Widget _buildReasonsSection() {
    return Form(
      key: _formKeys[2],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMultiSelectFormField(
            title: 'Reasons started smoking',
            dataSource: [
              {"display": "Stress", "value": "Stress"},
              {"display": "Peer pressure", "value": "Peer pressure"},
              {"display": "Curiosity", "value": "Curiosity"},
              {"display": "Other", "value": "Other"},
            ],
            selectedValues: _userData[2]['reasons_started'],
            onChanged: (value) {
              setState(() {
                _userData[2]['reasons_started'] = value;
              });
            },
          ),
          if (_userData[2]['reasons_started'] != null && _userData[2]['reasons_started'].contains('Other'))
            TextFormField(
              decoration: const InputDecoration(labelText: 'Other reasons started smoking (if any)'),
              onSaved: (value) => _userData[2]['other_reason_started'] = value ?? '',
            ),
          _buildMultiSelectFormField(
            title: 'Reasons to quit smoking',
            dataSource: [
              {"display": "Health concerns", "value": "Health concerns"},
              {"display": "Financial reasons", "value": "Financial reasons"},
              {"display": "Social reasons", "value": "Social reasons"},
              {"display": "Other", "value": "Other"},
            ],
            selectedValues: _userData[2]['reasons_to_quit'],
            onChanged: (value) {
              setState(() {
                _userData[2]['reasons_to_quit'] = value;
              });
            },
          ),
          if (_userData[2]['reasons_to_quit'] != null && _userData[2]['reasons_to_quit'].contains('Other'))
            TextFormField(
              decoration: const InputDecoration(labelText: 'Other reasons to quit smoking (if any)'),
              onSaved: (value) => _userData[2]['other_reason_quit'] = value ?? '',
            ),
        ],
      ),
    );
  }

  Widget _buildMultiSelectFormField({
    required String title,
    required List<Map<String, dynamic>> dataSource,
    required List<dynamic> selectedValues,
    required Function(List<dynamic>) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: dataSource.map((item) {
            final value = item['value'];
            return FilterChip(
              label: Text(item['display']),
              selected: selectedValues.contains(value),
              onSelected: (selected) {
                List<dynamic> newSelectedValues = List.from(selectedValues);
                if (selected) {
                  newSelectedValues.add(value);
                } else {
                  newSelectedValues.remove(value);
                }
                onChanged(newSelectedValues);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}