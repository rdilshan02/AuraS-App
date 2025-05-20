import 'package:flutter/material.dart';

class SkinAnalysisPage extends StatefulWidget {
  const SkinAnalysisPage({super.key});

  @override
  State<SkinAnalysisPage> createState() => _SkinAnalysisPageState();
}

class _SkinAnalysisPageState extends State<SkinAnalysisPage> {
  bool _isLoading = false;
  bool _showOptions = false;
  String? _selectedImagePath;

  void _toggleOptions() {
    setState(() {
      _showOptions = !_showOptions;
    });
  }

  Future<void> _handleImageSelection(bool useCamera) async {
    setState(() {
      _showOptions = false;
      _isLoading = true;
    });

    // Simulate image selection process
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
      _selectedImagePath =
          useCamera
              ? 'assets/images/camera_placeholder.png'
              : 'assets/images/gallery_placeholder.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header with logo and AuraS text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/logo.png', // Ensure the image exists in assets
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'AuraS',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('https://placehold.co/100x100'),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Title
            const Text(
              'AI Skin Analysis',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Upload clear photos of your skin concern for analysis',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            // Image Preview or Placeholder
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child:
                  _selectedImagePath != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          _selectedImagePath!,
                          fit: BoxFit.cover,
                        ),
                      )
                      : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                          SizedBox(height: 10),
                          Text('No image selected'),
                        ],
                      ),
            ),

            const SizedBox(height: 30),

            // Upload Button with Options
            Stack(
              alignment: Alignment.center,
              children: [
                ElevatedButton(
                  onPressed: _toggleOptions,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child:
                      _isLoading
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'Upload Photo',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                ),

                // Options Menu
                if (_showOptions)
                  Positioned(
                    bottom: 60,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            _buildOptionButton(
                              icon: Icons.camera_alt,
                              label: 'Take Photo',
                              onPressed: () => _handleImageSelection(true),
                            ),
                            const Divider(height: 20),
                            _buildOptionButton(
                              icon: Icons.photo_library,
                              label: 'Choose from Gallery',
                              onPressed: () => _handleImageSelection(false),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),

            // Analysis Tips
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'For best results:\n'
                '- Use good lighting\n'
                '- Take clear, focused photos\n'
                '- Include affected area only',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 180,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 10),
            Text(label),
          ],
        ),
      ),
    );
  }
}
