import 'dart:convert';

import 'package:flutter/services.dart';

enum Environment {
  dev,
  qa,
  uat,
  prod,
}

class EnvironmentConfig {
  static const String _configPath = 'assets/config/';
  static final EnvironmentConfig _instance = EnvironmentConfig._internal();
  static Environment _currentEnvironment = Environment.dev;

  // Private configuration map
  Map<String, dynamic> _config = {};

  // Singleton pattern
  factory EnvironmentConfig() {
    return _instance;
  }

  EnvironmentConfig._internal();

  // Initialize the configuration
  Future<void> initialize(Environment env) async {
    _currentEnvironment = env;

    // Load configuration file based on environment
    String configFile = '';
    switch (env) {
      case Environment.dev:
        configFile = 'dev_config.json';
        break;
      case Environment.qa:
        configFile = 'qa_config.json';
        break;
      case Environment.uat:
        configFile = 'uat_config.json';
        break;
      case Environment.prod:
        configFile = 'prod_config.json';
        break;
    }

    try {
      final configData = await rootBundle.loadString('$_configPath$configFile');
      _config = json.decode(configData);
    } catch (e) {
      throw Exception('Failed to load environment configuration: $e');
    }
  }

  // Get a specific configuration value
  dynamic get(String key) {
    if (_config.containsKey(key)) {
      return _config[key];
    }
    throw Exception('Key "$key" not found in configuration');
  }

  // Get current environment
  Environment get currentEnvironment => _currentEnvironment;

  // Check if current environment is production
  bool get isProduction => _currentEnvironment == Environment.prod;
}
