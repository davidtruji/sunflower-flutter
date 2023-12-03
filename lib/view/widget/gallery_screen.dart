import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sunflower_flutter/domain/model/plant.dart';
import 'package:sunflower_flutter/domain/model/unsplash_photo.dart';
import 'package:sunflower_flutter/domain/model/unsplash_search_result.dart';
import 'package:sunflower_flutter/view/bloc/gallery_cubit.dart';
import 'package:sunflower_flutter/view/bloc/gallery_state.dart';
import 'package:sunflower_flutter/view/bloc/navigator_cubit.dart';
import 'package:sunflower_flutter/view/widget/plant_list_item.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PagingController<int, UnsplashPhoto> pagingController =
        PagingController(firstPageKey: 0);
    pagingController.addPageRequestListener((page) {
      context.read<GalleryCubit>().fetchGallery(page); //
    });

    return BlocBuilder<GalleryCubit, GalleryState>(builder: (context, state) {
      if (state.unsplashSearchResult != null) {
        final UnsplashSearchResult newItems = state.unsplashSearchResult!;
        final isLastPage = newItems.results.length < 20;
        if (isLastPage) {
          pagingController.appendLastPage(newItems.results);
        } else {
          final nextPage = state.page + newItems.results.length;
          pagingController.appendPage(newItems.results, nextPage);
        }
      }

      return Scaffold(
          appBar: AppBar(
              title: const Text("Fotos por Unsplash"),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.read<NavigatorCubit>().toPlantDetail(),
              )),
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
                          onTap: () => context
                              .read<GalleryCubit>()
                              .launchURL(item.user.username),
                        )),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    crossAxisCount:
                        (MediaQuery.of(context).size.width ~/ 150).toInt()),
              )));
    });
  }
}
