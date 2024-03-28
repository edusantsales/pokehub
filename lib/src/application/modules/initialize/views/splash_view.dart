import 'package:flutter/material.dart';

import '../../../../domain/states/pokemon_state.dart';
import '../../../constants/asset_constants.dart';
import '../../../extensions/build_context_extension.dart';
import '../../../routes/routes.dart';
import '../../../themes/palettes.dart';
import '../../../themes/typographies.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  final SplashController controller = SplashController();

  late final AnimationController _animationProgressController;
  late final AnimationController _animationSpinController;
  late final Animation<double> _animationSpin;

  void _updateState() => setState(() {});

  @override
  void initState() {
    controller.getPokemons();
    _animationProgressController = AnimationController(duration: const Duration(seconds: 60), vsync: this);
    _animationSpinController = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _animationSpin = CurvedAnimation(parent: _animationSpinController, curve: Curves.elasticInOut);
    _animationProgressController.repeat();
    _animationSpinController.repeat();
    _animationProgressController.addListener(() {
      if (_animationProgressController.isCompleted) {
        Future<void>.delayed(
          const Duration(seconds: 5),
          () => context.navigator.pushNamedAndRemoveUntil(Routes.home, (Route<dynamic> route) => false),
        );
      }
      _updateState();
    });
    controller.pokemonState.addListener(() {
      if (controller.pokemonState.value is SuccessPokemonState) {
        _animationProgressController.animateTo(1, duration: const Duration(seconds: 1));
        _animationSpinController.animateTo(1);
        controller.savePokemonsOnLocalStorage();
      }
      _updateState();
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.pokemonState.removeListener(_updateState);
    _animationProgressController.removeListener(_updateState);
    _animationProgressController.dispose();
    _animationSpinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Palettes colors = context.palettes;
    final Typographies inter = context.typographies;

    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              runAlignment: WrapAlignment.center,
              runSpacing: 24,
              spacing: context.screen.width,
              children: <Widget>[
                AnimatedCrossFade(
                  firstChild: RotationTransition(
                    turns: _animationSpin,
                    child: Image.asset(
                      kPokeballBorder,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      height: 240,
                      isAntiAlias: true,
                    ),
                  ),
                  secondChild: Column(
                    children: <Widget>[
                      Image.asset(
                        kPokeball,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        height: 240,
                        isAntiAlias: true,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Poke Hub',
                        style: inter.fontSize24?.copyWith(
                          color: colors.grey60,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  secondCurve: Curves.easeInExpo,
                  crossFadeState:
                      _animationProgressController.isCompleted ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: Duration(milliseconds: _animationProgressController.isCompleted ? 2000 : 1),
                ),
                if (_animationProgressController.isAnimating) ...<Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: LinearProgressIndicator(
                      backgroundColor: colors.cardColor,
                      borderRadius: BorderRadius.circular(16),
                      minHeight: 30,
                      value: _animationProgressController.value + 0.03,
                      valueColor: AlwaysStoppedAnimation<Color>(colors.successColor!),
                    ),
                  ),
                  Text(
                    _animationProgressController.value <= 0.5
                        ? 'Capturando os pokemons...'
                        : 'Salvando os dados na pokedex...',
                    style: inter.fontSize20?.copyWith(color: colors.grey40, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Powered by ',
                  style: inter.fontSize20?.copyWith(color: colors.grey60, fontWeight: FontWeight.w300),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: FlutterLogo(
                    size: 88,
                    style: FlutterLogoStyle.horizontal,
                    textColor: colors.grey80,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
