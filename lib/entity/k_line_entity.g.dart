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
    r'MA10Volume': PropertySchema(
      id: 0,
      name: r'MA10Volume',
      type: IsarType.double,
    ),
    r'MA5Volume': PropertySchema(
      id: 1,
      name: r'MA5Volume',
      type: IsarType.double,
    ),
    r'amount': PropertySchema(
      id: 2,
      name: r'amount',
      type: IsarType.double,
    ),
    r'atrValues': PropertySchema(
      id: 3,
      name: r'atrValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    ),
    r'bollValues': PropertySchema(
      id: 4,
      name: r'bollValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    ),
    r'cciValues': PropertySchema(
      id: 5,
      name: r'cciValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    ),
    r'change': PropertySchema(
      id: 6,
      name: r'change',
      type: IsarType.double,
    ),
    r'close': PropertySchema(
      id: 7,
      name: r'close',
      type: IsarType.double,
    ),
    r'deMarkerValues': PropertySchema(
      id: 8,
      name: r'deMarkerValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    ),
    r'envelopsEmaValues': PropertySchema(
      id: 9,
      name: r'envelopsEmaValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    ),
    r'envelopsLwmaValues': PropertySchema(
      id: 10,
      name: r'envelopsLwmaValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    ),
    r'envelopsSmaValues': PropertySchema(
      id: 11,
      name: r'envelopsSmaValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    ),
    r'envelopsSmmaValues': PropertySchema(
      id: 12,
      name: r'envelopsSmmaValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    ),
    r'frame': PropertySchema(
      id: 13,
      name: r'frame',
      type: IsarType.byte,
      enumMap: _KLineEntityframeEnumValueMap,
    ),
    r'high': PropertySchema(
      id: 14,
      name: r'high',
      type: IsarType.double,
    ),
    r'ichimokuValues': PropertySchema(
      id: 15,
      name: r'ichimokuValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    ),
    r'low': PropertySchema(
      id: 16,
      name: r'low',
      type: IsarType.double,
    ),
    r'maEmaValues': PropertySchema(
      id: 17,
      name: r'maEmaValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    ),
    r'maLwmaValues': PropertySchema(
      id: 18,
      name: r'maLwmaValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    ),
    r'maSmaValues': PropertySchema(
      id: 19,
      name: r'maSmaValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    ),
    r'maSmmaValues': PropertySchema(
      id: 20,
      name: r'maSmmaValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    ),
    r'macdSignalValues': PropertySchema(
      id: 21,
      name: r'macdSignalValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    ),
    r'macdValues': PropertySchema(
      id: 22,
      name: r'macdValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    ),
    r'mfiValues': PropertySchema(
      id: 23,
      name: r'mfiValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    ),
    r'momentumValues': PropertySchema(
      id: 24,
      name: r'momentumValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    ),
    r'open': PropertySchema(
      id: 25,
      name: r'open',
      type: IsarType.double,
    ),
    r'parabolicValues': PropertySchema(
      id: 26,
      name: r'parabolicValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    ),
    r'ratio': PropertySchema(
      id: 27,
      name: r'ratio',
      type: IsarType.double,
    ),
    r'rsiValues': PropertySchema(
      id: 28,
      name: r'rsiValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    ),
    r'stochasticValues': PropertySchema(
      id: 29,
      name: r'stochasticValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    ),
    r'symbol': PropertySchema(
      id: 30,
      name: r'symbol',
      type: IsarType.string,
    ),
    r'time': PropertySchema(
      id: 31,
      name: r'time',
      type: IsarType.long,
    ),
    r'vol': PropertySchema(
      id: 32,
      name: r'vol',
      type: IsarType.double,
    ),
    r'wprValues': PropertySchema(
      id: 33,
      name: r'wprValues',
      type: IsarType.objectList,
      target: r'CandleIndicatorEntity',
    )
  },
  estimateSize: _kLineEntityEstimateSize,
  serialize: _kLineEntitySerialize,
  deserialize: _kLineEntityDeserialize,
  deserializeProp: _kLineEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'CandleIndicatorEntity': CandleIndicatorEntitySchema,
    r'Ichimoku': IchimokuSchema,
    r'MACD': MACDSchema,
    r'Stochastic': StochasticSchema
  },
  getId: _kLineEntityGetId,
  getLinks: _kLineEntityGetLinks,
  attach: _kLineEntityAttach,
  version: '3.1.0+1',
);

int _kLineEntityEstimateSize(
  KLineEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.atrValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.bollValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.cciValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.deMarkerValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.envelopsEmaValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.envelopsLwmaValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.envelopsSmaValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.envelopsSmmaValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.ichimokuValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.maEmaValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.maLwmaValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.maSmaValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.maSmmaValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.macdSignalValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.macdValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.mfiValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.momentumValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.parabolicValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.rsiValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.stochasticValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.symbol;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.wprValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CandleIndicatorEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CandleIndicatorEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  return bytesCount;
}

void _kLineEntitySerialize(
  KLineEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.MA10Volume);
  writer.writeDouble(offsets[1], object.MA5Volume);
  writer.writeDouble(offsets[2], object.amount);
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[3],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.atrValues,
  );
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[4],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.bollValues,
  );
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[5],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.cciValues,
  );
  writer.writeDouble(offsets[6], object.change);
  writer.writeDouble(offsets[7], object.close);
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[8],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.deMarkerValues,
  );
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[9],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.envelopsEmaValues,
  );
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[10],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.envelopsLwmaValues,
  );
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[11],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.envelopsSmaValues,
  );
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[12],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.envelopsSmmaValues,
  );
  writer.writeByte(offsets[13], object.frame.index);
  writer.writeDouble(offsets[14], object.high);
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[15],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.ichimokuValues,
  );
  writer.writeDouble(offsets[16], object.low);
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[17],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.maEmaValues,
  );
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[18],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.maLwmaValues,
  );
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[19],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.maSmaValues,
  );
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[20],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.maSmmaValues,
  );
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[21],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.macdSignalValues,
  );
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[22],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.macdValues,
  );
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[23],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.mfiValues,
  );
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[24],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.momentumValues,
  );
  writer.writeDouble(offsets[25], object.open);
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[26],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.parabolicValues,
  );
  writer.writeDouble(offsets[27], object.ratio);
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[28],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.rsiValues,
  );
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[29],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.stochasticValues,
  );
  writer.writeString(offsets[30], object.symbol);
  writer.writeLong(offsets[31], object.time);
  writer.writeDouble(offsets[32], object.vol);
  writer.writeObjectList<CandleIndicatorEntity>(
    offsets[33],
    allOffsets,
    CandleIndicatorEntitySchema.serialize,
    object.wprValues,
  );
}

KLineEntity _kLineEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = KLineEntity(
    amount: reader.readDoubleOrNull(offsets[2]),
    change: reader.readDoubleOrNull(offsets[6]),
    close: reader.readDouble(offsets[7]),
    frame: _KLineEntityframeValueEnumMap[reader.readByteOrNull(offsets[13])] ??
        CandleTimeFormat.H4,
    high: reader.readDouble(offsets[14]),
    low: reader.readDouble(offsets[16]),
    open: reader.readDouble(offsets[25]),
    ratio: reader.readDoubleOrNull(offsets[27]),
    symbol: reader.readStringOrNull(offsets[30]),
    time: reader.readLongOrNull(offsets[31]),
    vol: reader.readDouble(offsets[32]),
  );
  object.MA10Volume = reader.readDoubleOrNull(offsets[0]);
  object.MA5Volume = reader.readDoubleOrNull(offsets[1]);
  object.atrValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[3],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
  object.bollValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[4],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
  object.cciValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[5],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
  object.deMarkerValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[8],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
  object.envelopsEmaValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[9],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
  object.envelopsLwmaValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[10],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
  object.envelopsSmaValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[11],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
  object.envelopsSmmaValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[12],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
  object.ichimokuValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[15],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
  object.id = id;
  object.maEmaValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[17],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
  object.maLwmaValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[18],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
  object.maSmaValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[19],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
  object.maSmmaValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[20],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
  object.macdSignalValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[21],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
  object.macdValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[22],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
  object.mfiValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[23],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
  object.momentumValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[24],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
  object.parabolicValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[26],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
  object.rsiValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[28],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
  object.stochasticValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[29],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
  object.wprValues = reader.readObjectList<CandleIndicatorEntity>(
    offsets[33],
    CandleIndicatorEntitySchema.deserialize,
    allOffsets,
    CandleIndicatorEntity(),
  );
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
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    case 4:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    case 5:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    case 9:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    case 10:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    case 11:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    case 12:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    case 13:
      return (_KLineEntityframeValueEnumMap[reader.readByteOrNull(offset)] ??
          CandleTimeFormat.H4) as P;
    case 14:
      return (reader.readDouble(offset)) as P;
    case 15:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    case 16:
      return (reader.readDouble(offset)) as P;
    case 17:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    case 18:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    case 19:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    case 20:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    case 21:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    case 22:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    case 23:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    case 24:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    case 25:
      return (reader.readDouble(offset)) as P;
    case 26:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    case 27:
      return (reader.readDoubleOrNull(offset)) as P;
    case 28:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    case 29:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    case 30:
      return (reader.readStringOrNull(offset)) as P;
    case 31:
      return (reader.readLongOrNull(offset)) as P;
    case 32:
      return (reader.readDouble(offset)) as P;
    case 33:
      return (reader.readObjectList<CandleIndicatorEntity>(
        offset,
        CandleIndicatorEntitySchema.deserialize,
        allOffsets,
        CandleIndicatorEntity(),
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _KLineEntityframeEnumValueMap = {
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
const _KLineEntityframeValueEnumMap = {
  0: CandleTimeFormat.M1,
  1: CandleTimeFormat.M5,
  2: CandleTimeFormat.M15,
  3: CandleTimeFormat.M30,
  4: CandleTimeFormat.H1,
  5: CandleTimeFormat.H4,
  6: CandleTimeFormat.D1,
  7: CandleTimeFormat.W1,
  8: CandleTimeFormat.MN,
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
  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mA10VolumeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'MA10Volume',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mA10VolumeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'MA10Volume',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mA10VolumeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'MA10Volume',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mA10VolumeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'MA10Volume',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mA10VolumeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'MA10Volume',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mA10VolumeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'MA10Volume',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mA5VolumeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'MA5Volume',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mA5VolumeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'MA5Volume',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mA5VolumeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'MA5Volume',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mA5VolumeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'MA5Volume',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mA5VolumeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'MA5Volume',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mA5VolumeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'MA5Volume',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> amountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'amount',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      amountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'amount',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> amountEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      amountGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> amountLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> amountBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      atrValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'atrValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      atrValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'atrValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      atrValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'atrValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      atrValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'atrValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      atrValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'atrValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      atrValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'atrValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      atrValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'atrValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      atrValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'atrValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      bollValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bollValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      bollValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bollValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      bollValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bollValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      bollValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bollValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      bollValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bollValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      bollValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bollValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      bollValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bollValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      bollValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bollValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      cciValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cciValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      cciValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cciValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      cciValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cciValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      cciValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cciValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      cciValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cciValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      cciValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cciValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      cciValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cciValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      cciValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cciValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> changeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'change',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      changeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'change',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> changeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'change',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      changeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'change',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> changeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'change',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> changeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'change',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

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

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      deMarkerValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deMarkerValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      deMarkerValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deMarkerValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      deMarkerValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'deMarkerValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      deMarkerValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'deMarkerValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      deMarkerValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'deMarkerValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      deMarkerValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'deMarkerValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      deMarkerValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'deMarkerValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      deMarkerValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'deMarkerValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsEmaValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'envelopsEmaValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsEmaValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'envelopsEmaValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsEmaValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsEmaValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsEmaValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsEmaValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsEmaValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsEmaValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsEmaValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsEmaValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsEmaValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsEmaValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsEmaValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsEmaValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsLwmaValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'envelopsLwmaValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsLwmaValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'envelopsLwmaValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsLwmaValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsLwmaValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsLwmaValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsLwmaValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsLwmaValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsLwmaValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsLwmaValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsLwmaValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsLwmaValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsLwmaValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsLwmaValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsLwmaValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsSmaValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'envelopsSmaValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsSmaValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'envelopsSmaValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsSmaValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsSmaValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsSmaValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsSmaValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsSmaValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsSmaValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsSmaValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsSmaValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsSmaValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsSmaValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsSmaValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsSmaValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsSmmaValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'envelopsSmmaValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsSmmaValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'envelopsSmmaValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsSmmaValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsSmmaValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsSmmaValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsSmmaValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsSmmaValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsSmmaValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsSmmaValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsSmmaValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsSmmaValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsSmmaValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsSmmaValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'envelopsSmmaValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
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

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      ichimokuValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ichimokuValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      ichimokuValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ichimokuValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      ichimokuValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ichimokuValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      ichimokuValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ichimokuValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      ichimokuValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ichimokuValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      ichimokuValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ichimokuValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      ichimokuValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ichimokuValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      ichimokuValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ichimokuValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
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

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maEmaValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maEmaValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maEmaValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maEmaValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maEmaValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maEmaValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maEmaValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maEmaValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maEmaValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maEmaValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maEmaValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maEmaValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maEmaValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maEmaValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maEmaValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maEmaValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maLwmaValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maLwmaValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maLwmaValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maLwmaValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maLwmaValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maLwmaValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maLwmaValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maLwmaValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maLwmaValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maLwmaValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maLwmaValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maLwmaValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maLwmaValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maLwmaValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maLwmaValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maLwmaValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maSmaValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maSmaValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maSmaValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maSmaValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maSmaValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maSmaValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maSmaValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maSmaValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maSmaValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maSmaValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maSmaValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maSmaValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maSmaValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maSmaValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maSmaValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maSmaValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maSmmaValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maSmmaValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maSmmaValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maSmmaValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maSmmaValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maSmmaValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maSmmaValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maSmmaValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maSmmaValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maSmmaValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maSmmaValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maSmmaValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maSmmaValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maSmmaValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maSmmaValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'maSmmaValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      macdSignalValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'macdSignalValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      macdSignalValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'macdSignalValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      macdSignalValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'macdSignalValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      macdSignalValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'macdSignalValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      macdSignalValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'macdSignalValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      macdSignalValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'macdSignalValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      macdSignalValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'macdSignalValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      macdSignalValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'macdSignalValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      macdValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'macdValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      macdValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'macdValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      macdValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'macdValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      macdValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'macdValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      macdValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'macdValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      macdValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'macdValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      macdValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'macdValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      macdValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'macdValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mfiValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mfiValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mfiValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mfiValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mfiValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mfiValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mfiValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mfiValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mfiValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mfiValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mfiValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mfiValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mfiValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mfiValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mfiValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mfiValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      momentumValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'momentumValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      momentumValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'momentumValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      momentumValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'momentumValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      momentumValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'momentumValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      momentumValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'momentumValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      momentumValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'momentumValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      momentumValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'momentumValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      momentumValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'momentumValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
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

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      parabolicValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parabolicValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      parabolicValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parabolicValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      parabolicValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'parabolicValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      parabolicValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'parabolicValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      parabolicValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'parabolicValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      parabolicValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'parabolicValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      parabolicValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'parabolicValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      parabolicValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'parabolicValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> ratioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ratio',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      ratioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ratio',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> ratioEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ratio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      ratioGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ratio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> ratioLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ratio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> ratioBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ratio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      rsiValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rsiValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      rsiValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rsiValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      rsiValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rsiValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      rsiValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rsiValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      rsiValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rsiValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      rsiValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rsiValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      rsiValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rsiValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      rsiValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rsiValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      stochasticValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stochasticValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      stochasticValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stochasticValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      stochasticValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stochasticValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      stochasticValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stochasticValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      stochasticValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stochasticValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      stochasticValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stochasticValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      stochasticValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stochasticValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      stochasticValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stochasticValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> symbolIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'symbol',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      symbolIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'symbol',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> symbolEqualTo(
    String? value, {
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
    String? value, {
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
    String? value, {
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
    String? lower,
    String? upper, {
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

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> timeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'time',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      timeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'time',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> timeEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'time',
        value: value,
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition> timeGreaterThan(
    int? value, {
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
    int? value, {
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
    int? lower,
    int? upper, {
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

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      wprValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'wprValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      wprValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'wprValues',
      ));
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      wprValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'wprValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      wprValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'wprValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      wprValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'wprValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      wprValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'wprValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      wprValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'wprValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      wprValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'wprValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension KLineEntityQueryObject
    on QueryBuilder<KLineEntity, KLineEntity, QFilterCondition> {
  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      atrValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'atrValues');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      bollValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'bollValues');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      cciValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'cciValues');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      deMarkerValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'deMarkerValues');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsEmaValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'envelopsEmaValues');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsLwmaValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'envelopsLwmaValues');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsSmaValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'envelopsSmaValues');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      envelopsSmmaValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'envelopsSmmaValues');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      ichimokuValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'ichimokuValues');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maEmaValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'maEmaValues');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maLwmaValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'maLwmaValues');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maSmaValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'maSmaValues');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      maSmmaValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'maSmmaValues');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      macdSignalValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'macdSignalValues');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      macdValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'macdValues');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      mfiValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'mfiValues');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      momentumValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'momentumValues');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      parabolicValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'parabolicValues');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      rsiValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'rsiValues');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      stochasticValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'stochasticValues');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterFilterCondition>
      wprValuesElement(FilterQuery<CandleIndicatorEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'wprValues');
    });
  }
}

extension KLineEntityQueryLinks
    on QueryBuilder<KLineEntity, KLineEntity, QFilterCondition> {}

extension KLineEntityQuerySortBy
    on QueryBuilder<KLineEntity, KLineEntity, QSortBy> {
  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByMA10Volume() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'MA10Volume', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByMA10VolumeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'MA10Volume', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByMA5Volume() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'MA5Volume', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByMA5VolumeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'MA5Volume', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByChange() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'change', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByChangeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'change', Sort.desc);
    });
  }

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

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByRatio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratio', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> sortByRatioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratio', Sort.desc);
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
  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByMA10Volume() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'MA10Volume', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByMA10VolumeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'MA10Volume', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByMA5Volume() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'MA5Volume', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByMA5VolumeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'MA5Volume', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByChange() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'change', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByChangeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'change', Sort.desc);
    });
  }

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

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByRatio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratio', Sort.asc);
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QAfterSortBy> thenByRatioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratio', Sort.desc);
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
  QueryBuilder<KLineEntity, KLineEntity, QDistinct> distinctByMA10Volume() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'MA10Volume');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QDistinct> distinctByMA5Volume() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'MA5Volume');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QDistinct> distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<KLineEntity, KLineEntity, QDistinct> distinctByChange() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'change');
    });
  }

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

  QueryBuilder<KLineEntity, KLineEntity, QDistinct> distinctByRatio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ratio');
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

  QueryBuilder<KLineEntity, double?, QQueryOperations> MA10VolumeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'MA10Volume');
    });
  }

  QueryBuilder<KLineEntity, double?, QQueryOperations> MA5VolumeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'MA5Volume');
    });
  }

  QueryBuilder<KLineEntity, double?, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      atrValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'atrValues');
    });
  }

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      bollValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bollValues');
    });
  }

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      cciValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cciValues');
    });
  }

  QueryBuilder<KLineEntity, double?, QQueryOperations> changeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'change');
    });
  }

  QueryBuilder<KLineEntity, double, QQueryOperations> closeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'close');
    });
  }

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      deMarkerValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deMarkerValues');
    });
  }

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      envelopsEmaValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'envelopsEmaValues');
    });
  }

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      envelopsLwmaValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'envelopsLwmaValues');
    });
  }

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      envelopsSmaValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'envelopsSmaValues');
    });
  }

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      envelopsSmmaValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'envelopsSmmaValues');
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

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      ichimokuValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ichimokuValues');
    });
  }

  QueryBuilder<KLineEntity, double, QQueryOperations> lowProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'low');
    });
  }

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      maEmaValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maEmaValues');
    });
  }

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      maLwmaValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maLwmaValues');
    });
  }

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      maSmaValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maSmaValues');
    });
  }

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      maSmmaValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maSmmaValues');
    });
  }

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      macdSignalValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'macdSignalValues');
    });
  }

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      macdValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'macdValues');
    });
  }

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      mfiValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mfiValues');
    });
  }

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      momentumValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'momentumValues');
    });
  }

  QueryBuilder<KLineEntity, double, QQueryOperations> openProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'open');
    });
  }

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      parabolicValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parabolicValues');
    });
  }

  QueryBuilder<KLineEntity, double?, QQueryOperations> ratioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ratio');
    });
  }

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      rsiValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rsiValues');
    });
  }

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      stochasticValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stochasticValues');
    });
  }

  QueryBuilder<KLineEntity, String?, QQueryOperations> symbolProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'symbol');
    });
  }

  QueryBuilder<KLineEntity, int?, QQueryOperations> timeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'time');
    });
  }

  QueryBuilder<KLineEntity, double, QQueryOperations> volProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vol');
    });
  }

  QueryBuilder<KLineEntity, List<CandleIndicatorEntity>?, QQueryOperations>
      wprValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wprValues');
    });
  }
}
