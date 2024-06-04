import 'package:core/models/card_data/card_data.dart';
import 'package:shared/services/app_localization.dart';
import 'package:shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared/assetsGen/assets.gen.dart';

class CardUI extends StatelessWidget {
  final Items item;
  const CardUI({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: defaultInfoListPadding,
        child: Container(
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(defaultInfoListBorderRadius),
                boxShadow: defaultInfoShadows),
            child: Card(
              surfaceTintColor: Theme.of(context).cardTheme.surfaceTintColor,
              color: Theme.of(context).cardTheme.color,
              shape: Theme.of(context).cardTheme.shape,
              child: Padding(
                  padding: defaultCardContentPadding,
                  child: Column(
                    crossAxisAlignment: defaultCardContentAlignment,
                    children: <Widget>[
                      Row(children: [
                        item.logoType == "svg"
                            ? SvgPicture.asset(
                                item.logoUrl,
                                package: 'shared',
                                // fit: BoxFit.fitHeight,
                                height: defaultCardIconSize,
                                width: defaultCardIconSize,
                                allowDrawingOutsideViewBox: true,
                              )
                            : Image.asset(item.logoUrl,
                                package: 'shared',
                                height: defaultCardIconSize,
                                width: defaultCardIconSize),
                        Padding(
                            padding: defaultCardContentIconTextGroupPadding,
                            child: Text(
                              item.bankName,
                              style: Theme.of(context).textTheme.bodyMedium,
                            )),
                      ]),
                      const Padding(
                        padding: defaultCardContentDescriptionPadding,
                        child: Divider(
                            height: defaultCardContentDividerHeight,
                            color: defaultCardContentDividerColor,
                            thickness: defaultCardContentDividerThickness),
                      ),
                      Padding(
                          padding: defaultCardContentGroupPadding,
                          child: Column(
                            crossAxisAlignment: defaultCardContentAlignment,
                            children: [
                              Text(
                                  AppLocalizationService.of(context)
                                          ?.translate('type') ??
                                      'Type',
                                  style: Theme.of(context).textTheme.bodySmall),
                              Text(item.type,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ],
                          )),
                      Padding(
                          padding: defaultCardContentGroupPadding,
                          child: Column(
                            crossAxisAlignment: defaultCardContentAlignment,
                            children: [
                              Text(
                                  AppLocalizationService.of(context)
                                          ?.translate('purpose') ??
                                      'Purpose',
                                  style: Theme.of(context).textTheme.bodySmall),
                              Text(
                                item.purpose,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          )),
                      Padding(
                          padding: defaultCardContentGroupPadding,
                          child: Column(
                            crossAxisAlignment: defaultCardContentAlignment,
                            children: [
                              Text(
                                  AppLocalizationService.of(context)
                                          ?.translate('date') ??
                                      'Date',
                                  style: Theme.of(context).textTheme.bodySmall),
                              Text(
                                item.date,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          )),
                      Padding(
                        padding: defaultCardContentGroupPadding,
                        child: Column(
                          crossAxisAlignment: defaultCardContentAlignment,
                          children: [
                            Text(
                                AppLocalizationService.of(context)
                                        ?.translate('effect') ??
                                    'Effect',
                                style: Theme.of(context).textTheme.bodySmall),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                    package: 'shared',
                                    item.effect
                                        ? AppAssets.icons.effect.path
                                        : AppAssets.icons.notEffect.path,
                                    // item.effect ? AppAssets.images.
                                    // "assets/icons/${item.effect ? "effect.svg" : "notEffect.svg"}",
                                    height: defaultIconSize,
                                    width: defaultIconSize),
                                Padding(
                                    padding:
                                        defaultCardContentIconTextGroupPadding,
                                    child: Text(
                                      item.effect
                                          ? AppLocalizationService.of(context)
                                                  ?.translate('impacting') ??
                                              'Impacting'
                                          : AppLocalizationService.of(context)
                                                  ?.translate('notImpacting') ??
                                              'Not impacting',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    )),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            )));
  }
}
