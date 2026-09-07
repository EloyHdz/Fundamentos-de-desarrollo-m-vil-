import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Registro de Preferencias',
      home: const RegistroPage(),
    );
  }
}

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  String genero = "Masculino";
  String pais = "México";

  bool deporte = false;
  bool musica = false;
  bool cine = false;
  bool lectura = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Preferencias"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [

            // Sección 1
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xffe9eef5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blueGrey.shade200),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        "Seccion 1: Informacion General",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Completa los siguientes datos personales básicos",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Sección 2
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xffdfeae0),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.person, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        "Seccion 2: Datos Personales",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.person),
                      hintText: "Nombre completo",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.calendar_month),
                      hintText: "Edad",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Sección 3
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xfff5ebd9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.view_column, color: Colors.orange),
                      SizedBox(width: 8),
                      Text(
                        "Seccion 3: Distribucion en Filas",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  filaColor("Fila 1 - Color Rojo",
                      Colors.red.shade100, Colors.red),

                  const SizedBox(height: 10),

                  filaColor("Fila 2 - Color Amarillo",
                      Colors.yellow.shade100, Colors.yellow.shade700),

                  const SizedBox(height: 10),

                  filaColor("Fila 3 - Color Azul",
                      Colors.blue.shade100, Colors.blue),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Sección 4
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xffeee2f2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.grid_view, color: Colors.purple),
                      SizedBox(width: 8),
                      Text(
                        "Seccion 4: Cuatro Hijos en Colores",
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      hijo("Hijo 1", Colors.pink.shade100),
                      hijo("Hijo 2", Colors.orange.shade100),
                      hijo("Hijo 3", Colors.green.shade100),
                      hijo("Hijo 4", Colors.deepPurple.shade100),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Sección 5
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Row(
                    children: [
                      Icon(Icons.add_circle_outline),
                      SizedBox(width: 8),
                      Text(
                        "Seccion 5: Controles UI",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Genero:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  RadioListTile(
                    title: const Text("Masculino"),
                    value: "Masculino",
                    groupValue: genero,
                    onChanged: (value) {
                      setState(() {
                        genero = value!;
                      });
                    },
                  ),

                  RadioListTile(
                    title: const Text("Femenino"),
                    value: "Femenino",
                    groupValue: genero,
                    onChanged: (value) {
                      setState(() {
                        genero = value!;
                      });
                    },
                  ),

                  RadioListTile(
                    title: const Text("Otro"),
                    value: "Otro",
                    groupValue: genero,
                    onChanged: (value) {
                      setState(() {
                        genero = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Intereses:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  CheckboxListTile(
                    title: const Text("Deporte"),
                    value: deporte,
                    onChanged: (value) {
                      setState(() => deporte = value!);
                    },
                  ),

                  CheckboxListTile(
                    title: const Text("Musica"),
                    value: musica,
                    onChanged: (value) {
                      setState(() => musica = value!);
                    },
                  ),

                  CheckboxListTile(
                    title: const Text("Cine"),
                    value: cine,
                    onChanged: (value) {
                      setState(() => cine = value!);
                    },
                  ),

                  CheckboxListTile(
                    title: const Text("Lectura"),
                    value: lectura,
                    onChanged: (value) {
                      setState(() => lectura = value!);
                    },
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Pais:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  DropdownButtonFormField(
                    value: pais,
                    items: const [
                      DropdownMenuItem(
                        value: "México",
                        child: Text("México"),
                      ),
                      DropdownMenuItem(
                        value: "USA",
                        child: Text("USA"),
                      ),
                      DropdownMenuItem(
                        value: "Canadá",
                        child: Text("Canadá"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        pais = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.visibility),
                          label: const Text("Mostrar Preferencias"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.check_circle),
                          label: const Text("Guardar Registro"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filaColor(String texto, Color fondo, Color circulo) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: fondo,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 8,
            backgroundColor: circulo,
          ),
          const SizedBox(width: 10),
          Text(texto),
        ],
      ),
    );
  }

  Widget hijo(String texto, Color color) {
    return Container(
      width: 52,
      height: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(texto),
    );
  }
}
