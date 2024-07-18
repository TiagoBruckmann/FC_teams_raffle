// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGamesCollectionCollection on Isar {
  IsarCollection<GamesCollection> get gamesCollections => this.collection();
}

const GamesCollectionSchema = CollectionSchema(
  name: r'GamesCollection',
  id: 3203350571436939986,
  properties: {
    r'listTournaments': PropertySchema(
      id: 0,
      name: r'listTournaments',
      type: IsarType.objectList,
      target: r'TournamentCollection',
    )
  },
  estimateSize: _gamesCollectionEstimateSize,
  serialize: _gamesCollectionSerialize,
  deserialize: _gamesCollectionDeserialize,
  deserializeProp: _gamesCollectionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'TournamentCollection': TournamentCollectionSchema,
    r'KeyCollection': KeyCollectionSchema,
    r'PlayerCollection': PlayerCollectionSchema
  },
  getId: _gamesCollectionGetId,
  getLinks: _gamesCollectionGetLinks,
  attach: _gamesCollectionAttach,
  version: '3.1.0+1',
);

int _gamesCollectionEstimateSize(
  GamesCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.listTournaments;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[TournamentCollection]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += TournamentCollectionSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  return bytesCount;
}

void _gamesCollectionSerialize(
  GamesCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<TournamentCollection>(
    offsets[0],
    allOffsets,
    TournamentCollectionSchema.serialize,
    object.listTournaments,
  );
}

GamesCollection _gamesCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GamesCollection(
    listTournaments: reader.readObjectList<TournamentCollection>(
      offsets[0],
      TournamentCollectionSchema.deserialize,
      allOffsets,
      TournamentCollection(),
    ),
  );
  object.id = id;
  return object;
}

P _gamesCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<TournamentCollection>(
        offset,
        TournamentCollectionSchema.deserialize,
        allOffsets,
        TournamentCollection(),
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _gamesCollectionGetId(GamesCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _gamesCollectionGetLinks(GamesCollection object) {
  return [];
}

void _gamesCollectionAttach(
    IsarCollection<dynamic> col, Id id, GamesCollection object) {
  object.id = id;
}

extension GamesCollectionQueryWhereSort
    on QueryBuilder<GamesCollection, GamesCollection, QWhere> {
  QueryBuilder<GamesCollection, GamesCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GamesCollectionQueryWhere
    on QueryBuilder<GamesCollection, GamesCollection, QWhereClause> {
  QueryBuilder<GamesCollection, GamesCollection, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GamesCollection, GamesCollection, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<GamesCollection, GamesCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GamesCollection, GamesCollection, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GamesCollection, GamesCollection, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GamesCollectionQueryFilter
    on QueryBuilder<GamesCollection, GamesCollection, QFilterCondition> {
  QueryBuilder<GamesCollection, GamesCollection, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GamesCollection, GamesCollection, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GamesCollection, GamesCollection, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GamesCollection, GamesCollection, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GamesCollection, GamesCollection, QAfterFilterCondition>
      listTournamentsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'listTournaments',
      ));
    });
  }

  QueryBuilder<GamesCollection, GamesCollection, QAfterFilterCondition>
      listTournamentsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'listTournaments',
      ));
    });
  }

  QueryBuilder<GamesCollection, GamesCollection, QAfterFilterCondition>
      listTournamentsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listTournaments',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<GamesCollection, GamesCollection, QAfterFilterCondition>
      listTournamentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listTournaments',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<GamesCollection, GamesCollection, QAfterFilterCondition>
      listTournamentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listTournaments',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GamesCollection, GamesCollection, QAfterFilterCondition>
      listTournamentsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listTournaments',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<GamesCollection, GamesCollection, QAfterFilterCondition>
      listTournamentsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listTournaments',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GamesCollection, GamesCollection, QAfterFilterCondition>
      listTournamentsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listTournaments',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension GamesCollectionQueryObject
    on QueryBuilder<GamesCollection, GamesCollection, QFilterCondition> {
  QueryBuilder<GamesCollection, GamesCollection, QAfterFilterCondition>
      listTournamentsElement(FilterQuery<TournamentCollection> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'listTournaments');
    });
  }
}

extension GamesCollectionQueryLinks
    on QueryBuilder<GamesCollection, GamesCollection, QFilterCondition> {}

extension GamesCollectionQuerySortBy
    on QueryBuilder<GamesCollection, GamesCollection, QSortBy> {}

extension GamesCollectionQuerySortThenBy
    on QueryBuilder<GamesCollection, GamesCollection, QSortThenBy> {
  QueryBuilder<GamesCollection, GamesCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GamesCollection, GamesCollection, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension GamesCollectionQueryWhereDistinct
    on QueryBuilder<GamesCollection, GamesCollection, QDistinct> {}

extension GamesCollectionQueryProperty
    on QueryBuilder<GamesCollection, GamesCollection, QQueryProperty> {
  QueryBuilder<GamesCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GamesCollection, List<TournamentCollection>?, QQueryOperations>
      listTournamentsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'listTournaments');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const TournamentCollectionSchema = Schema(
  name: r'TournamentCollection',
  id: -5871045532009332678,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.string,
    ),
    r'currentStep': PropertySchema(
      id: 1,
      name: r'currentStep',
      type: IsarType.string,
    ),
    r'date': PropertySchema(
      id: 2,
      name: r'date',
      type: IsarType.string,
    ),
    r'defeats': PropertySchema(
      id: 3,
      name: r'defeats',
      type: IsarType.long,
    ),
    r'drawTeams': PropertySchema(
      id: 4,
      name: r'drawTeams',
      type: IsarType.bool,
    ),
    r'isActive': PropertySchema(
      id: 5,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'listKeys': PropertySchema(
      id: 6,
      name: r'listKeys',
      type: IsarType.objectList,
      target: r'KeyCollection',
    ),
    r'name': PropertySchema(
      id: 7,
      name: r'name',
      type: IsarType.string,
    ),
    r'quantityGames': PropertySchema(
      id: 8,
      name: r'quantityGames',
      type: IsarType.long,
    ),
    r'quantityPlayers': PropertySchema(
      id: 9,
      name: r'quantityPlayers',
      type: IsarType.long,
    )
  },
  estimateSize: _tournamentCollectionEstimateSize,
  serialize: _tournamentCollectionSerialize,
  deserialize: _tournamentCollectionDeserialize,
  deserializeProp: _tournamentCollectionDeserializeProp,
);

int _tournamentCollectionEstimateSize(
  TournamentCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.createdAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.currentStep;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.date;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.listKeys;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[KeyCollection]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              KeyCollectionSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _tournamentCollectionSerialize(
  TournamentCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.currentStep);
  writer.writeString(offsets[2], object.date);
  writer.writeLong(offsets[3], object.defeats);
  writer.writeBool(offsets[4], object.drawTeams);
  writer.writeBool(offsets[5], object.isActive);
  writer.writeObjectList<KeyCollection>(
    offsets[6],
    allOffsets,
    KeyCollectionSchema.serialize,
    object.listKeys,
  );
  writer.writeString(offsets[7], object.name);
  writer.writeLong(offsets[8], object.quantityGames);
  writer.writeLong(offsets[9], object.quantityPlayers);
}

TournamentCollection _tournamentCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TournamentCollection(
    createdAt: reader.readStringOrNull(offsets[0]),
    currentStep: reader.readStringOrNull(offsets[1]),
    date: reader.readStringOrNull(offsets[2]),
    defeats: reader.readLongOrNull(offsets[3]),
    drawTeams: reader.readBoolOrNull(offsets[4]),
    isActive: reader.readBoolOrNull(offsets[5]),
    listKeys: reader.readObjectList<KeyCollection>(
      offsets[6],
      KeyCollectionSchema.deserialize,
      allOffsets,
      KeyCollection(),
    ),
    name: reader.readStringOrNull(offsets[7]),
    quantityGames: reader.readLongOrNull(offsets[8]),
    quantityPlayers: reader.readLongOrNull(offsets[9]),
  );
  return object;
}

P _tournamentCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset)) as P;
    case 6:
      return (reader.readObjectList<KeyCollection>(
        offset,
        KeyCollectionSchema.deserialize,
        allOffsets,
        KeyCollection(),
      )) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension TournamentCollectionQueryFilter on QueryBuilder<TournamentCollection,
    TournamentCollection, QFilterCondition> {
  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> createdAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> createdAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> createdAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> createdAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> createdAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> createdAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
          QAfterFilterCondition>
      createdAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
          QAfterFilterCondition>
      createdAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> createdAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: '',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> createdAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdAt',
        value: '',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> currentStepIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'currentStep',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> currentStepIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'currentStep',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> currentStepEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentStep',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> currentStepGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentStep',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> currentStepLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentStep',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> currentStepBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentStep',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> currentStepStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currentStep',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> currentStepEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currentStep',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
          QAfterFilterCondition>
      currentStepContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currentStep',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
          QAfterFilterCondition>
      currentStepMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currentStep',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> currentStepIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentStep',
        value: '',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> currentStepIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currentStep',
        value: '',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> dateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> dateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> dateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> dateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> dateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> dateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
          QAfterFilterCondition>
      dateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
          QAfterFilterCondition>
      dateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'date',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> dateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: '',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> dateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'date',
        value: '',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> defeatsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'defeats',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> defeatsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'defeats',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> defeatsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defeats',
        value: value,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> defeatsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defeats',
        value: value,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> defeatsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defeats',
        value: value,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> defeatsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defeats',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> drawTeamsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'drawTeams',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> drawTeamsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'drawTeams',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> drawTeamsEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'drawTeams',
        value: value,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> isActiveIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isActive',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> isActiveIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isActive',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> isActiveEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> listKeysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'listKeys',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> listKeysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'listKeys',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> listKeysLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listKeys',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> listKeysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listKeys',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> listKeysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listKeys',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> listKeysLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listKeys',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> listKeysLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listKeys',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> listKeysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listKeys',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
          QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
          QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> quantityGamesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quantityGames',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> quantityGamesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quantityGames',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> quantityGamesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantityGames',
        value: value,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> quantityGamesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantityGames',
        value: value,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> quantityGamesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantityGames',
        value: value,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> quantityGamesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantityGames',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> quantityPlayersIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quantityPlayers',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> quantityPlayersIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quantityPlayers',
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> quantityPlayersEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantityPlayers',
        value: value,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> quantityPlayersGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantityPlayers',
        value: value,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> quantityPlayersLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantityPlayers',
        value: value,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> quantityPlayersBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantityPlayers',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TournamentCollectionQueryObject on QueryBuilder<TournamentCollection,
    TournamentCollection, QFilterCondition> {
  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> listKeysElement(FilterQuery<KeyCollection> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'listKeys');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const KeyCollectionSchema = Schema(
  name: r'KeyCollection',
  id: 3688524552406408907,
  properties: {
    r'player1': PropertySchema(
      id: 0,
      name: r'player1',
      type: IsarType.object,
      target: r'PlayerCollection',
    ),
    r'player1Scoreboard': PropertySchema(
      id: 1,
      name: r'player1Scoreboard',
      type: IsarType.long,
    ),
    r'player2': PropertySchema(
      id: 2,
      name: r'player2',
      type: IsarType.object,
      target: r'PlayerCollection',
    ),
    r'player2Scoreboard': PropertySchema(
      id: 3,
      name: r'player2Scoreboard',
      type: IsarType.long,
    ),
    r'position': PropertySchema(
      id: 4,
      name: r'position',
      type: IsarType.long,
    ),
    r'winner': PropertySchema(
      id: 5,
      name: r'winner',
      type: IsarType.string,
    )
  },
  estimateSize: _keyCollectionEstimateSize,
  serialize: _keyCollectionSerialize,
  deserialize: _keyCollectionDeserialize,
  deserializeProp: _keyCollectionDeserializeProp,
);

int _keyCollectionEstimateSize(
  KeyCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.player1;
    if (value != null) {
      bytesCount += 3 +
          PlayerCollectionSchema.estimateSize(
              value, allOffsets[PlayerCollection]!, allOffsets);
    }
  }
  {
    final value = object.player2;
    if (value != null) {
      bytesCount += 3 +
          PlayerCollectionSchema.estimateSize(
              value, allOffsets[PlayerCollection]!, allOffsets);
    }
  }
  {
    final value = object.winner;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _keyCollectionSerialize(
  KeyCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<PlayerCollection>(
    offsets[0],
    allOffsets,
    PlayerCollectionSchema.serialize,
    object.player1,
  );
  writer.writeLong(offsets[1], object.player1Scoreboard);
  writer.writeObject<PlayerCollection>(
    offsets[2],
    allOffsets,
    PlayerCollectionSchema.serialize,
    object.player2,
  );
  writer.writeLong(offsets[3], object.player2Scoreboard);
  writer.writeLong(offsets[4], object.position);
  writer.writeString(offsets[5], object.winner);
}

KeyCollection _keyCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = KeyCollection(
    player1: reader.readObjectOrNull<PlayerCollection>(
      offsets[0],
      PlayerCollectionSchema.deserialize,
      allOffsets,
    ),
    player1Scoreboard: reader.readLongOrNull(offsets[1]),
    player2: reader.readObjectOrNull<PlayerCollection>(
      offsets[2],
      PlayerCollectionSchema.deserialize,
      allOffsets,
    ),
    player2Scoreboard: reader.readLongOrNull(offsets[3]),
    position: reader.readLongOrNull(offsets[4]),
    winner: reader.readStringOrNull(offsets[5]),
  );
  return object;
}

P _keyCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<PlayerCollection>(
        offset,
        PlayerCollectionSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readObjectOrNull<PlayerCollection>(
        offset,
        PlayerCollectionSchema.deserialize,
        allOffsets,
      )) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension KeyCollectionQueryFilter
    on QueryBuilder<KeyCollection, KeyCollection, QFilterCondition> {
  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      player1IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'player1',
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      player1IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'player1',
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      player1ScoreboardIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'player1Scoreboard',
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      player1ScoreboardIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'player1Scoreboard',
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      player1ScoreboardEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'player1Scoreboard',
        value: value,
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      player1ScoreboardGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'player1Scoreboard',
        value: value,
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      player1ScoreboardLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'player1Scoreboard',
        value: value,
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      player1ScoreboardBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'player1Scoreboard',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      player2IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'player2',
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      player2IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'player2',
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      player2ScoreboardIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'player2Scoreboard',
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      player2ScoreboardIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'player2Scoreboard',
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      player2ScoreboardEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'player2Scoreboard',
        value: value,
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      player2ScoreboardGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'player2Scoreboard',
        value: value,
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      player2ScoreboardLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'player2Scoreboard',
        value: value,
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      player2ScoreboardBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'player2Scoreboard',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      positionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'position',
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      positionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'position',
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      positionEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      positionGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      positionLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      positionBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'position',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      winnerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'winner',
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      winnerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'winner',
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      winnerEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'winner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      winnerGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'winner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      winnerLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'winner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      winnerBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'winner',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      winnerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'winner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      winnerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'winner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      winnerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'winner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      winnerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'winner',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      winnerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'winner',
        value: '',
      ));
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition>
      winnerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'winner',
        value: '',
      ));
    });
  }
}

extension KeyCollectionQueryObject
    on QueryBuilder<KeyCollection, KeyCollection, QFilterCondition> {
  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition> player1(
      FilterQuery<PlayerCollection> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'player1');
    });
  }

  QueryBuilder<KeyCollection, KeyCollection, QAfterFilterCondition> player2(
      FilterQuery<PlayerCollection> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'player2');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PlayerCollectionSchema = Schema(
  name: r'PlayerCollection',
  id: -2680462244093645409,
  properties: {
    r'defeats': PropertySchema(
      id: 0,
      name: r'defeats',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    ),
    r'team': PropertySchema(
      id: 2,
      name: r'team',
      type: IsarType.string,
    )
  },
  estimateSize: _playerCollectionEstimateSize,
  serialize: _playerCollectionSerialize,
  deserialize: _playerCollectionDeserialize,
  deserializeProp: _playerCollectionDeserializeProp,
);

int _playerCollectionEstimateSize(
  PlayerCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.team;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _playerCollectionSerialize(
  PlayerCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.defeats);
  writer.writeString(offsets[1], object.name);
  writer.writeString(offsets[2], object.team);
}

PlayerCollection _playerCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlayerCollection(
    defeats: reader.readLongOrNull(offsets[0]),
    name: reader.readStringOrNull(offsets[1]),
    team: reader.readStringOrNull(offsets[2]),
  );
  return object;
}

P _playerCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension PlayerCollectionQueryFilter
    on QueryBuilder<PlayerCollection, PlayerCollection, QFilterCondition> {
  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      defeatsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'defeats',
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      defeatsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'defeats',
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      defeatsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defeats',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      defeatsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defeats',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      defeatsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defeats',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      defeatsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defeats',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      teamIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'team',
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      teamIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'team',
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      teamEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'team',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      teamGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'team',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      teamLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'team',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      teamBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'team',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      teamStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'team',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      teamEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'team',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      teamContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'team',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      teamMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'team',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      teamIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'team',
        value: '',
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      teamIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'team',
        value: '',
      ));
    });
  }
}

extension PlayerCollectionQueryObject
    on QueryBuilder<PlayerCollection, PlayerCollection, QFilterCondition> {}
