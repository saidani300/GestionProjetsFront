import 'package:gestion_projets/routing/routes.dart';
import 'package:get/get.dart';

class TopNavMenuController extends GetxController {
  static TopNavMenuController instance = Get.find();
  var activeItem = projectsPageDisplayName.obs;

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