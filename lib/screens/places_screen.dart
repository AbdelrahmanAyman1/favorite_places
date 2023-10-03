import 'package:favorite_places/provider/user_places.dart';
import 'package:favorite_places/screens/add_places_screen.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() {
    return _PlacesScreenState();
  }
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> _placeFuture;
  @override
  void initState() {
    super.initState();
    _placeFuture=ref.read(userPlacesProvider.notifier).loadPlaces();
  }
  void openAddPlaceScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const AddPlaceScreen();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    
    
    final addPlace = ref.watch(userPlacesProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),
          actions: [
            IconButton(
                onPressed: () {
                  openAddPlaceScreen(context);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: FutureBuilder(
            future: _placeFuture,
            builder: (context, snapshot) => snapshot.connectionState== ConnectionState.waiting?const Center(child: CircularProgressIndicator(),): PlacesList(places: addPlace)),
        ));
  }
}
