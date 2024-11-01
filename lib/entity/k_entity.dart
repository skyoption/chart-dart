import 'candle_entity.dart';
import 'kdj_entity.dart';
import 'rw_entity.dart';
import 'volume_entity.dart';
import 'cci_entity.dart';


class KEntity
    with
        CandleEntity,
        VolumeEntity,
        KDJEntity,
        WREntity,
        CCIEntity{}
