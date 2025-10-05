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

abstract class _$DatabaseClient extends GeneratedDatabase {
  _$DatabaseClient(QueryExecutor e) : super(e);
  $DatabaseClientManager get managers => $DatabaseClientManager(this);
  late final $LocalAttendantsTable localAttendants =
      $LocalAttendantsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [localAttendants];
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

class $DatabaseClientManager {
  final _$DatabaseClient _db;
  $DatabaseClientManager(this._db);
  $$LocalAttendantsTableTableManager get localAttendants =>
      $$LocalAttendantsTableTableManager(_db, _db.localAttendants);
}
