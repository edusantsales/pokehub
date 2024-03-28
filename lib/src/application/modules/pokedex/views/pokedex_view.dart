import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/pokemon_model.dart';
import '../../../../domain/states/pokemon_state.dart';
import '../../../constants/asset_constants.dart';
import '../../../extensions/build_context_extension.dart';
import '../../../extensions/string_extension.dart';
import '../../../services/responsive_service.dart';
import '../../../themes/palettes.dart';
import '../../../themes/typographies.dart';
import '../controllers/pokedex_controller.dart';

class PokedexView extends StatefulWidget {
  const PokedexView({super.key});

  @override
  State<PokedexView> createState() => _PokedexViewState();
}

class _PokedexViewState extends State<PokedexView> {
  final PokedexController controller = PokedexController();
  final ScrollController scrollController = ScrollController();

  void _updateState() => setState(() {});

  @override
  void initState() {
    controller.getPokemons();
    controller.pokemonState.addListener(_updateState);
    controller.pokemonImageState.addListener(_updateState);
    super.initState();
  }

  @override
  void dispose() {
    controller.pokemonState.removeListener(_updateState);
    controller.pokemonImageState.removeListener(_updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Palettes colors = context.palettes;
    final Typographies inter = context.typographies;
    final PokemonState pokemonState = controller.pokemonState.value;
    final bool pokemonImageState = controller.pokemonImageState.value;

    return context.screen.width < Breakpoints.xs.value
        ? const SizedBox.shrink()
        : Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                if (context.screen.width < Breakpoints.xl.value) ...<Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: IconButton(
                      icon: Row(
                        children: <Widget>[
                          Text(
                            '3D',
                            style: inter.fontSize16?.copyWith(
                              color: pokemonImageState ? colors.grey80 : colors.grey20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            pokemonImageState ? Icons.view_in_ar_sharp : Icons.view_in_ar,
                            color: pokemonImageState ? colors.grey80 : colors.grey20,
                            size: 24,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      style: const ButtonStyle(visualDensity: VisualDensity.compact),
                      onPressed: controller.setPokemonImage3d,
                    ),
                  ),
                ],
              ],
              backgroundColor: colors.cardColor,
              title: Text(
                'Pokedex',
                style: inter.fontSize40?.copyWith(color: colors.grey80, fontWeight: FontWeight.w600),
              ),
            ),
            backgroundColor: colors.backgroundColor,
            body: switch (pokemonState) {
              LoadingPokemonState _ => const _LoadingBody(),
              FailurePokemonState _ => _FailureBody(colors: colors, fonts: inter, state: pokemonState),
              SuccessPokemonState _ => _SuccessBody(
                  controller: scrollController,
                  colors: colors,
                  fonts: inter,
                  state: pokemonState,
                  imageState: pokemonImageState,
                ),
            },
            floatingActionButton: FloatingActionButton(
              backgroundColor: colors.grey40,
              foregroundColor: colors.backgroundColor,
              onPressed: () {
                scrollController.animateTo(0.0, duration: Durations.extralong4, curve: Curves.fastLinearToSlowEaseIn);
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
              child: const Icon(Icons.swipe_down, size: 32),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
  }
}

class _LoadingBody extends StatelessWidget {
  const _LoadingBody();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _FailureBody extends StatelessWidget {
  const _FailureBody({required this.colors, required this.fonts, required this.state});

  final Palettes colors;
  final Typographies fonts;
  final FailurePokemonState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(32),
      child: Text(
        state.e.error.toString(),
        style: fonts.fontSize40?.copyWith(color: colors.grey80),
        textAlign: TextAlign.start,
      ),
    );
  }
}

class _SuccessBody extends StatelessWidget {
  const _SuccessBody({
    required this.controller,
    required this.colors,
    required this.fonts,
    required this.state,
    required this.imageState,
  });

  final ScrollController controller;
  final Palettes colors;
  final Typographies fonts;
  final SuccessPokemonState state;
  final bool imageState;

  double customAlignmentBottom(PokemonModel pokemon) {
    return switch (pokemon.id) {
      22 || 42 || 384 || 397 => -16,
      142 || 144 => -24,
      146 => -32,
      249 => -4,
      250 => -8,
      398 || 430 => -48,
      _ => 0,
    };
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: context.responsive.value(<Breakpoints, double>{
          Breakpoints.xs: 1.8,
          Breakpoints.sm: 1.6,
          Breakpoints.md: 1.4,
          Breakpoints.lg: 1.4,
          Breakpoints.xl: 1.6,
        }),
        crossAxisCount: context.responsive.value(<Breakpoints, int>{
          Breakpoints.xs: 1,
          Breakpoints.sm: 2,
          Breakpoints.md: 3,
          Breakpoints.lg: 4,
          Breakpoints.xl: 5,
        }),
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: state.pokemons.length,
      itemBuilder: (BuildContext context, int index) {
        final String imageUrl = imageState && context.screen.width < Breakpoints.xl.value
            ? state.pokemons[index].showdown
            : state.pokemons[index].officialArtwork;
        return Padding(
          padding: const EdgeInsets.all(4),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: colors.black26,
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 2,
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  state.pokemons[index].primaryColor,
                  state.pokemons[index].secondaryColor,
                ],
              ),
            ),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Positioned(
                  top: 0,
                  right: -24,
                  bottom: -24,
                  child: _PokeballImage(),
                ),
                Positioned(
                  top: imageUrl.endsWith('.gif') ? null : 16,
                  right: imageUrl.endsWith('.gif') ? 0 : -6,
                  bottom: imageUrl.endsWith('.gif') ? customAlignmentBottom(state.pokemons[index]) : -6,
                  child: _PokeImage(imageUrl: imageUrl),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  child: _PokeInfo(colors: colors, fonts: fonts, pokemon: state.pokemons[index]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PokeInfo extends StatelessWidget {
  const _PokeInfo({required this.colors, required this.fonts, required this.pokemon});

  final Palettes colors;
  final Typographies fonts;
  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Spacer(flex: 8),
          Text(
            '#${pokemon.id.toString().padLeft(3, '0')}',
            style: fonts.fontSize16?.copyWith(color: colors.primaryColor, fontWeight: FontWeight.w700),
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(flex: 4),
          Text(
            pokemon.name.capitalize,
            style: fonts.fontSize24?.copyWith(
              color: colors.primaryColor,
              fontWeight: FontWeight.w900,
              shadows: <Shadow>[
                Shadow(color: colors.black26, blurRadius: 1),
                Shadow(color: colors.black26, blurRadius: 2),
                Shadow(color: colors.black26, blurRadius: 3),
              ],
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(flex: 4),
          Container(
            constraints: const BoxConstraints(minWidth: 80),
            decoration: BoxDecoration(
              border: Border.all(style: BorderStyle.none),
              borderRadius: BorderRadius.circular(8),
              color: colors.white24,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            child: Row(
              children: <Widget>[
                Image.asset(
                  getTypeAsset(pokemon.primaryType),
                  filterQuality: FilterQuality.high,
                  height: 16,
                  width: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  pokemon.primaryType.capitalize,
                  style: fonts.fontSize12?.copyWith(color: colors.primaryColor, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Container(
            constraints: const BoxConstraints(minWidth: 80),
            decoration: BoxDecoration(
              border: Border.all(style: BorderStyle.none),
              borderRadius: BorderRadius.circular(8),
              color: pokemon.types.length == 2 ? colors.white24 : colors.tertiaryColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            child: Row(
              children: <Widget>[
                if (pokemon.types.length == 2) ...<Widget>[
                  Image.asset(
                    getTypeAsset(pokemon.secondaryType),
                    filterQuality: FilterQuality.high,
                    height: 16,
                    width: 16,
                  ),
                  const SizedBox(width: 4),
                ],
                Text(
                  pokemon.types.length == 2 ? pokemon.secondaryType.capitalize : '',
                  style: fonts.fontSize12?.copyWith(color: colors.primaryColor, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Spacer(flex: 8),
        ],
      ),
    );
  }
}

class _PokeballImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      kPokeballFlat,
      alignment: Alignment.centerRight,
      filterQuality: FilterQuality.high,
      fit: BoxFit.cover,
      isAntiAlias: true,
      scale: 6,
    );
  }
}

class _PokeImage extends StatelessWidget {
  const _PokeImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: CachedNetworkImageProvider(
        imageUrl,
        scale: imageUrl.endsWith('.gif')
            ? context.responsive.value(<Breakpoints, double>{
                Breakpoints.xs: 0.65,
                Breakpoints.sm: 0.8,
                Breakpoints.md: 0.8,
                Breakpoints.lg: 0.8,
                Breakpoints.xl: 0.8,
              })
            : 5.0,
      ),
      alignment: Alignment.centerRight,
      filterQuality: FilterQuality.high,
      fit: BoxFit.cover,
      isAntiAlias: true,
    );
  }
}
