import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../utils/app_colors.dart';
import '../utils/app_dimens.dart';
import '../utils/app_text.dart';
import '../viewmodels/login_viewmodel.dart';
import 'root_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LoginViewModel>().verifierDisponibiliteBiometrie();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();

    return Scaffold(
      backgroundColor: AppColors.indigo900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo — reproduit les arcs concentriques du prototype
              // (cercle + 3 arcs dorés, voir <svg class="logo-mark">).
              const _KoraArcsLogo(size: 72),
              const SizedBox(height: 20),
              Text('Kora', style: AppText.brandName),
              const SizedBox(height: 6),
              Text('Présence et congés, simplifiés', style: AppText.brandTagline),
              const SizedBox(height: 36),

              _champTexte(controller: _emailController, label: 'Email professionnel'),
              const SizedBox(height: 14),
              _champTexte(
                controller: _passwordController,
                label: 'Mot de passe',
                obscure: true,
              ),
              const SizedBox(height: 20),

              if (viewModel.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Text(
                    viewModel.errorMessage!,
                    style: AppText.loginHint.copyWith(color: AppColors.red),
                  ),
                ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold500,
                    disabledBackgroundColor: AppColors.gold500.withOpacity(0.6),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.button),
                    ),
                  ),
                  onPressed: viewModel.status == LoginStatus.loading
                      ? null
                      : () => _seConnecter(context),
                  child: viewModel.status == LoginStatus.loading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.indigo900,
                          ),
                        )
                      : Text('Se connecter', style: AppText.buttonText),
                ),
              ),

              if (viewModel.biometricsDisponibles) ...[
                const SizedBox(height: 18),
                TextButton.icon(
                  onPressed: () => _seConnecterParBiometrie(context),
                  icon: const Icon(Icons.fingerprint, color: AppColors.indigoMuted, size: 18),
                  label: Text(
                    'Se connecter avec ${viewModel.biometricLabel}',
                    style: AppText.loginHint,
                  ),
                ),
              ],

            ],
          ),
        ),
      ),
    );
  }

  Widget _champTexte({
    required TextEditingController controller,
    required String label,
    bool obscure = false,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppText.fieldLabel),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            obscureText: obscure,
            style: AppText.inputText,
            cursorColor: AppColors.gold500,
            decoration: InputDecoration(
              filled: true,
              // fillColor: AppColors.indigo700,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.button),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _seConnecter(BuildContext context) async {
    final viewModel = context.read<LoginViewModel>();
    await viewModel.seConnecter(
      email: _emailController.text,
      motDePasse: _passwordController.text,
    );
    if (viewModel.status == LoginStatus.success && context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const RootView()),
      );
    }
  }

  Future<void> _seConnecterParBiometrie(BuildContext context) async {
    final ok = await context.read<LoginViewModel>().seConnecterParBiometrie();
    if (ok && context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const RootView()),
      );
    }
  }
}

/// Reproduit fidèlement le logo SVG du prototype : un cercle et trois
/// arcs concentriques dorés (`<path d="M14 44 Q36 14 58 44" ...>`).
class _KoraArcsLogo extends StatelessWidget {
  final double size;
  const _KoraArcsLogo({required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _ArcsPainter()),
    );
  }
}

class _ArcsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.gold500
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);

    paint.strokeWidth = size.width * (2 / 72);
    canvas.drawCircle(center, size.width * (34 / 72), paint);

    void arc(double widthFactor, double opacity, double yOffsetFactor) {
      paint.strokeWidth = size.width * widthFactor;
      paint.color = AppColors.gold500.withOpacity(opacity);
      final rect = Rect.fromCenter(
        center: Offset(center.dx, size.height * yOffsetFactor),
        width: size.width * 0.6,
        height: size.height * 0.6,
      );
      canvas.drawArc(rect, 3.4, 2.6, false, paint);
    }

    arc(2 / 72, 1.0, 0.75);
    arc(1.4 / 72, 0.7, 0.85);
    arc(1.0 / 72, 0.5, 0.95);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
