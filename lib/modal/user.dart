import 'package:bot_org_manage/utilities/constants.dart';
import 'dart:core';

import 'package:jiffy/jiffy.dart';

class User {
  int AccessLevelId = 0;
  String? Address = Constants.Empty;
  int AdminId = 0;
  String? City = Constants.Empty;
  int CompanyId = 0;
  String CompanyCode = Constants.Empty;
  String? CompanyName = Constants.Empty;
  DateTime CreatedOn = DateTime.now();
  DateTime? DOB = DateTime.now();
  String? Designation = Constants.Empty;
  String Email = Constants.Empty;
  int EmployeeCurrentRegime = 0;
  int EmployeeId = 0;
  String FirstName = Constants.Empty;
  String LastName = Constants.Empty;
  String? ManagerName = Constants.Empty;
  String? MediaName = Constants.Empty;
  String Mobile = Constants.Empty;
  int OrganizationId = 0;
  String? Password = Constants.Empty;
  int ReportingManagerId = 0;
  int RoleId = 0;
  String? State = Constants.Empty;
  int UserId = 0;
  int UserTypeId = 0;

  static final User instance = User._internal();

  factory User() {
    return instance;
  }

  User._internal();

  User.fromUser(
        this.AccessLevelId,
        this.Address,
        this.AdminId,
        this.City,
        this.CompanyId,
        this.CompanyCode,
        this.CompanyName,
        this.CreatedOn,
        this.DOB,
        this.Designation,
        this.Email,
        this.EmployeeCurrentRegime,
        this.EmployeeId,
        this.FirstName,
        this.LastName,
        this.ManagerName,
        this.MediaName,
        this.Mobile,
        this.OrganizationId,
        this.ReportingManagerId,
        this.RoleId,
        this.State,
        this.UserId,
        this.UserTypeId,
      );

  static DateTime toDateTime(String? date) {
    if (date != null && date != "") {
      return Jiffy(date).dateTime;
    } else {
      return DateTime.now();
    }
  }

  factory User.fromJson(dynamic json) {
    instance.AccessLevelId = json["AccessLevelId"];
    instance.Address = json["Address"];
    instance.AdminId = json["AdminId"];
    instance.City = json["City"];
    instance.CompanyId = json["CompanyId"];
    instance.CompanyCode = json["CompanyCode"];
    instance.CompanyName = json["CompanyName"];
    instance.CreatedOn = toDateTime(json["CreatedOn"]);
    instance.DOB = toDateTime(json["DOB"]);
    instance.Designation = json["Designation"];
    instance.Email = json["EmailId"];
    instance.EmployeeCurrentRegime = json["EmployeeCurrentRegime"];
    instance.EmployeeId = json["UserId"];
    instance.FirstName = json["FirstName"];
    instance.LastName = json["LastName"];
    instance.ManagerName = json["ManagerName"];
    instance.MediaName = json["MediaName"];
    instance.Mobile = json["Mobile"];
    instance.OrganizationId = json["OrganizationId"];
    instance.ReportingManagerId = json["ReportingManagerId"];
    instance.RoleId = json["RoleId"];
    instance.State = json["State"];
    instance.UserId = json["UserId"];
    instance.UserTypeId = json["UserTypeId"];
    return instance;
  }
}