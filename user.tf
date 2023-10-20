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
  members = [azuread_user.IT-1.id, azuread_user.IT-2.id, azuread_user.IT-3.id]
  assignable_to_role = true
}

resource "azuread_group" "AF" {
  display_name = "Administratif"
  security_enabled = true
  members = [azuread_user.AF-4.id, azuread_user.AF-5.id]
}

resource "azuread_directory_role" "GlobalAdmin"{
  display_name = "Global Administrator"
}

resource "azuread_directory_role_assignment" "GlobalAdmin" {
  role_id = azuread_directory_role.GlobalAdmin.template_id
  principal_object_id = azuread_group.IT.id
}

resource "azuread_conditional_access_policy" "AdminAccessPolicy" {
  display_name = "AdminAccessPolicy"
  state        = "enabled"

  conditions {
    client_app_types    = ["all"]
    sign_in_risk_levels = ["high"]
    user_risk_levels    = ["high"]

    applications {
      included_applications = ["all"]
    }

    locations {
      included_locations = ["all"]
    }

    platforms {
      included_platforms = ["all"]
    }

    users {
      included_groups = [azuread_group.IT.id]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["mfa"]
  }
}