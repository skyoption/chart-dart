// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secondary_indicator_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSecondaryIndicatorEntityCollection on Isar {
  IsarCollection<SecondaryIndicatorEntity> get secondaryIndicatorEntitys =>
      this.collection();
}

const SecondaryIndicatorEntitySchema = CollectionSchema(
  name: r'SecondaryIndicatorEntity',
  id: -5362295942368598322,
  properties: {
    r'applyTo': PropertySchema(
      id: 0,
      name: r'applyTo',
      type: IsarType.byte,
      enumMap: _SecondaryIndicatorEntityapplyToEnumValueMap,
    ),
    r'color': PropertySchema(
      id: 1,
      name: r'color',
      type: IsarType.string,
    ),
    r'deviations': PropertySchema(
      id: 2,
      name: r'deviations',
      type: IsarType.double,
    ),
    r'dn': PropertySchema(
      id: 3,
      name: r'dn',
      type: IsarType.double,
    ),
    r'drawAsBackground': PropertySchema(
      id: 4,
      name: r'drawAsBackground',
      type: IsarType.bool,
    ),
    r'ichimoku': PropertySchema(
      id: 5,
      name: r'ichimoku',
      type: IsarType.object,
      target: r'Ichimoku',
    ),
    r'level': PropertySchema(
      id: 6,
      name: r'level',
      type: IsarType.byte,
      enumMap: _SecondaryIndicatorEntitylevelEnumValueMap,
    ),
    r'maximum': PropertySchema(
      id: 7,
      name: r'maximum',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 8,
      name: r'name',
      type: IsarType.string,
    ),
    r'period': PropertySchema(
      id: 9,
      name: r'period',
      type: IsarType.long,
    ),
    r'secondColor': PropertySchema(
      id: 10,
      name: r'secondColor',
      type: IsarType.string,
    ),
    r'shift': PropertySchema(
      id: 11,
      name: r'shift',
      type: IsarType.long,
    ),
    r'steps': PropertySchema(
      id: 12,
      name: r'steps',
      type: IsarType.double,
    ),
    r'strokeWidth': PropertySchema(
      id: 13,
      name: r'strokeWidth',
      type: IsarType.double,
    ),
    r'style': PropertySchema(
      id: 14,
      name: r'style',
      type: IsarType.byte,
      enumMap: _SecondaryIndicatorEntitystyleEnumValueMap,
    ),
    r'timeframe': PropertySchema(
      id: 15,
      name: r'timeframe',
      type: IsarType.byte,
      enumMap: _SecondaryIndicatorEntitytimeframeEnumValueMap,
    ),
    r'type': PropertySchema(
      id: 16,
      name: r'type',
      type: IsarType.byte,
      enumMap: _SecondaryIndicatorEntitytypeEnumValueMap,
    ),
    r'up': PropertySchema(
      id: 17,
      name: r'up',
      type: IsarType.double,
    ),
    r'value': PropertySchema(
      id: 18,
      name: r'value',
      type: IsarType.double,
    )
  },
  estimateSize: _secondaryIndicatorEntityEstimateSize,
  serialize: _secondaryIndicatorEntitySerialize,
  deserialize: _secondaryIndicatorEntityDeserialize,
  deserializeProp: _secondaryIndicatorEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'Ichimoku': IchimokuSchema},
  getId: _secondaryIndicatorEntityGetId,
  getLinks: _secondaryIndicatorEntityGetLinks,
  attach: _secondaryIndicatorEntityAttach,
  version: '3.1.0+1',
);

int _secondaryIndicatorEntityEstimateSize(
  SecondaryIndicatorEntity object,
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
  {
    final value = object.ichimoku;
    if (value != null) {
      bytesCount += 3 +
          IchimokuSchema.estimateSize(value, allOffsets[Ichimoku]!, allOffsets);
    }
  }
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.secondColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _secondaryIndicatorEntitySerialize(
  SecondaryIndicatorEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.applyTo.index);
  writer.writeString(offsets[1], object.color);
  writer.writeDouble(offsets[2], object.deviations);
  writer.writeDouble(offsets[3], object.dn);
  writer.writeBool(offsets[4], object.drawAsBackground);
  writer.writeObject<Ichimoku>(
    offsets[5],
    allOffsets,
    IchimokuSchema.serialize,
    object.ichimoku,
  );
  writer.writeByte(offsets[6], object.level.index);
  writer.writeDouble(offsets[7], object.maximum);
  writer.writeString(offsets[8], object.name);
  writer.writeLong(offsets[9], object.period);
  writer.writeString(offsets[10], object.secondColor);
  writer.writeLong(offsets[11], object.shift);
  writer.writeDouble(offsets[12], object.steps);
  writer.writeDouble(offsets[13], object.strokeWidth);
  writer.writeByte(offsets[14], object.style.index);
  writer.writeByte(offsets[15], object.timeframe.index);
  writer.writeByte(offsets[16], object.type.index);
  writer.writeDouble(offsets[17], object.up);
  writer.writeDouble(offsets[18], object.value);
}

SecondaryIndicatorEntity _secondaryIndicatorEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SecondaryIndicatorEntity(
    applyTo: _SecondaryIndicatorEntityapplyToValueEnumMap[
            reader.readByteOrNull(offsets[0])] ??
        ApplyTo.Close,
    color: reader.readStringOrNull(offsets[1]),
    deviations: reader.readDoubleOrNull(offsets[2]),
    dn: reader.readDoubleOrNull(offsets[3]),
    drawAsBackground: reader.readBoolOrNull(offsets[4]) ?? false,
    level: _SecondaryIndicatorEntitylevelValueEnumMap[
            reader.readByteOrNull(offsets[6])] ??
        Levels.None,
    maximum: reader.readDoubleOrNull(offsets[7]),
    name: reader.readStringOrNull(offsets[8]) ?? '',
    period: reader.readLongOrNull(offsets[9]) ?? 5,
    secondColor: reader.readStringOrNull(offsets[10]),
    shift: reader.readLongOrNull(offsets[11]) ?? 0,
    steps: reader.readDoubleOrNull(offsets[12]),
    strokeWidth: reader.readDoubleOrNull(offsets[13]) ?? 1.0,
    style: _SecondaryIndicatorEntitystyleValueEnumMap[
            reader.readByteOrNull(offsets[14])] ??
        LineStyle.normal,
    timeframe: _SecondaryIndicatorEntitytimeframeValueEnumMap[
            reader.readByteOrNull(offsets[15])] ??
        Timeframes.All_Timeframes,
    type: _SecondaryIndicatorEntitytypeValueEnumMap[
            reader.readByteOrNull(offsets[16])] ??
        IndicatorType.MACD,
    up: reader.readDoubleOrNull(offsets[17]),
    value: reader.readDoubleOrNull(offsets[18]) ?? 0,
  );
  object.ichimoku = reader.readObjectOrNull<Ichimoku>(
    offsets[5],
    IchimokuSchema.deserialize,
    allOffsets,
  );
  object.id = id;
  return object;
}

P _secondaryIndicatorEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_SecondaryIndicatorEntityapplyToValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ApplyTo.Close) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 5:
      return (reader.readObjectOrNull<Ichimoku>(
        offset,
        IchimokuSchema.deserialize,
        allOffsets,
      )) as P;
    case 6:
      return (_SecondaryIndicatorEntitylevelValueEnumMap[
              reader.readByteOrNull(offset)] ??
          Levels.None) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 9:
      return (reader.readLongOrNull(offset) ?? 5) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 12:
      return (reader.readDoubleOrNull(offset)) as P;
    case 13:
      return (reader.readDoubleOrNull(offset) ?? 1.0) as P;
    case 14:
      return (_SecondaryIndicatorEntitystyleValueEnumMap[
              reader.readByteOrNull(offset)] ??
          LineStyle.normal) as P;
    case 15:
      return (_SecondaryIndicatorEntitytimeframeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          Timeframes.All_Timeframes) as P;
    case 16:
      return (_SecondaryIndicatorEntitytypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          IndicatorType.MACD) as P;
    case 17:
      return (reader.readDoubleOrNull(offset)) as P;
    case 18:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _SecondaryIndicatorEntityapplyToEnumValueMap = {
  'Close': 0,
  'Open': 1,
  'High': 2,
  'Low': 3,
  'Median_Price_HL__2': 4,
  'Middle_Price_OC__2': 5,
  'Typical_Price_HLC__3': 6,
  'Weighted_Close_HLCC__4': 7,
};
const _SecondaryIndicatorEntityapplyToValueEnumMap = {
  0: ApplyTo.Close,
  1: ApplyTo.Open,
  2: ApplyTo.High,
  3: ApplyTo.Low,
  4: ApplyTo.Median_Price_HL__2,
  5: ApplyTo.Middle_Price_OC__2,
  6: ApplyTo.Typical_Price_HLC__3,
  7: ApplyTo.Weighted_Close_HLCC__4,
};
const _SecondaryIndicatorEntitylevelEnumValueMap = {
  'None': 0,
};
const _SecondaryIndicatorEntitylevelValueEnumMap = {
  0: Levels.None,
};
const _SecondaryIndicatorEntitystyleEnumValueMap = {
  'dash': 0,
  'normal': 1,
  'longDash': 2,
};
const _SecondaryIndicatorEntitystyleValueEnumMap = {
  0: LineStyle.dash,
  1: LineStyle.normal,
  2: LineStyle.longDash,
};
const _SecondaryIndicatorEntitytimeframeEnumValueMap = {
  'All_Timeframes': 0,
  'None': 1,
};
const _SecondaryIndicatorEntitytimeframeValueEnumMap = {
  0: Timeframes.All_Timeframes,
  1: Timeframes.None,
};
const _SecondaryIndicatorEntitytypeEnumValueMap = {
  'LINEAR_MA': 0,
  'SMMA_MA': 1,
  'EMA_MA': 2,
  'SMA_MA': 3,
  'LINEAR_ENVELOPS': 4,
  'SMMA_ENVELOPS': 5,
  'EMA_ENVELOPS': 6,
  'SMA_ENVELOPS': 7,
  'BOLL': 8,
  'PARABOLIC': 9,
  'ICHIMOKU': 10,
  'MACD': 11,
  'KDJ': 12,
  'RSI': 13,
  'WR': 14,
  'CCI': 15,
};
const _SecondaryIndicatorEntitytypeValueEnumMap = {
  0: IndicatorType.LINEAR_MA,
  1: IndicatorType.SMMA_MA,
  2: IndicatorType.EMA_MA,
  3: IndicatorType.SMA_MA,
  4: IndicatorType.LINEAR_ENVELOPS,
  5: IndicatorType.SMMA_ENVELOPS,
  6: IndicatorType.EMA_ENVELOPS,
  7: IndicatorType.SMA_ENVELOPS,
  8: IndicatorType.BOLL,
  9: IndicatorType.PARABOLIC,
  10: IndicatorType.ICHIMOKU,
  11: IndicatorType.MACD,
  12: IndicatorType.KDJ,
  13: IndicatorType.RSI,
  14: IndicatorType.WR,
  15: IndicatorType.CCI,
};

Id _secondaryIndicatorEntityGetId(SecondaryIndicatorEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _secondaryIndicatorEntityGetLinks(
    SecondaryIndicatorEntity object) {
  return [];
}

void _secondaryIndicatorEntityAttach(
    IsarCollection<dynamic> col, Id id, SecondaryIndicatorEntity object) {
  object.id = id;
}

extension SecondaryIndicatorEntityQueryWhereSort on QueryBuilder<
    SecondaryIndicatorEntity, SecondaryIndicatorEntity, QWhere> {
  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SecondaryIndicatorEntityQueryWhere on QueryBuilder<
    SecondaryIndicatorEntity, SecondaryIndicatorEntity, QWhereClause> {
  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterWhereClause> idBetween(
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

extension SecondaryIndicatorEntityQueryFilter on QueryBuilder<
    SecondaryIndicatorEntity, SecondaryIndicatorEntity, QFilterCondition> {
  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> applyToEqualTo(ApplyTo value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'applyTo',
        value: value,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> applyToGreaterThan(
    ApplyTo value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'applyTo',
        value: value,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> applyToLessThan(
    ApplyTo value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'applyTo',
        value: value,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> applyToBetween(
    ApplyTo lower,
    ApplyTo upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'applyTo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> colorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> colorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> colorEqualTo(
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> colorGreaterThan(
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> colorLessThan(
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> colorBetween(
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> colorStartsWith(
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> colorEndsWith(
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
          QAfterFilterCondition>
      colorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
          QAfterFilterCondition>
      colorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'color',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> colorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> colorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> deviationsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deviations',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> deviationsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deviations',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> deviationsEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviations',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> deviationsGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deviations',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> deviationsLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deviations',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> deviationsBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deviations',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> dnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dn',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> dnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dn',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> dnEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dn',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> dnGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dn',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> dnLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dn',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> dnBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> drawAsBackgroundEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'drawAsBackground',
        value: value,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> ichimokuIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ichimoku',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> ichimokuIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ichimoku',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> levelEqualTo(Levels value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'level',
        value: value,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> levelGreaterThan(
    Levels value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'level',
        value: value,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> levelLessThan(
    Levels value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'level',
        value: value,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> levelBetween(
    Levels lower,
    Levels upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'level',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> maximumIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maximum',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> maximumIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maximum',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> maximumEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maximum',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> maximumGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maximum',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> maximumLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maximum',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> maximumBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maximum',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> periodEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'period',
        value: value,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> periodGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'period',
        value: value,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> periodLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'period',
        value: value,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> periodBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'period',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> secondColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'secondColor',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> secondColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'secondColor',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> secondColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secondColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> secondColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'secondColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> secondColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'secondColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> secondColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'secondColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> secondColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'secondColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> secondColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'secondColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
          QAfterFilterCondition>
      secondColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'secondColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
          QAfterFilterCondition>
      secondColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'secondColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> secondColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secondColor',
        value: '',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> secondColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'secondColor',
        value: '',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> shiftEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shift',
        value: value,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> shiftGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shift',
        value: value,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> shiftLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shift',
        value: value,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> shiftBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shift',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> stepsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'steps',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> stepsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'steps',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> stepsEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'steps',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> stepsGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'steps',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> stepsLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'steps',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> stepsBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'steps',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> strokeWidthEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'strokeWidth',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> strokeWidthGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'strokeWidth',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> strokeWidthLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'strokeWidth',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> strokeWidthBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'strokeWidth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> styleEqualTo(LineStyle value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'style',
        value: value,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> styleGreaterThan(
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> styleLessThan(
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> styleBetween(
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> timeframeEqualTo(Timeframes value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeframe',
        value: value,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> timeframeGreaterThan(
    Timeframes value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeframe',
        value: value,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> timeframeLessThan(
    Timeframes value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeframe',
        value: value,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> timeframeBetween(
    Timeframes lower,
    Timeframes upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeframe',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> typeEqualTo(IndicatorType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> typeGreaterThan(
    IndicatorType value, {
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> typeLessThan(
    IndicatorType value, {
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> typeBetween(
    IndicatorType lower,
    IndicatorType upper, {
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> upIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'up',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> upIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'up',
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> upEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'up',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> upGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'up',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> upLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'up',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> upBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'up',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> valueEqualTo(
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> valueGreaterThan(
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> valueLessThan(
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

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> valueBetween(
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

extension SecondaryIndicatorEntityQueryObject on QueryBuilder<
    SecondaryIndicatorEntity, SecondaryIndicatorEntity, QFilterCondition> {
  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity,
      QAfterFilterCondition> ichimoku(FilterQuery<Ichimoku> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'ichimoku');
    });
  }
}

extension SecondaryIndicatorEntityQueryLinks on QueryBuilder<
    SecondaryIndicatorEntity, SecondaryIndicatorEntity, QFilterCondition> {}

extension SecondaryIndicatorEntityQuerySortBy on QueryBuilder<
    SecondaryIndicatorEntity, SecondaryIndicatorEntity, QSortBy> {
  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByApplyTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applyTo', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByApplyToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applyTo', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByDeviations() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviations', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByDeviationsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviations', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByDn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dn', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByDnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dn', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByDrawAsBackground() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drawAsBackground', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByDrawAsBackgroundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drawAsBackground', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByMaximum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maximum', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByMaximumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maximum', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByPeriod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'period', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByPeriodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'period', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortBySecondColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondColor', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortBySecondColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondColor', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByShift() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shift', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByShiftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shift', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByStrokeWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strokeWidth', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByStrokeWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strokeWidth', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByStyleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByTimeframe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeframe', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByTimeframeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeframe', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByUp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'up', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByUpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'up', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      sortByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension SecondaryIndicatorEntityQuerySortThenBy on QueryBuilder<
    SecondaryIndicatorEntity, SecondaryIndicatorEntity, QSortThenBy> {
  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByApplyTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applyTo', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByApplyToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applyTo', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByDeviations() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviations', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByDeviationsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviations', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByDn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dn', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByDnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dn', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByDrawAsBackground() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drawAsBackground', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByDrawAsBackgroundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drawAsBackground', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByMaximum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maximum', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByMaximumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maximum', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByPeriod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'period', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByPeriodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'period', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenBySecondColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondColor', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenBySecondColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondColor', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByShift() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shift', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByShiftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shift', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByStrokeWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strokeWidth', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByStrokeWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strokeWidth', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByStyleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByTimeframe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeframe', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByTimeframeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeframe', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByUp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'up', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByUpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'up', Sort.desc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QAfterSortBy>
      thenByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension SecondaryIndicatorEntityQueryWhereDistinct on QueryBuilder<
    SecondaryIndicatorEntity, SecondaryIndicatorEntity, QDistinct> {
  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QDistinct>
      distinctByApplyTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'applyTo');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QDistinct>
      distinctByColor({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QDistinct>
      distinctByDeviations() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deviations');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QDistinct>
      distinctByDn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dn');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QDistinct>
      distinctByDrawAsBackground() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'drawAsBackground');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QDistinct>
      distinctByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'level');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QDistinct>
      distinctByMaximum() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maximum');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QDistinct>
      distinctByPeriod() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'period');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QDistinct>
      distinctBySecondColor({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'secondColor', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QDistinct>
      distinctByShift() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shift');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QDistinct>
      distinctBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'steps');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QDistinct>
      distinctByStrokeWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'strokeWidth');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QDistinct>
      distinctByStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'style');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QDistinct>
      distinctByTimeframe() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeframe');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QDistinct>
      distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QDistinct>
      distinctByUp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'up');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, SecondaryIndicatorEntity, QDistinct>
      distinctByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'value');
    });
  }
}

extension SecondaryIndicatorEntityQueryProperty on QueryBuilder<
    SecondaryIndicatorEntity, SecondaryIndicatorEntity, QQueryProperty> {
  QueryBuilder<SecondaryIndicatorEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, ApplyTo, QQueryOperations>
      applyToProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'applyTo');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, String?, QQueryOperations>
      colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, double?, QQueryOperations>
      deviationsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deviations');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, double?, QQueryOperations>
      dnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dn');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, bool, QQueryOperations>
      drawAsBackgroundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'drawAsBackground');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, Ichimoku?, QQueryOperations>
      ichimokuProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ichimoku');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, Levels, QQueryOperations>
      levelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'level');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, double?, QQueryOperations>
      maximumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maximum');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, String, QQueryOperations>
      nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, int, QQueryOperations>
      periodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'period');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, String?, QQueryOperations>
      secondColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'secondColor');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, int, QQueryOperations>
      shiftProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shift');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, double?, QQueryOperations>
      stepsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'steps');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, double, QQueryOperations>
      strokeWidthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'strokeWidth');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, LineStyle, QQueryOperations>
      styleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'style');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, Timeframes, QQueryOperations>
      timeframeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeframe');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, IndicatorType, QQueryOperations>
      typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, double?, QQueryOperations>
      upProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'up');
    });
  }

  QueryBuilder<SecondaryIndicatorEntity, double, QQueryOperations>
      valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'value');
    });
  }
}
