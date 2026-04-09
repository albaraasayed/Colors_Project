import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/colors.dart';
import '../../../core/cache/cache_helper.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../auth/screens/signin_screen.dart';
import '../../favorites/cubit/favorites_cubit.dart';
import '../../favorites/cubit/favorites_state.dart';
import '../../favorites/screens/favorites_screen.dart';
import '../cubit/palette_cubit.dart';
import '../cubit/palette_state.dart';

class HomeColor extends StatelessWidget {
  const HomeColor({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => PaletteCubit()..fetchPalette())],
      child: const _HomeColorView(),
    );
  }
}

class _HomeColorView extends StatefulWidget {
  const _HomeColorView();

  @override
  State<_HomeColorView> createState() => _HomeColorViewState();
}

class _HomeColorViewState extends State<_HomeColorView> {
  Color? _selectedColor;

  @override
  Widget build(BuildContext context) {
    final String userEmail = CacheHelper.loggedInEmail ?? '';

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        title: const Text(
          'Coloring Studio',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          // Favorites navigation
          IconButton(
            icon: const Icon(Icons.favorite_border, color: AppColors.primary),
            tooltip: 'My Favorites',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              );
            },
          ),
          // Refresh palette
          BlocBuilder<PaletteCubit, PaletteState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                tooltip: 'Generate New Palette',
                onPressed: state is PaletteLoading
                    ? null
                    : () {
                        PaletteCubit.get(context).fetchPalette();
                        setState(() => _selectedColor = null);
                      },
              );
            },
          ),
          // Logout
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white70),
            tooltip: 'Logout',
            onPressed: () async {
              await AuthCubit.get(context).logout();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const SignInScreen()),
                (_) => false,
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<PaletteCubit, PaletteState>(
        listener: (context, state) {
          if (state is PaletteSuccess) {
            FavoritesCubit.get(context).initForPalette(state.colors);
            setState(() => _selectedColor = state.colors.first);
          }
        },
        builder: (context, paletteState) {
          if (paletteState is PaletteLoading ||
              paletteState is PaletteInitial) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(color: AppColors.primary),
                  const SizedBox(height: 16),
                  Text(
                    'Generating palette..',
                    style: TextStyle(color: AppColors.grey, fontSize: 14),
                  ),
                ],
              ),
            );
          }

          if (paletteState is PaletteError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: AppColors.error,
                      size: 52,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      paletteState.message,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.darkBackground,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => PaletteCubit.get(context).fetchPalette(),
                      icon: const Icon(Icons.refresh),
                      label: const Text(
                        'Try Again',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final colors = (paletteState as PaletteSuccess).colors;

          return Column(
            children: [
              if (_selectedColor != null)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: 80,
                  margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  decoration: BoxDecoration(
                    color: _selectedColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: _selectedColor!.withValues(alpha: 0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '#${_selectedColor!.toARGB32().toRadixString(16).toUpperCase().padLeft(8, '0').substring(2)}',
                      style: TextStyle(
                        color: _selectedColor!.computeLuminance() > 0.4
                            ? Colors.black87
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 12),

              Expanded(
                child: BlocBuilder<FavoritesCubit, FavoritesState>(
                  builder: (context, favState) {
                    final Set<int> favoritedValues = favState is FavoriteToggled
                        ? favState.favoritedColorValues
                        : {};

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        itemCount: colors.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                        itemBuilder: (context, index) {
                          final color = colors[index];
                          final isSelected = color == _selectedColor;
                          final isFavorited = favoritedValues.contains(
                            color.toARGB32(),
                          );
                          final hexCode =
                              '#${color.toARGB32().toRadixString(16).toUpperCase().padLeft(8, '0').substring(2)}';

                          return GestureDetector(
                            onTap: () => setState(() => _selectedColor = color),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  width: 3,
                                ),
                                boxShadow: [
                                  if (isSelected)
                                    BoxShadow(
                                      color: color.withValues(alpha: 0.6),
                                      blurRadius: 16,
                                      offset: const Offset(0, 5),
                                    ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 6,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black38,
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: Text(
                                          hexCode,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: GestureDetector(
                                      onTap: () {
                                        FavoritesCubit.get(
                                          context,
                                        ).toggleFavorite(
                                          color: color,
                                          paletteColors: colors,
                                        );
                                      },
                                      child: AnimatedSwitcher(
                                        duration: const Duration(
                                          milliseconds: 250,
                                        ),
                                        child: Icon(
                                          isFavorited
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          key: ValueKey(isFavorited),
                                          color: isFavorited
                                              ? Colors.redAccent
                                              : Colors.white70,
                                          size: 22,
                                          shadows: const [
                                            Shadow(
                                              color: Colors.black38,
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                color: AppColors.darkSurface,
                child: Row(
                  children: [
                    const Icon(
                      Icons.account_circle,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      userEmail,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
