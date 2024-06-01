import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPageController extends GetxController {
  RxList<DocumentSnapshot> searchResults = <DocumentSnapshot>[].obs;

  void searchJobPosts(String searchText) async {
  try {
    if (searchText.isNotEmpty) {
      // Convert the search text to lowercase
      String searchTextLower = searchText.toLowerCase();

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('jobPost')
          .get();

      List<DocumentSnapshot> filteredResults = querySnapshot.docs.where((doc) {
        // Convert each document's title to lowercase for comparison
        String titleLower = (doc['title'] ?? '').toString().toLowerCase();
        // Check if the lowercase title contains the lowercase search text
        return titleLower.contains(searchTextLower);
      }).toList();

      searchResults.value = filteredResults;
      searchResults.forEach((snapshot) {
        print("Search result: ${snapshot.data()}");
      });
    } else {
      // Clear the search results when searchText is empty
      searchResults.clear();
    }
  } catch (error) {
    print("Failed to search job posts: $error");
  }
}


}
