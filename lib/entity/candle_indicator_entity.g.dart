// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candle_indicator_entity.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CandleIndicatorEntitySchema = Schema(
  name: r'CandleIndicatorEntity',
  id: -8351318507956919182,
  properties: {
    r'applyTo': PropertySchema(
      id: 0,
      name: r'applyTo',
      type: IsarType.byte,
      enumMap: _CandleIndicatorEntityapplyToEnumValueMap,
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
    r'ichimoku': PropertySchema(
      id: 7,
      name: r'ichimoku',
      type: IsarType.object,
      target: r'Ichimoku',
    ),
    r'isMain': PropertySchema(
      id: 8,
      name: r'isMain',
      type: IsarType.bool,
    ),
    r'isSecondary': PropertySchema(
      id: 9,
      name: r'isSecondary',
      type: IsarType.bool,
    ),
    r'kValue': PropertySchema(
      id: 10,
      name: r'kValue',
      type: IsarType.double,
    ),
    r'kijunSen': PropertySchema(
      id: 11,
      name: r'kijunSen',
      type: IsarType.double,
    ),
    r'level': PropertySchema(
      id: 12,
      name: r'level',
      type: IsarType.byte,
      enumMap: _CandleIndicatorEntitylevelEnumValueMap,
    ),
    r'levels': PropertySchema(
      id: 13,
      name: r'levels',
      type: IsarType.doubleList,
    ),
    r'levelsColor': PropertySchema(
      id: 14,
      name: r'levelsColor',
      type: IsarType.string,
    ),
    r'longEMA': PropertySchema(
      id: 15,
      name: r'longEMA',
      type: IsarType.double,
    ),
    r'macd': PropertySchema(
      id: 16,
      name: r'macd',
      type: IsarType.object,
      target: r'MACD',
    ),
    r'maximum': PropertySchema(
      id: 17,
      name: r'maximum',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 18,
      name: r'name',
      type: IsarType.string,
    ),
    r'period': PropertySchema(
      id: 19,
      name: r'period',
      type: IsarType.long,
    ),
    r'secondColor': PropertySchema(
      id: 20,
      name: r'secondColor',
      type: IsarType.string,
    ),
    r'senkouSpanA': PropertySchema(
      id: 21,
      name: r'senkouSpanA',
      type: IsarType.double,
    ),
    r'senkouSpanB': PropertySchema(
      id: 22,
      name: r'senkouSpanB',
      type: IsarType.double,
    ),
    r'shift': PropertySchema(
      id: 23,
      name: r'shift',
      type: IsarType.long,
    ),
    r'shortEMA': PropertySchema(
      id: 24,
      name: r'shortEMA',
      type: IsarType.double,
    ),
    r'steps': PropertySchema(
      id: 25,
      name: r'steps',
      type: IsarType.double,
    ),
    r'stochastic': PropertySchema(
      id: 26,
      name: r'stochastic',
      type: IsarType.object,
      target: r'Stochastic',
    ),
    r'strokeWidth': PropertySchema(
      id: 27,
      name: r'strokeWidth',
      type: IsarType.double,
    ),
    r'style': PropertySchema(
      id: 28,
      name: r'style',
      type: IsarType.byte,
      enumMap: _CandleIndicatorEntitystyleEnumValueMap,
    ),
    r'tenkanSen': PropertySchema(
      id: 29,
      name: r'tenkanSen',
      type: IsarType.double,
    ),
    r'timeframe': PropertySchema(
      id: 30,
      name: r'timeframe',
      type: IsarType.byte,
      enumMap: _CandleIndicatorEntitytimeframeEnumValueMap,
    ),
    r'type': PropertySchema(
      id: 31,
      name: r'type',
      type: IsarType.byte,
      enumMap: _CandleIndicatorEntitytypeEnumValueMap,
    ),
    r'up': PropertySchema(
      id: 32,
      name: r'up',
      type: IsarType.double,
    ),
    r'value': PropertySchema(
      id: 33,
      name: r'value',
      type: IsarType.double,
    ),
    r'windowId': PropertySchema(
      id: 34,
      name: r'windowId',
      type: IsarType.long,
    )
  },
  estimateSize: _candleIndicatorEntityEstimateSize,
  serialize: _candleIndicatorEntitySerialize,
  deserialize: _candleIndicatorEntityDeserialize,
  deserializeProp: _candleIndicatorEntityDeserializeProp,
);

int _candleIndicatorEntityEstimateSize(
  CandleIndicatorEntity object,
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

void _candleIndicatorEntitySerialize(
  CandleIndicatorEntity object,
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
  writer.writeObject<Ichimoku>(
    offsets[7],
    allOffsets,
    IchimokuSchema.serialize,
    object.ichimoku,
  );
  writer.writeBool(offsets[8], object.isMain);
  writer.writeBool(offsets[9], object.isSecondary);
  writer.writeDouble(offsets[10], object.kValue);
  writer.writeDouble(offsets[11], object.kijunSen);
  writer.writeByte(offsets[12], object.level.index);
  writer.writeDoubleList(offsets[13], object.levels);
  writer.writeString(offsets[14], object.levelsColor);
  writer.writeDouble(offsets[15], object.longEMA);
  writer.writeObject<MACD>(
    offsets[16],
    allOffsets,
    MACDSchema.serialize,
    object.macd,
  );
  writer.writeDouble(offsets[17], object.maximum);
  writer.writeString(offsets[18], object.name);
  writer.writeLong(offsets[19], object.period);
  writer.writeString(offsets[20], object.secondColor);
  writer.writeDouble(offsets[21], object.senkouSpanA);
  writer.writeDouble(offsets[22], object.senkouSpanB);
  writer.writeLong(offsets[23], object.shift);
  writer.writeDouble(offsets[24], object.shortEMA);
  writer.writeDouble(offsets[25], object.steps);
  writer.writeObject<Stochastic>(
    offsets[26],
    allOffsets,
    StochasticSchema.serialize,
    object.stochastic,
  );
  writer.writeDouble(offsets[27], object.strokeWidth);
  writer.writeByte(offsets[28], object.style.index);
  writer.writeDouble(offsets[29], object.tenkanSen);
  writer.writeByte(offsets[30], object.timeframe.index);
  writer.writeByte(offsets[31], object.type.index);
  writer.writeDouble(offsets[32], object.up);
  writer.writeDouble(offsets[33], object.value);
  writer.writeLong(offsets[34], object.windowId);
}

CandleIndicatorEntity _candleIndicatorEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CandleIndicatorEntity(
    applyTo: _CandleIndicatorEntityapplyToValueEnumMap[
            reader.readByteOrNull(offsets[0])] ??
        ApplyTo.Close,
    chikouSpan: reader.readDoubleOrNull(offsets[1]),
    color: reader.readStringOrNull(offsets[2]),
    dValue: reader.readDoubleOrNull(offsets[3]) ?? 0,
    deviations: reader.readDoubleOrNull(offsets[4]),
    dn: reader.readDoubleOrNull(offsets[5]),
    drawAsBackground: reader.readBoolOrNull(offsets[6]) ?? false,
    ichimoku: reader.readObjectOrNull<Ichimoku>(
      offsets[7],
      IchimokuSchema.deserialize,
      allOffsets,
    ),
    isMain: reader.readBoolOrNull(offsets[8]) ?? false,
    isSecondary: reader.readBoolOrNull(offsets[9]) ?? false,
    kValue: reader.readDoubleOrNull(offsets[10]) ?? 0,
    kijunSen: reader.readDoubleOrNull(offsets[11]),
    level: _CandleIndicatorEntitylevelValueEnumMap[
            reader.readByteOrNull(offsets[12])] ??
        Levels.None,
    levels: reader.readDoubleList(offsets[13]) ?? const [],
    levelsColor: reader.readStringOrNull(offsets[14]),
    longEMA: reader.readDoubleOrNull(offsets[15]),
    macd: reader.readObjectOrNull<MACD>(
      offsets[16],
      MACDSchema.deserialize,
      allOffsets,
    ),
    maximum: reader.readDoubleOrNull(offsets[17]),
    name: reader.readStringOrNull(offsets[18]) ?? '',
    period: reader.readLongOrNull(offsets[19]) ?? 5,
    secondColor: reader.readStringOrNull(offsets[20]),
    senkouSpanA: reader.readDoubleOrNull(offsets[21]),
    senkouSpanB: reader.readDoubleOrNull(offsets[22]),
    shift: reader.readLongOrNull(offsets[23]) ?? 0,
    shortEMA: reader.readDoubleOrNull(offsets[24]),
    steps: reader.readDoubleOrNull(offsets[25]),
    stochastic: reader.readObjectOrNull<Stochastic>(
      offsets[26],
      StochasticSchema.deserialize,
      allOffsets,
    ),
    strokeWidth: reader.readDoubleOrNull(offsets[27]) ?? 1.0,
    style: _CandleIndicatorEntitystyleValueEnumMap[
            reader.readByteOrNull(offsets[28])] ??
        LineStyle.normal,
    tenkanSen: reader.readDoubleOrNull(offsets[29]),
    timeframe: _CandleIndicatorEntitytimeframeValueEnumMap[
            reader.readByteOrNull(offsets[30])] ??
        Timeframes.All_Timeframes,
    type: _CandleIndicatorEntitytypeValueEnumMap[
            reader.readByteOrNull(offsets[31])] ??
        IndicatorType.MA_SMA,
    up: reader.readDoubleOrNull(offsets[32]),
    value: reader.readDoubleOrNull(offsets[33]) ?? 0,
    windowId: reader.readLongOrNull(offsets[34]) ?? 0,
  );
  return object;
}

P _candleIndicatorEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_CandleIndicatorEntityapplyToValueEnumMap[
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
      return (reader.readObjectOrNull<Ichimoku>(
        offset,
        IchimokuSchema.deserialize,
        allOffsets,
      )) as P;
    case 8:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 9:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 10:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 11:
      return (reader.readDoubleOrNull(offset)) as P;
    case 12:
      return (_CandleIndicatorEntitylevelValueEnumMap[
              reader.readByteOrNull(offset)] ??
          Levels.None) as P;
    case 13:
      return (reader.readDoubleList(offset) ?? const []) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readDoubleOrNull(offset)) as P;
    case 16:
      return (reader.readObjectOrNull<MACD>(
        offset,
        MACDSchema.deserialize,
        allOffsets,
      )) as P;
    case 17:
      return (reader.readDoubleOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 19:
      return (reader.readLongOrNull(offset) ?? 5) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (reader.readDoubleOrNull(offset)) as P;
    case 22:
      return (reader.readDoubleOrNull(offset)) as P;
    case 23:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 24:
      return (reader.readDoubleOrNull(offset)) as P;
    case 25:
      return (reader.readDoubleOrNull(offset)) as P;
    case 26:
      return (reader.readObjectOrNull<Stochastic>(
        offset,
        StochasticSchema.deserialize,
        allOffsets,
      )) as P;
    case 27:
      return (reader.readDoubleOrNull(offset) ?? 1.0) as P;
    case 28:
      return (_CandleIndicatorEntitystyleValueEnumMap[
              reader.readByteOrNull(offset)] ??
          LineStyle.normal) as P;
    case 29:
      return (reader.readDoubleOrNull(offset)) as P;
    case 30:
      return (_CandleIndicatorEntitytimeframeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          Timeframes.All_Timeframes) as P;
    case 31:
      return (_CandleIndicatorEntitytypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          IndicatorType.MA_SMA) as P;
    case 32:
      return (reader.readDoubleOrNull(offset)) as P;
    case 33:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 34:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CandleIndicatorEntityapplyToEnumValueMap = {
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
const _CandleIndicatorEntityapplyToValueEnumMap = {
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
const _CandleIndicatorEntitylevelEnumValueMap = {
  'None': 0,
};
const _CandleIndicatorEntitylevelValueEnumMap = {
  0: Levels.None,
};
const _CandleIndicatorEntitystyleEnumValueMap = {
  'dash': 0,
  'normal': 1,
  'longDash': 2,
};
const _CandleIndicatorEntitystyleValueEnumMap = {
  0: LineStyle.dash,
  1: LineStyle.normal,
  2: LineStyle.longDash,
};
const _CandleIndicatorEntitytimeframeEnumValueMap = {
  'All_Timeframes': 0,
  'None': 1,
};
const _CandleIndicatorEntitytimeframeValueEnumMap = {
  0: Timeframes.All_Timeframes,
  1: Timeframes.None,
};
const _CandleIndicatorEntitytypeEnumValueMap = {
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
const _CandleIndicatorEntitytypeValueEnumMap = {
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

extension CandleIndicatorEntityQueryFilter on QueryBuilder<
    CandleIndicatorEntity, CandleIndicatorEntity, QFilterCondition> {
  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> applyToEqualTo(ApplyTo value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'applyTo',
        value: value,
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> chikouSpanIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chikouSpan',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> chikouSpanIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chikouSpan',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> chikouSpanEqualTo(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> chikouSpanGreaterThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> chikouSpanLessThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> chikouSpanBetween(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> colorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> colorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> colorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> colorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> dValueEqualTo(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> dValueGreaterThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> dValueLessThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> dValueBetween(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> deviationsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deviations',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> deviationsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deviations',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> dnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dn',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> dnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dn',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> drawAsBackgroundEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'drawAsBackground',
        value: value,
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> ichimokuIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ichimoku',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> ichimokuIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ichimoku',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> isMainEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMain',
        value: value,
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> isSecondaryEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSecondary',
        value: value,
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> kValueEqualTo(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> kValueGreaterThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> kValueLessThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> kValueBetween(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> kijunSenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'kijunSen',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> kijunSenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'kijunSen',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> kijunSenEqualTo(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> kijunSenGreaterThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> kijunSenLessThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> kijunSenBetween(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelEqualTo(Levels value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'level',
        value: value,
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelsElementEqualTo(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelsElementGreaterThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelsElementLessThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelsElementBetween(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelsLengthEqualTo(int length) {
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelsIsEmpty() {
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelsIsNotEmpty() {
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelsLengthLessThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelsLengthGreaterThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelsLengthBetween(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelsColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'levelsColor',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelsColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'levelsColor',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelsColorEqualTo(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelsColorGreaterThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelsColorLessThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelsColorBetween(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelsColorStartsWith(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelsColorEndsWith(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
          QAfterFilterCondition>
      levelsColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'levelsColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
          QAfterFilterCondition>
      levelsColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'levelsColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelsColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'levelsColor',
        value: '',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> levelsColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'levelsColor',
        value: '',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> longEMAIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'longEMA',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> longEMAIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'longEMA',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> longEMAEqualTo(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> longEMAGreaterThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> longEMALessThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> longEMABetween(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> macdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'macd',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> macdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'macd',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> maximumIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maximum',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> maximumIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maximum',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> periodEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'period',
        value: value,
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> secondColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'secondColor',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> secondColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'secondColor',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> secondColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secondColor',
        value: '',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> secondColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'secondColor',
        value: '',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> senkouSpanAIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'senkouSpanA',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> senkouSpanAIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'senkouSpanA',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> senkouSpanAEqualTo(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> senkouSpanAGreaterThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> senkouSpanALessThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> senkouSpanABetween(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> senkouSpanBIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'senkouSpanB',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> senkouSpanBIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'senkouSpanB',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> senkouSpanBEqualTo(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> senkouSpanBGreaterThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> senkouSpanBLessThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> senkouSpanBBetween(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> shiftEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shift',
        value: value,
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> shortEMAIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shortEMA',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> shortEMAIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shortEMA',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> shortEMAEqualTo(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> shortEMAGreaterThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> shortEMALessThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> shortEMABetween(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> stepsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'steps',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> stepsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'steps',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> stochasticIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stochastic',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> stochasticIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stochastic',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> styleEqualTo(LineStyle value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'style',
        value: value,
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> tenkanSenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tenkanSen',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> tenkanSenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tenkanSen',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> tenkanSenEqualTo(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> tenkanSenGreaterThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> tenkanSenLessThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> tenkanSenBetween(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> timeframeEqualTo(Timeframes value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeframe',
        value: value,
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> typeEqualTo(IndicatorType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> upIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'up',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> upIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'up',
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> windowIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'windowId',
        value: value,
      ));
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> windowIdGreaterThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> windowIdLessThan(
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

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> windowIdBetween(
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

extension CandleIndicatorEntityQueryObject on QueryBuilder<
    CandleIndicatorEntity, CandleIndicatorEntity, QFilterCondition> {
  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> ichimoku(FilterQuery<Ichimoku> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'ichimoku');
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> macd(FilterQuery<MACD> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'macd');
    });
  }

  QueryBuilder<CandleIndicatorEntity, CandleIndicatorEntity,
      QAfterFilterCondition> stochastic(FilterQuery<Stochastic> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'stochastic');
    });
  }
}
