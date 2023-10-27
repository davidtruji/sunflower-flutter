import 'package:flutter/material.dart';

/// Flutter code sample for [Card].
class PlantListItem extends StatelessWidget {
  const PlantListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: SizedBox(
          width: 200,
          height: 200,
          child: Column(
            children: [
              Image.asset(
                "assets/sunflower.jpg",
                fit: BoxFit.fill,
              ),
              Text("Sunflower"),
            ],
          ),
        ));
  }
}
