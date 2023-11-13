import 'package:flutter/material.dart';
import 'package:sunflower_flutter/plant.dart';
import 'package:sunflower_flutter/plant_detail.dart';
import 'package:sunflower_flutter/shape.dart';

class PlantListItem extends StatelessWidget {
  const PlantListItem({super.key, required this.plant});

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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PlantDetail(plant: plant),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.network(
                  height: 100,
                  plant.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              SectionTitle(title: plant.name),
            ],
          ),
        ));
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: Text(title,
          maxLines: 1,
          softWrap: true,
          style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
