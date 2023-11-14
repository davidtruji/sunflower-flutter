import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sunflower_flutter/data/datasource/remote/unsplash_api.dart';
import 'package:sunflower_flutter/domain/model/plant.dart';
import 'package:sunflower_flutter/view/viewmodel/gallery_viewmodel.dart';
import 'package:sunflower_flutter/view/widget/plant_list_item.dart';
import 'package:sunflower_flutter/view/widget/root_widget.dart';

import '../../di/locator.dart';
import '../../domain/model/unsplash_photo.dart';

class GalleryScroll extends RootWidget<GalleryViewModel> {
  GalleryScroll({super.key}) : super(getIt());

  @override
  Widget widget(GalleryViewModel model) {
    model.setQuery(Get.arguments);
    return GalleryScreen(
      query: Get.arguments,
    );
  }
}

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key, required this.query});

  final String query;

  @override
  // ignore: no_logic_in_create_state
  GalleryScreenState createState() => GalleryScreenState(query);
}

class GalleryScreenState extends State<GalleryScreen> {
  GalleryScreenState(this.query);

  static const _pageSize = UnsplashAPI.pageSize;
  final String query;

  final PagingController<int, UnsplashPhoto> _pagingController =
  PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(query, pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(String query, int pageKey) async {
    try {
      final newItems = await UnsplashAPI().fetchGallery(query, pageKey);
      final isLastPage = newItems.results!.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.results!);
      } else {
        final nextPageKey = pageKey + newItems.results!.length;
        _pagingController.appendPage(newItems.results!, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(title: const Text("Fotos por Unsplash")),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: PagedGridView<int, UnsplashPhoto>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<UnsplashPhoto>(
                  itemBuilder: (context, item, index) =>
                      PlantListItem(
                        plant: Plant(
                            plantId: "plantId",
                            name: item.user!.username!,
                            description: "description",
                            growZoneNumber: 0,
                            wateringInterval: 0,
                            imageUrl: item.urls!.small!),
                        onTap: () => {},
                      )),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  crossAxisCount:
                  (MediaQuery
                      .of(context)
                      .size
                      .width ~/ 150).toInt()),
            )),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}