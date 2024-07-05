// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlayerCollectionCollection on Isar {
  IsarCollection<PlayerCollection> get playerCollections => this.collection();
}

const PlayerCollectionSchema = CollectionSchema(
  name: r'PlayerCollection',
  id: -2680462244093645409,
  properties: {
    r'losses': PropertySchema(
      id: 0,
      name: r'losses',
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
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _playerCollectionGetId,
  getLinks: _playerCollectionGetLinks,
  attach: _playerCollectionAttach,
  version: '3.1.0+1',
);

int _playerCollectionEstimateSize(
  PlayerCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.team.length * 3;
  return bytesCount;
}

void _playerCollectionSerialize(
  PlayerCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.losses);
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
    reader.readString(offsets[1]),
    reader.readString(offsets[2]),
    reader.readLong(offsets[0]),
  );
  object.id = id;
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
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _playerCollectionGetId(PlayerCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _playerCollectionGetLinks(PlayerCollection object) {
  return [];
}

void _playerCollectionAttach(
    IsarCollection<dynamic> col, Id id, PlayerCollection object) {
  object.id = id;
}

extension PlayerCollectionQueryWhereSort
    on QueryBuilder<PlayerCollection, PlayerCollection, QWhere> {
  QueryBuilder<PlayerCollection, PlayerCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PlayerCollectionQueryWhere
    on QueryBuilder<PlayerCollection, PlayerCollection, QWhereClause> {
  QueryBuilder<PlayerCollection, PlayerCollection, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterWhereClause>
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

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterWhereClause> idBetween(
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

extension PlayerCollectionQueryFilter
    on QueryBuilder<PlayerCollection, PlayerCollection, QFilterCondition> {
  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
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

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
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

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
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

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      lossesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'losses',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      lossesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'losses',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      lossesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'losses',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      lossesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'losses',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterFilterCondition>
      nameEqualTo(
    String value, {
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
    String value, {
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
    String value, {
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
    String lower,
    String upper, {
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
      teamEqualTo(
    String value, {
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
    String value, {
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
    String value, {
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
    String lower,
    String upper, {
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

extension PlayerCollectionQueryLinks
    on QueryBuilder<PlayerCollection, PlayerCollection, QFilterCondition> {}

extension PlayerCollectionQuerySortBy
    on QueryBuilder<PlayerCollection, PlayerCollection, QSortBy> {
  QueryBuilder<PlayerCollection, PlayerCollection, QAfterSortBy>
      sortByLosses() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'losses', Sort.asc);
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterSortBy>
      sortByLossesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'losses', Sort.desc);
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterSortBy> sortByTeam() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'team', Sort.asc);
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterSortBy>
      sortByTeamDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'team', Sort.desc);
    });
  }
}

extension PlayerCollectionQuerySortThenBy
    on QueryBuilder<PlayerCollection, PlayerCollection, QSortThenBy> {
  QueryBuilder<PlayerCollection, PlayerCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterSortBy>
      thenByLosses() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'losses', Sort.asc);
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterSortBy>
      thenByLossesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'losses', Sort.desc);
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterSortBy> thenByTeam() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'team', Sort.asc);
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QAfterSortBy>
      thenByTeamDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'team', Sort.desc);
    });
  }
}

extension PlayerCollectionQueryWhereDistinct
    on QueryBuilder<PlayerCollection, PlayerCollection, QDistinct> {
  QueryBuilder<PlayerCollection, PlayerCollection, QDistinct>
      distinctByLosses() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'losses');
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlayerCollection, PlayerCollection, QDistinct> distinctByTeam(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'team', caseSensitive: caseSensitive);
    });
  }
}

extension PlayerCollectionQueryProperty
    on QueryBuilder<PlayerCollection, PlayerCollection, QQueryProperty> {
  QueryBuilder<PlayerCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PlayerCollection, int, QQueryOperations> lossesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'losses');
    });
  }

  QueryBuilder<PlayerCollection, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<PlayerCollection, String, QQueryOperations> teamProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'team');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTournamentCollectionCollection on Isar {
  IsarCollection<TournamentCollection> get tournamentCollections =>
      this.collection();
}

const TournamentCollectionSchema = CollectionSchema(
  name: r'TournamentCollection',
  id: -5871045532009332678,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.string,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.string,
    ),
    r'defeats': PropertySchema(
      id: 2,
      name: r'defeats',
      type: IsarType.long,
    ),
    r'drawTeams': PropertySchema(
      id: 3,
      name: r'drawTeams',
      type: IsarType.bool,
    ),
    r'isActive': PropertySchema(
      id: 4,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _tournamentCollectionEstimateSize,
  serialize: _tournamentCollectionSerialize,
  deserialize: _tournamentCollectionDeserialize,
  deserializeProp: _tournamentCollectionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'players': LinkSchema(
      id: 7559757076791939689,
      name: r'players',
      target: r'PlayerCollection',
      single: false,
    ),
    r'matches': LinkSchema(
      id: 5540093426692962598,
      name: r'matches',
      target: r'MatchCollection',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _tournamentCollectionGetId,
  getLinks: _tournamentCollectionGetLinks,
  attach: _tournamentCollectionAttach,
  version: '3.1.0+1',
);

int _tournamentCollectionEstimateSize(
  TournamentCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.createdAt.length * 3;
  bytesCount += 3 + object.date.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _tournamentCollectionSerialize(
  TournamentCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.date);
  writer.writeLong(offsets[2], object.defeats);
  writer.writeBool(offsets[3], object.drawTeams);
  writer.writeBool(offsets[4], object.isActive);
  writer.writeString(offsets[5], object.name);
}

TournamentCollection _tournamentCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TournamentCollection(
    reader.readString(offsets[5]),
    reader.readString(offsets[1]),
    reader.readLong(offsets[2]),
    reader.readBool(offsets[4]),
    reader.readBool(offsets[3]),
    reader.readString(offsets[0]),
  );
  object.id = id;
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
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tournamentCollectionGetId(TournamentCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tournamentCollectionGetLinks(
    TournamentCollection object) {
  return [object.players, object.matches];
}

void _tournamentCollectionAttach(
    IsarCollection<dynamic> col, Id id, TournamentCollection object) {
  object.id = id;
  object.players
      .attach(col, col.isar.collection<PlayerCollection>(), r'players', id);
  object.matches
      .attach(col, col.isar.collection<MatchCollection>(), r'matches', id);
}

extension TournamentCollectionQueryWhereSort
    on QueryBuilder<TournamentCollection, TournamentCollection, QWhere> {
  QueryBuilder<TournamentCollection, TournamentCollection, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TournamentCollectionQueryWhere
    on QueryBuilder<TournamentCollection, TournamentCollection, QWhereClause> {
  QueryBuilder<TournamentCollection, TournamentCollection, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterWhereClause>
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

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterWhereClause>
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

extension TournamentCollectionQueryFilter on QueryBuilder<TournamentCollection,
    TournamentCollection, QFilterCondition> {
  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> createdAtEqualTo(
    String value, {
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
    String value, {
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
    String value, {
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
    String lower,
    String upper, {
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
      QAfterFilterCondition> dateEqualTo(
    String value, {
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
    String value, {
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
    String value, {
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
    String lower,
    String upper, {
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
      QAfterFilterCondition> defeatsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defeats',
        value: value,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> defeatsGreaterThan(
    int value, {
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
    int value, {
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
    int lower,
    int upper, {
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
      QAfterFilterCondition> drawTeamsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'drawTeams',
        value: value,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> nameEqualTo(
    String value, {
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
    String value, {
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
    String value, {
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
    String lower,
    String upper, {
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
}

extension TournamentCollectionQueryObject on QueryBuilder<TournamentCollection,
    TournamentCollection, QFilterCondition> {}

extension TournamentCollectionQueryLinks on QueryBuilder<TournamentCollection,
    TournamentCollection, QFilterCondition> {
  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> players(FilterQuery<PlayerCollection> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'players');
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> playersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', length, true, length, true);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> playersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', 0, true, 0, true);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> playersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', 0, false, 999999, true);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> playersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', 0, true, length, include);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> playersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', length, include, 999999, true);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> playersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'players', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> matches(FilterQuery<MatchCollection> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'matches');
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> matchesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'matches', length, true, length, true);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> matchesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'matches', 0, true, 0, true);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> matchesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'matches', 0, false, 999999, true);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> matchesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'matches', 0, true, length, include);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> matchesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'matches', length, include, 999999, true);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection,
      QAfterFilterCondition> matchesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'matches', lower, includeLower, upper, includeUpper);
    });
  }
}

extension TournamentCollectionQuerySortBy
    on QueryBuilder<TournamentCollection, TournamentCollection, QSortBy> {
  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      sortByDefeats() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defeats', Sort.asc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      sortByDefeatsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defeats', Sort.desc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      sortByDrawTeams() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drawTeams', Sort.asc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      sortByDrawTeamsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drawTeams', Sort.desc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension TournamentCollectionQuerySortThenBy
    on QueryBuilder<TournamentCollection, TournamentCollection, QSortThenBy> {
  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      thenByDefeats() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defeats', Sort.asc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      thenByDefeatsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defeats', Sort.desc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      thenByDrawTeams() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drawTeams', Sort.asc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      thenByDrawTeamsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drawTeams', Sort.desc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension TournamentCollectionQueryWhereDistinct
    on QueryBuilder<TournamentCollection, TournamentCollection, QDistinct> {
  QueryBuilder<TournamentCollection, TournamentCollection, QDistinct>
      distinctByCreatedAt({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QDistinct>
      distinctByDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QDistinct>
      distinctByDefeats() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'defeats');
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QDistinct>
      distinctByDrawTeams() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'drawTeams');
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QDistinct>
      distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<TournamentCollection, TournamentCollection, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension TournamentCollectionQueryProperty on QueryBuilder<
    TournamentCollection, TournamentCollection, QQueryProperty> {
  QueryBuilder<TournamentCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TournamentCollection, String, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<TournamentCollection, String, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<TournamentCollection, int, QQueryOperations> defeatsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defeats');
    });
  }

  QueryBuilder<TournamentCollection, bool, QQueryOperations>
      drawTeamsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'drawTeams');
    });
  }

  QueryBuilder<TournamentCollection, bool, QQueryOperations>
      isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<TournamentCollection, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMatchCollectionCollection on Isar {
  IsarCollection<MatchCollection> get matchCollections => this.collection();
}

const MatchCollectionSchema = CollectionSchema(
  name: r'MatchCollection',
  id: 8137511204617563710,
  properties: {
    r'player1': PropertySchema(
      id: 0,
      name: r'player1',
      type: IsarType.string,
    ),
    r'player2': PropertySchema(
      id: 1,
      name: r'player2',
      type: IsarType.string,
    ),
    r'round': PropertySchema(
      id: 2,
      name: r'round',
      type: IsarType.long,
    ),
    r'score1': PropertySchema(
      id: 3,
      name: r'score1',
      type: IsarType.long,
    ),
    r'score2': PropertySchema(
      id: 4,
      name: r'score2',
      type: IsarType.long,
    ),
    r'winner': PropertySchema(
      id: 5,
      name: r'winner',
      type: IsarType.string,
    )
  },
  estimateSize: _matchCollectionEstimateSize,
  serialize: _matchCollectionSerialize,
  deserialize: _matchCollectionDeserialize,
  deserializeProp: _matchCollectionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _matchCollectionGetId,
  getLinks: _matchCollectionGetLinks,
  attach: _matchCollectionAttach,
  version: '3.1.0+1',
);

int _matchCollectionEstimateSize(
  MatchCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.player1.length * 3;
  bytesCount += 3 + object.player2.length * 3;
  bytesCount += 3 + object.winner.length * 3;
  return bytesCount;
}

void _matchCollectionSerialize(
  MatchCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.player1);
  writer.writeString(offsets[1], object.player2);
  writer.writeLong(offsets[2], object.round);
  writer.writeLong(offsets[3], object.score1);
  writer.writeLong(offsets[4], object.score2);
  writer.writeString(offsets[5], object.winner);
}

MatchCollection _matchCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MatchCollection(
    reader.readString(offsets[0]),
    reader.readString(offsets[1]),
    reader.readLongOrNull(offsets[3]),
    reader.readLongOrNull(offsets[4]),
    reader.readLong(offsets[2]),
    reader.readString(offsets[5]),
  );
  object.id = id;
  return object;
}

P _matchCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _matchCollectionGetId(MatchCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _matchCollectionGetLinks(MatchCollection object) {
  return [];
}

void _matchCollectionAttach(
    IsarCollection<dynamic> col, Id id, MatchCollection object) {
  object.id = id;
}

extension MatchCollectionQueryWhereSort
    on QueryBuilder<MatchCollection, MatchCollection, QWhere> {
  QueryBuilder<MatchCollection, MatchCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MatchCollectionQueryWhere
    on QueryBuilder<MatchCollection, MatchCollection, QWhereClause> {
  QueryBuilder<MatchCollection, MatchCollection, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterWhereClause>
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

  QueryBuilder<MatchCollection, MatchCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterWhereClause> idBetween(
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

extension MatchCollectionQueryFilter
    on QueryBuilder<MatchCollection, MatchCollection, QFilterCondition> {
  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
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

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
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

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
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

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      player1EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'player1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      player1GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'player1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      player1LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'player1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      player1Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'player1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      player1StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'player1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      player1EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'player1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      player1Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'player1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      player1Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'player1',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      player1IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'player1',
        value: '',
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      player1IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'player1',
        value: '',
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      player2EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'player2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      player2GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'player2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      player2LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'player2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      player2Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'player2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      player2StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'player2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      player2EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'player2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      player2Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'player2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      player2Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'player2',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      player2IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'player2',
        value: '',
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      player2IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'player2',
        value: '',
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      roundEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'round',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      roundGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'round',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      roundLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'round',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      roundBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'round',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      score1IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'score1',
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      score1IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'score1',
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      score1EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'score1',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      score1GreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'score1',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      score1LessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'score1',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      score1Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'score1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      score2IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'score2',
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      score2IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'score2',
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      score2EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'score2',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      score2GreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'score2',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      score2LessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'score2',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      score2Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'score2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      winnerEqualTo(
    String value, {
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

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      winnerGreaterThan(
    String value, {
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

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      winnerLessThan(
    String value, {
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

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      winnerBetween(
    String lower,
    String upper, {
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

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
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

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
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

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      winnerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'winner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      winnerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'winner',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      winnerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'winner',
        value: '',
      ));
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterFilterCondition>
      winnerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'winner',
        value: '',
      ));
    });
  }
}

extension MatchCollectionQueryObject
    on QueryBuilder<MatchCollection, MatchCollection, QFilterCondition> {}

extension MatchCollectionQueryLinks
    on QueryBuilder<MatchCollection, MatchCollection, QFilterCondition> {}

extension MatchCollectionQuerySortBy
    on QueryBuilder<MatchCollection, MatchCollection, QSortBy> {
  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy> sortByPlayer1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'player1', Sort.asc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy>
      sortByPlayer1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'player1', Sort.desc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy> sortByPlayer2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'player2', Sort.asc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy>
      sortByPlayer2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'player2', Sort.desc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy> sortByRound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'round', Sort.asc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy>
      sortByRoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'round', Sort.desc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy> sortByScore1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score1', Sort.asc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy>
      sortByScore1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score1', Sort.desc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy> sortByScore2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score2', Sort.asc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy>
      sortByScore2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score2', Sort.desc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy> sortByWinner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'winner', Sort.asc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy>
      sortByWinnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'winner', Sort.desc);
    });
  }
}

extension MatchCollectionQuerySortThenBy
    on QueryBuilder<MatchCollection, MatchCollection, QSortThenBy> {
  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy> thenByPlayer1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'player1', Sort.asc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy>
      thenByPlayer1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'player1', Sort.desc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy> thenByPlayer2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'player2', Sort.asc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy>
      thenByPlayer2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'player2', Sort.desc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy> thenByRound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'round', Sort.asc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy>
      thenByRoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'round', Sort.desc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy> thenByScore1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score1', Sort.asc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy>
      thenByScore1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score1', Sort.desc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy> thenByScore2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score2', Sort.asc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy>
      thenByScore2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score2', Sort.desc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy> thenByWinner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'winner', Sort.asc);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QAfterSortBy>
      thenByWinnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'winner', Sort.desc);
    });
  }
}

extension MatchCollectionQueryWhereDistinct
    on QueryBuilder<MatchCollection, MatchCollection, QDistinct> {
  QueryBuilder<MatchCollection, MatchCollection, QDistinct> distinctByPlayer1(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'player1', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QDistinct> distinctByPlayer2(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'player2', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QDistinct> distinctByRound() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'round');
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QDistinct> distinctByScore1() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'score1');
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QDistinct> distinctByScore2() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'score2');
    });
  }

  QueryBuilder<MatchCollection, MatchCollection, QDistinct> distinctByWinner(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'winner', caseSensitive: caseSensitive);
    });
  }
}

extension MatchCollectionQueryProperty
    on QueryBuilder<MatchCollection, MatchCollection, QQueryProperty> {
  QueryBuilder<MatchCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MatchCollection, String, QQueryOperations> player1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'player1');
    });
  }

  QueryBuilder<MatchCollection, String, QQueryOperations> player2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'player2');
    });
  }

  QueryBuilder<MatchCollection, int, QQueryOperations> roundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'round');
    });
  }

  QueryBuilder<MatchCollection, int?, QQueryOperations> score1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'score1');
    });
  }

  QueryBuilder<MatchCollection, int?, QQueryOperations> score2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'score2');
    });
  }

  QueryBuilder<MatchCollection, String, QQueryOperations> winnerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'winner');
    });
  }
}
