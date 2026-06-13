# 🧵 Elfy - Patronaje Digital Industrial

Aplicación Flutter para diseño y cálculo automático de patrones de costura con medidas personalizadas.

## 📋 Características

- ✅ Autenticación de usuarios (Login/Registro)
- ✅ Biblioteca de prendas base (Falda, Blusa, Manga)
- ✅ Asistente de medidas secuencial
- ✅ Generación de patrones vectoriales automáticos
- ✅ Integración con Stripe para pagos premium
- ✅ Base de datos local con Isar
- ✅ Exportación de patrones en PDF

## 🚀 Instalación

### Requisitos previos
- Flutter 3.0 o superior
- Dart 3.0 o superior

### Pasos de instalación

```bash
# Clonar el repositorio
git clone https://github.com/b477vbk7zp-jpg/elfy-app.git
cd elfy_app

# Instalar dependencias
flutter pub get

# Ejecutar la aplicación
flutter run
```

## 📁 Estructura del Proyecto

```
lib/
├── main.dart                      # Punto de entrada de la app
├── pages/
│   ├── auth_page.dart            # Pantalla de autenticación
│   ├── biblioteca_prendas_page.dart  # Catálogo de prendas
│   ├── asistente_medidas_page.dart   # Recopilación de medidas
│   └── lienzo_grafico_page.dart      # Visualización de patrones
└── services/
    └── stripe_service.dart        # Integración de pagos
```

## 🔧 Dependencias

- **flutter**: Framework UI
- **isar**: Base de datos local
- **path_provider**: Acceso a directorios del dispositivo
- **flutter_stripe**: Integración de pagos
- **pdf**: Exportación de patrones
- **http**: Comunicación con backend

## 📱 Uso

### 1. Iniciar sesión
```
Email: diseñador@elfy.com
Contraseña: 123456
```

### 2. Seleccionar prenda
Elige entre Falda, Blusa o Manga

### 3. Ingresar medidas
Sigue el asistente secuencial para tomar medidas

### 4. Visualizar patrón
El patrón se genera automáticamente con tus medidas

## 🛠️ Configuración de Stripe

Para habilitar pagos:

1. Ve a `lib/services/stripe_service.dart`
2. Reemplaza `pk_test_tu_llave_publica_aqui` con tu llave pública de Stripe
3. Configura tu backend para generar Payment Intents

## 📦 Compilación

### Android
```bash
flutter build apk
```

### iOS
```bash
flutter build ios
```

## 🤝 Contribuir

Las contribuciones son bienvenidas. Para cambios importantes:

1. Fork el repositorio
2. Crea una rama (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo licencia MIT.

## 📧 Contacto

Para más información, contacta al equipo de Elfy.

---

**Desarrollado con ❤️ para diseñadores de moda**
