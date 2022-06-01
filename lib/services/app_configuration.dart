const isTest = true;

enum Environment {
  local,
  develop,
  product;

  String get host {
    switch (this) {
      case Environment.local:
        return 'http://127.0.0.1:8000/api/v1/';
      case Environment.develop:
        return 'http://39.107.136.94/puppy/api/v1/';
      case Environment.product:
        return '';
    }
  }
}

const currentEnvironment = Environment.local;
