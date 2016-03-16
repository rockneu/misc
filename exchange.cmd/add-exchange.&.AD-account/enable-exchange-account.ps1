function Addmailbox { 
  Enable-Mailbox ($_.split(","))[1] -Alias ($_.split(","))[2] 
  Set-CasMailbox -MAPIEnabled $false -Identity ($_.split(","))[1]  //取消默认的Exchange MAPI 功能。如果需要，可以删除这句。
}
gc E:\L2-account.csv | foreach {Addmailbox}

echo .
echo .

function Addprint {
echo 你注册的帐户名是: ($_.split(","))[0] 
echo 你注册的邮件地址是: ($_.split(","))[1]
}
