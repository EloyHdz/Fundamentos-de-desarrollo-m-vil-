import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'select_location_screen.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() =>
      _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final nameController = TextEditingController();
  final descriptionController =
      TextEditingController();

  String categoria = 'Parque';

  LatLng? selectedLocation;

  Uint8List? imageBytes;
  String? imageName;

  Future<void> pickImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      imageBytes = await image.readAsBytes();

      setState(() {
        imageName = image.name;
      });
    }
  }

  Future<void> savePlace() async {
    try {
      final user =
          Supabase.instance.client.auth.currentUser;

      String? imageUrl;

      if (imageBytes != null) {
        final fileName =
            '${DateTime.now().millisecondsSinceEpoch}_$imageName';

        await Supabase.instance.client.storage
            .from('places-images')
            .uploadBinary(
              fileName,
              imageBytes!,
            );

        imageUrl = Supabase.instance.client.storage
            .from('places-images')
            .getPublicUrl(fileName);
      }

      await Supabase.instance.client
          .from('places')
          .insert({
        'user_id': user!.id,
        'name': nameController.text,
        'description':
            descriptionController.text,
        'category': categoria,
        'latitude':
            selectedLocation?.latitude,
        'longitude':
            selectedLocation?.longitude,
        'image_url': imageUrl,
      });

      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'Error: $e',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AGREGAR LUGAR',
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints:
                const BoxConstraints(
              maxWidth: 650,
            ),
            margin:
                const EdgeInsets.all(20),
            padding:
                const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: const Color(
                0xFF141421,
              ),
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
                  Icons.add_location_alt,
                  size: 90,
                  color:
                      Color(0xFF00F7FF),
                ),

                const SizedBox(
                  height: 10,
                ),

                const Text(
                  'AGREGAR LUGAR',
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
                        'Nombre del lugar',
                    prefixIcon:
                        Icon(Icons.place),
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                TextField(
                  controller:
                      descriptionController,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Descripción',
                    prefixIcon: Icon(
                      Icons.description,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                DropdownButtonFormField<
                    String>(
                  value: categoria,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Categoría',
                    prefixIcon:
                        Icon(Icons.category),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Parque',
                      child:
                          Text('Parque'),
                    ),
                    DropdownMenuItem(
                      value:
                          'Restaurante',
                      child: Text(
                          'Restaurante'),
                    ),
                    DropdownMenuItem(
                      value:
                          'Compras',
                      child:
                          Text('Compras'),
                    ),
                    DropdownMenuItem(
                      value:
                          'Escuela',
                      child:
                          Text('Escuela'),
                    ),
                    DropdownMenuItem(
                      value: 'Otro',
                      child: Text(
                          'Otro'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      categoria = value!;
                    });
                  },
                ),

                const SizedBox(
                  height: 20,
                ),

                ElevatedButton.icon(
                  onPressed: () async {
                    final result =
                        await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const SelectLocationScreen(),
                      ),
                    );

                    if (result != null) {
                      setState(() {
                        selectedLocation =
                            result;
                      });
                    }
                  },
                  icon:
                      const Icon(Icons.map),
                  label: const Text(
                    'SELECCIONAR UBICACIÓN',
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.all(
                    15,
                  ),
                  decoration:
                      BoxDecoration(
                    borderRadius:
                        BorderRadius
                            .circular(15),
                    border: Border.all(
                      color:
                          const Color(
                        0xFF00F7FF,
                      ),
                    ),
                  ),
                  child: Text(
                    selectedLocation ==
                            null
                        ? 'Ubicación no seleccionada'
                        : 'Lat: ${selectedLocation!.latitude}\nLng: ${selectedLocation!.longitude}',
                    textAlign:
                        TextAlign.center,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                ElevatedButton.icon(
                  onPressed: pickImage,
                  icon: const Icon(
                    Icons.image,
                  ),
                  label: const Text(
                    'SELECCIONAR IMAGEN',
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                if (imageBytes != null)
                  ClipRRect(
                    borderRadius:
                        BorderRadius
                            .circular(15),
                    child: Image.memory(
                      imageBytes!,
                      height: 250,
                      fit: BoxFit.cover,
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
                        savePlace,
                    child:
                        const Text(
                      'GUARDAR LUGAR',
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