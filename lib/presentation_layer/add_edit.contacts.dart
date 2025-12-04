import 'package:flutter/material.dart';
import 'package:google_contact/domain_layer/contacts.dart';
import 'package:google_contact/application_layer/db_helper.dart';


class AddEditContact extends StatefulWidget {
  final Contact? contact;

  AddEditContact({super.key, this.contact});

  @override
  State<AddEditContact> createState() => _AddEditContactState();
}

class _AddEditContactState extends State<AddEditContact> {
  final _form = GlobalKey<FormState>();

  late TextEditingController name;
  late TextEditingController phone;
  late TextEditingController email;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.contact?.name ?? "");
    phone = TextEditingController(text: widget.contact?.phone ?? "");
    email = TextEditingController(text: widget.contact?.email ?? "");
  }

  void save() async {
    if (_form.currentState!.validate()) {
      final newContact = Contact(
        id: widget.contact?.id,
        name: name.text,
        phone: phone.text,
        email: email.text,
        isFavorite: widget.contact?.isFavorite ?? false,
      );

      if (widget.contact == null) {
        await DBHelper.instance.insertContact(newContact);
      } else {
        await DBHelper.instance.updateContact(newContact);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.contact == null ? "Add Contact" : "Edit Contact")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            children: [

              TextFormField(
                controller: name,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: phone,
                decoration: const InputDecoration(labelText: "Phone"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: email,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: save, child: const Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
