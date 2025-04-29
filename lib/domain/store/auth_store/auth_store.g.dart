// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on AuthStoreBase, Store {
  late final _$currentUserAtom =
      Atom(name: 'AuthStoreBase.currentUser', context: context);

  @override
  User? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: 'AuthStoreBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'AuthStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isLoggedInAtom =
      Atom(name: 'AuthStoreBase.isLoggedIn', context: context);

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$verificationIdAtom =
      Atom(name: 'AuthStoreBase.verificationId', context: context);

  @override
  String? get verificationId {
    _$verificationIdAtom.reportRead();
    return super.verificationId;
  }

  @override
  set verificationId(String? value) {
    _$verificationIdAtom.reportWrite(value, super.verificationId, () {
      super.verificationId = value;
    });
  }

  late final _$phoneNumberAtom =
      Atom(name: 'AuthStoreBase.phoneNumber', context: context);

  @override
  String? get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String? value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  late final _$isCodeSentAtom =
      Atom(name: 'AuthStoreBase.isCodeSent', context: context);

  @override
  bool get isCodeSent {
    _$isCodeSentAtom.reportRead();
    return super.isCodeSent;
  }

  @override
  set isCodeSent(bool value) {
    _$isCodeSentAtom.reportWrite(value, super.isCodeSent, () {
      super.isCodeSent = value;
    });
  }

  late final _$isWaitingForSmsAtom =
      Atom(name: 'AuthStoreBase.isWaitingForSms', context: context);

  @override
  bool get isWaitingForSms {
    _$isWaitingForSmsAtom.reportRead();
    return super.isWaitingForSms;
  }

  @override
  set isWaitingForSms(bool value) {
    _$isWaitingForSmsAtom.reportWrite(value, super.isWaitingForSms, () {
      super.isWaitingForSms = value;
    });
  }

  late final _$sendOTPAsyncAction =
      AsyncAction('AuthStoreBase.sendOTP', context: context);

  @override
  Future<void> sendOTP() {
    return _$sendOTPAsyncAction.run(() => super.sendOTP());
  }

  late final _$verifyOTPAsyncAction =
      AsyncAction('AuthStoreBase.verifyOTP', context: context);

  @override
  Future<void> verifyOTP(String smsCode) {
    return _$verifyOTPAsyncAction.run(() => super.verifyOTP(smsCode));
  }

  late final _$signUpWithEmailAsyncAction =
      AsyncAction('AuthStoreBase.signUpWithEmail', context: context);

  @override
  Future<void> signUpWithEmail(String email, String password) {
    return _$signUpWithEmailAsyncAction
        .run(() => super.signUpWithEmail(email, password));
  }

  late final _$signInWithEmailAsyncAction =
      AsyncAction('AuthStoreBase.signInWithEmail', context: context);

  @override
  Future<void> signInWithEmail(String email, String password) {
    return _$signInWithEmailAsyncAction
        .run(() => super.signInWithEmail(email, password));
  }

  late final _$resetPasswordAsyncAction =
      AsyncAction('AuthStoreBase.resetPassword', context: context);

  @override
  Future<void> resetPassword(String email) {
    return _$resetPasswordAsyncAction.run(() => super.resetPassword(email));
  }

  late final _$resetReCapPasswordAsyncAction =
      AsyncAction('AuthStoreBase.resetReCapPassword', context: context);

  @override
  Future<void> resetReCapPassword(String email) {
    return _$resetReCapPasswordAsyncAction
        .run(() => super.resetReCapPassword(email));
  }

  late final _$signOutAsyncAction =
      AsyncAction('AuthStoreBase.signOut', context: context);

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  late final _$signInWithGoogleAsyncAction =
      AsyncAction('AuthStoreBase.signInWithGoogle', context: context);

  @override
  Future<bool> signInWithGoogle() {
    return _$signInWithGoogleAsyncAction.run(() => super.signInWithGoogle());
  }

  late final _$saveInitialUserDataAsyncAction =
      AsyncAction('AuthStoreBase.saveInitialUserData', context: context);

  @override
  Future<void> saveInitialUserData(UserModel user) {
    return _$saveInitialUserDataAsyncAction
        .run(() => super.saveInitialUserData(user));
  }

  late final _$updateUserDataAsyncAction =
      AsyncAction('AuthStoreBase.updateUserData', context: context);

  @override
  Future<void> updateUserData(String userId, Map<String, dynamic> updates) {
    return _$updateUserDataAsyncAction
        .run(() => super.updateUserData(userId, updates));
  }

  late final _$savePhoneNumberAsyncAction =
      AsyncAction('AuthStoreBase.savePhoneNumber', context: context);

  @override
  Future<void> savePhoneNumber(String userId, String phoneNumber) {
    return _$savePhoneNumberAsyncAction
        .run(() => super.savePhoneNumber(userId, phoneNumber));
  }

  late final _$updateUserProfileAsyncAction =
      AsyncAction('AuthStoreBase.updateUserProfile', context: context);

  @override
  Future<void> updateUserProfile(Map<String, dynamic> updates) {
    return _$updateUserProfileAsyncAction
        .run(() => super.updateUserProfile(updates));
  }

  late final _$saveUserPhoneNumberAsyncAction =
      AsyncAction('AuthStoreBase.saveUserPhoneNumber', context: context);

  @override
  Future<void> saveUserPhoneNumber(String phoneNumber) {
    return _$saveUserPhoneNumberAsyncAction
        .run(() => super.saveUserPhoneNumber(phoneNumber));
  }

  late final _$AuthStoreBaseActionController =
      ActionController(name: 'AuthStoreBase', context: context);

  @override
  void setPhoneNumber(String value) {
    final _$actionInfo = _$AuthStoreBaseActionController.startAction(
        name: 'AuthStoreBase.setPhoneNumber',);
    try {
      return super.setPhoneNumber(value);
    } finally {
      _$AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool isPhoneNumberValid(String number) {
    final _$actionInfo = _$AuthStoreBaseActionController.startAction(
        name: 'AuthStoreBase.isPhoneNumberValid',);
    try {
      return super.isPhoneNumberValid(number);
    } finally {
      _$AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearErrorMessageAfterDelay() {
    final _$actionInfo = _$AuthStoreBaseActionController.startAction(
        name: 'AuthStoreBase.clearErrorMessageAfterDelay',);
    try {
      return super.clearErrorMessageAfterDelay();
    } finally {
      _$AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser},
errorMessage: ${errorMessage},
isLoading: ${isLoading},
isLoggedIn: ${isLoggedIn},
verificationId: ${verificationId},
phoneNumber: ${phoneNumber},
isCodeSent: ${isCodeSent},
isWaitingForSms: ${isWaitingForSms}
    ''';
  }
}
