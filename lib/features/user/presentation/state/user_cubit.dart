import 'package:Postly/features/user/domain/models/user_model.dart';
import 'package:Postly/features/user/domain/usecases/fetch_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_cubit.freezed.dart';
part 'user_cubit.g.dart';
part 'user_state.dart';

class UserCubit extends HydratedCubit<UserState> {
  final FetchUser _fetchUser;

  static const _initialUserState = UserState.initial(
    payload: UserStatePayload(
      user: null,
      error: '',
    ),
  );

  UserCubit(this._fetchUser) : super(_initialUserState);

  Future<void> fetchUser() async {
    if (state.payload.user != null) {
      // We already have a cached user which should only be replaced when the
      // app data is deleted. Ahbeg return.
      return;
    }

    emit(UserState.loading(payload: state.payload.copyWith()));
    final res = await _fetchUser();

    res.fold(
      (l) => emit(UserState.error(payload: state.payload.copyWith(error: l.message))),
      (r) => emit(UserState.loaded(payload: state.payload.copyWith(user: r))),
    );
  }

  @override
  UserState fromJson(Map json) {
    try {
      return UserState.fromJson(Map.castFrom<dynamic, dynamic, String, dynamic>(json));
    } catch (_) {
      return _initialUserState;
    }
  }

  @override
  Map<String, dynamic> toJson(UserState state) => state.toJson();
}
