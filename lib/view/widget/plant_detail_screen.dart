import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sunflower_flutter/view/widget/navigator_cubit.dart';
import 'package:sunflower_flutter/view/widget/plant_detail_cubit.dart';
import 'package:sunflower_flutter/view/widget/plant_detail_state.dart';
import 'package:sunflower_flutter/view/widget/shape.dart';
import 'package:sunflower_flutter/view/widget/tab_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class PlantDetailScreen extends StatelessWidget {
  const PlantDetailScreen({super.key}) : super();

  static const snackBar = SnackBar(
    content: Text('Planta añadida al jardín'),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantDetailCubit, PlantDetailState>(
        builder: (context, state) {
      return state.plant == null
          ? const Center(child: CircularProgressIndicator())
          : Scaffold(
              resizeToAvoidBottomInset: false,
              body: NestedScrollView(
                  // Setting floatHeaderSlivers to true is required in order to float
                  // the outer slivers over the inner scrollable.
                  floatHeaderSlivers: true,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        pinned: true,
                        expandedHeight: 300.0,
                        collapsedHeight: 150.0,
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: FloatingActionButton(
                              elevation: 0,
                              heroTag: UniqueKey(),
                              onPressed: () => context
                                  .read<PlantDetailCubit>()
                                  .onTapShare(state.plant!.name),
                              shape: const CircleBorder(),
                              child: const Icon(Icons.share),
                            ),
                          ),
                        ],
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FloatingActionButton(
                            elevation: 0,
                            heroTag: UniqueKey(),
                            onPressed: () =>
                                context.read<NavigatorCubit>().toTabScreen(),
                            shape: const CircleBorder(),
                            child: const Icon(Icons.arrow_back),
                          ),
                        ),
                        forceElevated: innerBoxIsScrolled,
                        flexibleSpace: Stack(
                          children: [
                            Positioned.fill(
                                child: Image.network(
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              state.plant!.imageUrl,
                              fit: BoxFit.cover,
                            )),
                            Scaffold(
                                backgroundColor: Colors.transparent,
                                floatingActionButtonLocation:
                                    FloatingActionButtonLocation.endFloat,
                                floatingActionButton: Visibility(
                                  visible: !state.addedToGarden,
                                  child: FloatingActionButton(
                                    onPressed: () => addPlantToGarden(context),
                                    heroTag: UniqueKey(),
                                    shape: Shape.sunflowerShape,
                                    child: const Icon(Icons.add),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ];
                  },
                  body: SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(state.plant!.name,
                              style: Theme.of(context).textTheme.headlineSmall),
                          IconButton(
                              icon: const Icon(Icons.photo_library),
                              onPressed: () => context
                                  .read<NavigatorCubit>()
                                  .toPlantGallery())
                        ],
                      ),
                      plantIrrigation(state.plant!.wateringInterval),
                      Html(
                        data: state.plant!.description,
                        onLinkTap: (url, attributes, element) =>
                            launchUrl(Uri.parse(url!)),
                      ),
                    ]),
                  ))),
            );
    });
  }

  void addPlantToGarden(BuildContext context) {
    context.read<PlantDetailCubit>().addPlantToGarden();
    context.read<TabCubit>().updateGardenPlantings();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget plantIrrigation(int wateringInterval) {
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
}
