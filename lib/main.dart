import 'package:flutter/material.dart';
import 'dart:math' as math;

// Si quieres que el botón de Instagram abra el enlace, habilita estas importaciones
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const VRUniverseApp());
}

class VRUniverseApp extends StatelessWidget {
  const VRUniverseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VR Universe - Alquiler de Lentes VR',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF00FFC8),
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        fontFamily: 'Arial',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // Paleta de colores principal
  final Color _color1 = const Color(0xFF00FFC8); // Acento VR
  final Color _color2 = const Color(0xFF0A2F35); // Tono oscuro azulado
  final Color _color3 = const Color(0xFF181818); // Gris muy oscuro
  final Color _color4 = const Color(0xFFD1FFD7); // Texto claro

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(); // Gira 360° indefinidamente
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Función para abrir URLs (Instagram, etc.)
  Future<void> _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      debugPrint('No se pudo abrir $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: FondoVRPainter(
          color1: _color1,
          color2: _color2,
        ),
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;
              return Column(
                children: [
                  // HEADER
                  SizedBox(
                    width: double.infinity,
                    height: isMobile ? 450 : 500,
                    child: Stack(
                      children: [
                        // Texto principal
                        Positioned.fill(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 20 : 80,
                              vertical: isMobile ? 40 : 80,
                            ),
                            child: Column(
                              crossAxisAlignment: isMobile
                                  ? CrossAxisAlignment.center
                                  : CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'VR Universe\nAlquiler de Lentes VR',
                                  textAlign:
                                  isMobile ? TextAlign.center : TextAlign.left,
                                  style: TextStyle(
                                    fontSize: isMobile ? 28 : 42,
                                    fontWeight: FontWeight.bold,
                                    color: _color4,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Realidad Virtual para tus eventos en Buenos Aires, Argentina.\n'
                                      'Comicons, Cumpleaños, Fiestas, Eventos Corporativos y más.',
                                  textAlign:
                                  isMobile ? TextAlign.center : TextAlign.left,
                                  style: TextStyle(
                                    fontSize: isMobile ? 16 : 20,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Visor VR frontal rotando 360°
                        Positioned(
                          right: isMobile ? 20 : 80,
                          bottom: isMobile ? 20 : 80,
                          child: AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              // Efecto de rotación continua
                              return Transform.rotate(
                                angle: _controller.value * 2 * math.pi,
                                child: child,
                              );
                            },
                            child: SizedBox(
                              width: isMobile ? 150 : 230,
                              height: isMobile ? 150 : 230,
                              child: CustomPaint(
                                painter: FrontVRPainter(
                                  color1: _color1,
                                  color2: _color2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Sección de servicios
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : 80,
                      vertical: 40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¿Por qué elegir VR Universe?',
                          style: TextStyle(
                            fontSize: isMobile ? 24 : 32,
                            fontWeight: FontWeight.bold,
                            color: _color4,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          children: [
                            _buildCard(
                              icon: Icons.event_available,
                              title: 'Eventos Corporativos',
                              description:
                              'Experiencias VR únicas para ferias y eventos '
                                  'empresariales, con alta participación e impacto.',
                              isMobile: isMobile,
                            ),
                            _buildCard(
                              icon: Icons.child_care,
                              title: 'Cumpleaños',
                              description:
                              'Sorprende a todos con mundos virtuales asombrosos '
                                  'en tus fiestas de cumpleaños.',
                              isMobile: isMobile,
                            ),
                            _buildCard(
                              icon: Icons.group,
                              title: 'Comicons',
                              description:
                              'Destaca con un stand VR innovador para fanáticos '
                                  'de la cultura geek y el cosplay.',
                              isMobile: isMobile,
                            ),
                            _buildCard(
                              icon: Icons.videogame_asset,
                              title: 'Experiencias Interactivas',
                              description:
                              'Gaming, simuladores y recorridos virtuales '
                                  'para llevar la diversión a otro nivel.',
                              isMobile: isMobile,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // CTA / Contáctanos
                  Container(
                    width: double.infinity,
                    color: _color2.withOpacity(0.8),
                    padding: EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: isMobile ? 20 : 80,
                    ),
                    child: Column(
                      crossAxisAlignment: isMobile
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contáctanos',
                          style: TextStyle(
                            fontSize: isMobile ? 24 : 32,
                            fontWeight: FontWeight.bold,
                            color: _color1,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '¿Listo para llevar tu evento al siguiente nivel?\n'
                              'Comunícate con nosotros para cotizaciones y más información.',
                          textAlign:
                          isMobile ? TextAlign.center : TextAlign.left,
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 20,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: _color1,
                            onPrimary: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 16,
                            ),
                          ),
                          onPressed: () {
                            // Aquí podrías abrir un formulario o enviar un email
                            // _launchURL('mailto:contacto@vruniverse.com');
                          },
                          child: const Text(
                            'Solicita tu cotización',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 40),
                        // Botón para Instagram
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pinkAccent,
                            onPrimary: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                          ),
                          icon: const Icon(Icons.camera_alt_outlined),
                          label: const Text(
                            'Síguenos en Instagram',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            _launchURL('https://instagram.com/vr_universe_argentina');
                          },
                        ),
                      ],
                    ),
                  ),

                  // Footer
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      '© 2025 VR Universe - Alquiler de Lentes VR, Buenos Aires, Argentina',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Tarjeta genérica para la sección de servicios
  Widget _buildCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isMobile,
  }) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: _color3.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Icon(icon, size: 50, color: _color1),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: _color4,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

// Pinta el fondo con ondas
class FondoVRPainter extends CustomPainter {
  final Color color1;
  final Color color2;

  FondoVRPainter({
    required this.color1,
    required this.color2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Gradiente lineal en la parte superior
    final rect = Rect.fromLTWH(0, 0, size.width, size.height * 0.4);
    paint.shader = LinearGradient(
      colors: [color2, color2.withOpacity(0)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(rect);
    canvas.drawRect(rect, paint);

    // Onda curvada
    final path = Path();
    path.moveTo(0, size.height * 0.3);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.35,
      size.width * 0.5,
      size.height * 0.3,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.25,
      size.width,
      size.height * 0.3,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    paint.shader = LinearGradient(
      colors: [
        color1.withOpacity(0.2),
        color1.withOpacity(0.01),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(
      Rect.fromLTWH(0, 0, size.width, size.height * 0.3),
    );
    canvas.drawPath(path, paint);

    // Segunda onda
    final path2 = Path();
    path2.moveTo(0, size.height * 0.4);
    path2.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.45,
      size.width * 0.5,
      size.height * 0.4,
    );
    path2.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.35,
      size.width,
      size.height * 0.4,
    );
    path2.lineTo(size.width, size.height * 0.3);
    path2.lineTo(0, size.height * 0.3);
    path2.close();

    paint.shader = LinearGradient(
      colors: [
        color2.withOpacity(0.3),
        color1.withOpacity(0.05),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(
      Rect.fromLTWH(0, size.height * 0.3, size.width, size.height * 0.1),
    );
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Pinta un visor VR frontal con dos lentes
// y en cada lente un gradiente blanco/transparente en el centro.
class FrontVRPainter extends CustomPainter {
  final Color color1;
  final Color color2;

  FrontVRPainter({required this.color1, required this.color2});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    // 1) Fondo circular con gradiente radial (efecto "halo")
    final Paint circlePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          color1.withOpacity(0.1),
          color1.withOpacity(0.4),
          color1,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, circlePaint);

    // 2) Cuerpo principal del visor (rectángulo con bordes redondeados)
    final double bodyWidth = size.width * 0.65;
    final double bodyHeight = size.height * 0.35;
    final double bodyLeft = (size.width - bodyWidth) / 2;
    final double bodyTop = (size.height - bodyHeight) / 2;
    final Rect bodyRect = Rect.fromLTWH(bodyLeft, bodyTop, bodyWidth, bodyHeight);

    final Paint bodyPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          color2.withOpacity(0.7),
          color1.withOpacity(0.2),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(bodyRect);

    final RRect bodyRRect = RRect.fromRectAndRadius(
      bodyRect,
      const Radius.circular(16),
    );
    canvas.drawRRect(bodyRRect, bodyPaint);

    // 3) Lentes (dos círculos) con base oscura
    final double lensRadius = bodyHeight * 0.35;
    final Offset leftLensCenter = Offset(
      bodyLeft + (bodyWidth * 0.3),
      bodyTop + (bodyHeight / 2),
    );
    final Offset rightLensCenter = Offset(
      bodyLeft + (bodyWidth * 0.7),
      bodyTop + (bodyHeight / 2),
    );

    // Pintura base de la lente (negro o muy oscuro)
    // 1) Base oscura para cada lente
    final Paint lensBasePaintLeft = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.black.withOpacity(0.7),
          Colors.black,
        ],
      ).createShader(
        Rect.fromCircle(center: leftLensCenter, radius: lensRadius),
      );

    final Paint lensBasePaintRight = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.black.withOpacity(0.7),
          Colors.black,
        ],
      ).createShader(
        Rect.fromCircle(center: rightLensCenter, radius: lensRadius),
      );

// Lente izquierda (base oscura)
    canvas.drawCircle(leftLensCenter, lensRadius, lensBasePaintLeft);

// Lente derecha (base oscura)
    canvas.drawCircle(rightLensCenter, lensRadius, lensBasePaintRight);

// 2) Gradiente blanco/transparente para cada lente
    final Paint lensCenterPaintLeft = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withOpacity(0.6),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(center: leftLensCenter, radius: lensRadius),
      );

    final Paint lensCenterPaintRight = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withOpacity(0.6),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(center: rightLensCenter, radius: lensRadius),
      );

// Lente izquierda, gradiente blanco al centro
    canvas.drawCircle(leftLensCenter, lensRadius, lensCenterPaintLeft);

// Lente derecha, gradiente blanco al centro
    canvas.drawCircle(rightLensCenter, lensRadius, lensCenterPaintRight);

    // 5) Pequeño “borde inferior” (nariz)
    final double noseWidth = bodyWidth * 0.3;
    final double noseHeight = bodyHeight * 0.2;
    final double noseLeft = center.dx - (noseWidth / 2);
    final double noseTop = bodyTop + (bodyHeight * 0.75);
    final Rect noseRect = Rect.fromLTWH(noseLeft, noseTop, noseWidth, noseHeight);

    final Paint nosePaint = Paint()
      ..color = color2.withOpacity(0.8);

    final RRect noseRRect = RRect.fromRectAndRadius(
      noseRect,
      const Radius.circular(10),
    );
    canvas.drawRRect(noseRRect, nosePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}