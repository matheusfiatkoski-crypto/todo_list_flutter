import 'dart:convert';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskStorage {
  static const String _storageKey = 'tasks';

  // Carrega as tarefas do armazenamento local
  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);

    if (jsonString == null) {
      return [];
    }

    final List<dynamic> decodedList = jsonDecode(jsonString);

    return decodedList
        .map((item) => Task.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  // Salva as tarefas no armazenamento local
  Future<void> saveTasks(List<Task> tasks) async {
    // 1. Inicializa o prefs que estava faltando nesta função
    final prefs = await SharedPreferences.getInstance();

    // 2. Transforma a lista de objetos Task em uma String JSON
    final String jsonString = jsonEncode(
      tasks.map((task) => task.toJson()).toList(),
    );

    // 3. Salva a String de forma assíncrona usando await
    await prefs.setString(_storageKey, jsonString);
  }
}