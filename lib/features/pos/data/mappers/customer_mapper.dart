import 'package:drift/drift.dart';

import '../../../../core/database/database_client.dart';
import '../models/customer.dart';

extension CustomerMapper on Customer {
  LocalCustomersCompanion toDrift() {
    return LocalCustomersCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      name: Value(name),
      companyId: Value(companyId),
      email: Value(email),
      phone: Value(phone),
      country: Value(country),
      address: Value(address),
      city: Value(city),
      createdAt: Value(createdAt),
      link: Value(link),
    );
  }

  static Customer fromDrift(LocalCustomer row) {
    return Customer(
      id: row.id,
      name: row.name,
      companyId: row.companyId,
      email: row.email,
      phone: row.phone,
      country: row.country,
      city: row.city,
      address: row.address,
      createdAt: row.createdAt,
      link: row.link,
    );
  }
}
