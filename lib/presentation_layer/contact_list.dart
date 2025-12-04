import 'package:flutter/material.dart';
import 'package:google_contact/domain_layer/contacts.dart';
import 'package:google_contact/application_layer/db_helper.dart';
import 'package:google_contact/presentation_layer/contact_detail_screen.dart';


class ContactTile extends StatelessWidget {
  final Contact contact;
  final VoidCallback onRefresh;

  const ContactTile(
      {super.key, required this.contact, required this.onRefresh});

  void toggleFavorite() async {
    contact.isFavorite = !contact.isFavorite;
    await DBHelper.instance.updateContact(contact);
    onRefresh();
  }

  void deleteContact(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Delete Contact?"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            TextButton(
                onPressed: () async {
                  await DBHelper.instance.deleteContact(contact.id!);
                  Navigator.pop(context);
                  onRefresh();
                },
                child: const Text("Delete")),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: Icon(contact.isFavorite ? Icons.star : Icons.star_border,
            color: Colors.orange),
        onPressed: toggleFavorite,
      ),
      title: Text(contact.name),
      subtitle: Text(contact.phone),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    ContactDetails(contact: contact, onRefresh: onRefresh)));
      },
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () => deleteContact(context),
      ),
    );
  }
}
