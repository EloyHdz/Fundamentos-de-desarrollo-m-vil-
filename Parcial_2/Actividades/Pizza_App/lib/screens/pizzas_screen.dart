import 'package:flutter/material.dart';
import 'ingredientes_screen.dart';
import '../services/supabase_service.dart';

class PizzasScreen extends StatefulWidget {
  const PizzasScreen({super.key});

  @override
  State<PizzasScreen> createState() => _PizzasScreenState();
}

class _PizzasScreenState extends State<PizzasScreen> {
  final SupabaseService service = SupabaseService();

  List<Map<String, dynamic>> pizzas = [];
  bool loading = true;

  String obtenerImagen(String nombre) {
    switch (nombre.toLowerCase()) {
      case 'pepperoni':
        return 'assets/images/pepperoni.png';

      case 'hawaiana':
        return 'assets/images/hawaiana.png';

      case 'mexicana':
        return 'assets/images/mexicana.png';

      case 'cuatro quesos':
        return 'assets/images/cuatroquesos.jpg';

      default:
        return 'assets/images/pepperoni.png';
    }
  }

  @override
  void initState() {
    super.initState();
    cargarPizzas();
  }

  Future<void> cargarPizzas() async {
    try {
      final data = await service.getPizzas();

      setState(() {
        pizzas = data;
        loading = false;
      });
    } catch (e) {
      print(e);

      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050816),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          '🍕 CYBER PIZZA',
          style: TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: pizzas.length,
              itemBuilder: (context, index) {
                final pizza = pizzas[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => IngredientesScreen(
                          pizzaId: int.parse(
                            pizza['id'].toString(),
                          ),
                          nombrePizza:
                              pizza['nombre'].toString(),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.cyanAccent,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyanAccent.withOpacity(0.3),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.vertical(
                            top: Radius.circular(18),
                          ),
                          child: Image.asset(
                            obtenerImagen(
                              pizza['nombre']
                                  .toString(),
                            ),
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (
                                  context,
                                  error,
                                  stackTrace,
                                ) {
                              return Container(
                                height: 220,
                                color: Colors.red,
                                child: const Center(
                                  child: Text(
                                    "Imagen no encontrada",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.all(15),
                          decoration:
                              const BoxDecoration(
                            color: Color(0xFF111827),
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                pizza['nombre']
                                    .toString(),
                                style:
                                    const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(
                                  height: 8),

                              Text(
                                '\$${pizza['precio']}',
                                style:
                                    const TextStyle(
                                  color:
                                      Colors.greenAccent,
                                  fontSize: 18,
                                ),
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
    );
  }
}