import 'package:gestion_projets/pages/projects/Data/items.dart';
import 'package:get/get.dart';

class ShowByStatusController extends GetxController {
  static ShowByStatusController instance = Get.find();
  var activeItem = AllName.obs;

  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isHovering(String itemName) => hoverItem.value == itemName;

  isActive(String itemName) => activeItem.value == itemName;
}
