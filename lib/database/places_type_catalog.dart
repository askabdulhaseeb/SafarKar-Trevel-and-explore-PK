import 'package:cloud_firestore/cloud_firestore.dart';

class PlacesTypeCatalogMethods {
  static const _fPlacesCatalog = 'placesTypeCatalog';
  getAllPlacesCatalog() async {
    return await FirebaseFirestore.instance.collection(_fPlacesCatalog).get();
  }
}
