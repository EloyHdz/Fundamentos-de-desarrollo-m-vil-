import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'add_place_screen.dart';
import 'edit_place_screen.dart';
import 'map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> places = [];
  List<dynamic> filteredPlaces = [];

  String searchText = '';
  String selectedCategory = 'Todos';

  @override
  void initState() {
    super.initState();
    loadPlaces();
  }

  Future<void> loadPlaces() async {
    try {
      final data = await Supabase.instance.client
          .from('places')
          .select();

      places = data;
      applyFilters();
    } catch (e) {
      debugPrint('ERROR: $e');
    }
  }

  void applyFilters() {
    filteredPlaces = places.where((place) {
      final matchesSearch = (place['name'] ?? '')
          .toString()
          .toLowerCase()
          .contains(searchText.toLowerCase());

      final matchesCategory =
          selectedCategory == 'Todos' ||
          place['category'] == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    setState(() {});
  }

  Future<void> deletePlace(String id) async {
    await Supabase.instance.client
        .from('places')
        .delete()
        .eq('id', id);

    loadPlaces();
  }

  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MIS LUGARES FAVORITOS',
        ),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'CYBER FAVORITES',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00F7FF),
                    letterSpacing: 3,
                    shadows: [
                      Shadow(
                        color: Color(0xFF00F7FF),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  user?.email ?? '',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 15),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF141421),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFFF00FF),
                    ),
                  ),
                  child: Text(
                    'Lugares encontrados: ${filteredPlaces.length}',
                    style: const TextStyle(
                      color: Color(0xFFFF00FF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Buscar lugar...',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    searchText = value;
                    applyFilters();
                  },
                ),

                const SizedBox(height: 10),

                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Filtrar categoría',
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Todos',
                      child: Text('Todos'),
                    ),
                    DropdownMenuItem(
                      value: 'Parque',
                      child: Text('Parque'),
                    ),
                    DropdownMenuItem(
                      value: 'Restaurante',
                      child: Text('Restaurante'),
                    ),
                    DropdownMenuItem(
                      value: 'Compras',
                      child: Text('Compras'),
                    ),
                    DropdownMenuItem(
                      value: 'Escuela',
                      child: Text('Escuela'),
                    ),
                    DropdownMenuItem(
                      value: 'Otro',
                      child: Text('Otro'),
                    ),
                  ],
                  onChanged: (value) {
                    selectedCategory = value!;
                    applyFilters();
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: filteredPlaces.isEmpty
                ? const Center(
                    child: Text(
                      'No hay lugares guardados',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredPlaces.length,
                    itemBuilder: (context, index) {
                      final place = filteredPlaces[index];

                      return AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 400,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF141421),
                          borderRadius:
                              BorderRadius.circular(20),
                          border: Border.all(
                            color:
                                const Color(0xFF00F7FF),
                            width: 1.5,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x5500F7FF),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              if (place['image_url'] != null)
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(
                                          16),
                                  child: Image.network(
                                    place['image_url'],
                                    width:
                                        double.infinity,
                                    height: 220,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                              const SizedBox(height: 10),

                              ListTile(
                                leading: const Icon(
                                  Icons.location_on,
                                  color:
                                      Color(0xFF00F7FF),
                                  size: 35,
                                ),

                                onTap: () {
                                  if (place['latitude'] !=
                                          null &&
                                      place['longitude'] !=
                                          null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            MapScreen(
                                          latitude:
                                              (place['latitude']
                                                      as num)
                                                  .toDouble(),
                                          longitude:
                                              (place['longitude']
                                                      as num)
                                                  .toDouble(),
                                        ),
                                      ),
                                    );
                                  }
                                },

                                title: Text(
                                  place['name'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight:
                                        FontWeight.bold,
                                    color:
                                        Color(0xFFFF00FF),
                                  ),
                                ),

                                subtitle: Text(
                                  '${place['description'] ?? ''}\n\n'
                                  'Categoría: ${place['category'] ?? 'Sin categoría'}',
                                  style: const TextStyle(
                                    color:
                                        Colors.white70,
                                  ),
                                ),

                                trailing: Row(
                                  mainAxisSize:
                                      MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Color(
                                            0xFF00F7FF),
                                      ),
                                      onPressed:
                                          () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) =>
                                                    EditPlaceScreen(
                                              place:
                                                  place,
                                            ),
                                          ),
                                        );

                                        loadPlaces();
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Color(
                                            0xFFFF007F),
                                      ),
                                      onPressed:
                                          () async {
                                        final confirmar =
                                            await showDialog<
                                                bool>(
                                          context:
                                              context,
                                          builder:
                                              (context) {
                                            return AlertDialog(
                                              title:
                                                  const Text(
                                                'Eliminar',
                                              ),
                                              content:
                                                  const Text(
                                                '¿Deseas eliminar este lugar?',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed:
                                                      () {
                                                    Navigator.pop(
                                                      context,
                                                      false,
                                                    );
                                                  },
                                                  child:
                                                      const Text(
                                                    'Cancelar',
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed:
                                                      () {
                                                    Navigator.pop(
                                                      context,
                                                      true,
                                                    );
                                                  },
                                                  child:
                                                      const Text(
                                                    'Eliminar',
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );

                                        if (confirmar ==
                                            true) {
                                          await deletePlace(
                                            place['id'],
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 25,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AddPlaceScreen(),
            ),
          );

          loadPlaces();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}