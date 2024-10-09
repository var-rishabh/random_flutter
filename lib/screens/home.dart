import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:random_flutter/provider/location.dart';
import 'package:random_flutter/widgets/appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LocationProvider locationProvider =
        Provider.of<LocationProvider>(context);

    // print('=====================${locationProvider?.places[0].name}');

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: const KAppBar(),
      body: Center(
        child: locationProvider.places.isEmpty
            ? const Text('No location added yet!')
            : ListView.builder(
                itemCount: locationProvider.places.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    title: Text(locationProvider.places[index].name),
                    subtitle: Text(locationProvider.places[index].description),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        locationProvider
                            .removePlace(locationProvider.places[index].id);
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
