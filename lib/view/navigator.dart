import 'package:get/get.dart';
import 'package:sunflower_flutter/view/viewmodel/plant_detail_viewmodel.dart';
import 'package:sunflower_flutter/view/widget/gallery_screen.dart';
import 'package:sunflower_flutter/view/widget/plant_detail.dart';
import 'package:sunflower_flutter/di/locator.dart';
class Navigator {


  void toPlantDetail(String id) {
    getIt.get<PlantDetailViewModel>().onDetailIdFound(id); // Initialize PlantDeatilViewModel here
    Get.to(() => PlantDetail());
  }

  void toGallery(String query) {
    Get.to(() => GalleryScroll(), arguments: query);
  }

  void back() {
    Get.back();
  }
}
