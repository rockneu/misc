:: This script is used to create AD user
:: Dependency: need to follow the data format in file L2-account.csv

for /f "tokens=1,2,3,4,5 delims=," %a in (L2-account.csv) do dsadd user "CN=%a, OU=π≤œÌ” œ‰,DC=szgdjt,DC=local" -display %a  -desc %e -email %b -samid %c -upn %b -pwd %d -disabled yes
pause