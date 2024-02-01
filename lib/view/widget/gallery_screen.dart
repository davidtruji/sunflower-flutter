import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sunflower_flutter/di/locator.dart';
import 'package:sunflower_flutter/domain/model/plant.dart';
import 'package:sunflower_flutter/domain/model/unsplash_photo.dart';
import 'package:sunflower_flutter/view/viewmodel/gallery_viewmodel.dart';
import 'package:sunflower_flutter/view/widget/plant_list_item.dart';
import 'package:sunflower_flutter/view/widget/root_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class GalleryScreen extends MyRootWidget<GalleryViewModel> {
  GalleryScreen({super.key}) : super(getIt());

  Future<void> _fetchPage(GalleryViewModel model,
      PagingController pagingController, String query, int page) async {
    try {
      final newItems =
          await model.fetchGallery(query, page); // Call in viewModel
      final isLastPage = newItems.results.length < 20;
      if (isLastPage) {
        pagingController.appendLastPage(newItems.results);
      } else {
        final nextPage = page + newItems.results.length;
        pagingController.appendPage(newItems.results, nextPage);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  Widget widget(GalleryViewModel model, BuildContext context) {
    final PagingController<int, UnsplashPhoto> pagingController =
        PagingController(firstPageKey: 0);
    pagingController.addPageRequestListener((page) {
      _fetchPage(model, pagingController, model.query, page);
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Fotos por Unsplash")),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: PagedGridView<int, UnsplashPhoto>(
            pagingController: pagingController,
            builderDelegate: PagedChildBuilderDelegate<UnsplashPhoto>(
                itemBuilder: (context, item, index) => PlantListItem(
                      plant: Plant(
                          plantId: "",
                          name: item.user.name,
                          description: "",
                          growZoneNumber: 0,
                          wateringInterval: 0,
                          imageUrl: item.urls.toString()),
                      onTap: () => launchURL(item.user.username),
                    )),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                crossAxisCount:
                    (MediaQuery.of(context).size.width ~/ 150).toInt()),
          )),
    );
  }

  void launchURL(String username) {
    launchUrl(Uri.parse(
        "https://unsplash.com/$username?utm_source=sunflower&utm_medium=referral"));
  }
}
