import 'package:flutter/material.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BackgroundImageScreen(),
    );
  }
}

class BackgroundImageScreen extends StatefulWidget {
  const BackgroundImageScreen({super.key});

  @override
  _BackgroundImageScreenState createState() => _BackgroundImageScreenState();
}

class _BackgroundImageScreenState extends State<BackgroundImageScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedDestination;
  int? _passengerCount;
  DateTime? _selectedDate;

  final Map<String, int> _fares = {
    'Chitwan': 900,
    'Pokhara': 1200,
    'Butwal': 1900,
  };

  //Form Fields
  final TextEditingController _passengerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prastavana Booking System'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg2.jpg'),
            fit: BoxFit.cover, // This will zoom out the image a bit
            alignment: Alignment.center,
          ),
        ),
        //Form
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedDestination,
                  decoration: const InputDecoration(
                    labelText: 'Select Destination',
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                  items: _fares.keys
                      .map((destination) => DropdownMenuItem<String>(
                            value: destination,
                            child: Text(destination),
                          ))
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedDestination = newValue;
                    });
                  },
                  validator: (newValue) {
                    if (newValue == null || newValue.isEmpty) {
                      return 'Please select a destination';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                //Passenger Field
                TextFormField(
                  controller: _passengerController,
                  decoration: const InputDecoration(
                    labelText: 'Number of Passengers',
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (newValue) {
                    if (newValue == null || newValue.isEmpty) {
                      return 'Please enter the number of passengers';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _passengerCount = int.tryParse(newValue ?? '');
                  },
                ),
                const SizedBox(height: 16),

                //Date Picker
                Row(
                  children: [
                    const Text('Travel Date: '),
                    TextButton(
                      onPressed: () async {
                        final selected = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (selected != null) {
                          setState(() {
                            _selectedDate = selected;
                          });
                        }
                      },
                      child: Text(
                        _selectedDate == null
                            ? 'Select Date'
                            : '${_selectedDate!.toLocal()}'.split(' ')[0],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
