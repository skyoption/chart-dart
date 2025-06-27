import 'package:example/core/consts/exports.dart';
import 'package:example/features/auth/data_source/connected_account_data_source.dart';
import 'package:example/features/auth/models/connected_account_info_entity.dart';

///[AccountCubit]
///[Implementation]
@injectable
class AccountsCubit extends Cubit<FlowState> {
  ///[LoginUseCase]
  final ConnectedAccountDataSource loginDataSource;
  List<ConnectedAccountInfoEntity> accounts = [];

  AccountsCubit(
    this.loginDataSource,
  ) : super(const FlowState());

  Future<void> execute() async {
    accounts = await loginDataSource.getAllAccountsInfo();
    emit(state.copyWith(data: Data.secure));
  }
}
