import 'package:get/get.dart';
import '../../data/models/user_model.dart';
import '../../data/models/loan_model.dart';
import '../../data/models/policy_model.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/repositories/loan_repository.dart';
import '../../data/repositories/policy_repository.dart';

class AdminController extends GetxController {
  final UserRepository _userRepository = UserRepository();
  final LoanRepository _loanRepository = LoanRepository();
  final PolicyRepository _policyRepository = PolicyRepository();

  var clients = <UserModel>[].obs;
  var loans = <LoanModel>[].obs;
  var policies = <PolicyModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() {
    clients.bindStream(_userRepository.getAllClients());
    loans.bindStream(_loanRepository.getAllLoans());
    policies.bindStream(_policyRepository.getAllPolicies());
  }

  int get pendingApplicationsCount => loans.where((l) => l.status == 'pending').length;
  int get activePoliciesCount => policies.where((p) => p.status == 'active').length;
}
