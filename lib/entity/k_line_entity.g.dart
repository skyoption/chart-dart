// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'k_line_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetKLineEntityCollection on Isar {
  IsarCollection<KLineEntity> get kLineEntitys => this.collection();
}

const KLineEntitySchema = CollectionSchema(
  name: r'KLineEntity',
  id: 3655396878855884161,
  properties: {
    r'close': PropertySchema(
      id: 0,
      name: r'close',
      type: IsarType.double,
    ),
    r'frame': PropertySchema(
      id: 1,
      name: r'frame',
      type: IsarType.byte,
      enumMap: _KLineEntityframeEnumValueMap,
    ),
    r'high': PropertySchema(
      id: 2,
      name: r'high',
      type: IsarType.double,
    ),
    r'low': PropertySchema(
      id: 3,
      name: r'low',
      type: IsarType.double,
    ),
    r'open': PropertySchema(
      id: 4,
      name: r'open',
      type: IsarType.double,
    ),
    r'symbol': PropertySchema(
      id: 5,
      name: r'symbol',
      type: IsarType.string,
    ),
    r'time': PropertySchema(
      id: 6,
      name: r'time',
      type: IsarType.long,
    ),
    r'vol': PropertySchema(
      id: 7,
      name: r'vol',
      type: IsarType.double,
    )
  },
  estimateSize: _kLineEntityEstimateSize,
  serialize: _kLineEntitySerialize,
  deserialize: _kLineEntityDeserialize,
  deserializeProp: _kLineEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _kLineEntityGetId,
  getLinks: _kLineEntityGetLinks,
  attach: _kLineEntityAttach,
  version: '3.3.0',
);

int _kLineEntityEstimateSize(
  KLineEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.symbol.length * 3;
  return bytesCount;
}

void _kLineEntitySerialize(
  KLineEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.close);
  writer.writeByte(offsets[1], object.frame.index);
  writer.writeDouble(offsets[2], object.high);
  writer.writeDouble(offsets[3], object.low);
  writer.writeDouble(offsets[4], object.open);
  writer.writeString(offsets[5], object.symbol);
  writer.writeLong(offsets[6], object.time);
  writer.writeDouble(offsets[7], object.vol);
}

KLineEntity _kLineEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = KLineEntity(
    close: reader.readDouble(offsets[0]),
    high: reader.readDouble(offsets[2]),
    id: id,
    low: reader.readDouble(offsets[3]),
    open: reader.readDouble(offsets[4]),
    time: reader.readLong(offsets[6]),
    vol: reader.readDouble(offsets[7]),
  );
  object.frame =
      _KLineEntityframeValueEnumMap[reader.readByteOrNull(offsets[1])] ??
          CandleTimeFormat.S5;
  object.symbol = reader.readString(offsets[5]);
  return object;
}

P _kLineEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (_KLineEntityframeValueEnumMap[reader.readByteOrNull(offset)] ??
          CandleTimeFormat.S5) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _KLineEntityframeEnumValueMap = {
  'S5': 0,
  'M1': 1,
  'M5': 2,
  'M15': 3,
  'M30': 4,
  'H1': 5,
  'H4': 6,
  'D1': 7,
  'W1': 8,
  'MN1': 9,
};
const _KLineEntityframeValueEnumMap = {
  0: CandleTimeFormat.S5,
  1: CandleTimeFormat.M1,
  2: CandleTimeFormat.M5,
  3: CandleTimeFormat.M15,
  4: CandleTimeFormat.M30,
  5: CandleTimeFormat.H1,
  6: CandleTimeFormat.H4,
  7: CandleTimeFormat.D1,
  8: CandleTimeFormat.W1,
  9: CandleTimeFormat.MN1,
};

Id _kLineEntityGetId(KLineEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _kLineEntityGetLinks(KLineEntity object) {
  return [];
}

void _kLineEntityAttach(
    IsarCollection<dynamic> col, Id id, KLineEntity object) {
  object.id = id;
}

extension KLineEntityQueryWhereSort
    on QueryBuilder<KLineEntity, KLineEntity, QWhere> {
  QueryBuilder<KLineEntity, KLineEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension KLineEntityQueryWhere
    on QueryBuilder<KLineEntity, KLineEntity, QWhereClause> {
  QueryBuilder<KLineEntity, KLineEntity, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<KLineEntity, KLineEntity, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterWhereClause> idBetween(
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

extension KLineEntityQueryFilter
    on QueryBuilder<KLineEntity, KLineEntity, QFilterCondition> {
  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> closeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'close',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      closeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'close',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> closeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'close',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> closeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'close',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> frameEqualTo(
      CandleTimeFormat value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frame',
        value: value,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      frameGreaterThan(
    CandleTimeFormat value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frame',
        value: value,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> frameLessThan(
    CandleTimeFormat value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frame',
        value: value,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> frameBetween(
    CandleTimeFormat lower,
    CandleTimeFormat upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frame',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> highEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'high',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> highGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'high',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> highLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'high',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> highBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'high',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> idBetween(
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

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> lowEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'low',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> lowGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'low',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> lowLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'low',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> lowBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'low',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> openEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'open',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> openGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'open',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> openLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'open',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> openBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'open',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> symbolEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      symbolGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> symbolLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> symbolBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'symbol',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      symbolStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> symbolEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> symbolContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> symbolMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'symbol',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      symbolIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'symbol',
        value: '',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      symbolIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'symbol',
        value: '',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> timeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'time',
        value: value,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> timeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'time',
        value: value,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> timeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'time',
        value: value,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> timeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'time',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> volEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vol',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> volGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vol',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> volLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vol',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> volBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vol',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension KLineEntityQueryObject
    on QueryBuilder<KLineEntity, KLineEntity, QFilterCondition> {}

extension KLineEntityQueryLinks
    on QueryBuilder<KLineEntity, KLineEntity, QFilterCondition> {}

extension KLineEntityQuerySortBy
    on QueryBuilder<KLineEntity, KLineEntity, QSortBy> {
  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByClose() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'close', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByCloseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'close', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByFrame() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frame', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByFrameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frame', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByHigh() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'high', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByHighDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'high', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByLow() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'low', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByLowDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'low', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByOpen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'open', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByOpenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'open', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortBySymbol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortBySymbolDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByVol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vol', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByVolDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vol', Sort.desc);
    });
  }
}

extension KLineEntityQuerySortThenBy
    on QueryBuilder<KLineEntity, KLineEntity, QSortThenBy> {
  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByClose() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'close', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByCloseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'close', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByFrame() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frame', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByFrameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frame', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByHigh() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'high', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByHighDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'high', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByLow() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'low', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByLowDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'low', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByOpen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'open', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByOpenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'open', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenBySymbol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenBySymbolDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByVol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vol', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByVolDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vol', Sort.desc);
    });
  }
}

extension KLineEntityQueryWhereDistinct
    on QueryBuilder<KLineEntity, KLineEntity, QDistinct> {
  QueryBuilder<KLineEntity, KLineEntity, QDistinct> distinctByClose() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'close');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QDistinct> distinctByFrame() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frame');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QDistinct> distinctByHigh() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'high');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QDistinct> distinctByLow() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'low');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QDistinct> distinctByOpen() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'open');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QDistinct> distinctBySymbol(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'symbol', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QDistinct> distinctByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'time');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QDistinct> distinctByVol() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vol');
    });
  }
}

extension KLineEntityQueryProperty
    on QueryBuilder<KLineEntity, KLineEntity, QQueryProperty> {
  QueryBuilder<KLineEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<KLineEntity, double, QQueryOperations> closeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'close');
    });
  }

  QueryBuilder<KLineEntity, CandleTimeFormat, QQueryOperations>
      frameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frame');
    });
  }

  QueryBuilder<KLineEntity, double, QQueryOperations> highProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'high');
    });
  }

  QueryBuilder<KLineEntity, double, QQueryOperations> lowProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'low');
    });
  }

  QueryBuilder<KLineEntity, double, QQueryOperations> openProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'open');
    });
  }

  QueryBuilder<KLineEntity, String, QQueryOperations> symbolProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'symbol');
    });
  }

  QueryBuilder<KLineEntity, int, QQueryOperations> timeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'time');
    });
  }

  QueryBuilder<KLineEntity, double, QQueryOperations> volProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vol');
    });
  }
}
