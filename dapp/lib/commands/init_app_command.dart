import '../commands/base_command.dart';

class InitAppCommand extends BaseCommand {
  Future<void> execute() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
