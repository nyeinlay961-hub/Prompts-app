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
