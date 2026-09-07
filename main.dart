import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const InvokersynyApp());

class InvokersynyApp extends StatelessWidget {
  const InvokersynyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INVOKERSYNY PROMPT BUILDER',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0E1013),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF16181D),
          elevation: 2,
        ),
      ),
      home: const PromptGenerator(),
    );
  }
}

class PromptGenerator extends StatefulWidget {
  const PromptGenerator({super.key});

  @override
  State<PromptGenerator> createState() => _PromptGeneratorState();
}

class _PromptGeneratorState extends State<PromptGenerator> {
  String currentPrompt = "(select a key)";
  final List<String> _history = [];

  void addText(String text) {
    setState(() {
      _history.add(currentPrompt);
      if (currentPrompt == "(select a key)" || currentPrompt.isEmpty) {
        currentPrompt = text;
      } else {
        currentPrompt += "\n$text";
      }
    });
    HapticFeedback.lightImpact();
  }

  void clearPrompt() {
    setState(() {
      _history.add(currentPrompt);
      currentPrompt = "(select a key)";
    });
    HapticFeedback.mediumImpact();
  }

  void undo() {
    if (_history.isNotEmpty) {
      setState(() {
        currentPrompt = _history.removeLast();
      });
      HapticFeedback.selectionClick();
    }
  }

  void copyPrompt() {
    if (currentPrompt == "(select a key)" || currentPrompt.isEmpty) return;
    Clipboard.setData(ClipboardData(text: currentPrompt));
    HapticFeedback.heavyImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Prompt copied to clipboard!"),
        backgroundColor: Colors.orangeAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget _buildButton(String code, String label, String value) {
    return GestureDetector(
      onTap: () => addText(value),
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(color: Colors.black38, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              code,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.black87),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "INVOKERSYNY PROMPT BUILDER",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            tooltip: "Undo",
            onPressed: _history.isNotEmpty ? undo : null,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(16),
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFE5D1B0),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF32363E), width: 3),
                boxShadow: const [
                  BoxShadow(color: Colors.black54, blurRadius: 8, offset: Offset(0, 4)),
                ],
              ),
              child: SingleChildScrollView(
                child: SelectableText(
                  currentPrompt,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                childAspectRatio: 1.0,
                children: [
                  _buildButton("F", "Clip", "Clip: First Clip"),
                  _buildButton("T", "Time", "Time: 00:00-00:05"),
                  _buildButton("C", "Camera", "Camera: Bird's Eye View"),
                  _buildButton("S", "Style", "Style: Cinematic Anime"),
                  _buildButton("CU", "Close-Up", "Camera: Extreme Close-Up Macro"),
                  _buildButton("FP", "FPV Drone", "Camera: Fast FPV Drone Flythrough"),
                  _buildButton("DO", "Dolly Zoom", "Camera: Hitchcock Vertigo Dolly Zoom"),
                  _buildButton("OR", "Orbit 360", "Camera: 360° Smooth Orbiting Pan"),
                  _buildButton("GH", "Golden Hr", "Lighting: Golden Hour Warm Sunflare"),
                  _buildButton("NE", "Neon Rim", "Lighting: Neon Magenta Rim Lighting"),
                  _buildButton("VO", "Volumetric", "Lighting: Heavy Volumetric God Rays"),
                  _buildButton("16M", "16mm Film", "Style: Authentic 16mm Grain Kodak 500T"),
                  _buildButton("SM", "Slow-Mo", "Motion: 120fps Bullet-Time Hyper Slow-Mo"),
                  _buildButton("FA", "Action", "Motion: Kinetic High-Octane Action Blur"),
                  _buildButton("4K", "4K UHD", "Quality: Mastered in 4K UHD Pro-Res"),
                  _buildButton("AR", "16:9 Aspect", "Aspect Ratio: 16:9 Widescreen"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF282B32),
                        foregroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: clearPrompt,
                      icon: const Icon(Icons.delete_outline),
                      label: const Text("CLEAR", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: copyPrompt,
                      icon: const Icon(Icons.copy),
                      label: const Text("COPY PROMPT", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
