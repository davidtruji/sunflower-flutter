import 'package:get/get.dart';
import 'package:sunflower_flutter/view/widget/gallery_screen.dart';
import 'package:sunflower_flutter/view/widget/plant_detail.dart';

class Navigator {
  void toPlantDetail(String id) {
    Get.to(() => PlantDetail(), arguments: id);
  }

  void toGallery(String query) {
    Get.to(() => GalleryScroll(), arguments: query);
  }

  void back() {
    Get.back();
  }
}
