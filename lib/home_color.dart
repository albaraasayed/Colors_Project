import 'package:flutter/material.dart';
import 'package:first_flutter/data/Models/PaletteModel.dart';
import 'package:first_flutter/data/Repositories/PaletteRepo.dart';
import 'package:first_flutter/core/DataSource/RemoteDataSource.dart';

class HomeColor extends StatefulWidget {
  const HomeColor({super.key});

  @override
  State<HomeColor> createState() => _HomeColorState();
}

class _HomeColorState extends State<HomeColor> {
  final PaletteRepo _paletteRepo = PaletteRepo(RemoteDataSource());

  List<Color>? currentPalette;
  Color? selectedColor;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNewPalette();
  }

  Future<void> _fetchNewPalette() async {
    setState(() => isLoading = true);

    PaletteModel? model = await _paletteRepo.getRandomPalette();

    if (mounted) {
      setState(() {
        if (model != null && model.colors.isNotEmpty) {
          currentPalette = model.colors;
          selectedColor = model.colors.first;
        } else {
          currentPalette = null;
        }
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Coloring Studio',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: _fetchNewPalette,
            tooltip: 'Generate New Palette',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : currentPalette == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Oops! Failed to load the AI palette.',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _fetchNewPalette,
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: currentPalette!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final color = currentPalette![index];
                  final isSelected = color == selectedColor;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.black : Colors.transparent,
                          width: 3,
                        ),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: color.withOpacity(0.5),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
