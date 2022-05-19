// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Markets`
  String get g_key_0 {
    return Intl.message(
      'Markets',
      name: 'g_key_0',
      desc: '',
      args: [],
    );
  }

  /// `Global Trend`
  String get g_key_1 {
    return Intl.message(
      'Global Trend',
      name: 'g_key_1',
      desc: '',
      args: [],
    );
  }

  /// `24H`
  String get g_key_2 {
    return Intl.message(
      '24H',
      name: 'g_key_2',
      desc: '',
      args: [],
    );
  }

  /// `Market Cap Rank`
  String get g_key_3 {
    return Intl.message(
      'Market Cap Rank',
      name: 'g_key_3',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR code`
  String get g_key_4 {
    return Intl.message(
      'Scan QR code',
      name: 'g_key_4',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load`
  String get g_key_5 {
    return Intl.message(
      'Failed to load',
      name: 'g_key_5',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get g_key_6 {
    return Intl.message(
      'Wallet',
      name: 'g_key_6',
      desc: '',
      args: [],
    );
  }

  /// `Privacy and security`
  String get g_key_7 {
    return Intl.message(
      'Privacy and security',
      name: 'g_key_7',
      desc: '',
      args: [],
    );
  }

  /// `The key never leaves your device`
  String get g_key_8 {
    return Intl.message(
      'The key never leaves your device',
      name: 'g_key_8',
      desc: '',
      args: [],
    );
  }

  /// `And supports multiple main chain digital currencies such as BTC, EOS, ETH, etc.`
  String get g_key_9 {
    return Intl.message(
      'And supports multiple main chain digital currencies such as BTC, EOS, ETH, etc.',
      name: 'g_key_9',
      desc: '',
      args: [],
    );
  }

  /// `Create a new wallet`
  String get g_key_10 {
    return Intl.message(
      'Create a new wallet',
      name: 'g_key_10',
      desc: '',
      args: [],
    );
  }

  /// `Import already wallet`
  String get g_key_11 {
    return Intl.message(
      'Import already wallet',
      name: 'g_key_11',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the mnemonic phrase`
  String get g_key_12 {
    return Intl.message(
      'Please enter the mnemonic phrase',
      name: 'g_key_12',
      desc: '',
      args: [],
    );
  }

  /// `Enter an existing mnemonic`
  String get g_key_13 {
    return Intl.message(
      'Enter an existing mnemonic',
      name: 'g_key_13',
      desc: '',
      args: [],
    );
  }

  /// `Mnemonic cannot be empty`
  String get g_key_14 {
    return Intl.message(
      'Mnemonic cannot be empty',
      name: 'g_key_14',
      desc: '',
      args: [],
    );
  }

  /// `**Please recheck your mnemonic phrase, the mnemonic phrase you entered is invalid **`
  String get g_key_15 {
    return Intl.message(
      '**Please recheck your mnemonic phrase, the mnemonic phrase you entered is invalid **',
      name: 'g_key_15',
      desc: '',
      args: [],
    );
  }

  /// `Set up`
  String get g_key_16 {
    return Intl.message(
      'Set up',
      name: 'g_key_16',
      desc: '',
      args: [],
    );
  }

  /// `Set wallet name`
  String get g_key_17 {
    return Intl.message(
      'Set wallet name',
      name: 'g_key_17',
      desc: '',
      args: [],
    );
  }

  /// `Enter a custom name`
  String get g_key_18 {
    return Intl.message(
      'Enter a custom name',
      name: 'g_key_18',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a name`
  String get g_key_19 {
    return Intl.message(
      'Please enter a name',
      name: 'g_key_19',
      desc: '',
      args: [],
    );
  }

  /// `Set wallet password`
  String get g_key_20 {
    return Intl.message(
      'Set wallet password',
      name: 'g_key_20',
      desc: '',
      args: [],
    );
  }

  /// `Please enter wallet password`
  String get g_key_21 {
    return Intl.message(
      'Please enter wallet password',
      name: 'g_key_21',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the password`
  String get g_key_22 {
    return Intl.message(
      'Please enter the password',
      name: 'g_key_22',
      desc: '',
      args: [],
    );
  }

  /// `Password length cannot be less than 8 characters`
  String get g_key_23 {
    return Intl.message(
      'Password length cannot be less than 8 characters',
      name: 'g_key_23',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password again`
  String get g_key_24 {
    return Intl.message(
      'Please enter your password again',
      name: 'g_key_24',
      desc: '',
      args: [],
    );
  }

  /// `The password entered twice does not match`
  String get g_key_25 {
    return Intl.message(
      'The password entered twice does not match',
      name: 'g_key_25',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get g_key_26 {
    return Intl.message(
      'Create',
      name: 'g_key_26',
      desc: '',
      args: [],
    );
  }

  /// `Create a wallet...`
  String get g_key_27 {
    return Intl.message(
      'Create a wallet...',
      name: 'g_key_27',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get g_key_28 {
    return Intl.message(
      'Wallet',
      name: 'g_key_28',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get g_key_29 {
    return Intl.message(
      'Balance',
      name: 'g_key_29',
      desc: '',
      args: [],
    );
  }

  /// `locked-in amount`
  String get g_key_30 {
    return Intl.message(
      'locked-in amount',
      name: 'g_key_30',
      desc: '',
      args: [],
    );
  }

  /// `next release`
  String get g_key_31 {
    return Intl.message(
      'next release',
      name: 'g_key_31',
      desc: '',
      args: [],
    );
  }

  /// `Transaction`
  String get g_key_32 {
    return Intl.message(
      'Transaction',
      name: 'g_key_32',
      desc: '',
      args: [],
    );
  }

  /// `Receive`
  String get g_key_33 {
    return Intl.message(
      'Receive',
      name: 'g_key_33',
      desc: '',
      args: [],
    );
  }

  /// `Locked-in amount`
  String get g_key_34 {
    return Intl.message(
      'Locked-in amount',
      name: 'g_key_34',
      desc: '',
      args: [],
    );
  }

  /// `Transaction sent successfully!`
  String get g_key_35 {
    return Intl.message(
      'Transaction sent successfully!',
      name: 'g_key_35',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Hash`
  String get g_key_36 {
    return Intl.message(
      'Transaction Hash',
      name: 'g_key_36',
      desc: '',
      args: [],
    );
  }

  /// `Transfer`
  String get g_key_37 {
    return Intl.message(
      'Transfer',
      name: 'g_key_37',
      desc: '',
      args: [],
    );
  }

  /// `Receiving address`
  String get g_key_38 {
    return Intl.message(
      'Receiving address',
      name: 'g_key_38',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the payment address`
  String get g_key_39 {
    return Intl.message(
      'Please enter the payment address',
      name: 'g_key_39',
      desc: '',
      args: [],
    );
  }

  /// `地址`
  String get g_key_40 {
    return Intl.message(
      '地址',
      name: 'g_key_40',
      desc: '',
      args: [],
    );
  }

  /// `Payment address cannot be empty`
  String get g_key_41 {
    return Intl.message(
      'Payment address cannot be empty',
      name: 'g_key_41',
      desc: '',
      args: [],
    );
  }

  /// `Transaction amount`
  String get g_key_42 {
    return Intl.message(
      'Transaction amount',
      name: 'g_key_42',
      desc: '',
      args: [],
    );
  }

  /// `Available Balance`
  String get g_key_43 {
    return Intl.message(
      'Available Balance',
      name: 'g_key_43',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the amount`
  String get g_key_44 {
    return Intl.message(
      'Please enter the amount',
      name: 'g_key_44',
      desc: '',
      args: [],
    );
  }

  /// `金额`
  String get g_key_45 {
    return Intl.message(
      '金额',
      name: 'g_key_45',
      desc: '',
      args: [],
    );
  }

  /// `Amount cannot be empty`
  String get g_key_46 {
    return Intl.message(
      'Amount cannot be empty',
      name: 'g_key_46',
      desc: '',
      args: [],
    );
  }

  /// `Amount exceeds the available range`
  String get g_key_47 {
    return Intl.message(
      'Amount exceeds the available range',
      name: 'g_key_47',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get g_key_48 {
    return Intl.message(
      'Send',
      name: 'g_key_48',
      desc: '',
      args: [],
    );
  }

  /// `Lock-in transaction`
  String get g_key_49 {
    return Intl.message(
      'Lock-in transaction',
      name: 'g_key_49',
      desc: '',
      args: [],
    );
  }

  /// `Lock-in amount`
  String get g_key_50 {
    return Intl.message(
      'Lock-in amount',
      name: 'g_key_50',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the lock-in amount`
  String get g_key_51 {
    return Intl.message(
      'Please enter the lock-in amount',
      name: 'g_key_51',
      desc: '',
      args: [],
    );
  }

  /// `The lock-in amount cannot be empty`
  String get g_key_52 {
    return Intl.message(
      'The lock-in amount cannot be empty',
      name: 'g_key_52',
      desc: '',
      args: [],
    );
  }

  /// `The lock-in amount exceeds the available range`
  String get g_key_53 {
    return Intl.message(
      'The lock-in amount exceeds the available range',
      name: 'g_key_53',
      desc: '',
      args: [],
    );
  }

  /// `The lock-in amount exceeds the transaction amount`
  String get g_key_54 {
    return Intl.message(
      'The lock-in amount exceeds the transaction amount',
      name: 'g_key_54',
      desc: '',
      args: [],
    );
  }

  /// `Release amount`
  String get g_key_55 {
    return Intl.message(
      'Release amount',
      name: 'g_key_55',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the release amount`
  String get g_key_56 {
    return Intl.message(
      'Please enter the release amount',
      name: 'g_key_56',
      desc: '',
      args: [],
    );
  }

  /// `The release amount cannot be empty`
  String get g_key_57 {
    return Intl.message(
      'The release amount cannot be empty',
      name: 'g_key_57',
      desc: '',
      args: [],
    );
  }

  /// `The released amount exceeds the available range`
  String get g_key_58 {
    return Intl.message(
      'The released amount exceeds the available range',
      name: 'g_key_58',
      desc: '',
      args: [],
    );
  }

  /// `The released amount exceeds the transaction amount`
  String get g_key_59 {
    return Intl.message(
      'The released amount exceeds the transaction amount',
      name: 'g_key_59',
      desc: '',
      args: [],
    );
  }

  /// `The released amount exceeds the lock-in amount`
  String get g_key_60 {
    return Intl.message(
      'The released amount exceeds the lock-in amount',
      name: 'g_key_60',
      desc: '',
      args: [],
    );
  }

  /// `Release interval`
  String get g_key_61 {
    return Intl.message(
      'Release interval',
      name: 'g_key_61',
      desc: '',
      args: [],
    );
  }

  /// `How often is the interval to release, the unit is second, not less than 10 minutes (600 seconds)`
  String get g_key_62 {
    return Intl.message(
      'How often is the interval to release, the unit is second, not less than 10 minutes (600 seconds)',
      name: 'g_key_62',
      desc: '',
      args: [],
    );
  }

  /// `Please select the release interval`
  String get g_key_63 {
    return Intl.message(
      'Please select the release interval',
      name: 'g_key_63',
      desc: '',
      args: [],
    );
  }

  /// `间隔秒数`
  String get g_key_64 {
    return Intl.message(
      '间隔秒数',
      name: 'g_key_64',
      desc: '',
      args: [],
    );
  }

  /// `The release interval cannot be empty`
  String get g_key_65 {
    return Intl.message(
      'The release interval cannot be empty',
      name: 'g_key_65',
      desc: '',
      args: [],
    );
  }

  /// `The release interval cannot be less than 10 minutes (600 seconds)`
  String get g_key_66 {
    return Intl.message(
      'The release interval cannot be less than 10 minutes (600 seconds)',
      name: 'g_key_66',
      desc: '',
      args: [],
    );
  }

  /// `Release time`
  String get g_key_67 {
    return Intl.message(
      'Release time',
      name: 'g_key_67',
      desc: '',
      args: [],
    );
  }

  /// `开启释放时间，为具体年月日时分钞的时间戳`
  String get g_key_68 {
    return Intl.message(
      '开启释放时间，为具体年月日时分钞的时间戳',
      name: 'g_key_68',
      desc: '',
      args: [],
    );
  }

  /// `Please select the release date`
  String get g_key_69 {
    return Intl.message(
      'Please select the release date',
      name: 'g_key_69',
      desc: '',
      args: [],
    );
  }

  /// `Timestamp of release date`
  String get g_key_70 {
    return Intl.message(
      'Timestamp of release date',
      name: 'g_key_70',
      desc: '',
      args: [],
    );
  }

  /// `Release date cannot be empty`
  String get g_key_71 {
    return Intl.message(
      'Release date cannot be empty',
      name: 'g_key_71',
      desc: '',
      args: [],
    );
  }

  /// `fdsafads`
  String get g_key_72 {
    return Intl.message(
      'fdsafads',
      name: 'g_key_72',
      desc: '',
      args: [],
    );
  }

  /// `transaction history`
  String get g_key_73 {
    return Intl.message(
      'transaction history',
      name: 'g_key_73',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Details`
  String get g_key_74 {
    return Intl.message(
      'Transaction Details',
      name: 'g_key_74',
      desc: '',
      args: [],
    );
  }

  /// `Payment address`
  String get g_key_75 {
    return Intl.message(
      'Payment address',
      name: 'g_key_75',
      desc: '',
      args: [],
    );
  }

  /// `Password required to view wallet`
  String get g_key_76 {
    return Intl.message(
      'Password required to view wallet',
      name: 'g_key_76',
      desc: '',
      args: [],
    );
  }

  /// `Please enter wallet password`
  String get g_key_77 {
    return Intl.message(
      'Please enter wallet password',
      name: 'g_key_77',
      desc: '',
      args: [],
    );
  }

  /// `Sure`
  String get g_key_78 {
    return Intl.message(
      'Sure',
      name: 'g_key_78',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get g_key_79 {
    return Intl.message(
      'Cancel',
      name: 'g_key_79',
      desc: '',
      args: [],
    );
  }

  /// `重置密码`
  String get g_key_80 {
    return Intl.message(
      '重置密码',
      name: 'g_key_80',
      desc: '',
      args: [],
    );
  }

  /// `Change wallet password`
  String get g_key_81 {
    return Intl.message(
      'Change wallet password',
      name: 'g_key_81',
      desc: '',
      args: [],
    );
  }

  /// `请输入新的钱包密码`
  String get g_key_82 {
    return Intl.message(
      '请输入新的钱包密码',
      name: 'g_key_82',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the password again`
  String get g_key_83 {
    return Intl.message(
      'Please enter the password again',
      name: 'g_key_83',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get g_key_84 {
    return Intl.message(
      'Change',
      name: 'g_key_84',
      desc: '',
      args: [],
    );
  }

  /// `Mnemonic`
  String get g_key_85 {
    return Intl.message(
      'Mnemonic',
      name: 'g_key_85',
      desc: '',
      args: [],
    );
  }

  /// `MTK Browser`
  String get g_key_86 {
    return Intl.message(
      'MTK Browser',
      name: 'g_key_86',
      desc: '',
      args: [],
    );
  }

  /// `M`
  String get g_key_87 {
    return Intl.message(
      'M',
      name: 'g_key_87',
      desc: '',
      args: [],
    );
  }

  /// `d`
  String get g_key_88 {
    return Intl.message(
      'd',
      name: 'g_key_88',
      desc: '',
      args: [],
    );
  }

  /// `h`
  String get g_key_89 {
    return Intl.message(
      'h',
      name: 'g_key_89',
      desc: '',
      args: [],
    );
  }

  /// `m`
  String get g_key_90 {
    return Intl.message(
      'm',
      name: 'g_key_90',
      desc: '',
      args: [],
    );
  }

  /// `s`
  String get g_key_91 {
    return Intl.message(
      's',
      name: 'g_key_91',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get g_key_92 {
    return Intl.message(
      'Wallet',
      name: 'g_key_92',
      desc: '',
      args: [],
    );
  }

  /// `Transaction`
  String get g_key_93 {
    return Intl.message(
      'Transaction',
      name: 'g_key_93',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get g_key_94 {
    return Intl.message(
      'Setting',
      name: 'g_key_94',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get g_key_95 {
    return Intl.message(
      'Wallet',
      name: 'g_key_95',
      desc: '',
      args: [],
    );
  }

  /// `Apps`
  String get g_key_96 {
    return Intl.message(
      'Apps',
      name: 'g_key_96',
      desc: '',
      args: [],
    );
  }

  /// `View Secret Phrase`
  String get g_key_97 {
    return Intl.message(
      'View Secret Phrase',
      name: 'g_key_97',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get g_key_98 {
    return Intl.message(
      'Change Password',
      name: 'g_key_98',
      desc: '',
      args: [],
    );
  }

  /// `MTK Browser`
  String get g_key_99 {
    return Intl.message(
      'MTK Browser',
      name: 'g_key_99',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get g_key_100 {
    return Intl.message(
      'Send',
      name: 'g_key_100',
      desc: '',
      args: [],
    );
  }

  /// `Miner fee`
  String get g_key_101 {
    return Intl.message(
      'Miner fee',
      name: 'g_key_101',
      desc: '',
      args: [],
    );
  }

  /// `Current Gas Price`
  String get g_key_102 {
    return Intl.message(
      'Current Gas Price',
      name: 'g_key_102',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the Gas fee`
  String get g_key_103 {
    return Intl.message(
      'Please enter the Gas fee',
      name: 'g_key_103',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the number of Ges fees`
  String get g_key_104 {
    return Intl.message(
      'Please enter the number of Ges fees',
      name: 'g_key_104',
      desc: '',
      args: [],
    );
  }

  /// `No more`
  String get g_key_105 {
    return Intl.message(
      'No more',
      name: 'g_key_105',
      desc: '',
      args: [],
    );
  }

  /// `Loading `
  String get g_key_106 {
    return Intl.message(
      'Loading ',
      name: 'g_key_106',
      desc: '',
      args: [],
    );
  }

  /// `Modify name`
  String get g_key_107 {
    return Intl.message(
      'Modify name',
      name: 'g_key_107',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get g_key_108 {
    return Intl.message(
      'Address',
      name: 'g_key_108',
      desc: '',
      args: [],
    );
  }

  /// `Default Address`
  String get g_key_109 {
    return Intl.message(
      'Default Address',
      name: 'g_key_109',
      desc: '',
      args: [],
    );
  }

  /// `Manage`
  String get g_key_110 {
    return Intl.message(
      'Manage',
      name: 'g_key_110',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get g_key_111 {
    return Intl.message(
      'Finish',
      name: 'g_key_111',
      desc: '',
      args: [],
    );
  }

  /// `New address`
  String get g_key_112 {
    return Intl.message(
      'New address',
      name: 'g_key_112',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get g_key_113 {
    return Intl.message(
      'Delete',
      name: 'g_key_113',
      desc: '',
      args: [],
    );
  }

  /// `Modify address`
  String get g_key_114 {
    return Intl.message(
      'Modify address',
      name: 'g_key_114',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get g_key_115 {
    return Intl.message(
      'Save',
      name: 'g_key_115',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the address name`
  String get g_key_116 {
    return Intl.message(
      'Please enter the address name',
      name: 'g_key_116',
      desc: '',
      args: [],
    );
  }

  /// `Please select coins`
  String get g_key_117 {
    return Intl.message(
      'Please select coins',
      name: 'g_key_117',
      desc: '',
      args: [],
    );
  }

  /// `Please wait...`
  String get g_key_118 {
    return Intl.message(
      'Please wait...',
      name: 'g_key_118',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get g_key_119 {
    return Intl.message(
      'Copy',
      name: 'g_key_119',
      desc: '',
      args: [],
    );
  }

  /// `Copy mnemonic words to clipboard`
  String get g_key_120 {
    return Intl.message(
      'Copy mnemonic words to clipboard',
      name: 'g_key_120',
      desc: '',
      args: [],
    );
  }

  /// `Mnemonic {value} cannot be empty`
  String g_key_121(Object value) {
    return Intl.message(
      'Mnemonic $value cannot be empty',
      name: 'g_key_121',
      desc: '',
      args: [value],
    );
  }

  /// `Copy your mnemonic phrase to the current page, and the App can recognize your mnemonic phrase`
  String get g_key_122 {
    return Intl.message(
      'Copy your mnemonic phrase to the current page, and the App can recognize your mnemonic phrase',
      name: 'g_key_122',
      desc: '',
      args: [],
    );
  }

  /// `The mnemonic phrase has been successfully copied from the clipboard`
  String get g_key_123 {
    return Intl.message(
      'The mnemonic phrase has been successfully copied from the clipboard',
      name: 'g_key_123',
      desc: '',
      args: [],
    );
  }

  /// `Please create a wallet first`
  String get g_key_124 {
    return Intl.message(
      'Please create a wallet first',
      name: 'g_key_124',
      desc: '',
      args: [],
    );
  }

  /// `Increase`
  String get g_key_125 {
    return Intl.message(
      'Increase',
      name: 'g_key_125',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get g_key_126 {
    return Intl.message(
      'Theme',
      name: 'g_key_126',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get g_key_127 {
    return Intl.message(
      'System',
      name: 'g_key_127',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get g_key_128 {
    return Intl.message(
      'Light',
      name: 'g_key_128',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get g_key_129 {
    return Intl.message(
      'Dark',
      name: 'g_key_129',
      desc: '',
      args: [],
    );
  }

  /// `Transaction time`
  String get g_key_130 {
    return Intl.message(
      'Transaction time',
      name: 'g_key_130',
      desc: '',
      args: [],
    );
  }

  /// `Trading volume`
  String get g_key_131 {
    return Intl.message(
      'Trading volume',
      name: 'g_key_131',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get g_key_132 {
    return Intl.message(
      'No data',
      name: 'g_key_132',
      desc: '',
      args: [],
    );
  }

  /// `App version`
  String get g_key_133 {
    return Intl.message(
      'App version',
      name: 'g_key_133',
      desc: '',
      args: [],
    );
  }

  /// `Amount entered incorrectly`
  String get g_key_134 {
    return Intl.message(
      'Amount entered incorrectly',
      name: 'g_key_134',
      desc: '',
      args: [],
    );
  }

  /// `Gas fee amount entered incorrectly`
  String get g_key_135 {
    return Intl.message(
      'Gas fee amount entered incorrectly',
      name: 'g_key_135',
      desc: '',
      args: [],
    );
  }

  /// `Cross-chain transaction`
  String get g_key_136 {
    return Intl.message(
      'Cross-chain transaction',
      name: 'g_key_136',
      desc: '',
      args: [],
    );
  }

  /// `You don’t have this currency in your wallet.`
  String get g_key_137 {
    return Intl.message(
      'You don’t have this currency in your wallet.',
      name: 'g_key_137',
      desc: '',
      args: [],
    );
  }

  /// `Coins`
  String get g_key_138 {
    return Intl.message(
      'Coins',
      name: 'g_key_138',
      desc: '',
      args: [],
    );
  }

  /// `Receiving coins`
  String get g_key_139 {
    return Intl.message(
      'Receiving coins',
      name: 'g_key_139',
      desc: '',
      args: [],
    );
  }

  /// `Successful transaction`
  String get g_key_140 {
    return Intl.message(
      'Successful transaction',
      name: 'g_key_140',
      desc: '',
      args: [],
    );
  }

  /// `Transaction request has been sent`
  String get g_key_141 {
    return Intl.message(
      'Transaction request has been sent',
      name: 'g_key_141',
      desc: '',
      args: [],
    );
  }

  /// `Cross-chain transaction history`
  String get g_key_142 {
    return Intl.message(
      'Cross-chain transaction history',
      name: 'g_key_142',
      desc: '',
      args: [],
    );
  }

  /// `No transaction record`
  String get g_key_143 {
    return Intl.message(
      'No transaction record',
      name: 'g_key_143',
      desc: '',
      args: [],
    );
  }

  /// `Record details`
  String get g_key_144 {
    return Intl.message(
      'Record details',
      name: 'g_key_144',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get g_key_145 {
    return Intl.message(
      'State',
      name: 'g_key_145',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password`
  String get g_key_146 {
    return Intl.message(
      'Wrong password',
      name: 'g_key_146',
      desc: '',
      args: [],
    );
  }

  /// `Block number`
  String get g_key_t_1 {
    return Intl.message(
      'Block number',
      name: 'g_key_t_1',
      desc: '',
      args: [],
    );
  }

  /// `Transaction time`
  String get g_key_t_2 {
    return Intl.message(
      'Transaction time',
      name: 'g_key_t_2',
      desc: '',
      args: [],
    );
  }

  /// `Hash`
  String get g_key_t_3 {
    return Intl.message(
      'Hash',
      name: 'g_key_t_3',
      desc: '',
      args: [],
    );
  }

  /// `Nonce`
  String get g_key_t_4 {
    return Intl.message(
      'Nonce',
      name: 'g_key_t_4',
      desc: '',
      args: [],
    );
  }

  /// `Block hash`
  String get g_key_t_5 {
    return Intl.message(
      'Block hash',
      name: 'g_key_t_5',
      desc: '',
      args: [],
    );
  }

  /// `Payment address`
  String get g_key_t_6 {
    return Intl.message(
      'Payment address',
      name: 'g_key_t_6',
      desc: '',
      args: [],
    );
  }

  /// `Contract address`
  String get g_key_t_7 {
    return Intl.message(
      'Contract address',
      name: 'g_key_t_7',
      desc: '',
      args: [],
    );
  }

  /// `Receiving address`
  String get g_key_t_8 {
    return Intl.message(
      'Receiving address',
      name: 'g_key_t_8',
      desc: '',
      args: [],
    );
  }

  /// `Trading volume`
  String get g_key_t_9 {
    return Intl.message(
      'Trading volume',
      name: 'g_key_t_9',
      desc: '',
      args: [],
    );
  }

  /// `Token name`
  String get g_key_t_10 {
    return Intl.message(
      'Token name',
      name: 'g_key_t_10',
      desc: '',
      args: [],
    );
  }

  /// `Token symbol`
  String get g_key_t_11 {
    return Intl.message(
      'Token symbol',
      name: 'g_key_t_11',
      desc: '',
      args: [],
    );
  }

  /// `Token decimal`
  String get g_key_t_12 {
    return Intl.message(
      'Token decimal',
      name: 'g_key_t_12',
      desc: '',
      args: [],
    );
  }

  /// `Transaction index`
  String get g_key_t_13 {
    return Intl.message(
      'Transaction index',
      name: 'g_key_t_13',
      desc: '',
      args: [],
    );
  }

  /// `Gas`
  String get g_key_t_14 {
    return Intl.message(
      'Gas',
      name: 'g_key_t_14',
      desc: '',
      args: [],
    );
  }

  /// `Gas price`
  String get g_key_t_15 {
    return Intl.message(
      'Gas price',
      name: 'g_key_t_15',
      desc: '',
      args: [],
    );
  }

  /// `Gas used`
  String get g_key_t_16 {
    return Intl.message(
      'Gas used',
      name: 'g_key_t_16',
      desc: '',
      args: [],
    );
  }

  /// `Cumulative gas used`
  String get g_key_t_17 {
    return Intl.message(
      'Cumulative gas used',
      name: 'g_key_t_17',
      desc: '',
      args: [],
    );
  }

  /// `Input`
  String get g_key_t_18 {
    return Intl.message(
      'Input',
      name: 'g_key_t_18',
      desc: '',
      args: [],
    );
  }

  /// `Confirmations`
  String get g_key_t_19 {
    return Intl.message(
      'Confirmations',
      name: 'g_key_t_19',
      desc: '',
      args: [],
    );
  }

  /// `Parsing response data abnormal`
  String get g_key_error_1 {
    return Intl.message(
      'Parsing response data abnormal',
      name: 'g_key_error_1',
      desc: '',
      args: [],
    );
  }

  /// `HTTP error`
  String get g_key_error_2 {
    return Intl.message(
      'HTTP error',
      name: 'g_key_error_2',
      desc: '',
      args: [],
    );
  }

  /// `Unknown abnormal`
  String get g_key_error_3 {
    return Intl.message(
      'Unknown abnormal',
      name: 'g_key_error_3',
      desc: '',
      args: [],
    );
  }

  /// `Network connection timed out, please check network settings`
  String get g_key_error_4 {
    return Intl.message(
      'Network connection timed out, please check network settings',
      name: 'g_key_error_4',
      desc: '',
      args: [],
    );
  }

  /// `The server is abnormal, please try again later!`
  String get g_key_error_5 {
    return Intl.message(
      'The server is abnormal, please try again later!',
      name: 'g_key_error_5',
      desc: '',
      args: [],
    );
  }

  /// `Network connection timed out, please check network settings`
  String get g_key_error_6 {
    return Intl.message(
      'Network connection timed out, please check network settings',
      name: 'g_key_error_6',
      desc: '',
      args: [],
    );
  }

  /// `The server is abnormal, please try again later!`
  String get g_key_error_7 {
    return Intl.message(
      'The server is abnormal, please try again later!',
      name: 'g_key_error_7',
      desc: '',
      args: [],
    );
  }

  /// `Request has been cancelled, please request again`
  String get g_key_error_8 {
    return Intl.message(
      'Request has been cancelled, please request again',
      name: 'g_key_error_8',
      desc: '',
      args: [],
    );
  }

  /// `The network is abnormal, please try again later!`
  String get g_key_error_9 {
    return Intl.message(
      'The network is abnormal, please try again later!',
      name: 'g_key_error_9',
      desc: '',
      args: [],
    );
  }

  /// `Dio abnormal`
  String get g_key_error_10 {
    return Intl.message(
      'Dio abnormal',
      name: 'g_key_error_10',
      desc: '',
      args: [],
    );
  }

  /// `Request syntax error`
  String get g_key_error_11 {
    return Intl.message(
      'Request syntax error',
      name: 'g_key_error_11',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorized, please log in`
  String get g_key_error_12 {
    return Intl.message(
      'Unauthorized, please log in',
      name: 'g_key_error_12',
      desc: '',
      args: [],
    );
  }

  /// `Access denied`
  String get g_key_error_13 {
    return Intl.message(
      'Access denied',
      name: 'g_key_error_13',
      desc: '',
      args: [],
    );
  }

  /// `Request error`
  String get g_key_error_14 {
    return Intl.message(
      'Request error',
      name: 'g_key_error_14',
      desc: '',
      args: [],
    );
  }

  /// `Request timed out`
  String get g_key_error_15 {
    return Intl.message(
      'Request timed out',
      name: 'g_key_error_15',
      desc: '',
      args: [],
    );
  }

  /// `Server abnormal`
  String get g_key_error_16 {
    return Intl.message(
      'Server abnormal',
      name: 'g_key_error_16',
      desc: '',
      args: [],
    );
  }

  /// `Service not implemented`
  String get g_key_error_17 {
    return Intl.message(
      'Service not implemented',
      name: 'g_key_error_17',
      desc: '',
      args: [],
    );
  }

  /// `Gateway error`
  String get g_key_error_18 {
    return Intl.message(
      'Gateway error',
      name: 'g_key_error_18',
      desc: '',
      args: [],
    );
  }

  /// `Service is not available`
  String get g_key_error_19 {
    return Intl.message(
      'Service is not available',
      name: 'g_key_error_19',
      desc: '',
      args: [],
    );
  }

  /// `Gateway timeout`
  String get g_key_error_20 {
    return Intl.message(
      'Gateway timeout',
      name: 'g_key_error_20',
      desc: '',
      args: [],
    );
  }

  /// `HTTP version is not supported`
  String get g_key_error_21 {
    return Intl.message(
      'HTTP version is not supported',
      name: 'g_key_error_21',
      desc: '',
      args: [],
    );
  }

  /// `The request failed, error code:`
  String get g_key_error_22 {
    return Intl.message(
      'The request failed, error code:',
      name: 'g_key_error_22',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
