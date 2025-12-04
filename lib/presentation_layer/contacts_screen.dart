import 'package:flutter/material.dart';
import 'package:google_contact/domain_layer/contacts.dart';
import 'package:google_contact/application_layer/db_helper.dart';
import 'package:google_contact/presentation_layer/add_edit.contacts.dart';
import 'package:google_contact/presentation_layer/contact_list.dart';


class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact> contacts = [];

  void load_Data() async {
    contacts = await DBHelper.instance.getContacts();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    load_Data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contacts App")),
      body: contacts.isEmpty
          ?  Center(
          child:
          Container(
              color: Color(0xffe28cff),
              child: Text("No Contacts Found")))
          : ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ContactTile(
            contact: contacts[index],
            onRefresh: load_Data,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddEditContact(),
            ),
          );
          load_Data();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
