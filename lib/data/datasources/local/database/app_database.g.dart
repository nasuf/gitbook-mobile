// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CachedOrganizationsTable extends CachedOrganizations
    with TableInfo<$CachedOrganizationsTable, CachedOrganization> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedOrganizationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _urlsLocationMeta =
      const VerificationMeta('urlsLocation');
  @override
  late final GeneratedColumn<String> urlsLocation = GeneratedColumn<String>(
      'urls_location', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _urlsAppMeta =
      const VerificationMeta('urlsApp');
  @override
  late final GeneratedColumn<String> urlsApp = GeneratedColumn<String>(
      'urls_app', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _expiresAtMeta =
      const VerificationMeta('expiresAt');
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
      'expires_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        urlsLocation,
        urlsApp,
        createdAt,
        updatedAt,
        cachedAt,
        expiresAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_organizations';
  @override
  VerificationContext validateIntegrity(Insertable<CachedOrganization> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('urls_location')) {
      context.handle(
          _urlsLocationMeta,
          urlsLocation.isAcceptableOrUnknown(
              data['urls_location']!, _urlsLocationMeta));
    }
    if (data.containsKey('urls_app')) {
      context.handle(_urlsAppMeta,
          urlsApp.isAcceptableOrUnknown(data['urls_app']!, _urlsAppMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(_expiresAtMeta,
          expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta));
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedOrganization map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedOrganization(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      urlsLocation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}urls_location']),
      urlsApp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}urls_app']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
      expiresAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}expires_at'])!,
    );
  }

  @override
  $CachedOrganizationsTable createAlias(String alias) {
    return $CachedOrganizationsTable(attachedDatabase, alias);
  }
}

class CachedOrganization extends DataClass
    implements Insertable<CachedOrganization> {
  final String id;
  final String title;
  final String? urlsLocation;
  final String? urlsApp;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime cachedAt;
  final DateTime expiresAt;
  const CachedOrganization(
      {required this.id,
      required this.title,
      this.urlsLocation,
      this.urlsApp,
      this.createdAt,
      this.updatedAt,
      required this.cachedAt,
      required this.expiresAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || urlsLocation != null) {
      map['urls_location'] = Variable<String>(urlsLocation);
    }
    if (!nullToAbsent || urlsApp != null) {
      map['urls_app'] = Variable<String>(urlsApp);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    return map;
  }

  CachedOrganizationsCompanion toCompanion(bool nullToAbsent) {
    return CachedOrganizationsCompanion(
      id: Value(id),
      title: Value(title),
      urlsLocation: urlsLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(urlsLocation),
      urlsApp: urlsApp == null && nullToAbsent
          ? const Value.absent()
          : Value(urlsApp),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      cachedAt: Value(cachedAt),
      expiresAt: Value(expiresAt),
    );
  }

  factory CachedOrganization.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedOrganization(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      urlsLocation: serializer.fromJson<String?>(json['urlsLocation']),
      urlsApp: serializer.fromJson<String?>(json['urlsApp']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'urlsLocation': serializer.toJson<String?>(urlsLocation),
      'urlsApp': serializer.toJson<String?>(urlsApp),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
    };
  }

  CachedOrganization copyWith(
          {String? id,
          String? title,
          Value<String?> urlsLocation = const Value.absent(),
          Value<String?> urlsApp = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent(),
          DateTime? cachedAt,
          DateTime? expiresAt}) =>
      CachedOrganization(
        id: id ?? this.id,
        title: title ?? this.title,
        urlsLocation:
            urlsLocation.present ? urlsLocation.value : this.urlsLocation,
        urlsApp: urlsApp.present ? urlsApp.value : this.urlsApp,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        cachedAt: cachedAt ?? this.cachedAt,
        expiresAt: expiresAt ?? this.expiresAt,
      );
  CachedOrganization copyWithCompanion(CachedOrganizationsCompanion data) {
    return CachedOrganization(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      urlsLocation: data.urlsLocation.present
          ? data.urlsLocation.value
          : this.urlsLocation,
      urlsApp: data.urlsApp.present ? data.urlsApp.value : this.urlsApp,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedOrganization(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('urlsLocation: $urlsLocation, ')
          ..write('urlsApp: $urlsApp, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, urlsLocation, urlsApp, createdAt,
      updatedAt, cachedAt, expiresAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedOrganization &&
          other.id == this.id &&
          other.title == this.title &&
          other.urlsLocation == this.urlsLocation &&
          other.urlsApp == this.urlsApp &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.cachedAt == this.cachedAt &&
          other.expiresAt == this.expiresAt);
}

class CachedOrganizationsCompanion extends UpdateCompanion<CachedOrganization> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> urlsLocation;
  final Value<String?> urlsApp;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime> cachedAt;
  final Value<DateTime> expiresAt;
  final Value<int> rowid;
  const CachedOrganizationsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.urlsLocation = const Value.absent(),
    this.urlsApp = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedOrganizationsCompanion.insert({
    required String id,
    required String title,
    this.urlsLocation = const Value.absent(),
    this.urlsApp = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required DateTime cachedAt,
    required DateTime expiresAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        cachedAt = Value(cachedAt),
        expiresAt = Value(expiresAt);
  static Insertable<CachedOrganization> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? urlsLocation,
    Expression<String>? urlsApp,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? cachedAt,
    Expression<DateTime>? expiresAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (urlsLocation != null) 'urls_location': urlsLocation,
      if (urlsApp != null) 'urls_app': urlsApp,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedOrganizationsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? urlsLocation,
      Value<String?>? urlsApp,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime>? cachedAt,
      Value<DateTime>? expiresAt,
      Value<int>? rowid}) {
    return CachedOrganizationsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      urlsLocation: urlsLocation ?? this.urlsLocation,
      urlsApp: urlsApp ?? this.urlsApp,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      cachedAt: cachedAt ?? this.cachedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (urlsLocation.present) {
      map['urls_location'] = Variable<String>(urlsLocation.value);
    }
    if (urlsApp.present) {
      map['urls_app'] = Variable<String>(urlsApp.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedOrganizationsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('urlsLocation: $urlsLocation, ')
          ..write('urlsApp: $urlsApp, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedSpacesTable extends CachedSpaces
    with TableInfo<$CachedSpacesTable, CachedSpace> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedSpacesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _visibilityMeta =
      const VerificationMeta('visibility');
  @override
  late final GeneratedColumn<String> visibility = GeneratedColumn<String>(
      'visibility', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _organizationIdMeta =
      const VerificationMeta('organizationId');
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
      'organization_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _urlsLocationMeta =
      const VerificationMeta('urlsLocation');
  @override
  late final GeneratedColumn<String> urlsLocation = GeneratedColumn<String>(
      'urls_location', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _urlsAppMeta =
      const VerificationMeta('urlsApp');
  @override
  late final GeneratedColumn<String> urlsApp = GeneratedColumn<String>(
      'urls_app', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _urlsPublishedMeta =
      const VerificationMeta('urlsPublished');
  @override
  late final GeneratedColumn<String> urlsPublished = GeneratedColumn<String>(
      'urls_published', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _expiresAtMeta =
      const VerificationMeta('expiresAt');
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
      'expires_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        description,
        visibility,
        organizationId,
        urlsLocation,
        urlsApp,
        urlsPublished,
        createdAt,
        updatedAt,
        deletedAt,
        cachedAt,
        expiresAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_spaces';
  @override
  VerificationContext validateIntegrity(Insertable<CachedSpace> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('visibility')) {
      context.handle(
          _visibilityMeta,
          visibility.isAcceptableOrUnknown(
              data['visibility']!, _visibilityMeta));
    }
    if (data.containsKey('organization_id')) {
      context.handle(
          _organizationIdMeta,
          organizationId.isAcceptableOrUnknown(
              data['organization_id']!, _organizationIdMeta));
    }
    if (data.containsKey('urls_location')) {
      context.handle(
          _urlsLocationMeta,
          urlsLocation.isAcceptableOrUnknown(
              data['urls_location']!, _urlsLocationMeta));
    }
    if (data.containsKey('urls_app')) {
      context.handle(_urlsAppMeta,
          urlsApp.isAcceptableOrUnknown(data['urls_app']!, _urlsAppMeta));
    }
    if (data.containsKey('urls_published')) {
      context.handle(
          _urlsPublishedMeta,
          urlsPublished.isAcceptableOrUnknown(
              data['urls_published']!, _urlsPublishedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(_expiresAtMeta,
          expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta));
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedSpace map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedSpace(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      visibility: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}visibility']),
      organizationId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}organization_id']),
      urlsLocation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}urls_location']),
      urlsApp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}urls_app']),
      urlsPublished: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}urls_published']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
      expiresAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}expires_at'])!,
    );
  }

  @override
  $CachedSpacesTable createAlias(String alias) {
    return $CachedSpacesTable(attachedDatabase, alias);
  }
}

class CachedSpace extends DataClass implements Insertable<CachedSpace> {
  final String id;
  final String title;
  final String? description;
  final String? visibility;
  final String? organizationId;
  final String? urlsLocation;
  final String? urlsApp;
  final String? urlsPublished;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final DateTime cachedAt;
  final DateTime expiresAt;
  const CachedSpace(
      {required this.id,
      required this.title,
      this.description,
      this.visibility,
      this.organizationId,
      this.urlsLocation,
      this.urlsApp,
      this.urlsPublished,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      required this.cachedAt,
      required this.expiresAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || visibility != null) {
      map['visibility'] = Variable<String>(visibility);
    }
    if (!nullToAbsent || organizationId != null) {
      map['organization_id'] = Variable<String>(organizationId);
    }
    if (!nullToAbsent || urlsLocation != null) {
      map['urls_location'] = Variable<String>(urlsLocation);
    }
    if (!nullToAbsent || urlsApp != null) {
      map['urls_app'] = Variable<String>(urlsApp);
    }
    if (!nullToAbsent || urlsPublished != null) {
      map['urls_published'] = Variable<String>(urlsPublished);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    return map;
  }

  CachedSpacesCompanion toCompanion(bool nullToAbsent) {
    return CachedSpacesCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      visibility: visibility == null && nullToAbsent
          ? const Value.absent()
          : Value(visibility),
      organizationId: organizationId == null && nullToAbsent
          ? const Value.absent()
          : Value(organizationId),
      urlsLocation: urlsLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(urlsLocation),
      urlsApp: urlsApp == null && nullToAbsent
          ? const Value.absent()
          : Value(urlsApp),
      urlsPublished: urlsPublished == null && nullToAbsent
          ? const Value.absent()
          : Value(urlsPublished),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      cachedAt: Value(cachedAt),
      expiresAt: Value(expiresAt),
    );
  }

  factory CachedSpace.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedSpace(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      visibility: serializer.fromJson<String?>(json['visibility']),
      organizationId: serializer.fromJson<String?>(json['organizationId']),
      urlsLocation: serializer.fromJson<String?>(json['urlsLocation']),
      urlsApp: serializer.fromJson<String?>(json['urlsApp']),
      urlsPublished: serializer.fromJson<String?>(json['urlsPublished']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'visibility': serializer.toJson<String?>(visibility),
      'organizationId': serializer.toJson<String?>(organizationId),
      'urlsLocation': serializer.toJson<String?>(urlsLocation),
      'urlsApp': serializer.toJson<String?>(urlsApp),
      'urlsPublished': serializer.toJson<String?>(urlsPublished),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
    };
  }

  CachedSpace copyWith(
          {String? id,
          String? title,
          Value<String?> description = const Value.absent(),
          Value<String?> visibility = const Value.absent(),
          Value<String?> organizationId = const Value.absent(),
          Value<String?> urlsLocation = const Value.absent(),
          Value<String?> urlsApp = const Value.absent(),
          Value<String?> urlsPublished = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent(),
          DateTime? cachedAt,
          DateTime? expiresAt}) =>
      CachedSpace(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        visibility: visibility.present ? visibility.value : this.visibility,
        organizationId:
            organizationId.present ? organizationId.value : this.organizationId,
        urlsLocation:
            urlsLocation.present ? urlsLocation.value : this.urlsLocation,
        urlsApp: urlsApp.present ? urlsApp.value : this.urlsApp,
        urlsPublished:
            urlsPublished.present ? urlsPublished.value : this.urlsPublished,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        cachedAt: cachedAt ?? this.cachedAt,
        expiresAt: expiresAt ?? this.expiresAt,
      );
  CachedSpace copyWithCompanion(CachedSpacesCompanion data) {
    return CachedSpace(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      visibility:
          data.visibility.present ? data.visibility.value : this.visibility,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      urlsLocation: data.urlsLocation.present
          ? data.urlsLocation.value
          : this.urlsLocation,
      urlsApp: data.urlsApp.present ? data.urlsApp.value : this.urlsApp,
      urlsPublished: data.urlsPublished.present
          ? data.urlsPublished.value
          : this.urlsPublished,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedSpace(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('visibility: $visibility, ')
          ..write('organizationId: $organizationId, ')
          ..write('urlsLocation: $urlsLocation, ')
          ..write('urlsApp: $urlsApp, ')
          ..write('urlsPublished: $urlsPublished, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      description,
      visibility,
      organizationId,
      urlsLocation,
      urlsApp,
      urlsPublished,
      createdAt,
      updatedAt,
      deletedAt,
      cachedAt,
      expiresAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedSpace &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.visibility == this.visibility &&
          other.organizationId == this.organizationId &&
          other.urlsLocation == this.urlsLocation &&
          other.urlsApp == this.urlsApp &&
          other.urlsPublished == this.urlsPublished &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.cachedAt == this.cachedAt &&
          other.expiresAt == this.expiresAt);
}

class CachedSpacesCompanion extends UpdateCompanion<CachedSpace> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> visibility;
  final Value<String?> organizationId;
  final Value<String?> urlsLocation;
  final Value<String?> urlsApp;
  final Value<String?> urlsPublished;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<DateTime> cachedAt;
  final Value<DateTime> expiresAt;
  final Value<int> rowid;
  const CachedSpacesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.visibility = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.urlsLocation = const Value.absent(),
    this.urlsApp = const Value.absent(),
    this.urlsPublished = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedSpacesCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    this.visibility = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.urlsLocation = const Value.absent(),
    this.urlsApp = const Value.absent(),
    this.urlsPublished = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required DateTime cachedAt,
    required DateTime expiresAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        cachedAt = Value(cachedAt),
        expiresAt = Value(expiresAt);
  static Insertable<CachedSpace> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? visibility,
    Expression<String>? organizationId,
    Expression<String>? urlsLocation,
    Expression<String>? urlsApp,
    Expression<String>? urlsPublished,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<DateTime>? cachedAt,
    Expression<DateTime>? expiresAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (visibility != null) 'visibility': visibility,
      if (organizationId != null) 'organization_id': organizationId,
      if (urlsLocation != null) 'urls_location': urlsLocation,
      if (urlsApp != null) 'urls_app': urlsApp,
      if (urlsPublished != null) 'urls_published': urlsPublished,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedSpacesCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<String?>? visibility,
      Value<String?>? organizationId,
      Value<String?>? urlsLocation,
      Value<String?>? urlsApp,
      Value<String?>? urlsPublished,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<DateTime>? cachedAt,
      Value<DateTime>? expiresAt,
      Value<int>? rowid}) {
    return CachedSpacesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      visibility: visibility ?? this.visibility,
      organizationId: organizationId ?? this.organizationId,
      urlsLocation: urlsLocation ?? this.urlsLocation,
      urlsApp: urlsApp ?? this.urlsApp,
      urlsPublished: urlsPublished ?? this.urlsPublished,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      cachedAt: cachedAt ?? this.cachedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (visibility.present) {
      map['visibility'] = Variable<String>(visibility.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (urlsLocation.present) {
      map['urls_location'] = Variable<String>(urlsLocation.value);
    }
    if (urlsApp.present) {
      map['urls_app'] = Variable<String>(urlsApp.value);
    }
    if (urlsPublished.present) {
      map['urls_published'] = Variable<String>(urlsPublished.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedSpacesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('visibility: $visibility, ')
          ..write('organizationId: $organizationId, ')
          ..write('urlsLocation: $urlsLocation, ')
          ..write('urlsApp: $urlsApp, ')
          ..write('urlsPublished: $urlsPublished, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedContentTable extends CachedContent
    with TableInfo<$CachedContentTable, CachedContentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedContentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _spaceIdMeta =
      const VerificationMeta('spaceId');
  @override
  late final GeneratedColumn<String> spaceId = GeneratedColumn<String>(
      'space_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
      'slug', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _urlsLocationMeta =
      const VerificationMeta('urlsLocation');
  @override
  late final GeneratedColumn<String> urlsLocation = GeneratedColumn<String>(
      'urls_location', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _urlsAppMeta =
      const VerificationMeta('urlsApp');
  @override
  late final GeneratedColumn<String> urlsApp = GeneratedColumn<String>(
      'urls_app', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _expiresAtMeta =
      const VerificationMeta('expiresAt');
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
      'expires_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        spaceId,
        title,
        type,
        path,
        slug,
        description,
        parentId,
        orderIndex,
        urlsLocation,
        urlsApp,
        createdAt,
        updatedAt,
        cachedAt,
        expiresAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_content';
  @override
  VerificationContext validateIntegrity(Insertable<CachedContentData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('space_id')) {
      context.handle(_spaceIdMeta,
          spaceId.isAcceptableOrUnknown(data['space_id']!, _spaceIdMeta));
    } else if (isInserting) {
      context.missing(_spaceIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    }
    if (data.containsKey('slug')) {
      context.handle(
          _slugMeta, slug.isAcceptableOrUnknown(data['slug']!, _slugMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    }
    if (data.containsKey('urls_location')) {
      context.handle(
          _urlsLocationMeta,
          urlsLocation.isAcceptableOrUnknown(
              data['urls_location']!, _urlsLocationMeta));
    }
    if (data.containsKey('urls_app')) {
      context.handle(_urlsAppMeta,
          urlsApp.isAcceptableOrUnknown(data['urls_app']!, _urlsAppMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(_expiresAtMeta,
          expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta));
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedContentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedContentData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      spaceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}space_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path']),
      slug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slug']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent_id']),
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
      urlsLocation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}urls_location']),
      urlsApp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}urls_app']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
      expiresAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}expires_at'])!,
    );
  }

  @override
  $CachedContentTable createAlias(String alias) {
    return $CachedContentTable(attachedDatabase, alias);
  }
}

class CachedContentData extends DataClass
    implements Insertable<CachedContentData> {
  final String id;
  final String spaceId;
  final String title;
  final String type;
  final String? path;
  final String? slug;
  final String? description;
  final String? parentId;
  final int orderIndex;
  final String? urlsLocation;
  final String? urlsApp;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime cachedAt;
  final DateTime expiresAt;
  const CachedContentData(
      {required this.id,
      required this.spaceId,
      required this.title,
      required this.type,
      this.path,
      this.slug,
      this.description,
      this.parentId,
      required this.orderIndex,
      this.urlsLocation,
      this.urlsApp,
      this.createdAt,
      this.updatedAt,
      required this.cachedAt,
      required this.expiresAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['space_id'] = Variable<String>(spaceId);
    map['title'] = Variable<String>(title);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || path != null) {
      map['path'] = Variable<String>(path);
    }
    if (!nullToAbsent || slug != null) {
      map['slug'] = Variable<String>(slug);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['order_index'] = Variable<int>(orderIndex);
    if (!nullToAbsent || urlsLocation != null) {
      map['urls_location'] = Variable<String>(urlsLocation);
    }
    if (!nullToAbsent || urlsApp != null) {
      map['urls_app'] = Variable<String>(urlsApp);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    return map;
  }

  CachedContentCompanion toCompanion(bool nullToAbsent) {
    return CachedContentCompanion(
      id: Value(id),
      spaceId: Value(spaceId),
      title: Value(title),
      type: Value(type),
      path: path == null && nullToAbsent ? const Value.absent() : Value(path),
      slug: slug == null && nullToAbsent ? const Value.absent() : Value(slug),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      orderIndex: Value(orderIndex),
      urlsLocation: urlsLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(urlsLocation),
      urlsApp: urlsApp == null && nullToAbsent
          ? const Value.absent()
          : Value(urlsApp),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      cachedAt: Value(cachedAt),
      expiresAt: Value(expiresAt),
    );
  }

  factory CachedContentData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedContentData(
      id: serializer.fromJson<String>(json['id']),
      spaceId: serializer.fromJson<String>(json['spaceId']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<String>(json['type']),
      path: serializer.fromJson<String?>(json['path']),
      slug: serializer.fromJson<String?>(json['slug']),
      description: serializer.fromJson<String?>(json['description']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      urlsLocation: serializer.fromJson<String?>(json['urlsLocation']),
      urlsApp: serializer.fromJson<String?>(json['urlsApp']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'spaceId': serializer.toJson<String>(spaceId),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(type),
      'path': serializer.toJson<String?>(path),
      'slug': serializer.toJson<String?>(slug),
      'description': serializer.toJson<String?>(description),
      'parentId': serializer.toJson<String?>(parentId),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'urlsLocation': serializer.toJson<String?>(urlsLocation),
      'urlsApp': serializer.toJson<String?>(urlsApp),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
    };
  }

  CachedContentData copyWith(
          {String? id,
          String? spaceId,
          String? title,
          String? type,
          Value<String?> path = const Value.absent(),
          Value<String?> slug = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> parentId = const Value.absent(),
          int? orderIndex,
          Value<String?> urlsLocation = const Value.absent(),
          Value<String?> urlsApp = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent(),
          DateTime? cachedAt,
          DateTime? expiresAt}) =>
      CachedContentData(
        id: id ?? this.id,
        spaceId: spaceId ?? this.spaceId,
        title: title ?? this.title,
        type: type ?? this.type,
        path: path.present ? path.value : this.path,
        slug: slug.present ? slug.value : this.slug,
        description: description.present ? description.value : this.description,
        parentId: parentId.present ? parentId.value : this.parentId,
        orderIndex: orderIndex ?? this.orderIndex,
        urlsLocation:
            urlsLocation.present ? urlsLocation.value : this.urlsLocation,
        urlsApp: urlsApp.present ? urlsApp.value : this.urlsApp,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        cachedAt: cachedAt ?? this.cachedAt,
        expiresAt: expiresAt ?? this.expiresAt,
      );
  CachedContentData copyWithCompanion(CachedContentCompanion data) {
    return CachedContentData(
      id: data.id.present ? data.id.value : this.id,
      spaceId: data.spaceId.present ? data.spaceId.value : this.spaceId,
      title: data.title.present ? data.title.value : this.title,
      type: data.type.present ? data.type.value : this.type,
      path: data.path.present ? data.path.value : this.path,
      slug: data.slug.present ? data.slug.value : this.slug,
      description:
          data.description.present ? data.description.value : this.description,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
      urlsLocation: data.urlsLocation.present
          ? data.urlsLocation.value
          : this.urlsLocation,
      urlsApp: data.urlsApp.present ? data.urlsApp.value : this.urlsApp,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedContentData(')
          ..write('id: $id, ')
          ..write('spaceId: $spaceId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('path: $path, ')
          ..write('slug: $slug, ')
          ..write('description: $description, ')
          ..write('parentId: $parentId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('urlsLocation: $urlsLocation, ')
          ..write('urlsApp: $urlsApp, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      spaceId,
      title,
      type,
      path,
      slug,
      description,
      parentId,
      orderIndex,
      urlsLocation,
      urlsApp,
      createdAt,
      updatedAt,
      cachedAt,
      expiresAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedContentData &&
          other.id == this.id &&
          other.spaceId == this.spaceId &&
          other.title == this.title &&
          other.type == this.type &&
          other.path == this.path &&
          other.slug == this.slug &&
          other.description == this.description &&
          other.parentId == this.parentId &&
          other.orderIndex == this.orderIndex &&
          other.urlsLocation == this.urlsLocation &&
          other.urlsApp == this.urlsApp &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.cachedAt == this.cachedAt &&
          other.expiresAt == this.expiresAt);
}

class CachedContentCompanion extends UpdateCompanion<CachedContentData> {
  final Value<String> id;
  final Value<String> spaceId;
  final Value<String> title;
  final Value<String> type;
  final Value<String?> path;
  final Value<String?> slug;
  final Value<String?> description;
  final Value<String?> parentId;
  final Value<int> orderIndex;
  final Value<String?> urlsLocation;
  final Value<String?> urlsApp;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime> cachedAt;
  final Value<DateTime> expiresAt;
  final Value<int> rowid;
  const CachedContentCompanion({
    this.id = const Value.absent(),
    this.spaceId = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.path = const Value.absent(),
    this.slug = const Value.absent(),
    this.description = const Value.absent(),
    this.parentId = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.urlsLocation = const Value.absent(),
    this.urlsApp = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedContentCompanion.insert({
    required String id,
    required String spaceId,
    required String title,
    required String type,
    this.path = const Value.absent(),
    this.slug = const Value.absent(),
    this.description = const Value.absent(),
    this.parentId = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.urlsLocation = const Value.absent(),
    this.urlsApp = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required DateTime cachedAt,
    required DateTime expiresAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        spaceId = Value(spaceId),
        title = Value(title),
        type = Value(type),
        cachedAt = Value(cachedAt),
        expiresAt = Value(expiresAt);
  static Insertable<CachedContentData> custom({
    Expression<String>? id,
    Expression<String>? spaceId,
    Expression<String>? title,
    Expression<String>? type,
    Expression<String>? path,
    Expression<String>? slug,
    Expression<String>? description,
    Expression<String>? parentId,
    Expression<int>? orderIndex,
    Expression<String>? urlsLocation,
    Expression<String>? urlsApp,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? cachedAt,
    Expression<DateTime>? expiresAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (spaceId != null) 'space_id': spaceId,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (path != null) 'path': path,
      if (slug != null) 'slug': slug,
      if (description != null) 'description': description,
      if (parentId != null) 'parent_id': parentId,
      if (orderIndex != null) 'order_index': orderIndex,
      if (urlsLocation != null) 'urls_location': urlsLocation,
      if (urlsApp != null) 'urls_app': urlsApp,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedContentCompanion copyWith(
      {Value<String>? id,
      Value<String>? spaceId,
      Value<String>? title,
      Value<String>? type,
      Value<String?>? path,
      Value<String?>? slug,
      Value<String?>? description,
      Value<String?>? parentId,
      Value<int>? orderIndex,
      Value<String?>? urlsLocation,
      Value<String?>? urlsApp,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime>? cachedAt,
      Value<DateTime>? expiresAt,
      Value<int>? rowid}) {
    return CachedContentCompanion(
      id: id ?? this.id,
      spaceId: spaceId ?? this.spaceId,
      title: title ?? this.title,
      type: type ?? this.type,
      path: path ?? this.path,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      parentId: parentId ?? this.parentId,
      orderIndex: orderIndex ?? this.orderIndex,
      urlsLocation: urlsLocation ?? this.urlsLocation,
      urlsApp: urlsApp ?? this.urlsApp,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      cachedAt: cachedAt ?? this.cachedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (spaceId.present) {
      map['space_id'] = Variable<String>(spaceId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (urlsLocation.present) {
      map['urls_location'] = Variable<String>(urlsLocation.value);
    }
    if (urlsApp.present) {
      map['urls_app'] = Variable<String>(urlsApp.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedContentCompanion(')
          ..write('id: $id, ')
          ..write('spaceId: $spaceId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('path: $path, ')
          ..write('slug: $slug, ')
          ..write('description: $description, ')
          ..write('parentId: $parentId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('urlsLocation: $urlsLocation, ')
          ..write('urlsApp: $urlsApp, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedDocumentsTable extends CachedDocuments
    with TableInfo<$CachedDocumentsTable, CachedDocument> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedDocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pageIdMeta = const VerificationMeta('pageId');
  @override
  late final GeneratedColumn<String> pageId = GeneratedColumn<String>(
      'page_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _spaceIdMeta =
      const VerificationMeta('spaceId');
  @override
  late final GeneratedColumn<String> spaceId = GeneratedColumn<String>(
      'space_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _markdownMeta =
      const VerificationMeta('markdown');
  @override
  late final GeneratedColumn<String> markdown = GeneratedColumn<String>(
      'markdown', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nodesJsonMeta =
      const VerificationMeta('nodesJson');
  @override
  late final GeneratedColumn<String> nodesJson = GeneratedColumn<String>(
      'nodes_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _expiresAtMeta =
      const VerificationMeta('expiresAt');
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
      'expires_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [pageId, spaceId, markdown, nodesJson, cachedAt, expiresAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_documents';
  @override
  VerificationContext validateIntegrity(Insertable<CachedDocument> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('page_id')) {
      context.handle(_pageIdMeta,
          pageId.isAcceptableOrUnknown(data['page_id']!, _pageIdMeta));
    } else if (isInserting) {
      context.missing(_pageIdMeta);
    }
    if (data.containsKey('space_id')) {
      context.handle(_spaceIdMeta,
          spaceId.isAcceptableOrUnknown(data['space_id']!, _spaceIdMeta));
    } else if (isInserting) {
      context.missing(_spaceIdMeta);
    }
    if (data.containsKey('markdown')) {
      context.handle(_markdownMeta,
          markdown.isAcceptableOrUnknown(data['markdown']!, _markdownMeta));
    }
    if (data.containsKey('nodes_json')) {
      context.handle(_nodesJsonMeta,
          nodesJson.isAcceptableOrUnknown(data['nodes_json']!, _nodesJsonMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(_expiresAtMeta,
          expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta));
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pageId};
  @override
  CachedDocument map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedDocument(
      pageId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}page_id'])!,
      spaceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}space_id'])!,
      markdown: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}markdown']),
      nodesJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nodes_json']),
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
      expiresAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}expires_at'])!,
    );
  }

  @override
  $CachedDocumentsTable createAlias(String alias) {
    return $CachedDocumentsTable(attachedDatabase, alias);
  }
}

class CachedDocument extends DataClass implements Insertable<CachedDocument> {
  final String pageId;
  final String spaceId;
  final String? markdown;
  final String? nodesJson;
  final DateTime cachedAt;
  final DateTime expiresAt;
  const CachedDocument(
      {required this.pageId,
      required this.spaceId,
      this.markdown,
      this.nodesJson,
      required this.cachedAt,
      required this.expiresAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['page_id'] = Variable<String>(pageId);
    map['space_id'] = Variable<String>(spaceId);
    if (!nullToAbsent || markdown != null) {
      map['markdown'] = Variable<String>(markdown);
    }
    if (!nullToAbsent || nodesJson != null) {
      map['nodes_json'] = Variable<String>(nodesJson);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    return map;
  }

  CachedDocumentsCompanion toCompanion(bool nullToAbsent) {
    return CachedDocumentsCompanion(
      pageId: Value(pageId),
      spaceId: Value(spaceId),
      markdown: markdown == null && nullToAbsent
          ? const Value.absent()
          : Value(markdown),
      nodesJson: nodesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(nodesJson),
      cachedAt: Value(cachedAt),
      expiresAt: Value(expiresAt),
    );
  }

  factory CachedDocument.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedDocument(
      pageId: serializer.fromJson<String>(json['pageId']),
      spaceId: serializer.fromJson<String>(json['spaceId']),
      markdown: serializer.fromJson<String?>(json['markdown']),
      nodesJson: serializer.fromJson<String?>(json['nodesJson']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pageId': serializer.toJson<String>(pageId),
      'spaceId': serializer.toJson<String>(spaceId),
      'markdown': serializer.toJson<String?>(markdown),
      'nodesJson': serializer.toJson<String?>(nodesJson),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
    };
  }

  CachedDocument copyWith(
          {String? pageId,
          String? spaceId,
          Value<String?> markdown = const Value.absent(),
          Value<String?> nodesJson = const Value.absent(),
          DateTime? cachedAt,
          DateTime? expiresAt}) =>
      CachedDocument(
        pageId: pageId ?? this.pageId,
        spaceId: spaceId ?? this.spaceId,
        markdown: markdown.present ? markdown.value : this.markdown,
        nodesJson: nodesJson.present ? nodesJson.value : this.nodesJson,
        cachedAt: cachedAt ?? this.cachedAt,
        expiresAt: expiresAt ?? this.expiresAt,
      );
  CachedDocument copyWithCompanion(CachedDocumentsCompanion data) {
    return CachedDocument(
      pageId: data.pageId.present ? data.pageId.value : this.pageId,
      spaceId: data.spaceId.present ? data.spaceId.value : this.spaceId,
      markdown: data.markdown.present ? data.markdown.value : this.markdown,
      nodesJson: data.nodesJson.present ? data.nodesJson.value : this.nodesJson,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedDocument(')
          ..write('pageId: $pageId, ')
          ..write('spaceId: $spaceId, ')
          ..write('markdown: $markdown, ')
          ..write('nodesJson: $nodesJson, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(pageId, spaceId, markdown, nodesJson, cachedAt, expiresAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedDocument &&
          other.pageId == this.pageId &&
          other.spaceId == this.spaceId &&
          other.markdown == this.markdown &&
          other.nodesJson == this.nodesJson &&
          other.cachedAt == this.cachedAt &&
          other.expiresAt == this.expiresAt);
}

class CachedDocumentsCompanion extends UpdateCompanion<CachedDocument> {
  final Value<String> pageId;
  final Value<String> spaceId;
  final Value<String?> markdown;
  final Value<String?> nodesJson;
  final Value<DateTime> cachedAt;
  final Value<DateTime> expiresAt;
  final Value<int> rowid;
  const CachedDocumentsCompanion({
    this.pageId = const Value.absent(),
    this.spaceId = const Value.absent(),
    this.markdown = const Value.absent(),
    this.nodesJson = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedDocumentsCompanion.insert({
    required String pageId,
    required String spaceId,
    this.markdown = const Value.absent(),
    this.nodesJson = const Value.absent(),
    required DateTime cachedAt,
    required DateTime expiresAt,
    this.rowid = const Value.absent(),
  })  : pageId = Value(pageId),
        spaceId = Value(spaceId),
        cachedAt = Value(cachedAt),
        expiresAt = Value(expiresAt);
  static Insertable<CachedDocument> custom({
    Expression<String>? pageId,
    Expression<String>? spaceId,
    Expression<String>? markdown,
    Expression<String>? nodesJson,
    Expression<DateTime>? cachedAt,
    Expression<DateTime>? expiresAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pageId != null) 'page_id': pageId,
      if (spaceId != null) 'space_id': spaceId,
      if (markdown != null) 'markdown': markdown,
      if (nodesJson != null) 'nodes_json': nodesJson,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedDocumentsCompanion copyWith(
      {Value<String>? pageId,
      Value<String>? spaceId,
      Value<String?>? markdown,
      Value<String?>? nodesJson,
      Value<DateTime>? cachedAt,
      Value<DateTime>? expiresAt,
      Value<int>? rowid}) {
    return CachedDocumentsCompanion(
      pageId: pageId ?? this.pageId,
      spaceId: spaceId ?? this.spaceId,
      markdown: markdown ?? this.markdown,
      nodesJson: nodesJson ?? this.nodesJson,
      cachedAt: cachedAt ?? this.cachedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pageId.present) {
      map['page_id'] = Variable<String>(pageId.value);
    }
    if (spaceId.present) {
      map['space_id'] = Variable<String>(spaceId.value);
    }
    if (markdown.present) {
      map['markdown'] = Variable<String>(markdown.value);
    }
    if (nodesJson.present) {
      map['nodes_json'] = Variable<String>(nodesJson.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedDocumentsCompanion(')
          ..write('pageId: $pageId, ')
          ..write('spaceId: $spaceId, ')
          ..write('markdown: $markdown, ')
          ..write('nodesJson: $nodesJson, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedUsersTable extends CachedUsers
    with TableInfo<$CachedUsersTable, CachedUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _photoUrlMeta =
      const VerificationMeta('photoUrl');
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
      'photo_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _expiresAtMeta =
      const VerificationMeta('expiresAt');
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
      'expires_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, displayName, email, photoUrl, cachedAt, expiresAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_users';
  @override
  VerificationContext validateIntegrity(Insertable<CachedUser> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('photo_url')) {
      context.handle(_photoUrlMeta,
          photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(_expiresAtMeta,
          expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta));
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedUser(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      photoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_url']),
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
      expiresAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}expires_at'])!,
    );
  }

  @override
  $CachedUsersTable createAlias(String alias) {
    return $CachedUsersTable(attachedDatabase, alias);
  }
}

class CachedUser extends DataClass implements Insertable<CachedUser> {
  final String id;
  final String? displayName;
  final String? email;
  final String? photoUrl;
  final DateTime cachedAt;
  final DateTime expiresAt;
  const CachedUser(
      {required this.id,
      this.displayName,
      this.email,
      this.photoUrl,
      required this.cachedAt,
      required this.expiresAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    return map;
  }

  CachedUsersCompanion toCompanion(bool nullToAbsent) {
    return CachedUsersCompanion(
      id: Value(id),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      cachedAt: Value(cachedAt),
      expiresAt: Value(expiresAt),
    );
  }

  factory CachedUser.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedUser(
      id: serializer.fromJson<String>(json['id']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      email: serializer.fromJson<String?>(json['email']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'displayName': serializer.toJson<String?>(displayName),
      'email': serializer.toJson<String?>(email),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
    };
  }

  CachedUser copyWith(
          {String? id,
          Value<String?> displayName = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> photoUrl = const Value.absent(),
          DateTime? cachedAt,
          DateTime? expiresAt}) =>
      CachedUser(
        id: id ?? this.id,
        displayName: displayName.present ? displayName.value : this.displayName,
        email: email.present ? email.value : this.email,
        photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
        cachedAt: cachedAt ?? this.cachedAt,
        expiresAt: expiresAt ?? this.expiresAt,
      );
  CachedUser copyWithCompanion(CachedUsersCompanion data) {
    return CachedUser(
      id: data.id.present ? data.id.value : this.id,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      email: data.email.present ? data.email.value : this.email,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedUser(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('email: $email, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, displayName, email, photoUrl, cachedAt, expiresAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedUser &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.email == this.email &&
          other.photoUrl == this.photoUrl &&
          other.cachedAt == this.cachedAt &&
          other.expiresAt == this.expiresAt);
}

class CachedUsersCompanion extends UpdateCompanion<CachedUser> {
  final Value<String> id;
  final Value<String?> displayName;
  final Value<String?> email;
  final Value<String?> photoUrl;
  final Value<DateTime> cachedAt;
  final Value<DateTime> expiresAt;
  final Value<int> rowid;
  const CachedUsersCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.email = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedUsersCompanion.insert({
    required String id,
    this.displayName = const Value.absent(),
    this.email = const Value.absent(),
    this.photoUrl = const Value.absent(),
    required DateTime cachedAt,
    required DateTime expiresAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        cachedAt = Value(cachedAt),
        expiresAt = Value(expiresAt);
  static Insertable<CachedUser> custom({
    Expression<String>? id,
    Expression<String>? displayName,
    Expression<String>? email,
    Expression<String>? photoUrl,
    Expression<DateTime>? cachedAt,
    Expression<DateTime>? expiresAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (email != null) 'email': email,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedUsersCompanion copyWith(
      {Value<String>? id,
      Value<String?>? displayName,
      Value<String?>? email,
      Value<String?>? photoUrl,
      Value<DateTime>? cachedAt,
      Value<DateTime>? expiresAt,
      Value<int>? rowid}) {
    return CachedUsersCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      cachedAt: cachedAt ?? this.cachedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedUsersCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('email: $email, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _operationTypeMeta =
      const VerificationMeta('operationType');
  @override
  late final GeneratedColumn<String> operationType = GeneratedColumn<String>(
      'operation_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _spaceIdMeta =
      const VerificationMeta('spaceId');
  @override
  late final GeneratedColumn<String> spaceId = GeneratedColumn<String>(
      'space_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _retryCountMeta =
      const VerificationMeta('retryCount');
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
      'retry_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _errorMessageMeta =
      const VerificationMeta('errorMessage');
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
      'error_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastAttemptAtMeta =
      const VerificationMeta('lastAttemptAt');
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>('last_attempt_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        operationType,
        entityType,
        entityId,
        spaceId,
        payload,
        status,
        retryCount,
        errorMessage,
        createdAt,
        lastAttemptAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(Insertable<SyncQueueData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('operation_type')) {
      context.handle(
          _operationTypeMeta,
          operationType.isAcceptableOrUnknown(
              data['operation_type']!, _operationTypeMeta));
    } else if (isInserting) {
      context.missing(_operationTypeMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('space_id')) {
      context.handle(_spaceIdMeta,
          spaceId.isAcceptableOrUnknown(data['space_id']!, _spaceIdMeta));
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('retry_count')) {
      context.handle(
          _retryCountMeta,
          retryCount.isAcceptableOrUnknown(
              data['retry_count']!, _retryCountMeta));
    }
    if (data.containsKey('error_message')) {
      context.handle(
          _errorMessageMeta,
          errorMessage.isAcceptableOrUnknown(
              data['error_message']!, _errorMessageMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
          _lastAttemptAtMeta,
          lastAttemptAt.isAcceptableOrUnknown(
              data['last_attempt_at']!, _lastAttemptAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      operationType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation_type'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      spaceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}space_id']),
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      retryCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retry_count'])!,
      errorMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_message']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_attempt_at']),
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final int id;
  final String operationType;
  final String entityType;
  final String entityId;
  final String? spaceId;
  final String payload;
  final String status;
  final int retryCount;
  final String? errorMessage;
  final DateTime createdAt;
  final DateTime? lastAttemptAt;
  const SyncQueueData(
      {required this.id,
      required this.operationType,
      required this.entityType,
      required this.entityId,
      this.spaceId,
      required this.payload,
      required this.status,
      required this.retryCount,
      this.errorMessage,
      required this.createdAt,
      this.lastAttemptAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['operation_type'] = Variable<String>(operationType);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    if (!nullToAbsent || spaceId != null) {
      map['space_id'] = Variable<String>(spaceId);
    }
    map['payload'] = Variable<String>(payload);
    map['status'] = Variable<String>(status);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      operationType: Value(operationType),
      entityType: Value(entityType),
      entityId: Value(entityId),
      spaceId: spaceId == null && nullToAbsent
          ? const Value.absent()
          : Value(spaceId),
      payload: Value(payload),
      status: Value(status),
      retryCount: Value(retryCount),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      createdAt: Value(createdAt),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
    );
  }

  factory SyncQueueData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      operationType: serializer.fromJson<String>(json['operationType']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      spaceId: serializer.fromJson<String?>(json['spaceId']),
      payload: serializer.fromJson<String>(json['payload']),
      status: serializer.fromJson<String>(json['status']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'operationType': serializer.toJson<String>(operationType),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'spaceId': serializer.toJson<String?>(spaceId),
      'payload': serializer.toJson<String>(payload),
      'status': serializer.toJson<String>(status),
      'retryCount': serializer.toJson<int>(retryCount),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
    };
  }

  SyncQueueData copyWith(
          {int? id,
          String? operationType,
          String? entityType,
          String? entityId,
          Value<String?> spaceId = const Value.absent(),
          String? payload,
          String? status,
          int? retryCount,
          Value<String?> errorMessage = const Value.absent(),
          DateTime? createdAt,
          Value<DateTime?> lastAttemptAt = const Value.absent()}) =>
      SyncQueueData(
        id: id ?? this.id,
        operationType: operationType ?? this.operationType,
        entityType: entityType ?? this.entityType,
        entityId: entityId ?? this.entityId,
        spaceId: spaceId.present ? spaceId.value : this.spaceId,
        payload: payload ?? this.payload,
        status: status ?? this.status,
        retryCount: retryCount ?? this.retryCount,
        errorMessage:
            errorMessage.present ? errorMessage.value : this.errorMessage,
        createdAt: createdAt ?? this.createdAt,
        lastAttemptAt:
            lastAttemptAt.present ? lastAttemptAt.value : this.lastAttemptAt,
      );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      operationType: data.operationType.present
          ? data.operationType.value
          : this.operationType,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      spaceId: data.spaceId.present ? data.spaceId.value : this.spaceId,
      payload: data.payload.present ? data.payload.value : this.payload,
      status: data.status.present ? data.status.value : this.status,
      retryCount:
          data.retryCount.present ? data.retryCount.value : this.retryCount,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('operationType: $operationType, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('spaceId: $spaceId, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      operationType,
      entityType,
      entityId,
      spaceId,
      payload,
      status,
      retryCount,
      errorMessage,
      createdAt,
      lastAttemptAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.operationType == this.operationType &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.spaceId == this.spaceId &&
          other.payload == this.payload &&
          other.status == this.status &&
          other.retryCount == this.retryCount &&
          other.errorMessage == this.errorMessage &&
          other.createdAt == this.createdAt &&
          other.lastAttemptAt == this.lastAttemptAt);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<String> operationType;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String?> spaceId;
  final Value<String> payload;
  final Value<String> status;
  final Value<int> retryCount;
  final Value<String?> errorMessage;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastAttemptAt;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.operationType = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.spaceId = const Value.absent(),
    this.payload = const Value.absent(),
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String operationType,
    required String entityType,
    required String entityId,
    this.spaceId = const Value.absent(),
    required String payload,
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.errorMessage = const Value.absent(),
    required DateTime createdAt,
    this.lastAttemptAt = const Value.absent(),
  })  : operationType = Value(operationType),
        entityType = Value(entityType),
        entityId = Value(entityId),
        payload = Value(payload),
        createdAt = Value(createdAt);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<String>? operationType,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? spaceId,
    Expression<String>? payload,
    Expression<String>? status,
    Expression<int>? retryCount,
    Expression<String>? errorMessage,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastAttemptAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (operationType != null) 'operation_type': operationType,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (spaceId != null) 'space_id': spaceId,
      if (payload != null) 'payload': payload,
      if (status != null) 'status': status,
      if (retryCount != null) 'retry_count': retryCount,
      if (errorMessage != null) 'error_message': errorMessage,
      if (createdAt != null) 'created_at': createdAt,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
    });
  }

  SyncQueueCompanion copyWith(
      {Value<int>? id,
      Value<String>? operationType,
      Value<String>? entityType,
      Value<String>? entityId,
      Value<String?>? spaceId,
      Value<String>? payload,
      Value<String>? status,
      Value<int>? retryCount,
      Value<String?>? errorMessage,
      Value<DateTime>? createdAt,
      Value<DateTime?>? lastAttemptAt}) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      operationType: operationType ?? this.operationType,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      spaceId: spaceId ?? this.spaceId,
      payload: payload ?? this.payload,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (operationType.present) {
      map['operation_type'] = Variable<String>(operationType.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (spaceId.present) {
      map['space_id'] = Variable<String>(spaceId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('operationType: $operationType, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('spaceId: $spaceId, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt')
          ..write(')'))
        .toString();
  }
}

class $RecentItemsTable extends RecentItems
    with TableInfo<$RecentItemsTable, RecentItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecentItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _itemTypeMeta =
      const VerificationMeta('itemType');
  @override
  late final GeneratedColumn<String> itemType = GeneratedColumn<String>(
      'item_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
      'item_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _spaceIdMeta =
      const VerificationMeta('spaceId');
  @override
  late final GeneratedColumn<String> spaceId = GeneratedColumn<String>(
      'space_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _accessedAtMeta =
      const VerificationMeta('accessedAt');
  @override
  late final GeneratedColumn<DateTime> accessedAt = GeneratedColumn<DateTime>(
      'accessed_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, itemType, itemId, title, spaceId, path, accessedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recent_items';
  @override
  VerificationContext validateIntegrity(Insertable<RecentItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_type')) {
      context.handle(_itemTypeMeta,
          itemType.isAcceptableOrUnknown(data['item_type']!, _itemTypeMeta));
    } else if (isInserting) {
      context.missing(_itemTypeMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('space_id')) {
      context.handle(_spaceIdMeta,
          spaceId.isAcceptableOrUnknown(data['space_id']!, _spaceIdMeta));
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    }
    if (data.containsKey('accessed_at')) {
      context.handle(
          _accessedAtMeta,
          accessedAt.isAcceptableOrUnknown(
              data['accessed_at']!, _accessedAtMeta));
    } else if (isInserting) {
      context.missing(_accessedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecentItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecentItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      itemType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_type'])!,
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      spaceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}space_id']),
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path']),
      accessedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}accessed_at'])!,
    );
  }

  @override
  $RecentItemsTable createAlias(String alias) {
    return $RecentItemsTable(attachedDatabase, alias);
  }
}

class RecentItem extends DataClass implements Insertable<RecentItem> {
  final int id;
  final String itemType;
  final String itemId;
  final String title;
  final String? spaceId;
  final String? path;
  final DateTime accessedAt;
  const RecentItem(
      {required this.id,
      required this.itemType,
      required this.itemId,
      required this.title,
      this.spaceId,
      this.path,
      required this.accessedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['item_type'] = Variable<String>(itemType);
    map['item_id'] = Variable<String>(itemId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || spaceId != null) {
      map['space_id'] = Variable<String>(spaceId);
    }
    if (!nullToAbsent || path != null) {
      map['path'] = Variable<String>(path);
    }
    map['accessed_at'] = Variable<DateTime>(accessedAt);
    return map;
  }

  RecentItemsCompanion toCompanion(bool nullToAbsent) {
    return RecentItemsCompanion(
      id: Value(id),
      itemType: Value(itemType),
      itemId: Value(itemId),
      title: Value(title),
      spaceId: spaceId == null && nullToAbsent
          ? const Value.absent()
          : Value(spaceId),
      path: path == null && nullToAbsent ? const Value.absent() : Value(path),
      accessedAt: Value(accessedAt),
    );
  }

  factory RecentItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecentItem(
      id: serializer.fromJson<int>(json['id']),
      itemType: serializer.fromJson<String>(json['itemType']),
      itemId: serializer.fromJson<String>(json['itemId']),
      title: serializer.fromJson<String>(json['title']),
      spaceId: serializer.fromJson<String?>(json['spaceId']),
      path: serializer.fromJson<String?>(json['path']),
      accessedAt: serializer.fromJson<DateTime>(json['accessedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemType': serializer.toJson<String>(itemType),
      'itemId': serializer.toJson<String>(itemId),
      'title': serializer.toJson<String>(title),
      'spaceId': serializer.toJson<String?>(spaceId),
      'path': serializer.toJson<String?>(path),
      'accessedAt': serializer.toJson<DateTime>(accessedAt),
    };
  }

  RecentItem copyWith(
          {int? id,
          String? itemType,
          String? itemId,
          String? title,
          Value<String?> spaceId = const Value.absent(),
          Value<String?> path = const Value.absent(),
          DateTime? accessedAt}) =>
      RecentItem(
        id: id ?? this.id,
        itemType: itemType ?? this.itemType,
        itemId: itemId ?? this.itemId,
        title: title ?? this.title,
        spaceId: spaceId.present ? spaceId.value : this.spaceId,
        path: path.present ? path.value : this.path,
        accessedAt: accessedAt ?? this.accessedAt,
      );
  RecentItem copyWithCompanion(RecentItemsCompanion data) {
    return RecentItem(
      id: data.id.present ? data.id.value : this.id,
      itemType: data.itemType.present ? data.itemType.value : this.itemType,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      title: data.title.present ? data.title.value : this.title,
      spaceId: data.spaceId.present ? data.spaceId.value : this.spaceId,
      path: data.path.present ? data.path.value : this.path,
      accessedAt:
          data.accessedAt.present ? data.accessedAt.value : this.accessedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecentItem(')
          ..write('id: $id, ')
          ..write('itemType: $itemType, ')
          ..write('itemId: $itemId, ')
          ..write('title: $title, ')
          ..write('spaceId: $spaceId, ')
          ..write('path: $path, ')
          ..write('accessedAt: $accessedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, itemType, itemId, title, spaceId, path, accessedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecentItem &&
          other.id == this.id &&
          other.itemType == this.itemType &&
          other.itemId == this.itemId &&
          other.title == this.title &&
          other.spaceId == this.spaceId &&
          other.path == this.path &&
          other.accessedAt == this.accessedAt);
}

class RecentItemsCompanion extends UpdateCompanion<RecentItem> {
  final Value<int> id;
  final Value<String> itemType;
  final Value<String> itemId;
  final Value<String> title;
  final Value<String?> spaceId;
  final Value<String?> path;
  final Value<DateTime> accessedAt;
  const RecentItemsCompanion({
    this.id = const Value.absent(),
    this.itemType = const Value.absent(),
    this.itemId = const Value.absent(),
    this.title = const Value.absent(),
    this.spaceId = const Value.absent(),
    this.path = const Value.absent(),
    this.accessedAt = const Value.absent(),
  });
  RecentItemsCompanion.insert({
    this.id = const Value.absent(),
    required String itemType,
    required String itemId,
    required String title,
    this.spaceId = const Value.absent(),
    this.path = const Value.absent(),
    required DateTime accessedAt,
  })  : itemType = Value(itemType),
        itemId = Value(itemId),
        title = Value(title),
        accessedAt = Value(accessedAt);
  static Insertable<RecentItem> custom({
    Expression<int>? id,
    Expression<String>? itemType,
    Expression<String>? itemId,
    Expression<String>? title,
    Expression<String>? spaceId,
    Expression<String>? path,
    Expression<DateTime>? accessedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemType != null) 'item_type': itemType,
      if (itemId != null) 'item_id': itemId,
      if (title != null) 'title': title,
      if (spaceId != null) 'space_id': spaceId,
      if (path != null) 'path': path,
      if (accessedAt != null) 'accessed_at': accessedAt,
    });
  }

  RecentItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? itemType,
      Value<String>? itemId,
      Value<String>? title,
      Value<String?>? spaceId,
      Value<String?>? path,
      Value<DateTime>? accessedAt}) {
    return RecentItemsCompanion(
      id: id ?? this.id,
      itemType: itemType ?? this.itemType,
      itemId: itemId ?? this.itemId,
      title: title ?? this.title,
      spaceId: spaceId ?? this.spaceId,
      path: path ?? this.path,
      accessedAt: accessedAt ?? this.accessedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemType.present) {
      map['item_type'] = Variable<String>(itemType.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (spaceId.present) {
      map['space_id'] = Variable<String>(spaceId.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (accessedAt.present) {
      map['accessed_at'] = Variable<DateTime>(accessedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecentItemsCompanion(')
          ..write('id: $id, ')
          ..write('itemType: $itemType, ')
          ..write('itemId: $itemId, ')
          ..write('title: $title, ')
          ..write('spaceId: $spaceId, ')
          ..write('path: $path, ')
          ..write('accessedAt: $accessedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CachedOrganizationsTable cachedOrganizations =
      $CachedOrganizationsTable(this);
  late final $CachedSpacesTable cachedSpaces = $CachedSpacesTable(this);
  late final $CachedContentTable cachedContent = $CachedContentTable(this);
  late final $CachedDocumentsTable cachedDocuments =
      $CachedDocumentsTable(this);
  late final $CachedUsersTable cachedUsers = $CachedUsersTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $RecentItemsTable recentItems = $RecentItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        cachedOrganizations,
        cachedSpaces,
        cachedContent,
        cachedDocuments,
        cachedUsers,
        syncQueue,
        recentItems
      ];
}

typedef $$CachedOrganizationsTableCreateCompanionBuilder
    = CachedOrganizationsCompanion Function({
  required String id,
  required String title,
  Value<String?> urlsLocation,
  Value<String?> urlsApp,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  required DateTime cachedAt,
  required DateTime expiresAt,
  Value<int> rowid,
});
typedef $$CachedOrganizationsTableUpdateCompanionBuilder
    = CachedOrganizationsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String?> urlsLocation,
  Value<String?> urlsApp,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime> cachedAt,
  Value<DateTime> expiresAt,
  Value<int> rowid,
});

class $$CachedOrganizationsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedOrganizationsTable> {
  $$CachedOrganizationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get urlsLocation => $composableBuilder(
      column: $table.urlsLocation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get urlsApp => $composableBuilder(
      column: $table.urlsApp, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
      column: $table.expiresAt, builder: (column) => ColumnFilters(column));
}

class $$CachedOrganizationsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedOrganizationsTable> {
  $$CachedOrganizationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get urlsLocation => $composableBuilder(
      column: $table.urlsLocation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get urlsApp => $composableBuilder(
      column: $table.urlsApp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
      column: $table.expiresAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedOrganizationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedOrganizationsTable> {
  $$CachedOrganizationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get urlsLocation => $composableBuilder(
      column: $table.urlsLocation, builder: (column) => column);

  GeneratedColumn<String> get urlsApp =>
      $composableBuilder(column: $table.urlsApp, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);
}

class $$CachedOrganizationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedOrganizationsTable,
    CachedOrganization,
    $$CachedOrganizationsTableFilterComposer,
    $$CachedOrganizationsTableOrderingComposer,
    $$CachedOrganizationsTableAnnotationComposer,
    $$CachedOrganizationsTableCreateCompanionBuilder,
    $$CachedOrganizationsTableUpdateCompanionBuilder,
    (
      CachedOrganization,
      BaseReferences<_$AppDatabase, $CachedOrganizationsTable,
          CachedOrganization>
    ),
    CachedOrganization,
    PrefetchHooks Function()> {
  $$CachedOrganizationsTableTableManager(
      _$AppDatabase db, $CachedOrganizationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedOrganizationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedOrganizationsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedOrganizationsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> urlsLocation = const Value.absent(),
            Value<String?> urlsApp = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<DateTime> expiresAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedOrganizationsCompanion(
            id: id,
            title: title,
            urlsLocation: urlsLocation,
            urlsApp: urlsApp,
            createdAt: createdAt,
            updatedAt: updatedAt,
            cachedAt: cachedAt,
            expiresAt: expiresAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> urlsLocation = const Value.absent(),
            Value<String?> urlsApp = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            required DateTime cachedAt,
            required DateTime expiresAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedOrganizationsCompanion.insert(
            id: id,
            title: title,
            urlsLocation: urlsLocation,
            urlsApp: urlsApp,
            createdAt: createdAt,
            updatedAt: updatedAt,
            cachedAt: cachedAt,
            expiresAt: expiresAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedOrganizationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedOrganizationsTable,
    CachedOrganization,
    $$CachedOrganizationsTableFilterComposer,
    $$CachedOrganizationsTableOrderingComposer,
    $$CachedOrganizationsTableAnnotationComposer,
    $$CachedOrganizationsTableCreateCompanionBuilder,
    $$CachedOrganizationsTableUpdateCompanionBuilder,
    (
      CachedOrganization,
      BaseReferences<_$AppDatabase, $CachedOrganizationsTable,
          CachedOrganization>
    ),
    CachedOrganization,
    PrefetchHooks Function()>;
typedef $$CachedSpacesTableCreateCompanionBuilder = CachedSpacesCompanion
    Function({
  required String id,
  required String title,
  Value<String?> description,
  Value<String?> visibility,
  Value<String?> organizationId,
  Value<String?> urlsLocation,
  Value<String?> urlsApp,
  Value<String?> urlsPublished,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  required DateTime cachedAt,
  required DateTime expiresAt,
  Value<int> rowid,
});
typedef $$CachedSpacesTableUpdateCompanionBuilder = CachedSpacesCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<String?> description,
  Value<String?> visibility,
  Value<String?> organizationId,
  Value<String?> urlsLocation,
  Value<String?> urlsApp,
  Value<String?> urlsPublished,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  Value<DateTime> cachedAt,
  Value<DateTime> expiresAt,
  Value<int> rowid,
});

class $$CachedSpacesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedSpacesTable> {
  $$CachedSpacesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get visibility => $composableBuilder(
      column: $table.visibility, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get organizationId => $composableBuilder(
      column: $table.organizationId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get urlsLocation => $composableBuilder(
      column: $table.urlsLocation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get urlsApp => $composableBuilder(
      column: $table.urlsApp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get urlsPublished => $composableBuilder(
      column: $table.urlsPublished, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
      column: $table.expiresAt, builder: (column) => ColumnFilters(column));
}

class $$CachedSpacesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedSpacesTable> {
  $$CachedSpacesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get visibility => $composableBuilder(
      column: $table.visibility, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get organizationId => $composableBuilder(
      column: $table.organizationId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get urlsLocation => $composableBuilder(
      column: $table.urlsLocation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get urlsApp => $composableBuilder(
      column: $table.urlsApp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get urlsPublished => $composableBuilder(
      column: $table.urlsPublished,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
      column: $table.expiresAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedSpacesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedSpacesTable> {
  $$CachedSpacesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get visibility => $composableBuilder(
      column: $table.visibility, builder: (column) => column);

  GeneratedColumn<String> get organizationId => $composableBuilder(
      column: $table.organizationId, builder: (column) => column);

  GeneratedColumn<String> get urlsLocation => $composableBuilder(
      column: $table.urlsLocation, builder: (column) => column);

  GeneratedColumn<String> get urlsApp =>
      $composableBuilder(column: $table.urlsApp, builder: (column) => column);

  GeneratedColumn<String> get urlsPublished => $composableBuilder(
      column: $table.urlsPublished, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);
}

class $$CachedSpacesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedSpacesTable,
    CachedSpace,
    $$CachedSpacesTableFilterComposer,
    $$CachedSpacesTableOrderingComposer,
    $$CachedSpacesTableAnnotationComposer,
    $$CachedSpacesTableCreateCompanionBuilder,
    $$CachedSpacesTableUpdateCompanionBuilder,
    (
      CachedSpace,
      BaseReferences<_$AppDatabase, $CachedSpacesTable, CachedSpace>
    ),
    CachedSpace,
    PrefetchHooks Function()> {
  $$CachedSpacesTableTableManager(_$AppDatabase db, $CachedSpacesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedSpacesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedSpacesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedSpacesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> visibility = const Value.absent(),
            Value<String?> organizationId = const Value.absent(),
            Value<String?> urlsLocation = const Value.absent(),
            Value<String?> urlsApp = const Value.absent(),
            Value<String?> urlsPublished = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<DateTime> expiresAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedSpacesCompanion(
            id: id,
            title: title,
            description: description,
            visibility: visibility,
            organizationId: organizationId,
            urlsLocation: urlsLocation,
            urlsApp: urlsApp,
            urlsPublished: urlsPublished,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            cachedAt: cachedAt,
            expiresAt: expiresAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> description = const Value.absent(),
            Value<String?> visibility = const Value.absent(),
            Value<String?> organizationId = const Value.absent(),
            Value<String?> urlsLocation = const Value.absent(),
            Value<String?> urlsApp = const Value.absent(),
            Value<String?> urlsPublished = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required DateTime cachedAt,
            required DateTime expiresAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedSpacesCompanion.insert(
            id: id,
            title: title,
            description: description,
            visibility: visibility,
            organizationId: organizationId,
            urlsLocation: urlsLocation,
            urlsApp: urlsApp,
            urlsPublished: urlsPublished,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            cachedAt: cachedAt,
            expiresAt: expiresAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedSpacesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedSpacesTable,
    CachedSpace,
    $$CachedSpacesTableFilterComposer,
    $$CachedSpacesTableOrderingComposer,
    $$CachedSpacesTableAnnotationComposer,
    $$CachedSpacesTableCreateCompanionBuilder,
    $$CachedSpacesTableUpdateCompanionBuilder,
    (
      CachedSpace,
      BaseReferences<_$AppDatabase, $CachedSpacesTable, CachedSpace>
    ),
    CachedSpace,
    PrefetchHooks Function()>;
typedef $$CachedContentTableCreateCompanionBuilder = CachedContentCompanion
    Function({
  required String id,
  required String spaceId,
  required String title,
  required String type,
  Value<String?> path,
  Value<String?> slug,
  Value<String?> description,
  Value<String?> parentId,
  Value<int> orderIndex,
  Value<String?> urlsLocation,
  Value<String?> urlsApp,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  required DateTime cachedAt,
  required DateTime expiresAt,
  Value<int> rowid,
});
typedef $$CachedContentTableUpdateCompanionBuilder = CachedContentCompanion
    Function({
  Value<String> id,
  Value<String> spaceId,
  Value<String> title,
  Value<String> type,
  Value<String?> path,
  Value<String?> slug,
  Value<String?> description,
  Value<String?> parentId,
  Value<int> orderIndex,
  Value<String?> urlsLocation,
  Value<String?> urlsApp,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime> cachedAt,
  Value<DateTime> expiresAt,
  Value<int> rowid,
});

class $$CachedContentTableFilterComposer
    extends Composer<_$AppDatabase, $CachedContentTable> {
  $$CachedContentTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get spaceId => $composableBuilder(
      column: $table.spaceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get parentId => $composableBuilder(
      column: $table.parentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get urlsLocation => $composableBuilder(
      column: $table.urlsLocation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get urlsApp => $composableBuilder(
      column: $table.urlsApp, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
      column: $table.expiresAt, builder: (column) => ColumnFilters(column));
}

class $$CachedContentTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedContentTable> {
  $$CachedContentTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get spaceId => $composableBuilder(
      column: $table.spaceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get parentId => $composableBuilder(
      column: $table.parentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get urlsLocation => $composableBuilder(
      column: $table.urlsLocation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get urlsApp => $composableBuilder(
      column: $table.urlsApp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
      column: $table.expiresAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedContentTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedContentTable> {
  $$CachedContentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get spaceId =>
      $composableBuilder(column: $table.spaceId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => column);

  GeneratedColumn<String> get urlsLocation => $composableBuilder(
      column: $table.urlsLocation, builder: (column) => column);

  GeneratedColumn<String> get urlsApp =>
      $composableBuilder(column: $table.urlsApp, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);
}

class $$CachedContentTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedContentTable,
    CachedContentData,
    $$CachedContentTableFilterComposer,
    $$CachedContentTableOrderingComposer,
    $$CachedContentTableAnnotationComposer,
    $$CachedContentTableCreateCompanionBuilder,
    $$CachedContentTableUpdateCompanionBuilder,
    (
      CachedContentData,
      BaseReferences<_$AppDatabase, $CachedContentTable, CachedContentData>
    ),
    CachedContentData,
    PrefetchHooks Function()> {
  $$CachedContentTableTableManager(_$AppDatabase db, $CachedContentTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedContentTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedContentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedContentTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> spaceId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String?> path = const Value.absent(),
            Value<String?> slug = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> parentId = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<String?> urlsLocation = const Value.absent(),
            Value<String?> urlsApp = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<DateTime> expiresAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedContentCompanion(
            id: id,
            spaceId: spaceId,
            title: title,
            type: type,
            path: path,
            slug: slug,
            description: description,
            parentId: parentId,
            orderIndex: orderIndex,
            urlsLocation: urlsLocation,
            urlsApp: urlsApp,
            createdAt: createdAt,
            updatedAt: updatedAt,
            cachedAt: cachedAt,
            expiresAt: expiresAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String spaceId,
            required String title,
            required String type,
            Value<String?> path = const Value.absent(),
            Value<String?> slug = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> parentId = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<String?> urlsLocation = const Value.absent(),
            Value<String?> urlsApp = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            required DateTime cachedAt,
            required DateTime expiresAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedContentCompanion.insert(
            id: id,
            spaceId: spaceId,
            title: title,
            type: type,
            path: path,
            slug: slug,
            description: description,
            parentId: parentId,
            orderIndex: orderIndex,
            urlsLocation: urlsLocation,
            urlsApp: urlsApp,
            createdAt: createdAt,
            updatedAt: updatedAt,
            cachedAt: cachedAt,
            expiresAt: expiresAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedContentTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedContentTable,
    CachedContentData,
    $$CachedContentTableFilterComposer,
    $$CachedContentTableOrderingComposer,
    $$CachedContentTableAnnotationComposer,
    $$CachedContentTableCreateCompanionBuilder,
    $$CachedContentTableUpdateCompanionBuilder,
    (
      CachedContentData,
      BaseReferences<_$AppDatabase, $CachedContentTable, CachedContentData>
    ),
    CachedContentData,
    PrefetchHooks Function()>;
typedef $$CachedDocumentsTableCreateCompanionBuilder = CachedDocumentsCompanion
    Function({
  required String pageId,
  required String spaceId,
  Value<String?> markdown,
  Value<String?> nodesJson,
  required DateTime cachedAt,
  required DateTime expiresAt,
  Value<int> rowid,
});
typedef $$CachedDocumentsTableUpdateCompanionBuilder = CachedDocumentsCompanion
    Function({
  Value<String> pageId,
  Value<String> spaceId,
  Value<String?> markdown,
  Value<String?> nodesJson,
  Value<DateTime> cachedAt,
  Value<DateTime> expiresAt,
  Value<int> rowid,
});

class $$CachedDocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedDocumentsTable> {
  $$CachedDocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get pageId => $composableBuilder(
      column: $table.pageId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get spaceId => $composableBuilder(
      column: $table.spaceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get markdown => $composableBuilder(
      column: $table.markdown, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nodesJson => $composableBuilder(
      column: $table.nodesJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
      column: $table.expiresAt, builder: (column) => ColumnFilters(column));
}

class $$CachedDocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedDocumentsTable> {
  $$CachedDocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get pageId => $composableBuilder(
      column: $table.pageId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get spaceId => $composableBuilder(
      column: $table.spaceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get markdown => $composableBuilder(
      column: $table.markdown, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nodesJson => $composableBuilder(
      column: $table.nodesJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
      column: $table.expiresAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedDocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedDocumentsTable> {
  $$CachedDocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get pageId =>
      $composableBuilder(column: $table.pageId, builder: (column) => column);

  GeneratedColumn<String> get spaceId =>
      $composableBuilder(column: $table.spaceId, builder: (column) => column);

  GeneratedColumn<String> get markdown =>
      $composableBuilder(column: $table.markdown, builder: (column) => column);

  GeneratedColumn<String> get nodesJson =>
      $composableBuilder(column: $table.nodesJson, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);
}

class $$CachedDocumentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedDocumentsTable,
    CachedDocument,
    $$CachedDocumentsTableFilterComposer,
    $$CachedDocumentsTableOrderingComposer,
    $$CachedDocumentsTableAnnotationComposer,
    $$CachedDocumentsTableCreateCompanionBuilder,
    $$CachedDocumentsTableUpdateCompanionBuilder,
    (
      CachedDocument,
      BaseReferences<_$AppDatabase, $CachedDocumentsTable, CachedDocument>
    ),
    CachedDocument,
    PrefetchHooks Function()> {
  $$CachedDocumentsTableTableManager(
      _$AppDatabase db, $CachedDocumentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedDocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedDocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedDocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> pageId = const Value.absent(),
            Value<String> spaceId = const Value.absent(),
            Value<String?> markdown = const Value.absent(),
            Value<String?> nodesJson = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<DateTime> expiresAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedDocumentsCompanion(
            pageId: pageId,
            spaceId: spaceId,
            markdown: markdown,
            nodesJson: nodesJson,
            cachedAt: cachedAt,
            expiresAt: expiresAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String pageId,
            required String spaceId,
            Value<String?> markdown = const Value.absent(),
            Value<String?> nodesJson = const Value.absent(),
            required DateTime cachedAt,
            required DateTime expiresAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedDocumentsCompanion.insert(
            pageId: pageId,
            spaceId: spaceId,
            markdown: markdown,
            nodesJson: nodesJson,
            cachedAt: cachedAt,
            expiresAt: expiresAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedDocumentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedDocumentsTable,
    CachedDocument,
    $$CachedDocumentsTableFilterComposer,
    $$CachedDocumentsTableOrderingComposer,
    $$CachedDocumentsTableAnnotationComposer,
    $$CachedDocumentsTableCreateCompanionBuilder,
    $$CachedDocumentsTableUpdateCompanionBuilder,
    (
      CachedDocument,
      BaseReferences<_$AppDatabase, $CachedDocumentsTable, CachedDocument>
    ),
    CachedDocument,
    PrefetchHooks Function()>;
typedef $$CachedUsersTableCreateCompanionBuilder = CachedUsersCompanion
    Function({
  required String id,
  Value<String?> displayName,
  Value<String?> email,
  Value<String?> photoUrl,
  required DateTime cachedAt,
  required DateTime expiresAt,
  Value<int> rowid,
});
typedef $$CachedUsersTableUpdateCompanionBuilder = CachedUsersCompanion
    Function({
  Value<String> id,
  Value<String?> displayName,
  Value<String?> email,
  Value<String?> photoUrl,
  Value<DateTime> cachedAt,
  Value<DateTime> expiresAt,
  Value<int> rowid,
});

class $$CachedUsersTableFilterComposer
    extends Composer<_$AppDatabase, $CachedUsersTable> {
  $$CachedUsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoUrl => $composableBuilder(
      column: $table.photoUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
      column: $table.expiresAt, builder: (column) => ColumnFilters(column));
}

class $$CachedUsersTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedUsersTable> {
  $$CachedUsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoUrl => $composableBuilder(
      column: $table.photoUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
      column: $table.expiresAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedUsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedUsersTable> {
  $$CachedUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);
}

class $$CachedUsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedUsersTable,
    CachedUser,
    $$CachedUsersTableFilterComposer,
    $$CachedUsersTableOrderingComposer,
    $$CachedUsersTableAnnotationComposer,
    $$CachedUsersTableCreateCompanionBuilder,
    $$CachedUsersTableUpdateCompanionBuilder,
    (CachedUser, BaseReferences<_$AppDatabase, $CachedUsersTable, CachedUser>),
    CachedUser,
    PrefetchHooks Function()> {
  $$CachedUsersTableTableManager(_$AppDatabase db, $CachedUsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> displayName = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> photoUrl = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<DateTime> expiresAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedUsersCompanion(
            id: id,
            displayName: displayName,
            email: email,
            photoUrl: photoUrl,
            cachedAt: cachedAt,
            expiresAt: expiresAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> displayName = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> photoUrl = const Value.absent(),
            required DateTime cachedAt,
            required DateTime expiresAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedUsersCompanion.insert(
            id: id,
            displayName: displayName,
            email: email,
            photoUrl: photoUrl,
            cachedAt: cachedAt,
            expiresAt: expiresAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedUsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedUsersTable,
    CachedUser,
    $$CachedUsersTableFilterComposer,
    $$CachedUsersTableOrderingComposer,
    $$CachedUsersTableAnnotationComposer,
    $$CachedUsersTableCreateCompanionBuilder,
    $$CachedUsersTableUpdateCompanionBuilder,
    (CachedUser, BaseReferences<_$AppDatabase, $CachedUsersTable, CachedUser>),
    CachedUser,
    PrefetchHooks Function()>;
typedef $$SyncQueueTableCreateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  required String operationType,
  required String entityType,
  required String entityId,
  Value<String?> spaceId,
  required String payload,
  Value<String> status,
  Value<int> retryCount,
  Value<String?> errorMessage,
  required DateTime createdAt,
  Value<DateTime?> lastAttemptAt,
});
typedef $$SyncQueueTableUpdateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  Value<String> operationType,
  Value<String> entityType,
  Value<String> entityId,
  Value<String?> spaceId,
  Value<String> payload,
  Value<String> status,
  Value<int> retryCount,
  Value<String?> errorMessage,
  Value<DateTime> createdAt,
  Value<DateTime?> lastAttemptAt,
});

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operationType => $composableBuilder(
      column: $table.operationType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get spaceId => $composableBuilder(
      column: $table.spaceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt, builder: (column) => ColumnFilters(column));
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operationType => $composableBuilder(
      column: $table.operationType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get spaceId => $composableBuilder(
      column: $table.spaceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt,
      builder: (column) => ColumnOrderings(column));
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get operationType => $composableBuilder(
      column: $table.operationType, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get spaceId =>
      $composableBuilder(column: $table.spaceId, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt, builder: (column) => column);
}

class $$SyncQueueTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (
      SyncQueueData,
      BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>
    ),
    SyncQueueData,
    PrefetchHooks Function()> {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> operationType = const Value.absent(),
            Value<String> entityType = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<String?> spaceId = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> lastAttemptAt = const Value.absent(),
          }) =>
              SyncQueueCompanion(
            id: id,
            operationType: operationType,
            entityType: entityType,
            entityId: entityId,
            spaceId: spaceId,
            payload: payload,
            status: status,
            retryCount: retryCount,
            errorMessage: errorMessage,
            createdAt: createdAt,
            lastAttemptAt: lastAttemptAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String operationType,
            required String entityType,
            required String entityId,
            Value<String?> spaceId = const Value.absent(),
            required String payload,
            Value<String> status = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> lastAttemptAt = const Value.absent(),
          }) =>
              SyncQueueCompanion.insert(
            id: id,
            operationType: operationType,
            entityType: entityType,
            entityId: entityId,
            spaceId: spaceId,
            payload: payload,
            status: status,
            retryCount: retryCount,
            errorMessage: errorMessage,
            createdAt: createdAt,
            lastAttemptAt: lastAttemptAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncQueueTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (
      SyncQueueData,
      BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>
    ),
    SyncQueueData,
    PrefetchHooks Function()>;
typedef $$RecentItemsTableCreateCompanionBuilder = RecentItemsCompanion
    Function({
  Value<int> id,
  required String itemType,
  required String itemId,
  required String title,
  Value<String?> spaceId,
  Value<String?> path,
  required DateTime accessedAt,
});
typedef $$RecentItemsTableUpdateCompanionBuilder = RecentItemsCompanion
    Function({
  Value<int> id,
  Value<String> itemType,
  Value<String> itemId,
  Value<String> title,
  Value<String?> spaceId,
  Value<String?> path,
  Value<DateTime> accessedAt,
});

class $$RecentItemsTableFilterComposer
    extends Composer<_$AppDatabase, $RecentItemsTable> {
  $$RecentItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemType => $composableBuilder(
      column: $table.itemType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get spaceId => $composableBuilder(
      column: $table.spaceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get accessedAt => $composableBuilder(
      column: $table.accessedAt, builder: (column) => ColumnFilters(column));
}

class $$RecentItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecentItemsTable> {
  $$RecentItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemType => $composableBuilder(
      column: $table.itemType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get spaceId => $composableBuilder(
      column: $table.spaceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get accessedAt => $composableBuilder(
      column: $table.accessedAt, builder: (column) => ColumnOrderings(column));
}

class $$RecentItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecentItemsTable> {
  $$RecentItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemType =>
      $composableBuilder(column: $table.itemType, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get spaceId =>
      $composableBuilder(column: $table.spaceId, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<DateTime> get accessedAt => $composableBuilder(
      column: $table.accessedAt, builder: (column) => column);
}

class $$RecentItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RecentItemsTable,
    RecentItem,
    $$RecentItemsTableFilterComposer,
    $$RecentItemsTableOrderingComposer,
    $$RecentItemsTableAnnotationComposer,
    $$RecentItemsTableCreateCompanionBuilder,
    $$RecentItemsTableUpdateCompanionBuilder,
    (RecentItem, BaseReferences<_$AppDatabase, $RecentItemsTable, RecentItem>),
    RecentItem,
    PrefetchHooks Function()> {
  $$RecentItemsTableTableManager(_$AppDatabase db, $RecentItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecentItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecentItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecentItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> itemType = const Value.absent(),
            Value<String> itemId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> spaceId = const Value.absent(),
            Value<String?> path = const Value.absent(),
            Value<DateTime> accessedAt = const Value.absent(),
          }) =>
              RecentItemsCompanion(
            id: id,
            itemType: itemType,
            itemId: itemId,
            title: title,
            spaceId: spaceId,
            path: path,
            accessedAt: accessedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String itemType,
            required String itemId,
            required String title,
            Value<String?> spaceId = const Value.absent(),
            Value<String?> path = const Value.absent(),
            required DateTime accessedAt,
          }) =>
              RecentItemsCompanion.insert(
            id: id,
            itemType: itemType,
            itemId: itemId,
            title: title,
            spaceId: spaceId,
            path: path,
            accessedAt: accessedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RecentItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RecentItemsTable,
    RecentItem,
    $$RecentItemsTableFilterComposer,
    $$RecentItemsTableOrderingComposer,
    $$RecentItemsTableAnnotationComposer,
    $$RecentItemsTableCreateCompanionBuilder,
    $$RecentItemsTableUpdateCompanionBuilder,
    (RecentItem, BaseReferences<_$AppDatabase, $RecentItemsTable, RecentItem>),
    RecentItem,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CachedOrganizationsTableTableManager get cachedOrganizations =>
      $$CachedOrganizationsTableTableManager(_db, _db.cachedOrganizations);
  $$CachedSpacesTableTableManager get cachedSpaces =>
      $$CachedSpacesTableTableManager(_db, _db.cachedSpaces);
  $$CachedContentTableTableManager get cachedContent =>
      $$CachedContentTableTableManager(_db, _db.cachedContent);
  $$CachedDocumentsTableTableManager get cachedDocuments =>
      $$CachedDocumentsTableTableManager(_db, _db.cachedDocuments);
  $$CachedUsersTableTableManager get cachedUsers =>
      $$CachedUsersTableTableManager(_db, _db.cachedUsers);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$RecentItemsTableTableManager get recentItems =>
      $$RecentItemsTableTableManager(_db, _db.recentItems);
}
