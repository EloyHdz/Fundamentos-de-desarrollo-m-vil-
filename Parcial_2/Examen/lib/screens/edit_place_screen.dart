import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditPlaceScreen extends StatefulWidget {
  final Map place;

  const EditPlaceScreen({
    super.key,
    required this.place,
  });

  @override
  State<EditPlaceScreen> createState() =>
      _EditPlaceScreenState();
}

class _EditPlaceScreenState
    extends State<EditPlaceScreen> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.place['name'],
    );

    descriptionController =
        TextEditingController(
      text: widget.place['description'],
    );
  }

  Future<void> updatePlace() async {
    try {
      await Supabase.instance.client
          .from('places')
          .update({
        'name': nameController.text,
        'description':
            descriptionController.text,
      }).eq(
        'id',
        widget.place['id'],
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Lugar actualizado',
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content:
              Text('Error: $e'),
        ),
      );
    }
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EDITAR LUGAR',
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints:
                const BoxConstraints(
              maxWidth: 600,
            ),
            margin:
                const EdgeInsets.all(20),
            padding:
                const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color:
                  const Color(0xFF141421),
              borderRadius:
                  BorderRadius.circular(
                25,
              ),
              border: Border.all(
                color: const Color(
                  0xFF00F7FF,
                ),
              ),
              boxShadow: const [
                BoxShadow(
                  color:
                      Color(0x5500F7FF),
                  blurRadius: 25,
                ),
              ],
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.edit_location_alt,
                  size: 90,
                  color:
                      Color(0xFFFF00FF),
                ),

                const SizedBox(
                  height: 10,
                ),

                const Text(
                  'EDITAR LUGAR',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color(0xFFFF00FF),
                    shadows: [
                      Shadow(
                        color: Color(
                          0xFFFF00FF,
                        ),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                TextField(
                  controller:
                      nameController,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Nombre',
                    prefixIcon:
                        Icon(
                      Icons.place,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                TextField(
                  controller:
                      descriptionController,
                  maxLines: 3,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Descripción',
                    prefixIcon:
                        Icon(
                      Icons.description,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                SizedBox(
                  width:
                      double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed:
                        updatePlace,
                    child:
                        const Text(
                      'ACTUALIZAR',
                      style:
                          TextStyle(
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}