// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get passwordIsShort => 'كلمة المرور أقصر من 8 أحرف';

  @override
  String get notSamePassword => 'كلمة المرور ليست مثل تأكيد كلمة المرور';

  @override
  String get pleaseEnterData => 'الرجاء إدخال البيانات';

  @override
  String pleaseEnterValid(Object x) {
    return 'الرجاء إدخال $x صحيح';
  }

  @override
  String get emailIsNotValid => 'البريد الإلكتروني غير صحيح';

  @override
  String get pleaseEnterValidPhone => 'الرجاء إدخال رقم هاتف صحيح';

  @override
  String get more => 'المزيد';

  @override
  String get volume => 'الحجم';

  @override
  String get trading => 'التداول';

  @override
  String get corporateName => 'اسم الشركة';

  @override
  String get ib => 'IB';

  @override
  String get light => 'فاتح';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get symbol => 'الرمز';

  @override
  String get searchBySymbolName => 'البحث باسم الرمز';

  @override
  String fieldInvalid(Object field) {
    return '$field غير صحيح';
  }

  @override
  String get chooseSymbol => 'اختر رمزاً';

  @override
  String get clear => 'مسح';

  @override
  String get change => 'تغيير';

  @override
  String get area => 'مساحة';

  @override
  String get line => 'خط';

  @override
  String get candles => 'شموع';

  @override
  String get graphStyle => 'نمط الرسم البياني';

  @override
  String get timeframe => 'الإطار الزمني';

  @override
  String get dark => 'داكن';

  @override
  String sendOrderAtPrice(Object price) {
    return 'إرسال أمر @ $price';
  }

  @override
  String sellAtPrice(Object price) {
    return 'بيع @ $price';
  }

  @override
  String buyAtPrice(Object price) {
    return 'شراء @ $price';
  }

  @override
  String get defaultSystem => 'النظام الافتراضي';

  @override
  String get answer => 'إجابة';

  @override
  String get settings => 'الإعدادات';

  @override
  String get quotes => 'الأسعار';

  @override
  String get chart => 'الرسم البياني';

  @override
  String get trade => 'تداول';

  @override
  String get history => 'السجل';

  @override
  String get whatIsYourPreferredFrequencyTradingStyle =>
      'ما هو أسلوب التداول المفضل لديك من حيث التكرار؟';

  @override
  String get howManyYearsHaveInTrading => 'كم سنة لديك في التداول؟';

  @override
  String get didYouUnderstandRisks => 'هل فهمت المخاطر؟';

  @override
  String get whatAreFinancialInstrumentsTypes => 'ما هي أنواع الأدوات المالية؟';

  @override
  String get haveYouEverTradedForexBefore =>
      'هل سبق لك التداول في الفوركس من قبل؟';

  @override
  String get exploreNow => 'استكشف الآن';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get services => 'الخدمات';

  @override
  String get password => 'كلمة المرور';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get generatePassword => 'توليد كلمة مرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get country => 'الدولة';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get alreadyHaveAnAccount => 'هل لديك حساب بالفعل؟';

  @override
  String get iHaveReadAndAgreeWithAll => 'لقد قرأت ووافقت على جميع';

  @override
  String get termsAndPolicies => 'الشروط والسياسات';

  @override
  String get keepMeInformedByNewsletterAndOffers =>
      'أبقني على اطلاع بالنشرة الإخبارية والعروض';

  @override
  String get mr => 'السيد';

  @override
  String get backTo => 'العودة إلى';

  @override
  String get reset => 'إعادة تعيين';

  @override
  String get mrs => 'السيدة';

  @override
  String get next => 'التالي';

  @override
  String get back => 'رجوع';

  @override
  String get zipCode => 'الرمز البريدي';

  @override
  String get writeNumber => 'اكتب الرقم';

  @override
  String get dateOfBirth => 'تاريخ الميلاد';

  @override
  String get enterYourDate => 'أدخل تاريخك';

  @override
  String get enterYour => 'أدخل';

  @override
  String get documentsSuccessfullyUploaded => 'تم تحميل المستندات بنجاح!';

  @override
  String get documentsSuccessfullyUploadedMessage =>
      'تهانينا! تم تحميل مستنداتك وهي قيد التحقق. توقع بريداً إلكترونياً بمجرد التحقق. استكشف منصتنا ومواردنا لرحلة تداول ناجحة!';

  @override
  String get exploreThePlatform => 'استكشف المنصة';

  @override
  String get city => 'المدينة';

  @override
  String get select => 'اختر';

  @override
  String get state => 'الولاية';

  @override
  String get resend => 'إعادة إرسال';

  @override
  String get verify => 'تحقق';

  @override
  String get didNotGetACode => 'لم تحصل على رمز؟';

  @override
  String weHaveSentACodeTo(Object x) {
    return 'لقد أرسلنا رمزاً إلى \n$x';
  }

  @override
  String get enterVerificationCode => 'أدخل رمز التحقق';

  @override
  String get uploadAdditionDocument => 'تحميل مستند إضافي';

  @override
  String get proofOfResidence => 'إثبات الإقامة';

  @override
  String get identificationVerification => 'التحقق من الهوية';

  @override
  String get uploadIDDocument => 'تحميل وثيقة الهوية';

  @override
  String get whatIsYourExpectedAverageTransactionSize =>
      'ما هو متوسط حجم المعاملة المتوقع لديك؟';

  @override
  String get whatIsTheSourceOfYourFundsForTrading =>
      'ما هو مصدر أموالك للتداول؟';

  @override
  String get whatIsYourEstimatedNetWorth => 'ما هي قيمتك الصافية المقدرة؟';

  @override
  String get whatIsYourAnnualIncome => 'ما هو دخلك السنوي؟';

  @override
  String get streetAddress => 'عنوان الشارع';

  @override
  String get letIsVerifyYourAccount => 'دعنا نتحقق من حسابك!';

  @override
  String get chooseAnswer => 'اختر إجابة';

  @override
  String get typeAnswer => 'اكتب إجابة';

  @override
  String get personalInfo1 => 'المعلومات الشخصية (1/4)';

  @override
  String get personalInfo2 => 'المعلومات الشخصية (2/4)';

  @override
  String get personalInfo3 => 'المعلومات الشخصية (3/4)';

  @override
  String get personalInfo4 => 'المعلومات الشخصية (4/4)';

  @override
  String get completeTheseFourStepsToVerifyYourAccount =>
      'أكمل هذه الخطوات الأربع للتحقق من حسابك';

  @override
  String get letsVerifyYourAccount => 'دعنا نتحقق من حسابك!';

  @override
  String get individual => 'فردي';

  @override
  String get corporate => 'شركة';

  @override
  String get pleaseEnterYourInfoToSignUp => 'الرجاء إدخال معلوماتك للتسجيل';

  @override
  String get letsGetStartedWithSkyOption => 'لنبدأ مع سكاي أوبشن';

  @override
  String get signUp => 'تسجيل';

  @override
  String get doneHaveAnAccount => 'ليس لديك حساب؟';

  @override
  String get forgetPassword => 'نسيت كلمة المرور';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get pleaseEnterYourEmailAndPasswordToLogin =>
      'الرجاء إدخال\nبريدك الإلكتروني وكلمة المرور لتسجيل الدخول';

  @override
  String get getBackIntoYourSkyOptionAccount => 'عد إلى حسابك\nفي سكاي أوبشن';

  @override
  String get sendResetLink => 'إرسال رابط إعادة التعيين';

  @override
  String get resetPasswordMessage =>
      'لإعادة تعيين كلمة المرور الخاصة بك، أدخل عنوان بريدك الإلكتروني وسنرسل لك بريداً إلكترونياً مع رمز التحقق.';

  @override
  String get verifyAccount => 'تحقق من الحساب';

  @override
  String get myAssets => 'أصولي';

  @override
  String get congratulationsYourAccountHasBeenCreatedSuccessfully =>
      'تهانينا! تم إنشاء حسابك بنجاح.';

  @override
  String get transactions => 'المعاملات';

  @override
  String get accountSuccessfullyCreated => 'تم إنشاء الحساب بنجاح';

  @override
  String get physicalStore => 'متجر فعلي';

  @override
  String get oneClickTrade => 'تداول بنقرة واحدة';

  @override
  String get oneClickTradeSubtitle => 'فتح صفقة بدون تأكيد';

  @override
  String get oneClickClosing => 'إغلاق بنقرة واحدة';

  @override
  String get oneClickClosingSubtitle => 'إغلاق وبيع الصفقة بدون تأكيد';

  @override
  String get orderSounds => 'أصوات الأوامر';

  @override
  String get orderSoundsSubtitle => 'تشغيل الأصوات للأوامر';

  @override
  String get chartTheme => 'سمة الرسم البياني';

  @override
  String get ask => 'الطلب';

  @override
  String get bid => 'العرض';

  @override
  String get done => 'تم';

  @override
  String get chartGridColor => 'لون شبكة الرسم البياني';

  @override
  String get pickColor => 'اختر اللون';

  @override
  String get showAskLine => 'إظهار خط الطلب';

  @override
  String get showAskLineOnChart => 'إظهار/إخفاء خط الطلب على الرسم البياني';

  @override
  String get areaColor => 'لون المنطقة';

  @override
  String get chartLine => 'خط الرسم البياني';

  @override
  String get chartLineSize => 'حجم خط الرسم البياني';

  @override
  String get tradeNotification => 'إشعار التداول';

  @override
  String get tradeNotificationSound => 'صوت التداول';

  @override
  String get tradeNotificationVibration => 'اهتزاز التداول';

  @override
  String get tradeNotificationSubtitle => 'التحكم في إشعار التداول';

  @override
  String get tradeNotificationSoundSubtitle => 'التحكم في صوت إشعار التداول';

  @override
  String get tradeNotificationVibrationSubtitle =>
      'التحكم في اهتزاز إشعار التداول';

  @override
  String get noSymbolsWasFound => 'لم يتم العثور على رموز';

  @override
  String get marketCurrentlyClosed => 'السوق مغلق حالياً';

  @override
  String get closePosition => 'إغلاق المركز';

  @override
  String positionClosedNotification(
      Object date, Object profit, Object symbol, Object ticketNumber) {
    return 'المركز: $ticketNumber مغلق لـ $symbol بربح $profit في $date';
  }

  @override
  String positionOpenedNotification(Object date, Object symbol, Object type) {
    return 'تم فتح مركز من نوع $type لـ $symbol في $date';
  }

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get classification => 'التصنيف';

  @override
  String get leverage => 'الرافعة المالية';

  @override
  String get mainPassword => 'كلمة المرور الرئيسية';

  @override
  String get accountNumber => 'رقم الحساب';

  @override
  String get pleaseEnterAccountNumber => 'الرجاء إدخال رقم الحساب';

  @override
  String get openNewAccount => 'فتح حساب جديد؟';

  @override
  String get longPasswordValidation => 'كلمة مرور طويلة من 8 إلى 32 حرفاً';

  @override
  String get upperCaseValidation => 'أحرف كبيرة';

  @override
  String get lowerCaseValidation => 'أحرف صغيرة';

  @override
  String get symbolValidation => 'رمز (\$&@-()/!?)';

  @override
  String get includeNumbersValidation => 'تضمين أرقام';

  @override
  String get weak => 'ضعيف';

  @override
  String get fair => 'مقبول';

  @override
  String get good => 'جيد';

  @override
  String get strong => 'قوي';

  @override
  String get selectYourAnswer => 'اختر إجابتك';

  @override
  String usdAmount(Object amount) {
    return '$amount دولار أمريكي';
  }

  @override
  String get noSymbolsFound => 'لم يتم العثور على رموز';

  @override
  String get currency => 'العملة';

  @override
  String get swap => 'المبادلة';

  @override
  String get investorPassword => 'كلمة مرور المستثمر';

  @override
  String get pleaseEnterInvestorPassword =>
      'الرجاء إدخال كلمة مرور المستثمر الخاصة بك';

  @override
  String get alreadyHaveAccount => 'هل لديك حساب بالفعل؟';

  @override
  String get logIn => 'تسجيل الدخول';

  @override
  String get enterYourPassword => 'أدخل كلمة المرور الخاصة بك';

  @override
  String get positions => 'المراكز';

  @override
  String get pending => 'قيد الانتظار';

  @override
  String get loginWelcomeMessage =>
      'أدر جميع حسابات التداول الخاصة بك في مكان واحد. سجل الدخول للوصول إلى منصة التداول متعددة الحسابات.';

  @override
  String get passwordValidationMessage =>
      'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل\nحرف واحد\nرمز خاص واحد';

  @override
  String get pleaseEnterPassword => 'الرجاء إدخال كلمة المرور الخاصة بك';

  @override
  String high(Object value) {
    return 'الأعلى: $value';
  }

  @override
  String low(Object value) {
    return 'الأدنى: $value';
  }

  @override
  String percentage(Object value) {
    return '$value٪';
  }

  @override
  String get stopLossShort => 'وقف الخسارة';

  @override
  String get takeProfitShort => 'جني الأرباح';

  @override
  String at(Object price) {
    return 'عند $price';
  }

  @override
  String get buyPosition => 'شراء';

  @override
  String get sellPosition => 'بيع';

  @override
  String get noValue => '--';

  @override
  String get enterAmount => '0.00';

  @override
  String get searchByName => 'البحث باسم الخادم';

  @override
  String live(Object number) {
    return 'مباشر $number';
  }

  @override
  String demo(Object number) {
    return 'تجريبي $number';
  }

  @override
  String get skyOptionLive => 'سكاي أوبشن - مباشر';

  @override
  String get skyOptionDemo => 'سكاي أوبشن - تجريبي';

  @override
  String skyOption(Object number) {
    return 'سكاي أوبشن - $number';
  }

  @override
  String get commission => 'العمولة';

  @override
  String get close => 'إغلاق';

  @override
  String get modify => 'تعديل';

  @override
  String leverageRatio(Object value) {
    return '1 : $value';
  }

  @override
  String get advanced => 'متقدم';

  @override
  String get simple => 'بسيط';

  @override
  String get table => 'جدول';

  @override
  String get appName => 'سكاي أوبشن';

  @override
  String get enterValue => '0.00';

  @override
  String get sell => 'بيع';

  @override
  String get buy => 'شراء';

  @override
  String get all => 'الكل';

  @override
  String get edit => 'تعديل';

  @override
  String get check => 'تحقق';

  @override
  String get reconnect => 'إعادة الاتصال';

  @override
  String get chartSettings => 'إعدادات الرسم البياني';

  @override
  String get rotate => 'تدوير';

  @override
  String get switchAccount => 'تبديل الحساب';

  @override
  String get addAccount => 'إضافة حساب';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get changeTheme => 'تغيير السمة';

  @override
  String get language => 'اللغة';

  @override
  String get tradingSettings => 'إعدادات التداول';

  @override
  String get logs => 'السجلات';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String version(Object version) {
    return 'الإصدار $version';
  }

  @override
  String get spectatePassword => 'كلمة مرور المراقبة';

  @override
  String get masterPassword => 'كلمة المرور الرئيسية';

  @override
  String get enterNewPassword => 'أدخل كلمة المرور الجديدة';

  @override
  String get confirmNewPassword => 'تأكيد كلمة المرور الجديدة';

  @override
  String get submit => 'إرسال';

  @override
  String get enterPassword => 'أدخل كلمة المرور الخاصة بك';

  @override
  String get price => 'السعر';

  @override
  String get invalid => 'غير صحيح';

  @override
  String volumeAt(Object price, Object volume) {
    return '$volume عند $price';
  }

  @override
  String get specified => 'محدد';

  @override
  String get wait => 'انتظر';

  @override
  String get modifyPosition => 'تعديل المركز';

  @override
  String get balance => 'الرصيد';

  @override
  String get credit => 'الائتمان';

  @override
  String get equity => 'حقوق الملكية';

  @override
  String get marketExecution => 'تنفيذ السوق';

  @override
  String get buyLimit => 'حد الشراء';

  @override
  String get sellLimit => 'حد البيع';

  @override
  String get buyStop => 'إيقاف الشراء';

  @override
  String get sellStop => 'إيقاف البيع';

  @override
  String get tradeType => 'نوع التداول';

  @override
  String get margin => 'الهامش';

  @override
  String get freeMargin => 'الهامش الحر';

  @override
  String get marginLevel => 'مستوى الهامش (%)';

  @override
  String get searchBySymbol => 'البحث بالرمز...';

  @override
  String get tick => 'نقطة';

  @override
  String get sendOrder => 'إرسال الأمر';

  @override
  String get functions => 'الوظائف';

  @override
  String get objects => 'الكائنات';

  @override
  String get grid => 'الشبكة';

  @override
  String get symbolSearch => 'البحث عن الرمز';

  @override
  String get symbolOptions => 'خيارات الرمز';

  @override
  String get search => 'بحث';

  @override
  String get findSymbol => 'البحث عن رمز...';

  @override
  String get folder => 'مجلد';

  @override
  String get delete => 'حذف';

  @override
  String get add => 'إضافة';

  @override
  String get favorites => 'المفضلة';

  @override
  String get dragToReorder => 'اسحب لإعادة الترتيب';

  @override
  String get sort => 'فرز';

  @override
  String get filterByDate => 'تصفية حسب التاريخ';

  @override
  String get selectDate => 'اختر التاريخ';

  @override
  String get apply => 'تطبيق';

  @override
  String get startDate => 'تاريخ البدء';

  @override
  String get endDate => 'تاريخ الانتهاء';

  @override
  String get today => 'اليوم';

  @override
  String get lastWeek => 'الأسبوع الماضي';

  @override
  String get lastMonth => 'الشهر الماضي';

  @override
  String get last3Months => 'آخر 3 أشهر';

  @override
  String get last6Months => 'آخر 6 أشهر';

  @override
  String get lastYear => 'السنة الماضية';

  @override
  String get custom => 'مخصص';

  @override
  String get actions => 'الإجراءات';

  @override
  String get openDate => 'تاريخ الفتح: ';

  @override
  String get closeDate => 'تاريخ الإغلاق: ';

  @override
  String get chartStyle => 'نمط الرسم البياني';

  @override
  String get candlestick => 'الشموع اليابانية';

  @override
  String get bar => 'شريط';

  @override
  String get minute => 'دقيقة';

  @override
  String minutes(Object count) {
    return '$count دقائق';
  }

  @override
  String get hour => 'ساعة';

  @override
  String hours(Object count) {
    return '$count ساعات';
  }

  @override
  String get day => 'يوم';

  @override
  String days(Object count) {
    return '$count أيام';
  }

  @override
  String get week => 'أسبوع';

  @override
  String get month => 'شهر';

  @override
  String get searchSymbol => 'البحث عن رمز';

  @override
  String get noResults => 'لا نتائج';

  @override
  String get loading => 'جارٍ التحميل';

  @override
  String get skip => 'تخطي';

  @override
  String get welcomeToSky5 => 'مرحباً بك في\\nسكاي 5';

  @override
  String get globalMarketsAtYourFingertips =>
      'الأسواق العالمية\\nفي متناول يديك';

  @override
  String get advancedTradingTools => 'أدوات تداول\\nمتقدمة';

  @override
  String get realTimeMarketInsights => 'رؤى السوق\\nفي الوقت الفعلي';

  @override
  String get searchBySymbolDots => 'البحث بالرمز...';

  @override
  String get editSymbols => 'تعديل الرموز';

  @override
  String get sortBy => 'فرز حسب';

  @override
  String get details => 'التفاصيل';

  @override
  String get sector => 'القطاع';

  @override
  String get industry => 'الصناعة';

  @override
  String get digits => 'الأرقام العشرية';

  @override
  String get contractSize => 'حجم العقد';

  @override
  String get spread => 'السبريد';

  @override
  String get stopsLevel => 'مستوى الإيقاف';

  @override
  String get marginCurrency => 'عملة الهامش';

  @override
  String get profitCurrency => 'عملة الربح';

  @override
  String get calculation => 'الحساب';

  @override
  String get chartMode => 'وضع الرسم البياني';

  @override
  String get execution => 'التنفيذ';

  @override
  String get gtcMode => 'وضع GTC';

  @override
  String get filling => 'التعبئة';

  @override
  String get expiration => 'انتهاء الصلاحية';

  @override
  String get minimalVolume => 'الحجم الأدنى';

  @override
  String get maximalVolume => 'الحجم الأقصى';

  @override
  String get volumeStep => 'خطوة الحجم';

  @override
  String get allSymbols => 'جميع الرموز';

  @override
  String get profit => 'الربح';

  @override
  String get deposit => 'الإيداع';

  @override
  String get withdrawal => 'السحب';

  @override
  String get totalBalance => 'إجمالي الرصيد';

  @override
  String get filled => 'تم التنفيذ';

  @override
  String get canceled => 'ملغى';

  @override
  String get total => 'الإجمالي';

  @override
  String get bidPrice => 'العرض:';

  @override
  String get modifyTradeLevels => 'تعديل مستويات التداول';

  @override
  String get modifyOrder => 'تعديل الأمر';

  @override
  String get deleteAllOrders => 'حذف جميع الأوامر';

  @override
  String get deleteAllBuyLimitOrders => 'حذف جميع أوامر حد الشراء';

  @override
  String get deleteAllSellLimitOrders => 'حذف جميع أوامر حد البيع';

  @override
  String get deleteAllBuyStopOrders => 'حذف جميع أوامر إيقاف الشراء';

  @override
  String get deleteAllSellStopOrders => 'حذف جميع أوامر إيقاف البيع';

  @override
  String get switchToThisAccount => 'التبديل إلى هذا الحساب';

  @override
  String get deleteAccount => 'حذف الحساب';

  @override
  String get selectSymbols => 'اختيار الرموز';

  @override
  String get forex => 'فوركس';

  @override
  String get metals => 'المعادن';

  @override
  String get indexes => 'المؤشرات';

  @override
  String get welcomeDescription =>
      'بوابتك للتداول في الفوركس والأسهم عبر الأسواق العالمية. ابدأ رحلة استثمارك بسهولة وثقة.';

  @override
  String get globalMarketsDescription =>
      'الوصول إلى البيانات في الوقت الفعلي، وتحليل الاتجاهات، والتداول في أسواق الفوركس والأسهم في جميع أنحاء العالم، كل ذلك من منصة واحدة.';

  @override
  String get advancedToolsDescription =>
      'استخدم مجموعتنا الشاملة من أدوات التداول والمؤشرات لاتخاذ قرارات مدروسة ووضع استراتيجيات لتداولاتك.';

  @override
  String get realTimeInsightsDescription =>
      'ابق على اطلاع بأحدث بيانات السوق والتحليلات. الوصول إلى الرسوم البيانية في الوقت الفعلي، ورؤى الخبراء، وأخبار السوق كلها في مكان واحد. اتخذ قرارات تداول ذكية بناءً على معلومات دقيقة.';

  @override
  String closeWithProfit(Object value) {
    return 'إغلاق بربح $value';
  }

  @override
  String get fullAccess => 'وصول كامل';

  @override
  String get byBidPrice => 'حسب سعر العرض';

  @override
  String get goodTillCanceled => 'صالح حتى الإلغاء';

  @override
  String get fillOrKill => 'التنفيذ أو الإلغاء، الفوري أو الإلغاء';

  @override
  String get invalidValue => 'غير صحيح';

  @override
  String get currencyPair => 'زوج العملات';

  @override
  String get undefined => 'غير محدد';

  @override
  String get floatingSpread => 'سبريد متغير';

  @override
  String get volumeLotSize => 'حجم اللوت';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get accountBalance => 'رصيد الحساب';

  @override
  String get askPrice => 'الطلب:';

  @override
  String get tradeAction => 'تداول';

  @override
  String get chartAction => 'رسم بياني';

  @override
  String get openPrice => 'سعر الفتح';

  @override
  String get closePrice => 'سعر الإغلاق';

  @override
  String get orderId => 'المعرف';

  @override
  String get openTime => 'وقت الفتح';

  @override
  String get closeAllPositions => 'إغلاق جميع المراكز';

  @override
  String get closeProfitablePositions => 'إغلاق المراكز الرابحة';

  @override
  String get closeLosingPositions => 'إغلاق المراكز الخاسرة';

  @override
  String get stopLossTitle => 'وقف الخسارة';

  @override
  String get takeProfitTitle => 'جني الأرباح';

  @override
  String get closeBy => 'إغلاق بواسطة';

  @override
  String get leverageTitle => 'الرافعة المالية';

  @override
  String pointValue(Object value) {
    return 'قيمة النقطة ($value)';
  }

  @override
  String get tradeMargin => 'هامش التداول';

  @override
  String get availableMargin => 'الهامش المتاح';

  @override
  String get expirationTitle => 'انتهاء الصلاحية';

  @override
  String get priceTitle => 'السعر';

  @override
  String get marginTitle => 'الهامش';

  @override
  String get commissionTitle => 'العمولة';

  @override
  String get english => 'English';

  @override
  String get save => 'حفظ';

  @override
  String get shortStopLoss => 'وقف';

  @override
  String get shortTakeProfit => 'ربح';

  @override
  String pointValueWithSize(Object size) {
    return 'قيمة النقطة ($size)';
  }

  @override
  String get closeByTitle => 'إغلاق بواسطة';

  @override
  String get statistics => 'الإحصائيات';

  @override
  String get loginWithGoogle => 'تسجيل الدخول باستخدام جوجل';

  @override
  String get loginWithApple => 'تسجيل الدخول باستخدام آبل';

  @override
  String get orLoginWith => 'أو سجل الدخول باستخدام';

  @override
  String get selectServer => 'اختر الخادم';

  @override
  String skyOptionServer(Object number) {
    return 'سكاي أوبشن - $number';
  }

  @override
  String get mainPosition => 'المركز الرئيسي';

  @override
  String get closeByMainPosition => 'إغلاق بواسطة المركز الرئيسي';

  @override
  String get searchByNameServer => 'البحث باسم الخادم';

  @override
  String get arabic => 'العربية';

  @override
  String get volumeLotTitle => 'حجم اللوت';

  @override
  String get time => 'الوقت';

  @override
  String get chooseTime => 'اختر الوقت';

  @override
  String get name => 'الاسم';

  @override
  String get activeTrades => 'الصفقات النشطة';

  @override
  String get market => 'السوق';

  @override
  String get limit => 'الحد';

  @override
  String get stop => 'التوقف';

  @override
  String get positionNumber => 'رقم الصفقة';

  @override
  String get historyDate => 'التاريخ';

  @override
  String get historyPositionNumber => 'رقم الصفقة';

  @override
  String get historyProfit => 'الربح';
}
