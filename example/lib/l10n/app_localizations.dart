import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @passwordIsShort.
  ///
  /// In en, this message translates to:
  /// **'Password is shorter than 8 characters'**
  String get passwordIsShort;

  /// No description provided for @notSamePassword.
  ///
  /// In en, this message translates to:
  /// **'Password is not the same as confirm password'**
  String get notSamePassword;

  /// No description provided for @pleaseEnterData.
  ///
  /// In en, this message translates to:
  /// **'Please enter data'**
  String get pleaseEnterData;

  /// No description provided for @pleaseEnterValid.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid ( {x} )'**
  String pleaseEnterValid(Object x);

  /// No description provided for @emailIsNotValid.
  ///
  /// In en, this message translates to:
  /// **'The email is not valid'**
  String get emailIsNotValid;

  /// No description provided for @pleaseEnterValidPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid phone'**
  String get pleaseEnterValidPhone;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @volume.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get volume;

  /// No description provided for @trading.
  ///
  /// In en, this message translates to:
  /// **'Trading'**
  String get trading;

  /// No description provided for @corporateName.
  ///
  /// In en, this message translates to:
  /// **'Corporate Name'**
  String get corporateName;

  /// No description provided for @ib.
  ///
  /// In en, this message translates to:
  /// **'IB'**
  String get ib;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @symbol.
  ///
  /// In en, this message translates to:
  /// **'Symbol'**
  String get symbol;

  /// No description provided for @searchBySymbolName.
  ///
  /// In en, this message translates to:
  /// **'Search by symbol name'**
  String get searchBySymbolName;

  /// No description provided for @fieldInvalid.
  ///
  /// In en, this message translates to:
  /// **'{field} invalid'**
  String fieldInvalid(Object field);

  /// No description provided for @chooseSymbol.
  ///
  /// In en, this message translates to:
  /// **'Choose a symbol'**
  String get chooseSymbol;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get area;

  /// No description provided for @line.
  ///
  /// In en, this message translates to:
  /// **'Line'**
  String get line;

  /// No description provided for @candles.
  ///
  /// In en, this message translates to:
  /// **'Candles'**
  String get candles;

  /// No description provided for @graphStyle.
  ///
  /// In en, this message translates to:
  /// **'Graph style'**
  String get graphStyle;

  /// No description provided for @timeframe.
  ///
  /// In en, this message translates to:
  /// **'Time Frame'**
  String get timeframe;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @sendOrderAtPrice.
  ///
  /// In en, this message translates to:
  /// **'Send Order @ {price}'**
  String sendOrderAtPrice(Object price);

  /// No description provided for @sellAtPrice.
  ///
  /// In en, this message translates to:
  /// **'SELL @ {price}'**
  String sellAtPrice(Object price);

  /// No description provided for @buyAtPrice.
  ///
  /// In en, this message translates to:
  /// **'BUY @ {price}'**
  String buyAtPrice(Object price);

  /// No description provided for @defaultSystem.
  ///
  /// In en, this message translates to:
  /// **'Default System'**
  String get defaultSystem;

  /// No description provided for @answer.
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get answer;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get value;

  /// No description provided for @switch_.
  ///
  /// In en, this message translates to:
  /// **'Switch'**
  String get switch_;

  /// No description provided for @usd.
  ///
  /// In en, this message translates to:
  /// **'USD'**
  String get usd;

  /// No description provided for @quotes.
  ///
  /// In en, this message translates to:
  /// **'Quotes'**
  String get quotes;

  /// No description provided for @chart.
  ///
  /// In en, this message translates to:
  /// **'Chart'**
  String get chart;

  /// No description provided for @trade.
  ///
  /// In en, this message translates to:
  /// **'Trade'**
  String get trade;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'Seconds'**
  String get seconds;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @whatIsYourPreferredFrequencyTradingStyle.
  ///
  /// In en, this message translates to:
  /// **'What is your preferred frequency trading style?'**
  String get whatIsYourPreferredFrequencyTradingStyle;

  /// No description provided for @howManyYearsHaveInTrading.
  ///
  /// In en, this message translates to:
  /// **'How many years have in trading?'**
  String get howManyYearsHaveInTrading;

  /// No description provided for @didYouUnderstandRisks.
  ///
  /// In en, this message translates to:
  /// **'Did you understand risks?'**
  String get didYouUnderstandRisks;

  /// No description provided for @whatAreFinancialInstrumentsTypes.
  ///
  /// In en, this message translates to:
  /// **'What are financial instruments types?'**
  String get whatAreFinancialInstrumentsTypes;

  /// No description provided for @haveYouEverTradedForexBefore.
  ///
  /// In en, this message translates to:
  /// **'Have You Ever Traded Forex Before?'**
  String get haveYouEverTradedForexBefore;

  /// No description provided for @exploreNow.
  ///
  /// In en, this message translates to:
  /// **'Explore Now'**
  String get exploreNow;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @generatePassword.
  ///
  /// In en, this message translates to:
  /// **'Generate Password'**
  String get generatePassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already Have An Account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @iHaveReadAndAgreeWithAll.
  ///
  /// In en, this message translates to:
  /// **'I have read and agree with all'**
  String get iHaveReadAndAgreeWithAll;

  /// No description provided for @termsAndPolicies.
  ///
  /// In en, this message translates to:
  /// **'terms and policies'**
  String get termsAndPolicies;

  /// No description provided for @keepMeInformedByNewsletterAndOffers.
  ///
  /// In en, this message translates to:
  /// **'Keep Me Informed By Newsletter And Offers'**
  String get keepMeInformedByNewsletterAndOffers;

  /// No description provided for @mr.
  ///
  /// In en, this message translates to:
  /// **'MR'**
  String get mr;

  /// No description provided for @backTo.
  ///
  /// In en, this message translates to:
  /// **'Back To'**
  String get backTo;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @mrs.
  ///
  /// In en, this message translates to:
  /// **'Mrs'**
  String get mrs;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @zipCode.
  ///
  /// In en, this message translates to:
  /// **'Zip Code'**
  String get zipCode;

  /// No description provided for @writeNumber.
  ///
  /// In en, this message translates to:
  /// **'Write Number'**
  String get writeNumber;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date Of Birth'**
  String get dateOfBirth;

  /// No description provided for @enterYourDate.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Date'**
  String get enterYourDate;

  /// No description provided for @enterYour.
  ///
  /// In en, this message translates to:
  /// **'Enter Your'**
  String get enterYour;

  /// No description provided for @documentsSuccessfullyUploaded.
  ///
  /// In en, this message translates to:
  /// **'Documents Successfully Uploaded!'**
  String get documentsSuccessfullyUploaded;

  /// No description provided for @documentsSuccessfullyUploadedMessage.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! Your Documents Are Uploaded And Pending Verification. Expect An Email Once Verified. Explore Our Platform And Resources For A Successful Trading Journey!'**
  String get documentsSuccessfullyUploadedMessage;

  /// No description provided for @exploreThePlatform.
  ///
  /// In en, this message translates to:
  /// **'Explore The Platform'**
  String get exploreThePlatform;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @didNotGetACode.
  ///
  /// In en, this message translates to:
  /// **'Did\'t get a code?'**
  String get didNotGetACode;

  /// No description provided for @weHaveSentACodeTo.
  ///
  /// In en, this message translates to:
  /// **'We have sent a code to \n{x}'**
  String weHaveSentACodeTo(Object x);

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Verification Code'**
  String get enterVerificationCode;

  /// No description provided for @uploadAdditionDocument.
  ///
  /// In en, this message translates to:
  /// **'Upload Addition Document'**
  String get uploadAdditionDocument;

  /// No description provided for @proofOfResidence.
  ///
  /// In en, this message translates to:
  /// **'Proof Of Residence'**
  String get proofOfResidence;

  /// No description provided for @identificationVerification.
  ///
  /// In en, this message translates to:
  /// **'Identification Verification'**
  String get identificationVerification;

  /// No description provided for @uploadIDDocument.
  ///
  /// In en, this message translates to:
  /// **'Upload ID Document'**
  String get uploadIDDocument;

  /// No description provided for @whatIsYourExpectedAverageTransactionSize.
  ///
  /// In en, this message translates to:
  /// **'What Is Your Expected Average Transaction Size?'**
  String get whatIsYourExpectedAverageTransactionSize;

  /// No description provided for @whatIsTheSourceOfYourFundsForTrading.
  ///
  /// In en, this message translates to:
  /// **'What Is The Source Of Your Funds For Trading?'**
  String get whatIsTheSourceOfYourFundsForTrading;

  /// No description provided for @whatIsYourEstimatedNetWorth.
  ///
  /// In en, this message translates to:
  /// **'What\'s Your Estimated Net Worth?'**
  String get whatIsYourEstimatedNetWorth;

  /// No description provided for @whatIsYourAnnualIncome.
  ///
  /// In en, this message translates to:
  /// **'What\'s Your Annual Income?'**
  String get whatIsYourAnnualIncome;

  /// No description provided for @streetAddress.
  ///
  /// In en, this message translates to:
  /// **'Street Address'**
  String get streetAddress;

  /// No description provided for @letIsVerifyYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Verify Your Account !'**
  String get letIsVerifyYourAccount;

  /// No description provided for @chooseAnswer.
  ///
  /// In en, this message translates to:
  /// **'Choose Answer'**
  String get chooseAnswer;

  /// No description provided for @typeAnswer.
  ///
  /// In en, this message translates to:
  /// **'Type Answer'**
  String get typeAnswer;

  /// No description provided for @personalInfo1.
  ///
  /// In en, this message translates to:
  /// **'Personal Info (1/4)'**
  String get personalInfo1;

  /// No description provided for @personalInfo2.
  ///
  /// In en, this message translates to:
  /// **'Personal Info (2/4)'**
  String get personalInfo2;

  /// No description provided for @personalInfo3.
  ///
  /// In en, this message translates to:
  /// **'Personal Info (3/4)'**
  String get personalInfo3;

  /// No description provided for @personalInfo4.
  ///
  /// In en, this message translates to:
  /// **'Personal Info (4/4)'**
  String get personalInfo4;

  /// No description provided for @completeTheseFourStepsToVerifyYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Complete These Four Steps to Verify your Account'**
  String get completeTheseFourStepsToVerifyYourAccount;

  /// No description provided for @letsVerifyYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Verify Your Account !'**
  String get letsVerifyYourAccount;

  /// No description provided for @individual.
  ///
  /// In en, this message translates to:
  /// **'Individual'**
  String get individual;

  /// No description provided for @corporate.
  ///
  /// In en, this message translates to:
  /// **'Corporate'**
  String get corporate;

  /// No description provided for @pleaseEnterYourInfoToSignUp.
  ///
  /// In en, this message translates to:
  /// **'Please enter your Info To Sign Up'**
  String get pleaseEnterYourInfoToSignUp;

  /// No description provided for @letsGetStartedWithSkyOption.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Get Started With Sky Option'**
  String get letsGetStartedWithSkyOption;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @doneHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t Have An Account ?'**
  String get doneHaveAnAccount;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPassword;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @pleaseEnterYourEmailAndPasswordToLogin.
  ///
  /// In en, this message translates to:
  /// **'Please enter your\nemail and password To login'**
  String get pleaseEnterYourEmailAndPasswordToLogin;

  /// No description provided for @getBackIntoYourSkyOptionAccount.
  ///
  /// In en, this message translates to:
  /// **'Get Back Into Your\nSky Option Account'**
  String get getBackIntoYourSkyOptionAccount;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @resetPasswordMessage.
  ///
  /// In en, this message translates to:
  /// **'To Reset Your Password, Enter Your Email Address And We\'ll Send You An Email With verification code.'**
  String get resetPasswordMessage;

  /// No description provided for @verifyAccount.
  ///
  /// In en, this message translates to:
  /// **'Verify Account'**
  String get verifyAccount;

  /// No description provided for @myAssets.
  ///
  /// In en, this message translates to:
  /// **'My assets'**
  String get myAssets;

  /// No description provided for @congratulationsYourAccountHasBeenCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! Your Account Has Been Created Successfully.'**
  String get congratulationsYourAccountHasBeenCreatedSuccessfully;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! Your Account Has Been Created Successfully.'**
  String get transactions;

  /// No description provided for @accountSuccessfullyCreated.
  ///
  /// In en, this message translates to:
  /// **'Account Successfully Created'**
  String get accountSuccessfullyCreated;

  /// No description provided for @physicalStore.
  ///
  /// In en, this message translates to:
  /// **'Physical Store'**
  String get physicalStore;

  /// No description provided for @oneClickTrade.
  ///
  /// In en, this message translates to:
  /// **'One click trade'**
  String get oneClickTrade;

  /// No description provided for @oneClickTradeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Open a trade without confirmation'**
  String get oneClickTradeSubtitle;

  /// No description provided for @oneClickClosing.
  ///
  /// In en, this message translates to:
  /// **'One click closing'**
  String get oneClickClosing;

  /// No description provided for @oneClickClosingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Close and sell trade without confirmation'**
  String get oneClickClosingSubtitle;

  /// No description provided for @orderSounds.
  ///
  /// In en, this message translates to:
  /// **'Order Sounds'**
  String get orderSounds;

  /// No description provided for @orderSoundsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Play sounds for orders'**
  String get orderSoundsSubtitle;

  /// No description provided for @chartTheme.
  ///
  /// In en, this message translates to:
  /// **'Chart theme'**
  String get chartTheme;

  /// No description provided for @ask.
  ///
  /// In en, this message translates to:
  /// **'Ask'**
  String get ask;

  /// No description provided for @bid.
  ///
  /// In en, this message translates to:
  /// **'Bid'**
  String get bid;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @chartGridColor.
  ///
  /// In en, this message translates to:
  /// **'Chart Grid Color'**
  String get chartGridColor;

  /// No description provided for @pickColor.
  ///
  /// In en, this message translates to:
  /// **'Pick Color'**
  String get pickColor;

  /// No description provided for @showAskLine.
  ///
  /// In en, this message translates to:
  /// **'Show Ask Line'**
  String get showAskLine;

  /// No description provided for @showAskLineOnChart.
  ///
  /// In en, this message translates to:
  /// **'Show/Hide Ask Line On Chart'**
  String get showAskLineOnChart;

  /// No description provided for @areaColor.
  ///
  /// In en, this message translates to:
  /// **'Area Color'**
  String get areaColor;

  /// No description provided for @chartLine.
  ///
  /// In en, this message translates to:
  /// **'Chart Line'**
  String get chartLine;

  /// No description provided for @chartLineSize.
  ///
  /// In en, this message translates to:
  /// **'Chart Line Size'**
  String get chartLineSize;

  /// No description provided for @tradePositionNotification.
  ///
  /// In en, this message translates to:
  /// **'Position Notification'**
  String get tradePositionNotification;

  /// No description provided for @tradePositionNotificationSound.
  ///
  /// In en, this message translates to:
  /// **'Position Sound'**
  String get tradePositionNotificationSound;

  /// No description provided for @tradePositionNotificationVibration.
  ///
  /// In en, this message translates to:
  /// **'Position Vibration'**
  String get tradePositionNotificationVibration;

  /// No description provided for @tradePositionNotificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Control Position\'s Notification'**
  String get tradePositionNotificationSubtitle;

  /// No description provided for @tradePositionNotificationSoundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Control Position\'s Notification Sound'**
  String get tradePositionNotificationSoundSubtitle;

  /// No description provided for @tradePositionNotificationVibrationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Control Position\'s Notification Vibration'**
  String get tradePositionNotificationVibrationSubtitle;

  /// No description provided for @tradeOrderNotification.
  ///
  /// In en, this message translates to:
  /// **'Trade Order Notification'**
  String get tradeOrderNotification;

  /// No description provided for @tradeOrderNotificationSound.
  ///
  /// In en, this message translates to:
  /// **'Trade Order Sound'**
  String get tradeOrderNotificationSound;

  /// No description provided for @tradeOrderNotificationVibration.
  ///
  /// In en, this message translates to:
  /// **'Trade Order Vibration'**
  String get tradeOrderNotificationVibration;

  /// No description provided for @tradeOrderNotificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Control Trade\'s Order Notification'**
  String get tradeOrderNotificationSubtitle;

  /// No description provided for @tradeOrderNotificationSoundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Control Trade\'s Order Notification Sound'**
  String get tradeOrderNotificationSoundSubtitle;

  /// No description provided for @tradeOrderNotificationVibrationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Control Trade\'s Order Notification Vibration'**
  String get tradeOrderNotificationVibrationSubtitle;

  /// No description provided for @noSymbolsWasFound.
  ///
  /// In en, this message translates to:
  /// **'No Symbols Was found'**
  String get noSymbolsWasFound;

  /// No description provided for @marketCurrentlyClosed.
  ///
  /// In en, this message translates to:
  /// **'Market Currently Closed'**
  String get marketCurrentlyClosed;

  /// No description provided for @closePosition.
  ///
  /// In en, this message translates to:
  /// **'Close Position'**
  String get closePosition;

  /// No description provided for @positionClosedNotification.
  ///
  /// In en, this message translates to:
  /// **'Position:#{ticketNumber} on {symbol} closed with profit {profit}'**
  String positionClosedNotification(
    Object profit,
    Object symbol,
    Object ticketNumber,
  );

  /// No description provided for @positionOpenedNotification.
  ///
  /// In en, this message translates to:
  /// **'New position: {direction} {symbol} @ {volume}'**
  String positionOpenedNotification(
    Object direction,
    Object symbol,
    Object volume,
  );

  /// No description provided for @positionModifiedNotification.
  ///
  /// In en, this message translates to:
  /// **'Position:#{id} on {symbol} SL/TP Modified'**
  String positionModifiedNotification(Object id, Object symbol);

  /// No description provided for @orderClosedNotification.
  ///
  /// In en, this message translates to:
  /// **'Order:#{ticketNumber} on {symbol} closed with profit {profit}'**
  String orderClosedNotification(
    Object profit,
    Object symbol,
    Object ticketNumber,
  );

  /// No description provided for @orderOpenedNotification.
  ///
  /// In en, this message translates to:
  /// **'New Order: {direction} {symbol} @ {price}'**
  String orderOpenedNotification(Object direction, Object price, Object symbol);

  /// No description provided for @orderModifiedNotification.
  ///
  /// In en, this message translates to:
  /// **'Order:#{id} on {symbol} SL/TP Modified'**
  String orderModifiedNotification(Object id, Object symbol);

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @classification.
  ///
  /// In en, this message translates to:
  /// **'Classification'**
  String get classification;

  /// No description provided for @leverage.
  ///
  /// In en, this message translates to:
  /// **'Leverage'**
  String get leverage;

  /// No description provided for @mainPassword.
  ///
  /// In en, this message translates to:
  /// **'Main Password'**
  String get mainPassword;

  /// No description provided for @accountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account number'**
  String get accountNumber;

  /// No description provided for @pleaseEnterAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter account number'**
  String get pleaseEnterAccountNumber;

  /// No description provided for @openNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Open New Account?'**
  String get openNewAccount;

  /// No description provided for @longPasswordValidation.
  ///
  /// In en, this message translates to:
  /// **'Long password from 8 to 32 characters'**
  String get longPasswordValidation;

  /// No description provided for @upperCaseValidation.
  ///
  /// In en, this message translates to:
  /// **'Upper case letters'**
  String get upperCaseValidation;

  /// No description provided for @lowerCaseValidation.
  ///
  /// In en, this message translates to:
  /// **'Lower case letters'**
  String get lowerCaseValidation;

  /// No description provided for @symbolValidation.
  ///
  /// In en, this message translates to:
  /// **'A symbol (\$&@-()/!?)'**
  String get symbolValidation;

  /// No description provided for @includeNumbersValidation.
  ///
  /// In en, this message translates to:
  /// **'Include numbers'**
  String get includeNumbersValidation;

  /// No description provided for @weak.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get weak;

  /// No description provided for @fair.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get fair;

  /// No description provided for @good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good;

  /// No description provided for @strong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get strong;

  /// No description provided for @selectYourAnswer.
  ///
  /// In en, this message translates to:
  /// **'Select your answer'**
  String get selectYourAnswer;

  /// No description provided for @usdAmount.
  ///
  /// In en, this message translates to:
  /// **'{amount} USD'**
  String usdAmount(Object amount);

  /// No description provided for @noSymbolsFound.
  ///
  /// In en, this message translates to:
  /// **'No Symbols Was found'**
  String get noSymbolsFound;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @swap.
  ///
  /// In en, this message translates to:
  /// **'Swap'**
  String get swap;

  /// No description provided for @investorPassword.
  ///
  /// In en, this message translates to:
  /// **'Investor password'**
  String get investorPassword;

  /// No description provided for @pleaseEnterInvestorPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your Investor password'**
  String get pleaseEnterInvestorPassword;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// No description provided for @positions.
  ///
  /// In en, this message translates to:
  /// **'Positions'**
  String get positions;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'pending'**
  String get pending;

  /// No description provided for @loginWelcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Manage all your trading accounts in one place. Login to access your multi-account trading platform.'**
  String get loginWelcomeMessage;

  /// No description provided for @passwordValidationMessage.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one digit\nOne letter\nOne special character'**
  String get passwordValidationMessage;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High: {value}'**
  String high(Object value);

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low: {value}'**
  String low(Object value);

  /// No description provided for @percentage.
  ///
  /// In en, this message translates to:
  /// **'{value}%'**
  String percentage(Object value);

  /// No description provided for @stopLossShort.
  ///
  /// In en, this message translates to:
  /// **'S/L'**
  String get stopLossShort;

  /// No description provided for @takeProfitShort.
  ///
  /// In en, this message translates to:
  /// **'T/P'**
  String get takeProfitShort;

  /// No description provided for @at.
  ///
  /// In en, this message translates to:
  /// **'At {price}'**
  String at(Object price);

  /// No description provided for @buyPosition.
  ///
  /// In en, this message translates to:
  /// **'BUY'**
  String get buyPosition;

  /// No description provided for @sellPosition.
  ///
  /// In en, this message translates to:
  /// **'SELL'**
  String get sellPosition;

  /// No description provided for @noValue.
  ///
  /// In en, this message translates to:
  /// **'--'**
  String get noValue;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'0.00'**
  String get enterAmount;

  /// No description provided for @searchByName.
  ///
  /// In en, this message translates to:
  /// **'Search by Name Server'**
  String get searchByName;

  /// No description provided for @live.
  ///
  /// In en, this message translates to:
  /// **'Live {number}'**
  String live(Object number);

  /// No description provided for @demo.
  ///
  /// In en, this message translates to:
  /// **'Demo {number}'**
  String demo(Object number);

  /// No description provided for @skyOptionLive.
  ///
  /// In en, this message translates to:
  /// **'Sky Option - Live'**
  String get skyOptionLive;

  /// No description provided for @skyOptionDemo.
  ///
  /// In en, this message translates to:
  /// **'Sky Option - Demo'**
  String get skyOptionDemo;

  /// No description provided for @skyOption.
  ///
  /// In en, this message translates to:
  /// **'Sky Option - {number}'**
  String skyOption(Object number);

  /// No description provided for @commission.
  ///
  /// In en, this message translates to:
  /// **'Commission'**
  String get commission;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @modify.
  ///
  /// In en, this message translates to:
  /// **'Modify'**
  String get modify;

  /// No description provided for @leverageRatio.
  ///
  /// In en, this message translates to:
  /// **'1 : {value}'**
  String leverageRatio(Object value);

  /// No description provided for @advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// No description provided for @simple.
  ///
  /// In en, this message translates to:
  /// **'Simple'**
  String get simple;

  /// No description provided for @table.
  ///
  /// In en, this message translates to:
  /// **'Table'**
  String get table;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Sky Option'**
  String get appName;

  /// No description provided for @enterValue.
  ///
  /// In en, this message translates to:
  /// **'0.00'**
  String get enterValue;

  /// No description provided for @sell.
  ///
  /// In en, this message translates to:
  /// **'Sell'**
  String get sell;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @check.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get check;

  /// No description provided for @reconnect.
  ///
  /// In en, this message translates to:
  /// **'Reconnect'**
  String get reconnect;

  /// No description provided for @chartSettings.
  ///
  /// In en, this message translates to:
  /// **'Chart Settings'**
  String get chartSettings;

  /// No description provided for @rotate.
  ///
  /// In en, this message translates to:
  /// **'Rotate'**
  String get rotate;

  /// No description provided for @switchAccount.
  ///
  /// In en, this message translates to:
  /// **'Switch Account'**
  String get switchAccount;

  /// No description provided for @addAccount.
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get addAccount;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @changeTheme.
  ///
  /// In en, this message translates to:
  /// **'Change Theme'**
  String get changeTheme;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @tradingSettings.
  ///
  /// In en, this message translates to:
  /// **'Trading Settings'**
  String get tradingSettings;

  /// No description provided for @logs.
  ///
  /// In en, this message translates to:
  /// **'Logs'**
  String get logs;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String version(Object version);

  /// No description provided for @spectatePassword.
  ///
  /// In en, this message translates to:
  /// **'Spectate Password'**
  String get spectatePassword;

  /// No description provided for @masterPassword.
  ///
  /// In en, this message translates to:
  /// **'Master password'**
  String get masterPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter New password'**
  String get enterNewPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New password'**
  String get confirmNewPassword;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid'**
  String get invalid;

  /// No description provided for @volumeAt.
  ///
  /// In en, this message translates to:
  /// **'{volume} at {price}'**
  String volumeAt(Object price, Object volume);

  /// No description provided for @specified.
  ///
  /// In en, this message translates to:
  /// **'Specified'**
  String get specified;

  /// No description provided for @wait.
  ///
  /// In en, this message translates to:
  /// **'Wait'**
  String get wait;

  /// No description provided for @modifyPosition.
  ///
  /// In en, this message translates to:
  /// **'Modify Position'**
  String get modifyPosition;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @credit.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get credit;

  /// No description provided for @equity.
  ///
  /// In en, this message translates to:
  /// **'Equity'**
  String get equity;

  /// No description provided for @marketExecution.
  ///
  /// In en, this message translates to:
  /// **'Market execution'**
  String get marketExecution;

  /// No description provided for @buyLimit.
  ///
  /// In en, this message translates to:
  /// **'Buy Limit'**
  String get buyLimit;

  /// No description provided for @sellLimit.
  ///
  /// In en, this message translates to:
  /// **'Sell Limit'**
  String get sellLimit;

  /// No description provided for @buyStop.
  ///
  /// In en, this message translates to:
  /// **'Buy Stop'**
  String get buyStop;

  /// No description provided for @sellStop.
  ///
  /// In en, this message translates to:
  /// **'Sell Stop'**
  String get sellStop;

  /// No description provided for @tradeType.
  ///
  /// In en, this message translates to:
  /// **'Trade Type'**
  String get tradeType;

  /// No description provided for @margin.
  ///
  /// In en, this message translates to:
  /// **'Margin'**
  String get margin;

  /// No description provided for @freeMargin.
  ///
  /// In en, this message translates to:
  /// **'Free Margin'**
  String get freeMargin;

  /// No description provided for @marginLevel.
  ///
  /// In en, this message translates to:
  /// **'Margin level (%)'**
  String get marginLevel;

  /// No description provided for @searchBySymbol.
  ///
  /// In en, this message translates to:
  /// **'Search by symbol...'**
  String get searchBySymbol;

  /// No description provided for @tick.
  ///
  /// In en, this message translates to:
  /// **'Tick'**
  String get tick;

  /// No description provided for @sendOrder.
  ///
  /// In en, this message translates to:
  /// **'Send Order'**
  String get sendOrder;

  /// No description provided for @functions.
  ///
  /// In en, this message translates to:
  /// **'Functions'**
  String get functions;

  /// No description provided for @objects.
  ///
  /// In en, this message translates to:
  /// **'Objects'**
  String get objects;

  /// No description provided for @grid.
  ///
  /// In en, this message translates to:
  /// **'Grid'**
  String get grid;

  /// No description provided for @symbolSearch.
  ///
  /// In en, this message translates to:
  /// **'Symbol Search'**
  String get symbolSearch;

  /// No description provided for @symbolOptions.
  ///
  /// In en, this message translates to:
  /// **'Symbol Options'**
  String get symbolOptions;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @findSymbol.
  ///
  /// In en, this message translates to:
  /// **'Find symbol...'**
  String get findSymbol;

  /// No description provided for @folder.
  ///
  /// In en, this message translates to:
  /// **'Folder'**
  String get folder;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @dragToReorder.
  ///
  /// In en, this message translates to:
  /// **'Drag to reorder'**
  String get dragToReorder;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @filterByDate.
  ///
  /// In en, this message translates to:
  /// **'Filter by date'**
  String get filterByDate;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @lastWeek.
  ///
  /// In en, this message translates to:
  /// **'Last Week'**
  String get lastWeek;

  /// No description provided for @lastMonth.
  ///
  /// In en, this message translates to:
  /// **'Last Month'**
  String get lastMonth;

  /// No description provided for @last3Months.
  ///
  /// In en, this message translates to:
  /// **'Last 3 Months'**
  String get last3Months;

  /// No description provided for @last6Months.
  ///
  /// In en, this message translates to:
  /// **'Last 6 Months'**
  String get last6Months;

  /// No description provided for @lastYear.
  ///
  /// In en, this message translates to:
  /// **'Last Year'**
  String get lastYear;

  /// No description provided for @custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// No description provided for @actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// No description provided for @openDate.
  ///
  /// In en, this message translates to:
  /// **'Open Date: '**
  String get openDate;

  /// No description provided for @closeDate.
  ///
  /// In en, this message translates to:
  /// **'Close Date: '**
  String get closeDate;

  /// No description provided for @chartStyle.
  ///
  /// In en, this message translates to:
  /// **'Chart Style'**
  String get chartStyle;

  /// No description provided for @candlestick.
  ///
  /// In en, this message translates to:
  /// **'Candlestick'**
  String get candlestick;

  /// No description provided for @bar.
  ///
  /// In en, this message translates to:
  /// **'Bar'**
  String get bar;

  /// No description provided for @minute.
  ///
  /// In en, this message translates to:
  /// **'Minute'**
  String get minute;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'{count} Minutes'**
  String minutes(Object count);

  /// No description provided for @hour.
  ///
  /// In en, this message translates to:
  /// **'Hour'**
  String get hour;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'{count} Hours'**
  String hours(Object count);

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'{count} Days'**
  String days(Object count);

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @searchSymbol.
  ///
  /// In en, this message translates to:
  /// **'Search Symbol'**
  String get searchSymbol;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No Results'**
  String get noResults;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @welcomeToSky5.
  ///
  /// In en, this message translates to:
  /// **'Welcome to\nSky 5'**
  String get welcomeToSky5;

  /// No description provided for @globalMarketsAtYourFingertips.
  ///
  /// In en, this message translates to:
  /// **'Global Markets at\nYour Fingertips'**
  String get globalMarketsAtYourFingertips;

  /// No description provided for @advancedTradingTools.
  ///
  /// In en, this message translates to:
  /// **'Advanced\nTrading Tools'**
  String get advancedTradingTools;

  /// No description provided for @realTimeMarketInsights.
  ///
  /// In en, this message translates to:
  /// **'Real-Time Market\nInsights'**
  String get realTimeMarketInsights;

  /// No description provided for @searchBySymbolDots.
  ///
  /// In en, this message translates to:
  /// **'Search by symbol...'**
  String get searchBySymbolDots;

  /// No description provided for @editSymbols.
  ///
  /// In en, this message translates to:
  /// **'Edit Symbols'**
  String get editSymbols;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortBy;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @sector.
  ///
  /// In en, this message translates to:
  /// **'Sector'**
  String get sector;

  /// No description provided for @industry.
  ///
  /// In en, this message translates to:
  /// **'Industry'**
  String get industry;

  /// No description provided for @digits.
  ///
  /// In en, this message translates to:
  /// **'Digits'**
  String get digits;

  /// No description provided for @contractSize.
  ///
  /// In en, this message translates to:
  /// **'Contract size'**
  String get contractSize;

  /// No description provided for @spread.
  ///
  /// In en, this message translates to:
  /// **'Spread'**
  String get spread;

  /// No description provided for @stopsLevel.
  ///
  /// In en, this message translates to:
  /// **'Stops level'**
  String get stopsLevel;

  /// No description provided for @marginCurrency.
  ///
  /// In en, this message translates to:
  /// **'Margin currency'**
  String get marginCurrency;

  /// No description provided for @profitCurrency.
  ///
  /// In en, this message translates to:
  /// **'Profit currency'**
  String get profitCurrency;

  /// No description provided for @calculation.
  ///
  /// In en, this message translates to:
  /// **'Calculation'**
  String get calculation;

  /// No description provided for @chartMode.
  ///
  /// In en, this message translates to:
  /// **'Chart mode'**
  String get chartMode;

  /// No description provided for @execution.
  ///
  /// In en, this message translates to:
  /// **'Execution'**
  String get execution;

  /// No description provided for @gtcMode.
  ///
  /// In en, this message translates to:
  /// **'GTC Mode'**
  String get gtcMode;

  /// No description provided for @filling.
  ///
  /// In en, this message translates to:
  /// **'Filling'**
  String get filling;

  /// No description provided for @expiration.
  ///
  /// In en, this message translates to:
  /// **'Expiration'**
  String get expiration;

  /// No description provided for @minimalVolume.
  ///
  /// In en, this message translates to:
  /// **'Minimal volume'**
  String get minimalVolume;

  /// No description provided for @maximalVolume.
  ///
  /// In en, this message translates to:
  /// **'Maximal volume'**
  String get maximalVolume;

  /// No description provided for @volumeStep.
  ///
  /// In en, this message translates to:
  /// **'Volume step'**
  String get volumeStep;

  /// No description provided for @allSymbols.
  ///
  /// In en, this message translates to:
  /// **'All Symbols'**
  String get allSymbols;

  /// No description provided for @profit.
  ///
  /// In en, this message translates to:
  /// **'Profit'**
  String get profit;

  /// No description provided for @deposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get deposit;

  /// No description provided for @withdrawal.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal'**
  String get withdrawal;

  /// No description provided for @totalBalance.
  ///
  /// In en, this message translates to:
  /// **'Total balance'**
  String get totalBalance;

  /// No description provided for @filled.
  ///
  /// In en, this message translates to:
  /// **'Filled'**
  String get filled;

  /// No description provided for @canceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get canceled;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @bidPrice.
  ///
  /// In en, this message translates to:
  /// **'Bid:'**
  String get bidPrice;

  /// No description provided for @modifyTradeLevels.
  ///
  /// In en, this message translates to:
  /// **'Modify Trade Levels'**
  String get modifyTradeLevels;

  /// No description provided for @modifyOrder.
  ///
  /// In en, this message translates to:
  /// **'Modify Order'**
  String get modifyOrder;

  /// No description provided for @deleteAllOrders.
  ///
  /// In en, this message translates to:
  /// **'Delete All Orders'**
  String get deleteAllOrders;

  /// No description provided for @deleteAllBuyLimitOrders.
  ///
  /// In en, this message translates to:
  /// **'Delete All Buy Limit Orders'**
  String get deleteAllBuyLimitOrders;

  /// No description provided for @deleteAllSellLimitOrders.
  ///
  /// In en, this message translates to:
  /// **'Delete All Sell Limit Orders'**
  String get deleteAllSellLimitOrders;

  /// No description provided for @deleteAllBuyStopOrders.
  ///
  /// In en, this message translates to:
  /// **'Delete All Buy Stop Orders'**
  String get deleteAllBuyStopOrders;

  /// No description provided for @deleteAllSellStopOrders.
  ///
  /// In en, this message translates to:
  /// **'Delete All Sell Stop Orders'**
  String get deleteAllSellStopOrders;

  /// No description provided for @switchToThisAccount.
  ///
  /// In en, this message translates to:
  /// **'Switch to this Account'**
  String get switchToThisAccount;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @selectSymbols.
  ///
  /// In en, this message translates to:
  /// **'Select Symbols'**
  String get selectSymbols;

  /// No description provided for @forex.
  ///
  /// In en, this message translates to:
  /// **'Forex'**
  String get forex;

  /// No description provided for @metals.
  ///
  /// In en, this message translates to:
  /// **'Metals'**
  String get metals;

  /// No description provided for @indexes.
  ///
  /// In en, this message translates to:
  /// **'Indexes'**
  String get indexes;

  /// No description provided for @welcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Your gateway to trading forex and stocks across global markets. Start your investment journey with ease and confidence.'**
  String get welcomeDescription;

  /// No description provided for @globalMarketsDescription.
  ///
  /// In en, this message translates to:
  /// **'Access real-time data, analyze trends, and trade in forex and stock markets worldwide, all from one platform.'**
  String get globalMarketsDescription;

  /// No description provided for @advancedToolsDescription.
  ///
  /// In en, this message translates to:
  /// **'Utilize our comprehensive suite of trading tools and indicators to make informed decisions and strategize your trades.'**
  String get advancedToolsDescription;

  /// No description provided for @realTimeInsightsDescription.
  ///
  /// In en, this message translates to:
  /// **'Stay informed with up-to-date market data and analysis. Access real-time charts, expert insights, and market news all in one place. Make smart trading decisions based on accurate information.'**
  String get realTimeInsightsDescription;

  /// No description provided for @closeWithProfit.
  ///
  /// In en, this message translates to:
  /// **'Close with Profit {value}'**
  String closeWithProfit(Object value);

  /// No description provided for @fullAccess.
  ///
  /// In en, this message translates to:
  /// **'Full access'**
  String get fullAccess;

  /// No description provided for @byBidPrice.
  ///
  /// In en, this message translates to:
  /// **'by bid price'**
  String get byBidPrice;

  /// No description provided for @goodTillCanceled.
  ///
  /// In en, this message translates to:
  /// **'Good till canceled'**
  String get goodTillCanceled;

  /// No description provided for @fillOrKill.
  ///
  /// In en, this message translates to:
  /// **'Fill or kill, Immediate or cancel'**
  String get fillOrKill;

  /// No description provided for @invalidValue.
  ///
  /// In en, this message translates to:
  /// **'Invalid'**
  String get invalidValue;

  /// No description provided for @currencyPair.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currencyPair;

  /// No description provided for @undefined.
  ///
  /// In en, this message translates to:
  /// **'Undefined'**
  String get undefined;

  /// No description provided for @floatingSpread.
  ///
  /// In en, this message translates to:
  /// **'Floating'**
  String get floatingSpread;

  /// No description provided for @volumeLotSize.
  ///
  /// In en, this message translates to:
  /// **'Volume (Lot)'**
  String get volumeLotSize;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @accountBalance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get accountBalance;

  /// No description provided for @askPrice.
  ///
  /// In en, this message translates to:
  /// **'Ask:'**
  String get askPrice;

  /// No description provided for @tradeAction.
  ///
  /// In en, this message translates to:
  /// **'Trade'**
  String get tradeAction;

  /// No description provided for @chartAction.
  ///
  /// In en, this message translates to:
  /// **'Chart'**
  String get chartAction;

  /// No description provided for @openPrice.
  ///
  /// In en, this message translates to:
  /// **'Open Price'**
  String get openPrice;

  /// No description provided for @closePrice.
  ///
  /// In en, this message translates to:
  /// **'Close Price'**
  String get closePrice;

  /// No description provided for @orderId.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get orderId;

  /// No description provided for @openTime.
  ///
  /// In en, this message translates to:
  /// **'Open Time'**
  String get openTime;

  /// No description provided for @closeAllPositions.
  ///
  /// In en, this message translates to:
  /// **'Close All Positions'**
  String get closeAllPositions;

  /// No description provided for @closeProfitablePositions.
  ///
  /// In en, this message translates to:
  /// **'Close Profitable Positions'**
  String get closeProfitablePositions;

  /// No description provided for @closeLosingPositions.
  ///
  /// In en, this message translates to:
  /// **'Close Losing Positions'**
  String get closeLosingPositions;

  /// No description provided for @stopLossTitle.
  ///
  /// In en, this message translates to:
  /// **'Stop Loss'**
  String get stopLossTitle;

  /// No description provided for @takeProfitTitle.
  ///
  /// In en, this message translates to:
  /// **'Take Profit'**
  String get takeProfitTitle;

  /// No description provided for @closeBy.
  ///
  /// In en, this message translates to:
  /// **'Close By'**
  String get closeBy;

  /// No description provided for @leverageTitle.
  ///
  /// In en, this message translates to:
  /// **'Leverage'**
  String get leverageTitle;

  /// No description provided for @pointValue.
  ///
  /// In en, this message translates to:
  /// **'Point Value ({value})'**
  String pointValue(Object value);

  /// No description provided for @tradeMargin.
  ///
  /// In en, this message translates to:
  /// **'Trade Margin'**
  String get tradeMargin;

  /// No description provided for @availableMargin.
  ///
  /// In en, this message translates to:
  /// **'Available Margin'**
  String get availableMargin;

  /// No description provided for @expirationTitle.
  ///
  /// In en, this message translates to:
  /// **'Expiration'**
  String get expirationTitle;

  /// No description provided for @priceTitle.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get priceTitle;

  /// No description provided for @marginTitle.
  ///
  /// In en, this message translates to:
  /// **'Margin'**
  String get marginTitle;

  /// No description provided for @commissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Commission'**
  String get commissionTitle;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @shortStopLoss.
  ///
  /// In en, this message translates to:
  /// **'SL'**
  String get shortStopLoss;

  /// No description provided for @shortTakeProfit.
  ///
  /// In en, this message translates to:
  /// **'TP'**
  String get shortTakeProfit;

  /// No description provided for @pointValueWithSize.
  ///
  /// In en, this message translates to:
  /// **'Point Value ({size})'**
  String pointValueWithSize(Object size);

  /// No description provided for @closeByTitle.
  ///
  /// In en, this message translates to:
  /// **'Close by'**
  String get closeByTitle;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @loginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Login With Google'**
  String get loginWithGoogle;

  /// No description provided for @loginWithApple.
  ///
  /// In en, this message translates to:
  /// **'Login With Apple'**
  String get loginWithApple;

  /// No description provided for @orLoginWith.
  ///
  /// In en, this message translates to:
  /// **'Or Login with'**
  String get orLoginWith;

  /// No description provided for @selectServer.
  ///
  /// In en, this message translates to:
  /// **'Select Server'**
  String get selectServer;

  /// No description provided for @skyOptionServer.
  ///
  /// In en, this message translates to:
  /// **'Sky Option - {number}'**
  String skyOptionServer(Object number);

  /// No description provided for @mainPosition.
  ///
  /// In en, this message translates to:
  /// **'Main Position'**
  String get mainPosition;

  /// No description provided for @closeByMainPosition.
  ///
  /// In en, this message translates to:
  /// **'Close by Main Position'**
  String get closeByMainPosition;

  /// No description provided for @searchByNameServer.
  ///
  /// In en, this message translates to:
  /// **'Search by Name Server'**
  String get searchByNameServer;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @volumeLotTitle.
  ///
  /// In en, this message translates to:
  /// **'Volume (Lot)'**
  String get volumeLotTitle;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @chooseTime.
  ///
  /// In en, this message translates to:
  /// **'Choose time'**
  String get chooseTime;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @activeTrades.
  ///
  /// In en, this message translates to:
  /// **'Active Trades'**
  String get activeTrades;

  /// No description provided for @market.
  ///
  /// In en, this message translates to:
  /// **'Market'**
  String get market;

  /// No description provided for @limit.
  ///
  /// In en, this message translates to:
  /// **'Limit'**
  String get limit;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @positionNumber.
  ///
  /// In en, this message translates to:
  /// **'Position Number'**
  String get positionNumber;

  /// No description provided for @historyDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get historyDate;

  /// No description provided for @historyPositionNumber.
  ///
  /// In en, this message translates to:
  /// **'Position Number'**
  String get historyPositionNumber;

  /// No description provided for @historyProfit.
  ///
  /// In en, this message translates to:
  /// **'Profit'**
  String get historyProfit;

  /// No description provided for @floating.
  ///
  /// In en, this message translates to:
  /// **'Floating'**
  String get floating;

  /// No description provided for @cursorColor.
  ///
  /// In en, this message translates to:
  /// **'Cursor Color'**
  String get cursorColor;

  /// No description provided for @thereIsNoServerSelected.
  ///
  /// In en, this message translates to:
  /// **'There is no server selected'**
  String get thereIsNoServerSelected;

  /// No description provided for @searchByServerName.
  ///
  /// In en, this message translates to:
  /// **'Search by Server Name'**
  String get searchByServerName;

  /// No description provided for @candleUpColor.
  ///
  /// In en, this message translates to:
  /// **'Candle Up Color'**
  String get candleUpColor;

  /// No description provided for @candleDownColor.
  ///
  /// In en, this message translates to:
  /// **'Candle Down Color'**
  String get candleDownColor;

  /// No description provided for @totalWinPositions.
  ///
  /// In en, this message translates to:
  /// **'Total Win Positions'**
  String get totalWinPositions;

  /// No description provided for @totalLosePositions.
  ///
  /// In en, this message translates to:
  /// **'Total Lose Positions'**
  String get totalLosePositions;

  /// No description provided for @netProfit.
  ///
  /// In en, this message translates to:
  /// **'Net Profit'**
  String get netProfit;

  /// No description provided for @winPositions.
  ///
  /// In en, this message translates to:
  /// **'Win Positions'**
  String get winPositions;

  /// No description provided for @losePositions.
  ///
  /// In en, this message translates to:
  /// **'Lose Positions'**
  String get losePositions;

  /// No description provided for @lot.
  ///
  /// In en, this message translates to:
  /// **'Lot'**
  String get lot;

  /// No description provided for @money.
  ///
  /// In en, this message translates to:
  /// **'Money'**
  String get money;

  /// No description provided for @pips.
  ///
  /// In en, this message translates to:
  /// **'Pips'**
  String get pips;

  /// No description provided for @orderInformation.
  ///
  /// In en, this message translates to:
  /// **'Order information'**
  String get orderInformation;

  /// No description provided for @orderSend.
  ///
  /// In en, this message translates to:
  /// **'Order Send'**
  String get orderSend;

  /// No description provided for @openNewPosition.
  ///
  /// In en, this message translates to:
  /// **'Open new position'**
  String get openNewPosition;

  /// No description provided for @stopLoss.
  ///
  /// In en, this message translates to:
  /// **'Stop Loss'**
  String get stopLoss;

  /// No description provided for @takeProfit.
  ///
  /// In en, this message translates to:
  /// **'Take Profit'**
  String get takeProfit;

  /// No description provided for @actionId.
  ///
  /// In en, this message translates to:
  /// **'Action Id'**
  String get actionId;

  /// No description provided for @positionId.
  ///
  /// In en, this message translates to:
  /// **'Position Id'**
  String get positionId;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @tickets.
  ///
  /// In en, this message translates to:
  /// **'Tickets'**
  String get tickets;

  /// No description provided for @tooltipEditSymbols.
  ///
  /// In en, this message translates to:
  /// **'Edit Symbols'**
  String get tooltipEditSymbols;

  /// No description provided for @tooltipEditSymbolsDescription.
  ///
  /// In en, this message translates to:
  /// **'Modify your symbol list and customize your trading symbols.'**
  String get tooltipEditSymbolsDescription;

  /// No description provided for @tooltipLayoutToggle.
  ///
  /// In en, this message translates to:
  /// **'Layout Toggle'**
  String get tooltipLayoutToggle;

  /// No description provided for @tooltipLayoutToggleDescription.
  ///
  /// In en, this message translates to:
  /// **'Switch between advanced, simple, and table view layouts.'**
  String get tooltipLayoutToggleDescription;

  /// No description provided for @tooltipAddSymbol.
  ///
  /// In en, this message translates to:
  /// **'Add Symbol'**
  String get tooltipAddSymbol;

  /// No description provided for @tooltipAddSymbolDescription.
  ///
  /// In en, this message translates to:
  /// **'Search and add new trading symbols to your list.'**
  String get tooltipAddSymbolDescription;

  /// No description provided for @tooltipSortSymbols.
  ///
  /// In en, this message translates to:
  /// **'Sort Symbols'**
  String get tooltipSortSymbols;

  /// No description provided for @tooltipSortSymbolsDescription.
  ///
  /// In en, this message translates to:
  /// **'Sort your symbols by various criteria like name, price, or change.'**
  String get tooltipSortSymbolsDescription;

  /// No description provided for @tooltipSymbolList.
  ///
  /// In en, this message translates to:
  /// **'Symbol List'**
  String get tooltipSymbolList;

  /// No description provided for @tooltipSymbolListDescription.
  ///
  /// In en, this message translates to:
  /// **'View all your subscribed trading symbols with real-time prices.'**
  String get tooltipSymbolListDescription;

  /// No description provided for @tooltipChartOptions.
  ///
  /// In en, this message translates to:
  /// **'Chart Options'**
  String get tooltipChartOptions;

  /// No description provided for @tooltipChartOptionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Customize your chart view and add technical indicators.'**
  String get tooltipChartOptionsDescription;

  /// No description provided for @tooltipSymbolSelection.
  ///
  /// In en, this message translates to:
  /// **'Symbol Selection'**
  String get tooltipSymbolSelection;

  /// No description provided for @tooltipSymbolSelectionDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose your trading symbol here.'**
  String get tooltipSymbolSelectionDescription;

  /// No description provided for @tooltipFullscreenToggle.
  ///
  /// In en, this message translates to:
  /// **'Fullscreen Toggle'**
  String get tooltipFullscreenToggle;

  /// No description provided for @tooltipFullscreenToggleDescription.
  ///
  /// In en, this message translates to:
  /// **'Switch to fullscreen chart view.'**
  String get tooltipFullscreenToggleDescription;

  /// No description provided for @tooltipZoomOptions.
  ///
  /// In en, this message translates to:
  /// **'Zoom Options'**
  String get tooltipZoomOptions;

  /// No description provided for @tooltipZoomOptionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Control chart zoom and view options.'**
  String get tooltipZoomOptionsDescription;

  /// No description provided for @tooltipScreenRotation.
  ///
  /// In en, this message translates to:
  /// **'Screen Rotation'**
  String get tooltipScreenRotation;

  /// No description provided for @tooltipScreenRotationDescription.
  ///
  /// In en, this message translates to:
  /// **'Rotate screen orientation for better chart viewing.'**
  String get tooltipScreenRotationDescription;

  /// No description provided for @tooltipTimeframeSelection.
  ///
  /// In en, this message translates to:
  /// **'Timeframe Selection'**
  String get tooltipTimeframeSelection;

  /// No description provided for @tooltipTimeframeSelectionDescription.
  ///
  /// In en, this message translates to:
  /// **'Change chart timeframe (1M, 5M, 1H, etc.).'**
  String get tooltipTimeframeSelectionDescription;

  /// No description provided for @tooltipTradingPanel.
  ///
  /// In en, this message translates to:
  /// **'Trading Panel'**
  String get tooltipTradingPanel;

  /// No description provided for @tooltipTradingPanelDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure your trading parameters and place orders.'**
  String get tooltipTradingPanelDescription;

  /// No description provided for @tooltipFloatingPnL.
  ///
  /// In en, this message translates to:
  /// **'Floating P&L'**
  String get tooltipFloatingPnL;

  /// No description provided for @tooltipFloatingPnLDescription.
  ///
  /// In en, this message translates to:
  /// **'Your current profit/loss from open positions.'**
  String get tooltipFloatingPnLDescription;

  /// No description provided for @tooltipSortFilter.
  ///
  /// In en, this message translates to:
  /// **'Sort & Filter'**
  String get tooltipSortFilter;

  /// No description provided for @tooltipSortFilterDescription.
  ///
  /// In en, this message translates to:
  /// **'Sort and filter your positions and orders.'**
  String get tooltipSortFilterDescription;

  /// No description provided for @tooltipNewPosition.
  ///
  /// In en, this message translates to:
  /// **'New Position'**
  String get tooltipNewPosition;

  /// No description provided for @tooltipNewPositionDescription.
  ///
  /// In en, this message translates to:
  /// **'Open a new trading position.'**
  String get tooltipNewPositionDescription;

  /// No description provided for @tooltipPositionsTab.
  ///
  /// In en, this message translates to:
  /// **'Positions Tab'**
  String get tooltipPositionsTab;

  /// No description provided for @tooltipPositionsTabDescription.
  ///
  /// In en, this message translates to:
  /// **'View your active trading positions.'**
  String get tooltipPositionsTabDescription;

  /// No description provided for @tooltipPendingTab.
  ///
  /// In en, this message translates to:
  /// **'Pending Tab'**
  String get tooltipPendingTab;

  /// No description provided for @tooltipPendingTabDescription.
  ///
  /// In en, this message translates to:
  /// **'View your pending orders.'**
  String get tooltipPendingTabDescription;

  /// No description provided for @tooltipMoreActions.
  ///
  /// In en, this message translates to:
  /// **'More Actions'**
  String get tooltipMoreActions;

  /// No description provided for @tooltipMoreActionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Access additional actions for positions and orders.'**
  String get tooltipMoreActionsDescription;

  /// No description provided for @tooltipTradeInfo.
  ///
  /// In en, this message translates to:
  /// **'Trade Information'**
  String get tooltipTradeInfo;

  /// No description provided for @tooltipTradeInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'View your trading account information and statistics.'**
  String get tooltipTradeInfoDescription;

  /// No description provided for @tooltipHistoryInfo.
  ///
  /// In en, this message translates to:
  /// **'History Information'**
  String get tooltipHistoryInfo;

  /// No description provided for @tooltipHistoryInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'View your trading history information and statistics.'**
  String get tooltipHistoryInfoDescription;

  /// No description provided for @tooltipSortHistory.
  ///
  /// In en, this message translates to:
  /// **'Sort History'**
  String get tooltipSortHistory;

  /// No description provided for @tooltipSortHistoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Sort your trading history by various criteria.'**
  String get tooltipSortHistoryDescription;

  /// No description provided for @tooltipFilterHistory.
  ///
  /// In en, this message translates to:
  /// **'Filter History'**
  String get tooltipFilterHistory;

  /// No description provided for @tooltipFilterHistoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Filter your trading history by date range and other criteria.'**
  String get tooltipFilterHistoryDescription;

  /// No description provided for @tooltipTabSwitcher.
  ///
  /// In en, this message translates to:
  /// **'History Tabs'**
  String get tooltipTabSwitcher;

  /// No description provided for @tooltipTabSwitcherDescription.
  ///
  /// In en, this message translates to:
  /// **'Switch between positions, pending orders, and actions history.'**
  String get tooltipTabSwitcherDescription;

  /// No description provided for @tooltipTradingAccount.
  ///
  /// In en, this message translates to:
  /// **'Trading Account'**
  String get tooltipTradingAccount;

  /// No description provided for @tooltipTradingAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'View your current trading account information.'**
  String get tooltipTradingAccountDescription;

  /// No description provided for @tooltipSwitchAccount.
  ///
  /// In en, this message translates to:
  /// **'Switch Account'**
  String get tooltipSwitchAccount;

  /// No description provided for @tooltipSwitchAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'Switch between your trading accounts.'**
  String get tooltipSwitchAccountDescription;

  /// No description provided for @tooltipAddAccount.
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get tooltipAddAccount;

  /// No description provided for @tooltipAddAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'Add a new trading account.'**
  String get tooltipAddAccountDescription;

  /// No description provided for @tooltipChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get tooltipChangePassword;

  /// No description provided for @tooltipChangePasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Change your account password.'**
  String get tooltipChangePasswordDescription;

  /// No description provided for @tooltipChangeTheme.
  ///
  /// In en, this message translates to:
  /// **'Change Theme'**
  String get tooltipChangeTheme;

  /// No description provided for @tooltipChangeThemeDescription.
  ///
  /// In en, this message translates to:
  /// **'Switch between light and dark themes.'**
  String get tooltipChangeThemeDescription;

  /// No description provided for @tooltipLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get tooltipLanguage;

  /// No description provided for @tooltipLanguageDescription.
  ///
  /// In en, this message translates to:
  /// **'Change the application language.'**
  String get tooltipLanguageDescription;

  /// No description provided for @tooltipTradingSettings.
  ///
  /// In en, this message translates to:
  /// **'Trading Settings'**
  String get tooltipTradingSettings;

  /// No description provided for @tooltipTradingSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure your trading preferences and settings.'**
  String get tooltipTradingSettingsDescription;

  /// No description provided for @tooltipLogs.
  ///
  /// In en, this message translates to:
  /// **'Logs'**
  String get tooltipLogs;

  /// No description provided for @tooltipLogsDescription.
  ///
  /// In en, this message translates to:
  /// **'View application logs and system information.'**
  String get tooltipLogsDescription;

  /// No description provided for @tooltipTickets.
  ///
  /// In en, this message translates to:
  /// **'Tickets'**
  String get tooltipTickets;

  /// No description provided for @tooltipTicketsDescription.
  ///
  /// In en, this message translates to:
  /// **'Contact support and manage your support tickets.'**
  String get tooltipTicketsDescription;

  /// No description provided for @tooltipLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get tooltipLogout;

  /// No description provided for @tooltipLogoutDescription.
  ///
  /// In en, this message translates to:
  /// **'Sign out of your account.'**
  String get tooltipLogoutDescription;

  /// No description provided for @requiredMargin.
  ///
  /// In en, this message translates to:
  /// **'Required Margin'**
  String get requiredMargin;

  /// No description provided for @addNewSymbol.
  ///
  /// In en, this message translates to:
  /// **'Add New Symbol'**
  String get addNewSymbol;

  /// No description provided for @main.
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get main;

  /// No description provided for @spectator.
  ///
  /// In en, this message translates to:
  /// **'Spectator'**
  String get spectator;

  /// No description provided for @accountType.
  ///
  /// In en, this message translates to:
  /// **'Account Type'**
  String get accountType;

  /// No description provided for @aed.
  ///
  /// In en, this message translates to:
  /// **'AED'**
  String get aed;

  /// No description provided for @sar.
  ///
  /// In en, this message translates to:
  /// **'SAR'**
  String get sar;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just Now'**
  String get justNow;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} Minutes Ago'**
  String minutesAgo(Object count);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} Hours Ago'**
  String hoursAgo(Object count);

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} Days Ago'**
  String daysAgo(Object count);

  /// No description provided for @minutesSeconds.
  ///
  /// In en, this message translates to:
  /// **'{minutes} Minutes {seconds} Seconds'**
  String minutesSeconds(Object minutes, Object seconds);

  /// No description provided for @hoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'{hours} Hours {minutes} Minutes'**
  String hoursMinutes(Object hours, Object minutes);

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to Clipboard'**
  String get copiedToClipboard;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @marketWillOpenIn.
  ///
  /// In en, this message translates to:
  /// **'The market will open in {day} days {hour} hours {minute} minutes {second} seconds'**
  String marketWillOpenIn(
    Object day,
    Object hour,
    Object minute,
    Object second,
  );

  /// No description provided for @secondsX.
  ///
  /// In en, this message translates to:
  /// **'{count} Seconds'**
  String secondsX(Object count);

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @maxAmount.
  ///
  /// In en, this message translates to:
  /// **'Max Amount'**
  String get maxAmount;

  /// No description provided for @minAmount.
  ///
  /// In en, this message translates to:
  /// **'Min Amount'**
  String get minAmount;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @positionDirection.
  ///
  /// In en, this message translates to:
  /// **'Position Direction'**
  String get positionDirection;

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get id;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
