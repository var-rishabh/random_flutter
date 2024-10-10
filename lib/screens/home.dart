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
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        locationProvider.places[index].image!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
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
