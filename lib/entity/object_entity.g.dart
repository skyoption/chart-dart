// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetObjectEntityCollection on Isar {
  IsarCollection<ObjectEntity> get objectEntitys => this.collection();
}

const ObjectEntitySchema = CollectionSchema(
  name: r'ObjectEntity',
  id: -7933839839827304844,
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
    r'datetime2': PropertySchema(
      id: 3,
      name: r'datetime2',
      type: IsarType.long,
    ),
    r'drawAsBackground': PropertySchema(
      id: 4,
      name: r'drawAsBackground',
      type: IsarType.bool,
    ),
    r'dx1': PropertySchema(
      id: 5,
      name: r'dx1',
      type: IsarType.double,
    ),
    r'dx2': PropertySchema(
      id: 6,
      name: r'dx2',
      type: IsarType.double,
    ),
    r'dy1': PropertySchema(
      id: 7,
      name: r'dy1',
      type: IsarType.double,
    ),
    r'dy2': PropertySchema(
      id: 8,
      name: r'dy2',
      type: IsarType.double,
    ),
    r'frame': PropertySchema(
      id: 9,
      name: r'frame',
      type: IsarType.byte,
      enumMap: _ObjectEntityframeEnumValueMap,
    ),
    r'height': PropertySchema(
      id: 10,
      name: r'height',
      type: IsarType.double,
    ),
    r'isFill': PropertySchema(
      id: 11,
      name: r'isFill',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 12,
      name: r'name',
      type: IsarType.string,
    ),
    r'rayLift': PropertySchema(
      id: 13,
      name: r'rayLift',
      type: IsarType.bool,
    ),
    r'rayRight': PropertySchema(
      id: 14,
      name: r'rayRight',
      type: IsarType.bool,
    ),
    r'style': PropertySchema(
      id: 15,
      name: r'style',
      type: IsarType.byte,
      enumMap: _ObjectEntitystyleEnumValueMap,
    ),
    r'symbol': PropertySchema(
      id: 16,
      name: r'symbol',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 17,
      name: r'type',
      type: IsarType.byte,
      enumMap: _ObjectEntitytypeEnumValueMap,
    ),
    r'value': PropertySchema(
      id: 18,
      name: r'value',
      type: IsarType.double,
    ),
    r'value2': PropertySchema(
      id: 19,
      name: r'value2',
      type: IsarType.double,
    )
  },
  estimateSize: _objectEntityEstimateSize,
  serialize: _objectEntitySerialize,
  deserialize: _objectEntityDeserialize,
  deserializeProp: _objectEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _objectEntityGetId,
  getLinks: _objectEntityGetLinks,
  attach: _objectEntityAttach,
  version: '3.1.0+1',
);

int _objectEntityEstimateSize(
  ObjectEntity object,
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

void _objectEntitySerialize(
  ObjectEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.color);
  writer.writeLong(offsets[1], object.currentEditIndex);
  writer.writeLong(offsets[2], object.datetime);
  writer.writeLong(offsets[3], object.datetime2);
  writer.writeBool(offsets[4], object.drawAsBackground);
  writer.writeDouble(offsets[5], object.dx1);
  writer.writeDouble(offsets[6], object.dx2);
  writer.writeDouble(offsets[7], object.dy1);
  writer.writeDouble(offsets[8], object.dy2);
  writer.writeByte(offsets[9], object.frame.index);
  writer.writeDouble(offsets[10], object.height);
  writer.writeBool(offsets[11], object.isFill);
  writer.writeString(offsets[12], object.name);
  writer.writeBool(offsets[13], object.rayLift);
  writer.writeBool(offsets[14], object.rayRight);
  writer.writeByte(offsets[15], object.style.index);
  writer.writeString(offsets[16], object.symbol);
  writer.writeByte(offsets[17], object.type.index);
  writer.writeDouble(offsets[18], object.value);
  writer.writeDouble(offsets[19], object.value2);
}

ObjectEntity _objectEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ObjectEntity(
    color: reader.readStringOrNull(offsets[0]),
    currentEditIndex: reader.readLongOrNull(offsets[1]) ?? -1,
    datetime: reader.readLongOrNull(offsets[2]) ?? 0,
    datetime2: reader.readLongOrNull(offsets[3]) ?? 0,
    drawAsBackground: reader.readBoolOrNull(offsets[4]) ?? false,
    dx1: reader.readDoubleOrNull(offsets[5]) ?? 0,
    dx2: reader.readDoubleOrNull(offsets[6]) ?? 0,
    dy1: reader.readDoubleOrNull(offsets[7]) ?? 0,
    dy2: reader.readDoubleOrNull(offsets[8]) ?? 0,
    frame: _ObjectEntityframeValueEnumMap[reader.readByteOrNull(offsets[9])] ??
        CandleTimeFormat.H4,
    height: reader.readDoubleOrNull(offsets[10]) ?? 1.0,
    isFill: reader.readBoolOrNull(offsets[11]) ?? false,
    name: reader.readStringOrNull(offsets[12]) ?? '',
    rayLift: reader.readBoolOrNull(offsets[13]) ?? false,
    rayRight: reader.readBoolOrNull(offsets[14]) ?? false,
    style: _ObjectEntitystyleValueEnumMap[reader.readByteOrNull(offsets[15])] ??
        ObjectStyle.normal,
    symbol: reader.readStringOrNull(offsets[16]) ?? '',
    type: _ObjectEntitytypeValueEnumMap[reader.readByteOrNull(offsets[17])] ??
        ObjectType.Horizontal,
    value: reader.readDoubleOrNull(offsets[18]) ?? 0,
    value2: reader.readDoubleOrNull(offsets[19]) ?? 0,
  );
  object.id = id;
  return object;
}

P _objectEntityDeserializeProp<P>(
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
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 5:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 6:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 7:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 8:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 9:
      return (_ObjectEntityframeValueEnumMap[reader.readByteOrNull(offset)] ??
          CandleTimeFormat.H4) as P;
    case 10:
      return (reader.readDoubleOrNull(offset) ?? 1.0) as P;
    case 11:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 12:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 13:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 14:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 15:
      return (_ObjectEntitystyleValueEnumMap[reader.readByteOrNull(offset)] ??
          ObjectStyle.normal) as P;
    case 16:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 17:
      return (_ObjectEntitytypeValueEnumMap[reader.readByteOrNull(offset)] ??
          ObjectType.Horizontal) as P;
    case 18:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 19:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ObjectEntityframeEnumValueMap = {
  'M1': 0,
  'M5': 1,
  'M15': 2,
  'M30': 3,
  'H1': 4,
  'H4': 5,
  'D1': 6,
  'W1': 7,
  'MN': 8,
};
const _ObjectEntityframeValueEnumMap = {
  0: CandleTimeFormat.M1,
  1: CandleTimeFormat.M5,
  2: CandleTimeFormat.M15,
  3: CandleTimeFormat.M30,
  4: CandleTimeFormat.H1,
  5: CandleTimeFormat.H4,
  6: CandleTimeFormat.D1,
  7: CandleTimeFormat.W1,
  8: CandleTimeFormat.MN1,
};
const _ObjectEntitystyleEnumValueMap = {
  'dash': 0,
  'normal': 1,
};
const _ObjectEntitystyleValueEnumMap = {
  0: ObjectStyle.dash,
  1: ObjectStyle.normal,
};
const _ObjectEntitytypeEnumValueMap = {
  'Vertical': 0,
  'Horizontal': 1,
  'Trend': 2,
  'Rectangle': 3,
};
const _ObjectEntitytypeValueEnumMap = {
  0: ObjectType.Vertical,
  1: ObjectType.Horizontal,
  2: ObjectType.Trend,
  3: ObjectType.Rectangle,
};

Id _objectEntityGetId(ObjectEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _objectEntityGetLinks(ObjectEntity object) {
  return [];
}

void _objectEntityAttach(
    IsarCollection<dynamic> col, Id id, ObjectEntity object) {
  object.id = id;
}

extension ObjectEntityQueryWhereSort
    on QueryBuilder<ObjectEntity, ObjectEntity, QWhere> {
  QueryBuilder<ObjectEntity, ObjectEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ObjectEntityQueryWhere
    on QueryBuilder<ObjectEntity, ObjectEntity, QWhereClause> {
  QueryBuilder<ObjectEntity, ObjectEntity, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterWhereClause> idBetween(
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

extension ObjectEntityQueryFilter
    on QueryBuilder<ObjectEntity, ObjectEntity, QFilterCondition> {
  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      colorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      colorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> colorEqualTo(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      colorGreaterThan(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> colorLessThan(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> colorBetween(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      colorStartsWith(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> colorEndsWith(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> colorContains(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> colorMatches(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      colorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      colorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      currentEditIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentEditIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      datetimeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'datetime',
        value: value,
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      datetimeLessThan(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      datetimeBetween(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      datetime2EqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'datetime2',
        value: value,
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      datetime2GreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'datetime2',
        value: value,
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      datetime2LessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'datetime2',
        value: value,
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      datetime2Between(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'datetime2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      drawAsBackgroundEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'drawAsBackground',
        value: value,
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> dx1EqualTo(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      dx1GreaterThan(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> dx1LessThan(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> dx1Between(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> dx2EqualTo(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      dx2GreaterThan(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> dx2LessThan(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> dx2Between(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> dy1EqualTo(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      dy1GreaterThan(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> dy1LessThan(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> dy1Between(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> dy2EqualTo(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      dy2GreaterThan(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> dy2LessThan(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> dy2Between(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> frameEqualTo(
      CandleTimeFormat value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frame',
        value: value,
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> frameLessThan(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> frameBetween(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> heightEqualTo(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      heightGreaterThan(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      heightLessThan(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> heightBetween(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> isFillEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFill',
        value: value,
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> nameContains(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      rayLiftEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rayLift',
        value: value,
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      rayRightEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rayRight',
        value: value,
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> styleEqualTo(
      ObjectStyle value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'style',
        value: value,
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      styleGreaterThan(
    ObjectStyle value, {
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> styleLessThan(
    ObjectStyle value, {
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> styleBetween(
    ObjectStyle lower,
    ObjectStyle upper, {
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> symbolEqualTo(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      symbolLessThan(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> symbolBetween(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      symbolEndsWith(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      symbolContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> symbolMatches(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      symbolIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'symbol',
        value: '',
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      symbolIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'symbol',
        value: '',
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> typeEqualTo(
      ObjectType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      typeGreaterThan(
    ObjectType value, {
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> typeLessThan(
    ObjectType value, {
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> typeBetween(
    ObjectType lower,
    ObjectType upper, {
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> valueEqualTo(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      valueGreaterThan(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> valueLessThan(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> valueBetween(
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

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> value2EqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value2',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      value2GreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value2',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition>
      value2LessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value2',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterFilterCondition> value2Between(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension ObjectEntityQueryObject
    on QueryBuilder<ObjectEntity, ObjectEntity, QFilterCondition> {}

extension ObjectEntityQueryLinks
    on QueryBuilder<ObjectEntity, ObjectEntity, QFilterCondition> {}

extension ObjectEntityQuerySortBy
    on QueryBuilder<ObjectEntity, ObjectEntity, QSortBy> {
  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy>
      sortByCurrentEditIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentEditIndex', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy>
      sortByCurrentEditIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentEditIndex', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByDatetime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datetime', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByDatetimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datetime', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByDatetime2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datetime2', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByDatetime2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datetime2', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy>
      sortByDrawAsBackground() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drawAsBackground', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy>
      sortByDrawAsBackgroundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drawAsBackground', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByDx1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dx1', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByDx1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dx1', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByDx2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dx2', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByDx2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dx2', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByDy1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy1', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByDy1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy1', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByDy2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy2', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByDy2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy2', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByFrame() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frame', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByFrameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frame', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByIsFill() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFill', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByIsFillDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFill', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByRayLift() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rayLift', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByRayLiftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rayLift', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByRayRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rayRight', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByRayRightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rayRight', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByStyleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortBySymbol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortBySymbolDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByValue2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value2', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> sortByValue2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value2', Sort.desc);
    });
  }
}

extension ObjectEntityQuerySortThenBy
    on QueryBuilder<ObjectEntity, ObjectEntity, QSortThenBy> {
  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy>
      thenByCurrentEditIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentEditIndex', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy>
      thenByCurrentEditIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentEditIndex', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByDatetime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datetime', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByDatetimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datetime', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByDatetime2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datetime2', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByDatetime2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datetime2', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy>
      thenByDrawAsBackground() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drawAsBackground', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy>
      thenByDrawAsBackgroundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drawAsBackground', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByDx1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dx1', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByDx1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dx1', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByDx2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dx2', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByDx2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dx2', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByDy1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy1', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByDy1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy1', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByDy2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy2', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByDy2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy2', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByFrame() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frame', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByFrameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frame', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByIsFill() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFill', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByIsFillDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFill', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByRayLift() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rayLift', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByRayLiftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rayLift', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByRayRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rayRight', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByRayRightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rayRight', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByStyleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenBySymbol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenBySymbolDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByValue2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value2', Sort.asc);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QAfterSortBy> thenByValue2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value2', Sort.desc);
    });
  }
}

extension ObjectEntityQueryWhereDistinct
    on QueryBuilder<ObjectEntity, ObjectEntity, QDistinct> {
  QueryBuilder<ObjectEntity, ObjectEntity, QDistinct> distinctByColor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QDistinct>
      distinctByCurrentEditIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentEditIndex');
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QDistinct> distinctByDatetime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'datetime');
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QDistinct> distinctByDatetime2() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'datetime2');
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QDistinct>
      distinctByDrawAsBackground() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'drawAsBackground');
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QDistinct> distinctByDx1() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dx1');
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QDistinct> distinctByDx2() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dx2');
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QDistinct> distinctByDy1() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dy1');
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QDistinct> distinctByDy2() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dy2');
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QDistinct> distinctByFrame() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frame');
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QDistinct> distinctByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'height');
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QDistinct> distinctByIsFill() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFill');
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QDistinct> distinctByRayLift() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rayLift');
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QDistinct> distinctByRayRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rayRight');
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QDistinct> distinctByStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'style');
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QDistinct> distinctBySymbol(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'symbol', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QDistinct> distinctByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'value');
    });
  }

  QueryBuilder<ObjectEntity, ObjectEntity, QDistinct> distinctByValue2() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'value2');
    });
  }
}

extension ObjectEntityQueryProperty
    on QueryBuilder<ObjectEntity, ObjectEntity, QQueryProperty> {
  QueryBuilder<ObjectEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ObjectEntity, String?, QQueryOperations> colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<ObjectEntity, int, QQueryOperations> currentEditIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentEditIndex');
    });
  }

  QueryBuilder<ObjectEntity, int, QQueryOperations> datetimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'datetime');
    });
  }

  QueryBuilder<ObjectEntity, int, QQueryOperations> datetime2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'datetime2');
    });
  }

  QueryBuilder<ObjectEntity, bool, QQueryOperations>
      drawAsBackgroundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'drawAsBackground');
    });
  }

  QueryBuilder<ObjectEntity, double, QQueryOperations> dx1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dx1');
    });
  }

  QueryBuilder<ObjectEntity, double, QQueryOperations> dx2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dx2');
    });
  }

  QueryBuilder<ObjectEntity, double, QQueryOperations> dy1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dy1');
    });
  }

  QueryBuilder<ObjectEntity, double, QQueryOperations> dy2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dy2');
    });
  }

  QueryBuilder<ObjectEntity, CandleTimeFormat, QQueryOperations>
      frameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frame');
    });
  }

  QueryBuilder<ObjectEntity, double, QQueryOperations> heightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'height');
    });
  }

  QueryBuilder<ObjectEntity, bool, QQueryOperations> isFillProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFill');
    });
  }

  QueryBuilder<ObjectEntity, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ObjectEntity, bool, QQueryOperations> rayLiftProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rayLift');
    });
  }

  QueryBuilder<ObjectEntity, bool, QQueryOperations> rayRightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rayRight');
    });
  }

  QueryBuilder<ObjectEntity, ObjectStyle, QQueryOperations> styleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'style');
    });
  }

  QueryBuilder<ObjectEntity, String, QQueryOperations> symbolProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'symbol');
    });
  }

  QueryBuilder<ObjectEntity, ObjectType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<ObjectEntity, double, QQueryOperations> valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'value');
    });
  }

  QueryBuilder<ObjectEntity, double, QQueryOperations> value2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'value2');
    });
  }
}
