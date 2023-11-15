import 'package:flutter/material.dart';
import 'package:sunflower_flutter/domain/model/plant_garden_planting.dart';
import 'package:sunflower_flutter/view/widget/shape.dart';

class GardenListItem extends StatelessWidget {
  const GardenListItem(
      {super.key, required this.plantGardenPlanting, required this.onTap});

  final PlantGardenPlanting plantGardenPlanting;
  final Function onTap;

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
          onTap: () => onTap(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ));
                },
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
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const Text("Última vez regada",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text(lastWateringDate, style: Theme.of(context).textTheme.bodyMedium),
          Text("Regar en $wateringInterval días"),
        ],
      ),
    );
  }

  Widget seededSection(BuildContext context, String seeded) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const Text("Plantada", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(seeded),
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
