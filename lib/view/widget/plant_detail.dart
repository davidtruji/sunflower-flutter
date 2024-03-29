import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sunflower_flutter/di/locator.dart';
import 'package:sunflower_flutter/view/viewmodel/plant_detail_viewmodel.dart';
import 'package:sunflower_flutter/view/widget/root_widget.dart';
import 'package:sunflower_flutter/view/widget/shape.dart';
import 'package:url_launcher/url_launcher.dart';

class PlantDetail extends MyRootWidget<PlantDetailViewModel> {
  PlantDetail({super.key}) : super(getIt());

  static const snackBar = SnackBar(
    content: Text('Planta añadida al jardín'),
  );

  @override
  Widget widget(PlantDetailViewModel model, BuildContext context) {
    return model.plant == null
        ? const Text("LOADING")
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
                            onPressed: () =>
                                model.onTapShare(model.plant!.name),
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
                          onPressed: () => model.onTapBack(),
                          shape: const CircleBorder(),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      forceElevated: innerBoxIsScrolled,
                      flexibleSpace: Stack(
                        children: [
                          Positioned.fill(
                              child: Image.network(
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            model.plant!.imageUrl,
                            fit: BoxFit.cover,
                          )),
                          Scaffold(
                              backgroundColor: Colors.transparent,
                              floatingActionButtonLocation:
                                  FloatingActionButtonLocation.endFloat,
                              floatingActionButton: Visibility(
                                visible: !model.addedToGarden,
                                child: FloatingActionButton(
                                  onPressed: () => {
                                    model.addPlantToGarden(),
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar),
                                  },
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
                        Text(model.plant!.name,
                            style: Theme.of(context).textTheme.headlineSmall),
                        IconButton(
                            icon: const Icon(Icons.photo_library),
                            onPressed: () => model.onTapGallery()),
                      ],
                    ),
                    plantIrrigation(model.plant!.wateringInterval),
                    Html(
                      data: model.plant!.description,
                      onLinkTap: (url, attributes, element) =>
                          launchUrl(Uri.parse(url!)),
                    ),
                  ]),
                ))),
          );
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
