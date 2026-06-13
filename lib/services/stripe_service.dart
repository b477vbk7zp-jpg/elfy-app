import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeWorkflowService {
  void configurarLlavePublica() {
    Stripe.publishableKey = 'pk_test_tu_llave_publica_aqui';
  }

  Future<bool> ejecutarSuscripcionPremium(BuildContext context) async {
    try {
      final urlBackend = Uri.parse('https://tu-servidor-backend.com');

      final respuestaServidor = await http.post(
        urlBackend,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'plan_id': 'elfy_premium_mensual',
          'moneda': 'usd'
        }),
      );

      if (respuestaServidor.statusCode != 200) {
        throw Exception('El servidor backend falló al generar el Payment Intent.');
      }

      final datosPago = jsonDecode(respuestaServidor.body);
      final String tokenClienteSecreto = datosPago['client_secret'];

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: tokenClienteSecreto,
          style: ThemeMode.light,
          merchantDisplayName: 'Elfy Patronaje Premium',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Pago Exitoso! Tu cuenta Elfy ahora es Premium.')),
        );
      }
      return true;
    } on StripeException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Transacción interrumpida: ${e.error.localizedMessage}')),
        );
      }
      return false;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error del sistema: $e')),
        );
      }
      return false;
    }
  }
}