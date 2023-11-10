import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sunflower_flutter/db_helper.dart';
import 'package:sunflower_flutter/garden_planting.dart';
import 'package:sunflower_flutter/plant.dart';
import 'package:sunflower_flutter/shape.dart';

class PlantDetail extends StatelessWidget {
  const PlantDetail({super.key, required this.plant});

  static const snackBar = SnackBar(
    content: Text('Planta añadida al jardín'),
  );
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
          // Setting floatHeaderSlivers to true is required in order to float
          // the outer slivers over the inner scrollable.
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: 300.0,
                collapsedHeight: 100.0,
                leading: Padding(
                  padding: const EdgeInsets.all(8),
                  child: FloatingActionButton(
                    heroTag: UniqueKey(),
                    onPressed: () => Navigator.pop(context),
                    shape: const CircleBorder(),
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: Stack(
                  children: [
                    Positioned.fill(
                        child: Image.network(
                      plant.imageUrl,
                      fit: BoxFit.cover,
                    )),
                    Scaffold(
                      backgroundColor: Colors.transparent,
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.endFloat,
                      floatingActionButton: FloatingActionButton(
                        onPressed: () => addPlantToGarden(context),
                        heroTag: UniqueKey(),
                        shape: Shape.sunflowerShape,
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(children: [
              Text(plant.name,
                  style: Theme.of(context).textTheme.displayMedium),
              plantIrrigation(context, plant.wateringInterval),
              Text(plant.description),
            ]),
          ))),
    );
  }

  Widget plantIrrigation(BuildContext context, int wateringInterval) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const Text("Necesita ser regada",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Cada $wateringInterval días."),
        ],
      ),
    );
  }

  void addPlantToGarden(BuildContext context) {
    DBHelper helper = DBHelper();
    DateTime dateNow = DateTime.now();
    DateFormat formatter = DateFormat("MMM d, y");

    helper.insertGardenPlanting(GardenPlanting(
        gardenPlantingId: plant.plantId,
        plantId: plant.plantId,
        plantDate: formatter.format(dateNow),
        lastWateringDate: formatter.format(dateNow)));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
