import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../constants/asset_constants.dart';
import '../../../extensions/build_context_extension.dart';
import '../../../routes/routes.dart';
import '../../../services/responsive_service.dart';
import '../../../themes/palettes.dart';
import '../../../themes/typographies.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final Palettes colors = context.palettes;
    final Typographies inter = context.typographies;

    return Scaffold(
      backgroundColor: colors.cardColor,
      body: context.screen.width < Breakpoints.xs.value
          ? const SizedBox.shrink()
          : Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: context.maxSize.height,
                  maxWidth: context.maxSize.width,
                ),
                child: CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: <Widget>[
                    SliverList.list(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: context.responsive.value(<Breakpoints, double>{
                            Breakpoints.xs: switch (context.screen.width) {
                              > 420 => 0.83,
                              > 400 => 0.77,
                              > 360 => 0.73,
                              _ => 0.66,
                            },
                            Breakpoints.sm: 0.9,
                            Breakpoints.md: 1.65,
                            Breakpoints.lg: 1.9,
                            Breakpoints.xl: 2.05,
                          }),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(48),
                                bottomRight: Radius.circular(48),
                              ),
                              color: colors.backgroundColor,
                            ),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: -80,
                                  right: -80,
                                  child: Image.asset(
                                    kPokeballFlat,
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    isAntiAlias: true,
                                    scale: 3,
                                  ),
                                ),
                                Positioned(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Bem vindo ao Poke Hub!',
                                              style: inter.fontSize32?.copyWith(fontWeight: FontWeight.w800),
                                            ),
                                            Text(
                                              'Seu hub de conteúdos sobre pokémons.',
                                              style: inter.fontSize16?.copyWith(fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: GridView.count(
                                          childAspectRatio: 2,
                                          crossAxisCount: context.responsive.value(<Breakpoints, int>{
                                            Breakpoints.xs: 2,
                                            Breakpoints.sm: 2,
                                            Breakpoints.md: 3,
                                            Breakpoints.lg: 3,
                                            Breakpoints.xl: 3,
                                          }),
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8,
                                          padding: const EdgeInsets.all(16),
                                          physics: const NeverScrollableScrollPhysics(),
                                          children: <Widget>[
                                            _HomeCard(
                                              colors: colors,
                                              fonts: inter,
                                              onTap: () {
                                                context.navigator.pushNamed(Routes.pokedex);
                                              },
                                              backgroundColor: colors.red,
                                              label: 'Pokédex',
                                            ),
                                            _HomeCard(
                                              colors: colors,
                                              fonts: inter,
                                              onTap: () {},
                                              backgroundColor: colors.green,
                                              label: 'Favoritos',
                                            ),
                                            _HomeCard(
                                              colors: colors,
                                              fonts: inter,
                                              onTap: () {},
                                              backgroundColor: colors.blue,
                                              label: 'Equipes',
                                            ),
                                            _HomeCard(
                                              colors: colors,
                                              fonts: inter,
                                              onTap: () {},
                                              backgroundColor: colors.yellow,
                                              label: 'Músicas',
                                            ),
                                            _HomeCard(
                                              colors: colors,
                                              fonts: inter,
                                              onTap: () {},
                                              backgroundColor: colors.purple,
                                              label: 'Jogos',
                                            ),
                                            _HomeCard(
                                              colors: colors,
                                              fonts: inter,
                                              onTap: () {},
                                              backgroundColor: colors.brown,
                                              label: 'Séries',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Novidades',
                                    style: inter.fontSize24?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      foregroundColor: MaterialStatePropertyAll<Color?>(colors.blue),
                                      padding: const MaterialStatePropertyAll<EdgeInsetsGeometry?>(EdgeInsets.all(16)),
                                      textStyle: MaterialStatePropertyAll<TextStyle?>(
                                        inter.fontSize12?.copyWith(fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    child: const Text('Mostrar Todas'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  const _HomeCard({
    required this.colors,
    required this.fonts,
    required this.onTap,
    required this.backgroundColor,
    required this.label,
  });

  final Palettes colors;
  final Typographies fonts;
  final VoidCallback onTap;
  final Color backgroundColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          alignment: Alignment.centerLeft,
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
            color: backgroundColor,
            image: const DecorationImage(
              image: CachedNetworkImageProvider(kPokeballFlat),
              alignment: Alignment.centerRight,
              filterQuality: FilterQuality.high,
              fit: BoxFit.contain,
              isAntiAlias: true,
            ),
          ),
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            label,
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
        ),
      ),
    );
  }
}
