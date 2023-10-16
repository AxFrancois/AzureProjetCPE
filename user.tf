resource "azuread_user" "IT-1" {
  user_principal_name = "jean.cive@AxFrancoiscpe.onmicrosoft.com"
  display_name        = "Jean Cive"
  mail_nickname       = "jean.cive"
  password            = "SecretP@sswd99!"
  company_name        = "CPE"
  department          = "IT"
}

resource "azuread_user" "IT-2" {
  user_principal_name = "sarah.croche@AxFrancoiscpe.onmicrosoft.com"
  display_name        = "Sarah Croche"
  mail_nickname       = "sara.croche"
  password            = "SecretP@sswd99!"
  company_name        = "CPE"
  department          = "IT"
}

resource "azuread_user" "IT-3" {
  user_principal_name = "hubert.bonisseur-delabath@AxFrancoiscpe.onmicrosoft.com"
  display_name        = "Hubert Bonisseur-Delabath"
  mail_nickname       = "hubert.bonisseur-delabath"
  password            = "SecretP@sswd99!"
  company_name        = "CPE"
  department          = "IT"
}

resource "azuread_user" "AF-4" {
  user_principal_name = "barack.afritt@AxFrancoiscpe.onmicrosoft.com"
  display_name        = "Barack Afritt"
  mail_nickname       = "barack.afritt"
  password            = "SecretP@sswd99!"
  company_name        = "CPE"
  department          = "Administratif"
}

resource "azuread_user" "AF-5" {
  user_principal_name = "annie-zette.auffray@AxFrancoiscpe.onmicrosoft.com"
  display_name        = "Annie-Zette Auffray"
  mail_nickname       = "annie-zette.auffray"
  password            = "SecretP@sswd99!"
  company_name        = "CPE"
  department          = "Administratif"
}

resource "azuread_group" "IT" {
  display_name = "IT"
  security_enabled = true
}

resource "azuread_group" "AF" {
  display_name = "Administratif"
  security_enabled = true
}

resource "azuread_group_member" "IT" {
  group_object_id = azuread_group.IT.id
  member_object_id = [azuread_user.IT-1.id, azuread_user.IT-2.id, azuread_user.IT-3.id]
}

resource "azuread_group_member" "AF" {
  group_object_id = azuread_group.AF.id
  member_object_id = [azuread_user.AF-4.id, azuread_user.AF-5.id]
}

resource "azuread_administrative_unit" "Admin_unit" {
  display_name = "Admin_unit"
}

resource "azuread_directory_role" "Admin" {
  display_name = "Administrator"
}

resource "azuread_administrative_unit_role_member" "Administrator" {
  role_object_id = azuread_directory_role.Admin.object_id
  administrative_unit_object_id = azuread_administrative_unit.Admin_unit.id
  member_object_id = [azuread_user.IT-1.id, azuread_user.IT-2.id, azuread_user.IT-3.id]
}