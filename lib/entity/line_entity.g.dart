// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLineEntityCollection on Isar {
  IsarCollection<LineEntity> get lineEntitys => this.collection();
}

const LineEntitySchema = CollectionSchema(
  name: r'LineEntity',
  id: -2643489878973826560,
  properties: {
    r'color': PropertySchema(
      id: 0,
      name: r'color',
      type: IsarType.string,
    ),
    r'currentEditIndex': PropertySchema(
      id: 1,
      name: r'currentEditIndex',
      type: IsarType.long,
    ),
    r'datetime': PropertySchema(
      id: 2,
      name: r'datetime',
      type: IsarType.long,
    ),
    r'drawAsBackground': PropertySchema(
      id: 3,
      name: r'drawAsBackground',
      type: IsarType.bool,
    ),
    r'dx1': PropertySchema(
      id: 4,
      name: r'dx1',
      type: IsarType.double,
    ),
    r'dx2': PropertySchema(
      id: 5,
      name: r'dx2',
      type: IsarType.double,
    ),
    r'dy1': PropertySchema(
      id: 6,
      name: r'dy1',
      type: IsarType.double,
    ),
    r'dy2': PropertySchema(
      id: 7,
      name: r'dy2',
      type: IsarType.double,
    ),
    r'height': PropertySchema(
      id: 8,
      name: r'height',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 9,
      name: r'name',
      type: IsarType.string,
    ),
    r'style': PropertySchema(
      id: 10,
      name: r'style',
      type: IsarType.byte,
      enumMap: _LineEntitystyleEnumValueMap,
    ),
    r'symbol': PropertySchema(
      id: 11,
      name: r'symbol',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 12,
      name: r'type',
      type: IsarType.byte,
      enumMap: _LineEntitytypeEnumValueMap,
    ),
    r'value': PropertySchema(
      id: 13,
      name: r'value',
      type: IsarType.double,
    )
  },
  estimateSize: _lineEntityEstimateSize,
  serialize: _lineEntitySerialize,
  deserialize: _lineEntityDeserialize,
  deserializeProp: _lineEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _lineEntityGetId,
  getLinks: _lineEntityGetLinks,
  attach: _lineEntityAttach,
  version: '3.1.0+1',
);

int _lineEntityEstimateSize(
  LineEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.color;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.symbol.length * 3;
  return bytesCount;
}

void _lineEntitySerialize(
  LineEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.color);
  writer.writeLong(offsets[1], object.currentEditIndex);
  writer.writeLong(offsets[2], object.datetime);
  writer.writeBool(offsets[3], object.drawAsBackground);
  writer.writeDouble(offsets[4], object.dx1);
  writer.writeDouble(offsets[5], object.dx2);
  writer.writeDouble(offsets[6], object.dy1);
  writer.writeDouble(offsets[7], object.dy2);
  writer.writeDouble(offsets[8], object.height);
  writer.writeString(offsets[9], object.name);
  writer.writeByte(offsets[10], object.style.index);
  writer.writeString(offsets[11], object.symbol);
  writer.writeByte(offsets[12], object.type.index);
  writer.writeDouble(offsets[13], object.value);
}

LineEntity _lineEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LineEntity(
    color: reader.readStringOrNull(offsets[0]),
    currentEditIndex: reader.readLongOrNull(offsets[1]) ?? -1,
    datetime: reader.readLongOrNull(offsets[2]) ?? 0,
    drawAsBackground: reader.readBoolOrNull(offsets[3]) ?? false,
    dx1: reader.readDoubleOrNull(offsets[4]) ?? 0,
    dx2: reader.readDoubleOrNull(offsets[5]) ?? 0,
    dy1: reader.readDoubleOrNull(offsets[6]) ?? 0,
    dy2: reader.readDoubleOrNull(offsets[7]) ?? 0,
    height: reader.readDoubleOrNull(offsets[8]) ?? 1.2,
    name: reader.readStringOrNull(offsets[9]) ?? '',
    style: _LineEntitystyleValueEnumMap[reader.readByteOrNull(offsets[10])] ??
        LineStyle.normal,
    symbol: reader.readStringOrNull(offsets[11]) ?? '',
    type: _LineEntitytypeValueEnumMap[reader.readByteOrNull(offsets[12])] ??
        LineType.horizontal,
    value: reader.readDoubleOrNull(offsets[13]) ?? 50559.50,
  );
  object.id = id;
  return object;
}

P _lineEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? -1) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 4:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 5:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 6:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 7:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 8:
      return (reader.readDoubleOrNull(offset) ?? 1.2) as P;
    case 9:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 10:
      return (_LineEntitystyleValueEnumMap[reader.readByteOrNull(offset)] ??
          LineStyle.normal) as P;
    case 11:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 12:
      return (_LineEntitytypeValueEnumMap[reader.readByteOrNull(offset)] ??
          LineType.horizontal) as P;
    case 13:
      return (reader.readDoubleOrNull(offset) ?? 50559.50) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _LineEntitystyleEnumValueMap = {
  'dash': 0,
  'normal': 1,
  'longDash': 2,
};
const _LineEntitystyleValueEnumMap = {
  0: LineStyle.dash,
  1: LineStyle.normal,
  2: LineStyle.longDash,
};
const _LineEntitytypeEnumValueMap = {
  'vertical': 0,
  'horizontal': 1,
  'trend': 2,
};
const _LineEntitytypeValueEnumMap = {
  0: LineType.vertical,
  1: LineType.horizontal,
  2: LineType.trend,
};

Id _lineEntityGetId(LineEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _lineEntityGetLinks(LineEntity object) {
  return [];
}

void _lineEntityAttach(IsarCollection<dynamic> col, Id id, LineEntity object) {
  object.id = id;
}

extension LineEntityQueryWhereSort
    on QueryBuilder<LineEntity, LineEntity, QWhere> {
  QueryBuilder<LineEntity, LineEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LineEntityQueryWhere
    on QueryBuilder<LineEntity, LineEntity, QWhereClause> {
  QueryBuilder<LineEntity, LineEntity, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<LineEntity, LineEntity, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterWhereClause> idBetween(
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

extension LineEntityQueryFilter
    on QueryBuilder<LineEntity, LineEntity, QFilterCondition> {
  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> colorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> colorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> colorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> colorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> colorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> colorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'color',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> colorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> colorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> colorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> colorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'color',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> colorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition>
      colorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition>
      currentEditIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentEditIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition>
      currentEditIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentEditIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition>
      currentEditIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentEditIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition>
      currentEditIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentEditIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> datetimeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'datetime',
        value: value,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition>
      datetimeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'datetime',
        value: value,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> datetimeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'datetime',
        value: value,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> datetimeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'datetime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition>
      drawAsBackgroundEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'drawAsBackground',
        value: value,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> dx1EqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dx1',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> dx1GreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dx1',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> dx1LessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dx1',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> dx1Between(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dx1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> dx2EqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dx2',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> dx2GreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dx2',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> dx2LessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dx2',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> dx2Between(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dx2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> dy1EqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dy1',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> dy1GreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dy1',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> dy1LessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dy1',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> dy1Between(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dy1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> dy2EqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dy2',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> dy2GreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dy2',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> dy2LessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dy2',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> dy2Between(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dy2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> heightEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> heightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> heightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> heightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'height',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> idBetween(
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

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> styleEqualTo(
      LineStyle value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'style',
        value: value,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> styleGreaterThan(
    LineStyle value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'style',
        value: value,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> styleLessThan(
    LineStyle value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'style',
        value: value,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> styleBetween(
    LineStyle lower,
    LineStyle upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'style',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> symbolEqualTo(
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

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> symbolGreaterThan(
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

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> symbolLessThan(
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

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> symbolBetween(
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

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> symbolStartsWith(
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

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> symbolEndsWith(
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

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> symbolContains(
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

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> symbolMatches(
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

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> symbolIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'symbol',
        value: '',
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition>
      symbolIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'symbol',
        value: '',
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> typeEqualTo(
      LineType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> typeGreaterThan(
    LineType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> typeLessThan(
    LineType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> typeBetween(
    LineType lower,
    LineType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> valueEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> valueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> valueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> valueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension LineEntityQueryObject
    on QueryBuilder<LineEntity, LineEntity, QFilterCondition> {}

extension LineEntityQueryLinks
    on QueryBuilder<LineEntity, LineEntity, QFilterCondition> {}

extension LineEntityQuerySortBy
    on QueryBuilder<LineEntity, LineEntity, QSortBy> {
  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByCurrentEditIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentEditIndex', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy>
      sortByCurrentEditIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentEditIndex', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByDatetime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datetime', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByDatetimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datetime', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByDrawAsBackground() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drawAsBackground', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy>
      sortByDrawAsBackgroundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drawAsBackground', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByDx1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dx1', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByDx1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dx1', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByDx2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dx2', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByDx2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dx2', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByDy1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy1', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByDy1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy1', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByDy2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy2', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByDy2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy2', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByStyleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortBySymbol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortBySymbolDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension LineEntityQuerySortThenBy
    on QueryBuilder<LineEntity, LineEntity, QSortThenBy> {
  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByCurrentEditIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentEditIndex', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy>
      thenByCurrentEditIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentEditIndex', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByDatetime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datetime', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByDatetimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datetime', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByDrawAsBackground() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drawAsBackground', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy>
      thenByDrawAsBackgroundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drawAsBackground', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByDx1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dx1', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByDx1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dx1', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByDx2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dx2', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByDx2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dx2', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByDy1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy1', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByDy1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy1', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByDy2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy2', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByDy2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy2', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByStyleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenBySymbol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenBySymbolDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension LineEntityQueryWhereDistinct
    on QueryBuilder<LineEntity, LineEntity, QDistinct> {
  QueryBuilder<LineEntity, LineEntity, QDistinct> distinctByColor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QDistinct> distinctByCurrentEditIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentEditIndex');
    });
  }

  QueryBuilder<LineEntity, LineEntity, QDistinct> distinctByDatetime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'datetime');
    });
  }

  QueryBuilder<LineEntity, LineEntity, QDistinct> distinctByDrawAsBackground() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'drawAsBackground');
    });
  }

  QueryBuilder<LineEntity, LineEntity, QDistinct> distinctByDx1() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dx1');
    });
  }

  QueryBuilder<LineEntity, LineEntity, QDistinct> distinctByDx2() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dx2');
    });
  }

  QueryBuilder<LineEntity, LineEntity, QDistinct> distinctByDy1() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dy1');
    });
  }

  QueryBuilder<LineEntity, LineEntity, QDistinct> distinctByDy2() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dy2');
    });
  }

  QueryBuilder<LineEntity, LineEntity, QDistinct> distinctByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'height');
    });
  }

  QueryBuilder<LineEntity, LineEntity, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QDistinct> distinctByStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'style');
    });
  }

  QueryBuilder<LineEntity, LineEntity, QDistinct> distinctBySymbol(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'symbol', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<LineEntity, LineEntity, QDistinct> distinctByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'value');
    });
  }
}

extension LineEntityQueryProperty
    on QueryBuilder<LineEntity, LineEntity, QQueryProperty> {
  QueryBuilder<LineEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LineEntity, String?, QQueryOperations> colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<LineEntity, int, QQueryOperations> currentEditIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentEditIndex');
    });
  }

  QueryBuilder<LineEntity, int, QQueryOperations> datetimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'datetime');
    });
  }

  QueryBuilder<LineEntity, bool, QQueryOperations> drawAsBackgroundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'drawAsBackground');
    });
  }

  QueryBuilder<LineEntity, double, QQueryOperations> dx1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dx1');
    });
  }

  QueryBuilder<LineEntity, double, QQueryOperations> dx2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dx2');
    });
  }

  QueryBuilder<LineEntity, double, QQueryOperations> dy1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dy1');
    });
  }

  QueryBuilder<LineEntity, double, QQueryOperations> dy2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dy2');
    });
  }

  QueryBuilder<LineEntity, double, QQueryOperations> heightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'height');
    });
  }

  QueryBuilder<LineEntity, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<LineEntity, LineStyle, QQueryOperations> styleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'style');
    });
  }

  QueryBuilder<LineEntity, String, QQueryOperations> symbolProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'symbol');
    });
  }

  QueryBuilder<LineEntity, LineType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<LineEntity, double, QQueryOperations> valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'value');
    });
  }
}
