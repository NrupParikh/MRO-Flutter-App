import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mro/features/data/data_sources/local/database/mro_database.dart';
import 'package:mro/features/domain/repository/singleton/mro_repository.dart';

import '../../../config/constants/app_constants.dart';
import '../../../config/shared_preferences/singleton/mro_shared_preference.dart';
import '../../data/models/sign_in/sign_in_response.dart';

Future<void> storeLoginResponse(String userName, String schemaId, MroDatabase mroDatabase, MroRepository mroRepository,
    String password, MroSharedPreference pref) async {
  var userNameWithSchemaId = "$userName|$schemaId";
  SignInResponse data = await mroRepository.signIn("$userName|$schemaId", password);
  // Storing [User schema ] Tenant in shared preference
  pref.setString(AppConstants.prefKeyToken, data.token.toString());
  pref.setString(AppConstants.prefKeyLoginResponse, json.encode(data));
  pref.setString(AppConstants.prefKeyUserNameWithSchemaId, userNameWithSchemaId);
  pref.setString(AppConstants.prefKeyPassword, password);

  var isEmployee = data.isEmployee;
  var isApprover = data.isApprover;

  pref.setBool(AppConstants.prefKeyIsEmployee, isEmployee!);
  pref.setBool(AppConstants.prefKeyIsisApprover, isApprover!);

  // Storing employee data in the database
  var employeeData = data.employee;
  if (employeeData != null) {
    // Storing Employee
    var rowsAffected = await mroDatabase.mroDao.insertEmployee(employeeData);
    if (rowsAffected > 0) {
      debugPrint('TAG_Insertion successful for Employee. $rowsAffected rows inserted.');
      // Storing Organizations
      var rowAffectedForOrganizations = await mroDatabase.mroDao.insertAllOrganizations(employeeData.organizations);
      debugPrint('TAG_Insertion successful for Organizations. $rowAffectedForOrganizations rows inserted.');
      if (rowAffectedForOrganizations.isNotEmpty) {
        var apiOrganization = data.employee?.organizations;
        if (apiOrganization!.isNotEmpty) {
          for (var i = 0; i < apiOrganization.length; i++) {
            // Storing Attributes
            var rowAffectedForAttributes = await mroDatabase.mroDao.insertAllAttributes(apiOrganization[i].attributes);
            debugPrint('TAG_Insertion successful for Attributes. $rowAffectedForAttributes rows inserted.');

            // Storing Accounts
            var rowAffectedForAccounts = await mroDatabase.mroDao.insertAllAccounts(apiOrganization[i].accounts);
            debugPrint('TAG_Insertion successful for Accounts. $rowAffectedForAccounts rows inserted.');

            if (rowAffectedForAccounts.isNotEmpty) {
              var apiAccounts = apiOrganization[i].accounts;
              if (apiAccounts.isNotEmpty) {
                for (var j = 0; j < apiAccounts.length; j++) {
                  // Storing Account's Fields
                  var rowAffectedForFields = await mroDatabase.mroDao.insertAllFields(apiAccounts[j].fields);
                  debugPrint('TAG_Insertion successful for Fields. $rowAffectedForFields rows inserted.');
                }
              }
            }

            // Storing Parent
            if (apiOrganization[i].parent != null) {
              var rowAffectedForParent = await mroDatabase.mroDao.insertParent(apiOrganization[i].parent!);
              debugPrint('TAG_Insertion successful for Parent. $rowAffectedForParent rows inserted.');
            }

            // Storing Organization Type
            if (apiOrganization[i].organizationType != null) {
              var rowAffectedForParent = await mroDatabase.mroDao.insertOrganizationType(apiOrganization[i].organizationType!);
              debugPrint('TAG_Insertion successful for Organization Type. $rowAffectedForParent rows inserted.');
            }
          }
        }
      }
    } else {
      debugPrint('TAG_Insertion failed for Employee.');
    }
  }
}
