import 'package:get/get.dart';
import 'package:sunflower_flutter/di/locator.dart';
import 'package:sunflower_flutter/view/viewmodel/gallery_viewmodel.dart';
import 'package:sunflower_flutter/view/widget/gallery_screen.dart';

class Navigator {
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
