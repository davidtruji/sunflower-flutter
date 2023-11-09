import 'package:flutter/material.dart';
import 'package:sunflower_flutter/plant.dart';
import 'package:sunflower_flutter/plant_detail.dart';
import 'package:sunflower_flutter/shape.dart';

class GardenListItem extends StatelessWidget {
  const GardenListItem({super.key, required this.plant});

  final Plant plant;

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
            debugPrint('Card tapped.');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PlantDetail(plant: plant),
              ),
            );
          },
          child: Column(
            children: [
              Image.asset(
                "assets/sunflower.jpg",
                fit: BoxFit.fitWidth,
              ),
              titleSection(context, "Sunflower"),
              seededSection(context, "seeded"),
              irrigationSection(context, "irrigation"),
            ],
          ),
        ));
  }

  Widget irrigationSection(BuildContext context, String irrigation) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text("Última vez regada",
              style: Theme.of(context).textTheme.labelMedium),
          Text("10 de Oct, 2023",
              style: Theme.of(context).textTheme.bodyMedium),
          Text("regar en 2 días",
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
      padding: const EdgeInsets.all(10),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
