import 'package:flutter/material.dart';
import 'package:google_contact/domain_layer/contacts.dart';
import 'package:google_contact/application_layer/db_helper.dart';
import 'package:google_contact/presentation_layer/contact_list.dart';


class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Contact> favorites = [];

  void loadData() async {
    favorites = await DBHelper.instance.getFavorites();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: favorites.isEmpty
          ?  Center(child:
      Container(
          color: Color(0xffe28cff),
          child:
      Text("No Favorites")))
          : ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            return ContactTile(
                contact: favorites[index], onRefresh: loadData);
          }),
    );
  }
}
