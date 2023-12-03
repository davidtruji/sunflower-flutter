import 'package:flutter/material.dart';
import 'package:sunflower_flutter/domain/model/plant.dart';
import 'package:sunflower_flutter/view/shape.dart';

class PlantListItem extends StatelessWidget {
  const PlantListItem({super.key, required this.plant, required this.onTap});

  final Plant plant;
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
              Expanded(
                child: Image.network(
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const SizedBox(
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ));
                  },
                  cacheHeight: 360,
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
