import 'package:flutter/material.dart';
import 'lienzo_grafico_page.dart';

class AsistenteMedidasPage extends StatefulWidget {
  final String prendaId;
  const AsistenteMedidasPage({super.key, required this.prendaId});

  @override
  State<AsistenteMedidasPage> createState() => _AsistenteMedidasPageState();
}

class _AsistenteMedidasPageState extends State<AsistenteMedidasPage> {
  int _indexPaso = 0;
  final Map<String, double> _valores = {};
  final _inputCtrl = TextEditingController();
  final _nombreClienteCtrl = TextEditingController();
  late List<Map<String, String>> _pasos;

  @override
  void initState() {
    super.initState();
    _inicializarPasos();
  }

  void _inicializarPasos() {
    if (widget.prendaId == 'blusa_superior') {
      _pasos = [
        {'clave': 'C_BUSTO', 'titulo': 'Contorno de Busto', 'desc': 'Pasa la cinta por la zona más prominente.'},
        {'clave': 'C_CUELLO', 'titulo': 'Contorno de Cuello', 'desc': 'Mide la base del cuello sin apretar.'},
        {'clave': 'T_DELANTERO', 'titulo': 'Largo Talle Delantero', 'desc': 'Desde el cuello hasta la cintura por delante.'},
        {'clave': 'T_ESPALDA', 'titulo': 'Largo Talle Espalda', 'desc': 'Desde el cuello hasta la cintura por la espalda.'},
      ];
    } else if (widget.prendaId == 'manga_base') {
      _pasos = [
        {'clave': 'R_SISA', 'titulo': 'Recorrido Total de Sisa', 'desc': 'Mide la curva de la sisa de tu patrón base en cm.'},
        {'clave': 'L_BRAZO', 'titulo': 'Largo Total del Brazo', 'desc': 'Desde el hueso del hombro hasta la muñeca.'},
      ];
    } else {
      _pasos = [
        {'clave': 'C_CINTURA', 'titulo': 'Contorno de Cintura', 'desc': 'Circunferencia anatómica natural.'},
        {'clave': 'C_CADERA', 'titulo': 'Contorno de Cadera', 'desc': 'Sobre la parte más prominente de los glúteos.'},
        {'clave': 'A_CADERA', 'titulo': 'Altura de Cadera', 'desc': 'Distancia vertical desde la cintura a la cadera.'},
        {'clave': 'L_FALDA', 'titulo': 'Largo de Falda', 'desc': 'Longitud vertical total de la pieza.'},
      ];
    }
  }

  void _procesarPaso() {
    double? v = double.tryParse(_inputCtrl.text);
    if (v == null || v <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingresa un valor válido mayor a 0')),
      );
      return;
    }

    _valores[_pasos[_indexPaso]['clave']!] = v;

    if (_indexPaso < _pasos.length - 1) {
      setState(() {
        _indexPaso++;
        _inputCtrl.clear();
      });
    } else {
      _solicitarNombreYGuardar();
    }
  }

  void _solicitarNombreYGuardar() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Ficha Técnica de Cliente',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _nombreClienteCtrl,
              decoration: const InputDecoration(
                labelText: 'Nombre del Cliente',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_nombreClienteCtrl.text.isNotEmpty) {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LienzoGraficoPage(
                        prendaId: widget.prendaId,
                        medidas: _valores,
                        nombreCliente: _nombreClienteCtrl.text,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Por favor ingresa el nombre del cliente')),
                  );
                }
              },
              child: const Text('Guardar y Dibujar Patrón'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final paso = _pasos[_indexPaso];
    final progreso = (_indexPaso + 1) / _pasos.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Asistente de Medidas'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Paso ${_indexPaso + 1} de ${_pasos.length}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progreso,
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              paso['titulo']!,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              paso['desc']!,
              style: const TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _inputCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Medida en cm',
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.straighten),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _procesarPaso(),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _procesarPaso,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  _indexPaso == _pasos.length - 1 ? 'Finalizar Medidas' : 'Siguiente',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _inputCtrl.dispose();
    _nombreClienteCtrl.dispose();
    super.dispose();
  }
}