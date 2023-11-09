import 'package:flutter/material.dart';
import 'package:sunflower_flutter/garden_planting.dart';
import 'package:sunflower_flutter/plant.dart';
import 'package:sunflower_flutter/plant_detail.dart';
import 'package:sunflower_flutter/plant_garden_planting.dart';
import 'package:sunflower_flutter/shape.dart';

class GardenListItem extends StatelessWidget {
  const GardenListItem({super.key, required this.plantGardenPlanting});

  final PlantGardenPlanting plantGardenPlanting;

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.hardEdge,
        shape: Shape.sunflowerShape,
        elevation: 0,
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: InkWell(
          splashColor: Theme.of(context)
              .colorScheme
              .secondaryContainer
              .withOpacity(0.12),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    PlantDetail(plant: plantGardenPlanting.plant),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                plantGardenPlanting.plant.imageUrl,
                height: 100,
                fit: BoxFit.cover,
              ),
              titleSection(context, plantGardenPlanting.plant.name),
              seededSection(
                  context, plantGardenPlanting.gardenPlanting.plantDate),
              irrigationSection(
                  context,
                  plantGardenPlanting.gardenPlanting.lastWateringDate,
                  plantGardenPlanting.plant.wateringInterval),
            ],
          ),
        ));
  }

  Widget irrigationSection(
    BuildContext context,
    String lastWateringDate,
    int wateringInterval,
  ) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text("Última vez regada",
              style: Theme.of(context).textTheme.labelMedium),
          Text(lastWateringDate, style: Theme.of(context).textTheme.bodyMedium),
          Text("Regar en $wateringInterval días",
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget seededSection(BuildContext context, String seeded) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text("Plantada", style: Theme.of(context).textTheme.labelMedium),
          Text("10 de Oct, 2023",
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget titleSection(BuildContext context, String title) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
