abstract class LegalEvent {}

class LoadLegalPage extends LegalEvent {
  final String apiPath;

  LoadLegalPage(this.apiPath);
}
