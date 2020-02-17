import 'dart:io';

enum ResponseCodeAndroid {
  BILLING_RESPONSE_RESULT_OK,
  BILLING_RESPONSE_RESULT_USER_CANCELED,
  BILLING_RESPONSE_RESULT_SERVICE_UNAVAILABLE,
  BILLING_RESPONSE_RESULT_BILLING_UNAVAILABLE,
  BILLING_RESPONSE_RESULT_ITEM_UNAVAILABLE,
  BILLING_RESPONSE_RESULT_DEVELOPER_ERROR,
  BILLING_RESPONSE_RESULT_ERROR,
  BILLING_RESPONSE_RESULT_ITEM_ALREADY_OWNED,
  BILLING_RESPONSE_RESULT_ITEM_NOT_OWNED,
  UNKNOWN,
}

/// An item available for purchase from either the `Google Play Store` or `iOS AppStore`
class IAPItem {
  final String productId;
  final String price;
  final String currency;
  final String localizedPrice;
  final String title;
  final String description;
  final String introductoryPrice;

  final SubscriptionInfo subscriptionInfo;

  /// ios only
  final String subscriptionPeriodNumberIOS;
  final String subscriptionPeriodUnitIOS;
  final String introductoryPricePaymentModeIOS;
  final String introductoryPriceNumberOfPeriodsIOS;
  final String introductoryPriceSubscriptionPeriodIOS;

  /// android only
  final String subscriptionPeriodAndroid;
  final String introductoryPriceCyclesAndroid;
  final String introductoryPricePeriodAndroid;
  final String freeTrialPeriodAndroid;
  final String signatureAndroid;

  final String iconUrl;
  final String originalJson;
  final String originalPrice;

  /// Create [IAPItem] from a Map that was previously JSON formatted
  IAPItem.fromJSON(Map<String, dynamic> json)
      : productId = json['productId'] as String,
        price = json['price'] as String,
        currency = json['currency'] as String,
        localizedPrice = json['localizedPrice'] as String,
        title = json['title'] as String,
        description = json['description'] as String,
        introductoryPrice = json['introductoryPrice'] as String,
        introductoryPricePaymentModeIOS = json['introductoryPricePaymentModeIOS'] as String,
        introductoryPriceNumberOfPeriodsIOS = json['introductoryPriceNumberOfPeriodsIOS'] as String,
        introductoryPriceSubscriptionPeriodIOS = json['introductoryPriceSubscriptionPeriodIOS'] as String,
        subscriptionPeriodNumberIOS = json['subscriptionPeriodNumberIOS'] as String,
        subscriptionPeriodUnitIOS = json['subscriptionPeriodUnitIOS'] as String,
        subscriptionPeriodAndroid = json['subscriptionPeriodAndroid'] as String,
        introductoryPriceCyclesAndroid = json['introductoryPriceCyclesAndroid'] as String,
        introductoryPricePeriodAndroid = json['introductoryPricePeriodAndroid'] as String,
        freeTrialPeriodAndroid = json['freeTrialPeriodAndroid'] as String,
        signatureAndroid = json['signatureAndroid'] as String,
        iconUrl = json['iconUrl'] as String,
        originalJson = json['originalJson'] as String,
        originalPrice = json['originalJson'] as String,
        subscriptionInfo = SubscriptionInfo.fromJSON(json);

  /// Return the contents of this class as a string
  @override
  String toString() {
    return 'productId: $productId, '
        'price: $price, '
        'currency: $currency, '
        'localizedPrice: $localizedPrice, '
        'title: $title, '
        'description: $description, '
        'introductoryPrice: $introductoryPrice, '
        'introductoryPricePaymentModeIOS: $introductoryPrice, '
        'subscriptionPeriodNumberIOS: $subscriptionPeriodNumberIOS, '
        'subscriptionPeriodUnitIOS: $subscriptionPeriodUnitIOS, '
        'introductoryPricePaymentModeIOS: $introductoryPricePaymentModeIOS, '
        'introductoryPriceNumberOfPeriodsIOS: $introductoryPriceNumberOfPeriodsIOS, '
        'introductoryPriceSubscriptionPeriodIOS: $introductoryPriceSubscriptionPeriodIOS, '
        'subscriptionPeriodAndroid: $subscriptionPeriodAndroid, '
        'introductoryPriceCyclesAndroid: $introductoryPriceCyclesAndroid, '
        'introductoryPricePeriodAndroid: $introductoryPricePeriodAndroid, '
        'freeTrialPeriodAndroid: $freeTrialPeriodAndroid, '
        'iconUrl: $iconUrl, '
        'originalJson: $originalJson, '
        'originalPrice: $originalPrice, ';
  }
}

/// An item which was purchased from either the `Google Play Store` or `iOS AppStore`
class PurchasedItem {
  final String productId;
  final String transactionId;
  final DateTime transactionDate;
  final String transactionReceipt;
  final String purchaseToken;
  final String orderId;

  // Android only
  final String dataAndroid;
  final String signatureAndroid;
  final bool autoRenewingAndroid;
  final bool isAcknowledgedAndroid;
  final int purchaseStateAndroid;
  final String developerPayloadAndroid;
  final String originalJsonAndroid;

  // iOS only
  final DateTime originalTransactionDateIOS;
  final String originalTransactionIdentifierIOS;

  /// Create [PurchasedItem] from a Map that was previously JSON formatted
  PurchasedItem.fromJSON(Map<String, dynamic> json)
      : productId = json['productId'] as String,
        transactionId = json['transactionId'] as String,
        transactionDate = _extractDate(json['transactionDate']),
        transactionReceipt = json['transactionReceipt'] as String,
        purchaseToken = json['purchaseToken'] as String,
        orderId = json['orderId'] as String,
        dataAndroid = json['dataAndroid'] as String,
        signatureAndroid = json['signatureAndroid'] as String,
        isAcknowledgedAndroid = json['isAcknowledgedAndroid'] as bool,
        autoRenewingAndroid = json['autoRenewingAndroid'] as bool,
        purchaseStateAndroid = json['purchaseStateAndroid'] as int,
        developerPayloadAndroid = json['developerPayloadAndroid'] as String,
        originalJsonAndroid = json['originalJsonAndroid'] as String,
        originalTransactionDateIOS = _extractDate(json['originalTransactionDateIOS']),
        originalTransactionIdentifierIOS = json['originalTransactionIdentifierIOS'] as String;

  /// This returns transaction dates in ISO 8601 format.
  @override
  String toString() {
    return 'productId: $productId, '
        'transactionId: $transactionId, '
        'transactionDate: ${transactionDate?.toIso8601String()}, '
        'transactionReceipt: $transactionReceipt, '
        'purchaseToken: $purchaseToken, '
        'orderId: $orderId, '

        /// android specific
        'dataAndroid: $dataAndroid, '
        'signatureAndroid: $signatureAndroid, '
        'isAcknowledgedAndroid: $isAcknowledgedAndroid, '
        'autoRenewingAndroid: $autoRenewingAndroid, '
        'purchaseStateAndroid: $purchaseStateAndroid, '
        'developerPayloadAndroid: $developerPayloadAndroid, '
        'originalJsonAndroid: $originalJsonAndroid, '

        /// ios specific
        'originalTransactionDateIOS: ${originalTransactionDateIOS?.toIso8601String()}, '
        'originalTransactionIdentifierIOS: $originalTransactionIdentifierIOS';
  }

  /// Coerce miliseconds since epoch in double, int, or String into DateTime format
  static DateTime _extractDate(dynamic timestamp) {
    if (timestamp == null) return null;

    int _toInt() => double.parse(timestamp.toString()).toInt();
    return DateTime.fromMillisecondsSinceEpoch(_toInt());
  }
}

class PurchaseResult {
  final int responseCode;
  final String debugMessage;
  final String code;
  final String message;

  PurchaseResult({this.responseCode, this.debugMessage, this.code, this.message});

  PurchaseResult.fromJSON(Map<String, dynamic> json)
      : responseCode = json['responseCode'] as int,
        debugMessage = json['debugMessage'] as String,
        code = json['code'] as String,
        message = json['message'] as String;

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode ?? 0,
        "debugMessage": debugMessage ?? '',
        "code": code ?? '',
        "message": message ?? '',
      };

  @override
  String toString() {
    return 'responseCode: $responseCode, '
        'debugMessage: $debugMessage, '
        'code: $code, '
        'message: $message';
  }
}

class ConnectionResult {
  final bool connected;

  ConnectionResult({
    this.connected,
  });

  ConnectionResult.fromJSON(Map<String, dynamic> json) : connected = json['connected'] as bool;

  Map<String, dynamic> toJson() => {
        "connected": connected ?? false,
      };

  @override
  String toString() {
    return 'connected: $connected';
  }
}

enum BillingPeriodType { DAILY, WEEKLY, MONTHLY, YEARLY }
enum BillingPaymentMode { FREE_TRIAL, PAY_AS_YOU_GO, PAY_UP_FRONT }

class BillingPeriod {
  final BillingPeriodType type;
  final int amount;

  const BillingPeriod(this.type, this.amount);

  const BillingPeriod.yearly(this.amount) : type = BillingPeriodType.YEARLY;

  const BillingPeriod.monthly(this.amount) : type = BillingPeriodType.MONTHLY;

  const BillingPeriod.daily(this.amount) : type = BillingPeriodType.DAILY;

  const BillingPeriod.weekly(this.amount) : type = BillingPeriodType.WEEKLY;
}

class SubscriptionInfo {
  final String subscriptionGroupIdentifier;
  final BillingPaymentMode paymentMode;
  final BillingPeriod billingPeriod;
  final BillingPeriod introPeriod;

  SubscriptionInfo(this.subscriptionGroupIdentifier, this.billingPeriod, {this.paymentMode, this.introPeriod});

  factory SubscriptionInfo.fromJSON(Map<String, dynamic> json) {
    if (Platform.isIOS) {
      final introductoryPriceNumberOfPeriodsIOS = json['introductoryPriceNumberOfPeriodsIOS'] as String,
          introductoryPriceSubscriptionPeriodIOS = json['introductoryPriceSubscriptionPeriodIOS'] as String,
          subscriptionPeriodNumberIOS = json['subscriptionPeriodNumberIOS'] as String,
          subscriptionGroupIdentifier = json["subscriptionGroupIdentifier"] as String,
          subscriptionPeriodUnitIOS = json['subscriptionPeriodUnitIOS'] as String,
          introductoryPricePaymentModeIOS = json['introductoryPricePaymentModeIOS'] as String;

      if (subscriptionPeriodUnitIOS != null) {
        final period = convertIosPeriod(subscriptionPeriodUnitIOS);
        BillingPeriod intro;
        final introPeriod = convertIosPeriod(introductoryPriceSubscriptionPeriodIOS);
        final introPeriodAmount = int.tryParse(introductoryPriceNumberOfPeriodsIOS) ?? 1;
        if (introPeriod != null) {
          intro = BillingPeriod(introPeriod, introPeriodAmount);
        }
        final periodAmount = int.tryParse(subscriptionPeriodNumberIOS) ?? 1;
        return SubscriptionInfo(
          subscriptionGroupIdentifier,
          BillingPeriod(period, periodAmount),
          paymentMode: convertPaymentMode(introductoryPricePaymentModeIOS),
          introPeriod: intro,
        );
      }
    }
    return null;
  }
}

BillingPeriodType convertIosPeriod(String iosPeriod) {
  switch (iosPeriod?.toLowerCase()) {
    case 'day':
      return BillingPeriodType.DAILY;
    case 'month':
      return BillingPeriodType.MONTHLY;
    case 'week':
      return BillingPeriodType.WEEKLY;
    case 'year':
      return BillingPeriodType.YEARLY;
    default:
      return null;
  }
}

BillingPaymentMode convertPaymentMode(String mode) {
  switch (mode?.toLowerCase()) {
    case 'FREETRIAL':
      return BillingPaymentMode.FREE_TRIAL;
    case 'PAYASYOUGO':
      return BillingPaymentMode.PAY_AS_YOU_GO;
    case 'PAYUPFRONT':
      return BillingPaymentMode.PAY_UP_FRONT;
    default:
      return null;
  }
}
