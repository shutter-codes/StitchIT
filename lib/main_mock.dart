import 'package:tailor_made/environments/environment.dart';
import 'package:tailor_made/main.dart' as def;
import 'package:tailor_made/repository/mock/main.dart';

void main() => def.main(repositoryFactory, delay: 2, environment: Environment.MOCK);
