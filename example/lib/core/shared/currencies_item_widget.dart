import 'package:flutter_svg/flutter_svg.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';

class CurrenciesItemWidget extends StatelessWidget {
  final String? item;
  final double size;
  final SymbolEntity? value;
  final double? endPadding;
  const CurrenciesItemWidget({
    super.key,
    this.item,
    this.value,
    this.size = 21.0,
    this.endPadding,
  });

  @override
  Widget build(BuildContext context) {
    if (item == null && value == null) return const SizedBox();
    final symbol = value ?? context.read<QuotesCubit>().getSymbol(item!);
    if (symbol == null) return const SizedBox();
    final image = getImage(symbol);
    return Stack(
      children: [image.baseLogo, image.quoteLogo].asMap().entries.map((item) {
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Coolors.white,
          ),
          padding: const MPadding.set(all: 1.5),
          margin: MPadding.set(start: item.key * size * 0.7),
          child: ClipRRect(
            borderRadius: MBorderRadius.set(all: 100.0),
            child: item.value.isNotEmpty
                ? SvgPicture.network(
                    item.value,
                    fit: BoxFit.cover,
                    height: size,
                    width: size,
                  )
                : SizedBox(height: size, width: size),
          ),
        );
      }).toList(),
    ).addPadding(end: endPadding ?? 8.0);
  }

  SymbolImage getImage(SymbolEntity symbol) {
    final image = SymbolImage();
    try {
      const country = "https://s3-symbol-logo.tradingview.com/country/";
      if (symbol.sector.toLowerCase() == 'crypto') {
        const url = "https://s3-symbol-logo.tradingview.com/crypto/XTVC";
        image.baseLogo = "$url${symbol.symbol.substring(0, 3)}--big.svg";
      } else if (symbol.sector.toLowerCase().contains('forex')) {
        const url = "https://s3-symbol-logo.tradingview.com/country/";
        image.quoteLogo =
            "$url${symbol.symbol.substring(3).substring(0, 2)}--big.svg";
        image.baseLogo = "$url${symbol.symbol.substring(0, 2)}--big.svg";
      } else if (symbol.sector.toLowerCase() == 'metals') {
        image.baseLogo =
            "https://s3-symbol-logo.tradingview.com/metal/gold--big.svg";
      }
      if (symbol.symbol.substring(3).contains('USD')) {
        image.quoteLogo =
            "$country${symbol.symbol.substring(3).substring(0, 2)}--big.svg";
      }
    } catch (e) {}
    return image;
  }
}

class SymbolImage {
  String baseLogo = '';
  String quoteLogo = '';
}

class TableCurrenciesItemWidget extends StatelessWidget {
  final List<String> images;
  final double size;

  const TableCurrenciesItemWidget({
    super.key,
    required this.images,
    this.size = 17.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: images.asMap().entries.map((item) {
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Coolors.white,
          ),
          // padding: const MPadding.set(all: 1.5),
          margin: MPadding.set(start: item.key * size * 0.7),
          child: MNetworkImage(
            url: item.value,
            fit: BoxFit.cover,
            height: size,
            width: size,
            borderRadius: 100.0,
          ),
        );
      }).toList(),
    ).addPadding(end: 5.0);
  }
}
