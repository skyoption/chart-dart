// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indicator_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIndicatorEntityCollection on Isar {
  IsarCollection<IndicatorEntity> get indicatorEntitys => this.collection();
}

const IndicatorEntitySchema = CollectionSchema(
  name: r'IndicatorEntity',
  id: 5811941488105835232,
  properties: {
    r'applyTo': PropertySchema(
      id: 0,
      name: r'applyTo',
      type: IsarType.byte,
      enumMap: _IndicatorEntityapplyToEnumValueMap,
    ),
    r'chikouSpan': PropertySchema(
      id: 1,
      name: r'chikouSpan',
      type: IsarType.double,
    ),
    r'color': PropertySchema(
      id: 2,
      name: r'color',
      type: IsarType.string,
    ),
    r'dValue': PropertySchema(
      id: 3,
      name: r'dValue',
      type: IsarType.double,
    ),
    r'deviations': PropertySchema(
      id: 4,
      name: r'deviations',
      type: IsarType.double,
    ),
    r'dn': PropertySchema(
      id: 5,
      name: r'dn',
      type: IsarType.double,
    ),
    r'drawAsBackground': PropertySchema(
      id: 6,
      name: r'drawAsBackground',
      type: IsarType.bool,
    ),
    r'heightRetro': PropertySchema(
      id: 7,
      name: r'heightRetro',
      type: IsarType.double,
    ),
    r'ichimoku': PropertySchema(
      id: 8,
      name: r'ichimoku',
      type: IsarType.object,
      target: r'Ichimoku',
    ),
    r'isMain': PropertySchema(
      id: 9,
      name: r'isMain',
      type: IsarType.bool,
    ),
    r'isSecondary': PropertySchema(
      id: 10,
      name: r'isSecondary',
      type: IsarType.bool,
    ),
    r'kValue': PropertySchema(
      id: 11,
      name: r'kValue',
      type: IsarType.double,
    ),
    r'kijunSen': PropertySchema(
      id: 12,
      name: r'kijunSen',
      type: IsarType.double,
    ),
    r'level': PropertySchema(
      id: 13,
      name: r'level',
      type: IsarType.byte,
      enumMap: _IndicatorEntitylevelEnumValueMap,
    ),
    r'levels': PropertySchema(
      id: 14,
      name: r'levels',
      type: IsarType.doubleList,
    ),
    r'levelsColor': PropertySchema(
      id: 15,
      name: r'levelsColor',
      type: IsarType.string,
    ),
    r'longEMA': PropertySchema(
      id: 16,
      name: r'longEMA',
      type: IsarType.double,
    ),
    r'macd': PropertySchema(
      id: 17,
      name: r'macd',
      type: IsarType.object,
      target: r'MACD',
    ),
    r'maximum': PropertySchema(
      id: 18,
      name: r'maximum',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 19,
      name: r'name',
      type: IsarType.string,
    ),
    r'period': PropertySchema(
      id: 20,
      name: r'period',
      type: IsarType.long,
    ),
    r'secondColor': PropertySchema(
      id: 21,
      name: r'secondColor',
      type: IsarType.string,
    ),
    r'senkouSpanA': PropertySchema(
      id: 22,
      name: r'senkouSpanA',
      type: IsarType.double,
    ),
    r'senkouSpanB': PropertySchema(
      id: 23,
      name: r'senkouSpanB',
      type: IsarType.double,
    ),
    r'shift': PropertySchema(
      id: 24,
      name: r'shift',
      type: IsarType.long,
    ),
    r'shortEMA': PropertySchema(
      id: 25,
      name: r'shortEMA',
      type: IsarType.double,
    ),
    r'steps': PropertySchema(
      id: 26,
      name: r'steps',
      type: IsarType.double,
    ),
    r'stochastic': PropertySchema(
      id: 27,
      name: r'stochastic',
      type: IsarType.object,
      target: r'Stochastic',
    ),
    r'strokeWidth': PropertySchema(
      id: 28,
      name: r'strokeWidth',
      type: IsarType.double,
    ),
    r'style': PropertySchema(
      id: 29,
      name: r'style',
      type: IsarType.byte,
      enumMap: _IndicatorEntitystyleEnumValueMap,
    ),
    r'tenkanSen': PropertySchema(
      id: 30,
      name: r'tenkanSen',
      type: IsarType.double,
    ),
    r'timeframe': PropertySchema(
      id: 31,
      name: r'timeframe',
      type: IsarType.byte,
      enumMap: _IndicatorEntitytimeframeEnumValueMap,
    ),
    r'type': PropertySchema(
      id: 32,
      name: r'type',
      type: IsarType.byte,
      enumMap: _IndicatorEntitytypeEnumValueMap,
    ),
    r'up': PropertySchema(
      id: 33,
      name: r'up',
      type: IsarType.double,
    ),
    r'value': PropertySchema(
      id: 34,
      name: r'value',
      type: IsarType.double,
    ),
    r'windowId': PropertySchema(
      id: 35,
      name: r'windowId',
      type: IsarType.long,
    )
  },
  estimateSize: _indicatorEntityEstimateSize,
  serialize: _indicatorEntitySerialize,
  deserialize: _indicatorEntityDeserialize,
  deserializeProp: _indicatorEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'Ichimoku': IchimokuSchema,
    r'MACD': MACDSchema,
    r'Stochastic': StochasticSchema
  },
  getId: _indicatorEntityGetId,
  getLinks: _indicatorEntityGetLinks,
  attach: _indicatorEntityAttach,
  version: '3.1.0+1',
);

int _indicatorEntityEstimateSize(
  IndicatorEntity object,
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
  bytesCount += 3 + object.levels.length * 8;
  {
    final value = object.levelsColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.macd;
    if (value != null) {
      bytesCount +=
          3 + MACDSchema.estimateSize(value, allOffsets[MACD]!, allOffsets);
    }
  }
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.secondColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.stochastic;
    if (value != null) {
      bytesCount += 3 +
          StochasticSchema.estimateSize(
              value, allOffsets[Stochastic]!, allOffsets);
    }
  }
  return bytesCount;
}

void _indicatorEntitySerialize(
  IndicatorEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.applyTo.index);
  writer.writeDouble(offsets[1], object.chikouSpan);
  writer.writeString(offsets[2], object.color);
  writer.writeDouble(offsets[3], object.dValue);
  writer.writeDouble(offsets[4], object.deviations);
  writer.writeDouble(offsets[5], object.dn);
  writer.writeBool(offsets[6], object.drawAsBackground);
  writer.writeDouble(offsets[7], object.heightRetro);
  writer.writeObject<Ichimoku>(
    offsets[8],
    allOffsets,
    IchimokuSchema.serialize,
    object.ichimoku,
  );
  writer.writeBool(offsets[9], object.isMain);
  writer.writeBool(offsets[10], object.isSecondary);
  writer.writeDouble(offsets[11], object.kValue);
  writer.writeDouble(offsets[12], object.kijunSen);
  writer.writeByte(offsets[13], object.level.index);
  writer.writeDoubleList(offsets[14], object.levels);
  writer.writeString(offsets[15], object.levelsColor);
  writer.writeDouble(offsets[16], object.longEMA);
  writer.writeObject<MACD>(
    offsets[17],
    allOffsets,
    MACDSchema.serialize,
    object.macd,
  );
  writer.writeDouble(offsets[18], object.maximum);
  writer.writeString(offsets[19], object.name);
  writer.writeLong(offsets[20], object.period);
  writer.writeString(offsets[21], object.secondColor);
  writer.writeDouble(offsets[22], object.senkouSpanA);
  writer.writeDouble(offsets[23], object.senkouSpanB);
  writer.writeLong(offsets[24], object.shift);
  writer.writeDouble(offsets[25], object.shortEMA);
  writer.writeDouble(offsets[26], object.steps);
  writer.writeObject<Stochastic>(
    offsets[27],
    allOffsets,
    StochasticSchema.serialize,
    object.stochastic,
  );
  writer.writeDouble(offsets[28], object.strokeWidth);
  writer.writeByte(offsets[29], object.style.index);
  writer.writeDouble(offsets[30], object.tenkanSen);
  writer.writeByte(offsets[31], object.timeframe.index);
  writer.writeByte(offsets[32], object.type.index);
  writer.writeDouble(offsets[33], object.up);
  writer.writeDouble(offsets[34], object.value);
  writer.writeLong(offsets[35], object.windowId);
}

IndicatorEntity _indicatorEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IndicatorEntity(
    applyTo: _IndicatorEntityapplyToValueEnumMap[
            reader.readByteOrNull(offsets[0])] ??
        ApplyTo.Close,
    chikouSpan: reader.readDoubleOrNull(offsets[1]),
    color: reader.readStringOrNull(offsets[2]),
    dValue: reader.readDoubleOrNull(offsets[3]) ?? 0,
    deviations: reader.readDoubleOrNull(offsets[4]),
    dn: reader.readDoubleOrNull(offsets[5]),
    drawAsBackground: reader.readBoolOrNull(offsets[6]) ?? false,
    heightRetro: reader.readDoubleOrNull(offsets[7]) ?? 0.4,
    ichimoku: reader.readObjectOrNull<Ichimoku>(
      offsets[8],
      IchimokuSchema.deserialize,
      allOffsets,
    ),
    isMain: reader.readBoolOrNull(offsets[9]) ?? false,
    isSecondary: reader.readBoolOrNull(offsets[10]) ?? false,
    kValue: reader.readDoubleOrNull(offsets[11]) ?? 0,
    kijunSen: reader.readDoubleOrNull(offsets[12]),
    level:
        _IndicatorEntitylevelValueEnumMap[reader.readByteOrNull(offsets[13])] ??
            Levels.None,
    levels: reader.readDoubleList(offsets[14]) ?? const [],
    levelsColor: reader.readStringOrNull(offsets[15]),
    longEMA: reader.readDoubleOrNull(offsets[16]),
    macd: reader.readObjectOrNull<MACD>(
      offsets[17],
      MACDSchema.deserialize,
      allOffsets,
    ),
    maximum: reader.readDoubleOrNull(offsets[18]),
    name: reader.readStringOrNull(offsets[19]) ?? '',
    period: reader.readLongOrNull(offsets[20]) ?? 5,
    secondColor: reader.readStringOrNull(offsets[21]),
    senkouSpanA: reader.readDoubleOrNull(offsets[22]),
    senkouSpanB: reader.readDoubleOrNull(offsets[23]),
    shift: reader.readLongOrNull(offsets[24]) ?? 0,
    shortEMA: reader.readDoubleOrNull(offsets[25]),
    steps: reader.readDoubleOrNull(offsets[26]),
    stochastic: reader.readObjectOrNull<Stochastic>(
      offsets[27],
      StochasticSchema.deserialize,
      allOffsets,
    ),
    strokeWidth: reader.readDoubleOrNull(offsets[28]) ?? 1.0,
    style:
        _IndicatorEntitystyleValueEnumMap[reader.readByteOrNull(offsets[29])] ??
            ObjectStyle.normal,
    tenkanSen: reader.readDoubleOrNull(offsets[30]),
    timeframe: _IndicatorEntitytimeframeValueEnumMap[
            reader.readByteOrNull(offsets[31])] ??
        Timeframes.All_Timeframes,
    type:
        _IndicatorEntitytypeValueEnumMap[reader.readByteOrNull(offsets[32])] ??
            IndicatorType.MA_SMA,
    up: reader.readDoubleOrNull(offsets[33]),
    value: reader.readDoubleOrNull(offsets[34]) ?? 0,
    windowId: reader.readLongOrNull(offsets[35]) ?? 0,
  );
  object.id = id;
  return object;
}

P _indicatorEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_IndicatorEntityapplyToValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ApplyTo.Close) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 7:
      return (reader.readDoubleOrNull(offset) ?? 0.4) as P;
    case 8:
      return (reader.readObjectOrNull<Ichimoku>(
        offset,
        IchimokuSchema.deserialize,
        allOffsets,
      )) as P;
    case 9:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 10:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 11:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 12:
      return (reader.readDoubleOrNull(offset)) as P;
    case 13:
      return (_IndicatorEntitylevelValueEnumMap[
              reader.readByteOrNull(offset)] ??
          Levels.None) as P;
    case 14:
      return (reader.readDoubleList(offset) ?? const []) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readDoubleOrNull(offset)) as P;
    case 17:
      return (reader.readObjectOrNull<MACD>(
        offset,
        MACDSchema.deserialize,
        allOffsets,
      )) as P;
    case 18:
      return (reader.readDoubleOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 20:
      return (reader.readLongOrNull(offset) ?? 5) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    case 22:
      return (reader.readDoubleOrNull(offset)) as P;
    case 23:
      return (reader.readDoubleOrNull(offset)) as P;
    case 24:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 25:
      return (reader.readDoubleOrNull(offset)) as P;
    case 26:
      return (reader.readDoubleOrNull(offset)) as P;
    case 27:
      return (reader.readObjectOrNull<Stochastic>(
        offset,
        StochasticSchema.deserialize,
        allOffsets,
      )) as P;
    case 28:
      return (reader.readDoubleOrNull(offset) ?? 1.0) as P;
    case 29:
      return (_IndicatorEntitystyleValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ObjectStyle.normal) as P;
    case 30:
      return (reader.readDoubleOrNull(offset)) as P;
    case 31:
      return (_IndicatorEntitytimeframeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          Timeframes.All_Timeframes) as P;
    case 32:
      return (_IndicatorEntitytypeValueEnumMap[reader.readByteOrNull(offset)] ??
          IndicatorType.MA_SMA) as P;
    case 33:
      return (reader.readDoubleOrNull(offset)) as P;
    case 34:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 35:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _IndicatorEntityapplyToEnumValueMap = {
  'Close': 0,
  'Open': 1,
  'High': 2,
  'Low': 3,
  'Median_Price_HL__2': 4,
  'Middle_Price_OC__2': 5,
  'Typical_Price_HLC__3': 6,
  'Weighted_Close_HLCC__4': 7,
  'First_Indicator': 8,
  'Last_Indicator': 9,
};
const _IndicatorEntityapplyToValueEnumMap = {
  0: ApplyTo.Close,
  1: ApplyTo.Open,
  2: ApplyTo.High,
  3: ApplyTo.Low,
  4: ApplyTo.Median_Price_HL__2,
  5: ApplyTo.Middle_Price_OC__2,
  6: ApplyTo.Typical_Price_HLC__3,
  7: ApplyTo.Weighted_Close_HLCC__4,
  8: ApplyTo.First_Indicator,
  9: ApplyTo.Last_Indicator,
};
const _IndicatorEntitylevelEnumValueMap = {
  'None': 0,
};
const _IndicatorEntitylevelValueEnumMap = {
  0: Levels.None,
};
const _IndicatorEntitystyleEnumValueMap = {
  'dash': 0,
  'normal': 1,
};
const _IndicatorEntitystyleValueEnumMap = {
  0: ObjectStyle.dash,
  1: ObjectStyle.normal,
};
const _IndicatorEntitytimeframeEnumValueMap = {
  'All_Timeframes': 0,
  'None': 1,
};
const _IndicatorEntitytimeframeValueEnumMap = {
  0: Timeframes.All_Timeframes,
  1: Timeframes.None,
};
const _IndicatorEntitytypeEnumValueMap = {
  'MA_LINEAR': 0,
  'MA_SMMA': 1,
  'MA_EMA': 2,
  'MA_SMA': 3,
  'ENVELOPS_LINEAR': 4,
  'ENVELOPS_SMMA': 5,
  'ENVELOPS_EMA': 6,
  'ENVELOPS_SMA': 7,
  'BOLL': 8,
  'PARABOLIC': 9,
  'ICHIMOKU': 10,
  'MACD': 11,
  'RSI': 12,
  'ATR': 13,
  'DEM': 14,
  'CCI': 15,
  'MOM': 16,
  'SO_EMA': 17,
  'SO_LINEAR': 18,
  'SO_SMMA': 19,
  'SO_SMA': 20,
  'WPR': 21,
  'MFI': 22,
};
const _IndicatorEntitytypeValueEnumMap = {
  0: IndicatorType.MA_LINEAR,
  1: IndicatorType.MA_SMMA,
  2: IndicatorType.MA_EMA,
  3: IndicatorType.MA_SMA,
  4: IndicatorType.ENVELOPS_LINEAR,
  5: IndicatorType.ENVELOPS_SMMA,
  6: IndicatorType.ENVELOPS_EMA,
  7: IndicatorType.ENVELOPS_SMA,
  8: IndicatorType.BOLL,
  9: IndicatorType.PARABOLIC,
  10: IndicatorType.ICHIMOKU,
  11: IndicatorType.MACD,
  12: IndicatorType.RSI,
  13: IndicatorType.ATR,
  14: IndicatorType.DEM,
  15: IndicatorType.CCI,
  16: IndicatorType.MOM,
  17: IndicatorType.SO_EMA,
  18: IndicatorType.SO_LINEAR,
  19: IndicatorType.SO_SMMA,
  20: IndicatorType.SO_SMA,
  21: IndicatorType.WPR,
  22: IndicatorType.MFI,
};

Id _indicatorEntityGetId(IndicatorEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _indicatorEntityGetLinks(IndicatorEntity object) {
  return [];
}

void _indicatorEntityAttach(
    IsarCollection<dynamic> col, Id id, IndicatorEntity object) {
  object.id = id;
}

extension IndicatorEntityQueryWhereSort
    on QueryBuilder<IndicatorEntity, IndicatorEntity, QWhere> {
  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IndicatorEntityQueryWhere
    on QueryBuilder<IndicatorEntity, IndicatorEntity, QWhereClause> {
  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterWhereClause>
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterWhereClause> idBetween(
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

extension IndicatorEntityQueryFilter
    on QueryBuilder<IndicatorEntity, IndicatorEntity, QFilterCondition> {
  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      applyToEqualTo(ApplyTo value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'applyTo',
        value: value,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      applyToGreaterThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      applyToLessThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      applyToBetween(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      chikouSpanIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chikouSpan',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      chikouSpanIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chikouSpan',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      chikouSpanEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chikouSpan',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      chikouSpanGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chikouSpan',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      chikouSpanLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chikouSpan',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      chikouSpanBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chikouSpan',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      colorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      colorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      colorEqualTo(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      colorLessThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      colorBetween(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      colorEndsWith(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      colorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      colorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'color',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      colorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      colorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      dValueEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      dValueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      dValueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      dValueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      deviationsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deviations',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      deviationsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deviations',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      deviationsEqualTo(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      deviationsGreaterThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      deviationsLessThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      deviationsBetween(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      dnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dn',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      dnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dn',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      dnEqualTo(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      dnGreaterThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      dnLessThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      dnBetween(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      drawAsBackgroundEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'drawAsBackground',
        value: value,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      heightRetroEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'heightRetro',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      heightRetroGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'heightRetro',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      heightRetroLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'heightRetro',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      heightRetroBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'heightRetro',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      ichimokuIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ichimoku',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      ichimokuIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ichimoku',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      isMainEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMain',
        value: value,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      isSecondaryEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSecondary',
        value: value,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      kValueEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      kValueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      kValueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      kValueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      kijunSenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'kijunSen',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      kijunSenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'kijunSen',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      kijunSenEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kijunSen',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      kijunSenGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kijunSen',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      kijunSenLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kijunSen',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      kijunSenBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kijunSen',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelEqualTo(Levels value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'level',
        value: value,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelGreaterThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelLessThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelBetween(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'levels',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'levels',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'levels',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'levels',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'levels',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'levels',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'levels',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'levels',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'levels',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'levels',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'levelsColor',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'levelsColor',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'levelsColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'levelsColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'levelsColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'levelsColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'levelsColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'levelsColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'levelsColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'levelsColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'levelsColor',
        value: '',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      levelsColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'levelsColor',
        value: '',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      longEMAIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'longEMA',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      longEMAIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'longEMA',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      longEMAEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longEMA',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      longEMAGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longEMA',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      longEMALessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longEMA',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      longEMABetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longEMA',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      macdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'macd',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      macdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'macd',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      maximumIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maximum',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      maximumIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maximum',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      maximumEqualTo(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      maximumGreaterThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      maximumLessThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      maximumBetween(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      periodEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'period',
        value: value,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      periodGreaterThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      periodLessThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      periodBetween(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      secondColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'secondColor',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      secondColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'secondColor',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      secondColorEqualTo(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      secondColorGreaterThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      secondColorLessThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      secondColorBetween(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      secondColorStartsWith(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      secondColorEndsWith(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      secondColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'secondColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      secondColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'secondColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      secondColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secondColor',
        value: '',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      secondColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'secondColor',
        value: '',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      senkouSpanAIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'senkouSpanA',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      senkouSpanAIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'senkouSpanA',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      senkouSpanAEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senkouSpanA',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      senkouSpanAGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'senkouSpanA',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      senkouSpanALessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'senkouSpanA',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      senkouSpanABetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'senkouSpanA',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      senkouSpanBIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'senkouSpanB',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      senkouSpanBIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'senkouSpanB',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      senkouSpanBEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senkouSpanB',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      senkouSpanBGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'senkouSpanB',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      senkouSpanBLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'senkouSpanB',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      senkouSpanBBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'senkouSpanB',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      shiftEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shift',
        value: value,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      shiftGreaterThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      shiftLessThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      shiftBetween(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      shortEMAIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shortEMA',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      shortEMAIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shortEMA',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      shortEMAEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortEMA',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      shortEMAGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shortEMA',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      shortEMALessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shortEMA',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      shortEMABetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shortEMA',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      stepsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'steps',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      stepsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'steps',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      stepsEqualTo(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      stepsGreaterThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      stepsLessThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      stepsBetween(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      stochasticIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stochastic',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      stochasticIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stochastic',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      strokeWidthEqualTo(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      strokeWidthGreaterThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      strokeWidthLessThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      strokeWidthBetween(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      styleEqualTo(ObjectStyle value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'style',
        value: value,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      styleLessThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      styleBetween(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      tenkanSenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tenkanSen',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      tenkanSenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tenkanSen',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      tenkanSenEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tenkanSen',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      tenkanSenGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tenkanSen',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      tenkanSenLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tenkanSen',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      tenkanSenBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tenkanSen',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      timeframeEqualTo(Timeframes value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeframe',
        value: value,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      timeframeGreaterThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      timeframeLessThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      timeframeBetween(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      typeEqualTo(IndicatorType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      typeGreaterThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      typeLessThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      typeBetween(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      upIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'up',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      upIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'up',
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      upEqualTo(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      upGreaterThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      upLessThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      upBetween(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      valueEqualTo(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      valueLessThan(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      valueBetween(
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

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      windowIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'windowId',
        value: value,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      windowIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'windowId',
        value: value,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      windowIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'windowId',
        value: value,
      ));
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      windowIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'windowId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IndicatorEntityQueryObject
    on QueryBuilder<IndicatorEntity, IndicatorEntity, QFilterCondition> {
  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      ichimoku(FilterQuery<Ichimoku> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'ichimoku');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition> macd(
      FilterQuery<MACD> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'macd');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterFilterCondition>
      stochastic(FilterQuery<Stochastic> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'stochastic');
    });
  }
}

extension IndicatorEntityQueryLinks
    on QueryBuilder<IndicatorEntity, IndicatorEntity, QFilterCondition> {}

extension IndicatorEntityQuerySortBy
    on QueryBuilder<IndicatorEntity, IndicatorEntity, QSortBy> {
  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> sortByApplyTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applyTo', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByApplyToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applyTo', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByChikouSpan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chikouSpan', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByChikouSpanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chikouSpan', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> sortByDValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dValue', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByDValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dValue', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByDeviations() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviations', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByDeviationsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviations', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> sortByDn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dn', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> sortByDnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dn', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByDrawAsBackground() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drawAsBackground', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByDrawAsBackgroundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drawAsBackground', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByHeightRetro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightRetro', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByHeightRetroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightRetro', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> sortByIsMain() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMain', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByIsMainDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMain', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByIsSecondary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSecondary', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByIsSecondaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSecondary', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> sortByKValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kValue', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByKValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kValue', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByKijunSen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kijunSen', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByKijunSenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kijunSen', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> sortByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByLevelsColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'levelsColor', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByLevelsColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'levelsColor', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> sortByLongEMA() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longEMA', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByLongEMADesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longEMA', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> sortByMaximum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maximum', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByMaximumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maximum', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> sortByPeriod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'period', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByPeriodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'period', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortBySecondColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondColor', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortBySecondColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondColor', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortBySenkouSpanA() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senkouSpanA', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortBySenkouSpanADesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senkouSpanA', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortBySenkouSpanB() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senkouSpanB', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortBySenkouSpanBDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senkouSpanB', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> sortByShift() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shift', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByShiftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shift', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByShortEMA() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortEMA', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByShortEMADesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortEMA', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> sortBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByStrokeWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strokeWidth', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByStrokeWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strokeWidth', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> sortByStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByStyleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByTenkanSen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tenkanSen', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByTenkanSenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tenkanSen', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByTimeframe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeframe', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByTimeframeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeframe', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> sortByUp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'up', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> sortByUpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'up', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> sortByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByWindowId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'windowId', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      sortByWindowIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'windowId', Sort.desc);
    });
  }
}

extension IndicatorEntityQuerySortThenBy
    on QueryBuilder<IndicatorEntity, IndicatorEntity, QSortThenBy> {
  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenByApplyTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applyTo', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByApplyToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applyTo', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByChikouSpan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chikouSpan', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByChikouSpanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chikouSpan', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenByDValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dValue', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByDValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dValue', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByDeviations() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviations', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByDeviationsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviations', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenByDn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dn', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenByDnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dn', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByDrawAsBackground() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drawAsBackground', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByDrawAsBackgroundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'drawAsBackground', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByHeightRetro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightRetro', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByHeightRetroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightRetro', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenByIsMain() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMain', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByIsMainDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMain', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByIsSecondary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSecondary', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByIsSecondaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSecondary', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenByKValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kValue', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByKValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kValue', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByKijunSen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kijunSen', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByKijunSenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kijunSen', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByLevelsColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'levelsColor', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByLevelsColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'levelsColor', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenByLongEMA() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longEMA', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByLongEMADesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longEMA', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenByMaximum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maximum', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByMaximumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maximum', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenByPeriod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'period', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByPeriodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'period', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenBySecondColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondColor', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenBySecondColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondColor', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenBySenkouSpanA() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senkouSpanA', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenBySenkouSpanADesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senkouSpanA', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenBySenkouSpanB() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senkouSpanB', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenBySenkouSpanBDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senkouSpanB', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenByShift() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shift', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByShiftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shift', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByShortEMA() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortEMA', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByShortEMADesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortEMA', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByStrokeWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strokeWidth', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByStrokeWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strokeWidth', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenByStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByStyleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'style', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByTenkanSen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tenkanSen', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByTenkanSenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tenkanSen', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByTimeframe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeframe', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByTimeframeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeframe', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenByUp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'up', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenByUpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'up', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy> thenByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByWindowId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'windowId', Sort.asc);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QAfterSortBy>
      thenByWindowIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'windowId', Sort.desc);
    });
  }
}

extension IndicatorEntityQueryWhereDistinct
    on QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct> {
  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct>
      distinctByApplyTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'applyTo');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct>
      distinctByChikouSpan() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chikouSpan');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct> distinctByColor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct> distinctByDValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dValue');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct>
      distinctByDeviations() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deviations');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct> distinctByDn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dn');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct>
      distinctByDrawAsBackground() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'drawAsBackground');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct>
      distinctByHeightRetro() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'heightRetro');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct> distinctByIsMain() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMain');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct>
      distinctByIsSecondary() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSecondary');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct> distinctByKValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kValue');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct>
      distinctByKijunSen() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kijunSen');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct> distinctByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'level');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct> distinctByLevels() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'levels');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct>
      distinctByLevelsColor({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'levelsColor', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct>
      distinctByLongEMA() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longEMA');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct>
      distinctByMaximum() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maximum');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct> distinctByPeriod() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'period');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct>
      distinctBySecondColor({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'secondColor', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct>
      distinctBySenkouSpanA() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'senkouSpanA');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct>
      distinctBySenkouSpanB() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'senkouSpanB');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct> distinctByShift() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shift');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct>
      distinctByShortEMA() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shortEMA');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct> distinctBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'steps');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct>
      distinctByStrokeWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'strokeWidth');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct> distinctByStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'style');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct>
      distinctByTenkanSen() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tenkanSen');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct>
      distinctByTimeframe() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeframe');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct> distinctByUp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'up');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct> distinctByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'value');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorEntity, QDistinct>
      distinctByWindowId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'windowId');
    });
  }
}

extension IndicatorEntityQueryProperty
    on QueryBuilder<IndicatorEntity, IndicatorEntity, QQueryProperty> {
  QueryBuilder<IndicatorEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IndicatorEntity, ApplyTo, QQueryOperations> applyToProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'applyTo');
    });
  }

  QueryBuilder<IndicatorEntity, double?, QQueryOperations>
      chikouSpanProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chikouSpan');
    });
  }

  QueryBuilder<IndicatorEntity, String?, QQueryOperations> colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<IndicatorEntity, double, QQueryOperations> dValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dValue');
    });
  }

  QueryBuilder<IndicatorEntity, double?, QQueryOperations>
      deviationsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deviations');
    });
  }

  QueryBuilder<IndicatorEntity, double?, QQueryOperations> dnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dn');
    });
  }

  QueryBuilder<IndicatorEntity, bool, QQueryOperations>
      drawAsBackgroundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'drawAsBackground');
    });
  }

  QueryBuilder<IndicatorEntity, double, QQueryOperations>
      heightRetroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'heightRetro');
    });
  }

  QueryBuilder<IndicatorEntity, Ichimoku?, QQueryOperations>
      ichimokuProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ichimoku');
    });
  }

  QueryBuilder<IndicatorEntity, bool, QQueryOperations> isMainProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMain');
    });
  }

  QueryBuilder<IndicatorEntity, bool, QQueryOperations> isSecondaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSecondary');
    });
  }

  QueryBuilder<IndicatorEntity, double, QQueryOperations> kValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kValue');
    });
  }

  QueryBuilder<IndicatorEntity, double?, QQueryOperations> kijunSenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kijunSen');
    });
  }

  QueryBuilder<IndicatorEntity, Levels, QQueryOperations> levelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'level');
    });
  }

  QueryBuilder<IndicatorEntity, List<double>, QQueryOperations>
      levelsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'levels');
    });
  }

  QueryBuilder<IndicatorEntity, String?, QQueryOperations>
      levelsColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'levelsColor');
    });
  }

  QueryBuilder<IndicatorEntity, double?, QQueryOperations> longEMAProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longEMA');
    });
  }

  QueryBuilder<IndicatorEntity, MACD?, QQueryOperations> macdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'macd');
    });
  }

  QueryBuilder<IndicatorEntity, double?, QQueryOperations> maximumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maximum');
    });
  }

  QueryBuilder<IndicatorEntity, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<IndicatorEntity, int, QQueryOperations> periodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'period');
    });
  }

  QueryBuilder<IndicatorEntity, String?, QQueryOperations>
      secondColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'secondColor');
    });
  }

  QueryBuilder<IndicatorEntity, double?, QQueryOperations>
      senkouSpanAProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'senkouSpanA');
    });
  }

  QueryBuilder<IndicatorEntity, double?, QQueryOperations>
      senkouSpanBProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'senkouSpanB');
    });
  }

  QueryBuilder<IndicatorEntity, int, QQueryOperations> shiftProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shift');
    });
  }

  QueryBuilder<IndicatorEntity, double?, QQueryOperations> shortEMAProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shortEMA');
    });
  }

  QueryBuilder<IndicatorEntity, double?, QQueryOperations> stepsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'steps');
    });
  }

  QueryBuilder<IndicatorEntity, Stochastic?, QQueryOperations>
      stochasticProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stochastic');
    });
  }

  QueryBuilder<IndicatorEntity, double, QQueryOperations>
      strokeWidthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'strokeWidth');
    });
  }

  QueryBuilder<IndicatorEntity, ObjectStyle, QQueryOperations> styleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'style');
    });
  }

  QueryBuilder<IndicatorEntity, double?, QQueryOperations> tenkanSenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tenkanSen');
    });
  }

  QueryBuilder<IndicatorEntity, Timeframes, QQueryOperations>
      timeframeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeframe');
    });
  }

  QueryBuilder<IndicatorEntity, IndicatorType, QQueryOperations>
      typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<IndicatorEntity, double?, QQueryOperations> upProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'up');
    });
  }

  QueryBuilder<IndicatorEntity, double, QQueryOperations> valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'value');
    });
  }

  QueryBuilder<IndicatorEntity, int, QQueryOperations> windowIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'windowId');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const IchimokuSchema = Schema(
  name: r'Ichimoku',
  id: 3563966005362693612,
  properties: {
    r'chikouSpanColor': PropertySchema(
      id: 0,
      name: r'chikouSpanColor',
      type: IsarType.string,
    ),
    r'downKumoColor': PropertySchema(
      id: 1,
      name: r'downKumoColor',
      type: IsarType.string,
    ),
    r'kijuSen': PropertySchema(
      id: 2,
      name: r'kijuSen',
      type: IsarType.long,
    ),
    r'kijuSenColor': PropertySchema(
      id: 3,
      name: r'kijuSenColor',
      type: IsarType.string,
    ),
    r'senkouSpan': PropertySchema(
      id: 4,
      name: r'senkouSpan',
      type: IsarType.long,
    ),
    r'tenkanSen': PropertySchema(
      id: 5,
      name: r'tenkanSen',
      type: IsarType.long,
    ),
    r'tenkanSenColor': PropertySchema(
      id: 6,
      name: r'tenkanSenColor',
      type: IsarType.string,
    ),
    r'upKumoColor': PropertySchema(
      id: 7,
      name: r'upKumoColor',
      type: IsarType.string,
    )
  },
  estimateSize: _ichimokuEstimateSize,
  serialize: _ichimokuSerialize,
  deserialize: _ichimokuDeserialize,
  deserializeProp: _ichimokuDeserializeProp,
);

int _ichimokuEstimateSize(
  Ichimoku object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.chikouSpanColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.downKumoColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.kijuSenColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tenkanSenColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.upKumoColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _ichimokuSerialize(
  Ichimoku object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.chikouSpanColor);
  writer.writeString(offsets[1], object.downKumoColor);
  writer.writeLong(offsets[2], object.kijuSen);
  writer.writeString(offsets[3], object.kijuSenColor);
  writer.writeLong(offsets[4], object.senkouSpan);
  writer.writeLong(offsets[5], object.tenkanSen);
  writer.writeString(offsets[6], object.tenkanSenColor);
  writer.writeString(offsets[7], object.upKumoColor);
}

Ichimoku _ichimokuDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Ichimoku(
    chikouSpanColor: reader.readStringOrNull(offsets[0]),
    downKumoColor: reader.readStringOrNull(offsets[1]),
    kijuSen: reader.readLongOrNull(offsets[2]) ?? 26,
    kijuSenColor: reader.readStringOrNull(offsets[3]),
    senkouSpan: reader.readLongOrNull(offsets[4]) ?? 52,
    tenkanSen: reader.readLongOrNull(offsets[5]) ?? 9,
    tenkanSenColor: reader.readStringOrNull(offsets[6]),
    upKumoColor: reader.readStringOrNull(offsets[7]),
  );
  return object;
}

P _ichimokuDeserializeProp<P>(
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
      return (reader.readLongOrNull(offset) ?? 26) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset) ?? 52) as P;
    case 5:
      return (reader.readLongOrNull(offset) ?? 9) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension IchimokuQueryFilter
    on QueryBuilder<Ichimoku, Ichimoku, QFilterCondition> {
  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      chikouSpanColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chikouSpanColor',
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      chikouSpanColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chikouSpanColor',
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      chikouSpanColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chikouSpanColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      chikouSpanColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chikouSpanColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      chikouSpanColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chikouSpanColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      chikouSpanColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chikouSpanColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      chikouSpanColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'chikouSpanColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      chikouSpanColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'chikouSpanColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      chikouSpanColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chikouSpanColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      chikouSpanColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chikouSpanColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      chikouSpanColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chikouSpanColor',
        value: '',
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      chikouSpanColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chikouSpanColor',
        value: '',
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      downKumoColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'downKumoColor',
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      downKumoColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'downKumoColor',
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> downKumoColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'downKumoColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      downKumoColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'downKumoColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> downKumoColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'downKumoColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> downKumoColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'downKumoColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      downKumoColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'downKumoColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> downKumoColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'downKumoColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> downKumoColorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'downKumoColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> downKumoColorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'downKumoColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      downKumoColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'downKumoColor',
        value: '',
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      downKumoColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'downKumoColor',
        value: '',
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> kijuSenEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kijuSen',
        value: value,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> kijuSenGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kijuSen',
        value: value,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> kijuSenLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kijuSen',
        value: value,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> kijuSenBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kijuSen',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> kijuSenColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'kijuSenColor',
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      kijuSenColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'kijuSenColor',
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> kijuSenColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kijuSenColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      kijuSenColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kijuSenColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> kijuSenColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kijuSenColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> kijuSenColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kijuSenColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      kijuSenColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'kijuSenColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> kijuSenColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'kijuSenColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> kijuSenColorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'kijuSenColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> kijuSenColorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'kijuSenColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      kijuSenColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kijuSenColor',
        value: '',
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      kijuSenColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'kijuSenColor',
        value: '',
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> senkouSpanEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senkouSpan',
        value: value,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> senkouSpanGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'senkouSpan',
        value: value,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> senkouSpanLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'senkouSpan',
        value: value,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> senkouSpanBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'senkouSpan',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> tenkanSenEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tenkanSen',
        value: value,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> tenkanSenGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tenkanSen',
        value: value,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> tenkanSenLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tenkanSen',
        value: value,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> tenkanSenBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tenkanSen',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      tenkanSenColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tenkanSenColor',
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      tenkanSenColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tenkanSenColor',
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> tenkanSenColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tenkanSenColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      tenkanSenColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tenkanSenColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      tenkanSenColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tenkanSenColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> tenkanSenColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tenkanSenColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      tenkanSenColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tenkanSenColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      tenkanSenColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tenkanSenColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      tenkanSenColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tenkanSenColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> tenkanSenColorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tenkanSenColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      tenkanSenColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tenkanSenColor',
        value: '',
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      tenkanSenColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tenkanSenColor',
        value: '',
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> upKumoColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'upKumoColor',
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      upKumoColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'upKumoColor',
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> upKumoColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'upKumoColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      upKumoColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'upKumoColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> upKumoColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'upKumoColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> upKumoColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'upKumoColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> upKumoColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'upKumoColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> upKumoColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'upKumoColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> upKumoColorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'upKumoColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> upKumoColorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'upKumoColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition> upKumoColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'upKumoColor',
        value: '',
      ));
    });
  }

  QueryBuilder<Ichimoku, Ichimoku, QAfterFilterCondition>
      upKumoColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'upKumoColor',
        value: '',
      ));
    });
  }
}

extension IchimokuQueryObject
    on QueryBuilder<Ichimoku, Ichimoku, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MACDSchema = Schema(
  name: r'MACD',
  id: 4271815911900684776,
  properties: {
    r'fastEma': PropertySchema(
      id: 0,
      name: r'fastEma',
      type: IsarType.long,
    ),
    r'macdSma': PropertySchema(
      id: 1,
      name: r'macdSma',
      type: IsarType.long,
    ),
    r'mainColor': PropertySchema(
      id: 2,
      name: r'mainColor',
      type: IsarType.string,
    ),
    r'signalColor': PropertySchema(
      id: 3,
      name: r'signalColor',
      type: IsarType.string,
    ),
    r'slowEma': PropertySchema(
      id: 4,
      name: r'slowEma',
      type: IsarType.long,
    )
  },
  estimateSize: _mACDEstimateSize,
  serialize: _mACDSerialize,
  deserialize: _mACDDeserialize,
  deserializeProp: _mACDDeserializeProp,
);

int _mACDEstimateSize(
  MACD object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.mainColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.signalColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _mACDSerialize(
  MACD object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.fastEma);
  writer.writeLong(offsets[1], object.macdSma);
  writer.writeString(offsets[2], object.mainColor);
  writer.writeString(offsets[3], object.signalColor);
  writer.writeLong(offsets[4], object.slowEma);
}

MACD _mACDDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MACD(
    fastEma: reader.readLongOrNull(offsets[0]) ?? 12,
    macdSma: reader.readLongOrNull(offsets[1]) ?? 9,
    mainColor: reader.readStringOrNull(offsets[2]),
    signalColor: reader.readStringOrNull(offsets[3]),
    slowEma: reader.readLongOrNull(offsets[4]) ?? 26,
  );
  return object;
}

P _mACDDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 12) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 9) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset) ?? 26) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension MACDQueryFilter on QueryBuilder<MACD, MACD, QFilterCondition> {
  QueryBuilder<MACD, MACD, QAfterFilterCondition> fastEmaEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fastEma',
        value: value,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> fastEmaGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fastEma',
        value: value,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> fastEmaLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fastEma',
        value: value,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> fastEmaBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fastEma',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> macdSmaEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'macdSma',
        value: value,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> macdSmaGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'macdSma',
        value: value,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> macdSmaLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'macdSma',
        value: value,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> macdSmaBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'macdSma',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> mainColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mainColor',
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> mainColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mainColor',
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> mainColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mainColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> mainColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mainColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> mainColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mainColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> mainColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mainColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> mainColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mainColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> mainColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mainColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> mainColorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mainColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> mainColorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mainColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> mainColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mainColor',
        value: '',
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> mainColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mainColor',
        value: '',
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> signalColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'signalColor',
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> signalColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'signalColor',
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> signalColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'signalColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> signalColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'signalColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> signalColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'signalColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> signalColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'signalColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> signalColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'signalColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> signalColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'signalColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> signalColorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'signalColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> signalColorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'signalColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> signalColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'signalColor',
        value: '',
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> signalColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'signalColor',
        value: '',
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> slowEmaEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'slowEma',
        value: value,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> slowEmaGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'slowEma',
        value: value,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> slowEmaLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'slowEma',
        value: value,
      ));
    });
  }

  QueryBuilder<MACD, MACD, QAfterFilterCondition> slowEmaBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'slowEma',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MACDQueryObject on QueryBuilder<MACD, MACD, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const StochasticSchema = Schema(
  name: r'Stochastic',
  id: 6422956883162085557,
  properties: {
    r'dPeriod': PropertySchema(
      id: 0,
      name: r'dPeriod',
      type: IsarType.long,
    ),
    r'kPeriod': PropertySchema(
      id: 1,
      name: r'kPeriod',
      type: IsarType.long,
    ),
    r'mainColor': PropertySchema(
      id: 2,
      name: r'mainColor',
      type: IsarType.string,
    ),
    r'priceField': PropertySchema(
      id: 3,
      name: r'priceField',
      type: IsarType.byte,
      enumMap: _StochasticpriceFieldEnumValueMap,
    ),
    r'signalColor': PropertySchema(
      id: 4,
      name: r'signalColor',
      type: IsarType.string,
    ),
    r'slowing': PropertySchema(
      id: 5,
      name: r'slowing',
      type: IsarType.long,
    )
  },
  estimateSize: _stochasticEstimateSize,
  serialize: _stochasticSerialize,
  deserialize: _stochasticDeserialize,
  deserializeProp: _stochasticDeserializeProp,
);

int _stochasticEstimateSize(
  Stochastic object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.mainColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.signalColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _stochasticSerialize(
  Stochastic object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.dPeriod);
  writer.writeLong(offsets[1], object.kPeriod);
  writer.writeString(offsets[2], object.mainColor);
  writer.writeByte(offsets[3], object.priceField.index);
  writer.writeString(offsets[4], object.signalColor);
  writer.writeLong(offsets[5], object.slowing);
}

Stochastic _stochasticDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Stochastic(
    dPeriod: reader.readLongOrNull(offsets[0]) ?? 3,
    kPeriod: reader.readLongOrNull(offsets[1]) ?? 5,
    mainColor: reader.readStringOrNull(offsets[2]),
    signalColor: reader.readStringOrNull(offsets[4]),
    slowing: reader.readLongOrNull(offsets[5]) ?? 3,
  );
  object.priceField =
      _StochasticpriceFieldValueEnumMap[reader.readByteOrNull(offsets[3])] ??
          PriceField.Low_High;
  return object;
}

P _stochasticDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 3) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 5) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (_StochasticpriceFieldValueEnumMap[
              reader.readByteOrNull(offset)] ??
          PriceField.Low_High) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset) ?? 3) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _StochasticpriceFieldEnumValueMap = {
  'Low_High': 0,
  'Close_Close': 1,
};
const _StochasticpriceFieldValueEnumMap = {
  0: PriceField.Low_High,
  1: PriceField.Close_Close,
};

extension StochasticQueryFilter
    on QueryBuilder<Stochastic, Stochastic, QFilterCondition> {
  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition> dPeriodEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dPeriod',
        value: value,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      dPeriodGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dPeriod',
        value: value,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition> dPeriodLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dPeriod',
        value: value,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition> dPeriodBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dPeriod',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition> kPeriodEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kPeriod',
        value: value,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      kPeriodGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kPeriod',
        value: value,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition> kPeriodLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kPeriod',
        value: value,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition> kPeriodBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kPeriod',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      mainColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mainColor',
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      mainColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mainColor',
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition> mainColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mainColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      mainColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mainColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition> mainColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mainColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition> mainColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mainColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      mainColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mainColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition> mainColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mainColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition> mainColorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mainColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition> mainColorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mainColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      mainColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mainColor',
        value: '',
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      mainColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mainColor',
        value: '',
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition> priceFieldEqualTo(
      PriceField value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priceField',
        value: value,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      priceFieldGreaterThan(
    PriceField value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'priceField',
        value: value,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      priceFieldLessThan(
    PriceField value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'priceField',
        value: value,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition> priceFieldBetween(
    PriceField lower,
    PriceField upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'priceField',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      signalColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'signalColor',
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      signalColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'signalColor',
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      signalColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'signalColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      signalColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'signalColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      signalColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'signalColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      signalColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'signalColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      signalColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'signalColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      signalColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'signalColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      signalColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'signalColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      signalColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'signalColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      signalColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'signalColor',
        value: '',
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      signalColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'signalColor',
        value: '',
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition> slowingEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'slowing',
        value: value,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition>
      slowingGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'slowing',
        value: value,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition> slowingLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'slowing',
        value: value,
      ));
    });
  }

  QueryBuilder<Stochastic, Stochastic, QAfterFilterCondition> slowingBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'slowing',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension StochasticQueryObject
    on QueryBuilder<Stochastic, Stochastic, QFilterCondition> {}
