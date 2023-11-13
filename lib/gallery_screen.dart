import 'package:flutter/material.dart';
import 'package:sunflower_flutter/plant.dart';
import 'package:sunflower_flutter/plant_list_item.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:sunflower_flutter/unsplash_photo.dart';
import 'package:sunflower_flutter/unsplash_search_result.dart';
import 'unsplash_api.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key, required this.query});

  final String query;

  @override
  GalleryScreenState createState() => GalleryScreenState(query: query);
}

class GalleryScreenState extends State<GalleryScreen> {
  late Future<UnsplashSearchResults> futureAlbum;
  final String query;

  GalleryScreenState({required this.query});

  @override
  void initState() {
    super.initState();
    futureAlbum = UnsplashAPI().fetchGallery(query, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Fotos por Unsplash")),
        body: FutureBuilder<UnsplashSearchResults>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No results.'));
              } else {
                final searchResults = snapshot.data;
                List<PlantListItem> plantList = [];

                for (UnsplashPhoto r in searchResults!.results!) {
                  plantList.add(PlantListItem(
                    plant: Plant(
                        plantId: "plantId",
                        name: r.user!.username!,
                        description: "description",
                        growZoneNumber: 0,
                        wateringInterval: 0,
                        imageUrl: r.urls!.small!),
                  ));
                }

                return ResponsiveGridList(
                  minItemWidth: 150,
                  verticalGridMargin: 16,
                  verticalGridSpacing: 16,
                  horizontalGridMargin: 16,
                  horizontalGridSpacing: 16,
                  children: plantList,
                );
              }
            }));
  }
}
