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