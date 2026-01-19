import 'package:drift/drift.dart';
import 'package:spotstock_inventory/core/networking/api_response/spotstock_api_data_item.dart';

import '../../../../core/database/database_client.dart';
import '../models/create_customer_dto.dart';
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
      isSynced: Value(isSynced ?? false),
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
      isSynced: row.isSynced,
    );
  }

  static Customer fromCustomerCreationResponse(SpotstockApiDataItem dao) {
    final attributes = dao.attributes;
    return Customer(
      id: attributes?['id'],
      name: attributes?['name'],
      companyId: attributes?['company_id'],
      email: attributes?['email'],
      phone: attributes?['phone'],
      country: attributes?['country'],
      city: attributes?['city'],
      address: attributes?['address'],
      createdAt: DateTime.tryParse(attributes?['created_at']),
      link: attributes?['link'],
      isSynced: true,
    );
  }

  static Customer fromCreateCustomerDto(CreateCustomerDto dto) {
    return Customer(
      name: dto.name,
      email: dto.email,
      phone: dto.phone,
      country: dto.country,
      city: dto.city,
      address: dto.address,
      isSynced: false,
    );
  }

  CreateCustomerDto toCreateCustomerDto() {
    return CreateCustomerDto(
      name: name,
      email: email,
      phone: phone,
      country: country,
      city: city,
      address: address,
    );
  }
}

extension CreateCustomerDtoMapper on CreateCustomerDto {
  LocalCustomersCompanion toDrift() {
    return LocalCustomersCompanion(
      name: Value(name),
      address: Value(address),
      city: Value(city),
      email: Value(email),
      country: Value(country),
      phone: Value(phone),
      isSynced: Value(false),
      createdAt: Value(DateTime.now()),
    );
  }
}
