import 'package:flutter/material.dart';
import 'asistente_medidas_page.dart';

class PrendaItem {
  final String id;
  final String titulo;
  final String descripcion;
  final IconData icono;
  final String dificultad;

  PrendaItem({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.icono,
    required this.dificultad,
  });
}

class BibliotecaPrendasPage extends StatelessWidget {
  const BibliotecaPrendasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PrendaItem> prendas = [
      PrendaItem(
        id: 'falda_base',
        titulo: 'Falda Básica',
        descripcion: 'Molde base para falda línea A, recta o tubo. Ideal para comenzar.',
        icono: Icons.layers_outlined,
        dificultad: 'Fácil',
      ),
      PrendaItem(
        id: 'blusa_superior',
        titulo: 'Blusa Superior / Torso',
        descripcion: 'Bloque superior con control anatómico de talle, busto y pinzas.',
        icono: Icons.accessibility_new_outlined,
        dificultad: 'Avanzada',
      ),
      PrendaItem(
        id: 'manga_base',
        titulo: 'Manga Industrial',
        descripcion: 'Cálculo de copa y ancho de brazo compatible con sisas escaladas.',
        icono: Icons.gesture_outlined,
        dificultad: 'Media',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('Biblioteca de Prendas', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¿Qué patrón vas a diseñar hoy?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text('Selecciona una base para activar al asistente técnico.', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: prendas.length,
                itemBuilder: (context, index) {
                  final prenda = prendas[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AsistenteMedidasPage(prendaId: prenda.id),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(prenda.icono, size: 32, color: Colors.blue.shade800),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(prenda.titulo, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                      _construirEtiquetaDificultad(prenda.dificultad),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(prenda.descripcion, style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1.3)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirEtiquetaDificultad(String dificultad) {
    Color colorEtiqueta = Colors.green;
    if (dificultad == 'Media') colorEtiqueta = Colors.orange;
    if (dificultad == 'Avanzada') colorEtiqueta = Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorEtiqueta.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        dificultad,
        style: TextStyle(color: colorEtiqueta, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}