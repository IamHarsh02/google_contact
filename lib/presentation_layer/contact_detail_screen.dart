import 'package:flutter/material.dart';
import 'package:google_contact/domain_layer/contacts.dart';
import 'package:google_contact/presentation_layer/add_edit.contacts.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactDetails extends StatelessWidget {
  final Contact contact;
  final VoidCallback onRefresh;

  ContactDetails({super.key, required this.contact, required this.onRefresh});

  void callNumber(String number) async {
    final url = Uri.parse("tel:$number");
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
        actions: [
          IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AddEditContact(contact: contact)));
                onRefresh();
                Navigator.pop(context);
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${contact.name}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Phone: ${contact.phone}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Email: ${contact.email}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.call),
              label: const Text("Call"),
              onPressed: () => callNumber(contact.phone),
            )
          ],
        ),
      ),
    );
  }
}
