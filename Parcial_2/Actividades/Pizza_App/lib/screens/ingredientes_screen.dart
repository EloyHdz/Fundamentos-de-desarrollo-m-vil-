import 'package:flutter/material.dart';
import '../services/supabase_service.dart';

class IngredientesScreen extends StatefulWidget {
  final int pizzaId;
  final String nombrePizza;

  const IngredientesScreen({
    super.key,
    required this.pizzaId,
    required this.nombrePizza,
  });

  @override
  State<IngredientesScreen> createState() => _IngredientesScreenState();
}

class _IngredientesScreenState extends State<IngredientesScreen> {
  final SupabaseService service = SupabaseService();

  List<Map<String, dynamic>> ingredientes = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    cargarIngredientes();
  }

  Future<void> cargarIngredientes() async {
    try {
      final data = await service.getIngredientes(widget.pizzaId);

      setState(() {
        ingredientes = data;
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.nombrePizza),
        backgroundColor: Colors.deepPurple,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ingredientes.isEmpty
              ? const Center(
                  child: Text(
                    "No hay ingredientes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: ingredientes.length,
                  itemBuilder: (context, index) {
                    final ingrediente = ingredientes[index];

                    return Card(
                      color: Colors.grey.shade900,
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        title: Text(
                          ingrediente['nombre'].toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}