// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_client.dart';

// ignore_for_file: type=lint
class $LocalAttendantsTable extends LocalAttendants
    with TableInfo<$LocalAttendantsTable, LocalAttendant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalAttendantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isAdminMeta =
      const VerificationMeta('isAdmin');
  @override
  late final GeneratedColumn<int> isAdmin = GeneratedColumn<int>(
      'is_admin', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isSuperMeta =
      const VerificationMeta('isSuper');
  @override
  late final GeneratedColumn<int> isSuper = GeneratedColumn<int>(
      'is_super', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isAttendantMeta =
      const VerificationMeta('isAttendant');
  @override
  late final GeneratedColumn<int> isAttendant = GeneratedColumn<int>(
      'is_attendant', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _setPinMeta = const VerificationMeta('setPin');
  @override
  late final GeneratedColumn<bool> setPin = GeneratedColumn<bool>(
      'set_pin', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("set_pin" IN (0, 1))'));
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
      'link', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        firstName,
        lastName,
        email,
        phone,
        image,
        createdAt,
        isAdmin,
        isSuper,
        isAttendant,
        setPin,
        link
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_attendants';
  @override
  VerificationContext validateIntegrity(Insertable<LocalAttendant> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('is_admin')) {
      context.handle(_isAdminMeta,
          isAdmin.isAcceptableOrUnknown(data['is_admin']!, _isAdminMeta));
    }
    if (data.containsKey('is_super')) {
      context.handle(_isSuperMeta,
          isSuper.isAcceptableOrUnknown(data['is_super']!, _isSuperMeta));
    }
    if (data.containsKey('is_attendant')) {
      context.handle(
          _isAttendantMeta,
          isAttendant.isAcceptableOrUnknown(
              data['is_attendant']!, _isAttendantMeta));
    }
    if (data.containsKey('set_pin')) {
      context.handle(_setPinMeta,
          setPin.isAcceptableOrUnknown(data['set_pin']!, _setPinMeta));
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link']!, _linkMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalAttendant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalAttendant(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name']),
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      isAdmin: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_admin']),
      isSuper: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_super']),
      isAttendant: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_attendant']),
      setPin: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}set_pin']),
      link: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}link']),
    );
  }

  @override
  $LocalAttendantsTable createAlias(String alias) {
    return $LocalAttendantsTable(attachedDatabase, alias);
  }
}

class LocalAttendant extends DataClass implements Insertable<LocalAttendant> {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? image;
  final DateTime? createdAt;
  final int? isAdmin;
  final int? isSuper;
  final int? isAttendant;
  final bool? setPin;
  final String? link;
  const LocalAttendant(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.image,
      this.createdAt,
      this.isAdmin,
      this.isSuper,
      this.isAttendant,
      this.setPin,
      this.link});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || firstName != null) {
      map['first_name'] = Variable<String>(firstName);
    }
    if (!nullToAbsent || lastName != null) {
      map['last_name'] = Variable<String>(lastName);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || isAdmin != null) {
      map['is_admin'] = Variable<int>(isAdmin);
    }
    if (!nullToAbsent || isSuper != null) {
      map['is_super'] = Variable<int>(isSuper);
    }
    if (!nullToAbsent || isAttendant != null) {
      map['is_attendant'] = Variable<int>(isAttendant);
    }
    if (!nullToAbsent || setPin != null) {
      map['set_pin'] = Variable<bool>(setPin);
    }
    if (!nullToAbsent || link != null) {
      map['link'] = Variable<String>(link);
    }
    return map;
  }

  LocalAttendantsCompanion toCompanion(bool nullToAbsent) {
    return LocalAttendantsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      isAdmin: isAdmin == null && nullToAbsent
          ? const Value.absent()
          : Value(isAdmin),
      isSuper: isSuper == null && nullToAbsent
          ? const Value.absent()
          : Value(isSuper),
      isAttendant: isAttendant == null && nullToAbsent
          ? const Value.absent()
          : Value(isAttendant),
      setPin:
          setPin == null && nullToAbsent ? const Value.absent() : Value(setPin),
      link: link == null && nullToAbsent ? const Value.absent() : Value(link),
    );
  }

  factory LocalAttendant.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalAttendant(
      id: serializer.fromJson<int?>(json['id']),
      firstName: serializer.fromJson<String?>(json['firstName']),
      lastName: serializer.fromJson<String?>(json['lastName']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      image: serializer.fromJson<String?>(json['image']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      isAdmin: serializer.fromJson<int?>(json['isAdmin']),
      isSuper: serializer.fromJson<int?>(json['isSuper']),
      isAttendant: serializer.fromJson<int?>(json['isAttendant']),
      setPin: serializer.fromJson<bool?>(json['setPin']),
      link: serializer.fromJson<String?>(json['link']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'firstName': serializer.toJson<String?>(firstName),
      'lastName': serializer.toJson<String?>(lastName),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'image': serializer.toJson<String?>(image),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'isAdmin': serializer.toJson<int?>(isAdmin),
      'isSuper': serializer.toJson<int?>(isSuper),
      'isAttendant': serializer.toJson<int?>(isAttendant),
      'setPin': serializer.toJson<bool?>(setPin),
      'link': serializer.toJson<String?>(link),
    };
  }

  LocalAttendant copyWith(
          {Value<int?> id = const Value.absent(),
          Value<String?> firstName = const Value.absent(),
          Value<String?> lastName = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> image = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<int?> isAdmin = const Value.absent(),
          Value<int?> isSuper = const Value.absent(),
          Value<int?> isAttendant = const Value.absent(),
          Value<bool?> setPin = const Value.absent(),
          Value<String?> link = const Value.absent()}) =>
      LocalAttendant(
        id: id.present ? id.value : this.id,
        firstName: firstName.present ? firstName.value : this.firstName,
        lastName: lastName.present ? lastName.value : this.lastName,
        email: email.present ? email.value : this.email,
        phone: phone.present ? phone.value : this.phone,
        image: image.present ? image.value : this.image,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        isAdmin: isAdmin.present ? isAdmin.value : this.isAdmin,
        isSuper: isSuper.present ? isSuper.value : this.isSuper,
        isAttendant: isAttendant.present ? isAttendant.value : this.isAttendant,
        setPin: setPin.present ? setPin.value : this.setPin,
        link: link.present ? link.value : this.link,
      );
  LocalAttendant copyWithCompanion(LocalAttendantsCompanion data) {
    return LocalAttendant(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      image: data.image.present ? data.image.value : this.image,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isAdmin: data.isAdmin.present ? data.isAdmin.value : this.isAdmin,
      isSuper: data.isSuper.present ? data.isSuper.value : this.isSuper,
      isAttendant:
          data.isAttendant.present ? data.isAttendant.value : this.isAttendant,
      setPin: data.setPin.present ? data.setPin.value : this.setPin,
      link: data.link.present ? data.link.value : this.link,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalAttendant(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('image: $image, ')
          ..write('createdAt: $createdAt, ')
          ..write('isAdmin: $isAdmin, ')
          ..write('isSuper: $isSuper, ')
          ..write('isAttendant: $isAttendant, ')
          ..write('setPin: $setPin, ')
          ..write('link: $link')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, firstName, lastName, email, phone, image,
      createdAt, isAdmin, isSuper, isAttendant, setPin, link);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalAttendant &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.image == this.image &&
          other.createdAt == this.createdAt &&
          other.isAdmin == this.isAdmin &&
          other.isSuper == this.isSuper &&
          other.isAttendant == this.isAttendant &&
          other.setPin == this.setPin &&
          other.link == this.link);
}

class LocalAttendantsCompanion extends UpdateCompanion<LocalAttendant> {
  final Value<int?> id;
  final Value<String?> firstName;
  final Value<String?> lastName;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> image;
  final Value<DateTime?> createdAt;
  final Value<int?> isAdmin;
  final Value<int?> isSuper;
  final Value<int?> isAttendant;
  final Value<bool?> setPin;
  final Value<String?> link;
  const LocalAttendantsCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.image = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isAdmin = const Value.absent(),
    this.isSuper = const Value.absent(),
    this.isAttendant = const Value.absent(),
    this.setPin = const Value.absent(),
    this.link = const Value.absent(),
  });
  LocalAttendantsCompanion.insert({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.image = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isAdmin = const Value.absent(),
    this.isSuper = const Value.absent(),
    this.isAttendant = const Value.absent(),
    this.setPin = const Value.absent(),
    this.link = const Value.absent(),
  });
  static Insertable<LocalAttendant> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? image,
    Expression<DateTime>? createdAt,
    Expression<int>? isAdmin,
    Expression<int>? isSuper,
    Expression<int>? isAttendant,
    Expression<bool>? setPin,
    Expression<String>? link,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (image != null) 'image': image,
      if (createdAt != null) 'created_at': createdAt,
      if (isAdmin != null) 'is_admin': isAdmin,
      if (isSuper != null) 'is_super': isSuper,
      if (isAttendant != null) 'is_attendant': isAttendant,
      if (setPin != null) 'set_pin': setPin,
      if (link != null) 'link': link,
    });
  }

  LocalAttendantsCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? firstName,
      Value<String?>? lastName,
      Value<String?>? email,
      Value<String?>? phone,
      Value<String?>? image,
      Value<DateTime?>? createdAt,
      Value<int?>? isAdmin,
      Value<int?>? isSuper,
      Value<int?>? isAttendant,
      Value<bool?>? setPin,
      Value<String?>? link}) {
    return LocalAttendantsCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      isAdmin: isAdmin ?? this.isAdmin,
      isSuper: isSuper ?? this.isSuper,
      isAttendant: isAttendant ?? this.isAttendant,
      setPin: setPin ?? this.setPin,
      link: link ?? this.link,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isAdmin.present) {
      map['is_admin'] = Variable<int>(isAdmin.value);
    }
    if (isSuper.present) {
      map['is_super'] = Variable<int>(isSuper.value);
    }
    if (isAttendant.present) {
      map['is_attendant'] = Variable<int>(isAttendant.value);
    }
    if (setPin.present) {
      map['set_pin'] = Variable<bool>(setPin.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalAttendantsCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('image: $image, ')
          ..write('createdAt: $createdAt, ')
          ..write('isAdmin: $isAdmin, ')
          ..write('isSuper: $isSuper, ')
          ..write('isAttendant: $isAttendant, ')
          ..write('setPin: $setPin, ')
          ..write('link: $link')
          ..write(')'))
        .toString();
  }
}

class $LocalCustomersTable extends LocalCustomers
    with TableInfo<$LocalCustomersTable, LocalCustomer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalCustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _companyIdMeta =
      const VerificationMeta('companyId');
  @override
  late final GeneratedColumn<int> companyId = GeneratedColumn<int>(
      'company_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _countryMeta =
      const VerificationMeta('country');
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
      'country', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
      'link', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        companyId,
        email,
        phone,
        country,
        city,
        address,
        createdAt,
        link,
        isSynced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_customers';
  @override
  VerificationContext validateIntegrity(Insertable<LocalCustomer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('company_id')) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link']!, _linkMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalCustomer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCustomer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      companyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}company_id']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      country: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country']),
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      link: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}link']),
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $LocalCustomersTable createAlias(String alias) {
    return $LocalCustomersTable(attachedDatabase, alias);
  }
}

class LocalCustomer extends DataClass implements Insertable<LocalCustomer> {
  final int id;
  final String? name;
  final int? companyId;
  final String? email;
  final String? phone;
  final String? country;
  final String? city;
  final String? address;
  final DateTime? createdAt;
  final String? link;
  final bool isSynced;
  const LocalCustomer(
      {required this.id,
      this.name,
      this.companyId,
      this.email,
      this.phone,
      this.country,
      this.city,
      this.address,
      this.createdAt,
      this.link,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || companyId != null) {
      map['company_id'] = Variable<int>(companyId);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || link != null) {
      map['link'] = Variable<String>(link);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  LocalCustomersCompanion toCompanion(bool nullToAbsent) {
    return LocalCustomersCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      companyId: companyId == null && nullToAbsent
          ? const Value.absent()
          : Value(companyId),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      link: link == null && nullToAbsent ? const Value.absent() : Value(link),
      isSynced: Value(isSynced),
    );
  }

  factory LocalCustomer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCustomer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      companyId: serializer.fromJson<int?>(json['companyId']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      country: serializer.fromJson<String?>(json['country']),
      city: serializer.fromJson<String?>(json['city']),
      address: serializer.fromJson<String?>(json['address']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      link: serializer.fromJson<String?>(json['link']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'companyId': serializer.toJson<int?>(companyId),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'country': serializer.toJson<String?>(country),
      'city': serializer.toJson<String?>(city),
      'address': serializer.toJson<String?>(address),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'link': serializer.toJson<String?>(link),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  LocalCustomer copyWith(
          {int? id,
          Value<String?> name = const Value.absent(),
          Value<int?> companyId = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> country = const Value.absent(),
          Value<String?> city = const Value.absent(),
          Value<String?> address = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<String?> link = const Value.absent(),
          bool? isSynced}) =>
      LocalCustomer(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        companyId: companyId.present ? companyId.value : this.companyId,
        email: email.present ? email.value : this.email,
        phone: phone.present ? phone.value : this.phone,
        country: country.present ? country.value : this.country,
        city: city.present ? city.value : this.city,
        address: address.present ? address.value : this.address,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        link: link.present ? link.value : this.link,
        isSynced: isSynced ?? this.isSynced,
      );
  LocalCustomer copyWithCompanion(LocalCustomersCompanion data) {
    return LocalCustomer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      country: data.country.present ? data.country.value : this.country,
      city: data.city.present ? data.city.value : this.city,
      address: data.address.present ? data.address.value : this.address,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      link: data.link.present ? data.link.value : this.link,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalCustomer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('companyId: $companyId, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('country: $country, ')
          ..write('city: $city, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('link: $link, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, companyId, email, phone, country,
      city, address, createdAt, link, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCustomer &&
          other.id == this.id &&
          other.name == this.name &&
          other.companyId == this.companyId &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.country == this.country &&
          other.city == this.city &&
          other.address == this.address &&
          other.createdAt == this.createdAt &&
          other.link == this.link &&
          other.isSynced == this.isSynced);
}

class LocalCustomersCompanion extends UpdateCompanion<LocalCustomer> {
  final Value<int> id;
  final Value<String?> name;
  final Value<int?> companyId;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> country;
  final Value<String?> city;
  final Value<String?> address;
  final Value<DateTime?> createdAt;
  final Value<String?> link;
  final Value<bool> isSynced;
  const LocalCustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.companyId = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.country = const Value.absent(),
    this.city = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.link = const Value.absent(),
    this.isSynced = const Value.absent(),
  });
  LocalCustomersCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.companyId = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.country = const Value.absent(),
    this.city = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.link = const Value.absent(),
    this.isSynced = const Value.absent(),
  });
  static Insertable<LocalCustomer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? companyId,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? country,
    Expression<String>? city,
    Expression<String>? address,
    Expression<DateTime>? createdAt,
    Expression<String>? link,
    Expression<bool>? isSynced,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (companyId != null) 'company_id': companyId,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (country != null) 'country': country,
      if (city != null) 'city': city,
      if (address != null) 'address': address,
      if (createdAt != null) 'created_at': createdAt,
      if (link != null) 'link': link,
      if (isSynced != null) 'is_synced': isSynced,
    });
  }

  LocalCustomersCompanion copyWith(
      {Value<int>? id,
      Value<String?>? name,
      Value<int?>? companyId,
      Value<String?>? email,
      Value<String?>? phone,
      Value<String?>? country,
      Value<String?>? city,
      Value<String?>? address,
      Value<DateTime?>? createdAt,
      Value<String?>? link,
      Value<bool>? isSynced}) {
    return LocalCustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      companyId: companyId ?? this.companyId,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      city: city ?? this.city,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      link: link ?? this.link,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<int>(companyId.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalCustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('companyId: $companyId, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('country: $country, ')
          ..write('city: $city, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('link: $link, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }
}

class $LocalBarTablesTable extends LocalBarTables
    with TableInfo<$LocalBarTablesTable, LocalBarTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalBarTablesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _companyIdMeta =
      const VerificationMeta('companyId');
  @override
  late final GeneratedColumn<int> companyId = GeneratedColumn<int>(
      'company_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _chairsNoMeta =
      const VerificationMeta('chairsNo');
  @override
  late final GeneratedColumn<int> chairsNo = GeneratedColumn<int>(
      'chairs_no', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
      'link', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, companyId, chairsNo, createdAt, link];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_bar_tables';
  @override
  VerificationContext validateIntegrity(Insertable<LocalBarTable> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('company_id')) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta));
    }
    if (data.containsKey('chairs_no')) {
      context.handle(_chairsNoMeta,
          chairsNo.isAcceptableOrUnknown(data['chairs_no']!, _chairsNoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link']!, _linkMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalBarTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalBarTable(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      companyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}company_id']),
      chairsNo: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chairs_no']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      link: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}link']),
    );
  }

  @override
  $LocalBarTablesTable createAlias(String alias) {
    return $LocalBarTablesTable(attachedDatabase, alias);
  }
}

class LocalBarTable extends DataClass implements Insertable<LocalBarTable> {
  final int? id;
  final String? name;
  final int? companyId;
  final int? chairsNo;
  final DateTime? createdAt;
  final String? link;
  const LocalBarTable(
      {this.id,
      this.name,
      this.companyId,
      this.chairsNo,
      this.createdAt,
      this.link});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || companyId != null) {
      map['company_id'] = Variable<int>(companyId);
    }
    if (!nullToAbsent || chairsNo != null) {
      map['chairs_no'] = Variable<int>(chairsNo);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || link != null) {
      map['link'] = Variable<String>(link);
    }
    return map;
  }

  LocalBarTablesCompanion toCompanion(bool nullToAbsent) {
    return LocalBarTablesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      companyId: companyId == null && nullToAbsent
          ? const Value.absent()
          : Value(companyId),
      chairsNo: chairsNo == null && nullToAbsent
          ? const Value.absent()
          : Value(chairsNo),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      link: link == null && nullToAbsent ? const Value.absent() : Value(link),
    );
  }

  factory LocalBarTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalBarTable(
      id: serializer.fromJson<int?>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      companyId: serializer.fromJson<int?>(json['companyId']),
      chairsNo: serializer.fromJson<int?>(json['chairsNo']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      link: serializer.fromJson<String?>(json['link']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'name': serializer.toJson<String?>(name),
      'companyId': serializer.toJson<int?>(companyId),
      'chairsNo': serializer.toJson<int?>(chairsNo),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'link': serializer.toJson<String?>(link),
    };
  }

  LocalBarTable copyWith(
          {Value<int?> id = const Value.absent(),
          Value<String?> name = const Value.absent(),
          Value<int?> companyId = const Value.absent(),
          Value<int?> chairsNo = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<String?> link = const Value.absent()}) =>
      LocalBarTable(
        id: id.present ? id.value : this.id,
        name: name.present ? name.value : this.name,
        companyId: companyId.present ? companyId.value : this.companyId,
        chairsNo: chairsNo.present ? chairsNo.value : this.chairsNo,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        link: link.present ? link.value : this.link,
      );
  LocalBarTable copyWithCompanion(LocalBarTablesCompanion data) {
    return LocalBarTable(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      chairsNo: data.chairsNo.present ? data.chairsNo.value : this.chairsNo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      link: data.link.present ? data.link.value : this.link,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalBarTable(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('companyId: $companyId, ')
          ..write('chairsNo: $chairsNo, ')
          ..write('createdAt: $createdAt, ')
          ..write('link: $link')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, companyId, chairsNo, createdAt, link);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalBarTable &&
          other.id == this.id &&
          other.name == this.name &&
          other.companyId == this.companyId &&
          other.chairsNo == this.chairsNo &&
          other.createdAt == this.createdAt &&
          other.link == this.link);
}

class LocalBarTablesCompanion extends UpdateCompanion<LocalBarTable> {
  final Value<int?> id;
  final Value<String?> name;
  final Value<int?> companyId;
  final Value<int?> chairsNo;
  final Value<DateTime?> createdAt;
  final Value<String?> link;
  const LocalBarTablesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.companyId = const Value.absent(),
    this.chairsNo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.link = const Value.absent(),
  });
  LocalBarTablesCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.companyId = const Value.absent(),
    this.chairsNo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.link = const Value.absent(),
  });
  static Insertable<LocalBarTable> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? companyId,
    Expression<int>? chairsNo,
    Expression<DateTime>? createdAt,
    Expression<String>? link,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (companyId != null) 'company_id': companyId,
      if (chairsNo != null) 'chairs_no': chairsNo,
      if (createdAt != null) 'created_at': createdAt,
      if (link != null) 'link': link,
    });
  }

  LocalBarTablesCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? name,
      Value<int?>? companyId,
      Value<int?>? chairsNo,
      Value<DateTime?>? createdAt,
      Value<String?>? link}) {
    return LocalBarTablesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      companyId: companyId ?? this.companyId,
      chairsNo: chairsNo ?? this.chairsNo,
      createdAt: createdAt ?? this.createdAt,
      link: link ?? this.link,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<int>(companyId.value);
    }
    if (chairsNo.present) {
      map['chairs_no'] = Variable<int>(chairsNo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalBarTablesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('companyId: $companyId, ')
          ..write('chairsNo: $chairsNo, ')
          ..write('createdAt: $createdAt, ')
          ..write('link: $link')
          ..write(')'))
        .toString();
  }
}

class $LocalProductCategoriesTable extends LocalProductCategories
    with TableInfo<$LocalProductCategoriesTable, LocalProductCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalProductCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _companyIdMeta =
      const VerificationMeta('companyId');
  @override
  late final GeneratedColumn<int> companyId = GeneratedColumn<int>(
      'company_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _productCountMeta =
      const VerificationMeta('productCount');
  @override
  late final GeneratedColumn<int> productCount = GeneratedColumn<int>(
      'product_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
      'link', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, companyId, image, productCount, link];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_product_categories';
  @override
  VerificationContext validateIntegrity(
      Insertable<LocalProductCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('company_id')) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    if (data.containsKey('product_count')) {
      context.handle(
          _productCountMeta,
          productCount.isAcceptableOrUnknown(
              data['product_count']!, _productCountMeta));
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link']!, _linkMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalProductCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalProductCategory(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      companyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}company_id']),
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image']),
      productCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_count']),
      link: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}link']),
    );
  }

  @override
  $LocalProductCategoriesTable createAlias(String alias) {
    return $LocalProductCategoriesTable(attachedDatabase, alias);
  }
}

class LocalProductCategory extends DataClass
    implements Insertable<LocalProductCategory> {
  final int? id;
  final String? name;
  final int? companyId;
  final String? image;
  final int? productCount;
  final String? link;
  const LocalProductCategory(
      {this.id,
      this.name,
      this.companyId,
      this.image,
      this.productCount,
      this.link});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || companyId != null) {
      map['company_id'] = Variable<int>(companyId);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || productCount != null) {
      map['product_count'] = Variable<int>(productCount);
    }
    if (!nullToAbsent || link != null) {
      map['link'] = Variable<String>(link);
    }
    return map;
  }

  LocalProductCategoriesCompanion toCompanion(bool nullToAbsent) {
    return LocalProductCategoriesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      companyId: companyId == null && nullToAbsent
          ? const Value.absent()
          : Value(companyId),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      productCount: productCount == null && nullToAbsent
          ? const Value.absent()
          : Value(productCount),
      link: link == null && nullToAbsent ? const Value.absent() : Value(link),
    );
  }

  factory LocalProductCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalProductCategory(
      id: serializer.fromJson<int?>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      companyId: serializer.fromJson<int?>(json['companyId']),
      image: serializer.fromJson<String?>(json['image']),
      productCount: serializer.fromJson<int?>(json['productCount']),
      link: serializer.fromJson<String?>(json['link']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'name': serializer.toJson<String?>(name),
      'companyId': serializer.toJson<int?>(companyId),
      'image': serializer.toJson<String?>(image),
      'productCount': serializer.toJson<int?>(productCount),
      'link': serializer.toJson<String?>(link),
    };
  }

  LocalProductCategory copyWith(
          {Value<int?> id = const Value.absent(),
          Value<String?> name = const Value.absent(),
          Value<int?> companyId = const Value.absent(),
          Value<String?> image = const Value.absent(),
          Value<int?> productCount = const Value.absent(),
          Value<String?> link = const Value.absent()}) =>
      LocalProductCategory(
        id: id.present ? id.value : this.id,
        name: name.present ? name.value : this.name,
        companyId: companyId.present ? companyId.value : this.companyId,
        image: image.present ? image.value : this.image,
        productCount:
            productCount.present ? productCount.value : this.productCount,
        link: link.present ? link.value : this.link,
      );
  LocalProductCategory copyWithCompanion(LocalProductCategoriesCompanion data) {
    return LocalProductCategory(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      image: data.image.present ? data.image.value : this.image,
      productCount: data.productCount.present
          ? data.productCount.value
          : this.productCount,
      link: data.link.present ? data.link.value : this.link,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalProductCategory(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('companyId: $companyId, ')
          ..write('image: $image, ')
          ..write('productCount: $productCount, ')
          ..write('link: $link')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, companyId, image, productCount, link);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalProductCategory &&
          other.id == this.id &&
          other.name == this.name &&
          other.companyId == this.companyId &&
          other.image == this.image &&
          other.productCount == this.productCount &&
          other.link == this.link);
}

class LocalProductCategoriesCompanion
    extends UpdateCompanion<LocalProductCategory> {
  final Value<int?> id;
  final Value<String?> name;
  final Value<int?> companyId;
  final Value<String?> image;
  final Value<int?> productCount;
  final Value<String?> link;
  const LocalProductCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.companyId = const Value.absent(),
    this.image = const Value.absent(),
    this.productCount = const Value.absent(),
    this.link = const Value.absent(),
  });
  LocalProductCategoriesCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.companyId = const Value.absent(),
    this.image = const Value.absent(),
    this.productCount = const Value.absent(),
    this.link = const Value.absent(),
  });
  static Insertable<LocalProductCategory> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? companyId,
    Expression<String>? image,
    Expression<int>? productCount,
    Expression<String>? link,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (companyId != null) 'company_id': companyId,
      if (image != null) 'image': image,
      if (productCount != null) 'product_count': productCount,
      if (link != null) 'link': link,
    });
  }

  LocalProductCategoriesCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? name,
      Value<int?>? companyId,
      Value<String?>? image,
      Value<int?>? productCount,
      Value<String?>? link}) {
    return LocalProductCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      companyId: companyId ?? this.companyId,
      image: image ?? this.image,
      productCount: productCount ?? this.productCount,
      link: link ?? this.link,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<int>(companyId.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (productCount.present) {
      map['product_count'] = Variable<int>(productCount.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalProductCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('companyId: $companyId, ')
          ..write('image: $image, ')
          ..write('productCount: $productCount, ')
          ..write('link: $link')
          ..write(')'))
        .toString();
  }
}

class $LocalProductsTable extends LocalProducts
    with TableInfo<$LocalProductsTable, LocalProduct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _companyIdMeta =
      const VerificationMeta('companyId');
  @override
  late final GeneratedColumn<int> companyId = GeneratedColumn<int>(
      'company_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _expiryDateMeta =
      const VerificationMeta('expiryDate');
  @override
  late final GeneratedColumn<DateTime> expiryDate = GeneratedColumn<DateTime>(
      'expiry_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _mainProductIdMeta =
      const VerificationMeta('mainProductId');
  @override
  late final GeneratedColumn<int> mainProductId = GeneratedColumn<int>(
      'main_product_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _productCategoryIdMeta =
      const VerificationMeta('productCategoryId');
  @override
  late final GeneratedColumn<int> productCategoryId = GeneratedColumn<int>(
      'product_category_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _productCostMeta =
      const VerificationMeta('productCost');
  @override
  late final GeneratedColumn<double> productCost = GeneratedColumn<double>(
      'product_cost', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _productPriceMeta =
      const VerificationMeta('productPrice');
  @override
  late final GeneratedColumn<double> productPrice = GeneratedColumn<double>(
      'product_price', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _inStockMeta =
      const VerificationMeta('inStock');
  @override
  late final GeneratedColumn<int> inStock = GeneratedColumn<int>(
      'in_stock', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
      'link', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stockIdMeta =
      const VerificationMeta('stockId');
  @override
  late final GeneratedColumn<int> stockId = GeneratedColumn<int>(
      'stock_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _warehouseIdMeta =
      const VerificationMeta('warehouseId');
  @override
  late final GeneratedColumn<int> warehouseId = GeneratedColumn<int>(
      'warehouse_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _brandNameMeta =
      const VerificationMeta('brandName');
  @override
  late final GeneratedColumn<String> brandName = GeneratedColumn<String>(
      'brand_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _productCategoryNameMeta =
      const VerificationMeta('productCategoryName');
  @override
  late final GeneratedColumn<String> productCategoryName =
      GeneratedColumn<String>('product_category_name', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stockAlertMeta =
      const VerificationMeta('stockAlert');
  @override
  late final GeneratedColumn<String> stockAlert = GeneratedColumn<String>(
      'stock_alert', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<ProductUnitName?, String>
      productUnitName = GeneratedColumn<String>(
              'product_unit_name', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ProductUnitName?>(
              $LocalProductsTable.$converterproductUnitName);
  @override
  late final GeneratedColumnWithTypeConverter<List<ProductWarehouse>?, String>
      warehouse = GeneratedColumn<String>('warehouse', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<ProductWarehouse>?>(
              $LocalProductsTable.$converterwarehouse);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        companyId,
        code,
        expiryDate,
        mainProductId,
        productCategoryId,
        productCost,
        productPrice,
        isActive,
        createdAt,
        inStock,
        link,
        stockId,
        warehouseId,
        brandName,
        productCategoryName,
        stockAlert,
        productUnitName,
        warehouse
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_products';
  @override
  VerificationContext validateIntegrity(Insertable<LocalProduct> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('company_id')) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('expiry_date')) {
      context.handle(
          _expiryDateMeta,
          expiryDate.isAcceptableOrUnknown(
              data['expiry_date']!, _expiryDateMeta));
    }
    if (data.containsKey('main_product_id')) {
      context.handle(
          _mainProductIdMeta,
          mainProductId.isAcceptableOrUnknown(
              data['main_product_id']!, _mainProductIdMeta));
    }
    if (data.containsKey('product_category_id')) {
      context.handle(
          _productCategoryIdMeta,
          productCategoryId.isAcceptableOrUnknown(
              data['product_category_id']!, _productCategoryIdMeta));
    }
    if (data.containsKey('product_cost')) {
      context.handle(
          _productCostMeta,
          productCost.isAcceptableOrUnknown(
              data['product_cost']!, _productCostMeta));
    }
    if (data.containsKey('product_price')) {
      context.handle(
          _productPriceMeta,
          productPrice.isAcceptableOrUnknown(
              data['product_price']!, _productPriceMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('in_stock')) {
      context.handle(_inStockMeta,
          inStock.isAcceptableOrUnknown(data['in_stock']!, _inStockMeta));
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link']!, _linkMeta));
    }
    if (data.containsKey('stock_id')) {
      context.handle(_stockIdMeta,
          stockId.isAcceptableOrUnknown(data['stock_id']!, _stockIdMeta));
    }
    if (data.containsKey('warehouse_id')) {
      context.handle(
          _warehouseIdMeta,
          warehouseId.isAcceptableOrUnknown(
              data['warehouse_id']!, _warehouseIdMeta));
    }
    if (data.containsKey('brand_name')) {
      context.handle(_brandNameMeta,
          brandName.isAcceptableOrUnknown(data['brand_name']!, _brandNameMeta));
    }
    if (data.containsKey('product_category_name')) {
      context.handle(
          _productCategoryNameMeta,
          productCategoryName.isAcceptableOrUnknown(
              data['product_category_name']!, _productCategoryNameMeta));
    }
    if (data.containsKey('stock_alert')) {
      context.handle(
          _stockAlertMeta,
          stockAlert.isAcceptableOrUnknown(
              data['stock_alert']!, _stockAlertMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalProduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalProduct(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      companyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}company_id']),
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      expiryDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}expiry_date']),
      mainProductId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}main_product_id']),
      productCategoryId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}product_category_id']),
      productCost: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}product_cost']),
      productPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}product_price']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      inStock: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}in_stock']),
      link: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}link']),
      stockId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock_id']),
      warehouseId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}warehouse_id']),
      brandName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}brand_name']),
      productCategoryName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}product_category_name']),
      stockAlert: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stock_alert']),
      productUnitName: $LocalProductsTable.$converterproductUnitName.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}product_unit_name'])),
      warehouse: $LocalProductsTable.$converterwarehouse.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}warehouse'])),
    );
  }

  @override
  $LocalProductsTable createAlias(String alias) {
    return $LocalProductsTable(attachedDatabase, alias);
  }

  static TypeConverter<ProductUnitName?, String?> $converterproductUnitName =
      NullAwareTypeConverter.wrap(const ProductUnitNameConverter());
  static TypeConverter<List<ProductWarehouse>?, String?> $converterwarehouse =
      NullAwareTypeConverter.wrap(const ProductWarehouseListConverter());
}

class LocalProduct extends DataClass implements Insertable<LocalProduct> {
  final int? id;
  final String? name;
  final int? companyId;
  final String? code;
  final DateTime? expiryDate;
  final int? mainProductId;
  final int? productCategoryId;
  final double? productCost;
  final double? productPrice;
  final bool? isActive;
  final DateTime? createdAt;
  final int? inStock;
  final String? link;
  final int? stockId;
  final int? warehouseId;
  final String? brandName;
  final String? productCategoryName;
  final String? stockAlert;
  final ProductUnitName? productUnitName;
  final List<ProductWarehouse>? warehouse;
  const LocalProduct(
      {this.id,
      this.name,
      this.companyId,
      this.code,
      this.expiryDate,
      this.mainProductId,
      this.productCategoryId,
      this.productCost,
      this.productPrice,
      this.isActive,
      this.createdAt,
      this.inStock,
      this.link,
      this.stockId,
      this.warehouseId,
      this.brandName,
      this.productCategoryName,
      this.stockAlert,
      this.productUnitName,
      this.warehouse});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || companyId != null) {
      map['company_id'] = Variable<int>(companyId);
    }
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    if (!nullToAbsent || expiryDate != null) {
      map['expiry_date'] = Variable<DateTime>(expiryDate);
    }
    if (!nullToAbsent || mainProductId != null) {
      map['main_product_id'] = Variable<int>(mainProductId);
    }
    if (!nullToAbsent || productCategoryId != null) {
      map['product_category_id'] = Variable<int>(productCategoryId);
    }
    if (!nullToAbsent || productCost != null) {
      map['product_cost'] = Variable<double>(productCost);
    }
    if (!nullToAbsent || productPrice != null) {
      map['product_price'] = Variable<double>(productPrice);
    }
    if (!nullToAbsent || isActive != null) {
      map['is_active'] = Variable<bool>(isActive);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || inStock != null) {
      map['in_stock'] = Variable<int>(inStock);
    }
    if (!nullToAbsent || link != null) {
      map['link'] = Variable<String>(link);
    }
    if (!nullToAbsent || stockId != null) {
      map['stock_id'] = Variable<int>(stockId);
    }
    if (!nullToAbsent || warehouseId != null) {
      map['warehouse_id'] = Variable<int>(warehouseId);
    }
    if (!nullToAbsent || brandName != null) {
      map['brand_name'] = Variable<String>(brandName);
    }
    if (!nullToAbsent || productCategoryName != null) {
      map['product_category_name'] = Variable<String>(productCategoryName);
    }
    if (!nullToAbsent || stockAlert != null) {
      map['stock_alert'] = Variable<String>(stockAlert);
    }
    if (!nullToAbsent || productUnitName != null) {
      map['product_unit_name'] = Variable<String>(
          $LocalProductsTable.$converterproductUnitName.toSql(productUnitName));
    }
    if (!nullToAbsent || warehouse != null) {
      map['warehouse'] = Variable<String>(
          $LocalProductsTable.$converterwarehouse.toSql(warehouse));
    }
    return map;
  }

  LocalProductsCompanion toCompanion(bool nullToAbsent) {
    return LocalProductsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      companyId: companyId == null && nullToAbsent
          ? const Value.absent()
          : Value(companyId),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      expiryDate: expiryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expiryDate),
      mainProductId: mainProductId == null && nullToAbsent
          ? const Value.absent()
          : Value(mainProductId),
      productCategoryId: productCategoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(productCategoryId),
      productCost: productCost == null && nullToAbsent
          ? const Value.absent()
          : Value(productCost),
      productPrice: productPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(productPrice),
      isActive: isActive == null && nullToAbsent
          ? const Value.absent()
          : Value(isActive),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      inStock: inStock == null && nullToAbsent
          ? const Value.absent()
          : Value(inStock),
      link: link == null && nullToAbsent ? const Value.absent() : Value(link),
      stockId: stockId == null && nullToAbsent
          ? const Value.absent()
          : Value(stockId),
      warehouseId: warehouseId == null && nullToAbsent
          ? const Value.absent()
          : Value(warehouseId),
      brandName: brandName == null && nullToAbsent
          ? const Value.absent()
          : Value(brandName),
      productCategoryName: productCategoryName == null && nullToAbsent
          ? const Value.absent()
          : Value(productCategoryName),
      stockAlert: stockAlert == null && nullToAbsent
          ? const Value.absent()
          : Value(stockAlert),
      productUnitName: productUnitName == null && nullToAbsent
          ? const Value.absent()
          : Value(productUnitName),
      warehouse: warehouse == null && nullToAbsent
          ? const Value.absent()
          : Value(warehouse),
    );
  }

  factory LocalProduct.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalProduct(
      id: serializer.fromJson<int?>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      companyId: serializer.fromJson<int?>(json['companyId']),
      code: serializer.fromJson<String?>(json['code']),
      expiryDate: serializer.fromJson<DateTime?>(json['expiryDate']),
      mainProductId: serializer.fromJson<int?>(json['mainProductId']),
      productCategoryId: serializer.fromJson<int?>(json['productCategoryId']),
      productCost: serializer.fromJson<double?>(json['productCost']),
      productPrice: serializer.fromJson<double?>(json['productPrice']),
      isActive: serializer.fromJson<bool?>(json['isActive']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      inStock: serializer.fromJson<int?>(json['inStock']),
      link: serializer.fromJson<String?>(json['link']),
      stockId: serializer.fromJson<int?>(json['stockId']),
      warehouseId: serializer.fromJson<int?>(json['warehouseId']),
      brandName: serializer.fromJson<String?>(json['brandName']),
      productCategoryName:
          serializer.fromJson<String?>(json['productCategoryName']),
      stockAlert: serializer.fromJson<String?>(json['stockAlert']),
      productUnitName:
          serializer.fromJson<ProductUnitName?>(json['productUnitName']),
      warehouse:
          serializer.fromJson<List<ProductWarehouse>?>(json['warehouse']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'name': serializer.toJson<String?>(name),
      'companyId': serializer.toJson<int?>(companyId),
      'code': serializer.toJson<String?>(code),
      'expiryDate': serializer.toJson<DateTime?>(expiryDate),
      'mainProductId': serializer.toJson<int?>(mainProductId),
      'productCategoryId': serializer.toJson<int?>(productCategoryId),
      'productCost': serializer.toJson<double?>(productCost),
      'productPrice': serializer.toJson<double?>(productPrice),
      'isActive': serializer.toJson<bool?>(isActive),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'inStock': serializer.toJson<int?>(inStock),
      'link': serializer.toJson<String?>(link),
      'stockId': serializer.toJson<int?>(stockId),
      'warehouseId': serializer.toJson<int?>(warehouseId),
      'brandName': serializer.toJson<String?>(brandName),
      'productCategoryName': serializer.toJson<String?>(productCategoryName),
      'stockAlert': serializer.toJson<String?>(stockAlert),
      'productUnitName': serializer.toJson<ProductUnitName?>(productUnitName),
      'warehouse': serializer.toJson<List<ProductWarehouse>?>(warehouse),
    };
  }

  LocalProduct copyWith(
          {Value<int?> id = const Value.absent(),
          Value<String?> name = const Value.absent(),
          Value<int?> companyId = const Value.absent(),
          Value<String?> code = const Value.absent(),
          Value<DateTime?> expiryDate = const Value.absent(),
          Value<int?> mainProductId = const Value.absent(),
          Value<int?> productCategoryId = const Value.absent(),
          Value<double?> productCost = const Value.absent(),
          Value<double?> productPrice = const Value.absent(),
          Value<bool?> isActive = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<int?> inStock = const Value.absent(),
          Value<String?> link = const Value.absent(),
          Value<int?> stockId = const Value.absent(),
          Value<int?> warehouseId = const Value.absent(),
          Value<String?> brandName = const Value.absent(),
          Value<String?> productCategoryName = const Value.absent(),
          Value<String?> stockAlert = const Value.absent(),
          Value<ProductUnitName?> productUnitName = const Value.absent(),
          Value<List<ProductWarehouse>?> warehouse = const Value.absent()}) =>
      LocalProduct(
        id: id.present ? id.value : this.id,
        name: name.present ? name.value : this.name,
        companyId: companyId.present ? companyId.value : this.companyId,
        code: code.present ? code.value : this.code,
        expiryDate: expiryDate.present ? expiryDate.value : this.expiryDate,
        mainProductId:
            mainProductId.present ? mainProductId.value : this.mainProductId,
        productCategoryId: productCategoryId.present
            ? productCategoryId.value
            : this.productCategoryId,
        productCost: productCost.present ? productCost.value : this.productCost,
        productPrice:
            productPrice.present ? productPrice.value : this.productPrice,
        isActive: isActive.present ? isActive.value : this.isActive,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        inStock: inStock.present ? inStock.value : this.inStock,
        link: link.present ? link.value : this.link,
        stockId: stockId.present ? stockId.value : this.stockId,
        warehouseId: warehouseId.present ? warehouseId.value : this.warehouseId,
        brandName: brandName.present ? brandName.value : this.brandName,
        productCategoryName: productCategoryName.present
            ? productCategoryName.value
            : this.productCategoryName,
        stockAlert: stockAlert.present ? stockAlert.value : this.stockAlert,
        productUnitName: productUnitName.present
            ? productUnitName.value
            : this.productUnitName,
        warehouse: warehouse.present ? warehouse.value : this.warehouse,
      );
  LocalProduct copyWithCompanion(LocalProductsCompanion data) {
    return LocalProduct(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      code: data.code.present ? data.code.value : this.code,
      expiryDate:
          data.expiryDate.present ? data.expiryDate.value : this.expiryDate,
      mainProductId: data.mainProductId.present
          ? data.mainProductId.value
          : this.mainProductId,
      productCategoryId: data.productCategoryId.present
          ? data.productCategoryId.value
          : this.productCategoryId,
      productCost:
          data.productCost.present ? data.productCost.value : this.productCost,
      productPrice: data.productPrice.present
          ? data.productPrice.value
          : this.productPrice,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      inStock: data.inStock.present ? data.inStock.value : this.inStock,
      link: data.link.present ? data.link.value : this.link,
      stockId: data.stockId.present ? data.stockId.value : this.stockId,
      warehouseId:
          data.warehouseId.present ? data.warehouseId.value : this.warehouseId,
      brandName: data.brandName.present ? data.brandName.value : this.brandName,
      productCategoryName: data.productCategoryName.present
          ? data.productCategoryName.value
          : this.productCategoryName,
      stockAlert:
          data.stockAlert.present ? data.stockAlert.value : this.stockAlert,
      productUnitName: data.productUnitName.present
          ? data.productUnitName.value
          : this.productUnitName,
      warehouse: data.warehouse.present ? data.warehouse.value : this.warehouse,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalProduct(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('companyId: $companyId, ')
          ..write('code: $code, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('mainProductId: $mainProductId, ')
          ..write('productCategoryId: $productCategoryId, ')
          ..write('productCost: $productCost, ')
          ..write('productPrice: $productPrice, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('inStock: $inStock, ')
          ..write('link: $link, ')
          ..write('stockId: $stockId, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('brandName: $brandName, ')
          ..write('productCategoryName: $productCategoryName, ')
          ..write('stockAlert: $stockAlert, ')
          ..write('productUnitName: $productUnitName, ')
          ..write('warehouse: $warehouse')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      companyId,
      code,
      expiryDate,
      mainProductId,
      productCategoryId,
      productCost,
      productPrice,
      isActive,
      createdAt,
      inStock,
      link,
      stockId,
      warehouseId,
      brandName,
      productCategoryName,
      stockAlert,
      productUnitName,
      warehouse);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalProduct &&
          other.id == this.id &&
          other.name == this.name &&
          other.companyId == this.companyId &&
          other.code == this.code &&
          other.expiryDate == this.expiryDate &&
          other.mainProductId == this.mainProductId &&
          other.productCategoryId == this.productCategoryId &&
          other.productCost == this.productCost &&
          other.productPrice == this.productPrice &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.inStock == this.inStock &&
          other.link == this.link &&
          other.stockId == this.stockId &&
          other.warehouseId == this.warehouseId &&
          other.brandName == this.brandName &&
          other.productCategoryName == this.productCategoryName &&
          other.stockAlert == this.stockAlert &&
          other.productUnitName == this.productUnitName &&
          other.warehouse == this.warehouse);
}

class LocalProductsCompanion extends UpdateCompanion<LocalProduct> {
  final Value<int?> id;
  final Value<String?> name;
  final Value<int?> companyId;
  final Value<String?> code;
  final Value<DateTime?> expiryDate;
  final Value<int?> mainProductId;
  final Value<int?> productCategoryId;
  final Value<double?> productCost;
  final Value<double?> productPrice;
  final Value<bool?> isActive;
  final Value<DateTime?> createdAt;
  final Value<int?> inStock;
  final Value<String?> link;
  final Value<int?> stockId;
  final Value<int?> warehouseId;
  final Value<String?> brandName;
  final Value<String?> productCategoryName;
  final Value<String?> stockAlert;
  final Value<ProductUnitName?> productUnitName;
  final Value<List<ProductWarehouse>?> warehouse;
  const LocalProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.companyId = const Value.absent(),
    this.code = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.mainProductId = const Value.absent(),
    this.productCategoryId = const Value.absent(),
    this.productCost = const Value.absent(),
    this.productPrice = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.inStock = const Value.absent(),
    this.link = const Value.absent(),
    this.stockId = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.brandName = const Value.absent(),
    this.productCategoryName = const Value.absent(),
    this.stockAlert = const Value.absent(),
    this.productUnitName = const Value.absent(),
    this.warehouse = const Value.absent(),
  });
  LocalProductsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.companyId = const Value.absent(),
    this.code = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.mainProductId = const Value.absent(),
    this.productCategoryId = const Value.absent(),
    this.productCost = const Value.absent(),
    this.productPrice = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.inStock = const Value.absent(),
    this.link = const Value.absent(),
    this.stockId = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.brandName = const Value.absent(),
    this.productCategoryName = const Value.absent(),
    this.stockAlert = const Value.absent(),
    this.productUnitName = const Value.absent(),
    this.warehouse = const Value.absent(),
  });
  static Insertable<LocalProduct> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? companyId,
    Expression<String>? code,
    Expression<DateTime>? expiryDate,
    Expression<int>? mainProductId,
    Expression<int>? productCategoryId,
    Expression<double>? productCost,
    Expression<double>? productPrice,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<int>? inStock,
    Expression<String>? link,
    Expression<int>? stockId,
    Expression<int>? warehouseId,
    Expression<String>? brandName,
    Expression<String>? productCategoryName,
    Expression<String>? stockAlert,
    Expression<String>? productUnitName,
    Expression<String>? warehouse,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (companyId != null) 'company_id': companyId,
      if (code != null) 'code': code,
      if (expiryDate != null) 'expiry_date': expiryDate,
      if (mainProductId != null) 'main_product_id': mainProductId,
      if (productCategoryId != null) 'product_category_id': productCategoryId,
      if (productCost != null) 'product_cost': productCost,
      if (productPrice != null) 'product_price': productPrice,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (inStock != null) 'in_stock': inStock,
      if (link != null) 'link': link,
      if (stockId != null) 'stock_id': stockId,
      if (warehouseId != null) 'warehouse_id': warehouseId,
      if (brandName != null) 'brand_name': brandName,
      if (productCategoryName != null)
        'product_category_name': productCategoryName,
      if (stockAlert != null) 'stock_alert': stockAlert,
      if (productUnitName != null) 'product_unit_name': productUnitName,
      if (warehouse != null) 'warehouse': warehouse,
    });
  }

  LocalProductsCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? name,
      Value<int?>? companyId,
      Value<String?>? code,
      Value<DateTime?>? expiryDate,
      Value<int?>? mainProductId,
      Value<int?>? productCategoryId,
      Value<double?>? productCost,
      Value<double?>? productPrice,
      Value<bool?>? isActive,
      Value<DateTime?>? createdAt,
      Value<int?>? inStock,
      Value<String?>? link,
      Value<int?>? stockId,
      Value<int?>? warehouseId,
      Value<String?>? brandName,
      Value<String?>? productCategoryName,
      Value<String?>? stockAlert,
      Value<ProductUnitName?>? productUnitName,
      Value<List<ProductWarehouse>?>? warehouse}) {
    return LocalProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      companyId: companyId ?? this.companyId,
      code: code ?? this.code,
      expiryDate: expiryDate ?? this.expiryDate,
      mainProductId: mainProductId ?? this.mainProductId,
      productCategoryId: productCategoryId ?? this.productCategoryId,
      productCost: productCost ?? this.productCost,
      productPrice: productPrice ?? this.productPrice,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      inStock: inStock ?? this.inStock,
      link: link ?? this.link,
      stockId: stockId ?? this.stockId,
      warehouseId: warehouseId ?? this.warehouseId,
      brandName: brandName ?? this.brandName,
      productCategoryName: productCategoryName ?? this.productCategoryName,
      stockAlert: stockAlert ?? this.stockAlert,
      productUnitName: productUnitName ?? this.productUnitName,
      warehouse: warehouse ?? this.warehouse,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<int>(companyId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<DateTime>(expiryDate.value);
    }
    if (mainProductId.present) {
      map['main_product_id'] = Variable<int>(mainProductId.value);
    }
    if (productCategoryId.present) {
      map['product_category_id'] = Variable<int>(productCategoryId.value);
    }
    if (productCost.present) {
      map['product_cost'] = Variable<double>(productCost.value);
    }
    if (productPrice.present) {
      map['product_price'] = Variable<double>(productPrice.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (inStock.present) {
      map['in_stock'] = Variable<int>(inStock.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (stockId.present) {
      map['stock_id'] = Variable<int>(stockId.value);
    }
    if (warehouseId.present) {
      map['warehouse_id'] = Variable<int>(warehouseId.value);
    }
    if (brandName.present) {
      map['brand_name'] = Variable<String>(brandName.value);
    }
    if (productCategoryName.present) {
      map['product_category_name'] =
          Variable<String>(productCategoryName.value);
    }
    if (stockAlert.present) {
      map['stock_alert'] = Variable<String>(stockAlert.value);
    }
    if (productUnitName.present) {
      map['product_unit_name'] = Variable<String>($LocalProductsTable
          .$converterproductUnitName
          .toSql(productUnitName.value));
    }
    if (warehouse.present) {
      map['warehouse'] = Variable<String>(
          $LocalProductsTable.$converterwarehouse.toSql(warehouse.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('companyId: $companyId, ')
          ..write('code: $code, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('mainProductId: $mainProductId, ')
          ..write('productCategoryId: $productCategoryId, ')
          ..write('productCost: $productCost, ')
          ..write('productPrice: $productPrice, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('inStock: $inStock, ')
          ..write('link: $link, ')
          ..write('stockId: $stockId, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('brandName: $brandName, ')
          ..write('productCategoryName: $productCategoryName, ')
          ..write('stockAlert: $stockAlert, ')
          ..write('productUnitName: $productUnitName, ')
          ..write('warehouse: $warehouse')
          ..write(')'))
        .toString();
  }
}

class $LocalWarehousesTable extends LocalWarehouses
    with TableInfo<$LocalWarehousesTable, LocalWarehouse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalWarehousesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _countryMeta =
      const VerificationMeta('country');
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
      'country', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _zipCodeMeta =
      const VerificationMeta('zipCode');
  @override
  late final GeneratedColumn<String> zipCode = GeneratedColumn<String>(
      'zip_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _companyIdMeta =
      const VerificationMeta('companyId');
  @override
  late final GeneratedColumn<int> companyId = GeneratedColumn<int>(
      'company_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        phone,
        country,
        city,
        email,
        zipCode,
        status,
        companyId,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_warehouses';
  @override
  VerificationContext validateIntegrity(Insertable<LocalWarehouse> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('zip_code')) {
      context.handle(_zipCodeMeta,
          zipCode.isAcceptableOrUnknown(data['zip_code']!, _zipCodeMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('company_id')) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalWarehouse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalWarehouse(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      country: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country']),
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      zipCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}zip_code']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status']),
      companyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}company_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $LocalWarehousesTable createAlias(String alias) {
    return $LocalWarehousesTable(attachedDatabase, alias);
  }
}

class LocalWarehouse extends DataClass implements Insertable<LocalWarehouse> {
  final int? id;
  final String? name;
  final String? phone;
  final String? country;
  final String? city;
  final String? email;
  final String? zipCode;
  final int? status;
  final int? companyId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const LocalWarehouse(
      {this.id,
      this.name,
      this.phone,
      this.country,
      this.city,
      this.email,
      this.zipCode,
      this.status,
      this.companyId,
      this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || zipCode != null) {
      map['zip_code'] = Variable<String>(zipCode);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<int>(status);
    }
    if (!nullToAbsent || companyId != null) {
      map['company_id'] = Variable<int>(companyId);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  LocalWarehousesCompanion toCompanion(bool nullToAbsent) {
    return LocalWarehousesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      zipCode: zipCode == null && nullToAbsent
          ? const Value.absent()
          : Value(zipCode),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      companyId: companyId == null && nullToAbsent
          ? const Value.absent()
          : Value(companyId),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory LocalWarehouse.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalWarehouse(
      id: serializer.fromJson<int?>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      country: serializer.fromJson<String?>(json['country']),
      city: serializer.fromJson<String?>(json['city']),
      email: serializer.fromJson<String?>(json['email']),
      zipCode: serializer.fromJson<String?>(json['zipCode']),
      status: serializer.fromJson<int?>(json['status']),
      companyId: serializer.fromJson<int?>(json['companyId']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'name': serializer.toJson<String?>(name),
      'phone': serializer.toJson<String?>(phone),
      'country': serializer.toJson<String?>(country),
      'city': serializer.toJson<String?>(city),
      'email': serializer.toJson<String?>(email),
      'zipCode': serializer.toJson<String?>(zipCode),
      'status': serializer.toJson<int?>(status),
      'companyId': serializer.toJson<int?>(companyId),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  LocalWarehouse copyWith(
          {Value<int?> id = const Value.absent(),
          Value<String?> name = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> country = const Value.absent(),
          Value<String?> city = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> zipCode = const Value.absent(),
          Value<int?> status = const Value.absent(),
          Value<int?> companyId = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      LocalWarehouse(
        id: id.present ? id.value : this.id,
        name: name.present ? name.value : this.name,
        phone: phone.present ? phone.value : this.phone,
        country: country.present ? country.value : this.country,
        city: city.present ? city.value : this.city,
        email: email.present ? email.value : this.email,
        zipCode: zipCode.present ? zipCode.value : this.zipCode,
        status: status.present ? status.value : this.status,
        companyId: companyId.present ? companyId.value : this.companyId,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  LocalWarehouse copyWithCompanion(LocalWarehousesCompanion data) {
    return LocalWarehouse(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      country: data.country.present ? data.country.value : this.country,
      city: data.city.present ? data.city.value : this.city,
      email: data.email.present ? data.email.value : this.email,
      zipCode: data.zipCode.present ? data.zipCode.value : this.zipCode,
      status: data.status.present ? data.status.value : this.status,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalWarehouse(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('country: $country, ')
          ..write('city: $city, ')
          ..write('email: $email, ')
          ..write('zipCode: $zipCode, ')
          ..write('status: $status, ')
          ..write('companyId: $companyId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, phone, country, city, email,
      zipCode, status, companyId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalWarehouse &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.country == this.country &&
          other.city == this.city &&
          other.email == this.email &&
          other.zipCode == this.zipCode &&
          other.status == this.status &&
          other.companyId == this.companyId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalWarehousesCompanion extends UpdateCompanion<LocalWarehouse> {
  final Value<int?> id;
  final Value<String?> name;
  final Value<String?> phone;
  final Value<String?> country;
  final Value<String?> city;
  final Value<String?> email;
  final Value<String?> zipCode;
  final Value<int?> status;
  final Value<int?> companyId;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  const LocalWarehousesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.country = const Value.absent(),
    this.city = const Value.absent(),
    this.email = const Value.absent(),
    this.zipCode = const Value.absent(),
    this.status = const Value.absent(),
    this.companyId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LocalWarehousesCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.country = const Value.absent(),
    this.city = const Value.absent(),
    this.email = const Value.absent(),
    this.zipCode = const Value.absent(),
    this.status = const Value.absent(),
    this.companyId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<LocalWarehouse> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? country,
    Expression<String>? city,
    Expression<String>? email,
    Expression<String>? zipCode,
    Expression<int>? status,
    Expression<int>? companyId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (country != null) 'country': country,
      if (city != null) 'city': city,
      if (email != null) 'email': email,
      if (zipCode != null) 'zip_code': zipCode,
      if (status != null) 'status': status,
      if (companyId != null) 'company_id': companyId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LocalWarehousesCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? name,
      Value<String?>? phone,
      Value<String?>? country,
      Value<String?>? city,
      Value<String?>? email,
      Value<String?>? zipCode,
      Value<int?>? status,
      Value<int?>? companyId,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return LocalWarehousesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      city: city ?? this.city,
      email: email ?? this.email,
      zipCode: zipCode ?? this.zipCode,
      status: status ?? this.status,
      companyId: companyId ?? this.companyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (zipCode.present) {
      map['zip_code'] = Variable<String>(zipCode.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<int>(companyId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalWarehousesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('country: $country, ')
          ..write('city: $city, ')
          ..write('email: $email, ')
          ..write('zipCode: $zipCode, ')
          ..write('status: $status, ')
          ..write('companyId: $companyId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LocalRegistersTable extends LocalRegisters
    with TableInfo<$LocalRegistersTable, LocalRegister> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalRegistersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _closedAtMeta =
      const VerificationMeta('closedAt');
  @override
  late final GeneratedColumn<DateTime> closedAt = GeneratedColumn<DateTime>(
      'closed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _openingCashAtHandMeta =
      const VerificationMeta('openingCashAtHand');
  @override
  late final GeneratedColumn<double> openingCashAtHand =
      GeneratedColumn<double>('opening_cash_at_hand', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _cashInHandWhileClosingMeta =
      const VerificationMeta('cashInHandWhileClosing');
  @override
  late final GeneratedColumn<double> cashInHandWhileClosing =
      GeneratedColumn<double>('cash_in_hand_while_closing', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<SpotstockUser?, String> user =
      GeneratedColumn<String>('user', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<SpotstockUser?>($LocalRegistersTable.$converteruser);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        closedAt,
        openingCashAtHand,
        cashInHandWhileClosing,
        note,
        user,
        isSynced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_registers';
  @override
  VerificationContext validateIntegrity(Insertable<LocalRegister> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('closed_at')) {
      context.handle(_closedAtMeta,
          closedAt.isAcceptableOrUnknown(data['closed_at']!, _closedAtMeta));
    }
    if (data.containsKey('opening_cash_at_hand')) {
      context.handle(
          _openingCashAtHandMeta,
          openingCashAtHand.isAcceptableOrUnknown(
              data['opening_cash_at_hand']!, _openingCashAtHandMeta));
    }
    if (data.containsKey('cash_in_hand_while_closing')) {
      context.handle(
          _cashInHandWhileClosingMeta,
          cashInHandWhileClosing.isAcceptableOrUnknown(
              data['cash_in_hand_while_closing']!,
              _cashInHandWhileClosingMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalRegister map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalRegister(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      closedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}closed_at']),
      openingCashAtHand: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}opening_cash_at_hand']),
      cashInHandWhileClosing: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}cash_in_hand_while_closing']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      user: $LocalRegistersTable.$converteruser.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user'])),
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $LocalRegistersTable createAlias(String alias) {
    return $LocalRegistersTable(attachedDatabase, alias);
  }

  static TypeConverter<SpotstockUser?, String?> $converteruser =
      NullAwareTypeConverter.wrap(const SpotstockUserConverter());
}

class LocalRegister extends DataClass implements Insertable<LocalRegister> {
  final int id;
  final DateTime? createdAt;
  final DateTime? closedAt;
  final double? openingCashAtHand;
  final double? cashInHandWhileClosing;
  final String? note;
  final SpotstockUser? user;
  final bool isSynced;
  const LocalRegister(
      {required this.id,
      this.createdAt,
      this.closedAt,
      this.openingCashAtHand,
      this.cashInHandWhileClosing,
      this.note,
      this.user,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || closedAt != null) {
      map['closed_at'] = Variable<DateTime>(closedAt);
    }
    if (!nullToAbsent || openingCashAtHand != null) {
      map['opening_cash_at_hand'] = Variable<double>(openingCashAtHand);
    }
    if (!nullToAbsent || cashInHandWhileClosing != null) {
      map['cash_in_hand_while_closing'] =
          Variable<double>(cashInHandWhileClosing);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || user != null) {
      map['user'] =
          Variable<String>($LocalRegistersTable.$converteruser.toSql(user));
    }
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  LocalRegistersCompanion toCompanion(bool nullToAbsent) {
    return LocalRegistersCompanion(
      id: Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      closedAt: closedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(closedAt),
      openingCashAtHand: openingCashAtHand == null && nullToAbsent
          ? const Value.absent()
          : Value(openingCashAtHand),
      cashInHandWhileClosing: cashInHandWhileClosing == null && nullToAbsent
          ? const Value.absent()
          : Value(cashInHandWhileClosing),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      user: user == null && nullToAbsent ? const Value.absent() : Value(user),
      isSynced: Value(isSynced),
    );
  }

  factory LocalRegister.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalRegister(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      closedAt: serializer.fromJson<DateTime?>(json['closedAt']),
      openingCashAtHand:
          serializer.fromJson<double?>(json['openingCashAtHand']),
      cashInHandWhileClosing:
          serializer.fromJson<double?>(json['cashInHandWhileClosing']),
      note: serializer.fromJson<String?>(json['note']),
      user: serializer.fromJson<SpotstockUser?>(json['user']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'closedAt': serializer.toJson<DateTime?>(closedAt),
      'openingCashAtHand': serializer.toJson<double?>(openingCashAtHand),
      'cashInHandWhileClosing':
          serializer.toJson<double?>(cashInHandWhileClosing),
      'note': serializer.toJson<String?>(note),
      'user': serializer.toJson<SpotstockUser?>(user),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  LocalRegister copyWith(
          {int? id,
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> closedAt = const Value.absent(),
          Value<double?> openingCashAtHand = const Value.absent(),
          Value<double?> cashInHandWhileClosing = const Value.absent(),
          Value<String?> note = const Value.absent(),
          Value<SpotstockUser?> user = const Value.absent(),
          bool? isSynced}) =>
      LocalRegister(
        id: id ?? this.id,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        closedAt: closedAt.present ? closedAt.value : this.closedAt,
        openingCashAtHand: openingCashAtHand.present
            ? openingCashAtHand.value
            : this.openingCashAtHand,
        cashInHandWhileClosing: cashInHandWhileClosing.present
            ? cashInHandWhileClosing.value
            : this.cashInHandWhileClosing,
        note: note.present ? note.value : this.note,
        user: user.present ? user.value : this.user,
        isSynced: isSynced ?? this.isSynced,
      );
  LocalRegister copyWithCompanion(LocalRegistersCompanion data) {
    return LocalRegister(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      closedAt: data.closedAt.present ? data.closedAt.value : this.closedAt,
      openingCashAtHand: data.openingCashAtHand.present
          ? data.openingCashAtHand.value
          : this.openingCashAtHand,
      cashInHandWhileClosing: data.cashInHandWhileClosing.present
          ? data.cashInHandWhileClosing.value
          : this.cashInHandWhileClosing,
      note: data.note.present ? data.note.value : this.note,
      user: data.user.present ? data.user.value : this.user,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalRegister(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('closedAt: $closedAt, ')
          ..write('openingCashAtHand: $openingCashAtHand, ')
          ..write('cashInHandWhileClosing: $cashInHandWhileClosing, ')
          ..write('note: $note, ')
          ..write('user: $user, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, closedAt, openingCashAtHand,
      cashInHandWhileClosing, note, user, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalRegister &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.closedAt == this.closedAt &&
          other.openingCashAtHand == this.openingCashAtHand &&
          other.cashInHandWhileClosing == this.cashInHandWhileClosing &&
          other.note == this.note &&
          other.user == this.user &&
          other.isSynced == this.isSynced);
}

class LocalRegistersCompanion extends UpdateCompanion<LocalRegister> {
  final Value<int> id;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> closedAt;
  final Value<double?> openingCashAtHand;
  final Value<double?> cashInHandWhileClosing;
  final Value<String?> note;
  final Value<SpotstockUser?> user;
  final Value<bool> isSynced;
  const LocalRegistersCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.openingCashAtHand = const Value.absent(),
    this.cashInHandWhileClosing = const Value.absent(),
    this.note = const Value.absent(),
    this.user = const Value.absent(),
    this.isSynced = const Value.absent(),
  });
  LocalRegistersCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.openingCashAtHand = const Value.absent(),
    this.cashInHandWhileClosing = const Value.absent(),
    this.note = const Value.absent(),
    this.user = const Value.absent(),
    this.isSynced = const Value.absent(),
  });
  static Insertable<LocalRegister> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? closedAt,
    Expression<double>? openingCashAtHand,
    Expression<double>? cashInHandWhileClosing,
    Expression<String>? note,
    Expression<String>? user,
    Expression<bool>? isSynced,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (closedAt != null) 'closed_at': closedAt,
      if (openingCashAtHand != null) 'opening_cash_at_hand': openingCashAtHand,
      if (cashInHandWhileClosing != null)
        'cash_in_hand_while_closing': cashInHandWhileClosing,
      if (note != null) 'note': note,
      if (user != null) 'user': user,
      if (isSynced != null) 'is_synced': isSynced,
    });
  }

  LocalRegistersCompanion copyWith(
      {Value<int>? id,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? closedAt,
      Value<double?>? openingCashAtHand,
      Value<double?>? cashInHandWhileClosing,
      Value<String?>? note,
      Value<SpotstockUser?>? user,
      Value<bool>? isSynced}) {
    return LocalRegistersCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      closedAt: closedAt ?? this.closedAt,
      openingCashAtHand: openingCashAtHand ?? this.openingCashAtHand,
      cashInHandWhileClosing:
          cashInHandWhileClosing ?? this.cashInHandWhileClosing,
      note: note ?? this.note,
      user: user ?? this.user,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (closedAt.present) {
      map['closed_at'] = Variable<DateTime>(closedAt.value);
    }
    if (openingCashAtHand.present) {
      map['opening_cash_at_hand'] = Variable<double>(openingCashAtHand.value);
    }
    if (cashInHandWhileClosing.present) {
      map['cash_in_hand_while_closing'] =
          Variable<double>(cashInHandWhileClosing.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (user.present) {
      map['user'] = Variable<String>(
          $LocalRegistersTable.$converteruser.toSql(user.value));
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalRegistersCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('closedAt: $closedAt, ')
          ..write('openingCashAtHand: $openingCashAtHand, ')
          ..write('cashInHandWhileClosing: $cashInHandWhileClosing, ')
          ..write('note: $note, ')
          ..write('user: $user, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }
}

class $LocalSalesTable extends LocalSales
    with TableInfo<$LocalSalesTable, LocalSale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalSalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      links = GeneratedColumn<String>('links', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Map<String, dynamic>?>(
              $LocalSalesTable.$converterlinks);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isReturnMeta =
      const VerificationMeta('isReturn');
  @override
  late final GeneratedColumn<int> isReturn = GeneratedColumn<int>(
      'is_return', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
      'customer_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _companyIdMeta =
      const VerificationMeta('companyId');
  @override
  late final GeneratedColumn<int> companyId = GeneratedColumn<int>(
      'company_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<SaleLoggedUser?, String>
      loggedUser = GeneratedColumn<String>('logged_user', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<SaleLoggedUser?>(
              $LocalSalesTable.$converterloggedUser);
  static const VerificationMeta _customerNameMeta =
      const VerificationMeta('customerName');
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
      'customer_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _staffNameMeta =
      const VerificationMeta('staffName');
  @override
  late final GeneratedColumn<String> staffName = GeneratedColumn<String>(
      'staff_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _warehouseIdMeta =
      const VerificationMeta('warehouseId');
  @override
  late final GeneratedColumn<int> warehouseId = GeneratedColumn<int>(
      'warehouse_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _warehouseNameMeta =
      const VerificationMeta('warehouseName');
  @override
  late final GeneratedColumn<String> warehouseName = GeneratedColumn<String>(
      'warehouse_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _taxRateMeta =
      const VerificationMeta('taxRate');
  @override
  late final GeneratedColumn<double> taxRate = GeneratedColumn<double>(
      'tax_rate', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _taxAmountMeta =
      const VerificationMeta('taxAmount');
  @override
  late final GeneratedColumn<double> taxAmount = GeneratedColumn<double>(
      'tax_amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _discountMeta =
      const VerificationMeta('discount');
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
      'discount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _discountAmountMeta =
      const VerificationMeta('discountAmount');
  @override
  late final GeneratedColumn<double> discountAmount = GeneratedColumn<double>(
      'discount_amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _shippingMeta =
      const VerificationMeta('shipping');
  @override
  late final GeneratedColumn<double> shipping = GeneratedColumn<double>(
      'shipping', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _grandTotalMeta =
      const VerificationMeta('grandTotal');
  @override
  late final GeneratedColumn<double> grandTotal = GeneratedColumn<double>(
      'grand_total', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _receivedAmountMeta =
      const VerificationMeta('receivedAmount');
  @override
  late final GeneratedColumn<double> receivedAmount = GeneratedColumn<double>(
      'received_amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _paidAmountMeta =
      const VerificationMeta('paidAmount');
  @override
  late final GeneratedColumn<double> paidAmount = GeneratedColumn<double>(
      'paid_amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _partialAmountMeta =
      const VerificationMeta('partialAmount');
  @override
  late final GeneratedColumn<double> partialAmount = GeneratedColumn<double>(
      'partial_amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _dueAmountMeta =
      const VerificationMeta('dueAmount');
  @override
  late final GeneratedColumn<double> dueAmount = GeneratedColumn<double>(
      'due_amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _paymentTypeMeta =
      const VerificationMeta('paymentType');
  @override
  late final GeneratedColumn<int> paymentType = GeneratedColumn<int>(
      'payment_type', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _paymentStatusMeta =
      const VerificationMeta('paymentStatus');
  @override
  late final GeneratedColumn<int> paymentStatus = GeneratedColumn<int>(
      'payment_status', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _referenceCodeMeta =
      const VerificationMeta('referenceCode');
  @override
  late final GeneratedColumn<String> referenceCode = GeneratedColumn<String>(
      'reference_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<List<SaleItem>?, String>
      saleItems = GeneratedColumn<String>('sale_items', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<SaleItem>?>($LocalSalesTable.$convertersaleItems);
  @override
  late final GeneratedColumnWithTypeConverter<List<SalePayment>?, String>
      payments = GeneratedColumn<String>('payments', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<SalePayment>?>(
              $LocalSalesTable.$converterpayments);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String>
      paymentMethods = GeneratedColumn<String>(
              'payment_methods', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<String>?>(
              $LocalSalesTable.$converterpaymentMethods);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _barcodeUrlMeta =
      const VerificationMeta('barcodeUrl');
  @override
  late final GeneratedColumn<String> barcodeUrl = GeneratedColumn<String>(
      'barcode_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isOfflineMeta =
      const VerificationMeta('isOffline');
  @override
  late final GeneratedColumn<bool> isOffline = GeneratedColumn<bool>(
      'is_offline', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_offline" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _offlineCustomerNameMeta =
      const VerificationMeta('offlineCustomerName');
  @override
  late final GeneratedColumn<String> offlineCustomerName =
      GeneratedColumn<String>('offline_customer_name', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _staffIdMeta =
      const VerificationMeta('staffId');
  @override
  late final GeneratedColumn<int> staffId = GeneratedColumn<int>(
      'staff_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _attendantNameMeta =
      const VerificationMeta('attendantName');
  @override
  late final GeneratedColumn<String> attendantName = GeneratedColumn<String>(
      'attendant_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _attendantIdMeta =
      const VerificationMeta('attendantId');
  @override
  late final GeneratedColumn<int> attendantId = GeneratedColumn<int>(
      'attendant_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      roomDetails = GeneratedColumn<String>('room_details', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Map<String, dynamic>?>(
              $LocalSalesTable.$converterroomDetails);
  static const VerificationMeta _partialPaymentAmountMeta =
      const VerificationMeta('partialPaymentAmount');
  @override
  late final GeneratedColumn<double> partialPaymentAmount =
      GeneratedColumn<double>('partial_payment_amount', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _partialPaymentMethodMeta =
      const VerificationMeta('partialPaymentMethod');
  @override
  late final GeneratedColumn<String> partialPaymentMethod =
      GeneratedColumn<String>('partial_payment_method', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdLocallyAtMeta =
      const VerificationMeta('createdLocallyAt');
  @override
  late final GeneratedColumn<DateTime> createdLocallyAt =
      GeneratedColumn<DateTime>('created_locally_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        remoteId,
        type,
        links,
        date,
        isReturn,
        customerId,
        companyId,
        loggedUser,
        customerName,
        staffName,
        warehouseId,
        warehouseName,
        taxRate,
        taxAmount,
        discount,
        discountAmount,
        shipping,
        grandTotal,
        receivedAmount,
        paidAmount,
        partialAmount,
        dueAmount,
        paymentType,
        note,
        status,
        paymentStatus,
        referenceCode,
        saleItems,
        payments,
        paymentMethods,
        createdAt,
        barcodeUrl,
        isOffline,
        offlineCustomerName,
        staffId,
        attendantName,
        attendantId,
        roomDetails,
        partialPaymentAmount,
        partialPaymentMethod,
        isSynced,
        lastSyncedAt,
        createdLocallyAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_sales';
  @override
  VerificationContext validateIntegrity(Insertable<LocalSale> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('is_return')) {
      context.handle(_isReturnMeta,
          isReturn.isAcceptableOrUnknown(data['is_return']!, _isReturnMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    }
    if (data.containsKey('company_id')) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta));
    }
    if (data.containsKey('customer_name')) {
      context.handle(
          _customerNameMeta,
          customerName.isAcceptableOrUnknown(
              data['customer_name']!, _customerNameMeta));
    }
    if (data.containsKey('staff_name')) {
      context.handle(_staffNameMeta,
          staffName.isAcceptableOrUnknown(data['staff_name']!, _staffNameMeta));
    }
    if (data.containsKey('warehouse_id')) {
      context.handle(
          _warehouseIdMeta,
          warehouseId.isAcceptableOrUnknown(
              data['warehouse_id']!, _warehouseIdMeta));
    }
    if (data.containsKey('warehouse_name')) {
      context.handle(
          _warehouseNameMeta,
          warehouseName.isAcceptableOrUnknown(
              data['warehouse_name']!, _warehouseNameMeta));
    }
    if (data.containsKey('tax_rate')) {
      context.handle(_taxRateMeta,
          taxRate.isAcceptableOrUnknown(data['tax_rate']!, _taxRateMeta));
    }
    if (data.containsKey('tax_amount')) {
      context.handle(_taxAmountMeta,
          taxAmount.isAcceptableOrUnknown(data['tax_amount']!, _taxAmountMeta));
    }
    if (data.containsKey('discount')) {
      context.handle(_discountMeta,
          discount.isAcceptableOrUnknown(data['discount']!, _discountMeta));
    }
    if (data.containsKey('discount_amount')) {
      context.handle(
          _discountAmountMeta,
          discountAmount.isAcceptableOrUnknown(
              data['discount_amount']!, _discountAmountMeta));
    }
    if (data.containsKey('shipping')) {
      context.handle(_shippingMeta,
          shipping.isAcceptableOrUnknown(data['shipping']!, _shippingMeta));
    }
    if (data.containsKey('grand_total')) {
      context.handle(
          _grandTotalMeta,
          grandTotal.isAcceptableOrUnknown(
              data['grand_total']!, _grandTotalMeta));
    }
    if (data.containsKey('received_amount')) {
      context.handle(
          _receivedAmountMeta,
          receivedAmount.isAcceptableOrUnknown(
              data['received_amount']!, _receivedAmountMeta));
    }
    if (data.containsKey('paid_amount')) {
      context.handle(
          _paidAmountMeta,
          paidAmount.isAcceptableOrUnknown(
              data['paid_amount']!, _paidAmountMeta));
    }
    if (data.containsKey('partial_amount')) {
      context.handle(
          _partialAmountMeta,
          partialAmount.isAcceptableOrUnknown(
              data['partial_amount']!, _partialAmountMeta));
    }
    if (data.containsKey('due_amount')) {
      context.handle(_dueAmountMeta,
          dueAmount.isAcceptableOrUnknown(data['due_amount']!, _dueAmountMeta));
    }
    if (data.containsKey('payment_type')) {
      context.handle(
          _paymentTypeMeta,
          paymentType.isAcceptableOrUnknown(
              data['payment_type']!, _paymentTypeMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('payment_status')) {
      context.handle(
          _paymentStatusMeta,
          paymentStatus.isAcceptableOrUnknown(
              data['payment_status']!, _paymentStatusMeta));
    }
    if (data.containsKey('reference_code')) {
      context.handle(
          _referenceCodeMeta,
          referenceCode.isAcceptableOrUnknown(
              data['reference_code']!, _referenceCodeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('barcode_url')) {
      context.handle(
          _barcodeUrlMeta,
          barcodeUrl.isAcceptableOrUnknown(
              data['barcode_url']!, _barcodeUrlMeta));
    }
    if (data.containsKey('is_offline')) {
      context.handle(_isOfflineMeta,
          isOffline.isAcceptableOrUnknown(data['is_offline']!, _isOfflineMeta));
    }
    if (data.containsKey('offline_customer_name')) {
      context.handle(
          _offlineCustomerNameMeta,
          offlineCustomerName.isAcceptableOrUnknown(
              data['offline_customer_name']!, _offlineCustomerNameMeta));
    }
    if (data.containsKey('staff_id')) {
      context.handle(_staffIdMeta,
          staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta));
    }
    if (data.containsKey('attendant_name')) {
      context.handle(
          _attendantNameMeta,
          attendantName.isAcceptableOrUnknown(
              data['attendant_name']!, _attendantNameMeta));
    }
    if (data.containsKey('attendant_id')) {
      context.handle(
          _attendantIdMeta,
          attendantId.isAcceptableOrUnknown(
              data['attendant_id']!, _attendantIdMeta));
    }
    if (data.containsKey('partial_payment_amount')) {
      context.handle(
          _partialPaymentAmountMeta,
          partialPaymentAmount.isAcceptableOrUnknown(
              data['partial_payment_amount']!, _partialPaymentAmountMeta));
    }
    if (data.containsKey('partial_payment_method')) {
      context.handle(
          _partialPaymentMethodMeta,
          partialPaymentMethod.isAcceptableOrUnknown(
              data['partial_payment_method']!, _partialPaymentMethodMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('created_locally_at')) {
      context.handle(
          _createdLocallyAtMeta,
          createdLocallyAt.isAcceptableOrUnknown(
              data['created_locally_at']!, _createdLocallyAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalSale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalSale(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}remote_id']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type']),
      links: $LocalSalesTable.$converterlinks.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}links'])),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date']),
      isReturn: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_return']),
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}customer_id']),
      companyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}company_id']),
      loggedUser: $LocalSalesTable.$converterloggedUser.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logged_user'])),
      customerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_name']),
      staffName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}staff_name']),
      warehouseId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}warehouse_id']),
      warehouseName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}warehouse_name']),
      taxRate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tax_rate']),
      taxAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tax_amount']),
      discount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}discount']),
      discountAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}discount_amount']),
      shipping: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}shipping']),
      grandTotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}grand_total']),
      receivedAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}received_amount']),
      paidAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}paid_amount']),
      partialAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}partial_amount']),
      dueAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}due_amount']),
      paymentType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payment_type']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status']),
      paymentStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payment_status']),
      referenceCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference_code']),
      saleItems: $LocalSalesTable.$convertersaleItems.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sale_items'])),
      payments: $LocalSalesTable.$converterpayments.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payments'])),
      paymentMethods: $LocalSalesTable.$converterpaymentMethods.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}payment_methods'])),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      barcodeUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}barcode_url']),
      isOffline: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_offline'])!,
      offlineCustomerName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}offline_customer_name']),
      staffId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}staff_id']),
      attendantName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}attendant_name']),
      attendantId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attendant_id']),
      roomDetails: $LocalSalesTable.$converterroomDetails.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}room_details'])),
      partialPaymentAmount: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}partial_payment_amount']),
      partialPaymentMethod: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}partial_payment_method']),
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_synced_at']),
      createdLocallyAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}created_locally_at']),
    );
  }

  @override
  $LocalSalesTable createAlias(String alias) {
    return $LocalSalesTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>?, String?> $converterlinks =
      NullAwareTypeConverter.wrap(const MapStringDynamicConverter());
  static TypeConverter<SaleLoggedUser?, String?> $converterloggedUser =
      NullAwareTypeConverter.wrap(const LoggedUserConverter());
  static TypeConverter<List<SaleItem>?, String?> $convertersaleItems =
      NullAwareTypeConverter.wrap(const SaleItemListConverter());
  static TypeConverter<List<SalePayment>?, String?> $converterpayments =
      NullAwareTypeConverter.wrap(const PaymentListConverter());
  static TypeConverter<List<String>?, String?> $converterpaymentMethods =
      NullAwareTypeConverter.wrap(const PaymentMethodsConverter());
  static TypeConverter<Map<String, dynamic>?, String?> $converterroomDetails =
      NullAwareTypeConverter.wrap(const MapStringDynamicConverter());
}

class LocalSale extends DataClass implements Insertable<LocalSale> {
  final int id;
  final int? remoteId;
  final String? type;
  final Map<String, dynamic>? links;
  final DateTime? date;
  final int? isReturn;
  final int? customerId;
  final int? companyId;
  final SaleLoggedUser? loggedUser;
  final String? customerName;
  final String? staffName;
  final int? warehouseId;
  final String? warehouseName;
  final double? taxRate;
  final double? taxAmount;
  final double? discount;
  final double? discountAmount;
  final double? shipping;
  final double? grandTotal;
  final double? receivedAmount;
  final double? paidAmount;
  final double? partialAmount;
  final double? dueAmount;
  final int? paymentType;
  final String? note;
  final int? status;
  final int? paymentStatus;
  final String? referenceCode;
  final List<SaleItem>? saleItems;
  final List<SalePayment>? payments;
  final List<String>? paymentMethods;
  final DateTime? createdAt;
  final String? barcodeUrl;
  final bool isOffline;
  final String? offlineCustomerName;
  final int? staffId;
  final String? attendantName;
  final int? attendantId;
  final Map<String, dynamic>? roomDetails;
  final double? partialPaymentAmount;
  final String? partialPaymentMethod;
  final bool isSynced;
  final DateTime? lastSyncedAt;
  final DateTime? createdLocallyAt;
  const LocalSale(
      {required this.id,
      this.remoteId,
      this.type,
      this.links,
      this.date,
      this.isReturn,
      this.customerId,
      this.companyId,
      this.loggedUser,
      this.customerName,
      this.staffName,
      this.warehouseId,
      this.warehouseName,
      this.taxRate,
      this.taxAmount,
      this.discount,
      this.discountAmount,
      this.shipping,
      this.grandTotal,
      this.receivedAmount,
      this.paidAmount,
      this.partialAmount,
      this.dueAmount,
      this.paymentType,
      this.note,
      this.status,
      this.paymentStatus,
      this.referenceCode,
      this.saleItems,
      this.payments,
      this.paymentMethods,
      this.createdAt,
      this.barcodeUrl,
      required this.isOffline,
      this.offlineCustomerName,
      this.staffId,
      this.attendantName,
      this.attendantId,
      this.roomDetails,
      this.partialPaymentAmount,
      this.partialPaymentMethod,
      required this.isSynced,
      this.lastSyncedAt,
      this.createdLocallyAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<int>(remoteId);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || links != null) {
      map['links'] =
          Variable<String>($LocalSalesTable.$converterlinks.toSql(links));
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    if (!nullToAbsent || isReturn != null) {
      map['is_return'] = Variable<int>(isReturn);
    }
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    if (!nullToAbsent || companyId != null) {
      map['company_id'] = Variable<int>(companyId);
    }
    if (!nullToAbsent || loggedUser != null) {
      map['logged_user'] = Variable<String>(
          $LocalSalesTable.$converterloggedUser.toSql(loggedUser));
    }
    if (!nullToAbsent || customerName != null) {
      map['customer_name'] = Variable<String>(customerName);
    }
    if (!nullToAbsent || staffName != null) {
      map['staff_name'] = Variable<String>(staffName);
    }
    if (!nullToAbsent || warehouseId != null) {
      map['warehouse_id'] = Variable<int>(warehouseId);
    }
    if (!nullToAbsent || warehouseName != null) {
      map['warehouse_name'] = Variable<String>(warehouseName);
    }
    if (!nullToAbsent || taxRate != null) {
      map['tax_rate'] = Variable<double>(taxRate);
    }
    if (!nullToAbsent || taxAmount != null) {
      map['tax_amount'] = Variable<double>(taxAmount);
    }
    if (!nullToAbsent || discount != null) {
      map['discount'] = Variable<double>(discount);
    }
    if (!nullToAbsent || discountAmount != null) {
      map['discount_amount'] = Variable<double>(discountAmount);
    }
    if (!nullToAbsent || shipping != null) {
      map['shipping'] = Variable<double>(shipping);
    }
    if (!nullToAbsent || grandTotal != null) {
      map['grand_total'] = Variable<double>(grandTotal);
    }
    if (!nullToAbsent || receivedAmount != null) {
      map['received_amount'] = Variable<double>(receivedAmount);
    }
    if (!nullToAbsent || paidAmount != null) {
      map['paid_amount'] = Variable<double>(paidAmount);
    }
    if (!nullToAbsent || partialAmount != null) {
      map['partial_amount'] = Variable<double>(partialAmount);
    }
    if (!nullToAbsent || dueAmount != null) {
      map['due_amount'] = Variable<double>(dueAmount);
    }
    if (!nullToAbsent || paymentType != null) {
      map['payment_type'] = Variable<int>(paymentType);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<int>(status);
    }
    if (!nullToAbsent || paymentStatus != null) {
      map['payment_status'] = Variable<int>(paymentStatus);
    }
    if (!nullToAbsent || referenceCode != null) {
      map['reference_code'] = Variable<String>(referenceCode);
    }
    if (!nullToAbsent || saleItems != null) {
      map['sale_items'] = Variable<String>(
          $LocalSalesTable.$convertersaleItems.toSql(saleItems));
    }
    if (!nullToAbsent || payments != null) {
      map['payments'] =
          Variable<String>($LocalSalesTable.$converterpayments.toSql(payments));
    }
    if (!nullToAbsent || paymentMethods != null) {
      map['payment_methods'] = Variable<String>(
          $LocalSalesTable.$converterpaymentMethods.toSql(paymentMethods));
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || barcodeUrl != null) {
      map['barcode_url'] = Variable<String>(barcodeUrl);
    }
    map['is_offline'] = Variable<bool>(isOffline);
    if (!nullToAbsent || offlineCustomerName != null) {
      map['offline_customer_name'] = Variable<String>(offlineCustomerName);
    }
    if (!nullToAbsent || staffId != null) {
      map['staff_id'] = Variable<int>(staffId);
    }
    if (!nullToAbsent || attendantName != null) {
      map['attendant_name'] = Variable<String>(attendantName);
    }
    if (!nullToAbsent || attendantId != null) {
      map['attendant_id'] = Variable<int>(attendantId);
    }
    if (!nullToAbsent || roomDetails != null) {
      map['room_details'] = Variable<String>(
          $LocalSalesTable.$converterroomDetails.toSql(roomDetails));
    }
    if (!nullToAbsent || partialPaymentAmount != null) {
      map['partial_payment_amount'] = Variable<double>(partialPaymentAmount);
    }
    if (!nullToAbsent || partialPaymentMethod != null) {
      map['partial_payment_method'] = Variable<String>(partialPaymentMethod);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    if (!nullToAbsent || createdLocallyAt != null) {
      map['created_locally_at'] = Variable<DateTime>(createdLocallyAt);
    }
    return map;
  }

  LocalSalesCompanion toCompanion(bool nullToAbsent) {
    return LocalSalesCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      links:
          links == null && nullToAbsent ? const Value.absent() : Value(links),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      isReturn: isReturn == null && nullToAbsent
          ? const Value.absent()
          : Value(isReturn),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      companyId: companyId == null && nullToAbsent
          ? const Value.absent()
          : Value(companyId),
      loggedUser: loggedUser == null && nullToAbsent
          ? const Value.absent()
          : Value(loggedUser),
      customerName: customerName == null && nullToAbsent
          ? const Value.absent()
          : Value(customerName),
      staffName: staffName == null && nullToAbsent
          ? const Value.absent()
          : Value(staffName),
      warehouseId: warehouseId == null && nullToAbsent
          ? const Value.absent()
          : Value(warehouseId),
      warehouseName: warehouseName == null && nullToAbsent
          ? const Value.absent()
          : Value(warehouseName),
      taxRate: taxRate == null && nullToAbsent
          ? const Value.absent()
          : Value(taxRate),
      taxAmount: taxAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(taxAmount),
      discount: discount == null && nullToAbsent
          ? const Value.absent()
          : Value(discount),
      discountAmount: discountAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(discountAmount),
      shipping: shipping == null && nullToAbsent
          ? const Value.absent()
          : Value(shipping),
      grandTotal: grandTotal == null && nullToAbsent
          ? const Value.absent()
          : Value(grandTotal),
      receivedAmount: receivedAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(receivedAmount),
      paidAmount: paidAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(paidAmount),
      partialAmount: partialAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(partialAmount),
      dueAmount: dueAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(dueAmount),
      paymentType: paymentType == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentType),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      paymentStatus: paymentStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentStatus),
      referenceCode: referenceCode == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceCode),
      saleItems: saleItems == null && nullToAbsent
          ? const Value.absent()
          : Value(saleItems),
      payments: payments == null && nullToAbsent
          ? const Value.absent()
          : Value(payments),
      paymentMethods: paymentMethods == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMethods),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      barcodeUrl: barcodeUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(barcodeUrl),
      isOffline: Value(isOffline),
      offlineCustomerName: offlineCustomerName == null && nullToAbsent
          ? const Value.absent()
          : Value(offlineCustomerName),
      staffId: staffId == null && nullToAbsent
          ? const Value.absent()
          : Value(staffId),
      attendantName: attendantName == null && nullToAbsent
          ? const Value.absent()
          : Value(attendantName),
      attendantId: attendantId == null && nullToAbsent
          ? const Value.absent()
          : Value(attendantId),
      roomDetails: roomDetails == null && nullToAbsent
          ? const Value.absent()
          : Value(roomDetails),
      partialPaymentAmount: partialPaymentAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(partialPaymentAmount),
      partialPaymentMethod: partialPaymentMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(partialPaymentMethod),
      isSynced: Value(isSynced),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      createdLocallyAt: createdLocallyAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdLocallyAt),
    );
  }

  factory LocalSale.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSale(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<int?>(json['remoteId']),
      type: serializer.fromJson<String?>(json['type']),
      links: serializer.fromJson<Map<String, dynamic>?>(json['links']),
      date: serializer.fromJson<DateTime?>(json['date']),
      isReturn: serializer.fromJson<int?>(json['isReturn']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      companyId: serializer.fromJson<int?>(json['companyId']),
      loggedUser: serializer.fromJson<SaleLoggedUser?>(json['loggedUser']),
      customerName: serializer.fromJson<String?>(json['customerName']),
      staffName: serializer.fromJson<String?>(json['staffName']),
      warehouseId: serializer.fromJson<int?>(json['warehouseId']),
      warehouseName: serializer.fromJson<String?>(json['warehouseName']),
      taxRate: serializer.fromJson<double?>(json['taxRate']),
      taxAmount: serializer.fromJson<double?>(json['taxAmount']),
      discount: serializer.fromJson<double?>(json['discount']),
      discountAmount: serializer.fromJson<double?>(json['discountAmount']),
      shipping: serializer.fromJson<double?>(json['shipping']),
      grandTotal: serializer.fromJson<double?>(json['grandTotal']),
      receivedAmount: serializer.fromJson<double?>(json['receivedAmount']),
      paidAmount: serializer.fromJson<double?>(json['paidAmount']),
      partialAmount: serializer.fromJson<double?>(json['partialAmount']),
      dueAmount: serializer.fromJson<double?>(json['dueAmount']),
      paymentType: serializer.fromJson<int?>(json['paymentType']),
      note: serializer.fromJson<String?>(json['note']),
      status: serializer.fromJson<int?>(json['status']),
      paymentStatus: serializer.fromJson<int?>(json['paymentStatus']),
      referenceCode: serializer.fromJson<String?>(json['referenceCode']),
      saleItems: serializer.fromJson<List<SaleItem>?>(json['saleItems']),
      payments: serializer.fromJson<List<SalePayment>?>(json['payments']),
      paymentMethods:
          serializer.fromJson<List<String>?>(json['paymentMethods']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      barcodeUrl: serializer.fromJson<String?>(json['barcodeUrl']),
      isOffline: serializer.fromJson<bool>(json['isOffline']),
      offlineCustomerName:
          serializer.fromJson<String?>(json['offlineCustomerName']),
      staffId: serializer.fromJson<int?>(json['staffId']),
      attendantName: serializer.fromJson<String?>(json['attendantName']),
      attendantId: serializer.fromJson<int?>(json['attendantId']),
      roomDetails:
          serializer.fromJson<Map<String, dynamic>?>(json['roomDetails']),
      partialPaymentAmount:
          serializer.fromJson<double?>(json['partialPaymentAmount']),
      partialPaymentMethod:
          serializer.fromJson<String?>(json['partialPaymentMethod']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
      createdLocallyAt:
          serializer.fromJson<DateTime?>(json['createdLocallyAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<int?>(remoteId),
      'type': serializer.toJson<String?>(type),
      'links': serializer.toJson<Map<String, dynamic>?>(links),
      'date': serializer.toJson<DateTime?>(date),
      'isReturn': serializer.toJson<int?>(isReturn),
      'customerId': serializer.toJson<int?>(customerId),
      'companyId': serializer.toJson<int?>(companyId),
      'loggedUser': serializer.toJson<SaleLoggedUser?>(loggedUser),
      'customerName': serializer.toJson<String?>(customerName),
      'staffName': serializer.toJson<String?>(staffName),
      'warehouseId': serializer.toJson<int?>(warehouseId),
      'warehouseName': serializer.toJson<String?>(warehouseName),
      'taxRate': serializer.toJson<double?>(taxRate),
      'taxAmount': serializer.toJson<double?>(taxAmount),
      'discount': serializer.toJson<double?>(discount),
      'discountAmount': serializer.toJson<double?>(discountAmount),
      'shipping': serializer.toJson<double?>(shipping),
      'grandTotal': serializer.toJson<double?>(grandTotal),
      'receivedAmount': serializer.toJson<double?>(receivedAmount),
      'paidAmount': serializer.toJson<double?>(paidAmount),
      'partialAmount': serializer.toJson<double?>(partialAmount),
      'dueAmount': serializer.toJson<double?>(dueAmount),
      'paymentType': serializer.toJson<int?>(paymentType),
      'note': serializer.toJson<String?>(note),
      'status': serializer.toJson<int?>(status),
      'paymentStatus': serializer.toJson<int?>(paymentStatus),
      'referenceCode': serializer.toJson<String?>(referenceCode),
      'saleItems': serializer.toJson<List<SaleItem>?>(saleItems),
      'payments': serializer.toJson<List<SalePayment>?>(payments),
      'paymentMethods': serializer.toJson<List<String>?>(paymentMethods),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'barcodeUrl': serializer.toJson<String?>(barcodeUrl),
      'isOffline': serializer.toJson<bool>(isOffline),
      'offlineCustomerName': serializer.toJson<String?>(offlineCustomerName),
      'staffId': serializer.toJson<int?>(staffId),
      'attendantName': serializer.toJson<String?>(attendantName),
      'attendantId': serializer.toJson<int?>(attendantId),
      'roomDetails': serializer.toJson<Map<String, dynamic>?>(roomDetails),
      'partialPaymentAmount': serializer.toJson<double?>(partialPaymentAmount),
      'partialPaymentMethod': serializer.toJson<String?>(partialPaymentMethod),
      'isSynced': serializer.toJson<bool>(isSynced),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
      'createdLocallyAt': serializer.toJson<DateTime?>(createdLocallyAt),
    };
  }

  LocalSale copyWith(
          {int? id,
          Value<int?> remoteId = const Value.absent(),
          Value<String?> type = const Value.absent(),
          Value<Map<String, dynamic>?> links = const Value.absent(),
          Value<DateTime?> date = const Value.absent(),
          Value<int?> isReturn = const Value.absent(),
          Value<int?> customerId = const Value.absent(),
          Value<int?> companyId = const Value.absent(),
          Value<SaleLoggedUser?> loggedUser = const Value.absent(),
          Value<String?> customerName = const Value.absent(),
          Value<String?> staffName = const Value.absent(),
          Value<int?> warehouseId = const Value.absent(),
          Value<String?> warehouseName = const Value.absent(),
          Value<double?> taxRate = const Value.absent(),
          Value<double?> taxAmount = const Value.absent(),
          Value<double?> discount = const Value.absent(),
          Value<double?> discountAmount = const Value.absent(),
          Value<double?> shipping = const Value.absent(),
          Value<double?> grandTotal = const Value.absent(),
          Value<double?> receivedAmount = const Value.absent(),
          Value<double?> paidAmount = const Value.absent(),
          Value<double?> partialAmount = const Value.absent(),
          Value<double?> dueAmount = const Value.absent(),
          Value<int?> paymentType = const Value.absent(),
          Value<String?> note = const Value.absent(),
          Value<int?> status = const Value.absent(),
          Value<int?> paymentStatus = const Value.absent(),
          Value<String?> referenceCode = const Value.absent(),
          Value<List<SaleItem>?> saleItems = const Value.absent(),
          Value<List<SalePayment>?> payments = const Value.absent(),
          Value<List<String>?> paymentMethods = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<String?> barcodeUrl = const Value.absent(),
          bool? isOffline,
          Value<String?> offlineCustomerName = const Value.absent(),
          Value<int?> staffId = const Value.absent(),
          Value<String?> attendantName = const Value.absent(),
          Value<int?> attendantId = const Value.absent(),
          Value<Map<String, dynamic>?> roomDetails = const Value.absent(),
          Value<double?> partialPaymentAmount = const Value.absent(),
          Value<String?> partialPaymentMethod = const Value.absent(),
          bool? isSynced,
          Value<DateTime?> lastSyncedAt = const Value.absent(),
          Value<DateTime?> createdLocallyAt = const Value.absent()}) =>
      LocalSale(
        id: id ?? this.id,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        type: type.present ? type.value : this.type,
        links: links.present ? links.value : this.links,
        date: date.present ? date.value : this.date,
        isReturn: isReturn.present ? isReturn.value : this.isReturn,
        customerId: customerId.present ? customerId.value : this.customerId,
        companyId: companyId.present ? companyId.value : this.companyId,
        loggedUser: loggedUser.present ? loggedUser.value : this.loggedUser,
        customerName:
            customerName.present ? customerName.value : this.customerName,
        staffName: staffName.present ? staffName.value : this.staffName,
        warehouseId: warehouseId.present ? warehouseId.value : this.warehouseId,
        warehouseName:
            warehouseName.present ? warehouseName.value : this.warehouseName,
        taxRate: taxRate.present ? taxRate.value : this.taxRate,
        taxAmount: taxAmount.present ? taxAmount.value : this.taxAmount,
        discount: discount.present ? discount.value : this.discount,
        discountAmount:
            discountAmount.present ? discountAmount.value : this.discountAmount,
        shipping: shipping.present ? shipping.value : this.shipping,
        grandTotal: grandTotal.present ? grandTotal.value : this.grandTotal,
        receivedAmount:
            receivedAmount.present ? receivedAmount.value : this.receivedAmount,
        paidAmount: paidAmount.present ? paidAmount.value : this.paidAmount,
        partialAmount:
            partialAmount.present ? partialAmount.value : this.partialAmount,
        dueAmount: dueAmount.present ? dueAmount.value : this.dueAmount,
        paymentType: paymentType.present ? paymentType.value : this.paymentType,
        note: note.present ? note.value : this.note,
        status: status.present ? status.value : this.status,
        paymentStatus:
            paymentStatus.present ? paymentStatus.value : this.paymentStatus,
        referenceCode:
            referenceCode.present ? referenceCode.value : this.referenceCode,
        saleItems: saleItems.present ? saleItems.value : this.saleItems,
        payments: payments.present ? payments.value : this.payments,
        paymentMethods:
            paymentMethods.present ? paymentMethods.value : this.paymentMethods,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        barcodeUrl: barcodeUrl.present ? barcodeUrl.value : this.barcodeUrl,
        isOffline: isOffline ?? this.isOffline,
        offlineCustomerName: offlineCustomerName.present
            ? offlineCustomerName.value
            : this.offlineCustomerName,
        staffId: staffId.present ? staffId.value : this.staffId,
        attendantName:
            attendantName.present ? attendantName.value : this.attendantName,
        attendantId: attendantId.present ? attendantId.value : this.attendantId,
        roomDetails: roomDetails.present ? roomDetails.value : this.roomDetails,
        partialPaymentAmount: partialPaymentAmount.present
            ? partialPaymentAmount.value
            : this.partialPaymentAmount,
        partialPaymentMethod: partialPaymentMethod.present
            ? partialPaymentMethod.value
            : this.partialPaymentMethod,
        isSynced: isSynced ?? this.isSynced,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        createdLocallyAt: createdLocallyAt.present
            ? createdLocallyAt.value
            : this.createdLocallyAt,
      );
  LocalSale copyWithCompanion(LocalSalesCompanion data) {
    return LocalSale(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      type: data.type.present ? data.type.value : this.type,
      links: data.links.present ? data.links.value : this.links,
      date: data.date.present ? data.date.value : this.date,
      isReturn: data.isReturn.present ? data.isReturn.value : this.isReturn,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      loggedUser:
          data.loggedUser.present ? data.loggedUser.value : this.loggedUser,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      staffName: data.staffName.present ? data.staffName.value : this.staffName,
      warehouseId:
          data.warehouseId.present ? data.warehouseId.value : this.warehouseId,
      warehouseName: data.warehouseName.present
          ? data.warehouseName.value
          : this.warehouseName,
      taxRate: data.taxRate.present ? data.taxRate.value : this.taxRate,
      taxAmount: data.taxAmount.present ? data.taxAmount.value : this.taxAmount,
      discount: data.discount.present ? data.discount.value : this.discount,
      discountAmount: data.discountAmount.present
          ? data.discountAmount.value
          : this.discountAmount,
      shipping: data.shipping.present ? data.shipping.value : this.shipping,
      grandTotal:
          data.grandTotal.present ? data.grandTotal.value : this.grandTotal,
      receivedAmount: data.receivedAmount.present
          ? data.receivedAmount.value
          : this.receivedAmount,
      paidAmount:
          data.paidAmount.present ? data.paidAmount.value : this.paidAmount,
      partialAmount: data.partialAmount.present
          ? data.partialAmount.value
          : this.partialAmount,
      dueAmount: data.dueAmount.present ? data.dueAmount.value : this.dueAmount,
      paymentType:
          data.paymentType.present ? data.paymentType.value : this.paymentType,
      note: data.note.present ? data.note.value : this.note,
      status: data.status.present ? data.status.value : this.status,
      paymentStatus: data.paymentStatus.present
          ? data.paymentStatus.value
          : this.paymentStatus,
      referenceCode: data.referenceCode.present
          ? data.referenceCode.value
          : this.referenceCode,
      saleItems: data.saleItems.present ? data.saleItems.value : this.saleItems,
      payments: data.payments.present ? data.payments.value : this.payments,
      paymentMethods: data.paymentMethods.present
          ? data.paymentMethods.value
          : this.paymentMethods,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      barcodeUrl:
          data.barcodeUrl.present ? data.barcodeUrl.value : this.barcodeUrl,
      isOffline: data.isOffline.present ? data.isOffline.value : this.isOffline,
      offlineCustomerName: data.offlineCustomerName.present
          ? data.offlineCustomerName.value
          : this.offlineCustomerName,
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      attendantName: data.attendantName.present
          ? data.attendantName.value
          : this.attendantName,
      attendantId:
          data.attendantId.present ? data.attendantId.value : this.attendantId,
      roomDetails:
          data.roomDetails.present ? data.roomDetails.value : this.roomDetails,
      partialPaymentAmount: data.partialPaymentAmount.present
          ? data.partialPaymentAmount.value
          : this.partialPaymentAmount,
      partialPaymentMethod: data.partialPaymentMethod.present
          ? data.partialPaymentMethod.value
          : this.partialPaymentMethod,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      createdLocallyAt: data.createdLocallyAt.present
          ? data.createdLocallyAt.value
          : this.createdLocallyAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalSale(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('type: $type, ')
          ..write('links: $links, ')
          ..write('date: $date, ')
          ..write('isReturn: $isReturn, ')
          ..write('customerId: $customerId, ')
          ..write('companyId: $companyId, ')
          ..write('loggedUser: $loggedUser, ')
          ..write('customerName: $customerName, ')
          ..write('staffName: $staffName, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('warehouseName: $warehouseName, ')
          ..write('taxRate: $taxRate, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('discount: $discount, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('shipping: $shipping, ')
          ..write('grandTotal: $grandTotal, ')
          ..write('receivedAmount: $receivedAmount, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('partialAmount: $partialAmount, ')
          ..write('dueAmount: $dueAmount, ')
          ..write('paymentType: $paymentType, ')
          ..write('note: $note, ')
          ..write('status: $status, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('referenceCode: $referenceCode, ')
          ..write('saleItems: $saleItems, ')
          ..write('payments: $payments, ')
          ..write('paymentMethods: $paymentMethods, ')
          ..write('createdAt: $createdAt, ')
          ..write('barcodeUrl: $barcodeUrl, ')
          ..write('isOffline: $isOffline, ')
          ..write('offlineCustomerName: $offlineCustomerName, ')
          ..write('staffId: $staffId, ')
          ..write('attendantName: $attendantName, ')
          ..write('attendantId: $attendantId, ')
          ..write('roomDetails: $roomDetails, ')
          ..write('partialPaymentAmount: $partialPaymentAmount, ')
          ..write('partialPaymentMethod: $partialPaymentMethod, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('createdLocallyAt: $createdLocallyAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        remoteId,
        type,
        links,
        date,
        isReturn,
        customerId,
        companyId,
        loggedUser,
        customerName,
        staffName,
        warehouseId,
        warehouseName,
        taxRate,
        taxAmount,
        discount,
        discountAmount,
        shipping,
        grandTotal,
        receivedAmount,
        paidAmount,
        partialAmount,
        dueAmount,
        paymentType,
        note,
        status,
        paymentStatus,
        referenceCode,
        saleItems,
        payments,
        paymentMethods,
        createdAt,
        barcodeUrl,
        isOffline,
        offlineCustomerName,
        staffId,
        attendantName,
        attendantId,
        roomDetails,
        partialPaymentAmount,
        partialPaymentMethod,
        isSynced,
        lastSyncedAt,
        createdLocallyAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSale &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.type == this.type &&
          other.links == this.links &&
          other.date == this.date &&
          other.isReturn == this.isReturn &&
          other.customerId == this.customerId &&
          other.companyId == this.companyId &&
          other.loggedUser == this.loggedUser &&
          other.customerName == this.customerName &&
          other.staffName == this.staffName &&
          other.warehouseId == this.warehouseId &&
          other.warehouseName == this.warehouseName &&
          other.taxRate == this.taxRate &&
          other.taxAmount == this.taxAmount &&
          other.discount == this.discount &&
          other.discountAmount == this.discountAmount &&
          other.shipping == this.shipping &&
          other.grandTotal == this.grandTotal &&
          other.receivedAmount == this.receivedAmount &&
          other.paidAmount == this.paidAmount &&
          other.partialAmount == this.partialAmount &&
          other.dueAmount == this.dueAmount &&
          other.paymentType == this.paymentType &&
          other.note == this.note &&
          other.status == this.status &&
          other.paymentStatus == this.paymentStatus &&
          other.referenceCode == this.referenceCode &&
          other.saleItems == this.saleItems &&
          other.payments == this.payments &&
          other.paymentMethods == this.paymentMethods &&
          other.createdAt == this.createdAt &&
          other.barcodeUrl == this.barcodeUrl &&
          other.isOffline == this.isOffline &&
          other.offlineCustomerName == this.offlineCustomerName &&
          other.staffId == this.staffId &&
          other.attendantName == this.attendantName &&
          other.attendantId == this.attendantId &&
          other.roomDetails == this.roomDetails &&
          other.partialPaymentAmount == this.partialPaymentAmount &&
          other.partialPaymentMethod == this.partialPaymentMethod &&
          other.isSynced == this.isSynced &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.createdLocallyAt == this.createdLocallyAt);
}

class LocalSalesCompanion extends UpdateCompanion<LocalSale> {
  final Value<int> id;
  final Value<int?> remoteId;
  final Value<String?> type;
  final Value<Map<String, dynamic>?> links;
  final Value<DateTime?> date;
  final Value<int?> isReturn;
  final Value<int?> customerId;
  final Value<int?> companyId;
  final Value<SaleLoggedUser?> loggedUser;
  final Value<String?> customerName;
  final Value<String?> staffName;
  final Value<int?> warehouseId;
  final Value<String?> warehouseName;
  final Value<double?> taxRate;
  final Value<double?> taxAmount;
  final Value<double?> discount;
  final Value<double?> discountAmount;
  final Value<double?> shipping;
  final Value<double?> grandTotal;
  final Value<double?> receivedAmount;
  final Value<double?> paidAmount;
  final Value<double?> partialAmount;
  final Value<double?> dueAmount;
  final Value<int?> paymentType;
  final Value<String?> note;
  final Value<int?> status;
  final Value<int?> paymentStatus;
  final Value<String?> referenceCode;
  final Value<List<SaleItem>?> saleItems;
  final Value<List<SalePayment>?> payments;
  final Value<List<String>?> paymentMethods;
  final Value<DateTime?> createdAt;
  final Value<String?> barcodeUrl;
  final Value<bool> isOffline;
  final Value<String?> offlineCustomerName;
  final Value<int?> staffId;
  final Value<String?> attendantName;
  final Value<int?> attendantId;
  final Value<Map<String, dynamic>?> roomDetails;
  final Value<double?> partialPaymentAmount;
  final Value<String?> partialPaymentMethod;
  final Value<bool> isSynced;
  final Value<DateTime?> lastSyncedAt;
  final Value<DateTime?> createdLocallyAt;
  const LocalSalesCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.type = const Value.absent(),
    this.links = const Value.absent(),
    this.date = const Value.absent(),
    this.isReturn = const Value.absent(),
    this.customerId = const Value.absent(),
    this.companyId = const Value.absent(),
    this.loggedUser = const Value.absent(),
    this.customerName = const Value.absent(),
    this.staffName = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.warehouseName = const Value.absent(),
    this.taxRate = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.discount = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.shipping = const Value.absent(),
    this.grandTotal = const Value.absent(),
    this.receivedAmount = const Value.absent(),
    this.paidAmount = const Value.absent(),
    this.partialAmount = const Value.absent(),
    this.dueAmount = const Value.absent(),
    this.paymentType = const Value.absent(),
    this.note = const Value.absent(),
    this.status = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.referenceCode = const Value.absent(),
    this.saleItems = const Value.absent(),
    this.payments = const Value.absent(),
    this.paymentMethods = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.barcodeUrl = const Value.absent(),
    this.isOffline = const Value.absent(),
    this.offlineCustomerName = const Value.absent(),
    this.staffId = const Value.absent(),
    this.attendantName = const Value.absent(),
    this.attendantId = const Value.absent(),
    this.roomDetails = const Value.absent(),
    this.partialPaymentAmount = const Value.absent(),
    this.partialPaymentMethod = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.createdLocallyAt = const Value.absent(),
  });
  LocalSalesCompanion.insert({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.type = const Value.absent(),
    this.links = const Value.absent(),
    this.date = const Value.absent(),
    this.isReturn = const Value.absent(),
    this.customerId = const Value.absent(),
    this.companyId = const Value.absent(),
    this.loggedUser = const Value.absent(),
    this.customerName = const Value.absent(),
    this.staffName = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.warehouseName = const Value.absent(),
    this.taxRate = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.discount = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.shipping = const Value.absent(),
    this.grandTotal = const Value.absent(),
    this.receivedAmount = const Value.absent(),
    this.paidAmount = const Value.absent(),
    this.partialAmount = const Value.absent(),
    this.dueAmount = const Value.absent(),
    this.paymentType = const Value.absent(),
    this.note = const Value.absent(),
    this.status = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.referenceCode = const Value.absent(),
    this.saleItems = const Value.absent(),
    this.payments = const Value.absent(),
    this.paymentMethods = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.barcodeUrl = const Value.absent(),
    this.isOffline = const Value.absent(),
    this.offlineCustomerName = const Value.absent(),
    this.staffId = const Value.absent(),
    this.attendantName = const Value.absent(),
    this.attendantId = const Value.absent(),
    this.roomDetails = const Value.absent(),
    this.partialPaymentAmount = const Value.absent(),
    this.partialPaymentMethod = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.createdLocallyAt = const Value.absent(),
  });
  static Insertable<LocalSale> custom({
    Expression<int>? id,
    Expression<int>? remoteId,
    Expression<String>? type,
    Expression<String>? links,
    Expression<DateTime>? date,
    Expression<int>? isReturn,
    Expression<int>? customerId,
    Expression<int>? companyId,
    Expression<String>? loggedUser,
    Expression<String>? customerName,
    Expression<String>? staffName,
    Expression<int>? warehouseId,
    Expression<String>? warehouseName,
    Expression<double>? taxRate,
    Expression<double>? taxAmount,
    Expression<double>? discount,
    Expression<double>? discountAmount,
    Expression<double>? shipping,
    Expression<double>? grandTotal,
    Expression<double>? receivedAmount,
    Expression<double>? paidAmount,
    Expression<double>? partialAmount,
    Expression<double>? dueAmount,
    Expression<int>? paymentType,
    Expression<String>? note,
    Expression<int>? status,
    Expression<int>? paymentStatus,
    Expression<String>? referenceCode,
    Expression<String>? saleItems,
    Expression<String>? payments,
    Expression<String>? paymentMethods,
    Expression<DateTime>? createdAt,
    Expression<String>? barcodeUrl,
    Expression<bool>? isOffline,
    Expression<String>? offlineCustomerName,
    Expression<int>? staffId,
    Expression<String>? attendantName,
    Expression<int>? attendantId,
    Expression<String>? roomDetails,
    Expression<double>? partialPaymentAmount,
    Expression<String>? partialPaymentMethod,
    Expression<bool>? isSynced,
    Expression<DateTime>? lastSyncedAt,
    Expression<DateTime>? createdLocallyAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (type != null) 'type': type,
      if (links != null) 'links': links,
      if (date != null) 'date': date,
      if (isReturn != null) 'is_return': isReturn,
      if (customerId != null) 'customer_id': customerId,
      if (companyId != null) 'company_id': companyId,
      if (loggedUser != null) 'logged_user': loggedUser,
      if (customerName != null) 'customer_name': customerName,
      if (staffName != null) 'staff_name': staffName,
      if (warehouseId != null) 'warehouse_id': warehouseId,
      if (warehouseName != null) 'warehouse_name': warehouseName,
      if (taxRate != null) 'tax_rate': taxRate,
      if (taxAmount != null) 'tax_amount': taxAmount,
      if (discount != null) 'discount': discount,
      if (discountAmount != null) 'discount_amount': discountAmount,
      if (shipping != null) 'shipping': shipping,
      if (grandTotal != null) 'grand_total': grandTotal,
      if (receivedAmount != null) 'received_amount': receivedAmount,
      if (paidAmount != null) 'paid_amount': paidAmount,
      if (partialAmount != null) 'partial_amount': partialAmount,
      if (dueAmount != null) 'due_amount': dueAmount,
      if (paymentType != null) 'payment_type': paymentType,
      if (note != null) 'note': note,
      if (status != null) 'status': status,
      if (paymentStatus != null) 'payment_status': paymentStatus,
      if (referenceCode != null) 'reference_code': referenceCode,
      if (saleItems != null) 'sale_items': saleItems,
      if (payments != null) 'payments': payments,
      if (paymentMethods != null) 'payment_methods': paymentMethods,
      if (createdAt != null) 'created_at': createdAt,
      if (barcodeUrl != null) 'barcode_url': barcodeUrl,
      if (isOffline != null) 'is_offline': isOffline,
      if (offlineCustomerName != null)
        'offline_customer_name': offlineCustomerName,
      if (staffId != null) 'staff_id': staffId,
      if (attendantName != null) 'attendant_name': attendantName,
      if (attendantId != null) 'attendant_id': attendantId,
      if (roomDetails != null) 'room_details': roomDetails,
      if (partialPaymentAmount != null)
        'partial_payment_amount': partialPaymentAmount,
      if (partialPaymentMethod != null)
        'partial_payment_method': partialPaymentMethod,
      if (isSynced != null) 'is_synced': isSynced,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (createdLocallyAt != null) 'created_locally_at': createdLocallyAt,
    });
  }

  LocalSalesCompanion copyWith(
      {Value<int>? id,
      Value<int?>? remoteId,
      Value<String?>? type,
      Value<Map<String, dynamic>?>? links,
      Value<DateTime?>? date,
      Value<int?>? isReturn,
      Value<int?>? customerId,
      Value<int?>? companyId,
      Value<SaleLoggedUser?>? loggedUser,
      Value<String?>? customerName,
      Value<String?>? staffName,
      Value<int?>? warehouseId,
      Value<String?>? warehouseName,
      Value<double?>? taxRate,
      Value<double?>? taxAmount,
      Value<double?>? discount,
      Value<double?>? discountAmount,
      Value<double?>? shipping,
      Value<double?>? grandTotal,
      Value<double?>? receivedAmount,
      Value<double?>? paidAmount,
      Value<double?>? partialAmount,
      Value<double?>? dueAmount,
      Value<int?>? paymentType,
      Value<String?>? note,
      Value<int?>? status,
      Value<int?>? paymentStatus,
      Value<String?>? referenceCode,
      Value<List<SaleItem>?>? saleItems,
      Value<List<SalePayment>?>? payments,
      Value<List<String>?>? paymentMethods,
      Value<DateTime?>? createdAt,
      Value<String?>? barcodeUrl,
      Value<bool>? isOffline,
      Value<String?>? offlineCustomerName,
      Value<int?>? staffId,
      Value<String?>? attendantName,
      Value<int?>? attendantId,
      Value<Map<String, dynamic>?>? roomDetails,
      Value<double?>? partialPaymentAmount,
      Value<String?>? partialPaymentMethod,
      Value<bool>? isSynced,
      Value<DateTime?>? lastSyncedAt,
      Value<DateTime?>? createdLocallyAt}) {
    return LocalSalesCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      type: type ?? this.type,
      links: links ?? this.links,
      date: date ?? this.date,
      isReturn: isReturn ?? this.isReturn,
      customerId: customerId ?? this.customerId,
      companyId: companyId ?? this.companyId,
      loggedUser: loggedUser ?? this.loggedUser,
      customerName: customerName ?? this.customerName,
      staffName: staffName ?? this.staffName,
      warehouseId: warehouseId ?? this.warehouseId,
      warehouseName: warehouseName ?? this.warehouseName,
      taxRate: taxRate ?? this.taxRate,
      taxAmount: taxAmount ?? this.taxAmount,
      discount: discount ?? this.discount,
      discountAmount: discountAmount ?? this.discountAmount,
      shipping: shipping ?? this.shipping,
      grandTotal: grandTotal ?? this.grandTotal,
      receivedAmount: receivedAmount ?? this.receivedAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      partialAmount: partialAmount ?? this.partialAmount,
      dueAmount: dueAmount ?? this.dueAmount,
      paymentType: paymentType ?? this.paymentType,
      note: note ?? this.note,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      referenceCode: referenceCode ?? this.referenceCode,
      saleItems: saleItems ?? this.saleItems,
      payments: payments ?? this.payments,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      createdAt: createdAt ?? this.createdAt,
      barcodeUrl: barcodeUrl ?? this.barcodeUrl,
      isOffline: isOffline ?? this.isOffline,
      offlineCustomerName: offlineCustomerName ?? this.offlineCustomerName,
      staffId: staffId ?? this.staffId,
      attendantName: attendantName ?? this.attendantName,
      attendantId: attendantId ?? this.attendantId,
      roomDetails: roomDetails ?? this.roomDetails,
      partialPaymentAmount: partialPaymentAmount ?? this.partialPaymentAmount,
      partialPaymentMethod: partialPaymentMethod ?? this.partialPaymentMethod,
      isSynced: isSynced ?? this.isSynced,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      createdLocallyAt: createdLocallyAt ?? this.createdLocallyAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (links.present) {
      map['links'] =
          Variable<String>($LocalSalesTable.$converterlinks.toSql(links.value));
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (isReturn.present) {
      map['is_return'] = Variable<int>(isReturn.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<int>(companyId.value);
    }
    if (loggedUser.present) {
      map['logged_user'] = Variable<String>(
          $LocalSalesTable.$converterloggedUser.toSql(loggedUser.value));
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (staffName.present) {
      map['staff_name'] = Variable<String>(staffName.value);
    }
    if (warehouseId.present) {
      map['warehouse_id'] = Variable<int>(warehouseId.value);
    }
    if (warehouseName.present) {
      map['warehouse_name'] = Variable<String>(warehouseName.value);
    }
    if (taxRate.present) {
      map['tax_rate'] = Variable<double>(taxRate.value);
    }
    if (taxAmount.present) {
      map['tax_amount'] = Variable<double>(taxAmount.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (discountAmount.present) {
      map['discount_amount'] = Variable<double>(discountAmount.value);
    }
    if (shipping.present) {
      map['shipping'] = Variable<double>(shipping.value);
    }
    if (grandTotal.present) {
      map['grand_total'] = Variable<double>(grandTotal.value);
    }
    if (receivedAmount.present) {
      map['received_amount'] = Variable<double>(receivedAmount.value);
    }
    if (paidAmount.present) {
      map['paid_amount'] = Variable<double>(paidAmount.value);
    }
    if (partialAmount.present) {
      map['partial_amount'] = Variable<double>(partialAmount.value);
    }
    if (dueAmount.present) {
      map['due_amount'] = Variable<double>(dueAmount.value);
    }
    if (paymentType.present) {
      map['payment_type'] = Variable<int>(paymentType.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (paymentStatus.present) {
      map['payment_status'] = Variable<int>(paymentStatus.value);
    }
    if (referenceCode.present) {
      map['reference_code'] = Variable<String>(referenceCode.value);
    }
    if (saleItems.present) {
      map['sale_items'] = Variable<String>(
          $LocalSalesTable.$convertersaleItems.toSql(saleItems.value));
    }
    if (payments.present) {
      map['payments'] = Variable<String>(
          $LocalSalesTable.$converterpayments.toSql(payments.value));
    }
    if (paymentMethods.present) {
      map['payment_methods'] = Variable<String>($LocalSalesTable
          .$converterpaymentMethods
          .toSql(paymentMethods.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (barcodeUrl.present) {
      map['barcode_url'] = Variable<String>(barcodeUrl.value);
    }
    if (isOffline.present) {
      map['is_offline'] = Variable<bool>(isOffline.value);
    }
    if (offlineCustomerName.present) {
      map['offline_customer_name'] =
          Variable<String>(offlineCustomerName.value);
    }
    if (staffId.present) {
      map['staff_id'] = Variable<int>(staffId.value);
    }
    if (attendantName.present) {
      map['attendant_name'] = Variable<String>(attendantName.value);
    }
    if (attendantId.present) {
      map['attendant_id'] = Variable<int>(attendantId.value);
    }
    if (roomDetails.present) {
      map['room_details'] = Variable<String>(
          $LocalSalesTable.$converterroomDetails.toSql(roomDetails.value));
    }
    if (partialPaymentAmount.present) {
      map['partial_payment_amount'] =
          Variable<double>(partialPaymentAmount.value);
    }
    if (partialPaymentMethod.present) {
      map['partial_payment_method'] =
          Variable<String>(partialPaymentMethod.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (createdLocallyAt.present) {
      map['created_locally_at'] = Variable<DateTime>(createdLocallyAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalSalesCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('type: $type, ')
          ..write('links: $links, ')
          ..write('date: $date, ')
          ..write('isReturn: $isReturn, ')
          ..write('customerId: $customerId, ')
          ..write('companyId: $companyId, ')
          ..write('loggedUser: $loggedUser, ')
          ..write('customerName: $customerName, ')
          ..write('staffName: $staffName, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('warehouseName: $warehouseName, ')
          ..write('taxRate: $taxRate, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('discount: $discount, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('shipping: $shipping, ')
          ..write('grandTotal: $grandTotal, ')
          ..write('receivedAmount: $receivedAmount, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('partialAmount: $partialAmount, ')
          ..write('dueAmount: $dueAmount, ')
          ..write('paymentType: $paymentType, ')
          ..write('note: $note, ')
          ..write('status: $status, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('referenceCode: $referenceCode, ')
          ..write('saleItems: $saleItems, ')
          ..write('payments: $payments, ')
          ..write('paymentMethods: $paymentMethods, ')
          ..write('createdAt: $createdAt, ')
          ..write('barcodeUrl: $barcodeUrl, ')
          ..write('isOffline: $isOffline, ')
          ..write('offlineCustomerName: $offlineCustomerName, ')
          ..write('staffId: $staffId, ')
          ..write('attendantName: $attendantName, ')
          ..write('attendantId: $attendantId, ')
          ..write('roomDetails: $roomDetails, ')
          ..write('partialPaymentAmount: $partialPaymentAmount, ')
          ..write('partialPaymentMethod: $partialPaymentMethod, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('createdLocallyAt: $createdLocallyAt')
          ..write(')'))
        .toString();
  }
}

class $LocalHoldsTable extends LocalHolds
    with TableInfo<$LocalHoldsTable, LocalHold> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalHoldsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      links = GeneratedColumn<String>('links', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Map<String, dynamic>?>(
              $LocalHoldsTable.$converterlinks);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<HoldAttendant?, String>
      attendant = GeneratedColumn<String>('attendant', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<HoldAttendant?>($LocalHoldsTable.$converterattendant);
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
      'customer_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _customerNameMeta =
      const VerificationMeta('customerName');
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
      'customer_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _staffIdMeta =
      const VerificationMeta('staffId');
  @override
  late final GeneratedColumn<int> staffId = GeneratedColumn<int>(
      'staff_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _staffNameMeta =
      const VerificationMeta('staffName');
  @override
  late final GeneratedColumn<String> staffName = GeneratedColumn<String>(
      'staff_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _warehouseIdMeta =
      const VerificationMeta('warehouseId');
  @override
  late final GeneratedColumn<int> warehouseId = GeneratedColumn<int>(
      'warehouse_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _warehouseNameMeta =
      const VerificationMeta('warehouseName');
  @override
  late final GeneratedColumn<String> warehouseName = GeneratedColumn<String>(
      'warehouse_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _taxRateMeta =
      const VerificationMeta('taxRate');
  @override
  late final GeneratedColumn<double> taxRate = GeneratedColumn<double>(
      'tax_rate', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _taxAmountMeta =
      const VerificationMeta('taxAmount');
  @override
  late final GeneratedColumn<double> taxAmount = GeneratedColumn<double>(
      'tax_amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _discountMeta =
      const VerificationMeta('discount');
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
      'discount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _shippingMeta =
      const VerificationMeta('shipping');
  @override
  late final GeneratedColumn<double> shipping = GeneratedColumn<double>(
      'shipping', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _grandTotalMeta =
      const VerificationMeta('grandTotal');
  @override
  late final GeneratedColumn<double> grandTotal = GeneratedColumn<double>(
      'grand_total', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _receivedAmountMeta =
      const VerificationMeta('receivedAmount');
  @override
  late final GeneratedColumn<double> receivedAmount = GeneratedColumn<double>(
      'received_amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _paidAmountMeta =
      const VerificationMeta('paidAmount');
  @override
  late final GeneratedColumn<double> paidAmount = GeneratedColumn<double>(
      'paid_amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _referenceCodeMeta =
      const VerificationMeta('referenceCode');
  @override
  late final GeneratedColumn<String> referenceCode = GeneratedColumn<String>(
      'reference_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tableIdMeta =
      const VerificationMeta('tableId');
  @override
  late final GeneratedColumn<String> tableId = GeneratedColumn<String>(
      'table_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _holdTableNameMeta =
      const VerificationMeta('holdTableName');
  @override
  late final GeneratedColumn<String> holdTableName = GeneratedColumn<String>(
      'hold_table_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<List<HoldItem>?, String>
      holdItems = GeneratedColumn<String>('hold_items', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<HoldItem>?>($LocalHoldsTable.$converterholdItems);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdLocallyAtMeta =
      const VerificationMeta('createdLocallyAt');
  @override
  late final GeneratedColumn<DateTime> createdLocallyAt =
      GeneratedColumn<DateTime>('created_locally_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        remoteId,
        type,
        links,
        date,
        userId,
        attendant,
        customerId,
        customerName,
        staffId,
        staffName,
        warehouseId,
        warehouseName,
        taxRate,
        taxAmount,
        discount,
        shipping,
        grandTotal,
        receivedAmount,
        paidAmount,
        referenceCode,
        note,
        status,
        tableId,
        holdTableName,
        holdItems,
        createdAt,
        isSynced,
        lastSyncedAt,
        createdLocallyAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_holds';
  @override
  VerificationContext validateIntegrity(Insertable<LocalHold> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    }
    if (data.containsKey('customer_name')) {
      context.handle(
          _customerNameMeta,
          customerName.isAcceptableOrUnknown(
              data['customer_name']!, _customerNameMeta));
    }
    if (data.containsKey('staff_id')) {
      context.handle(_staffIdMeta,
          staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta));
    }
    if (data.containsKey('staff_name')) {
      context.handle(_staffNameMeta,
          staffName.isAcceptableOrUnknown(data['staff_name']!, _staffNameMeta));
    }
    if (data.containsKey('warehouse_id')) {
      context.handle(
          _warehouseIdMeta,
          warehouseId.isAcceptableOrUnknown(
              data['warehouse_id']!, _warehouseIdMeta));
    }
    if (data.containsKey('warehouse_name')) {
      context.handle(
          _warehouseNameMeta,
          warehouseName.isAcceptableOrUnknown(
              data['warehouse_name']!, _warehouseNameMeta));
    }
    if (data.containsKey('tax_rate')) {
      context.handle(_taxRateMeta,
          taxRate.isAcceptableOrUnknown(data['tax_rate']!, _taxRateMeta));
    }
    if (data.containsKey('tax_amount')) {
      context.handle(_taxAmountMeta,
          taxAmount.isAcceptableOrUnknown(data['tax_amount']!, _taxAmountMeta));
    }
    if (data.containsKey('discount')) {
      context.handle(_discountMeta,
          discount.isAcceptableOrUnknown(data['discount']!, _discountMeta));
    }
    if (data.containsKey('shipping')) {
      context.handle(_shippingMeta,
          shipping.isAcceptableOrUnknown(data['shipping']!, _shippingMeta));
    }
    if (data.containsKey('grand_total')) {
      context.handle(
          _grandTotalMeta,
          grandTotal.isAcceptableOrUnknown(
              data['grand_total']!, _grandTotalMeta));
    }
    if (data.containsKey('received_amount')) {
      context.handle(
          _receivedAmountMeta,
          receivedAmount.isAcceptableOrUnknown(
              data['received_amount']!, _receivedAmountMeta));
    }
    if (data.containsKey('paid_amount')) {
      context.handle(
          _paidAmountMeta,
          paidAmount.isAcceptableOrUnknown(
              data['paid_amount']!, _paidAmountMeta));
    }
    if (data.containsKey('reference_code')) {
      context.handle(
          _referenceCodeMeta,
          referenceCode.isAcceptableOrUnknown(
              data['reference_code']!, _referenceCodeMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('table_id')) {
      context.handle(_tableIdMeta,
          tableId.isAcceptableOrUnknown(data['table_id']!, _tableIdMeta));
    }
    if (data.containsKey('hold_table_name')) {
      context.handle(
          _holdTableNameMeta,
          holdTableName.isAcceptableOrUnknown(
              data['hold_table_name']!, _holdTableNameMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('created_locally_at')) {
      context.handle(
          _createdLocallyAtMeta,
          createdLocallyAt.isAcceptableOrUnknown(
              data['created_locally_at']!, _createdLocallyAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalHold map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalHold(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}remote_id']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type']),
      links: $LocalHoldsTable.$converterlinks.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}links'])),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date']),
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      attendant: $LocalHoldsTable.$converterattendant.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}attendant'])),
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}customer_id']),
      customerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_name']),
      staffId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}staff_id']),
      staffName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}staff_name']),
      warehouseId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}warehouse_id']),
      warehouseName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}warehouse_name']),
      taxRate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tax_rate']),
      taxAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tax_amount']),
      discount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}discount']),
      shipping: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}shipping']),
      grandTotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}grand_total']),
      receivedAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}received_amount']),
      paidAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}paid_amount']),
      referenceCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference_code']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status']),
      tableId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}table_id']),
      holdTableName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hold_table_name']),
      holdItems: $LocalHoldsTable.$converterholdItems.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hold_items'])),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_synced_at']),
      createdLocallyAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}created_locally_at']),
    );
  }

  @override
  $LocalHoldsTable createAlias(String alias) {
    return $LocalHoldsTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>?, String?> $converterlinks =
      NullAwareTypeConverter.wrap(const MapStringDynamicConverter());
  static TypeConverter<HoldAttendant?, String?> $converterattendant =
      NullAwareTypeConverter.wrap(const HoldAttendantConverter());
  static TypeConverter<List<HoldItem>?, String?> $converterholdItems =
      NullAwareTypeConverter.wrap(const HoldItemListConverter());
}

class LocalHold extends DataClass implements Insertable<LocalHold> {
  final int id;
  final int? remoteId;
  final String? type;
  final Map<String, dynamic>? links;
  final DateTime? date;
  final int? userId;
  final HoldAttendant? attendant;
  final int? customerId;
  final String? customerName;
  final int? staffId;
  final String? staffName;
  final int? warehouseId;
  final String? warehouseName;
  final double? taxRate;
  final double? taxAmount;
  final double? discount;
  final double? shipping;
  final double? grandTotal;
  final double? receivedAmount;
  final double? paidAmount;
  final String? referenceCode;
  final String? note;
  final String? status;
  final String? tableId;
  final String? holdTableName;
  final List<HoldItem>? holdItems;
  final DateTime? createdAt;
  final bool isSynced;
  final DateTime? lastSyncedAt;
  final DateTime? createdLocallyAt;
  const LocalHold(
      {required this.id,
      this.remoteId,
      this.type,
      this.links,
      this.date,
      this.userId,
      this.attendant,
      this.customerId,
      this.customerName,
      this.staffId,
      this.staffName,
      this.warehouseId,
      this.warehouseName,
      this.taxRate,
      this.taxAmount,
      this.discount,
      this.shipping,
      this.grandTotal,
      this.receivedAmount,
      this.paidAmount,
      this.referenceCode,
      this.note,
      this.status,
      this.tableId,
      this.holdTableName,
      this.holdItems,
      this.createdAt,
      required this.isSynced,
      this.lastSyncedAt,
      this.createdLocallyAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<int>(remoteId);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || links != null) {
      map['links'] =
          Variable<String>($LocalHoldsTable.$converterlinks.toSql(links));
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    if (!nullToAbsent || attendant != null) {
      map['attendant'] = Variable<String>(
          $LocalHoldsTable.$converterattendant.toSql(attendant));
    }
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    if (!nullToAbsent || customerName != null) {
      map['customer_name'] = Variable<String>(customerName);
    }
    if (!nullToAbsent || staffId != null) {
      map['staff_id'] = Variable<int>(staffId);
    }
    if (!nullToAbsent || staffName != null) {
      map['staff_name'] = Variable<String>(staffName);
    }
    if (!nullToAbsent || warehouseId != null) {
      map['warehouse_id'] = Variable<int>(warehouseId);
    }
    if (!nullToAbsent || warehouseName != null) {
      map['warehouse_name'] = Variable<String>(warehouseName);
    }
    if (!nullToAbsent || taxRate != null) {
      map['tax_rate'] = Variable<double>(taxRate);
    }
    if (!nullToAbsent || taxAmount != null) {
      map['tax_amount'] = Variable<double>(taxAmount);
    }
    if (!nullToAbsent || discount != null) {
      map['discount'] = Variable<double>(discount);
    }
    if (!nullToAbsent || shipping != null) {
      map['shipping'] = Variable<double>(shipping);
    }
    if (!nullToAbsent || grandTotal != null) {
      map['grand_total'] = Variable<double>(grandTotal);
    }
    if (!nullToAbsent || receivedAmount != null) {
      map['received_amount'] = Variable<double>(receivedAmount);
    }
    if (!nullToAbsent || paidAmount != null) {
      map['paid_amount'] = Variable<double>(paidAmount);
    }
    if (!nullToAbsent || referenceCode != null) {
      map['reference_code'] = Variable<String>(referenceCode);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || tableId != null) {
      map['table_id'] = Variable<String>(tableId);
    }
    if (!nullToAbsent || holdTableName != null) {
      map['hold_table_name'] = Variable<String>(holdTableName);
    }
    if (!nullToAbsent || holdItems != null) {
      map['hold_items'] = Variable<String>(
          $LocalHoldsTable.$converterholdItems.toSql(holdItems));
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    if (!nullToAbsent || createdLocallyAt != null) {
      map['created_locally_at'] = Variable<DateTime>(createdLocallyAt);
    }
    return map;
  }

  LocalHoldsCompanion toCompanion(bool nullToAbsent) {
    return LocalHoldsCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      links:
          links == null && nullToAbsent ? const Value.absent() : Value(links),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      attendant: attendant == null && nullToAbsent
          ? const Value.absent()
          : Value(attendant),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      customerName: customerName == null && nullToAbsent
          ? const Value.absent()
          : Value(customerName),
      staffId: staffId == null && nullToAbsent
          ? const Value.absent()
          : Value(staffId),
      staffName: staffName == null && nullToAbsent
          ? const Value.absent()
          : Value(staffName),
      warehouseId: warehouseId == null && nullToAbsent
          ? const Value.absent()
          : Value(warehouseId),
      warehouseName: warehouseName == null && nullToAbsent
          ? const Value.absent()
          : Value(warehouseName),
      taxRate: taxRate == null && nullToAbsent
          ? const Value.absent()
          : Value(taxRate),
      taxAmount: taxAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(taxAmount),
      discount: discount == null && nullToAbsent
          ? const Value.absent()
          : Value(discount),
      shipping: shipping == null && nullToAbsent
          ? const Value.absent()
          : Value(shipping),
      grandTotal: grandTotal == null && nullToAbsent
          ? const Value.absent()
          : Value(grandTotal),
      receivedAmount: receivedAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(receivedAmount),
      paidAmount: paidAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(paidAmount),
      referenceCode: referenceCode == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceCode),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      tableId: tableId == null && nullToAbsent
          ? const Value.absent()
          : Value(tableId),
      holdTableName: holdTableName == null && nullToAbsent
          ? const Value.absent()
          : Value(holdTableName),
      holdItems: holdItems == null && nullToAbsent
          ? const Value.absent()
          : Value(holdItems),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      isSynced: Value(isSynced),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      createdLocallyAt: createdLocallyAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdLocallyAt),
    );
  }

  factory LocalHold.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalHold(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<int?>(json['remoteId']),
      type: serializer.fromJson<String?>(json['type']),
      links: serializer.fromJson<Map<String, dynamic>?>(json['links']),
      date: serializer.fromJson<DateTime?>(json['date']),
      userId: serializer.fromJson<int?>(json['userId']),
      attendant: serializer.fromJson<HoldAttendant?>(json['attendant']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      customerName: serializer.fromJson<String?>(json['customerName']),
      staffId: serializer.fromJson<int?>(json['staffId']),
      staffName: serializer.fromJson<String?>(json['staffName']),
      warehouseId: serializer.fromJson<int?>(json['warehouseId']),
      warehouseName: serializer.fromJson<String?>(json['warehouseName']),
      taxRate: serializer.fromJson<double?>(json['taxRate']),
      taxAmount: serializer.fromJson<double?>(json['taxAmount']),
      discount: serializer.fromJson<double?>(json['discount']),
      shipping: serializer.fromJson<double?>(json['shipping']),
      grandTotal: serializer.fromJson<double?>(json['grandTotal']),
      receivedAmount: serializer.fromJson<double?>(json['receivedAmount']),
      paidAmount: serializer.fromJson<double?>(json['paidAmount']),
      referenceCode: serializer.fromJson<String?>(json['referenceCode']),
      note: serializer.fromJson<String?>(json['note']),
      status: serializer.fromJson<String?>(json['status']),
      tableId: serializer.fromJson<String?>(json['tableId']),
      holdTableName: serializer.fromJson<String?>(json['holdTableName']),
      holdItems: serializer.fromJson<List<HoldItem>?>(json['holdItems']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
      createdLocallyAt:
          serializer.fromJson<DateTime?>(json['createdLocallyAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<int?>(remoteId),
      'type': serializer.toJson<String?>(type),
      'links': serializer.toJson<Map<String, dynamic>?>(links),
      'date': serializer.toJson<DateTime?>(date),
      'userId': serializer.toJson<int?>(userId),
      'attendant': serializer.toJson<HoldAttendant?>(attendant),
      'customerId': serializer.toJson<int?>(customerId),
      'customerName': serializer.toJson<String?>(customerName),
      'staffId': serializer.toJson<int?>(staffId),
      'staffName': serializer.toJson<String?>(staffName),
      'warehouseId': serializer.toJson<int?>(warehouseId),
      'warehouseName': serializer.toJson<String?>(warehouseName),
      'taxRate': serializer.toJson<double?>(taxRate),
      'taxAmount': serializer.toJson<double?>(taxAmount),
      'discount': serializer.toJson<double?>(discount),
      'shipping': serializer.toJson<double?>(shipping),
      'grandTotal': serializer.toJson<double?>(grandTotal),
      'receivedAmount': serializer.toJson<double?>(receivedAmount),
      'paidAmount': serializer.toJson<double?>(paidAmount),
      'referenceCode': serializer.toJson<String?>(referenceCode),
      'note': serializer.toJson<String?>(note),
      'status': serializer.toJson<String?>(status),
      'tableId': serializer.toJson<String?>(tableId),
      'holdTableName': serializer.toJson<String?>(holdTableName),
      'holdItems': serializer.toJson<List<HoldItem>?>(holdItems),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
      'createdLocallyAt': serializer.toJson<DateTime?>(createdLocallyAt),
    };
  }

  LocalHold copyWith(
          {int? id,
          Value<int?> remoteId = const Value.absent(),
          Value<String?> type = const Value.absent(),
          Value<Map<String, dynamic>?> links = const Value.absent(),
          Value<DateTime?> date = const Value.absent(),
          Value<int?> userId = const Value.absent(),
          Value<HoldAttendant?> attendant = const Value.absent(),
          Value<int?> customerId = const Value.absent(),
          Value<String?> customerName = const Value.absent(),
          Value<int?> staffId = const Value.absent(),
          Value<String?> staffName = const Value.absent(),
          Value<int?> warehouseId = const Value.absent(),
          Value<String?> warehouseName = const Value.absent(),
          Value<double?> taxRate = const Value.absent(),
          Value<double?> taxAmount = const Value.absent(),
          Value<double?> discount = const Value.absent(),
          Value<double?> shipping = const Value.absent(),
          Value<double?> grandTotal = const Value.absent(),
          Value<double?> receivedAmount = const Value.absent(),
          Value<double?> paidAmount = const Value.absent(),
          Value<String?> referenceCode = const Value.absent(),
          Value<String?> note = const Value.absent(),
          Value<String?> status = const Value.absent(),
          Value<String?> tableId = const Value.absent(),
          Value<String?> holdTableName = const Value.absent(),
          Value<List<HoldItem>?> holdItems = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          bool? isSynced,
          Value<DateTime?> lastSyncedAt = const Value.absent(),
          Value<DateTime?> createdLocallyAt = const Value.absent()}) =>
      LocalHold(
        id: id ?? this.id,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        type: type.present ? type.value : this.type,
        links: links.present ? links.value : this.links,
        date: date.present ? date.value : this.date,
        userId: userId.present ? userId.value : this.userId,
        attendant: attendant.present ? attendant.value : this.attendant,
        customerId: customerId.present ? customerId.value : this.customerId,
        customerName:
            customerName.present ? customerName.value : this.customerName,
        staffId: staffId.present ? staffId.value : this.staffId,
        staffName: staffName.present ? staffName.value : this.staffName,
        warehouseId: warehouseId.present ? warehouseId.value : this.warehouseId,
        warehouseName:
            warehouseName.present ? warehouseName.value : this.warehouseName,
        taxRate: taxRate.present ? taxRate.value : this.taxRate,
        taxAmount: taxAmount.present ? taxAmount.value : this.taxAmount,
        discount: discount.present ? discount.value : this.discount,
        shipping: shipping.present ? shipping.value : this.shipping,
        grandTotal: grandTotal.present ? grandTotal.value : this.grandTotal,
        receivedAmount:
            receivedAmount.present ? receivedAmount.value : this.receivedAmount,
        paidAmount: paidAmount.present ? paidAmount.value : this.paidAmount,
        referenceCode:
            referenceCode.present ? referenceCode.value : this.referenceCode,
        note: note.present ? note.value : this.note,
        status: status.present ? status.value : this.status,
        tableId: tableId.present ? tableId.value : this.tableId,
        holdTableName:
            holdTableName.present ? holdTableName.value : this.holdTableName,
        holdItems: holdItems.present ? holdItems.value : this.holdItems,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        isSynced: isSynced ?? this.isSynced,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        createdLocallyAt: createdLocallyAt.present
            ? createdLocallyAt.value
            : this.createdLocallyAt,
      );
  LocalHold copyWithCompanion(LocalHoldsCompanion data) {
    return LocalHold(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      type: data.type.present ? data.type.value : this.type,
      links: data.links.present ? data.links.value : this.links,
      date: data.date.present ? data.date.value : this.date,
      userId: data.userId.present ? data.userId.value : this.userId,
      attendant: data.attendant.present ? data.attendant.value : this.attendant,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      staffName: data.staffName.present ? data.staffName.value : this.staffName,
      warehouseId:
          data.warehouseId.present ? data.warehouseId.value : this.warehouseId,
      warehouseName: data.warehouseName.present
          ? data.warehouseName.value
          : this.warehouseName,
      taxRate: data.taxRate.present ? data.taxRate.value : this.taxRate,
      taxAmount: data.taxAmount.present ? data.taxAmount.value : this.taxAmount,
      discount: data.discount.present ? data.discount.value : this.discount,
      shipping: data.shipping.present ? data.shipping.value : this.shipping,
      grandTotal:
          data.grandTotal.present ? data.grandTotal.value : this.grandTotal,
      receivedAmount: data.receivedAmount.present
          ? data.receivedAmount.value
          : this.receivedAmount,
      paidAmount:
          data.paidAmount.present ? data.paidAmount.value : this.paidAmount,
      referenceCode: data.referenceCode.present
          ? data.referenceCode.value
          : this.referenceCode,
      note: data.note.present ? data.note.value : this.note,
      status: data.status.present ? data.status.value : this.status,
      tableId: data.tableId.present ? data.tableId.value : this.tableId,
      holdTableName: data.holdTableName.present
          ? data.holdTableName.value
          : this.holdTableName,
      holdItems: data.holdItems.present ? data.holdItems.value : this.holdItems,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      createdLocallyAt: data.createdLocallyAt.present
          ? data.createdLocallyAt.value
          : this.createdLocallyAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalHold(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('type: $type, ')
          ..write('links: $links, ')
          ..write('date: $date, ')
          ..write('userId: $userId, ')
          ..write('attendant: $attendant, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('staffId: $staffId, ')
          ..write('staffName: $staffName, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('warehouseName: $warehouseName, ')
          ..write('taxRate: $taxRate, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('discount: $discount, ')
          ..write('shipping: $shipping, ')
          ..write('grandTotal: $grandTotal, ')
          ..write('receivedAmount: $receivedAmount, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('referenceCode: $referenceCode, ')
          ..write('note: $note, ')
          ..write('status: $status, ')
          ..write('tableId: $tableId, ')
          ..write('holdTableName: $holdTableName, ')
          ..write('holdItems: $holdItems, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('createdLocallyAt: $createdLocallyAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        remoteId,
        type,
        links,
        date,
        userId,
        attendant,
        customerId,
        customerName,
        staffId,
        staffName,
        warehouseId,
        warehouseName,
        taxRate,
        taxAmount,
        discount,
        shipping,
        grandTotal,
        receivedAmount,
        paidAmount,
        referenceCode,
        note,
        status,
        tableId,
        holdTableName,
        holdItems,
        createdAt,
        isSynced,
        lastSyncedAt,
        createdLocallyAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalHold &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.type == this.type &&
          other.links == this.links &&
          other.date == this.date &&
          other.userId == this.userId &&
          other.attendant == this.attendant &&
          other.customerId == this.customerId &&
          other.customerName == this.customerName &&
          other.staffId == this.staffId &&
          other.staffName == this.staffName &&
          other.warehouseId == this.warehouseId &&
          other.warehouseName == this.warehouseName &&
          other.taxRate == this.taxRate &&
          other.taxAmount == this.taxAmount &&
          other.discount == this.discount &&
          other.shipping == this.shipping &&
          other.grandTotal == this.grandTotal &&
          other.receivedAmount == this.receivedAmount &&
          other.paidAmount == this.paidAmount &&
          other.referenceCode == this.referenceCode &&
          other.note == this.note &&
          other.status == this.status &&
          other.tableId == this.tableId &&
          other.holdTableName == this.holdTableName &&
          other.holdItems == this.holdItems &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.createdLocallyAt == this.createdLocallyAt);
}

class LocalHoldsCompanion extends UpdateCompanion<LocalHold> {
  final Value<int> id;
  final Value<int?> remoteId;
  final Value<String?> type;
  final Value<Map<String, dynamic>?> links;
  final Value<DateTime?> date;
  final Value<int?> userId;
  final Value<HoldAttendant?> attendant;
  final Value<int?> customerId;
  final Value<String?> customerName;
  final Value<int?> staffId;
  final Value<String?> staffName;
  final Value<int?> warehouseId;
  final Value<String?> warehouseName;
  final Value<double?> taxRate;
  final Value<double?> taxAmount;
  final Value<double?> discount;
  final Value<double?> shipping;
  final Value<double?> grandTotal;
  final Value<double?> receivedAmount;
  final Value<double?> paidAmount;
  final Value<String?> referenceCode;
  final Value<String?> note;
  final Value<String?> status;
  final Value<String?> tableId;
  final Value<String?> holdTableName;
  final Value<List<HoldItem>?> holdItems;
  final Value<DateTime?> createdAt;
  final Value<bool> isSynced;
  final Value<DateTime?> lastSyncedAt;
  final Value<DateTime?> createdLocallyAt;
  const LocalHoldsCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.type = const Value.absent(),
    this.links = const Value.absent(),
    this.date = const Value.absent(),
    this.userId = const Value.absent(),
    this.attendant = const Value.absent(),
    this.customerId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.staffId = const Value.absent(),
    this.staffName = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.warehouseName = const Value.absent(),
    this.taxRate = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.discount = const Value.absent(),
    this.shipping = const Value.absent(),
    this.grandTotal = const Value.absent(),
    this.receivedAmount = const Value.absent(),
    this.paidAmount = const Value.absent(),
    this.referenceCode = const Value.absent(),
    this.note = const Value.absent(),
    this.status = const Value.absent(),
    this.tableId = const Value.absent(),
    this.holdTableName = const Value.absent(),
    this.holdItems = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.createdLocallyAt = const Value.absent(),
  });
  LocalHoldsCompanion.insert({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.type = const Value.absent(),
    this.links = const Value.absent(),
    this.date = const Value.absent(),
    this.userId = const Value.absent(),
    this.attendant = const Value.absent(),
    this.customerId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.staffId = const Value.absent(),
    this.staffName = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.warehouseName = const Value.absent(),
    this.taxRate = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.discount = const Value.absent(),
    this.shipping = const Value.absent(),
    this.grandTotal = const Value.absent(),
    this.receivedAmount = const Value.absent(),
    this.paidAmount = const Value.absent(),
    this.referenceCode = const Value.absent(),
    this.note = const Value.absent(),
    this.status = const Value.absent(),
    this.tableId = const Value.absent(),
    this.holdTableName = const Value.absent(),
    this.holdItems = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.createdLocallyAt = const Value.absent(),
  });
  static Insertable<LocalHold> custom({
    Expression<int>? id,
    Expression<int>? remoteId,
    Expression<String>? type,
    Expression<String>? links,
    Expression<DateTime>? date,
    Expression<int>? userId,
    Expression<String>? attendant,
    Expression<int>? customerId,
    Expression<String>? customerName,
    Expression<int>? staffId,
    Expression<String>? staffName,
    Expression<int>? warehouseId,
    Expression<String>? warehouseName,
    Expression<double>? taxRate,
    Expression<double>? taxAmount,
    Expression<double>? discount,
    Expression<double>? shipping,
    Expression<double>? grandTotal,
    Expression<double>? receivedAmount,
    Expression<double>? paidAmount,
    Expression<String>? referenceCode,
    Expression<String>? note,
    Expression<String>? status,
    Expression<String>? tableId,
    Expression<String>? holdTableName,
    Expression<String>? holdItems,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
    Expression<DateTime>? lastSyncedAt,
    Expression<DateTime>? createdLocallyAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (type != null) 'type': type,
      if (links != null) 'links': links,
      if (date != null) 'date': date,
      if (userId != null) 'user_id': userId,
      if (attendant != null) 'attendant': attendant,
      if (customerId != null) 'customer_id': customerId,
      if (customerName != null) 'customer_name': customerName,
      if (staffId != null) 'staff_id': staffId,
      if (staffName != null) 'staff_name': staffName,
      if (warehouseId != null) 'warehouse_id': warehouseId,
      if (warehouseName != null) 'warehouse_name': warehouseName,
      if (taxRate != null) 'tax_rate': taxRate,
      if (taxAmount != null) 'tax_amount': taxAmount,
      if (discount != null) 'discount': discount,
      if (shipping != null) 'shipping': shipping,
      if (grandTotal != null) 'grand_total': grandTotal,
      if (receivedAmount != null) 'received_amount': receivedAmount,
      if (paidAmount != null) 'paid_amount': paidAmount,
      if (referenceCode != null) 'reference_code': referenceCode,
      if (note != null) 'note': note,
      if (status != null) 'status': status,
      if (tableId != null) 'table_id': tableId,
      if (holdTableName != null) 'hold_table_name': holdTableName,
      if (holdItems != null) 'hold_items': holdItems,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (createdLocallyAt != null) 'created_locally_at': createdLocallyAt,
    });
  }

  LocalHoldsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? remoteId,
      Value<String?>? type,
      Value<Map<String, dynamic>?>? links,
      Value<DateTime?>? date,
      Value<int?>? userId,
      Value<HoldAttendant?>? attendant,
      Value<int?>? customerId,
      Value<String?>? customerName,
      Value<int?>? staffId,
      Value<String?>? staffName,
      Value<int?>? warehouseId,
      Value<String?>? warehouseName,
      Value<double?>? taxRate,
      Value<double?>? taxAmount,
      Value<double?>? discount,
      Value<double?>? shipping,
      Value<double?>? grandTotal,
      Value<double?>? receivedAmount,
      Value<double?>? paidAmount,
      Value<String?>? referenceCode,
      Value<String?>? note,
      Value<String?>? status,
      Value<String?>? tableId,
      Value<String?>? holdTableName,
      Value<List<HoldItem>?>? holdItems,
      Value<DateTime?>? createdAt,
      Value<bool>? isSynced,
      Value<DateTime?>? lastSyncedAt,
      Value<DateTime?>? createdLocallyAt}) {
    return LocalHoldsCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      type: type ?? this.type,
      links: links ?? this.links,
      date: date ?? this.date,
      userId: userId ?? this.userId,
      attendant: attendant ?? this.attendant,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      staffId: staffId ?? this.staffId,
      staffName: staffName ?? this.staffName,
      warehouseId: warehouseId ?? this.warehouseId,
      warehouseName: warehouseName ?? this.warehouseName,
      taxRate: taxRate ?? this.taxRate,
      taxAmount: taxAmount ?? this.taxAmount,
      discount: discount ?? this.discount,
      shipping: shipping ?? this.shipping,
      grandTotal: grandTotal ?? this.grandTotal,
      receivedAmount: receivedAmount ?? this.receivedAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      referenceCode: referenceCode ?? this.referenceCode,
      note: note ?? this.note,
      status: status ?? this.status,
      tableId: tableId ?? this.tableId,
      holdTableName: holdTableName ?? this.holdTableName,
      holdItems: holdItems ?? this.holdItems,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      createdLocallyAt: createdLocallyAt ?? this.createdLocallyAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (links.present) {
      map['links'] =
          Variable<String>($LocalHoldsTable.$converterlinks.toSql(links.value));
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (attendant.present) {
      map['attendant'] = Variable<String>(
          $LocalHoldsTable.$converterattendant.toSql(attendant.value));
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (staffId.present) {
      map['staff_id'] = Variable<int>(staffId.value);
    }
    if (staffName.present) {
      map['staff_name'] = Variable<String>(staffName.value);
    }
    if (warehouseId.present) {
      map['warehouse_id'] = Variable<int>(warehouseId.value);
    }
    if (warehouseName.present) {
      map['warehouse_name'] = Variable<String>(warehouseName.value);
    }
    if (taxRate.present) {
      map['tax_rate'] = Variable<double>(taxRate.value);
    }
    if (taxAmount.present) {
      map['tax_amount'] = Variable<double>(taxAmount.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (shipping.present) {
      map['shipping'] = Variable<double>(shipping.value);
    }
    if (grandTotal.present) {
      map['grand_total'] = Variable<double>(grandTotal.value);
    }
    if (receivedAmount.present) {
      map['received_amount'] = Variable<double>(receivedAmount.value);
    }
    if (paidAmount.present) {
      map['paid_amount'] = Variable<double>(paidAmount.value);
    }
    if (referenceCode.present) {
      map['reference_code'] = Variable<String>(referenceCode.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (tableId.present) {
      map['table_id'] = Variable<String>(tableId.value);
    }
    if (holdTableName.present) {
      map['hold_table_name'] = Variable<String>(holdTableName.value);
    }
    if (holdItems.present) {
      map['hold_items'] = Variable<String>(
          $LocalHoldsTable.$converterholdItems.toSql(holdItems.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (createdLocallyAt.present) {
      map['created_locally_at'] = Variable<DateTime>(createdLocallyAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalHoldsCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('type: $type, ')
          ..write('links: $links, ')
          ..write('date: $date, ')
          ..write('userId: $userId, ')
          ..write('attendant: $attendant, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('staffId: $staffId, ')
          ..write('staffName: $staffName, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('warehouseName: $warehouseName, ')
          ..write('taxRate: $taxRate, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('discount: $discount, ')
          ..write('shipping: $shipping, ')
          ..write('grandTotal: $grandTotal, ')
          ..write('receivedAmount: $receivedAmount, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('referenceCode: $referenceCode, ')
          ..write('note: $note, ')
          ..write('status: $status, ')
          ..write('tableId: $tableId, ')
          ..write('holdTableName: $holdTableName, ')
          ..write('holdItems: $holdItems, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('createdLocallyAt: $createdLocallyAt')
          ..write(')'))
        .toString();
  }
}

class $AmenitiesTableTable extends AmenitiesTable
    with TableInfo<$AmenitiesTableTable, AmenitiesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AmenitiesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Active'));
  @override
  List<GeneratedColumn> get $columns => [id, name, description, icon, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'amenities_table';
  @override
  VerificationContext validateIntegrity(Insertable<AmenitiesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AmenitiesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AmenitiesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $AmenitiesTableTable createAlias(String alias) {
    return $AmenitiesTableTable(attachedDatabase, alias);
  }
}

class AmenitiesTableData extends DataClass
    implements Insertable<AmenitiesTableData> {
  final int id;
  final String name;
  final String description;
  final String icon;
  final String status;
  const AmenitiesTableData(
      {required this.id,
      required this.name,
      required this.description,
      required this.icon,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['icon'] = Variable<String>(icon);
    map['status'] = Variable<String>(status);
    return map;
  }

  AmenitiesTableCompanion toCompanion(bool nullToAbsent) {
    return AmenitiesTableCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      icon: Value(icon),
      status: Value(status),
    );
  }

  factory AmenitiesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AmenitiesTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      icon: serializer.fromJson<String>(json['icon']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'icon': serializer.toJson<String>(icon),
      'status': serializer.toJson<String>(status),
    };
  }

  AmenitiesTableData copyWith(
          {int? id,
          String? name,
          String? description,
          String? icon,
          String? status}) =>
      AmenitiesTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        icon: icon ?? this.icon,
        status: status ?? this.status,
      );
  AmenitiesTableData copyWithCompanion(AmenitiesTableCompanion data) {
    return AmenitiesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      icon: data.icon.present ? data.icon.value : this.icon,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AmenitiesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, icon, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AmenitiesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.icon == this.icon &&
          other.status == this.status);
}

class AmenitiesTableCompanion extends UpdateCompanion<AmenitiesTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> icon;
  final Value<String> status;
  const AmenitiesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.status = const Value.absent(),
  });
  AmenitiesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    required String icon,
    this.status = const Value.absent(),
  })  : name = Value(name),
        description = Value(description),
        icon = Value(icon);
  static Insertable<AmenitiesTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? icon,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (status != null) 'status': status,
    });
  }

  AmenitiesTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? description,
      Value<String>? icon,
      Value<String>? status}) {
    return AmenitiesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AmenitiesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $LocalFacilitiesTableTable extends LocalFacilitiesTable
    with TableInfo<$LocalFacilitiesTableTable, LocalFacilitiesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalFacilitiesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconCodePointMeta =
      const VerificationMeta('iconCodePoint');
  @override
  late final GeneratedColumn<int> iconCodePoint = GeneratedColumn<int>(
      'icon_code_point', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, iconCodePoint, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_facilities_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<LocalFacilitiesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_code_point')) {
      context.handle(
          _iconCodePointMeta,
          iconCodePoint.isAcceptableOrUnknown(
              data['icon_code_point']!, _iconCodePointMeta));
    } else if (isInserting) {
      context.missing(_iconCodePointMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalFacilitiesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalFacilitiesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      iconCodePoint: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}icon_code_point'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $LocalFacilitiesTableTable createAlias(String alias) {
    return $LocalFacilitiesTableTable(attachedDatabase, alias);
  }
}

class LocalFacilitiesTableData extends DataClass
    implements Insertable<LocalFacilitiesTableData> {
  final int id;
  final String name;
  final int iconCodePoint;
  final String status;
  const LocalFacilitiesTableData(
      {required this.id,
      required this.name,
      required this.iconCodePoint,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['icon_code_point'] = Variable<int>(iconCodePoint);
    map['status'] = Variable<String>(status);
    return map;
  }

  LocalFacilitiesTableCompanion toCompanion(bool nullToAbsent) {
    return LocalFacilitiesTableCompanion(
      id: Value(id),
      name: Value(name),
      iconCodePoint: Value(iconCodePoint),
      status: Value(status),
    );
  }

  factory LocalFacilitiesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalFacilitiesTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      iconCodePoint: serializer.fromJson<int>(json['iconCodePoint']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'iconCodePoint': serializer.toJson<int>(iconCodePoint),
      'status': serializer.toJson<String>(status),
    };
  }

  LocalFacilitiesTableData copyWith(
          {int? id, String? name, int? iconCodePoint, String? status}) =>
      LocalFacilitiesTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        iconCodePoint: iconCodePoint ?? this.iconCodePoint,
        status: status ?? this.status,
      );
  LocalFacilitiesTableData copyWithCompanion(
      LocalFacilitiesTableCompanion data) {
    return LocalFacilitiesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      iconCodePoint: data.iconCodePoint.present
          ? data.iconCodePoint.value
          : this.iconCodePoint,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalFacilitiesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconCodePoint: $iconCodePoint, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, iconCodePoint, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalFacilitiesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.iconCodePoint == this.iconCodePoint &&
          other.status == this.status);
}

class LocalFacilitiesTableCompanion
    extends UpdateCompanion<LocalFacilitiesTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> iconCodePoint;
  final Value<String> status;
  const LocalFacilitiesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.iconCodePoint = const Value.absent(),
    this.status = const Value.absent(),
  });
  LocalFacilitiesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int iconCodePoint,
    required String status,
  })  : name = Value(name),
        iconCodePoint = Value(iconCodePoint),
        status = Value(status);
  static Insertable<LocalFacilitiesTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? iconCodePoint,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (iconCodePoint != null) 'icon_code_point': iconCodePoint,
      if (status != null) 'status': status,
    });
  }

  LocalFacilitiesTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? iconCodePoint,
      Value<String>? status}) {
    return LocalFacilitiesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconCodePoint.present) {
      map['icon_code_point'] = Variable<int>(iconCodePoint.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalFacilitiesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconCodePoint: $iconCodePoint, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

abstract class _$DatabaseClient extends GeneratedDatabase {
  _$DatabaseClient(QueryExecutor e) : super(e);
  $DatabaseClientManager get managers => $DatabaseClientManager(this);
  late final $LocalAttendantsTable localAttendants =
      $LocalAttendantsTable(this);
  late final $LocalCustomersTable localCustomers = $LocalCustomersTable(this);
  late final $LocalBarTablesTable localBarTables = $LocalBarTablesTable(this);
  late final $LocalProductCategoriesTable localProductCategories =
      $LocalProductCategoriesTable(this);
  late final $LocalProductsTable localProducts = $LocalProductsTable(this);
  late final $LocalWarehousesTable localWarehouses =
      $LocalWarehousesTable(this);
  late final $LocalRegistersTable localRegisters = $LocalRegistersTable(this);
  late final $LocalSalesTable localSales = $LocalSalesTable(this);
  late final $LocalHoldsTable localHolds = $LocalHoldsTable(this);
  late final $AmenitiesTableTable amenitiesTable = $AmenitiesTableTable(this);
  late final $LocalFacilitiesTableTable localFacilitiesTable =
      $LocalFacilitiesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        localAttendants,
        localCustomers,
        localBarTables,
        localProductCategories,
        localProducts,
        localWarehouses,
        localRegisters,
        localSales,
        localHolds,
        amenitiesTable,
        localFacilitiesTable
      ];
}

typedef $$LocalAttendantsTableCreateCompanionBuilder = LocalAttendantsCompanion
    Function({
  Value<int?> id,
  Value<String?> firstName,
  Value<String?> lastName,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> image,
  Value<DateTime?> createdAt,
  Value<int?> isAdmin,
  Value<int?> isSuper,
  Value<int?> isAttendant,
  Value<bool?> setPin,
  Value<String?> link,
});
typedef $$LocalAttendantsTableUpdateCompanionBuilder = LocalAttendantsCompanion
    Function({
  Value<int?> id,
  Value<String?> firstName,
  Value<String?> lastName,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> image,
  Value<DateTime?> createdAt,
  Value<int?> isAdmin,
  Value<int?> isSuper,
  Value<int?> isAttendant,
  Value<bool?> setPin,
  Value<String?> link,
});

class $$LocalAttendantsTableFilterComposer
    extends Composer<_$DatabaseClient, $LocalAttendantsTable> {
  $$LocalAttendantsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isAdmin => $composableBuilder(
      column: $table.isAdmin, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isSuper => $composableBuilder(
      column: $table.isSuper, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isAttendant => $composableBuilder(
      column: $table.isAttendant, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get setPin => $composableBuilder(
      column: $table.setPin, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get link => $composableBuilder(
      column: $table.link, builder: (column) => ColumnFilters(column));
}

class $$LocalAttendantsTableOrderingComposer
    extends Composer<_$DatabaseClient, $LocalAttendantsTable> {
  $$LocalAttendantsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isAdmin => $composableBuilder(
      column: $table.isAdmin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isSuper => $composableBuilder(
      column: $table.isSuper, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isAttendant => $composableBuilder(
      column: $table.isAttendant, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get setPin => $composableBuilder(
      column: $table.setPin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get link => $composableBuilder(
      column: $table.link, builder: (column) => ColumnOrderings(column));
}

class $$LocalAttendantsTableAnnotationComposer
    extends Composer<_$DatabaseClient, $LocalAttendantsTable> {
  $$LocalAttendantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get isAdmin =>
      $composableBuilder(column: $table.isAdmin, builder: (column) => column);

  GeneratedColumn<int> get isSuper =>
      $composableBuilder(column: $table.isSuper, builder: (column) => column);

  GeneratedColumn<int> get isAttendant => $composableBuilder(
      column: $table.isAttendant, builder: (column) => column);

  GeneratedColumn<bool> get setPin =>
      $composableBuilder(column: $table.setPin, builder: (column) => column);

  GeneratedColumn<String> get link =>
      $composableBuilder(column: $table.link, builder: (column) => column);
}

class $$LocalAttendantsTableTableManager extends RootTableManager<
    _$DatabaseClient,
    $LocalAttendantsTable,
    LocalAttendant,
    $$LocalAttendantsTableFilterComposer,
    $$LocalAttendantsTableOrderingComposer,
    $$LocalAttendantsTableAnnotationComposer,
    $$LocalAttendantsTableCreateCompanionBuilder,
    $$LocalAttendantsTableUpdateCompanionBuilder,
    (
      LocalAttendant,
      BaseReferences<_$DatabaseClient, $LocalAttendantsTable, LocalAttendant>
    ),
    LocalAttendant,
    PrefetchHooks Function()> {
  $$LocalAttendantsTableTableManager(
      _$DatabaseClient db, $LocalAttendantsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalAttendantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalAttendantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalAttendantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> firstName = const Value.absent(),
            Value<String?> lastName = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> image = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<int?> isAdmin = const Value.absent(),
            Value<int?> isSuper = const Value.absent(),
            Value<int?> isAttendant = const Value.absent(),
            Value<bool?> setPin = const Value.absent(),
            Value<String?> link = const Value.absent(),
          }) =>
              LocalAttendantsCompanion(
            id: id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            image: image,
            createdAt: createdAt,
            isAdmin: isAdmin,
            isSuper: isSuper,
            isAttendant: isAttendant,
            setPin: setPin,
            link: link,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> firstName = const Value.absent(),
            Value<String?> lastName = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> image = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<int?> isAdmin = const Value.absent(),
            Value<int?> isSuper = const Value.absent(),
            Value<int?> isAttendant = const Value.absent(),
            Value<bool?> setPin = const Value.absent(),
            Value<String?> link = const Value.absent(),
          }) =>
              LocalAttendantsCompanion.insert(
            id: id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            image: image,
            createdAt: createdAt,
            isAdmin: isAdmin,
            isSuper: isSuper,
            isAttendant: isAttendant,
            setPin: setPin,
            link: link,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalAttendantsTableProcessedTableManager = ProcessedTableManager<
    _$DatabaseClient,
    $LocalAttendantsTable,
    LocalAttendant,
    $$LocalAttendantsTableFilterComposer,
    $$LocalAttendantsTableOrderingComposer,
    $$LocalAttendantsTableAnnotationComposer,
    $$LocalAttendantsTableCreateCompanionBuilder,
    $$LocalAttendantsTableUpdateCompanionBuilder,
    (
      LocalAttendant,
      BaseReferences<_$DatabaseClient, $LocalAttendantsTable, LocalAttendant>
    ),
    LocalAttendant,
    PrefetchHooks Function()>;
typedef $$LocalCustomersTableCreateCompanionBuilder = LocalCustomersCompanion
    Function({
  Value<int> id,
  Value<String?> name,
  Value<int?> companyId,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> country,
  Value<String?> city,
  Value<String?> address,
  Value<DateTime?> createdAt,
  Value<String?> link,
  Value<bool> isSynced,
});
typedef $$LocalCustomersTableUpdateCompanionBuilder = LocalCustomersCompanion
    Function({
  Value<int> id,
  Value<String?> name,
  Value<int?> companyId,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> country,
  Value<String?> city,
  Value<String?> address,
  Value<DateTime?> createdAt,
  Value<String?> link,
  Value<bool> isSynced,
});

class $$LocalCustomersTableFilterComposer
    extends Composer<_$DatabaseClient, $LocalCustomersTable> {
  $$LocalCustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get companyId => $composableBuilder(
      column: $table.companyId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get country => $composableBuilder(
      column: $table.country, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get link => $composableBuilder(
      column: $table.link, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$LocalCustomersTableOrderingComposer
    extends Composer<_$DatabaseClient, $LocalCustomersTable> {
  $$LocalCustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get companyId => $composableBuilder(
      column: $table.companyId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get country => $composableBuilder(
      column: $table.country, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get link => $composableBuilder(
      column: $table.link, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$LocalCustomersTableAnnotationComposer
    extends Composer<_$DatabaseClient, $LocalCustomersTable> {
  $$LocalCustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get link =>
      $composableBuilder(column: $table.link, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$LocalCustomersTableTableManager extends RootTableManager<
    _$DatabaseClient,
    $LocalCustomersTable,
    LocalCustomer,
    $$LocalCustomersTableFilterComposer,
    $$LocalCustomersTableOrderingComposer,
    $$LocalCustomersTableAnnotationComposer,
    $$LocalCustomersTableCreateCompanionBuilder,
    $$LocalCustomersTableUpdateCompanionBuilder,
    (
      LocalCustomer,
      BaseReferences<_$DatabaseClient, $LocalCustomersTable, LocalCustomer>
    ),
    LocalCustomer,
    PrefetchHooks Function()> {
  $$LocalCustomersTableTableManager(
      _$DatabaseClient db, $LocalCustomersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalCustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalCustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalCustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<int?> companyId = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> country = const Value.absent(),
            Value<String?> city = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String?> link = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
          }) =>
              LocalCustomersCompanion(
            id: id,
            name: name,
            companyId: companyId,
            email: email,
            phone: phone,
            country: country,
            city: city,
            address: address,
            createdAt: createdAt,
            link: link,
            isSynced: isSynced,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<int?> companyId = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> country = const Value.absent(),
            Value<String?> city = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String?> link = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
          }) =>
              LocalCustomersCompanion.insert(
            id: id,
            name: name,
            companyId: companyId,
            email: email,
            phone: phone,
            country: country,
            city: city,
            address: address,
            createdAt: createdAt,
            link: link,
            isSynced: isSynced,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalCustomersTableProcessedTableManager = ProcessedTableManager<
    _$DatabaseClient,
    $LocalCustomersTable,
    LocalCustomer,
    $$LocalCustomersTableFilterComposer,
    $$LocalCustomersTableOrderingComposer,
    $$LocalCustomersTableAnnotationComposer,
    $$LocalCustomersTableCreateCompanionBuilder,
    $$LocalCustomersTableUpdateCompanionBuilder,
    (
      LocalCustomer,
      BaseReferences<_$DatabaseClient, $LocalCustomersTable, LocalCustomer>
    ),
    LocalCustomer,
    PrefetchHooks Function()>;
typedef $$LocalBarTablesTableCreateCompanionBuilder = LocalBarTablesCompanion
    Function({
  Value<int?> id,
  Value<String?> name,
  Value<int?> companyId,
  Value<int?> chairsNo,
  Value<DateTime?> createdAt,
  Value<String?> link,
});
typedef $$LocalBarTablesTableUpdateCompanionBuilder = LocalBarTablesCompanion
    Function({
  Value<int?> id,
  Value<String?> name,
  Value<int?> companyId,
  Value<int?> chairsNo,
  Value<DateTime?> createdAt,
  Value<String?> link,
});

class $$LocalBarTablesTableFilterComposer
    extends Composer<_$DatabaseClient, $LocalBarTablesTable> {
  $$LocalBarTablesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get companyId => $composableBuilder(
      column: $table.companyId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get chairsNo => $composableBuilder(
      column: $table.chairsNo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get link => $composableBuilder(
      column: $table.link, builder: (column) => ColumnFilters(column));
}

class $$LocalBarTablesTableOrderingComposer
    extends Composer<_$DatabaseClient, $LocalBarTablesTable> {
  $$LocalBarTablesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get companyId => $composableBuilder(
      column: $table.companyId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get chairsNo => $composableBuilder(
      column: $table.chairsNo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get link => $composableBuilder(
      column: $table.link, builder: (column) => ColumnOrderings(column));
}

class $$LocalBarTablesTableAnnotationComposer
    extends Composer<_$DatabaseClient, $LocalBarTablesTable> {
  $$LocalBarTablesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<int> get chairsNo =>
      $composableBuilder(column: $table.chairsNo, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get link =>
      $composableBuilder(column: $table.link, builder: (column) => column);
}

class $$LocalBarTablesTableTableManager extends RootTableManager<
    _$DatabaseClient,
    $LocalBarTablesTable,
    LocalBarTable,
    $$LocalBarTablesTableFilterComposer,
    $$LocalBarTablesTableOrderingComposer,
    $$LocalBarTablesTableAnnotationComposer,
    $$LocalBarTablesTableCreateCompanionBuilder,
    $$LocalBarTablesTableUpdateCompanionBuilder,
    (
      LocalBarTable,
      BaseReferences<_$DatabaseClient, $LocalBarTablesTable, LocalBarTable>
    ),
    LocalBarTable,
    PrefetchHooks Function()> {
  $$LocalBarTablesTableTableManager(
      _$DatabaseClient db, $LocalBarTablesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalBarTablesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalBarTablesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalBarTablesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<int?> companyId = const Value.absent(),
            Value<int?> chairsNo = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String?> link = const Value.absent(),
          }) =>
              LocalBarTablesCompanion(
            id: id,
            name: name,
            companyId: companyId,
            chairsNo: chairsNo,
            createdAt: createdAt,
            link: link,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<int?> companyId = const Value.absent(),
            Value<int?> chairsNo = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String?> link = const Value.absent(),
          }) =>
              LocalBarTablesCompanion.insert(
            id: id,
            name: name,
            companyId: companyId,
            chairsNo: chairsNo,
            createdAt: createdAt,
            link: link,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalBarTablesTableProcessedTableManager = ProcessedTableManager<
    _$DatabaseClient,
    $LocalBarTablesTable,
    LocalBarTable,
    $$LocalBarTablesTableFilterComposer,
    $$LocalBarTablesTableOrderingComposer,
    $$LocalBarTablesTableAnnotationComposer,
    $$LocalBarTablesTableCreateCompanionBuilder,
    $$LocalBarTablesTableUpdateCompanionBuilder,
    (
      LocalBarTable,
      BaseReferences<_$DatabaseClient, $LocalBarTablesTable, LocalBarTable>
    ),
    LocalBarTable,
    PrefetchHooks Function()>;
typedef $$LocalProductCategoriesTableCreateCompanionBuilder
    = LocalProductCategoriesCompanion Function({
  Value<int?> id,
  Value<String?> name,
  Value<int?> companyId,
  Value<String?> image,
  Value<int?> productCount,
  Value<String?> link,
});
typedef $$LocalProductCategoriesTableUpdateCompanionBuilder
    = LocalProductCategoriesCompanion Function({
  Value<int?> id,
  Value<String?> name,
  Value<int?> companyId,
  Value<String?> image,
  Value<int?> productCount,
  Value<String?> link,
});

class $$LocalProductCategoriesTableFilterComposer
    extends Composer<_$DatabaseClient, $LocalProductCategoriesTable> {
  $$LocalProductCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get companyId => $composableBuilder(
      column: $table.companyId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get productCount => $composableBuilder(
      column: $table.productCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get link => $composableBuilder(
      column: $table.link, builder: (column) => ColumnFilters(column));
}

class $$LocalProductCategoriesTableOrderingComposer
    extends Composer<_$DatabaseClient, $LocalProductCategoriesTable> {
  $$LocalProductCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get companyId => $composableBuilder(
      column: $table.companyId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get productCount => $composableBuilder(
      column: $table.productCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get link => $composableBuilder(
      column: $table.link, builder: (column) => ColumnOrderings(column));
}

class $$LocalProductCategoriesTableAnnotationComposer
    extends Composer<_$DatabaseClient, $LocalProductCategoriesTable> {
  $$LocalProductCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<int> get productCount => $composableBuilder(
      column: $table.productCount, builder: (column) => column);

  GeneratedColumn<String> get link =>
      $composableBuilder(column: $table.link, builder: (column) => column);
}

class $$LocalProductCategoriesTableTableManager extends RootTableManager<
    _$DatabaseClient,
    $LocalProductCategoriesTable,
    LocalProductCategory,
    $$LocalProductCategoriesTableFilterComposer,
    $$LocalProductCategoriesTableOrderingComposer,
    $$LocalProductCategoriesTableAnnotationComposer,
    $$LocalProductCategoriesTableCreateCompanionBuilder,
    $$LocalProductCategoriesTableUpdateCompanionBuilder,
    (
      LocalProductCategory,
      BaseReferences<_$DatabaseClient, $LocalProductCategoriesTable,
          LocalProductCategory>
    ),
    LocalProductCategory,
    PrefetchHooks Function()> {
  $$LocalProductCategoriesTableTableManager(
      _$DatabaseClient db, $LocalProductCategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalProductCategoriesTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalProductCategoriesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalProductCategoriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<int?> companyId = const Value.absent(),
            Value<String?> image = const Value.absent(),
            Value<int?> productCount = const Value.absent(),
            Value<String?> link = const Value.absent(),
          }) =>
              LocalProductCategoriesCompanion(
            id: id,
            name: name,
            companyId: companyId,
            image: image,
            productCount: productCount,
            link: link,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<int?> companyId = const Value.absent(),
            Value<String?> image = const Value.absent(),
            Value<int?> productCount = const Value.absent(),
            Value<String?> link = const Value.absent(),
          }) =>
              LocalProductCategoriesCompanion.insert(
            id: id,
            name: name,
            companyId: companyId,
            image: image,
            productCount: productCount,
            link: link,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalProductCategoriesTableProcessedTableManager
    = ProcessedTableManager<
        _$DatabaseClient,
        $LocalProductCategoriesTable,
        LocalProductCategory,
        $$LocalProductCategoriesTableFilterComposer,
        $$LocalProductCategoriesTableOrderingComposer,
        $$LocalProductCategoriesTableAnnotationComposer,
        $$LocalProductCategoriesTableCreateCompanionBuilder,
        $$LocalProductCategoriesTableUpdateCompanionBuilder,
        (
          LocalProductCategory,
          BaseReferences<_$DatabaseClient, $LocalProductCategoriesTable,
              LocalProductCategory>
        ),
        LocalProductCategory,
        PrefetchHooks Function()>;
typedef $$LocalProductsTableCreateCompanionBuilder = LocalProductsCompanion
    Function({
  Value<int?> id,
  Value<String?> name,
  Value<int?> companyId,
  Value<String?> code,
  Value<DateTime?> expiryDate,
  Value<int?> mainProductId,
  Value<int?> productCategoryId,
  Value<double?> productCost,
  Value<double?> productPrice,
  Value<bool?> isActive,
  Value<DateTime?> createdAt,
  Value<int?> inStock,
  Value<String?> link,
  Value<int?> stockId,
  Value<int?> warehouseId,
  Value<String?> brandName,
  Value<String?> productCategoryName,
  Value<String?> stockAlert,
  Value<ProductUnitName?> productUnitName,
  Value<List<ProductWarehouse>?> warehouse,
});
typedef $$LocalProductsTableUpdateCompanionBuilder = LocalProductsCompanion
    Function({
  Value<int?> id,
  Value<String?> name,
  Value<int?> companyId,
  Value<String?> code,
  Value<DateTime?> expiryDate,
  Value<int?> mainProductId,
  Value<int?> productCategoryId,
  Value<double?> productCost,
  Value<double?> productPrice,
  Value<bool?> isActive,
  Value<DateTime?> createdAt,
  Value<int?> inStock,
  Value<String?> link,
  Value<int?> stockId,
  Value<int?> warehouseId,
  Value<String?> brandName,
  Value<String?> productCategoryName,
  Value<String?> stockAlert,
  Value<ProductUnitName?> productUnitName,
  Value<List<ProductWarehouse>?> warehouse,
});

class $$LocalProductsTableFilterComposer
    extends Composer<_$DatabaseClient, $LocalProductsTable> {
  $$LocalProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get companyId => $composableBuilder(
      column: $table.companyId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expiryDate => $composableBuilder(
      column: $table.expiryDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mainProductId => $composableBuilder(
      column: $table.mainProductId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get productCategoryId => $composableBuilder(
      column: $table.productCategoryId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get productCost => $composableBuilder(
      column: $table.productCost, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get productPrice => $composableBuilder(
      column: $table.productPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get inStock => $composableBuilder(
      column: $table.inStock, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get link => $composableBuilder(
      column: $table.link, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stockId => $composableBuilder(
      column: $table.stockId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get warehouseId => $composableBuilder(
      column: $table.warehouseId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get brandName => $composableBuilder(
      column: $table.brandName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get productCategoryName => $composableBuilder(
      column: $table.productCategoryName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stockAlert => $composableBuilder(
      column: $table.stockAlert, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ProductUnitName?, ProductUnitName, String>
      get productUnitName => $composableBuilder(
          column: $table.productUnitName,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<ProductWarehouse>?,
          List<ProductWarehouse>, String>
      get warehouse => $composableBuilder(
          column: $table.warehouse,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$LocalProductsTableOrderingComposer
    extends Composer<_$DatabaseClient, $LocalProductsTable> {
  $$LocalProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get companyId => $composableBuilder(
      column: $table.companyId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expiryDate => $composableBuilder(
      column: $table.expiryDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mainProductId => $composableBuilder(
      column: $table.mainProductId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get productCategoryId => $composableBuilder(
      column: $table.productCategoryId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get productCost => $composableBuilder(
      column: $table.productCost, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get productPrice => $composableBuilder(
      column: $table.productPrice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get inStock => $composableBuilder(
      column: $table.inStock, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get link => $composableBuilder(
      column: $table.link, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stockId => $composableBuilder(
      column: $table.stockId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get warehouseId => $composableBuilder(
      column: $table.warehouseId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get brandName => $composableBuilder(
      column: $table.brandName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productCategoryName => $composableBuilder(
      column: $table.productCategoryName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stockAlert => $composableBuilder(
      column: $table.stockAlert, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productUnitName => $composableBuilder(
      column: $table.productUnitName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get warehouse => $composableBuilder(
      column: $table.warehouse, builder: (column) => ColumnOrderings(column));
}

class $$LocalProductsTableAnnotationComposer
    extends Composer<_$DatabaseClient, $LocalProductsTable> {
  $$LocalProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<DateTime> get expiryDate => $composableBuilder(
      column: $table.expiryDate, builder: (column) => column);

  GeneratedColumn<int> get mainProductId => $composableBuilder(
      column: $table.mainProductId, builder: (column) => column);

  GeneratedColumn<int> get productCategoryId => $composableBuilder(
      column: $table.productCategoryId, builder: (column) => column);

  GeneratedColumn<double> get productCost => $composableBuilder(
      column: $table.productCost, builder: (column) => column);

  GeneratedColumn<double> get productPrice => $composableBuilder(
      column: $table.productPrice, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get inStock =>
      $composableBuilder(column: $table.inStock, builder: (column) => column);

  GeneratedColumn<String> get link =>
      $composableBuilder(column: $table.link, builder: (column) => column);

  GeneratedColumn<int> get stockId =>
      $composableBuilder(column: $table.stockId, builder: (column) => column);

  GeneratedColumn<int> get warehouseId => $composableBuilder(
      column: $table.warehouseId, builder: (column) => column);

  GeneratedColumn<String> get brandName =>
      $composableBuilder(column: $table.brandName, builder: (column) => column);

  GeneratedColumn<String> get productCategoryName => $composableBuilder(
      column: $table.productCategoryName, builder: (column) => column);

  GeneratedColumn<String> get stockAlert => $composableBuilder(
      column: $table.stockAlert, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ProductUnitName?, String>
      get productUnitName => $composableBuilder(
          column: $table.productUnitName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<ProductWarehouse>?, String>
      get warehouse => $composableBuilder(
          column: $table.warehouse, builder: (column) => column);
}

class $$LocalProductsTableTableManager extends RootTableManager<
    _$DatabaseClient,
    $LocalProductsTable,
    LocalProduct,
    $$LocalProductsTableFilterComposer,
    $$LocalProductsTableOrderingComposer,
    $$LocalProductsTableAnnotationComposer,
    $$LocalProductsTableCreateCompanionBuilder,
    $$LocalProductsTableUpdateCompanionBuilder,
    (
      LocalProduct,
      BaseReferences<_$DatabaseClient, $LocalProductsTable, LocalProduct>
    ),
    LocalProduct,
    PrefetchHooks Function()> {
  $$LocalProductsTableTableManager(
      _$DatabaseClient db, $LocalProductsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<int?> companyId = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<DateTime?> expiryDate = const Value.absent(),
            Value<int?> mainProductId = const Value.absent(),
            Value<int?> productCategoryId = const Value.absent(),
            Value<double?> productCost = const Value.absent(),
            Value<double?> productPrice = const Value.absent(),
            Value<bool?> isActive = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<int?> inStock = const Value.absent(),
            Value<String?> link = const Value.absent(),
            Value<int?> stockId = const Value.absent(),
            Value<int?> warehouseId = const Value.absent(),
            Value<String?> brandName = const Value.absent(),
            Value<String?> productCategoryName = const Value.absent(),
            Value<String?> stockAlert = const Value.absent(),
            Value<ProductUnitName?> productUnitName = const Value.absent(),
            Value<List<ProductWarehouse>?> warehouse = const Value.absent(),
          }) =>
              LocalProductsCompanion(
            id: id,
            name: name,
            companyId: companyId,
            code: code,
            expiryDate: expiryDate,
            mainProductId: mainProductId,
            productCategoryId: productCategoryId,
            productCost: productCost,
            productPrice: productPrice,
            isActive: isActive,
            createdAt: createdAt,
            inStock: inStock,
            link: link,
            stockId: stockId,
            warehouseId: warehouseId,
            brandName: brandName,
            productCategoryName: productCategoryName,
            stockAlert: stockAlert,
            productUnitName: productUnitName,
            warehouse: warehouse,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<int?> companyId = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<DateTime?> expiryDate = const Value.absent(),
            Value<int?> mainProductId = const Value.absent(),
            Value<int?> productCategoryId = const Value.absent(),
            Value<double?> productCost = const Value.absent(),
            Value<double?> productPrice = const Value.absent(),
            Value<bool?> isActive = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<int?> inStock = const Value.absent(),
            Value<String?> link = const Value.absent(),
            Value<int?> stockId = const Value.absent(),
            Value<int?> warehouseId = const Value.absent(),
            Value<String?> brandName = const Value.absent(),
            Value<String?> productCategoryName = const Value.absent(),
            Value<String?> stockAlert = const Value.absent(),
            Value<ProductUnitName?> productUnitName = const Value.absent(),
            Value<List<ProductWarehouse>?> warehouse = const Value.absent(),
          }) =>
              LocalProductsCompanion.insert(
            id: id,
            name: name,
            companyId: companyId,
            code: code,
            expiryDate: expiryDate,
            mainProductId: mainProductId,
            productCategoryId: productCategoryId,
            productCost: productCost,
            productPrice: productPrice,
            isActive: isActive,
            createdAt: createdAt,
            inStock: inStock,
            link: link,
            stockId: stockId,
            warehouseId: warehouseId,
            brandName: brandName,
            productCategoryName: productCategoryName,
            stockAlert: stockAlert,
            productUnitName: productUnitName,
            warehouse: warehouse,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalProductsTableProcessedTableManager = ProcessedTableManager<
    _$DatabaseClient,
    $LocalProductsTable,
    LocalProduct,
    $$LocalProductsTableFilterComposer,
    $$LocalProductsTableOrderingComposer,
    $$LocalProductsTableAnnotationComposer,
    $$LocalProductsTableCreateCompanionBuilder,
    $$LocalProductsTableUpdateCompanionBuilder,
    (
      LocalProduct,
      BaseReferences<_$DatabaseClient, $LocalProductsTable, LocalProduct>
    ),
    LocalProduct,
    PrefetchHooks Function()>;
typedef $$LocalWarehousesTableCreateCompanionBuilder = LocalWarehousesCompanion
    Function({
  Value<int?> id,
  Value<String?> name,
  Value<String?> phone,
  Value<String?> country,
  Value<String?> city,
  Value<String?> email,
  Value<String?> zipCode,
  Value<int?> status,
  Value<int?> companyId,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$LocalWarehousesTableUpdateCompanionBuilder = LocalWarehousesCompanion
    Function({
  Value<int?> id,
  Value<String?> name,
  Value<String?> phone,
  Value<String?> country,
  Value<String?> city,
  Value<String?> email,
  Value<String?> zipCode,
  Value<int?> status,
  Value<int?> companyId,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
});

class $$LocalWarehousesTableFilterComposer
    extends Composer<_$DatabaseClient, $LocalWarehousesTable> {
  $$LocalWarehousesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get country => $composableBuilder(
      column: $table.country, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get zipCode => $composableBuilder(
      column: $table.zipCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get companyId => $composableBuilder(
      column: $table.companyId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$LocalWarehousesTableOrderingComposer
    extends Composer<_$DatabaseClient, $LocalWarehousesTable> {
  $$LocalWarehousesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get country => $composableBuilder(
      column: $table.country, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get zipCode => $composableBuilder(
      column: $table.zipCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get companyId => $composableBuilder(
      column: $table.companyId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$LocalWarehousesTableAnnotationComposer
    extends Composer<_$DatabaseClient, $LocalWarehousesTable> {
  $$LocalWarehousesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get zipCode =>
      $composableBuilder(column: $table.zipCode, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalWarehousesTableTableManager extends RootTableManager<
    _$DatabaseClient,
    $LocalWarehousesTable,
    LocalWarehouse,
    $$LocalWarehousesTableFilterComposer,
    $$LocalWarehousesTableOrderingComposer,
    $$LocalWarehousesTableAnnotationComposer,
    $$LocalWarehousesTableCreateCompanionBuilder,
    $$LocalWarehousesTableUpdateCompanionBuilder,
    (
      LocalWarehouse,
      BaseReferences<_$DatabaseClient, $LocalWarehousesTable, LocalWarehouse>
    ),
    LocalWarehouse,
    PrefetchHooks Function()> {
  $$LocalWarehousesTableTableManager(
      _$DatabaseClient db, $LocalWarehousesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalWarehousesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalWarehousesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalWarehousesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> country = const Value.absent(),
            Value<String?> city = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> zipCode = const Value.absent(),
            Value<int?> status = const Value.absent(),
            Value<int?> companyId = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              LocalWarehousesCompanion(
            id: id,
            name: name,
            phone: phone,
            country: country,
            city: city,
            email: email,
            zipCode: zipCode,
            status: status,
            companyId: companyId,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> country = const Value.absent(),
            Value<String?> city = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> zipCode = const Value.absent(),
            Value<int?> status = const Value.absent(),
            Value<int?> companyId = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              LocalWarehousesCompanion.insert(
            id: id,
            name: name,
            phone: phone,
            country: country,
            city: city,
            email: email,
            zipCode: zipCode,
            status: status,
            companyId: companyId,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalWarehousesTableProcessedTableManager = ProcessedTableManager<
    _$DatabaseClient,
    $LocalWarehousesTable,
    LocalWarehouse,
    $$LocalWarehousesTableFilterComposer,
    $$LocalWarehousesTableOrderingComposer,
    $$LocalWarehousesTableAnnotationComposer,
    $$LocalWarehousesTableCreateCompanionBuilder,
    $$LocalWarehousesTableUpdateCompanionBuilder,
    (
      LocalWarehouse,
      BaseReferences<_$DatabaseClient, $LocalWarehousesTable, LocalWarehouse>
    ),
    LocalWarehouse,
    PrefetchHooks Function()>;
typedef $$LocalRegistersTableCreateCompanionBuilder = LocalRegistersCompanion
    Function({
  Value<int> id,
  Value<DateTime?> createdAt,
  Value<DateTime?> closedAt,
  Value<double?> openingCashAtHand,
  Value<double?> cashInHandWhileClosing,
  Value<String?> note,
  Value<SpotstockUser?> user,
  Value<bool> isSynced,
});
typedef $$LocalRegistersTableUpdateCompanionBuilder = LocalRegistersCompanion
    Function({
  Value<int> id,
  Value<DateTime?> createdAt,
  Value<DateTime?> closedAt,
  Value<double?> openingCashAtHand,
  Value<double?> cashInHandWhileClosing,
  Value<String?> note,
  Value<SpotstockUser?> user,
  Value<bool> isSynced,
});

class $$LocalRegistersTableFilterComposer
    extends Composer<_$DatabaseClient, $LocalRegistersTable> {
  $$LocalRegistersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get closedAt => $composableBuilder(
      column: $table.closedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get openingCashAtHand => $composableBuilder(
      column: $table.openingCashAtHand,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get cashInHandWhileClosing => $composableBuilder(
      column: $table.cashInHandWhileClosing,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<SpotstockUser?, SpotstockUser, String>
      get user => $composableBuilder(
          column: $table.user,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$LocalRegistersTableOrderingComposer
    extends Composer<_$DatabaseClient, $LocalRegistersTable> {
  $$LocalRegistersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get closedAt => $composableBuilder(
      column: $table.closedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get openingCashAtHand => $composableBuilder(
      column: $table.openingCashAtHand,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get cashInHandWhileClosing => $composableBuilder(
      column: $table.cashInHandWhileClosing,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get user => $composableBuilder(
      column: $table.user, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$LocalRegistersTableAnnotationComposer
    extends Composer<_$DatabaseClient, $LocalRegistersTable> {
  $$LocalRegistersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get closedAt =>
      $composableBuilder(column: $table.closedAt, builder: (column) => column);

  GeneratedColumn<double> get openingCashAtHand => $composableBuilder(
      column: $table.openingCashAtHand, builder: (column) => column);

  GeneratedColumn<double> get cashInHandWhileClosing => $composableBuilder(
      column: $table.cashInHandWhileClosing, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SpotstockUser?, String> get user =>
      $composableBuilder(column: $table.user, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$LocalRegistersTableTableManager extends RootTableManager<
    _$DatabaseClient,
    $LocalRegistersTable,
    LocalRegister,
    $$LocalRegistersTableFilterComposer,
    $$LocalRegistersTableOrderingComposer,
    $$LocalRegistersTableAnnotationComposer,
    $$LocalRegistersTableCreateCompanionBuilder,
    $$LocalRegistersTableUpdateCompanionBuilder,
    (
      LocalRegister,
      BaseReferences<_$DatabaseClient, $LocalRegistersTable, LocalRegister>
    ),
    LocalRegister,
    PrefetchHooks Function()> {
  $$LocalRegistersTableTableManager(
      _$DatabaseClient db, $LocalRegistersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalRegistersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalRegistersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalRegistersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> closedAt = const Value.absent(),
            Value<double?> openingCashAtHand = const Value.absent(),
            Value<double?> cashInHandWhileClosing = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<SpotstockUser?> user = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
          }) =>
              LocalRegistersCompanion(
            id: id,
            createdAt: createdAt,
            closedAt: closedAt,
            openingCashAtHand: openingCashAtHand,
            cashInHandWhileClosing: cashInHandWhileClosing,
            note: note,
            user: user,
            isSynced: isSynced,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> closedAt = const Value.absent(),
            Value<double?> openingCashAtHand = const Value.absent(),
            Value<double?> cashInHandWhileClosing = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<SpotstockUser?> user = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
          }) =>
              LocalRegistersCompanion.insert(
            id: id,
            createdAt: createdAt,
            closedAt: closedAt,
            openingCashAtHand: openingCashAtHand,
            cashInHandWhileClosing: cashInHandWhileClosing,
            note: note,
            user: user,
            isSynced: isSynced,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalRegistersTableProcessedTableManager = ProcessedTableManager<
    _$DatabaseClient,
    $LocalRegistersTable,
    LocalRegister,
    $$LocalRegistersTableFilterComposer,
    $$LocalRegistersTableOrderingComposer,
    $$LocalRegistersTableAnnotationComposer,
    $$LocalRegistersTableCreateCompanionBuilder,
    $$LocalRegistersTableUpdateCompanionBuilder,
    (
      LocalRegister,
      BaseReferences<_$DatabaseClient, $LocalRegistersTable, LocalRegister>
    ),
    LocalRegister,
    PrefetchHooks Function()>;
typedef $$LocalSalesTableCreateCompanionBuilder = LocalSalesCompanion Function({
  Value<int> id,
  Value<int?> remoteId,
  Value<String?> type,
  Value<Map<String, dynamic>?> links,
  Value<DateTime?> date,
  Value<int?> isReturn,
  Value<int?> customerId,
  Value<int?> companyId,
  Value<SaleLoggedUser?> loggedUser,
  Value<String?> customerName,
  Value<String?> staffName,
  Value<int?> warehouseId,
  Value<String?> warehouseName,
  Value<double?> taxRate,
  Value<double?> taxAmount,
  Value<double?> discount,
  Value<double?> discountAmount,
  Value<double?> shipping,
  Value<double?> grandTotal,
  Value<double?> receivedAmount,
  Value<double?> paidAmount,
  Value<double?> partialAmount,
  Value<double?> dueAmount,
  Value<int?> paymentType,
  Value<String?> note,
  Value<int?> status,
  Value<int?> paymentStatus,
  Value<String?> referenceCode,
  Value<List<SaleItem>?> saleItems,
  Value<List<SalePayment>?> payments,
  Value<List<String>?> paymentMethods,
  Value<DateTime?> createdAt,
  Value<String?> barcodeUrl,
  Value<bool> isOffline,
  Value<String?> offlineCustomerName,
  Value<int?> staffId,
  Value<String?> attendantName,
  Value<int?> attendantId,
  Value<Map<String, dynamic>?> roomDetails,
  Value<double?> partialPaymentAmount,
  Value<String?> partialPaymentMethod,
  Value<bool> isSynced,
  Value<DateTime?> lastSyncedAt,
  Value<DateTime?> createdLocallyAt,
});
typedef $$LocalSalesTableUpdateCompanionBuilder = LocalSalesCompanion Function({
  Value<int> id,
  Value<int?> remoteId,
  Value<String?> type,
  Value<Map<String, dynamic>?> links,
  Value<DateTime?> date,
  Value<int?> isReturn,
  Value<int?> customerId,
  Value<int?> companyId,
  Value<SaleLoggedUser?> loggedUser,
  Value<String?> customerName,
  Value<String?> staffName,
  Value<int?> warehouseId,
  Value<String?> warehouseName,
  Value<double?> taxRate,
  Value<double?> taxAmount,
  Value<double?> discount,
  Value<double?> discountAmount,
  Value<double?> shipping,
  Value<double?> grandTotal,
  Value<double?> receivedAmount,
  Value<double?> paidAmount,
  Value<double?> partialAmount,
  Value<double?> dueAmount,
  Value<int?> paymentType,
  Value<String?> note,
  Value<int?> status,
  Value<int?> paymentStatus,
  Value<String?> referenceCode,
  Value<List<SaleItem>?> saleItems,
  Value<List<SalePayment>?> payments,
  Value<List<String>?> paymentMethods,
  Value<DateTime?> createdAt,
  Value<String?> barcodeUrl,
  Value<bool> isOffline,
  Value<String?> offlineCustomerName,
  Value<int?> staffId,
  Value<String?> attendantName,
  Value<int?> attendantId,
  Value<Map<String, dynamic>?> roomDetails,
  Value<double?> partialPaymentAmount,
  Value<String?> partialPaymentMethod,
  Value<bool> isSynced,
  Value<DateTime?> lastSyncedAt,
  Value<DateTime?> createdLocallyAt,
});

class $$LocalSalesTableFilterComposer
    extends Composer<_$DatabaseClient, $LocalSalesTable> {
  $$LocalSalesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, dynamic>?, Map<String, dynamic>,
          String>
      get links => $composableBuilder(
          column: $table.links,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isReturn => $composableBuilder(
      column: $table.isReturn, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get customerId => $composableBuilder(
      column: $table.customerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get companyId => $composableBuilder(
      column: $table.companyId, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<SaleLoggedUser?, SaleLoggedUser, String>
      get loggedUser => $composableBuilder(
          column: $table.loggedUser,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get customerName => $composableBuilder(
      column: $table.customerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get staffName => $composableBuilder(
      column: $table.staffName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get warehouseId => $composableBuilder(
      column: $table.warehouseId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get warehouseName => $composableBuilder(
      column: $table.warehouseName, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get taxRate => $composableBuilder(
      column: $table.taxRate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get taxAmount => $composableBuilder(
      column: $table.taxAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get discount => $composableBuilder(
      column: $table.discount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get discountAmount => $composableBuilder(
      column: $table.discountAmount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get shipping => $composableBuilder(
      column: $table.shipping, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get grandTotal => $composableBuilder(
      column: $table.grandTotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get receivedAmount => $composableBuilder(
      column: $table.receivedAmount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get paidAmount => $composableBuilder(
      column: $table.paidAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get partialAmount => $composableBuilder(
      column: $table.partialAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get dueAmount => $composableBuilder(
      column: $table.dueAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get paymentType => $composableBuilder(
      column: $table.paymentType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get paymentStatus => $composableBuilder(
      column: $table.paymentStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get referenceCode => $composableBuilder(
      column: $table.referenceCode, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<SaleItem>?, List<SaleItem>, String>
      get saleItems => $composableBuilder(
          column: $table.saleItems,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<SalePayment>?, List<SalePayment>, String>
      get payments => $composableBuilder(
          column: $table.payments,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
      get paymentMethods => $composableBuilder(
          column: $table.paymentMethods,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get barcodeUrl => $composableBuilder(
      column: $table.barcodeUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isOffline => $composableBuilder(
      column: $table.isOffline, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get offlineCustomerName => $composableBuilder(
      column: $table.offlineCustomerName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get staffId => $composableBuilder(
      column: $table.staffId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get attendantName => $composableBuilder(
      column: $table.attendantName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attendantId => $composableBuilder(
      column: $table.attendantId, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, dynamic>?, Map<String, dynamic>,
          String>
      get roomDetails => $composableBuilder(
          column: $table.roomDetails,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get partialPaymentAmount => $composableBuilder(
      column: $table.partialPaymentAmount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get partialPaymentMethod => $composableBuilder(
      column: $table.partialPaymentMethod,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdLocallyAt => $composableBuilder(
      column: $table.createdLocallyAt,
      builder: (column) => ColumnFilters(column));
}

class $$LocalSalesTableOrderingComposer
    extends Composer<_$DatabaseClient, $LocalSalesTable> {
  $$LocalSalesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get links => $composableBuilder(
      column: $table.links, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isReturn => $composableBuilder(
      column: $table.isReturn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get customerId => $composableBuilder(
      column: $table.customerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get companyId => $composableBuilder(
      column: $table.companyId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get loggedUser => $composableBuilder(
      column: $table.loggedUser, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customerName => $composableBuilder(
      column: $table.customerName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get staffName => $composableBuilder(
      column: $table.staffName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get warehouseId => $composableBuilder(
      column: $table.warehouseId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get warehouseName => $composableBuilder(
      column: $table.warehouseName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get taxRate => $composableBuilder(
      column: $table.taxRate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get taxAmount => $composableBuilder(
      column: $table.taxAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get discount => $composableBuilder(
      column: $table.discount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get discountAmount => $composableBuilder(
      column: $table.discountAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get shipping => $composableBuilder(
      column: $table.shipping, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get grandTotal => $composableBuilder(
      column: $table.grandTotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get receivedAmount => $composableBuilder(
      column: $table.receivedAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get paidAmount => $composableBuilder(
      column: $table.paidAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get partialAmount => $composableBuilder(
      column: $table.partialAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get dueAmount => $composableBuilder(
      column: $table.dueAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get paymentType => $composableBuilder(
      column: $table.paymentType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get paymentStatus => $composableBuilder(
      column: $table.paymentStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get referenceCode => $composableBuilder(
      column: $table.referenceCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get saleItems => $composableBuilder(
      column: $table.saleItems, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payments => $composableBuilder(
      column: $table.payments, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentMethods => $composableBuilder(
      column: $table.paymentMethods,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get barcodeUrl => $composableBuilder(
      column: $table.barcodeUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isOffline => $composableBuilder(
      column: $table.isOffline, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get offlineCustomerName => $composableBuilder(
      column: $table.offlineCustomerName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get staffId => $composableBuilder(
      column: $table.staffId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get attendantName => $composableBuilder(
      column: $table.attendantName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attendantId => $composableBuilder(
      column: $table.attendantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get roomDetails => $composableBuilder(
      column: $table.roomDetails, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get partialPaymentAmount => $composableBuilder(
      column: $table.partialPaymentAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get partialPaymentMethod => $composableBuilder(
      column: $table.partialPaymentMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdLocallyAt => $composableBuilder(
      column: $table.createdLocallyAt,
      builder: (column) => ColumnOrderings(column));
}

class $$LocalSalesTableAnnotationComposer
    extends Composer<_$DatabaseClient, $LocalSalesTable> {
  $$LocalSalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String> get links =>
      $composableBuilder(column: $table.links, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get isReturn =>
      $composableBuilder(column: $table.isReturn, builder: (column) => column);

  GeneratedColumn<int> get customerId => $composableBuilder(
      column: $table.customerId, builder: (column) => column);

  GeneratedColumn<int> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SaleLoggedUser?, String> get loggedUser =>
      $composableBuilder(
          column: $table.loggedUser, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
      column: $table.customerName, builder: (column) => column);

  GeneratedColumn<String> get staffName =>
      $composableBuilder(column: $table.staffName, builder: (column) => column);

  GeneratedColumn<int> get warehouseId => $composableBuilder(
      column: $table.warehouseId, builder: (column) => column);

  GeneratedColumn<String> get warehouseName => $composableBuilder(
      column: $table.warehouseName, builder: (column) => column);

  GeneratedColumn<double> get taxRate =>
      $composableBuilder(column: $table.taxRate, builder: (column) => column);

  GeneratedColumn<double> get taxAmount =>
      $composableBuilder(column: $table.taxAmount, builder: (column) => column);

  GeneratedColumn<double> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<double> get discountAmount => $composableBuilder(
      column: $table.discountAmount, builder: (column) => column);

  GeneratedColumn<double> get shipping =>
      $composableBuilder(column: $table.shipping, builder: (column) => column);

  GeneratedColumn<double> get grandTotal => $composableBuilder(
      column: $table.grandTotal, builder: (column) => column);

  GeneratedColumn<double> get receivedAmount => $composableBuilder(
      column: $table.receivedAmount, builder: (column) => column);

  GeneratedColumn<double> get paidAmount => $composableBuilder(
      column: $table.paidAmount, builder: (column) => column);

  GeneratedColumn<double> get partialAmount => $composableBuilder(
      column: $table.partialAmount, builder: (column) => column);

  GeneratedColumn<double> get dueAmount =>
      $composableBuilder(column: $table.dueAmount, builder: (column) => column);

  GeneratedColumn<int> get paymentType => $composableBuilder(
      column: $table.paymentType, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get paymentStatus => $composableBuilder(
      column: $table.paymentStatus, builder: (column) => column);

  GeneratedColumn<String> get referenceCode => $composableBuilder(
      column: $table.referenceCode, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<SaleItem>?, String> get saleItems =>
      $composableBuilder(column: $table.saleItems, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<SalePayment>?, String> get payments =>
      $composableBuilder(column: $table.payments, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>?, String> get paymentMethods =>
      $composableBuilder(
          column: $table.paymentMethods, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get barcodeUrl => $composableBuilder(
      column: $table.barcodeUrl, builder: (column) => column);

  GeneratedColumn<bool> get isOffline =>
      $composableBuilder(column: $table.isOffline, builder: (column) => column);

  GeneratedColumn<String> get offlineCustomerName => $composableBuilder(
      column: $table.offlineCustomerName, builder: (column) => column);

  GeneratedColumn<int> get staffId =>
      $composableBuilder(column: $table.staffId, builder: (column) => column);

  GeneratedColumn<String> get attendantName => $composableBuilder(
      column: $table.attendantName, builder: (column) => column);

  GeneratedColumn<int> get attendantId => $composableBuilder(
      column: $table.attendantId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      get roomDetails => $composableBuilder(
          column: $table.roomDetails, builder: (column) => column);

  GeneratedColumn<double> get partialPaymentAmount => $composableBuilder(
      column: $table.partialPaymentAmount, builder: (column) => column);

  GeneratedColumn<String> get partialPaymentMethod => $composableBuilder(
      column: $table.partialPaymentMethod, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdLocallyAt => $composableBuilder(
      column: $table.createdLocallyAt, builder: (column) => column);
}

class $$LocalSalesTableTableManager extends RootTableManager<
    _$DatabaseClient,
    $LocalSalesTable,
    LocalSale,
    $$LocalSalesTableFilterComposer,
    $$LocalSalesTableOrderingComposer,
    $$LocalSalesTableAnnotationComposer,
    $$LocalSalesTableCreateCompanionBuilder,
    $$LocalSalesTableUpdateCompanionBuilder,
    (LocalSale, BaseReferences<_$DatabaseClient, $LocalSalesTable, LocalSale>),
    LocalSale,
    PrefetchHooks Function()> {
  $$LocalSalesTableTableManager(_$DatabaseClient db, $LocalSalesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalSalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalSalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalSalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> remoteId = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<Map<String, dynamic>?> links = const Value.absent(),
            Value<DateTime?> date = const Value.absent(),
            Value<int?> isReturn = const Value.absent(),
            Value<int?> customerId = const Value.absent(),
            Value<int?> companyId = const Value.absent(),
            Value<SaleLoggedUser?> loggedUser = const Value.absent(),
            Value<String?> customerName = const Value.absent(),
            Value<String?> staffName = const Value.absent(),
            Value<int?> warehouseId = const Value.absent(),
            Value<String?> warehouseName = const Value.absent(),
            Value<double?> taxRate = const Value.absent(),
            Value<double?> taxAmount = const Value.absent(),
            Value<double?> discount = const Value.absent(),
            Value<double?> discountAmount = const Value.absent(),
            Value<double?> shipping = const Value.absent(),
            Value<double?> grandTotal = const Value.absent(),
            Value<double?> receivedAmount = const Value.absent(),
            Value<double?> paidAmount = const Value.absent(),
            Value<double?> partialAmount = const Value.absent(),
            Value<double?> dueAmount = const Value.absent(),
            Value<int?> paymentType = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int?> status = const Value.absent(),
            Value<int?> paymentStatus = const Value.absent(),
            Value<String?> referenceCode = const Value.absent(),
            Value<List<SaleItem>?> saleItems = const Value.absent(),
            Value<List<SalePayment>?> payments = const Value.absent(),
            Value<List<String>?> paymentMethods = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String?> barcodeUrl = const Value.absent(),
            Value<bool> isOffline = const Value.absent(),
            Value<String?> offlineCustomerName = const Value.absent(),
            Value<int?> staffId = const Value.absent(),
            Value<String?> attendantName = const Value.absent(),
            Value<int?> attendantId = const Value.absent(),
            Value<Map<String, dynamic>?> roomDetails = const Value.absent(),
            Value<double?> partialPaymentAmount = const Value.absent(),
            Value<String?> partialPaymentMethod = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<DateTime?> createdLocallyAt = const Value.absent(),
          }) =>
              LocalSalesCompanion(
            id: id,
            remoteId: remoteId,
            type: type,
            links: links,
            date: date,
            isReturn: isReturn,
            customerId: customerId,
            companyId: companyId,
            loggedUser: loggedUser,
            customerName: customerName,
            staffName: staffName,
            warehouseId: warehouseId,
            warehouseName: warehouseName,
            taxRate: taxRate,
            taxAmount: taxAmount,
            discount: discount,
            discountAmount: discountAmount,
            shipping: shipping,
            grandTotal: grandTotal,
            receivedAmount: receivedAmount,
            paidAmount: paidAmount,
            partialAmount: partialAmount,
            dueAmount: dueAmount,
            paymentType: paymentType,
            note: note,
            status: status,
            paymentStatus: paymentStatus,
            referenceCode: referenceCode,
            saleItems: saleItems,
            payments: payments,
            paymentMethods: paymentMethods,
            createdAt: createdAt,
            barcodeUrl: barcodeUrl,
            isOffline: isOffline,
            offlineCustomerName: offlineCustomerName,
            staffId: staffId,
            attendantName: attendantName,
            attendantId: attendantId,
            roomDetails: roomDetails,
            partialPaymentAmount: partialPaymentAmount,
            partialPaymentMethod: partialPaymentMethod,
            isSynced: isSynced,
            lastSyncedAt: lastSyncedAt,
            createdLocallyAt: createdLocallyAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> remoteId = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<Map<String, dynamic>?> links = const Value.absent(),
            Value<DateTime?> date = const Value.absent(),
            Value<int?> isReturn = const Value.absent(),
            Value<int?> customerId = const Value.absent(),
            Value<int?> companyId = const Value.absent(),
            Value<SaleLoggedUser?> loggedUser = const Value.absent(),
            Value<String?> customerName = const Value.absent(),
            Value<String?> staffName = const Value.absent(),
            Value<int?> warehouseId = const Value.absent(),
            Value<String?> warehouseName = const Value.absent(),
            Value<double?> taxRate = const Value.absent(),
            Value<double?> taxAmount = const Value.absent(),
            Value<double?> discount = const Value.absent(),
            Value<double?> discountAmount = const Value.absent(),
            Value<double?> shipping = const Value.absent(),
            Value<double?> grandTotal = const Value.absent(),
            Value<double?> receivedAmount = const Value.absent(),
            Value<double?> paidAmount = const Value.absent(),
            Value<double?> partialAmount = const Value.absent(),
            Value<double?> dueAmount = const Value.absent(),
            Value<int?> paymentType = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int?> status = const Value.absent(),
            Value<int?> paymentStatus = const Value.absent(),
            Value<String?> referenceCode = const Value.absent(),
            Value<List<SaleItem>?> saleItems = const Value.absent(),
            Value<List<SalePayment>?> payments = const Value.absent(),
            Value<List<String>?> paymentMethods = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String?> barcodeUrl = const Value.absent(),
            Value<bool> isOffline = const Value.absent(),
            Value<String?> offlineCustomerName = const Value.absent(),
            Value<int?> staffId = const Value.absent(),
            Value<String?> attendantName = const Value.absent(),
            Value<int?> attendantId = const Value.absent(),
            Value<Map<String, dynamic>?> roomDetails = const Value.absent(),
            Value<double?> partialPaymentAmount = const Value.absent(),
            Value<String?> partialPaymentMethod = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<DateTime?> createdLocallyAt = const Value.absent(),
          }) =>
              LocalSalesCompanion.insert(
            id: id,
            remoteId: remoteId,
            type: type,
            links: links,
            date: date,
            isReturn: isReturn,
            customerId: customerId,
            companyId: companyId,
            loggedUser: loggedUser,
            customerName: customerName,
            staffName: staffName,
            warehouseId: warehouseId,
            warehouseName: warehouseName,
            taxRate: taxRate,
            taxAmount: taxAmount,
            discount: discount,
            discountAmount: discountAmount,
            shipping: shipping,
            grandTotal: grandTotal,
            receivedAmount: receivedAmount,
            paidAmount: paidAmount,
            partialAmount: partialAmount,
            dueAmount: dueAmount,
            paymentType: paymentType,
            note: note,
            status: status,
            paymentStatus: paymentStatus,
            referenceCode: referenceCode,
            saleItems: saleItems,
            payments: payments,
            paymentMethods: paymentMethods,
            createdAt: createdAt,
            barcodeUrl: barcodeUrl,
            isOffline: isOffline,
            offlineCustomerName: offlineCustomerName,
            staffId: staffId,
            attendantName: attendantName,
            attendantId: attendantId,
            roomDetails: roomDetails,
            partialPaymentAmount: partialPaymentAmount,
            partialPaymentMethod: partialPaymentMethod,
            isSynced: isSynced,
            lastSyncedAt: lastSyncedAt,
            createdLocallyAt: createdLocallyAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalSalesTableProcessedTableManager = ProcessedTableManager<
    _$DatabaseClient,
    $LocalSalesTable,
    LocalSale,
    $$LocalSalesTableFilterComposer,
    $$LocalSalesTableOrderingComposer,
    $$LocalSalesTableAnnotationComposer,
    $$LocalSalesTableCreateCompanionBuilder,
    $$LocalSalesTableUpdateCompanionBuilder,
    (LocalSale, BaseReferences<_$DatabaseClient, $LocalSalesTable, LocalSale>),
    LocalSale,
    PrefetchHooks Function()>;
typedef $$LocalHoldsTableCreateCompanionBuilder = LocalHoldsCompanion Function({
  Value<int> id,
  Value<int?> remoteId,
  Value<String?> type,
  Value<Map<String, dynamic>?> links,
  Value<DateTime?> date,
  Value<int?> userId,
  Value<HoldAttendant?> attendant,
  Value<int?> customerId,
  Value<String?> customerName,
  Value<int?> staffId,
  Value<String?> staffName,
  Value<int?> warehouseId,
  Value<String?> warehouseName,
  Value<double?> taxRate,
  Value<double?> taxAmount,
  Value<double?> discount,
  Value<double?> shipping,
  Value<double?> grandTotal,
  Value<double?> receivedAmount,
  Value<double?> paidAmount,
  Value<String?> referenceCode,
  Value<String?> note,
  Value<String?> status,
  Value<String?> tableId,
  Value<String?> holdTableName,
  Value<List<HoldItem>?> holdItems,
  Value<DateTime?> createdAt,
  Value<bool> isSynced,
  Value<DateTime?> lastSyncedAt,
  Value<DateTime?> createdLocallyAt,
});
typedef $$LocalHoldsTableUpdateCompanionBuilder = LocalHoldsCompanion Function({
  Value<int> id,
  Value<int?> remoteId,
  Value<String?> type,
  Value<Map<String, dynamic>?> links,
  Value<DateTime?> date,
  Value<int?> userId,
  Value<HoldAttendant?> attendant,
  Value<int?> customerId,
  Value<String?> customerName,
  Value<int?> staffId,
  Value<String?> staffName,
  Value<int?> warehouseId,
  Value<String?> warehouseName,
  Value<double?> taxRate,
  Value<double?> taxAmount,
  Value<double?> discount,
  Value<double?> shipping,
  Value<double?> grandTotal,
  Value<double?> receivedAmount,
  Value<double?> paidAmount,
  Value<String?> referenceCode,
  Value<String?> note,
  Value<String?> status,
  Value<String?> tableId,
  Value<String?> holdTableName,
  Value<List<HoldItem>?> holdItems,
  Value<DateTime?> createdAt,
  Value<bool> isSynced,
  Value<DateTime?> lastSyncedAt,
  Value<DateTime?> createdLocallyAt,
});

class $$LocalHoldsTableFilterComposer
    extends Composer<_$DatabaseClient, $LocalHoldsTable> {
  $$LocalHoldsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, dynamic>?, Map<String, dynamic>,
          String>
      get links => $composableBuilder(
          column: $table.links,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<HoldAttendant?, HoldAttendant, String>
      get attendant => $composableBuilder(
          column: $table.attendant,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get customerId => $composableBuilder(
      column: $table.customerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customerName => $composableBuilder(
      column: $table.customerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get staffId => $composableBuilder(
      column: $table.staffId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get staffName => $composableBuilder(
      column: $table.staffName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get warehouseId => $composableBuilder(
      column: $table.warehouseId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get warehouseName => $composableBuilder(
      column: $table.warehouseName, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get taxRate => $composableBuilder(
      column: $table.taxRate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get taxAmount => $composableBuilder(
      column: $table.taxAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get discount => $composableBuilder(
      column: $table.discount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get shipping => $composableBuilder(
      column: $table.shipping, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get grandTotal => $composableBuilder(
      column: $table.grandTotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get receivedAmount => $composableBuilder(
      column: $table.receivedAmount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get paidAmount => $composableBuilder(
      column: $table.paidAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get referenceCode => $composableBuilder(
      column: $table.referenceCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tableId => $composableBuilder(
      column: $table.tableId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get holdTableName => $composableBuilder(
      column: $table.holdTableName, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<HoldItem>?, List<HoldItem>, String>
      get holdItems => $composableBuilder(
          column: $table.holdItems,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdLocallyAt => $composableBuilder(
      column: $table.createdLocallyAt,
      builder: (column) => ColumnFilters(column));
}

class $$LocalHoldsTableOrderingComposer
    extends Composer<_$DatabaseClient, $LocalHoldsTable> {
  $$LocalHoldsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get links => $composableBuilder(
      column: $table.links, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get attendant => $composableBuilder(
      column: $table.attendant, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get customerId => $composableBuilder(
      column: $table.customerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customerName => $composableBuilder(
      column: $table.customerName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get staffId => $composableBuilder(
      column: $table.staffId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get staffName => $composableBuilder(
      column: $table.staffName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get warehouseId => $composableBuilder(
      column: $table.warehouseId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get warehouseName => $composableBuilder(
      column: $table.warehouseName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get taxRate => $composableBuilder(
      column: $table.taxRate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get taxAmount => $composableBuilder(
      column: $table.taxAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get discount => $composableBuilder(
      column: $table.discount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get shipping => $composableBuilder(
      column: $table.shipping, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get grandTotal => $composableBuilder(
      column: $table.grandTotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get receivedAmount => $composableBuilder(
      column: $table.receivedAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get paidAmount => $composableBuilder(
      column: $table.paidAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get referenceCode => $composableBuilder(
      column: $table.referenceCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tableId => $composableBuilder(
      column: $table.tableId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get holdTableName => $composableBuilder(
      column: $table.holdTableName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get holdItems => $composableBuilder(
      column: $table.holdItems, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdLocallyAt => $composableBuilder(
      column: $table.createdLocallyAt,
      builder: (column) => ColumnOrderings(column));
}

class $$LocalHoldsTableAnnotationComposer
    extends Composer<_$DatabaseClient, $LocalHoldsTable> {
  $$LocalHoldsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String> get links =>
      $composableBuilder(column: $table.links, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<HoldAttendant?, String> get attendant =>
      $composableBuilder(column: $table.attendant, builder: (column) => column);

  GeneratedColumn<int> get customerId => $composableBuilder(
      column: $table.customerId, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
      column: $table.customerName, builder: (column) => column);

  GeneratedColumn<int> get staffId =>
      $composableBuilder(column: $table.staffId, builder: (column) => column);

  GeneratedColumn<String> get staffName =>
      $composableBuilder(column: $table.staffName, builder: (column) => column);

  GeneratedColumn<int> get warehouseId => $composableBuilder(
      column: $table.warehouseId, builder: (column) => column);

  GeneratedColumn<String> get warehouseName => $composableBuilder(
      column: $table.warehouseName, builder: (column) => column);

  GeneratedColumn<double> get taxRate =>
      $composableBuilder(column: $table.taxRate, builder: (column) => column);

  GeneratedColumn<double> get taxAmount =>
      $composableBuilder(column: $table.taxAmount, builder: (column) => column);

  GeneratedColumn<double> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<double> get shipping =>
      $composableBuilder(column: $table.shipping, builder: (column) => column);

  GeneratedColumn<double> get grandTotal => $composableBuilder(
      column: $table.grandTotal, builder: (column) => column);

  GeneratedColumn<double> get receivedAmount => $composableBuilder(
      column: $table.receivedAmount, builder: (column) => column);

  GeneratedColumn<double> get paidAmount => $composableBuilder(
      column: $table.paidAmount, builder: (column) => column);

  GeneratedColumn<String> get referenceCode => $composableBuilder(
      column: $table.referenceCode, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get tableId =>
      $composableBuilder(column: $table.tableId, builder: (column) => column);

  GeneratedColumn<String> get holdTableName => $composableBuilder(
      column: $table.holdTableName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<HoldItem>?, String> get holdItems =>
      $composableBuilder(column: $table.holdItems, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdLocallyAt => $composableBuilder(
      column: $table.createdLocallyAt, builder: (column) => column);
}

class $$LocalHoldsTableTableManager extends RootTableManager<
    _$DatabaseClient,
    $LocalHoldsTable,
    LocalHold,
    $$LocalHoldsTableFilterComposer,
    $$LocalHoldsTableOrderingComposer,
    $$LocalHoldsTableAnnotationComposer,
    $$LocalHoldsTableCreateCompanionBuilder,
    $$LocalHoldsTableUpdateCompanionBuilder,
    (LocalHold, BaseReferences<_$DatabaseClient, $LocalHoldsTable, LocalHold>),
    LocalHold,
    PrefetchHooks Function()> {
  $$LocalHoldsTableTableManager(_$DatabaseClient db, $LocalHoldsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalHoldsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalHoldsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalHoldsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> remoteId = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<Map<String, dynamic>?> links = const Value.absent(),
            Value<DateTime?> date = const Value.absent(),
            Value<int?> userId = const Value.absent(),
            Value<HoldAttendant?> attendant = const Value.absent(),
            Value<int?> customerId = const Value.absent(),
            Value<String?> customerName = const Value.absent(),
            Value<int?> staffId = const Value.absent(),
            Value<String?> staffName = const Value.absent(),
            Value<int?> warehouseId = const Value.absent(),
            Value<String?> warehouseName = const Value.absent(),
            Value<double?> taxRate = const Value.absent(),
            Value<double?> taxAmount = const Value.absent(),
            Value<double?> discount = const Value.absent(),
            Value<double?> shipping = const Value.absent(),
            Value<double?> grandTotal = const Value.absent(),
            Value<double?> receivedAmount = const Value.absent(),
            Value<double?> paidAmount = const Value.absent(),
            Value<String?> referenceCode = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String?> status = const Value.absent(),
            Value<String?> tableId = const Value.absent(),
            Value<String?> holdTableName = const Value.absent(),
            Value<List<HoldItem>?> holdItems = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<DateTime?> createdLocallyAt = const Value.absent(),
          }) =>
              LocalHoldsCompanion(
            id: id,
            remoteId: remoteId,
            type: type,
            links: links,
            date: date,
            userId: userId,
            attendant: attendant,
            customerId: customerId,
            customerName: customerName,
            staffId: staffId,
            staffName: staffName,
            warehouseId: warehouseId,
            warehouseName: warehouseName,
            taxRate: taxRate,
            taxAmount: taxAmount,
            discount: discount,
            shipping: shipping,
            grandTotal: grandTotal,
            receivedAmount: receivedAmount,
            paidAmount: paidAmount,
            referenceCode: referenceCode,
            note: note,
            status: status,
            tableId: tableId,
            holdTableName: holdTableName,
            holdItems: holdItems,
            createdAt: createdAt,
            isSynced: isSynced,
            lastSyncedAt: lastSyncedAt,
            createdLocallyAt: createdLocallyAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> remoteId = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<Map<String, dynamic>?> links = const Value.absent(),
            Value<DateTime?> date = const Value.absent(),
            Value<int?> userId = const Value.absent(),
            Value<HoldAttendant?> attendant = const Value.absent(),
            Value<int?> customerId = const Value.absent(),
            Value<String?> customerName = const Value.absent(),
            Value<int?> staffId = const Value.absent(),
            Value<String?> staffName = const Value.absent(),
            Value<int?> warehouseId = const Value.absent(),
            Value<String?> warehouseName = const Value.absent(),
            Value<double?> taxRate = const Value.absent(),
            Value<double?> taxAmount = const Value.absent(),
            Value<double?> discount = const Value.absent(),
            Value<double?> shipping = const Value.absent(),
            Value<double?> grandTotal = const Value.absent(),
            Value<double?> receivedAmount = const Value.absent(),
            Value<double?> paidAmount = const Value.absent(),
            Value<String?> referenceCode = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String?> status = const Value.absent(),
            Value<String?> tableId = const Value.absent(),
            Value<String?> holdTableName = const Value.absent(),
            Value<List<HoldItem>?> holdItems = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<DateTime?> createdLocallyAt = const Value.absent(),
          }) =>
              LocalHoldsCompanion.insert(
            id: id,
            remoteId: remoteId,
            type: type,
            links: links,
            date: date,
            userId: userId,
            attendant: attendant,
            customerId: customerId,
            customerName: customerName,
            staffId: staffId,
            staffName: staffName,
            warehouseId: warehouseId,
            warehouseName: warehouseName,
            taxRate: taxRate,
            taxAmount: taxAmount,
            discount: discount,
            shipping: shipping,
            grandTotal: grandTotal,
            receivedAmount: receivedAmount,
            paidAmount: paidAmount,
            referenceCode: referenceCode,
            note: note,
            status: status,
            tableId: tableId,
            holdTableName: holdTableName,
            holdItems: holdItems,
            createdAt: createdAt,
            isSynced: isSynced,
            lastSyncedAt: lastSyncedAt,
            createdLocallyAt: createdLocallyAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalHoldsTableProcessedTableManager = ProcessedTableManager<
    _$DatabaseClient,
    $LocalHoldsTable,
    LocalHold,
    $$LocalHoldsTableFilterComposer,
    $$LocalHoldsTableOrderingComposer,
    $$LocalHoldsTableAnnotationComposer,
    $$LocalHoldsTableCreateCompanionBuilder,
    $$LocalHoldsTableUpdateCompanionBuilder,
    (LocalHold, BaseReferences<_$DatabaseClient, $LocalHoldsTable, LocalHold>),
    LocalHold,
    PrefetchHooks Function()>;
typedef $$AmenitiesTableTableCreateCompanionBuilder = AmenitiesTableCompanion
    Function({
  Value<int> id,
  required String name,
  required String description,
  required String icon,
  Value<String> status,
});
typedef $$AmenitiesTableTableUpdateCompanionBuilder = AmenitiesTableCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String> description,
  Value<String> icon,
  Value<String> status,
});

class $$AmenitiesTableTableFilterComposer
    extends Composer<_$DatabaseClient, $AmenitiesTableTable> {
  $$AmenitiesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));
}

class $$AmenitiesTableTableOrderingComposer
    extends Composer<_$DatabaseClient, $AmenitiesTableTable> {
  $$AmenitiesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));
}

class $$AmenitiesTableTableAnnotationComposer
    extends Composer<_$DatabaseClient, $AmenitiesTableTable> {
  $$AmenitiesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$AmenitiesTableTableTableManager extends RootTableManager<
    _$DatabaseClient,
    $AmenitiesTableTable,
    AmenitiesTableData,
    $$AmenitiesTableTableFilterComposer,
    $$AmenitiesTableTableOrderingComposer,
    $$AmenitiesTableTableAnnotationComposer,
    $$AmenitiesTableTableCreateCompanionBuilder,
    $$AmenitiesTableTableUpdateCompanionBuilder,
    (
      AmenitiesTableData,
      BaseReferences<_$DatabaseClient, $AmenitiesTableTable, AmenitiesTableData>
    ),
    AmenitiesTableData,
    PrefetchHooks Function()> {
  $$AmenitiesTableTableTableManager(
      _$DatabaseClient db, $AmenitiesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AmenitiesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AmenitiesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AmenitiesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              AmenitiesTableCompanion(
            id: id,
            name: name,
            description: description,
            icon: icon,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String description,
            required String icon,
            Value<String> status = const Value.absent(),
          }) =>
              AmenitiesTableCompanion.insert(
            id: id,
            name: name,
            description: description,
            icon: icon,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AmenitiesTableTableProcessedTableManager = ProcessedTableManager<
    _$DatabaseClient,
    $AmenitiesTableTable,
    AmenitiesTableData,
    $$AmenitiesTableTableFilterComposer,
    $$AmenitiesTableTableOrderingComposer,
    $$AmenitiesTableTableAnnotationComposer,
    $$AmenitiesTableTableCreateCompanionBuilder,
    $$AmenitiesTableTableUpdateCompanionBuilder,
    (
      AmenitiesTableData,
      BaseReferences<_$DatabaseClient, $AmenitiesTableTable, AmenitiesTableData>
    ),
    AmenitiesTableData,
    PrefetchHooks Function()>;
typedef $$LocalFacilitiesTableTableCreateCompanionBuilder
    = LocalFacilitiesTableCompanion Function({
  Value<int> id,
  required String name,
  required int iconCodePoint,
  required String status,
});
typedef $$LocalFacilitiesTableTableUpdateCompanionBuilder
    = LocalFacilitiesTableCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> iconCodePoint,
  Value<String> status,
});

class $$LocalFacilitiesTableTableFilterComposer
    extends Composer<_$DatabaseClient, $LocalFacilitiesTableTable> {
  $$LocalFacilitiesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get iconCodePoint => $composableBuilder(
      column: $table.iconCodePoint, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));
}

class $$LocalFacilitiesTableTableOrderingComposer
    extends Composer<_$DatabaseClient, $LocalFacilitiesTableTable> {
  $$LocalFacilitiesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get iconCodePoint => $composableBuilder(
      column: $table.iconCodePoint,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));
}

class $$LocalFacilitiesTableTableAnnotationComposer
    extends Composer<_$DatabaseClient, $LocalFacilitiesTableTable> {
  $$LocalFacilitiesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get iconCodePoint => $composableBuilder(
      column: $table.iconCodePoint, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$LocalFacilitiesTableTableTableManager extends RootTableManager<
    _$DatabaseClient,
    $LocalFacilitiesTableTable,
    LocalFacilitiesTableData,
    $$LocalFacilitiesTableTableFilterComposer,
    $$LocalFacilitiesTableTableOrderingComposer,
    $$LocalFacilitiesTableTableAnnotationComposer,
    $$LocalFacilitiesTableTableCreateCompanionBuilder,
    $$LocalFacilitiesTableTableUpdateCompanionBuilder,
    (
      LocalFacilitiesTableData,
      BaseReferences<_$DatabaseClient, $LocalFacilitiesTableTable,
          LocalFacilitiesTableData>
    ),
    LocalFacilitiesTableData,
    PrefetchHooks Function()> {
  $$LocalFacilitiesTableTableTableManager(
      _$DatabaseClient db, $LocalFacilitiesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalFacilitiesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalFacilitiesTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalFacilitiesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> iconCodePoint = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              LocalFacilitiesTableCompanion(
            id: id,
            name: name,
            iconCodePoint: iconCodePoint,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required int iconCodePoint,
            required String status,
          }) =>
              LocalFacilitiesTableCompanion.insert(
            id: id,
            name: name,
            iconCodePoint: iconCodePoint,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalFacilitiesTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DatabaseClient,
        $LocalFacilitiesTableTable,
        LocalFacilitiesTableData,
        $$LocalFacilitiesTableTableFilterComposer,
        $$LocalFacilitiesTableTableOrderingComposer,
        $$LocalFacilitiesTableTableAnnotationComposer,
        $$LocalFacilitiesTableTableCreateCompanionBuilder,
        $$LocalFacilitiesTableTableUpdateCompanionBuilder,
        (
          LocalFacilitiesTableData,
          BaseReferences<_$DatabaseClient, $LocalFacilitiesTableTable,
              LocalFacilitiesTableData>
        ),
        LocalFacilitiesTableData,
        PrefetchHooks Function()>;

class $DatabaseClientManager {
  final _$DatabaseClient _db;
  $DatabaseClientManager(this._db);
  $$LocalAttendantsTableTableManager get localAttendants =>
      $$LocalAttendantsTableTableManager(_db, _db.localAttendants);
  $$LocalCustomersTableTableManager get localCustomers =>
      $$LocalCustomersTableTableManager(_db, _db.localCustomers);
  $$LocalBarTablesTableTableManager get localBarTables =>
      $$LocalBarTablesTableTableManager(_db, _db.localBarTables);
  $$LocalProductCategoriesTableTableManager get localProductCategories =>
      $$LocalProductCategoriesTableTableManager(
          _db, _db.localProductCategories);
  $$LocalProductsTableTableManager get localProducts =>
      $$LocalProductsTableTableManager(_db, _db.localProducts);
  $$LocalWarehousesTableTableManager get localWarehouses =>
      $$LocalWarehousesTableTableManager(_db, _db.localWarehouses);
  $$LocalRegistersTableTableManager get localRegisters =>
      $$LocalRegistersTableTableManager(_db, _db.localRegisters);
  $$LocalSalesTableTableManager get localSales =>
      $$LocalSalesTableTableManager(_db, _db.localSales);
  $$LocalHoldsTableTableManager get localHolds =>
      $$LocalHoldsTableTableManager(_db, _db.localHolds);
  $$AmenitiesTableTableTableManager get amenitiesTable =>
      $$AmenitiesTableTableTableManager(_db, _db.amenitiesTable);
  $$LocalFacilitiesTableTableTableManager get localFacilitiesTable =>
      $$LocalFacilitiesTableTableTableManager(_db, _db.localFacilitiesTable);
}
