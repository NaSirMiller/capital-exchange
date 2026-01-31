import "package:capital_commons/clients/auth_client.dart";
import "package:capital_commons/core/loading_status.dart";
import "package:capital_commons/core/logger.dart";
import "package:capital_commons/core/service_locator.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "business_signup_cubit.freezed.dart";

class BusinessSignupCubit extends Cubit<BusinessSignupState> {
  BusinessSignupCubit() : super(const BusinessSignupState());

  final _authClient = getIt<AuthClient>();

  Future<void> submitSignupForm({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(signupStatus: LoadingStatus.loading));
    try {
      await _authClient.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(state.copyWith(signupStatus: LoadingStatus.success));
    } on AuthClientException catch (e) {
      Log.error(
        "AuthClientException occurred while signing up with email and password: $e",
      );
      emit(
        state.copyWith(
          signupStatus: LoadingStatus.failure,
          message: "An error occurred while signing up",
        ),
      );
      emit(state.copyWith(message: null));
    }
  }
}

@freezed
sealed class BusinessSignupState with _$BusinessSignupState {
  const factory BusinessSignupState({
    @Default(LoadingStatus.initial) LoadingStatus signupStatus,
    String? message,
  }) = _BusinessSignupState;
}
