@ECHO OFF

SETLOCAL

:: Set target OU and security principal
SET OU=CN=Computers,DC=prometheus,DC=corp
SET SP="PROMETHEUS\Domain Join"

:: Grant permissions to Add and Delete computer objects
dsacls %OU% /G %SP%:CC;computer;
dsacls %OU% /G %SP%:DC;computer;

:: Grant permissions to join computers to the domain
dsacls %OU% /I:S /G %SP%:CALCGRSDDTRC;;computer
dsacls %OU% /I:S /G %SP%:WP;description;computer
dsacls %OU% /I:S /G %SP%:WP;sAMAccountName;computer
dsacls %OU% /I:S /G %SP%:WP;displayName;computer
dsacls %OU% /I:S /G %SP%:WP;userAccountControl;computer
dsacls %OU% /I:S /G %SP%:WS;"Validated write to service principal name";computer
dsacls %OU% /I:S /G %SP%:WS;"Validated write to DNS host name";computer

ENDLOCAL
