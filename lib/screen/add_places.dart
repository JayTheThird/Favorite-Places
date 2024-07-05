import 'package:favorite_places/riverpod/user_places_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPlaces extends StatefulWidget {
  const AddPlaces({super.key});

  @override
  State<AddPlaces> createState() => _AddPlacesState();
}

class _AddPlacesState extends State<AddPlaces> {
  final _addPlaces = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final placeBLoc = BlocProvider.of<UserPlacesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Places"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _addPlaces,
                maxLength: 20,
                maxLines: 1,
                decoration: const InputDecoration(hintText: "Add Places"),
                cursorColor: Colors.black,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Can/t be empty!!";
                  }
                  return null;
                },
              ),
              TextButton.icon(
                onPressed: () {
                  placeBLoc.addPlace(_addPlaces.text);
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.add),
                label: const Text("Add Place"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
