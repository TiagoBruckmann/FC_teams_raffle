// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fc_teams.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFCTeamsCollectionCollection on Isar {
  IsarCollection<FCTeamsCollection> get fCTeamsCollections => this.collection();
}

const FCTeamsCollectionSchema = CollectionSchema(
  name: r'FCTeamsCollection',
  id: -2499091862812348088,
  properties: {
    r'teamCollection': PropertySchema(
      id: 0,
      name: r'teamCollection',
      type: IsarType.objectList,
      target: r'TeamCollection',
    ),
    r'versionDataSync': PropertySchema(
      id: 1,
      name: r'versionDataSync',
      type: IsarType.long,
    )
  },
  estimateSize: _fCTeamsCollectionEstimateSize,
  serialize: _fCTeamsCollectionSerialize,
  deserialize: _fCTeamsCollectionDeserialize,
  deserializeProp: _fCTeamsCollectionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'TeamCollection': TeamCollectionSchema},
  getId: _fCTeamsCollectionGetId,
  getLinks: _fCTeamsCollectionGetLinks,
  attach: _fCTeamsCollectionAttach,
  version: '3.1.0+1',
);

int _fCTeamsCollectionEstimateSize(
  FCTeamsCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.teamCollection;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[TeamCollection]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              TeamCollectionSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  return bytesCount;
}

void _fCTeamsCollectionSerialize(
  FCTeamsCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<TeamCollection>(
    offsets[0],
    allOffsets,
    TeamCollectionSchema.serialize,
    object.teamCollection,
  );
  writer.writeLong(offsets[1], object.versionDataSync);
}

FCTeamsCollection _fCTeamsCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FCTeamsCollection(
    teamCollection: reader.readObjectList<TeamCollection>(
      offsets[0],
      TeamCollectionSchema.deserialize,
      allOffsets,
      TeamCollection(),
    ),
    versionDataSync: reader.readLongOrNull(offsets[1]),
  );
  object.id = id;
  return object;
}

P _fCTeamsCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<TeamCollection>(
        offset,
        TeamCollectionSchema.deserialize,
        allOffsets,
        TeamCollection(),
      )) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _fCTeamsCollectionGetId(FCTeamsCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _fCTeamsCollectionGetLinks(
    FCTeamsCollection object) {
  return [];
}

void _fCTeamsCollectionAttach(
    IsarCollection<dynamic> col, Id id, FCTeamsCollection object) {
  object.id = id;
}

extension FCTeamsCollectionQueryWhereSort
    on QueryBuilder<FCTeamsCollection, FCTeamsCollection, QWhere> {
  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FCTeamsCollectionQueryWhere
    on QueryBuilder<FCTeamsCollection, FCTeamsCollection, QWhereClause> {
  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterWhereClause>
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

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterWhereClause>
      idBetween(
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

extension FCTeamsCollectionQueryFilter
    on QueryBuilder<FCTeamsCollection, FCTeamsCollection, QFilterCondition> {
  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterFilterCondition>
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

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterFilterCondition>
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

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterFilterCondition>
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

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterFilterCondition>
      teamCollectionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'teamCollection',
      ));
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterFilterCondition>
      teamCollectionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'teamCollection',
      ));
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterFilterCondition>
      teamCollectionLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'teamCollection',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterFilterCondition>
      teamCollectionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'teamCollection',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterFilterCondition>
      teamCollectionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'teamCollection',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterFilterCondition>
      teamCollectionLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'teamCollection',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterFilterCondition>
      teamCollectionLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'teamCollection',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterFilterCondition>
      teamCollectionLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'teamCollection',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterFilterCondition>
      versionDataSyncIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'versionDataSync',
      ));
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterFilterCondition>
      versionDataSyncIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'versionDataSync',
      ));
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterFilterCondition>
      versionDataSyncEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionDataSync',
        value: value,
      ));
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterFilterCondition>
      versionDataSyncGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'versionDataSync',
        value: value,
      ));
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterFilterCondition>
      versionDataSyncLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'versionDataSync',
        value: value,
      ));
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterFilterCondition>
      versionDataSyncBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'versionDataSync',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FCTeamsCollectionQueryObject
    on QueryBuilder<FCTeamsCollection, FCTeamsCollection, QFilterCondition> {
  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterFilterCondition>
      teamCollectionElement(FilterQuery<TeamCollection> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'teamCollection');
    });
  }
}

extension FCTeamsCollectionQueryLinks
    on QueryBuilder<FCTeamsCollection, FCTeamsCollection, QFilterCondition> {}

extension FCTeamsCollectionQuerySortBy
    on QueryBuilder<FCTeamsCollection, FCTeamsCollection, QSortBy> {
  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterSortBy>
      sortByVersionDataSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionDataSync', Sort.asc);
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterSortBy>
      sortByVersionDataSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionDataSync', Sort.desc);
    });
  }
}

extension FCTeamsCollectionQuerySortThenBy
    on QueryBuilder<FCTeamsCollection, FCTeamsCollection, QSortThenBy> {
  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterSortBy>
      thenByVersionDataSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionDataSync', Sort.asc);
    });
  }

  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QAfterSortBy>
      thenByVersionDataSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionDataSync', Sort.desc);
    });
  }
}

extension FCTeamsCollectionQueryWhereDistinct
    on QueryBuilder<FCTeamsCollection, FCTeamsCollection, QDistinct> {
  QueryBuilder<FCTeamsCollection, FCTeamsCollection, QDistinct>
      distinctByVersionDataSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'versionDataSync');
    });
  }
}

extension FCTeamsCollectionQueryProperty
    on QueryBuilder<FCTeamsCollection, FCTeamsCollection, QQueryProperty> {
  QueryBuilder<FCTeamsCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FCTeamsCollection, List<TeamCollection>?, QQueryOperations>
      teamCollectionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'teamCollection');
    });
  }

  QueryBuilder<FCTeamsCollection, int?, QQueryOperations>
      versionDataSyncProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'versionDataSync');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const TeamCollectionSchema = Schema(
  name: r'TeamCollection',
  id: -6852259819050403605,
  properties: {
    r'league': PropertySchema(
      id: 0,
      name: r'league',
      type: IsarType.string,
    ),
    r'logo': PropertySchema(
      id: 1,
      name: r'logo',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    ),
    r'score': PropertySchema(
      id: 3,
      name: r'score',
      type: IsarType.long,
    )
  },
  estimateSize: _teamCollectionEstimateSize,
  serialize: _teamCollectionSerialize,
  deserialize: _teamCollectionDeserialize,
  deserializeProp: _teamCollectionDeserializeProp,
);

int _teamCollectionEstimateSize(
  TeamCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.league;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.logo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
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

void _teamCollectionSerialize(
  TeamCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.league);
  writer.writeString(offsets[1], object.logo);
  writer.writeString(offsets[2], object.name);
  writer.writeLong(offsets[3], object.score);
}

TeamCollection _teamCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TeamCollection(
    league: reader.readStringOrNull(offsets[0]),
    logo: reader.readStringOrNull(offsets[1]),
    name: reader.readStringOrNull(offsets[2]),
    score: reader.readLongOrNull(offsets[3]),
  );
  return object;
}

P _teamCollectionDeserializeProp<P>(
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension TeamCollectionQueryFilter
    on QueryBuilder<TeamCollection, TeamCollection, QFilterCondition> {
  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      leagueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'league',
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      leagueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'league',
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      leagueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'league',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      leagueGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'league',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      leagueLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'league',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      leagueBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'league',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      leagueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'league',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      leagueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'league',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      leagueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'league',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      leagueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'league',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      leagueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'league',
        value: '',
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      leagueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'league',
        value: '',
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      logoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'logo',
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      logoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'logo',
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      logoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      logoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'logo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      logoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'logo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      logoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'logo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      logoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'logo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      logoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'logo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      logoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'logo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      logoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'logo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      logoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logo',
        value: '',
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      logoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'logo',
        value: '',
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
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

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
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

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
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

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
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

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
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

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
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

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      scoreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'score',
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      scoreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'score',
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      scoreEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      scoreGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      scoreLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<TeamCollection, TeamCollection, QAfterFilterCondition>
      scoreBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'score',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TeamCollectionQueryObject
    on QueryBuilder<TeamCollection, TeamCollection, QFilterCondition> {}
