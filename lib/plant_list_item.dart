import 'package:flutter/material.dart';
import 'package:sunflower_flutter/plant_detail.dart';

class PlantListItem extends StatelessWidget {
  const PlantListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20))),
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
                builder: (context) => const PlantDetail(),
              ),
            );
          },
          child: Column(
            children: [
              Image.asset(
                "assets/sunflower.jpg",
                fit: BoxFit.fitWidth,
              ),
              const SectionTitle(title: "Sunflower"),
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
      padding: const EdgeInsets.all(10),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
