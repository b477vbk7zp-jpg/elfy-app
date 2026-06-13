import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class LienzoGraficoPage extends StatefulWidget {
  final String prendaId;
  final Map<String, double> medidas;
  final String nombreCliente;

  const LienzoGraficoPage({
    super.key,
    required this.prendaId,
    required this.medidas,
    required this.nombreCliente,
  });

  @override
  State<LienzoGraficoPage> createState() => _LienzoGraficoPageState();
}

class _LienzoGraficoPageState extends State<LienzoGraficoPage> {
  double _escala = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patrón Generado'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              _mostrarDetallesMedidas();
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Función de descarga en desarrollo')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: Row(
              children: [
                const Icon(Icons.person, color: Colors.blue),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Cliente:', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    Text(widget.nombreCliente, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _obtenerNombrePrenda(widget.prendaId),
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: InteractiveViewer(
                onInteractionUpdate: (details) {
                  setState(() {
                    _escala = details.scale;
                  });
                },
                child: CustomPaint(
                  painter: PatronPainter(
                    prendaId: widget.prendaId,
                    medidas: widget.medidas,
                  ),
                  size: const Size(600, 800),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Ajustar Medidas'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Patrón guardado en base de datos')),
                    );
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _obtenerNombrePrenda(String id) {
    switch (id) {
      case 'falda_base':
        return 'Falda';
      case 'blusa_superior':
        return 'Blusa';
      case 'manga_base':
        return 'Manga';
      default:
        return 'Patrón';
    }
  }

  void _mostrarDetallesMedidas() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detalle de Medidas'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.medidas.entries
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.key, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text('${e.value.toStringAsFixed(1)} cm'),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}

class PatronPainter extends CustomPainter {
  final String prendaId;
  final Map<String, double> medidas;

  PatronPainter({required this.prendaId, required this.medidas});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = Colors.blue.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), fillPaint);

    if (prendaId == 'falda_base') {
      _dibujarFalda(canvas, size, paint, fillPaint, textPainter);
    } else if (prendaId == 'blusa_superior') {
      _dibujarBlusa(canvas, size, paint, fillPaint, textPainter);
    } else if (prendaId == 'manga_base') {
      _dibujarManga(canvas, size, paint, fillPaint, textPainter);
    }

    final titleSpan = TextSpan(
      text: 'Patrón Base - ${_obtenerNombrePrenda(prendaId)}',
      style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
    );
    textPainter.text = titleSpan;
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width / 2 - textPainter.width / 2, 20));
  }

  void _dibujarFalda(Canvas canvas, Size size, Paint paint, Paint fillPaint, TextPainter textPainter) {
    double cintura = medidas['C_CINTURA'] ?? 80;
    double cadera = medidas['C_CADERA'] ?? 100;
    double largo = medidas['L_FALDA'] ?? 60;

    double escala = (size.width - 60) / (cadera + 10);

    double startX = size.width / 2;
    double startY = 100;

    double anchoDelantero = cadera / 4;
    double anchoEspalda = cadera / 4;

    canvas.drawPath(
      Path()
        ..moveTo(startX - anchoDelantero * escala / 2, startY)
        ..lineTo(startX - anchoDelantero * escala / 2, startY + largo * escala)
        ..lineTo(startX + anchoDelantero * escala / 2, startY + largo * escala)
        ..lineTo(startX + anchoDelantero * escala / 2, startY)
        ..close(),
      paint,
    );

    _dibujarEtiqueta(canvas, textPainter, startX, startY + largo * escala + 20, 'Falda Delantero');
  }

  void _dibujarBlusa(Canvas canvas, Size size, Paint paint, Paint fillPaint, TextPainter textPainter) {
    double busto = medidas['C_BUSTO'] ?? 90;
    double talleDelantero = medidas['T_DELANTERO'] ?? 45;

    double escala = (size.width - 60) / (busto + 10);
    double startX = size.width / 2;
    double startY = 100;

    double anchoBlusa = busto / 4;

    canvas.drawPath(
      Path()
        ..moveTo(startX - anchoBlusa * escala / 2, startY)
        ..lineTo(startX - anchoBlusa * escala / 2, startY + talleDelantero * escala)
        ..lineTo(startX + anchoBlusa * escala / 2, startY + talleDelantero * escala)
        ..lineTo(startX + anchoBlusa * escala / 2, startY)
        ..close(),
      paint,
    );

    _dibujarEtiqueta(canvas, textPainter, startX, startY + talleDelantero * escala + 20, 'Blusa Delantero');
  }

  void _dibujarManga(Canvas canvas, Size size, Paint paint, Paint fillPaint, TextPainter textPainter) {
    double recorridoSisa = medidas['R_SISA'] ?? 40;
    double largoBrazo = medidas['L_BRAZO'] ?? 55;

    double escala = (size.width - 60) / (recorridoSisa + 10);
    double startX = size.width / 2;
    double startY = 100;

    double anchoCopa = recorridoSisa / 2;

    canvas.drawPath(
      Path()
        ..moveTo(startX - anchoCopa * escala / 2, startY)
        ..lineTo(startX - anchoCopa * escala / 4, startY + largoBrazo * escala)
        ..lineTo(startX + anchoCopa * escala / 4, startY + largoBrazo * escala)
        ..lineTo(startX + anchoCopa * escala / 2, startY)
        ..close(),
      paint,
    );

    _dibujarEtiqueta(canvas, textPainter, startX, startY + largoBrazo * escala + 20, 'Manga');
  }

  void _dibujarEtiqueta(Canvas canvas, TextPainter textPainter, double x, double y, String texto) {
    final span = TextSpan(
      text: texto,
      style: const TextStyle(color: Colors.black54, fontSize: 12),
    );
    textPainter.text = span;
    textPainter.layout();
    textPainter.paint(canvas, Offset(x - textPainter.width / 2, y));
  }

  String _obtenerNombrePrenda(String id) {
    switch (id) {
      case 'falda_base':
        return 'Falda';
      case 'blusa_superior':
        return 'Blusa';
      case 'manga_base':
        return 'Manga';
      default:
        return 'Patrón';
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}