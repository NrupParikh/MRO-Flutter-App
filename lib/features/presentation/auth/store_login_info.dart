import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mro/features/data/data_sources/local/database/mro_database.dart';
import 'package:mro/features/data/models/sign_in/accounts.dart';
import 'package:mro/features/data/models/sign_in/attributes.dart';
import 'package:mro/features/data/models/sign_in/employee.dart';
import 'package:mro/features/data/models/sign_in/fields.dart';
import 'package:mro/features/data/models/sign_in/organization_type.dart';
import 'package:mro/features/data/models/sign_in/organizations.dart';
import 'package:mro/features/data/models/sign_in/parent.dart';
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

  var employeeData = data.employee;
  await doDatabaseEntry(employeeData, mroDatabase);
}

Future<void> doDatabaseEntry(Employee? employeeData, MroDatabase mroDatabase) async {
  if (employeeData != null) {
    // ====================== STORE EMPLOYEE DATA
    var rowsAffected = await mroDatabase.mroDao.insertEmployee(employeeData);
    if (rowsAffected > 0) {
      debugPrint('TAG_Insertion successful for Employee. $rowsAffected rows inserted.');

      // ====================== STORE ORGANIZATION DATA
      if (employeeData.organizations.isNotEmpty) {
        for (var i = 0; i < employeeData.organizations.length; i++) {
          var organizationData = employeeData.organizations[i];
          var rowAffectedForOrganizations = await mroDatabase.mroDao.insertOrganization(Organizations(
              id: organizationData.id,
              employeeId: employeeData.id,
              version: organizationData.version,
              name: organizationData.name,
              externalIdentifier: organizationData.externalIdentifier,
              attributes: organizationData.attributes,
              abbreviation: organizationData.abbreviation,
              shortDescription: organizationData.shortDescription,
              parent: organizationData.parent,
              organizationType: organizationData.organizationType,
              active: organizationData.active,
              accounts: organizationData.accounts,
              activatePrimaryVAT: organizationData.activatePrimaryVAT,
              activateSecondaryVAT: organizationData.activateSecondaryVAT,
              substituteSubValue: organizationData.substituteSubValue));

          debugPrint('TAG_Insertion successful for Organizations. $rowAffectedForOrganizations rows inserted.');

          if (rowAffectedForOrganizations > 0) {
            // ====================== STORE ATTRIBUTES DATA

            var attributes = organizationData.attributes;
            if (attributes.isNotEmpty) {
              for (var j = 0; j < attributes.length; j++) {
                var attributesData = attributes[j];
                var rowAffectedForAttributes = await mroDatabase.mroDao.insertAttributes(Attributes(
                  id: attributesData.id,
                  organizationId: organizationData.id,
                  version: attributesData.version,
                  value: attributesData.value,
                  name: attributesData.name,
                ));
                debugPrint('TAG_Insertion successful for Attributes. $rowAffectedForAttributes rows inserted.');
              }
            }

            // ====================== STORE ACCOUNTS DATA

            var accounts = organizationData.accounts;
            if (accounts.isNotEmpty) {
              for (var k = 0; k < accounts.length; k++) {
                var accountsData = accounts[k];
                var rowAffectedForAccounts = await mroDatabase.mroDao.insertAccounts(Accounts(
                  id: accountsData.id,
                  organizationId: organizationData.id,
                  version: accountsData.version,
                  name: accountsData.name,
                  active: accountsData.active,
                  div: accountsData.div,
                  dept: accountsData.dept,
                  account: accountsData.account,
                  sub: accountsData.sub,
                  receiptVerifyRequired: accountsData.receiptVerifyRequired,
                  receiptUploadRequired: accountsData.receiptUploadRequired,
                  fields: accountsData.fields,
                ));

                debugPrint('TAG_Insertion successful for Accounts. $rowAffectedForAccounts rows inserted.');

                if (rowAffectedForAccounts > 0) {
                  // ====================== STORE ACCOUNTS FIELD DATA

                  var fields = accountsData.fields;
                  if (fields.isNotEmpty) {
                    for (var l = 0; l < fields.length; l++) {
                      var fieldsData = fields[l];
                      var rowAffectedForAccountsField = await mroDatabase.mroDao.insertAccountsFields(Fields(
                          id: fieldsData.id,
                          accountsId: accountsData.id,
                          version: fieldsData.version,
                          label: fieldsData.label,
                          required: fieldsData.required,
                          sequence: fieldsData.sequence,
                          uppercase: fieldsData.uppercase,
                          maxLength: fieldsData.maxLength));

                      debugPrint('TAG_Insertion successful for Accounts Fields. $rowAffectedForAccountsField rows inserted.');
                    }
                  }
                }
              }
            }

            // ====================== STORE PARENTS DATA
            var parents = organizationData.parent;
            if (parents != null) {
              var rowAffectedForParent = await mroDatabase.mroDao.insertParents(Parent(
                  id: parents.id,
                  organizationId: organizationData.id,
                  version: parents.version,
                  name: parents.name,
                  externalIdentifier: parents.externalIdentifier,
                  abbreviation: parents.abbreviation,
                  shortDescription: parents.shortDescription,
                  active: parents.active,
                  activatePrimaryVAT: parents.activatePrimaryVAT,
                  activateSecondaryVAT: parents.activateSecondaryVAT,
                  substituteSubValue: parents.substituteSubValue));

              debugPrint('TAG_Insertion successful for Parent Fields. $rowAffectedForParent rows inserted.');
            }

            // ====================== STORE ORGANIZATION TYPE DATA
            var organizationType = organizationData.organizationType;
            if (organizationType != null) {
              var rowAffectedForOrganizationType = await mroDatabase.mroDao.insertOrganizationType(OrganizationType(
                  id: organizationType.id,
                  organizationId: organizationData.id,
                  code: organizationType.code,
                  name: organizationType.name));

              debugPrint('TAG_Insertion successful for OrganizationType Fields. $rowAffectedForOrganizationType rows inserted.');
            }
          }
        }
      }
    } else {
      debugPrint('TAG_Insertion failed for Employee.');
    }
  }
}
