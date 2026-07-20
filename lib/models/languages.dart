import 'dart:convert';
import '../preferences/shared_pref.dart';

Languages languagesFromJson(String str) => Languages.fromJson(json.decode(str));

String languagesToJson(Languages data) => json.encode(data.toJson());

class Languages {
  Languages({
    required this.locker,
  });

  final Locker locker;

  factory Languages.fromJson(Map<String, dynamic> json) => Languages(
        locker: Locker.fromJson(json["Locker"]),
      );

  Map<String, dynamic> toJson() => {
        "Locker": locker.toJson(),
      };
}

class Locker {
  Locker({
    required this.allLanguages,
  });

  final AllLanguages allLanguages;

  factory Locker.fromJson(Map<String, dynamic> json) => Locker(
        allLanguages: AllLanguages.fromJson(json[LocalData.getLanguage]),
      );

  Map<String, dynamic> toJson() => {
        "English": allLanguages.toJson(),
      };
}

class AllLanguages {
  AllLanguages(
      {required this.enterCodelockToChangeCodelock,
      required this.changeCodelock,
      required this.typeDefine,
      required this.addGroupName,
      required this.addNewField,
      required this.addValue,
      required this.addYourPasscode,
      required this.alert,
      required this.applicationLockInterval,
      required this.atLeastOneFieldFill,
      required this.backUp,
      required this.bckUp,
      required this.byResetUWillCurrentDataDoUKnow,
      required this.byResetUWillCurrentDataDoUKnow1,
      required this.byRestoringDataYou,
      required this.cancel,
      required this.confirmPasscode,
      required this.confirmPassword,
      required this.confirmPwdNotMatch,
      required this.createNewAccount,
      required this.data,
      required this.dataHasBeenResetSuccessfully,
      required this.dataHasBeenUploadedSuccessfully,
      required this.dataHasNotBeenResetPlz,
      required this.dataHasNotBeenUploadedSuccessfully,
      required this.dataNotCorrectFormatDataToProceed,
      required this.databaseImportedNotSuccessfully,
      required this.databaseImportedSuccessfully,
      required this.delete,
      required this.done,
      required this.edit,
      required this.editValue,
      required this.enterGroupName,
      required this.eraseYourAllDataAreSqure,
      required this.fieldName,
      required this.groupName,
      required this.masterPassword,
      required this.noDataFound,
      required this.notNow,
      required this.ok,
      required this.or,
      required this.passcode,
      required this.password,
      required this.passwordNotMatch,
      required this.phoneNumberNotValid,
      required this.pleaseEnterValidPassword,
      required this.plzEnter,
      required this.plzEnterConfirmPwd,
      required this.plzEnterFieldName,
      required this.plzEnterPwd,
      required this.plzEnterSeqKeyToDecodeYourData,
      required this.reset,
      required this.resetData,
      required this.restore,
      required this.save,
      required this.saveSubField,
      required this.saveSubValue,
      required this.signIn,
      required this.sorry,
      required this.tapAddBtn,
      required this.thisWillUploadYourSaveDataToYourDrive,
      required this.title,
      required this.unableToLoadFiles,
      required this.yesProceed,
      required this.areYouSureToDelete,
      required this.confirmDelete,
      required this.desclaimer,
      required this.desclaimerText,
      required this.imageSelected,
      required this.selectImageSource,
      required this.accessDenied,
      required this.gotToSettingAllowCamera,
      required this.gotToSettingAllowPhotos,
      required this.changeLanguage,
      required this.languageselection,
      required this.entersomething,
      required this.wrongpassword,
      required this.plzentervalidpwd,
      required this.login_successfully,
      required this.plzenterpasscode,
      required this.passcodelenghthshouldbe4digit,
      required this.Back,
      required this.OldPassword,
      required this.newpassword,
      required this.oldpwdiswrong,
      required this.newpwdisnotmatch,
      required this.oldpasscode,
      required this.newpasscode,
      required this.plzentergroname,
      required this.plzenterfieldname});

  final String enterCodelockToChangeCodelock;
  final String languageselection;
  final String changeCodelock;
  final String typeDefine;
  final String addGroupName;
  final String addNewField;
  final String addValue;
  final String addYourPasscode;
  final String alert;
  final String applicationLockInterval;
  final String atLeastOneFieldFill;
  final String backUp;
  final String bckUp;
  final String byResetUWillCurrentDataDoUKnow;
  final String byResetUWillCurrentDataDoUKnow1;
  final String byRestoringDataYou;
  final String cancel;
  final String confirmPasscode;
  final String confirmPassword;
  final String confirmPwdNotMatch;
  final String createNewAccount;
  final String data;
  final String dataHasBeenResetSuccessfully;
  final String dataHasBeenUploadedSuccessfully;
  final String dataHasNotBeenResetPlz;
  final String dataHasNotBeenUploadedSuccessfully;
  final String dataNotCorrectFormatDataToProceed;
  final String databaseImportedNotSuccessfully;
  final String databaseImportedSuccessfully;
  final String delete;
  final String done;
  final String edit;
  final String editValue;
  final String enterGroupName;
  final String eraseYourAllDataAreSqure;
  final String fieldName;
  final String groupName;
  final String masterPassword;
  final String noDataFound;
  final String notNow;
  final String ok;
  final String or;
  final String passcode;
  final String password;
  final String passwordNotMatch;
  final String phoneNumberNotValid;
  final String pleaseEnterValidPassword;
  final String plzEnter;
  final String plzEnterConfirmPwd;
  final String plzEnterFieldName;
  final String plzEnterPwd;
  final String plzEnterSeqKeyToDecodeYourData;
  final String reset;
  final String resetData;
  final String restore;
  final String save;
  final String saveSubField;
  final String saveSubValue;
  final String signIn;
  final String sorry;
  final String tapAddBtn;
  final String thisWillUploadYourSaveDataToYourDrive;
  final String title;
  final String unableToLoadFiles;
  final String yesProceed;
  final String areYouSureToDelete;
  final String confirmDelete;
  final String desclaimer;
  final String desclaimerText;
  final String imageSelected;
  final String selectImageSource;
  final String accessDenied;
  final String gotToSettingAllowCamera;
  final String gotToSettingAllowPhotos;
  final String changeLanguage;
  //final String codelock;
  final String entersomething;
  final String wrongpassword;
  final String plzentervalidpwd;
  final String login_successfully;
  final String plzenterpasscode;
  final String passcodelenghthshouldbe4digit;
  final String Back;
  final String OldPassword;
  final String newpassword;
  final String oldpwdiswrong;
  final String newpwdisnotmatch;
  final String oldpasscode;
  final String newpasscode;
  final String plzentergroname;
  final String plzenterfieldname;

  // final String abc;

  factory AllLanguages.fromJson(Map<String, dynamic> json) => AllLanguages(
        enterCodelockToChangeCodelock:
            json["enter_codelock_to_change_codelock"],
        changeCodelock: json["change_codelock"],
        typeDefine: json["Type_define"],
        addGroupName: json["add_group_name"],
        addNewField: json["add_new_field"],
        addValue: json["add_value"],
        addYourPasscode: json["add_your_passcode"],
        alert: json["alert"],
        applicationLockInterval: json["application_lock_interval"],
        atLeastOneFieldFill: json["at_least_one_field_fill"],
        backUp: json["back_up"],
        bckUp: json["bck_up"],
        byResetUWillCurrentDataDoUKnow:
            json["by_reset_u_will_Current_data_do_u_know"].toString(),
        byResetUWillCurrentDataDoUKnow1:
            json["by_reset_u_will_Current_data_do_u_know1"],
        byRestoringDataYou: json["by_restoring_data_you"],
        cancel: json["cancel"],
        confirmPasscode: json["confirm_passcode"],
        confirmPassword: json["confirm_password"],
        confirmPwdNotMatch: json["confirm_pwd_not_match"],
        createNewAccount: json["create_new_account"],
        data: json["data"],
        dataHasBeenResetSuccessfully: json["data_has_been_reset_successfully"],
        dataHasBeenUploadedSuccessfully:
            json["data_has_been_uploaded_successfully"],
        dataHasNotBeenResetPlz: json["data_has_not_been_reset_plz"],
        dataHasNotBeenUploadedSuccessfully:
            json["data_has_not_been_uploaded_successfully"],
        dataNotCorrectFormatDataToProceed:
            json["data_not_correct_format_data_to_proceed"],
        databaseImportedNotSuccessfully:
            json["database_imported_not_successfully"],
        databaseImportedSuccessfully: json["database_imported_successfully"],
        delete: json["delete"],
        done: json["done"],
        edit: json["edit"],
        editValue: json["edit_value"],
        enterGroupName: json["enter_group_name"],
        eraseYourAllDataAreSqure:
            json["erase_your_All_data_are_squre"].toString(),
        fieldName: json["field_name"],
        groupName: json["group_name"],
        masterPassword: json["master_password"],
        noDataFound: json["no_data_found"],
        notNow: json["not_now"],
        ok: json["ok"],
        or: json["or"],
        passcode: json["passcode"],
        password: json["password"],
        passwordNotMatch: json["password_not_match"],
        phoneNumberNotValid: json["phone_number_not_valid"],
        pleaseEnterValidPassword: json["please_enter_valid_password"],
        plzEnter: json["plz_enter"],
        plzEnterConfirmPwd: json["plz_enter_confirm_pwd"],
        plzEnterFieldName: json["plz_enter_field_name"],
        plzEnterPwd: json["plz_enter_pwd"],
        plzEnterSeqKeyToDecodeYourData:
            json["plz_enter_seq_key_to_decode_your_data"],
        reset: json["reset"],
        resetData: json["reset_data"],
        restore: json["restore"],
        save: json["save"],
        saveSubField: json["save_sub_field"],
        saveSubValue: json["save_sub_value"],
        signIn: json["sign_in"],
        sorry: json["sorry_"],
        tapAddBtn: json["tap_add_btn"],
        thisWillUploadYourSaveDataToYourDrive:
            json["this_will_upload_your_save_data_to_your_drive"],
        title: json["title"],
        unableToLoadFiles: json["unable_to_load_files"],
        yesProceed: json["yes_proceed"],
        areYouSureToDelete: json["are_you_sure_to_delete"],
        confirmDelete: json["confirm_delete"],
        desclaimer: json["desclaimer"],
        desclaimerText: json["desclaimer_text"],
        imageSelected: json["image_selected"],
        selectImageSource: json["select_image_source"],
        accessDenied: json["access_denied"],
        gotToSettingAllowCamera: json["got_to_setting_allow_camera"],
        gotToSettingAllowPhotos: json["got_to_setting_allow_photos"],
        changeLanguage: json["change_language"],
        languageselection: json["languageselection"] ?? "",
        entersomething: json["entersomething"] ?? "",
        wrongpassword: json["wrongpassword"] ?? "",
        plzentervalidpwd: json["plzentervalidpwd"] ?? "",
        login_successfully: json["login_successfully"] ?? "",
        plzenterpasscode: json["plzenterpasscode"],
        passcodelenghthshouldbe4digit:
            json["passcodelenghthshouldbe4digit"] ?? "",
        Back: json["< Back"] ?? "",
        OldPassword: json["OldPassword"] ?? "",
        newpassword: json["newpassword"],
        oldpwdiswrong: json["oldpwdiswrong"],
        newpwdisnotmatch: json["newpwdisnotmatch"] ?? "",
        oldpasscode: json["oldpasscode"] ?? "",
        newpasscode: json["newpasscode"] ?? "",
        plzentergroname: json["plzentergroname"] ?? "",
        plzenterfieldname: json["plzenterfieldname"] ?? "",

        // languageselection: 'Language Selection', codelock: 'CodeLock', entersomething: 'Enter Something', wrongpassword: 'Wrong password', abc: json["ABC-XYZ"],
      );

  Map<String, dynamic> toJson() => {
        "enter_codelock_to_change_codelock": enterCodelockToChangeCodelock,
        "change_codelock": changeCodelock,
        "Type_define": typeDefine,
        "add_group_name": addGroupName,
        "add_new_field": addNewField,
        "add_value": addValue,
        "add_your_passcode": addYourPasscode,
        "alert": alert,
        "application_lock_interval": applicationLockInterval,
        "at_least_one_field_fill": atLeastOneFieldFill,
        "back_up": backUp,
        "bck_up": bckUp,
        "by_reset_u_will_Current_data_do_u_know":
            byResetUWillCurrentDataDoUKnow,
        "by_reset_u_will_Current_data_do_u_know1":
            byResetUWillCurrentDataDoUKnow1,
        "by_restoring_data_you": byRestoringDataYou,
        "cancel": cancel,
        "confirm_passcode": confirmPasscode,
        "confirm_password": confirmPassword,
        "confirm_pwd_not_match": confirmPwdNotMatch,
        "create_new_account": createNewAccount,
        "data": data,
        "data_has_been_reset_successfully": dataHasBeenResetSuccessfully,
        "data_has_been_uploaded_successfully": dataHasBeenUploadedSuccessfully,
        "data_has_not_been_reset_plz": dataHasNotBeenResetPlz,
        "data_has_not_been_uploaded_successfully":
            dataHasNotBeenUploadedSuccessfully,
        "data_not_correct_format_data_to_proceed":
            dataNotCorrectFormatDataToProceed,
        "database_imported_not_successfully": databaseImportedNotSuccessfully,
        "database_imported_successfully": databaseImportedSuccessfully,
        "delete": delete,
        "done": done,
        "edit": edit,
        "edit_value": editValue,
        "enter_group_name": enterGroupName,
        "erase_your_All_data_are_squre": eraseYourAllDataAreSqure,
        "field_name": fieldName,
        "group_name": groupName,
        "master_password": masterPassword,
        "no_data_found": noDataFound,
        "not_now": notNow,
        "ok": ok,
        "or": or,
        "passcode": passcode,
        "password": password,
        "password_not_match": passwordNotMatch,
        "phone_number_not_valid": phoneNumberNotValid,
        "please_enter_valid_password": pleaseEnterValidPassword,
        "plz_enter": plzEnter,
        "plz_enter_confirm_pwd": plzEnterConfirmPwd,
        "plz_enter_field_name": plzEnterFieldName,
        "plz_enter_pwd": plzEnterPwd,
        "plz_enter_seq_key_to_decode_your_data": plzEnterSeqKeyToDecodeYourData,
        "reset": reset,
        "reset_data": resetData,
        "restore": restore,
        "save": save,
        "save_sub_field": saveSubField,
        "save_sub_value": saveSubValue,
        "sign_in": signIn,
        "sorry_": sorry,
        "tap_add_btn": tapAddBtn,
        "this_will_upload_your_save_data_to_your_drive":
            thisWillUploadYourSaveDataToYourDrive,
        "title": title,
        "unable_to_load_files": unableToLoadFiles,
        "yes_proceed": yesProceed,
        "are_you_sure_to_delete": areYouSureToDelete,
        "confirm_delete": confirmDelete,
        "desclaimer": desclaimer,
        "desclaimer_text": desclaimerText,
        "image_selected": imageSelected,
        "select_image_source": selectImageSource,
        "access_denied": accessDenied,
        "got_to_setting_allow_camera": gotToSettingAllowCamera,
        "got_to_setting_allow_photos": gotToSettingAllowPhotos,
        "change_language": changeLanguage,
        "Language selection": languageselection,
        "Enter Something": entersomething,
        "Wrong passcode": wrongpassword,
        "Please Enter Password": plzentervalidpwd,
        "Login successfully": login_successfully,
        "Playas entre Passascode": plzenterpasscode,
        "Passcode Length should be 4 digit.": passcodelenghthshouldbe4digit,
        "< Back": Back,
        "Old Password": OldPassword,
        " New Password": newpassword,
        "Old password is  Wrong": oldpwdiswrong,
        "New password is Not Match": newpwdisnotmatch,
        "Old Passcode": oldpasscode,
        "New Passcode": newpasscode,
        "Please Enter Group Name": plzentergroname,
        "Please Enter Field Name": plzenterfieldname,
      };
}
