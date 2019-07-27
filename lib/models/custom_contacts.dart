import 'package:contacts_service/contacts_service.dart';
import './item_object.dart';

class CustomContact {
  final Contact contact;
  bool isChecked;
  double totalOwe;
  List<ItemObject> purchasedItem;

  CustomContact(
      {this.contact,
      this.isChecked = false,
      this.totalOwe = 0,
      this.purchasedItem});
}
