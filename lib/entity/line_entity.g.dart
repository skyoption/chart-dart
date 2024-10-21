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
    r'drawAsBackground': PropertySchema(
      id: 1,
      name: r'drawAsBackground',
      type: IsarType.bool,
    ),
    r'dy': PropertySchema(
      id: 2,
      name: r'dy',
      type: IsarType.double,
    ),
    r'editable': PropertySchema(
      id: 3,
      name: r'editable',
      type: IsarType.bool,
    ),
    r'height': PropertySchema(
      id: 4,
      name: r'height',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'newDy': PropertySchema(
      id: 6,
      name: r'newDy',
      type: IsarType.double,
    ),
    r'style': PropertySchema(
      id: 7,
      name: r'style',
      type: IsarType.byte,
      enumMap: _LineEntitystyleEnumValueMap,
    ),
    r'symbol': PropertySchema(
      id: 8,
      name: r'symbol',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 9,
      name: r'type',
      type: IsarType.byte,
      enumMap: _LineEntitytypeEnumValueMap,
    ),
    r'value': PropertySchema(
      id: 10,
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
  writer.writeBool(offsets[1], object.drawAsBackground);
  writer.writeDouble(offsets[2], object.dy);
  writer.writeBool(offsets[3], object.editable);
  writer.writeDouble(offsets[4], object.height);
  writer.writeString(offsets[5], object.name);
  writer.writeDouble(offsets[6], object.newDy);
  writer.writeByte(offsets[7], object.style.index);
  writer.writeString(offsets[8], object.symbol);
  writer.writeByte(offsets[9], object.type.index);
  writer.writeDouble(offsets[10], object.value);
}

LineEntity _lineEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LineEntity(
    color: reader.readStringOrNull(offsets[0]),
    drawAsBackground: reader.readBoolOrNull(offsets[1]) ?? false,
    dy: reader.readDoubleOrNull(offsets[2]) ?? 0,
    editable: reader.readBoolOrNull(offsets[3]) ?? false,
    height: reader.readDoubleOrNull(offsets[4]) ?? 1.2,
    name: reader.readStringOrNull(offsets[5]) ?? '',
    newDy: reader.readDoubleOrNull(offsets[6]) ?? 0,
    style: _LineEntitystyleValueEnumMap[reader.readByteOrNull(offsets[7])] ??
        LineStyle.normal,
    symbol: reader.readStringOrNull(offsets[8]) ?? '',
    type: _LineEntitytypeValueEnumMap[reader.readByteOrNull(offsets[9])] ??
        LineType.horizontal,
    value: reader.readDoubleOrNull(offsets[10]) ?? 50559.50,
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
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 2:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 4:
      return (reader.readDoubleOrNull(offset) ?? 1.2) as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 6:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 7:
      return (_LineEntitystyleValueEnumMap[reader.readByteOrNull(offset)] ??
          LineStyle.normal) as P;
    case 8:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 9:
      return (_LineEntitytypeValueEnumMap[reader.readByteOrNull(offset)] ??
          LineType.horizontal) as P;
    case 10:
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
      drawAsBackgroundEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'drawAsBackground',
        value: value,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> dyEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> dyGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> dyLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> dyBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> editableEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editable',
        value: value,
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

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> newDyEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newDy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> newDyGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'newDy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> newDyLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'newDy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterFilterCondition> newDyBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'newDy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
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

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByDy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByDyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByEditable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editable', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByEditableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editable', Sort.desc);
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

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByNewDy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newDy', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> sortByNewDyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newDy', Sort.desc);
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

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByDy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByDyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy', Sort.desc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByEditable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editable', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByEditableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editable', Sort.desc);
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

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByNewDy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newDy', Sort.asc);
    });
  }

  QueryBuilder<LineEntity, LineEntity, QAfterSortBy> thenByNewDyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newDy', Sort.desc);
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

  QueryBuilder<LineEntity, LineEntity, QDistinct> distinctByDrawAsBackground() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'drawAsBackground');
    });
  }

  QueryBuilder<LineEntity, LineEntity, QDistinct> distinctByDy() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dy');
    });
  }

  QueryBuilder<LineEntity, LineEntity, QDistinct> distinctByEditable() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'editable');
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

  QueryBuilder<LineEntity, LineEntity, QDistinct> distinctByNewDy() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'newDy');
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

  QueryBuilder<LineEntity, bool, QQueryOperations> drawAsBackgroundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'drawAsBackground');
    });
  }

  QueryBuilder<LineEntity, double, QQueryOperations> dyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dy');
    });
  }

  QueryBuilder<LineEntity, bool, QQueryOperations> editableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'editable');
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

  QueryBuilder<LineEntity, double, QQueryOperations> newDyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'newDy');
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
