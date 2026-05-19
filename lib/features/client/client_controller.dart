import 'package:get/get.dart';
import '../../data/models/loan_model.dart';
import '../../data/models/policy_model.dart';
import '../../data/repositories/loan_repository.dart';
import '../../data/repositories/policy_repository.dart';
import '../../data/services/auth_service.dart';

class ClientController extends GetxController {
  final LoanRepository _loanRepository = LoanRepository();
  final PolicyRepository _policyRepository = PolicyRepository();
  final AuthService _authService = Get.find<AuthService>();

  var loans = <LoanModel>[].obs;
  var policies = <PolicyModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() {
    final uid = _authService.user.value?.uid;
    if (uid != null) {
      loans.bindStream(_loanRepository.getUserLoans(uid));
      policies.bindStream(_policyRepository.getUserPolicies(uid));
    }
  }

  double get totalLoanAmount => loans.fold(0, (sum, item) => sum + item.amount);
  int get activePoliciesCount => policies.where((p) => p.status == 'active').length;
}
