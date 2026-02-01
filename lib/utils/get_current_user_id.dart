import "package:capital_commons/clients/auth_client.dart";
import "package:capital_commons/core/service_locator.dart";

String getCurrentUserId() async {
  final _authClient = getIt<AuthClient>;
  return _authClient.
}
