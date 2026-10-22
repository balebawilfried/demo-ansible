# On importe le module Active Directory
Import-Module ActiveDirectory

# On utilise le module Import-csv sur notre calc pour en faire une variable
$CalcAD = Import-csv -Delimiter ";" -Path C:\Users\Administrator\Downloads\usersdatabase.csv

# Boucle foreach 
foreach ($User in $CalcAD)
{
       $Username    = $User.Username
       $Password    = $User.Password
       $firstname      = $User.Firstname
       $lastname         = $User.Lastname
       $OU      = $User.OU
       $initials = $User.Initials
       $email = $User.Email
       $country = $User.Country
       $departement = $User.Departement
       $city = $User.City
       $telephone = $User.Telephone
       $streetaddress = $User.Streetaddress
       $zipcode = $User.Zipcode
       $state = $User.State
       $jobtitle = $User.Jobtitle
       $company = $User.Company  


       # On vérifie si l'utilisateur n'existe pas déjà dans le domaine
       if (Get-ADUser -F {SamAccountName -eq $Username}) {

           # On affiche un message sous forme de Warning
           Write-Warning "Oops, on dirait que $Username est déjà présent dans l'AD..."
       }
       else {

              # Sinon on créer l'utilisateur. Bien prendre soin de modifier le nom de domaine 
              # ici avant d'exécuter le script !
              New-ADUser `
                     -SamAccountName $Username `
                     -UserPrincipalName "$Username@balebawilfried.lan" `
                     -Name "$firstname $lastname" `
                     -GivenName $firstname `
                     -Surname $lastname `
                     -Enabled $true `
                     -DisplayName "$lastname, $firstname" `
                     -Path $OU `
                     -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) `
                     -ErrorAction Stop

       }
}
