enum ResgisterStatus {
  open,
  closed,
}

class RegisterFilterResult {
  final ResgisterStatus? status;
  final DateTime? startDate;
  final DateTime? endDate;

  RegisterFilterResult({
    this.status,
    this.startDate,
    this.endDate,
  });
}
