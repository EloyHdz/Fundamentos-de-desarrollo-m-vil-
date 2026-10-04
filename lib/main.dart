import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://blirrfjopirzzuxnyfql.supabase.co',
    anonKey: 'TU_ANON_KEY',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cyber Music',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List canciones = [];
  List cancionesFiltradas = [];

  final TextEditingController searchController =
      TextEditingController();

  Future<void> reproducirYoutube(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      throw Exception(
        'No se pudo abrir la URL',
      );
    }
  }

  Future<void> cargarCanciones() async {
    try {
      final datos =
          await Supabase.instance.client
              .from('canciones')
              .select();

      setState(() {
        canciones = datos;
        cancionesFiltradas = datos;
      });
    } catch (e) {
      print(e);
    }
  }

  void filtrarCanciones(String texto) {
    setState(() {
      cancionesFiltradas = canciones.where(
        (cancion) {
          return cancion['titulo']
              .toString()
              .toLowerCase()
              .contains(
                texto.toLowerCase(),
              );
        },
      ).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    cargarCanciones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF050816),
      appBar: AppBar(
        backgroundColor:
            Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          "CYBER MUSIC",
          style: TextStyle(
            color: Colors.cyanAccent,
            fontWeight:
                FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),

          Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: TextField(
              controller:
                  searchController,
              onChanged:
                  filtrarCanciones,
              decoration:
                  InputDecoration(
                hintText:
                    "Buscar canción",
                prefixIcon:
                    const Icon(
                  Icons.search,
                ),
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                          20),
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          Expanded(
            child:
                ListView.builder(
              itemCount:
                  cancionesFiltradas
                      .length,
              itemBuilder:
                  (context, index) {
                final cancion =
                    cancionesFiltradas[
                        index];

                return Card(
                  margin:
                      const EdgeInsets.all(
                          10),
                  child: ListTile(
                    leading:
                        const Icon(
                      Icons.music_note,
                      color: Colors
                          .cyanAccent,
                    ),
                    title: Text(
                      cancion['titulo']
                          .toString(),
                    ),
                    subtitle: Text(
                      cancion[
                              'artista']
                          .toString(),
                    ),
                    trailing:
                        IconButton(
                      icon:
                          const Icon(
                        Icons
                            .play_circle_fill,
                        size: 40,
                        color: Colors
                            .greenAccent,
                      ),
                      onPressed:
                          () async {
                        final url =
                            cancion[
                                'youtube_url'];

                        print(
                            'URL: $url');

                        if (url !=
                                null &&
                            url
                                .toString()
                                .isNotEmpty) {
                          await reproducirYoutube(
                            url.toString(),
                          );
                        } else {
                          ScaffoldMessenger.of(
                                  context)
                              .showSnackBar(
                            const SnackBar(
                              content:
                                  Text(
                                'Esta canción no tiene enlace configurado',
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}