import 'package:get/get.dart';
import 'package:sunflower_flutter/di/locator.dart';
import 'package:sunflower_flutter/view/viewmodel/gallery_viewmodel.dart';
import 'package:sunflower_flutter/view/viewmodel/plant_detail_viewmodel.dart';
import 'package:sunflower_flutter/view/widget/gallery_screen.dart';
import 'package:sunflower_flutter/view/widget/plant_detail.dart';

class Navigator {
  void toPlantDetail(String id) {
    getIt
        .get<PlantDetailViewModel>()
        .onDetailIdFound(id); // Initialize ViewModel here
    Get.to(() => PlantDetail());
  }

  void toPlantGallery(String plantName) {
    getIt
        .get<GalleryViewModel>()
        .setQuery(plantName); // Initialize ViewModel here
    Get.to(() => GalleryScreen());
  }

  void back() {
    Get.back();
  }
}
