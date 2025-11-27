ü
òC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Utilities\Email\IEmailService.cs
	namespace 	
GuessMyMessServer
 
. 
	Utilities %
.% &
Email& +
{ 
public		 

	interface		 
IEmailService		 "
{

 
Task 
SendEmailAsync 
( 
string "
recipientEmail# 1
,1 2
string3 9
recipientName: G
,G H
IEmailTemplateI W
templateX `
)` a
;a b
} 
} ãS
ñC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Services\UserProfileService.cs
	namespace 	
GuessMyMessServer
 
. 
Services $
{ 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?
PerCall? F
)F G
]G H
public 

class 
UserProfileService #
:$ %
IUserProfileService& 9
{ 
public 
UserProfileService !
(! "
)" #
{ 	
} 	
public 
async 
Task 
< 
UserProfileDto (
>( )
GetUserProfileAsync* =
(= >
string> D
usernameE M
)M N
{ 	
try 
{ 
using 
( 
var 
context "
=# $
new% (!
GuessMyMessDBEntities) >
(> ?
)? @
)@ A
{ 
var 
emailService $
=% &
new' *
SmtpEmailService+ ;
(; <
)< =
;= >
var 
logic 
= 
new  #
UserProfileLogic$ 4
(4 5
emailService5 A
,A B
contextC J
)J K
;K L
return 
await  
logic! &
.& '
GetUserProfileAsync' :
(: ;
username; C
)C D
;D E
} 
} 
catch   
(   
	Exception   
ex   
)    
{!! 
throw"" 
new"" 
FaultException"" (
(""( )
ex"") +
.""+ ,
Message"", 3
)""3 4
;""4 5
}## 
}$$ 	
public&& 
async&& 
Task&& 
<&& 
OperationResultDto&& ,
>&&, -
UpdateProfileAsync&&. @
(&&@ A
string&&A G
username&&H P
,&&P Q
UserProfileDto&&R `
profileData&&a l
)&&l m
{'' 	
try(( 
{)) 
using** 
(** 
var** 
context** "
=**# $
new**% (!
GuessMyMessDBEntities**) >
(**> ?
)**? @
)**@ A
{++ 
var,, 
emailService,, $
=,,% &
new,,' *
SmtpEmailService,,+ ;
(,,; <
),,< =
;,,= >
var-- 
logic-- 
=-- 
new--  #
UserProfileLogic--$ 4
(--4 5
emailService--5 A
,--A B
context--C J
)--J K
;--K L
return.. 
await..  
logic..! &
...& '
UpdateProfileAsync..' 9
(..9 :
username..: B
,..B C
profileData..D O
)..O P
;..P Q
}// 
}00 
catch11 
(11 
	Exception11 
ex11 
)11  
{22 
throw33 
new33 
FaultException33 (
(33( )
ex33) +
.33+ ,
Message33, 3
)333 4
;334 5
}44 
}55 	
public77 
async77 
Task77 
<77 
OperationResultDto77 ,
>77, -#
RequestChangeEmailAsync77. E
(77E F
string77F L
username77M U
,77U V
string77W ]
newEmail77^ f
)77f g
{88 	
try99 
{:: 
using;; 
(;; 
var;; 
context;; "
=;;# $
new;;% (!
GuessMyMessDBEntities;;) >
(;;> ?
);;? @
);;@ A
{<< 
var== 
emailService== $
===% &
new==' *
SmtpEmailService==+ ;
(==; <
)==< =
;=== >
var>> 
logic>> 
=>> 
new>>  #
UserProfileLogic>>$ 4
(>>4 5
emailService>>5 A
,>>A B
context>>C J
)>>J K
;>>K L
return?? 
await??  
logic??! &
.??& '#
RequestChangeEmailAsync??' >
(??> ?
username??? G
,??G H
newEmail??I Q
)??Q R
;??R S
}@@ 
}AA 
catchBB 
(BB 
	ExceptionBB 
exBB 
)BB  
{CC 
throwDD 
newDD 
FaultExceptionDD (
(DD( )
exDD) +
.DD+ ,
MessageDD, 3
)DD3 4
;DD4 5
}EE 
}FF 	
publicHH 
asyncHH 
TaskHH 
<HH 
OperationResultDtoHH ,
>HH, -#
ConfirmChangeEmailAsyncHH. E
(HHE F
stringHHF L
usernameHHM U
,HHU V
stringHHW ]
verificationCodeHH^ n
)HHn o
{II 	
tryJJ 
{KK 
usingLL 
(LL 
varLL 
contextLL "
=LL# $
newLL% (!
GuessMyMessDBEntitiesLL) >
(LL> ?
)LL? @
)LL@ A
{MM 
varNN 
emailServiceNN $
=NN% &
newNN' *
SmtpEmailServiceNN+ ;
(NN; <
)NN< =
;NN= >
varOO 
logicOO 
=OO 
newOO  #
UserProfileLogicOO$ 4
(OO4 5
emailServiceOO5 A
,OOA B
contextOOC J
)OOJ K
;OOK L
returnPP 
awaitPP  
logicPP! &
.PP& '#
ConfirmChangeEmailAsyncPP' >
(PP> ?
usernamePP? G
,PPG H
verificationCodePPI Y
)PPY Z
;PPZ [
}QQ 
}RR 
catchSS 
(SS 
	ExceptionSS 
exSS 
)SS  
{TT 
throwUU 
newUU 
FaultExceptionUU (
(UU( )
exUU) +
.UU+ ,
MessageUU, 3
)UU3 4
;UU4 5
}VV 
}WW 	
publicYY 
asyncYY 
TaskYY 
<YY 
OperationResultDtoYY ,
>YY, -&
RequestChangePasswordAsyncYY. H
(YYH I
stringYYI O
usernameYYP X
)YYX Y
{ZZ 	
try[[ 
{\\ 
using]] 
(]] 
var]] 
context]] "
=]]# $
new]]% (!
GuessMyMessDBEntities]]) >
(]]> ?
)]]? @
)]]@ A
{^^ 
var__ 
emailService__ $
=__% &
new__' *
SmtpEmailService__+ ;
(__; <
)__< =
;__= >
var`` 
logic`` 
=`` 
new``  #
UserProfileLogic``$ 4
(``4 5
emailService``5 A
,``A B
context``C J
)``J K
;``K L
returnaa 
awaitaa  
logicaa! &
.aa& '&
RequestChangePasswordAsyncaa' A
(aaA B
usernameaaB J
)aaJ K
;aaK L
}bb 
}cc 
catchdd 
(dd 
	Exceptiondd 
exdd 
)dd  
{ee 
throwff 
newff 
FaultExceptionff (
(ff( )
exff) +
.ff+ ,
Messageff, 3
)ff3 4
;ff4 5
}gg 
}hh 	
publicjj 
asyncjj 
Taskjj 
<jj 
OperationResultDtojj ,
>jj, -&
ConfirmChangePasswordAsyncjj. H
(jjH I
stringjjI O
usernamejjP X
,jjX Y
stringjjZ `
newPasswordjja l
,jjl m
stringjjn t
verificationCode	jju Ö
)
jjÖ Ü
{kk 	
tryll 
{mm 
usingnn 
(nn 
varnn 
contextnn "
=nn# $
newnn% (!
GuessMyMessDBEntitiesnn) >
(nn> ?
)nn? @
)nn@ A
{oo 
varpp 
emailServicepp $
=pp% &
newpp' *
SmtpEmailServicepp+ ;
(pp; <
)pp< =
;pp= >
varqq 
logicqq 
=qq 
newqq  #
UserProfileLogicqq$ 4
(qq4 5
emailServiceqq5 A
,qqA B
contextqqC J
)qqJ K
;qqK L
returnrr 
awaitrr  
logicrr! &
.rr& '&
ConfirmChangePasswordAsyncrr' A
(rrA B
usernamerrB J
,rrJ K
newPasswordrrL W
,rrW X
verificationCoderrY i
)rri j
;rrj k
}ss 
}tt 
catchuu 
(uu 
	Exceptionuu 
exuu 
)uu  
{vv 
throwww 
newww 
FaultExceptionww (
(ww( )
exww) +
.ww+ ,
Messageww, 3
)ww3 4
;ww4 5
}xx 
}yy 	
public{{ 
async{{ 
Task{{ 
<{{ 
List{{ 
<{{ 
	AvatarDto{{ (
>{{( )
>{{) *$
GetAvailableAvatarsAsync{{+ C
({{C D
){{D E
{|| 	
try}} 
{~~ 
using 
( 
var 
context "
=# $
new% (!
GuessMyMessDBEntities) >
(> ?
)? @
)@ A
{
ÄÄ 
var
ÅÅ 
emailService
ÅÅ $
=
ÅÅ% &
new
ÅÅ' *
SmtpEmailService
ÅÅ+ ;
(
ÅÅ; <
)
ÅÅ< =
;
ÅÅ= >
var
ÇÇ 
logic
ÇÇ 
=
ÇÇ 
new
ÇÇ  #
UserProfileLogic
ÇÇ$ 4
(
ÇÇ4 5
emailService
ÇÇ5 A
,
ÇÇA B
context
ÇÇC J
)
ÇÇJ K
;
ÇÇK L
return
ÉÉ 
await
ÉÉ  
logic
ÉÉ! &
.
ÉÉ& '&
GetAvailableAvatarsAsync
ÉÉ' ?
(
ÉÉ? @
)
ÉÉ@ A
;
ÉÉA B
}
ÑÑ 
}
ÖÖ 
catch
ÜÜ 
(
ÜÜ 
	Exception
ÜÜ 
ex
ÜÜ 
)
ÜÜ  
{
áá 
throw
àà 
new
àà 
FaultException
àà (
(
àà( )
ex
àà) +
.
àà+ ,
Message
àà, 3
)
àà3 4
;
àà4 5
}
ââ 
}
ää 	
}
ãã 
}åå Ù	
ºC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Utilities\Email\Templates\PasswordChangeVerificationEmailTemplate.cs
	namespace 	
GuessMyMessServer
 
. 
	Utilities %
.% &
Email& +
.+ ,
	Templates, 5
{ 
public		 

class		 3
'PasswordChangeVerificationEmailTemplate		 8
:		9 :
IEmailTemplate		; I
{

 
public 
string 
Subject 
=>  
$str! S
;S T
public 
string 
HtmlBody 
{  
get! $
;$ %
}& '
public 3
'PasswordChangeVerificationEmailTemplate 6
(6 7
string7 =
username> F
,F G
stringH N
verificationCodeO _
)_ `
{ 	
HtmlBody 
= 
$@" 
$str 9
{9 :
username: B
}B C
$strC Y
{Y Z
verificationCodeZ j
}j k
$strk 
" 
; 
}   	
}"" 
}## Û–
ëC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Services\SocialService.cs
	namespace 	
GuessMyMessServer
 
. 
Services $
{ 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?
Single? E
,E F
ConcurrencyModeG V
=W X
ConcurrencyModeY h
.h i
	Reentranti r
)r s
]s t
public 

class 
SocialService 
:  
ISocialService! /
{ 
private 
readonly 
SocialLogic $
_socialLogic% 1
;1 2
private 
static 
readonly 

Dictionary  *
<* +
string+ 1
,1 2"
ISocialServiceCallback3 I
>I J
connectedClientsK [
=\ ]
new^ a

Dictionaryb l
<l m
stringm s
,s t#
ISocialServiceCallback	u ã
>
ã å
(
å ç
)
ç é
;
é è
public 
SocialService 
( 
) 
{ 	
_socialLogic 
= 
new 
SocialLogic *
(* +
new+ .
SmtpEmailService/ ?
(? @
)@ A
)A B
;B C
} 	
private 
async 
Task $
NotifyFriendStatusUpdate 3
(3 4
string4 :
username; C
,C D
stringE K
statusL R
)R S
{ 	
List 
< 
string 
> 
friendUsernames (
;( )
try 
{ 
var 
friends 
= 
await #
_socialLogic$ 0
.0 1
GetFriendsListAsync1 D
(D E
usernameE M
)M N
;N O
friendUsernames 
=  !
friends" )
.) *
Select* 0
(0 1
f1 2
=>3 5
f6 7
.7 8
Username8 @
)@ A
.A B
ToListB H
(H I
)I J
;J K
}   
catch!! 
(!! 
	Exception!! 
ex!! 
)!!  
{"" 
Console## 
.## 
	WriteLine## !
(##! "
$"##" $
$str##$ [
{##[ \
ex##\ ^
.##^ _
Message##_ f
}##f g
"##g h
)##h i
;##i j
return$$ 
;$$ 
}%% 
List'' 
<'' 
string'' 
>'' 
clientsToRemove'' (
='') *
new''+ .
List''/ 3
<''3 4
string''4 :
>'': ;
(''; <
)''< =
;''= >
lock)) 
()) 
connectedClients)) "
)))" #
{** 
foreach++ 
(++ 
var++ 
friendUsername++ +
in++, .
friendUsernames++/ >
)++> ?
{,, 
if-- 
(-- 
connectedClients-- (
.--( )
TryGetValue--) 4
(--4 5
friendUsername--5 C
,--C D
out--E H
var--I L
callback--M U
)--U V
)--V W
{.. 
bool// 
success// $
=//% &$
SendNotificationToClient//' ?
(//? @
callback//@ H
,//H I
friendUsername//J X
,//X Y
username//Z b
,//b c
status//d j
)//j k
;//k l
if11 
(11 
!11 
success11 $
)11$ %
{22 
clientsToRemove33 +
.33+ ,
Add33, /
(33/ 0
friendUsername330 >
)33> ?
;33? @
}44 
}55 
else66 
{77 
Console88 
.88  
	WriteLine88  )
(88) *
$"88* ,
{88, -
friendUsername88- ;
}88; <
$str88< L
{88L M
username88M U
}88U V
$str88V v
"88v w
)88w x
;88x y
}99 
}:: 
foreach<< 
(<< 
var<< 
clientToRemove<< +
in<<, .
clientsToRemove<</ >
.<<> ?
Where<<? D
(<<D E
connectedClients<<E U
.<<U V
ContainsKey<<V a
)<<a b
)<<b c
{== 
Console>> 
.>> 
	WriteLine>> %
(>>% &
$">>& (
$str>>( @
{>>@ A
clientToRemove>>A O
}>>O P
">>P Q
)>>Q R
;>>R S
connectedClients?? $
.??$ %
Remove??% +
(??+ ,
clientToRemove??, :
)??: ;
;??; <
}@@ 
}AA 
}BB 	
privateDD 
boolDD $
SendNotificationToClientDD -
(DD- ."
ISocialServiceCallbackDD. D
callbackDDE M
,DDM N
stringDDO U
friendUsernameDDV d
,DDd e
stringDDf l
targetUsernameDDm {
,DD{ |
string	DD} É
status
DDÑ ä
)
DDä ã
{EE 	
tryFF 
{GG 
ConsoleHH 
.HH 
	WriteLineHH !
(HH! "
$"HH" $
$strHH$ .
{HH. /
friendUsernameHH/ =
}HH= >
$strHH> E
{HHE F
targetUsernameHHF T
}HHT U
$strHHU W
{HHW X
statusHHX ^
}HH^ _
$strHH_ c
"HHc d
)HHd e
;HHe f
callbackII 
?II 
.II %
NotifyFriendStatusChangedII 3
(II3 4
targetUsernameII4 B
,IIB C
statusIID J
)IIJ K
;IIK L
ConsoleJJ 
.JJ 
	WriteLineJJ !
(JJ! "
$"JJ" $
$strJJ$ 9
{JJ9 :
friendUsernameJJ: H
}JJH I
$strJJI J
"JJJ K
)JJK L
;JJL M
returnKK 
trueKK 
;KK 
}LL 
catchMM 
(MM #
ObjectDisposedExceptionMM *
odExMM+ /
)MM/ 0
{NN 
ConsoleOO 
.OO 
	WriteLineOO !
(OO! "
$"OO" $
$strOO$ 4
{OO4 5
friendUsernameOO5 C
}OOC D
$strOOD W
{OOW X
odExOOX \
.OO\ ]
MessageOO] d
}OOd e
$strOOe z
"OOz {
)OO{ |
;OO| }
}PP 
catchQQ 
(QQ /
#CommunicationObjectAbortedExceptionQQ 6
coaExQQ7 <
)QQ< =
{RR 
ConsoleSS 
.SS 
	WriteLineSS !
(SS! "
$"SS" $
$strSS$ 4
{SS4 5
friendUsernameSS5 C
}SSC D
$strSSD P
{SSP Q
coaExSSQ V
.SSV W
MessageSSW ^
}SS^ _
$strSS_ t
"SSt u
)SSu v
;SSv w
}TT 
catchUU 
(UU /
#CommunicationObjectFaultedExceptionUU 6
cofExUU7 <
)UU< =
{VV 
ConsoleWW 
.WW 
	WriteLineWW !
(WW! "
$"WW" $
$strWW$ 4
{WW4 5
friendUsernameWW5 C
}WWC D
$strWWD P
{WWP Q
cofExWWQ V
.WWV W
MessageWWW ^
}WW^ _
$strWW_ t
"WWt u
)WWu v
;WWv w
}XX 
catchYY 
(YY 
TimeoutExceptionYY #
tExYY$ '
)YY' (
{ZZ 
Console[[ 
.[[ 
	WriteLine[[ !
([[! "
$"[[" $
$str[[$ 6
{[[6 7
friendUsername[[7 E
}[[E F
$str[[F H
{[[H I
tEx[[I L
.[[L M
Message[[M T
}[[T U
$str[[U j
"[[j k
)[[k l
;[[l m
}\\ 
catch]] 
(]] 
	Exception]] 
ex]] 
)]]  
{^^ 
Console__ 
.__ 
	WriteLine__ !
(__! "
$"__" $
$str__$ <
{__< =
friendUsername__= K
}__K L
$str__L N
{__N O
ex__O Q
.__Q R
GetType__R Y
(__Y Z
)__Z [
.__[ \
Name__\ `
}__` a
$str__a d
{__d e
ex__e g
.__g h
Message__h o
}__o p
$str	__p Ö
"
__Ö Ü
)
__Ü á
;
__á à
}`` 
returnbb 
falsebb 
;bb 
}cc 	
publicee 
voidee 
Connectee 
(ee 
stringee "
usernameee# +
)ee+ ,
{ff 	
ifgg 
(gg 
stringgg 
.gg 
IsNullOrEmptygg $
(gg$ %
usernamegg% -
)gg- .
)gg. /
{hh 
returnii 
;ii 
}jj 
varll 
callbackll 
=ll 
OperationContextll +
.ll+ ,
Currentll, 3
.ll3 4
GetCallbackChannelll4 F
<llF G"
ISocialServiceCallbackllG ]
>ll] ^
(ll^ _
)ll_ `
;ll` a
lockmm 
(mm 
connectedClientsmm "
)mm" #
{nn 
ifoo 
(oo 
!oo 
connectedClientsoo %
.oo% &
ContainsKeyoo& 1
(oo1 2
usernameoo2 :
)oo: ;
)oo; <
{pp 
connectedClientsqq $
.qq$ %
Addqq% (
(qq( )
usernameqq) 1
,qq1 2
callbackqq3 ;
)qq; <
;qq< =
}rr 
elsess 
{tt 
connectedClientsuu $
[uu$ %
usernameuu% -
]uu- .
=uu/ 0
callbackuu1 9
;uu9 :
}vv 
}ww 
Taskyy 
.yy 
Runyy 
(yy 
asyncyy 
(yy 
)yy 
=>yy  
{zz 
try{{ 
{|| 
await}} 
_socialLogic}} &
.}}& '#
UpdatePlayerStatusAsync}}' >
(}}> ?
username}}? G
,}}G H
$str}}I Q
)}}Q R
;}}R S
await~~ $
NotifyFriendStatusUpdate~~ 2
(~~2 3
username~~3 ;
,~~; <
$str~~= E
)~~E F
;~~F G
} 
catch
ÄÄ 
(
ÄÄ 
	Exception
ÄÄ  
ex
ÄÄ! #
)
ÄÄ# $
{
ÅÅ 
Console
ÇÇ 
.
ÇÇ 
	WriteLine
ÇÇ %
(
ÇÇ% &
$"
ÇÇ& (
$str
ÇÇ( J
{
ÇÇJ K
ex
ÇÇK M
.
ÇÇM N
Message
ÇÇN U
}
ÇÇU V
"
ÇÇV W
)
ÇÇW X
;
ÇÇX Y
}
ÉÉ 
}
ÑÑ 
)
ÑÑ 
;
ÑÑ 
}
ÖÖ 	
public
áá 
void
áá 

Disconnect
áá 
(
áá 
string
áá %
username
áá& .
)
áá. /
{
àà 	
if
ââ 
(
ââ 
string
ââ 
.
ââ 
IsNullOrEmpty
ââ $
(
ââ$ %
username
ââ% -
)
ââ- .
)
ââ. /
{
ää 
return
ãã 
;
ãã 
}
åå 
lock
éé 
(
éé 
connectedClients
éé "
)
éé" #
{
èè 
connectedClients
êê  
.
êê  !
Remove
êê! '
(
êê' (
username
êê( 0
)
êê0 1
;
êê1 2
}
ëë 
Task
ìì 
.
ìì 
Run
ìì 
(
ìì 
async
ìì 
(
ìì 
)
ìì 
=>
ìì  
{
îî 
try
ïï 
{
ññ 
await
óó 
_socialLogic
óó &
.
óó& '%
UpdatePlayerStatusAsync
óó' >
(
óó> ?
username
óó? G
,
óóG H
$str
óóI R
)
óóR S
;
óóS T
await
òò &
NotifyFriendStatusUpdate
òò 2
(
òò2 3
username
òò3 ;
,
òò; <
$str
òò= F
)
òòF G
;
òòG H
}
ôô 
catch
öö 
(
öö 
	Exception
öö  
ex
öö! #
)
öö# $
{
õõ 
Console
úú 
.
úú 
	WriteLine
úú %
(
úú% &
$"
úú& (
$str
úú( M
{
úúM N
ex
úúN P
.
úúP Q
Message
úúQ X
}
úúX Y
"
úúY Z
)
úúZ [
;
úú[ \
}
ùù 
}
ûû 
)
ûû 
;
ûû 
}
üü 	
public
°° 
async
°° 
Task
°° 
<
°° 
List
°° 
<
°° 
	FriendDto
°° (
>
°°( )
>
°°) *!
GetFriendsListAsync
°°+ >
(
°°> ?
string
°°? E
username
°°F N
)
°°N O
{
¢¢ 	
try
££ 
{
§§ 
return
•• 
await
•• 
_socialLogic
•• )
.
••) *!
GetFriendsListAsync
••* =
(
••= >
username
••> F
)
••F G
;
••G H
}
¶¶ 
catch
ßß 
(
ßß 
	Exception
ßß 
ex
ßß 
)
ßß  
{
®® 
throw
©© 
new
©© 
FaultException
©© (
(
©©( )
$"
©©) +
$str
©©+ J
{
©©J K
ex
©©K M
.
©©M N
Message
©©N U
}
©©U V
"
©©V W
)
©©W X
;
©©X Y
}
™™ 
}
´´ 	
public
≠≠ 
async
≠≠ 
Task
≠≠ 
<
≠≠ 
List
≠≠ 
<
≠≠ "
FriendRequestInfoDto
≠≠ 3
>
≠≠3 4
>
≠≠4 5$
GetFriendRequestsAsync
≠≠6 L
(
≠≠L M
string
≠≠M S
username
≠≠T \
)
≠≠\ ]
{
ÆÆ 	
try
ØØ 
{
∞∞ 
return
±± 
await
±± 
_socialLogic
±± )
.
±±) *$
GetFriendRequestsAsync
±±* @
(
±±@ A
username
±±A I
)
±±I J
;
±±J K
}
≤≤ 
catch
≥≥ 
(
≥≥ 
	Exception
≥≥ 
ex
≥≥ 
)
≥≥  
{
¥¥ 
throw
µµ 
new
µµ 
FaultException
µµ (
(
µµ( )
$"
µµ) +
$str
µµ+ M
{
µµM N
ex
µµN P
.
µµP Q
Message
µµQ X
}
µµX Y
"
µµY Z
)
µµZ [
;
µµ[ \
}
∂∂ 
}
∑∑ 	
public
ππ 
async
ππ 
Task
ππ 
<
ππ 
List
ππ 
<
ππ 
UserProfileDto
ππ -
>
ππ- .
>
ππ. /
SearchUsersAsync
ππ0 @
(
ππ@ A
string
ππA G
searchUsername
ππH V
,
ππV W
string
ππX ^
requesterUsername
ππ_ p
)
ππp q
{
∫∫ 	
try
ªª 
{
ºº 
return
ΩΩ 
await
ΩΩ 
_socialLogic
ΩΩ )
.
ΩΩ) *
SearchUsersAsync
ΩΩ* :
(
ΩΩ: ;
searchUsername
ΩΩ; I
,
ΩΩI J
requesterUsername
ΩΩK \
)
ΩΩ\ ]
;
ΩΩ] ^
}
ææ 
catch
øø 
(
øø 
	Exception
øø 
ex
øø 
)
øø  
{
¿¿ 
throw
¡¡ 
new
¡¡ 
FaultException
¡¡ (
(
¡¡( )
$"
¡¡) +
$str
¡¡+ B
{
¡¡B C
ex
¡¡C E
.
¡¡E F
Message
¡¡F M
}
¡¡M N
"
¡¡N O
)
¡¡O P
;
¡¡P Q
}
¬¬ 
}
√√ 	
public
≈≈ 
async
≈≈ 
void
≈≈ 
SendFriendRequest
≈≈ +
(
≈≈+ ,
string
≈≈, 2
requesterUsername
≈≈3 D
,
≈≈D E
string
≈≈F L
targetUsername
≈≈M [
)
≈≈[ \
{
∆∆ 	
try
«« 
{
»» 
await
…… 
_socialLogic
…… "
.
……" #$
SendFriendRequestAsync
……# 9
(
……9 :
requesterUsername
……: K
,
……K L
targetUsername
……M [
)
……[ \
;
……\ ]$
ISocialServiceCallback
ÀÀ &
callback
ÀÀ' /
;
ÀÀ/ 0
lock
ÃÃ 
(
ÃÃ 
connectedClients
ÃÃ &
)
ÃÃ& '
{
ÕÕ 
connectedClients
ŒŒ $
.
ŒŒ$ %
TryGetValue
ŒŒ% 0
(
ŒŒ0 1
targetUsername
ŒŒ1 ?
,
ŒŒ? @
out
ŒŒA D
callback
ŒŒE M
)
ŒŒM N
;
ŒŒN O
}
œœ 
callback
–– 
?
–– 
.
–– !
NotifyFriendRequest
–– -
(
––- .
requesterUsername
––. ?
)
––? @
;
––@ A
}
—— 
catch
““ 
(
““ 
	Exception
““ 
ex
““ 
)
““  
{
”” 
Console
‘‘ 
.
‘‘ 
	WriteLine
‘‘ !
(
‘‘! "
$"
‘‘" $
$str
‘‘$ @
{
‘‘@ A
ex
‘‘A C
.
‘‘C D
Message
‘‘D K
}
‘‘K L
"
‘‘L M
)
‘‘M N
;
‘‘N O
}
’’ 
}
÷÷ 	
public
ÿÿ 
async
ÿÿ 
void
ÿÿ $
RespondToFriendRequest
ÿÿ 0
(
ÿÿ0 1
string
ÿÿ1 7
targetUsername
ÿÿ8 F
,
ÿÿF G
string
ÿÿH N
requesterUsername
ÿÿO `
,
ÿÿ` a
bool
ÿÿb f
accepted
ÿÿg o
)
ÿÿo p
{
ŸŸ 	
try
⁄⁄ 
{
€€ 
await
‹‹ 
_socialLogic
‹‹ "
.
‹‹" #)
RespondToFriendRequestAsync
‹‹# >
(
‹‹> ?
targetUsername
‹‹? M
,
‹‹M N
requesterUsername
‹‹O `
,
‹‹` a
accepted
‹‹b j
)
‹‹j k
;
‹‹k l$
ISocialServiceCallback
ﬁﬁ &
requesterCallback
ﬁﬁ' 8
;
ﬁﬁ8 9
lock
ﬂﬂ 
(
ﬂﬂ 
connectedClients
ﬂﬂ &
)
ﬂﬂ& '
{
‡‡ 
connectedClients
·· $
.
··$ %
TryGetValue
··% 0
(
··0 1
requesterUsername
··1 B
,
··B C
out
··D G
requesterCallback
··H Y
)
··Y Z
;
··Z [
}
‚‚ 
requesterCallback
„„ !
?
„„! "
.
„„" #"
NotifyFriendResponse
„„# 7
(
„„7 8
targetUsername
„„8 F
,
„„F G
accepted
„„H P
)
„„P Q
;
„„Q R
if
ÂÂ 
(
ÂÂ 
accepted
ÂÂ 
)
ÂÂ 
{
ÊÊ 
bool
ÁÁ 
requesterIsOnline
ÁÁ *
;
ÁÁ* +
bool
ËË 
targetIsOnline
ËË '
;
ËË' ($
ISocialServiceCallback
ÈÈ *
targetCallback
ÈÈ+ 9
;
ÈÈ9 :
lock
ÎÎ 
(
ÎÎ 
connectedClients
ÎÎ *
)
ÎÎ* +
{
ÏÏ 
requesterIsOnline
ÌÌ )
=
ÌÌ* +
connectedClients
ÌÌ, <
.
ÌÌ< =
ContainsKey
ÌÌ= H
(
ÌÌH I
requesterUsername
ÌÌI Z
)
ÌÌZ [
;
ÌÌ[ \
targetIsOnline
ÓÓ &
=
ÓÓ' (
connectedClients
ÓÓ) 9
.
ÓÓ9 :
TryGetValue
ÓÓ: E
(
ÓÓE F
targetUsername
ÓÓF T
,
ÓÓT U
out
ÓÓV Y
targetCallback
ÓÓZ h
)
ÓÓh i
;
ÓÓi j
}
ÔÔ 
requesterCallback
ÒÒ %
?
ÒÒ% &
.
ÒÒ& ''
NotifyFriendStatusChanged
ÒÒ' @
(
ÒÒ@ A
targetUsername
ÒÒA O
,
ÒÒO P
targetIsOnline
ÒÒQ _
?
ÒÒ` a
$str
ÒÒb j
:
ÒÒk l
$str
ÒÒm v
)
ÒÒv w
;
ÒÒw x
targetCallback
ÚÚ "
?
ÚÚ" #
.
ÚÚ# $'
NotifyFriendStatusChanged
ÚÚ$ =
(
ÚÚ= >
requesterUsername
ÚÚ> O
,
ÚÚO P
requesterIsOnline
ÚÚQ b
?
ÚÚc d
$str
ÚÚe m
:
ÚÚn o
$str
ÚÚp y
)
ÚÚy z
;
ÚÚz {
}
ÛÛ 
}
ÙÙ 
catch
ıı 
(
ıı 
	Exception
ıı 
ex
ıı 
)
ıı  
{
ˆˆ 
Console
˜˜ 
.
˜˜ 
	WriteLine
˜˜ !
(
˜˜! "
$"
˜˜" $
$str
˜˜$ E
{
˜˜E F
ex
˜˜F H
.
˜˜H I
Message
˜˜I P
}
˜˜P Q
"
˜˜Q R
)
˜˜R S
;
˜˜S T
}
¯¯ 
}
˘˘ 	
public
˚˚ 
async
˚˚ 
void
˚˚ 
RemoveFriend
˚˚ &
(
˚˚& '
string
˚˚' -
username
˚˚. 6
,
˚˚6 7
string
˚˚8 >
friendToRemove
˚˚? M
)
˚˚M N
{
¸¸ 	
try
˝˝ 
{
˛˛ 
await
ˇˇ 
_socialLogic
ˇˇ "
.
ˇˇ" #
RemoveFriendAsync
ˇˇ# 4
(
ˇˇ4 5
username
ˇˇ5 =
,
ˇˇ= >
friendToRemove
ˇˇ? M
)
ˇˇM N
;
ˇˇN O
}
ÄÄ 
catch
ÅÅ 
(
ÅÅ 
	Exception
ÅÅ 
ex
ÅÅ 
)
ÅÅ  
{
ÇÇ 
Console
ÉÉ 
.
ÉÉ 
	WriteLine
ÉÉ !
(
ÉÉ! "
$"
ÉÉ" $
$str
ÉÉ$ ;
{
ÉÉ; <
ex
ÉÉ< >
.
ÉÉ> ?
Message
ÉÉ? F
}
ÉÉF G
"
ÉÉG H
)
ÉÉH I
;
ÉÉI J
}
ÑÑ 
}
ÖÖ 	
public
áá 
async
áá 
void
áá 
SendDirectMessage
áá +
(
áá+ ,
DirectMessageDto
áá, <
message
áá= D
)
ááD E
{
àà 	
if
ââ 
(
ââ 
message
ââ 
==
ââ 
null
ââ 
||
ââ  "
string
ââ# )
.
ââ) *
IsNullOrEmpty
ââ* 7
(
ââ7 8
message
ââ8 ?
.
ââ? @
RecipientUsername
ââ@ Q
)
ââQ R
)
ââR S
{
ää 
Console
ãã 
.
ãã 
	WriteLine
ãã !
(
ãã! "
$str
ãã" B
)
ããB C
;
ããC D
return
åå 
;
åå 
}
çç 
try
èè 
{
êê 
await
ëë 
_socialLogic
ëë "
.
ëë" #$
SendDirectMessageAsync
ëë# 9
(
ëë9 :
message
ëë: A
)
ëëA B
;
ëëB C$
ISocialServiceCallback
ìì &
callback
ìì' /
;
ìì/ 0
lock
îî 
(
îî 
connectedClients
îî &
)
îî& '
{
ïï 
connectedClients
ññ $
.
ññ$ %
TryGetValue
ññ% 0
(
ññ0 1
message
ññ1 8
.
ññ8 9
RecipientUsername
ññ9 J
,
ññJ K
out
ññL O
callback
ññP X
)
ññX Y
;
ññY Z
}
óó 
callback
òò 
?
òò 
.
òò #
NotifyMessageReceived
òò /
(
òò/ 0
message
òò0 7
)
òò7 8
;
òò8 9
}
ôô 
catch
öö 
(
öö 
	Exception
öö 
ex
öö 
)
öö  
{
õõ 
Console
úú 
.
úú 
	WriteLine
úú !
(
úú! "
$"
úú" $
$str
úú$ @
{
úú@ A
ex
úúA C
.
úúC D
Message
úúD K
}
úúK L
"
úúL M
)
úúM N
;
úúN O
}
ùù 
}
ûû 	
public
†† 
async
†† 
Task
†† 
<
†† 
List
†† 
<
†† 
	FriendDto
†† (
>
††( )
>
††) *#
GetConversationsAsync
††+ @
(
††@ A
string
††A G
username
††H P
)
††P Q
{
°° 	
try
¢¢ 
{
££ 
return
§§ 
await
§§ 
_socialLogic
§§ )
.
§§) *#
GetConversationsAsync
§§* ?
(
§§? @
username
§§@ H
)
§§H I
;
§§I J
}
•• 
catch
¶¶ 
(
¶¶ 
	Exception
¶¶ 
ex
¶¶ 
)
¶¶  
{
ßß 
throw
®® 
new
®® 
FaultException
®® (
(
®®( )
$"
®®) +
$str
®®+ K
{
®®K L
ex
®®L N
.
®®N O
Message
®®O V
}
®®V W
"
®®W X
)
®®X Y
;
®®Y Z
}
©© 
}
™™ 	
public
¨¨ 
async
¨¨ 
Task
¨¨ 
<
¨¨ 
List
¨¨ 
<
¨¨ 
DirectMessageDto
¨¨ /
>
¨¨/ 0
>
¨¨0 1)
GetConversationHistoryAsync
¨¨2 M
(
¨¨M N
string
¨¨N T
user1
¨¨U Z
,
¨¨Z [
string
¨¨\ b
user2
¨¨c h
)
¨¨h i
{
≠≠ 	
try
ÆÆ 
{
ØØ 
return
∞∞ 
await
∞∞ 
_socialLogic
∞∞ )
.
∞∞) *)
GetConversationHistoryAsync
∞∞* E
(
∞∞E F
user1
∞∞F K
,
∞∞K L
user2
∞∞M R
)
∞∞R S
;
∞∞S T
}
±± 
catch
≤≤ 
(
≤≤ 
	Exception
≤≤ 
ex
≤≤ 
)
≤≤  
{
≥≥ 
throw
¥¥ 
new
¥¥ 
FaultException
¥¥ (
(
¥¥( )
$"
¥¥) +
$str
¥¥+ R
{
¥¥R S
ex
¥¥S U
.
¥¥U V
Message
¥¥V ]
}
¥¥] ^
"
¥¥^ _
)
¥¥_ `
;
¥¥` a
}
µµ 
}
∂∂ 	
public
∏∏ 
Task
∏∏ 
<
∏∏  
OperationResultDto
∏∏ &
>
∏∏& ',
InviteFriendToGameByEmailAsync
∏∏( F
(
∏∏F G
string
∏∏G M
fromUsername
∏∏N Z
,
∏∏Z [
string
∏∏\ b
friendEmail
∏∏c n
,
∏∏n o
string
∏∏p v
	matchCode∏∏w Ä
)∏∏Ä Å
{
ππ 	
Console
∫∫ 
.
∫∫ 
	WriteLine
∫∫ 
(
∫∫ 
$str
∫∫ [
)
∫∫[ \
;
∫∫\ ]
throw
ªª 
new
ªª %
NotImplementedException
ªª -
(
ªª- .
$str
ªª. j
)
ªªj k
;
ªªk l
}
ºº 	
}
ΩΩ 
}ææ Ê
ôC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Utilities\Email\IEmailTemplate.cs
	namespace 	
GuessMyMessServer
 
. 
	Utilities %
.% &
Email& +
{ 
public		 

	interface		 
IEmailTemplate		 #
{

 
string 
Subject 
{ 
get 
; 
} 
string 
HtmlBody 
{ 
get 
; 
}  
} 
} ÙF
êC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Services\LobbyService.cs
	namespace 	
GuessMyMessServer
 
. 
Services $
{ 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?

PerSession? I
,I J
ConcurrencyModeK Z
=[ \
ConcurrencyMode] l
.l m
	Reentrantm v
)v w
]w x
public		 

class		 
LobbyService		 
:		 
ILobbyService		  -
{

 
private 
readonly !
ILobbyServiceCallback .
	_callback/ 8
;8 9
private 
readonly 

LobbyLogic #
_lobbyLogic$ /
;/ 0
private 
string 
_connectedUsername )
=* +
null, 0
;0 1
private 
string 
_connectedMatchId (
=) *
null+ /
;/ 0
public 
LobbyService 
( 
) 
{ 	
	_callback 
= 
OperationContext (
.( )
Current) 0
.0 1
GetCallbackChannel1 C
<C D!
ILobbyServiceCallbackD Y
>Y Z
(Z [
)[ \
;\ ]
_lobbyLogic 
= 
new 

LobbyLogic (
(( )
)) *
;* +
OperationContext 
. 
Current $
.$ %
Channel% ,
., -
Faulted- 4
+=5 7#
Channel_FaultedOrClosed8 O
;O P
OperationContext 
. 
Current $
.$ %
Channel% ,
., -
Closed- 3
+=4 6#
Channel_FaultedOrClosed7 N
;N O
} 	
public 
void 
ConnectToLobby "
(" #
string# )
username* 2
,2 3
string4 :
matchId; B
)B C
{ 	
_connectedUsername 
=  
username! )
;) *
_connectedMatchId 
= 
matchId  '
;' (
_lobbyLogic 
. 
Connect 
(  
username  (
,( )
matchId* 1
,1 2
	_callback3 <
)< =
;= >
} 	
public 
void 
SendLobbyMessage $
($ %
string% +
senderUsername, :
,: ;
string< B
matchIdC J
,J K
stringL R
messageS Z
)Z [
{   	
if!! 
(!! 
_connectedUsername!! "
==!!# %
senderUsername!!& 4
&&!!5 7
_connectedMatchId!!8 I
==!!J L
matchId!!M T
)!!T U
{"" 
_lobbyLogic## 
.## 
SendMessage## '
(##' (
senderUsername##( 6
,##6 7
matchId##8 ?
,##? @
message##A H
)##H I
;##I J
}$$ 
}%% 	
public'' 
void'' 
	StartGame'' 
('' 
string'' $
hostUsername''% 1
,''1 2
string''3 9
matchId'': A
)''A B
{(( 	
if)) 
()) 
_connectedUsername)) "
==))# %
hostUsername))& 2
&&))3 5
_connectedMatchId))6 G
==))H J
matchId))K R
)))R S
{** 
_lobbyLogic++ 
.++ 
	StartGame++ %
(++% &
hostUsername++& 2
,++2 3
matchId++4 ;
)++; <
;++< =
},, 
}-- 	
public// 
void// 

LeaveLobby// 
(// 
string// %
username//& .
,//. /
string//0 6
matchId//7 >
)//> ?
{00 	
if11 
(11 
_connectedUsername11 "
==11# %
username11& .
&&11/ 1
_connectedMatchId112 C
==11D F
matchId11G N
)11N O
{22 
string33 
user33 
=33 
_connectedUsername33 0
;330 1
string44 
match44 
=44 
_connectedMatchId44 0
;440 1
_connectedUsername55 "
=55# $
null55% )
;55) *
_connectedMatchId66 !
=66" #
null66$ (
;66( )
_lobbyLogic77 
.77 

Disconnect77 &
(77& '
user77' +
,77+ ,
match77- 2
)772 3
;773 4
}88 
}99 	
public;; 
void;; 

KickPlayer;; 
(;; 
string;; %
hostUsername;;& 2
,;;2 3
string;;4 : 
playerToKickUsername;;; O
,;;O P
string;;Q W
matchId;;X _
);;_ `
{<< 	
if== 
(== 
_connectedUsername== "
====# %
hostUsername==& 2
&&==3 5
_connectedMatchId==6 G
====H J
matchId==K R
)==R S
{>> 
_lobbyLogic?? 
.?? 

KickPlayer?? &
(??& '
hostUsername??' 3
,??3 4 
playerToKickUsername??5 I
,??I J
matchId??K R
)??R S
;??S T
}@@ 
}AA 	
publicCC 
voidCC 
StartKickVoteCC !
(CC! "
stringCC" (
voterUsernameCC) 6
,CC6 7
stringCC8 >
targetUsernameCC? M
,CCM N
stringCCO U
matchIdCCV ]
)CC] ^
{DD 	
ifEE 
(EE 
_connectedUsernameEE "
==EE# %
voterUsernameEE& 3
&&EE4 6
_connectedMatchIdEE7 H
==EEI K
matchIdEEL S
)EES T
{FF 
_lobbyLogicGG 
.GG 
StartKickVoteGG )
(GG) *
voterUsernameGG* 7
,GG7 8
targetUsernameGG9 G
,GGG H
matchIdGGI P
)GGP Q
;GGQ R
}HH 
}II 	
publicKK 
voidKK 
SubmitKickVoteKK "
(KK" #
stringKK# )
voterUsernameKK* 7
,KK7 8
stringKK9 ?
targetUsernameKK@ N
,KKN O
stringKKP V
matchIdKKW ^
,KK^ _
boolKK` d
voteKKe i
)KKi j
{LL 	
ifMM 
(MM 
_connectedUsernameMM "
==MM# %
voterUsernameMM& 3
&&MM4 6
_connectedMatchIdMM7 H
==MMI K
matchIdMML S
)MMS T
{NN 
_lobbyLogicOO 
.OO 
SubmitKickVoteOO *
(OO* +
voterUsernameOO+ 8
,OO8 9
targetUsernameOO: H
,OOH I
matchIdOOJ Q
,OOQ R
voteOOS W
)OOW X
;OOX Y
}PP 
}QQ 	
privateSS 
voidSS #
Channel_FaultedOrClosedSS ,
(SS, -
objectSS- 3
senderSS4 :
,SS: ;
	EventArgsSS< E
eSSF G
)SSG H
{TT 	
ConsoleUU 
.UU 
	WriteLineUU 
(UU 
$"UU  
$strUU  H
{UUH I
_connectedUsernameUUI [
??UU\ ^
$strUU_ h
}UUh i
$strUUi t
{UUt u
_connectedMatchId	UUu Ü
??
UUá â
$str
UUä ê
}
UUê ë
"
UUë í
)
UUí ì
;
UUì î
ifVV 
(VV 
!VV 
stringVV 
.VV 
IsNullOrEmptyVV %
(VV% &
_connectedUsernameVV& 8
)VV8 9
&&VV: <
!VV= >
stringVV> D
.VVD E
IsNullOrEmptyVVE R
(VVR S
_connectedMatchIdVVS d
)VVd e
)VVe f
{WW 
_lobbyLogicXX 
.XX 

DisconnectXX &
(XX& '
_connectedUsernameXX' 9
,XX9 :
_connectedMatchIdXX; L
)XXL M
;XXM N
_connectedUsernameYY "
=YY# $
nullYY% )
;YY) *
_connectedMatchIdZZ !
=ZZ" #
nullZZ$ (
;ZZ( )
}[[ 
if\\ 
(\\ 
sender\\ 
is\\ 
IContextChannel\\ )
channel\\* 1
)\\1 2
{]] 
channel^^ 
.^^ 
Faulted^^ 
-=^^  "#
Channel_FaultedOrClosed^^# :
;^^: ;
channel__ 
.__ 
Closed__ 
-=__ !#
Channel_FaultedOrClosed__" 9
;__9 :
}`` 
}aa 	
}bb 
}cc Ù9
ôC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Services\AuthenticationService.cs
	namespace 	
GuessMyMessServer
 
. 
Services $
{ 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?
PerCall? F
)F G
]G H
public 

class !
AuthenticationService &
:' ("
IAuthenticationService) ?
{ 
public 
async 
Task 
< 
OperationResultDto ,
>, -

LoginAsync. 8
(8 9
string9 ?
emailOrUsername@ O
,O P
stringQ W
passwordX `
)` a
{ 	
try 
{ 
using 
( 
var 
context "
=# $
new% (!
GuessMyMessDBEntities) >
(> ?
)? @
)@ A
{ 
var 
emailService $
=% &
new' *
SmtpEmailService+ ;
(; <
)< =
;= >
var 
logic 
= 
new  #
AuthenticationLogic$ 7
(7 8
emailService8 D
,D E
contextF M
)M N
;N O
return 
await  
logic! &
.& '

LoginAsync' 1
(1 2
emailOrUsername2 A
,A B
passwordC K
)K L
;L M
} 
}   
catch!! 
(!! 
	Exception!! 
ex!! 
)!!  
{"" 
throw## 
new## 
FaultException## (
(##( )
ex##) +
.##+ ,
Message##, 3
)##3 4
;##4 5
}$$ 
}%% 	
public'' 
async'' 
Task'' 
<'' 
OperationResultDto'' ,
>'', -
RegisterAsync''. ;
(''; <
UserProfileDto''< J
userProfile''K V
,''V W
string''X ^
password''_ g
)''g h
{(( 	
try)) 
{** 
using++ 
(++ 
var++ 
context++ "
=++# $
new++% (!
GuessMyMessDBEntities++) >
(++> ?
)++? @
)++@ A
{,, 
var-- 
emailService-- $
=--% &
new--' *
SmtpEmailService--+ ;
(--; <
)--< =
;--= >
var.. 
logic.. 
=.. 
new..  #
AuthenticationLogic..$ 7
(..7 8
emailService..8 D
,..D E
context..F M
)..M N
;..N O
return// 
await//  
logic//! &
.//& '
RegisterPlayerAsync//' :
(//: ;
userProfile//; F
,//F G
password//H P
)//P Q
;//Q R
}00 
}11 
catch22 
(22 
	Exception22 
ex22 
)22  
{33 
throw44 
new44 
FaultException44 (
(44( )
ex44) +
.44+ ,
Message44, 3
)443 4
;444 5
}55 
}66 	
public88 
async88 
Task88 
<88 
OperationResultDto88 ,
>88, -
VerifyAccountAsync88. @
(88@ A
string88A G
email88H M
,88M N
string88O U
verificationCode88V f
)88f g
{99 	
try:: 
{;; 
using<< 
(<< 
var<< 
context<< "
=<<# $
new<<% (!
GuessMyMessDBEntities<<) >
(<<> ?
)<<? @
)<<@ A
{== 
var>> 
emailService>> $
=>>% &
new>>' *
SmtpEmailService>>+ ;
(>>; <
)>>< =
;>>= >
var?? 
logic?? 
=?? 
new??  #
AuthenticationLogic??$ 7
(??7 8
emailService??8 D
,??D E
context??F M
)??M N
;??N O
return@@ 
await@@  
logic@@! &
.@@& '
VerifyAccountAsync@@' 9
(@@9 :
email@@: ?
,@@? @
verificationCode@@A Q
)@@Q R
;@@R S
}AA 
}BB 
catchCC 
(CC 
	ExceptionCC 
exCC 
)CC  
{DD 
throwEE 
newEE 
FaultExceptionEE (
(EE( )
exEE) +
.EE+ ,
MessageEE, 3
)EE3 4
;EE4 5
}FF 
}GG 	
publicII 
voidII 
LogOutII 
(II 
stringII !
usernameII" *
)II* +
{JJ 	
tryKK 
{LL 
usingMM 
(MM 
varMM 
contextMM "
=MM# $
newMM% (!
GuessMyMessDBEntitiesMM) >
(MM> ?
)MM? @
)MM@ A
{NN 
varOO 
emailServiceOO $
=OO% &
newOO' *
SmtpEmailServiceOO+ ;
(OO; <
)OO< =
;OO= >
varPP 
logicPP 
=PP 
newPP  #
AuthenticationLogicPP$ 7
(PP7 8
emailServicePP8 D
,PPD E
contextPPF M
)PPM N
;PPN O
logicQQ 
.QQ 
LogOutQQ  
(QQ  !
usernameQQ! )
)QQ) *
;QQ* +
}RR 
}SS 
catchTT 
(TT 
	ExceptionTT 
exTT 
)TT  
{UU 
ConsoleVV 
.VV 
	WriteLineVV !
(VV! "
$"VV" $
$strVV$ >
{VV> ?
exVV? A
.VVA B
MessageVVB I
}VVI J
"VVJ K
)VVK L
;VVL M
}WW 
}XX 	
publicZZ 
TaskZZ 
<ZZ 
OperationResultDtoZZ &
>ZZ& '
LoginAsGuestAsyncZZ( 9
(ZZ9 :
stringZZ: @
usernameZZA I
,ZZI J
stringZZK Q

avatarPathZZR \
)ZZ\ ]
{ZZ^ _
throwZZ` e
newZZf i$
NotImplementedException	ZZj Å
(
ZZÅ Ç
)
ZZÇ É
;
ZZÉ Ñ
}
ZZÖ Ü
public[[ 
Task[[ 
<[[ 
OperationResultDto[[ &
>[[& ')
SendPasswordRecoveryCodeAsync[[( E
([[E F
string[[F L
email[[M R
)[[R S
{[[T U
throw[[V [
new[[\ _#
NotImplementedException[[` w
([[w x
)[[x y
;[[y z
}[[{ |
public\\ 
Task\\ 
<\\ 
OperationResultDto\\ &
>\\& '&
ResetPasswordWithCodeAsync\\( B
(\\B C
string\\C I
email\\J O
,\\O P
string\\Q W
code\\X \
,\\\ ]
string\\^ d
newPassword\\e p
)\\p q
{\\r s
throw\\t y
new\\z }$
NotImplementedException	\\~ ï
(
\\ï ñ
)
\\ñ ó
;
\\ó ò
}
\\ô ö
}]] 
}^^ ü
ÉC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Service1.cs
	namespace 	
GuessMyMessServer
 
{		 
public

 

class

 
Service1

 
:

 
	IService1

 %
{ 
public 
string 
GetData 
( 
int !
value" '
)' (
{ 	
return 
string 
. 
Format  
(  !
$str! 3
,3 4
value5 :
): ;
;; <
} 	
public 
CompositeType $
GetDataUsingDataContract 5
(5 6
CompositeType6 C
	compositeD M
)M N
{ 	
if 
( 
	composite 
== 
null !
)! "
{ 
throw 
new !
ArgumentNullException /
(/ 0
$str0 ;
); <
;< =
} 
if 
( 
	composite 
. 
	BoolValue #
)# $
{ 
	composite 
. 
StringValue %
+=& (
$str) 1
;1 2
} 
return 
	composite 
; 
} 	
} 
} Î	
πC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Utilities\Email\Templates\EmailChangeVerificationEmailTemplate.cs
	namespace 	
GuessMyMessServer
 
. 
	Utilities %
.% &
Email& +
.+ ,
	Templates, 5
{ 
public		 

class		 0
$EmailChangeVerificationEmailTemplate		 5
:		6 7
IEmailTemplate		8 F
{

 
public 
string 
Subject 
=>  
$str! [
;[ \
public 
string 
HtmlBody 
{  
get! $
;$ %
}& '
public 0
$EmailChangeVerificationEmailTemplate 3
(3 4
string4 :
username; C
,C D
stringE K
verificationCodeL \
)\ ]
{ 	
HtmlBody 
= 
$@" 
$str 9
{9 :
username: B
}B C
$strC Y
{Y Z
verificationCodeZ j
}j k
$strk 
" 
; 
}   	
}"" 
}## ª
ìC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Utilities\InputValidator.cs
	namespace 	
GuessMyMessServer
 
. 
	Utilities %
{		 
public

 

static

 
class

 
InputValidator

 &
{ 
public 
static 
bool 
IsValidEmail '
(' (
string( .
email/ 4
)4 5
{ 	
if 
( 
string 
. 
IsNullOrWhiteSpace )
() *
email* /
)/ 0
)0 1
return 
false 
; 
try 
{ 
var 
regex 
= 
new 
Regex  %
(% &
$str& H
,H I
RegexOptionsJ V
.V W

IgnoreCaseW a
,a b
TimeSpanc k
.k l
FromMillisecondsl |
(| }
$num	} Ä
)
Ä Å
)
Å Ç
;
Ç É
return 
regex 
. 
IsMatch $
($ %
email% *
)* +
;+ ,
} 
catch 
( &
RegexMatchTimeoutException -
)- .
{ 
return 
false 
; 
} 
} 	
public 
static 
bool 
IsPasswordSecure +
(+ ,
string, 2
password3 ;
); <
{ 	
if 
( 
string 
. 
IsNullOrWhiteSpace )
() *
password* 2
)2 3
)3 4
return 
false 
; 
if!! 
(!! 
password!! 
.!! 
Length!! 
<!!  !
$num!!" #
)!!# $
return"" 
false"" 
;"" 
if$$ 
($$ 
!$$ 
password$$ 
.$$ 
Any$$ 
($$ 
char$$ "
.$$" #
IsUpper$$# *
)$$* +
)$$+ ,
return%% 
false%% 
;%% 
if'' 
('' 
!'' 
password'' 
.'' 
Any'' 
('' 
char'' "
.''" #
IsLower''# *
)''* +
)''+ ,
return(( 
false(( 
;(( 
if** 
(** 
!** 
password** 
.** 
Any** 
(** 
char** "
.**" #
IsDigit**# *
)*** +
)**+ ,
return++ 
false++ 
;++ 
if-- 
(-- 
!-- 
password-- 
.-- 
Contains-- "
(--" #
$str--# &
)--& '
)--' (
return.. 
false.. 
;.. 
if00 
(00 
password00 
.00 
All00 
(00 
char00 !
.00! "
IsLetterOrDigit00" 1
)001 2
)002 3
return11 
false11 
;11 
return33 
true33 
;33 
}44 	
}55 
}66 ¬9
ñC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Services\MatchmakingService.cs
	namespace 	
GuessMyMessServer
 
. 
Services $
{ 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?

PerSession? I
,I J
ConcurrencyModeK Z
=[ \
ConcurrencyMode] l
.l m
	Reentrantm v
)v w
]w x
public 

class 
MatchmakingService #
:$ %
IMatchmakingService& 9
{ 
private 
readonly '
IMatchmakingServiceCallback 4
	_callback5 >
;> ?
private 
string 
_connectedUsername )
;) *
private 
const 
string 
AuthMismatchMessage 0
=1 2
$str3 C
;C D
public 
MatchmakingService !
(! "
)" #
{ 	
this 
. 
	_callback 
= 
OperationContext -
.- .
Current. 5
.5 6
GetCallbackChannel6 H
<H I'
IMatchmakingServiceCallbackI d
>d e
(e f
)f g
;g h
OperationContext 
. 
Current $
.$ %
Channel% ,
., -
Closing- 4
+=5 7
Channel_Closing8 G
;G H
OperationContext 
. 
Current $
.$ %
Channel% ,
., -
Faulted- 4
+=5 7
Channel_Faulted8 G
;G H
} 	
private 
void 
Channel_Faulted $
($ %
object% +
sender, 2
,2 3
	EventArgs4 =
e> ?
)? @
{ 	
DisconnectUser 
( 
) 
; 
} 	
private   
void   
Channel_Closing   $
(  $ %
object  % +
sender  , 2
,  2 3
	EventArgs  4 =
e  > ?
)  ? @
{!! 	
DisconnectUser"" 
("" 
)"" 
;"" 
}## 	
private%% 
void%% 
DisconnectUser%% #
(%%# $
)%%$ %
{&& 	
if'' 
('' 
!'' 
string'' 
.'' 
IsNullOrEmpty'' %
(''% &
_connectedUsername''& 8
)''8 9
)''9 :
{(( 
MatchmakingLogic))  
.))  !
DisconnectUser))! /
())/ 0
_connectedUsername))0 B
)))B C
;))C D
_connectedUsername** "
=**# $
null**% )
;**) *
}++ 
},, 	
public.. 
void.. 
Connect.. 
(.. 
string.. "
username..# +
)..+ ,
{// 	
this00 
.00 
_connectedUsername00 #
=00$ %
username00& .
;00. /
MatchmakingLogic11 
.11 
ConnectUser11 (
(11( )
username11) 1
,111 2
	_callback113 <
)11< =
;11= >
}22 	
public44 
void44 

Disconnect44 
(44 
string44 %
username44& .
)44. /
{55 	
DisconnectUser66 
(66 
)66 
;66 
}77 	
public99 
List99 
<99 
MatchInfoDto99  
>99  !
GetPublicMatches99" 2
(992 3
)993 4
{:: 	
return;; 
MatchmakingLogic;; #
.;;# $
GetPublicMatches;;$ 4
(;;4 5
);;5 6
;;;6 7
}<< 	
public>> 
OperationResultDto>> !
CreateMatch>>" -
(>>- .
string>>. 4
hostUsername>>5 A
,>>A B
LobbySettingsDto>>C S
settings>>T \
)>>\ ]
{?? 	
if@@ 
(@@ 
hostUsername@@ 
!=@@ 
_connectedUsername@@  2
)@@2 3
{AA 
returnBB 
newBB 
OperationResultDtoBB -
{BB. /
SuccessBB0 7
=BB8 9
falseBB: ?
,BB? @
MessageBBA H
=BBI J
AuthMismatchMessageBBK ^
}BB_ `
;BB` a
}CC 
returnDD 
MatchmakingLogicDD #
.DD# $
CreateMatchDD$ /
(DD/ 0
hostUsernameDD0 <
,DD< =
settingsDD> F
)DDF G
;DDG H
}EE 	
publicGG 
voidGG 
JoinPublicMatchGG #
(GG# $
stringGG$ *
usernameGG+ 3
,GG3 4
stringGG5 ;
matchIdGG< C
)GGC D
{HH 	
ifII 
(II 
usernameII 
!=II 
_connectedUsernameII .
)II. /
{JJ 
	_callbackKK 
.KK 
MatchmakingFailedKK +
(KK+ ,
AuthMismatchMessageKK, ?
)KK? @
;KK@ A
returnLL 
;LL 
}MM 
MatchmakingLogicNN 
.NN 
JoinPublicMatchNN ,
(NN, -
usernameNN- 5
,NN5 6
matchIdNN7 >
)NN> ?
;NN? @
}OO 	
publicQQ 
OperationResultDtoQQ !
JoinPrivateMatchQQ" 2
(QQ2 3
stringQQ3 9
usernameQQ: B
,QQB C
stringQQD J
	matchCodeQQK T
)QQT U
{RR 	
ifSS 
(SS 
usernameSS 
!=SS 
_connectedUsernameSS .
)SS. /
{TT 
returnUU 
newUU 
OperationResultDtoUU -
{UU. /
SuccessUU0 7
=UU8 9
falseUU: ?
,UU? @
MessageUUA H
=UUI J
AuthMismatchMessageUUK ^
}UU_ `
;UU` a
}VV 
returnWW 
MatchmakingLogicWW #
.WW# $
JoinPrivateMatchWW$ 4
(WW4 5
usernameWW5 =
,WW= >
	matchCodeWW? H
)WWH I
;WWI J
}XX 	
publicZZ 
voidZZ 
InviteToMatchZZ !
(ZZ! "
stringZZ" (
inviterUsernameZZ) 8
,ZZ8 9
stringZZ: @
invitedUsernameZZA P
,ZZP Q
stringZZR X
matchIdZZY `
)ZZ` a
{[[ 	
if\\ 
(\\ 
inviterUsername\\ 
!=\\  "
_connectedUsername\\# 5
)\\5 6
{]] 
	_callback^^ 
.^^ 
MatchmakingFailed^^ +
(^^+ ,
AuthMismatchMessage^^, ?
)^^? @
;^^@ A
return__ 
;__ 
}`` 
MatchmakingLogicaa 
.aa 
InviteToMatchaa *
(aa* +
inviterUsernameaa+ :
,aa: ;
invitedUsernameaa< K
,aaK L
matchIdaaM T
)aaT U
;aaU V
}bb 	
}cc 
}dd Å

ìC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Utilities\PasswordHasher.cs
	namespace 	
GuessMyMessServer
 
. 
	Utilities %
{ 
public		 

static		 
class		 
PasswordHasher		 &
{

 
public 
static 
string 
HashPassword )
() *
string* 0
password1 9
)9 :
{ 	
return 
BCrypt 
. 
Net 
. 
BCrypt $
.$ %
HashPassword% 1
(1 2
password2 :
): ;
;; <
} 	
public 
static 
bool 
VerifyPassword )
() *
string* 0
password1 9
,9 :
string; A

storedHashB L
)L M
{ 	
return 
BCrypt 
. 
Net 
. 
BCrypt $
.$ %
Verify% +
(+ ,
password, 4
,4 5

storedHash6 @
)@ A
;A B
} 	
} 
} §	
ÆC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Utilities\Email\Templates\VerificationEmailTemplate.cs
	namespace 	
GuessMyMessServer
 
. 
	Utilities %
.% &
Email& +
{ 
public		 

class		 %
VerificationEmailTemplate		 *
:		+ ,
IEmailTemplate		- ;
{

 
public 
string 
Subject 
=>  
$str! P
;P Q
public 
string 
HtmlBody 
{  
get! $
;$ %
}& '
public %
VerificationEmailTemplate (
(( )
string) /
username0 8
,8 9
string: @
verificationCodeA Q
)Q R
{ 	
HtmlBody 
= 
$@" 
$str S
{S T
usernameT \
}\ ]
$str] Y
{Y Z
verificationCodeZ j
}j k
$strk 
" 
; 
} 	
} 
} ˚'
õC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Utilities\Email\SmtpEmailService.cs
	namespace 	
GuessMyMessServer
 
. 
	Utilities %
.% &
Email& +
{ 
public 

class 
SmtpEmailService !
:" #
IEmailService$ 1
{ 
private 
readonly 
string 
_host  %
;% &
private 
readonly 
int 
_port "
;" #
private 
readonly 
string 
_user  %
;% &
private 
readonly 
string 
_pass  %
;% &
private 
readonly 
string 
_senderName  +
;+ ,
public 
SmtpEmailService 
(  
)  !
{ 	
_host 
=  
ConfigurationManager (
.( )
AppSettings) 4
[4 5
$str5 ?
]? @
;@ A
_port 
= 
Convert 
. 
ToInt32 #
(# $ 
ConfigurationManager$ 8
.8 9
AppSettings9 D
[D E
$strE O
]O P
)P Q
;Q R
_user 
=  
ConfigurationManager (
.( )
AppSettings) 4
[4 5
$str5 ?
]? @
;@ A
_pass 
=  
ConfigurationManager (
.( )
AppSettings) 4
[4 5
$str5 ?
]? @
;@ A
_senderName 
=  
ConfigurationManager .
.. /
AppSettings/ :
[: ;
$str; G
]G H
??I K
$strL `
;` a
if 
( 
string 
. 
IsNullOrEmpty $
($ %
_host% *
)* +
||, .
string/ 5
.5 6
IsNullOrEmpty6 C
(C D
_userD I
)I J
||K M
stringN T
.T U
IsNullOrEmptyU b
(b c
_passc h
)h i
)i j
{ 
throw 
new %
InvalidOperationException 3
(3 4
$str	4 â
)
â ä
;
ä ã
}   
}!! 	
public## 
async## 
Task## 
SendEmailAsync## (
(##( )
string##) /
recipientEmail##0 >
,##> ?
string##@ F
recipientName##G T
,##T U
IEmailTemplate##V d
template##e m
)##m n
{$$ 	
var%% 
message%% 
=%% 
new%% 
MimeMessage%% )
(%%) *
)%%* +
;%%+ ,
message&& 
.&& 
From&& 
.&& 
Add&& 
(&& 
new&&  
MailboxAddress&&! /
(&&/ 0
_senderName&&0 ;
,&&; <
_user&&= B
)&&B C
)&&C D
;&&D E
message'' 
.'' 
To'' 
.'' 
Add'' 
('' 
new'' 
MailboxAddress'' -
(''- .
recipientName''. ;
,''; <
recipientEmail''= K
)''K L
)''L M
;''M N
message(( 
.(( 
Subject(( 
=(( 
template(( &
.((& '
Subject((' .
;((. /
var** 
bodyBuilder** 
=** 
new** !
BodyBuilder**" -
{++ 
HtmlBody,, 
=,, 
template,, #
.,,# $
HtmlBody,,$ ,
}-- 
;-- 
message.. 
... 
Body.. 
=.. 
bodyBuilder.. &
...& '
ToMessageBody..' 4
(..4 5
)..5 6
;..6 7
using00 
(00 
var00 
client00 
=00 
new00  #

SmtpClient00$ .
(00. /
)00/ 0
)000 1
{11 
await22 
client22 
.22 
ConnectAsync22 )
(22) *
_host22* /
,22/ 0
_port221 6
,226 7
SecureSocketOptions228 K
.22K L
StartTls22L T
)22T U
;22U V
await33 
client33 
.33 
AuthenticateAsync33 .
(33. /
_user33/ 4
,334 5
_pass336 ;
)33; <
;33< =
await44 
client44 
.44 
	SendAsync44 &
(44& '
message44' .
)44. /
;44/ 0
await55 
client55 
.55 
DisconnectAsync55 ,
(55, -
true55- 1
)551 2
;552 3
}66 
}77 	
}88 
}99 ﬂÊ
èC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Services\GameService.cs
	namespace 	
GuessMyMessServer
 
. 
Services $
{ 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?
Single? E
,E F
ConcurrencyModeG V
=W X
ConcurrencyModeY h
.h i
	Reentranti r
)r s
]s t
public 

class 
GameService 
: 
IGameService +
{ 
private 
static 
readonly 

Dictionary  *
<* +
string+ 1
,1 2 
IGameServiceCallback3 G
>G H
connectedPlayersI Y
=Z [
new\ _

Dictionary` j
<j k
stringk q
,q r!
IGameServiceCallback	s á
>
á à
(
à â
)
â ä
;
ä ã
private 
static 
readonly 

Dictionary  *
<* +
string+ 1
,1 2
string3 9
>9 : 
_playerSelectedWords; O
=P Q
newR U

DictionaryV `
<` a
stringa g
,g h
stringi o
>o p
(p q
)q r
;r s
private 
static 
readonly 

Dictionary  *
<* +
string+ 1
,1 2
List3 7
<7 8

DrawingDto8 B
>B C
>C D
_matchDrawingsE S
=T U
newV Y

DictionaryZ d
<d e
stringe k
,k l
Listm q
<q r

DrawingDtor |
>| }
>} ~
(~ 
)	 Ä
;
Ä Å
private 
static 
readonly 

Dictionary  *
<* +
string+ 1
,1 2
List3 7
<7 8
string8 >
>> ?
>? @
_matchPlayersA N
=O P
newQ T

DictionaryU _
<_ `
string` f
,f g
Listh l
<l m
stringm s
>s t
>t u
(u v
)v w
;w x
private 
static 
readonly 

Dictionary  *
<* +
string+ 1
,1 2
List3 7
<7 8
GuessDto8 @
>@ A
>A B
_matchGuessesC P
=Q R
newS V

DictionaryW a
<a b
stringb h
,h i
Listj n
<n o
GuessDtoo w
>w x
>x y
(y z
)z {
;{ |
private 
static 
readonly 

Dictionary  *
<* +
string+ 1
,1 2
int3 6
>6 7%
_matchCurrentDrawingIndex8 Q
=R S
newT W

DictionaryX b
<b c
stringc i
,i j
intk n
>n o
(o p
)p q
;q r
private 
static 
readonly 

Dictionary  *
<* +
string+ 1
,1 2
List3 7
<7 8
PlayerScoreDto8 F
>F G
>G H
_matchScoresI U
=V W
newX [

Dictionary\ f
<f g
stringg m
,m n
Listo s
<s t
PlayerScoreDto	t Ç
>
Ç É
>
É Ñ
(
Ñ Ö
)
Ö Ü
;
Ü á
private 
const 
int 
SecondsPerGuess )
=* +
$num, .
;. /
public 
void 
Connect 
( 
string "
username# +
,+ ,
string- 3
matchId4 ;
); <
{ 	
if 
( 
string 
. 
IsNullOrEmpty $
($ %
username% -
)- .
||/ 1
string2 8
.8 9
IsNullOrEmpty9 F
(F G
matchIdG N
)N O
)O P
returnQ W
;W X
var 
callback 
= 
OperationContext +
.+ ,
Current, 3
.3 4
GetCallbackChannel4 F
<F G 
IGameServiceCallbackG [
>[ \
(\ ]
)] ^
;^ _
lock 
( 
connectedPlayers "
)" #
{ 
connectedPlayers    
[    !
username  ! )
]  ) *
=  + ,
callback  - 5
;  5 6
}!! 
lock## 
(## 
_matchPlayers## 
)##  
{$$ 
if%% 
(%% 
!%% 
_matchPlayers%% "
.%%" #
ContainsKey%%# .
(%%. /
matchId%%/ 6
)%%6 7
)%%7 8
{&& 
_matchPlayers'' !
[''! "
matchId''" )
]'') *
=''+ ,
new''- 0
List''1 5
<''5 6
string''6 <
>''< =
(''= >
)''> ?
;''? @
}(( 
if)) 
()) 
!)) 
_matchPlayers)) "
[))" #
matchId))# *
]))* +
.))+ ,
Contains)), 4
())4 5
username))5 =
)))= >
)))> ?
{** 
_matchPlayers++ !
[++! "
matchId++" )
]++) *
.++* +
Add+++ .
(++. /
username++/ 7
)++7 8
;++8 9
},, 
}-- 
Console.. 
... 
	WriteLine.. 
(.. 
$"..  
$str..  ?
{..? @
username..@ H
}..H I
$str..I S
{..S T
matchId..T [
}..[ \
"..\ ]
)..] ^
;..^ _
}// 	
public11 
void11 

Disconnect11 
(11 
string11 %
username11& .
,11. /
string110 6
matchId117 >
)11> ?
{22 	
if33 
(33 
string33 
.33 
IsNullOrEmpty33 $
(33$ %
username33% -
)33- .
)33. /
return330 6
;336 7
lock55 
(55 
connectedPlayers55 "
)55" #
{66 
connectedPlayers77  
.77  !
Remove77! '
(77' (
username77( 0
)770 1
;771 2
}88 
lock:: 
(::  
_playerSelectedWords:: &
)::& '
{;;  
_playerSelectedWords<< $
.<<$ %
Remove<<% +
(<<+ ,
username<<, 4
)<<4 5
;<<5 6
}== 
lock?? 
(?? 
_matchPlayers?? 
)??  
{@@ 
ifAA 
(AA 
matchIdAA 
!=AA 
nullAA #
&&AA$ &
_matchPlayersAA' 4
.AA4 5
ContainsKeyAA5 @
(AA@ A
matchIdAAA H
)AAH I
)AAI J
{BB 
_matchPlayersCC !
[CC! "
matchIdCC" )
]CC) *
.CC* +
RemoveCC+ 1
(CC1 2
usernameCC2 :
)CC: ;
;CC; <
ifEE 
(EE 
_matchPlayersEE %
[EE% &
matchIdEE& -
]EE- .
.EE. /
CountEE/ 4
==EE5 7
$numEE8 9
)EE9 :
{FF 
ClearMatchDataGG &
(GG& '
matchIdGG' .
)GG. /
;GG/ 0
}HH 
}II 
}JJ 
ConsoleKK 
.KK 
	WriteLineKK 
(KK 
$"KK  
$strKK  B
{KKB C
usernameKKC K
}KKK L
"KKL M
)KKM N
;KKN O
}LL 	
publicNN 
voidNN 

SelectWordNN 
(NN 
stringNN %
usernameNN& .
,NN. /
stringNN0 6
matchIdNN7 >
,NN> ?
stringNN@ F
selectedWordNNG S
)NNS T
{OO 	
lockPP 
(PP  
_playerSelectedWordsPP &
)PP& '
{QQ  
_playerSelectedWordsRR $
[RR$ %
usernameRR% -
]RR- .
=RR/ 0
selectedWordRR1 =
;RR= >
}SS 
ConsoleTT 
.TT 
	WriteLineTT 
(TT 
$"TT  
$strTT  4
{TT4 5
usernameTT5 =
}TT= >
$strTT> I
{TTI J
selectedWordTTJ V
}TTV W
$strTTW b
{TTb c
matchIdTTc j
}TTj k
"TTk l
)TTl m
;TTm n
}UU 	
publicWW 
asyncWW 
TaskWW 
<WW 
ListWW 
<WW 
WordDtoWW &
>WW& '
>WW' (
GetRandomWordsAsyncWW) <
(WW< =
)WW= >
{XX 	
tryYY 
{ZZ 
using[[ 
([[ 
var[[ 
context[[ "
=[[# $
new[[% (!
GuessMyMessDBEntities[[) >
([[> ?
)[[? @
)[[@ A
{\\ 
var]] 
logic]] 
=]] 
new]]  #
	GameLogic]]$ -
(]]- .
context]]. 5
)]]5 6
;]]6 7
return^^ 
await^^  
logic^^! &
.^^& '
GetRandomWordsAsync^^' :
(^^: ;
)^^; <
;^^< =
}__ 
}`` 
catchaa 
(aa 
	Exceptionaa 
exaa 
)aa  
{bb 
Consolecc 
.cc 
	WriteLinecc !
(cc! "
$"cc" $
$strcc$ :
{cc: ;
excc; =
.cc= >
Messagecc> E
}ccE F
"ccF G
)ccG H
;ccH I
throwdd 
newdd 
FaultExceptiondd (
(dd( )
exdd) +
.dd+ ,
Messagedd, 3
)dd3 4
;dd4 5
}ee 
}ff 	
publichh 
voidhh 
SubmitDrawinghh !
(hh! "
stringhh" (
usernamehh) 1
,hh1 2
stringhh3 9
matchIdhh: A
,hhA B
bytehhC G
[hhG H
]hhH I
drawingDatahhJ U
)hhU V
{ii 	
tryjj 
{kk 
stringll 

wordToSavell !
=ll" #
$strll$ -
;ll- .
lockmm 
(mm  
_playerSelectedWordsmm *
)mm* +
{nn 
ifoo 
(oo  
_playerSelectedWordsoo ,
.oo, -
ContainsKeyoo- 8
(oo8 9
usernameoo9 A
)ooA B
)ooB C
{pp 

wordToSaveqq "
=qq# $ 
_playerSelectedWordsqq% 9
[qq9 :
usernameqq: B
]qqB C
;qqC D
}rr 
}ss 
varuu 

newDrawinguu 
=uu  
newuu! $

DrawingDtouu% /
{vv 
OwnerUsernameww !
=ww" #
usernameww$ ,
,ww, -
DrawingDataxx 
=xx  !
drawingDataxx" -
,xx- .
WordKeyyy 
=yy 

wordToSaveyy (
,yy( )
	IsGuessedzz 
=zz 
falsezz  %
}{{ 
;{{ 
lock}} 
(}} 
_matchDrawings}} $
)}}$ %
{~~ 
if 
( 
! 
_matchDrawings '
.' (
ContainsKey( 3
(3 4
matchId4 ;
); <
)< =
{
ÄÄ 
_matchDrawings
ÅÅ &
[
ÅÅ& '
matchId
ÅÅ' .
]
ÅÅ. /
=
ÅÅ0 1
new
ÅÅ2 5
List
ÅÅ6 :
<
ÅÅ: ;

DrawingDto
ÅÅ; E
>
ÅÅE F
(
ÅÅF G
)
ÅÅG H
;
ÅÅH I
}
ÇÇ 

newDrawing
ÉÉ 
.
ÉÉ 
	DrawingId
ÉÉ (
=
ÉÉ) *
_matchDrawings
ÉÉ+ 9
[
ÉÉ9 :
matchId
ÉÉ: A
]
ÉÉA B
.
ÉÉB C
Count
ÉÉC H
+
ÉÉI J
$num
ÉÉK L
;
ÉÉL M
_matchDrawings
ÑÑ "
[
ÑÑ" #
matchId
ÑÑ# *
]
ÑÑ* +
.
ÑÑ+ ,
Add
ÑÑ, /
(
ÑÑ/ 0

newDrawing
ÑÑ0 :
)
ÑÑ: ;
;
ÑÑ; <
}
ÖÖ 
Console
áá 
.
áá 
	WriteLine
áá !
(
áá! "
$"
áá" $
$str
áá$ G
{
ááG H
matchId
ááH O
}
ááO P
$str
ááP X
{
ááX Y
username
ááY a
}
ááa b
$str
ááb j
{
ááj k

wordToSave
áák u
}
ááu v
"
ááv w
)
ááw x
;
ááx y'
CheckIfAllPlayersFinished
àà )
(
àà) *
matchId
àà* 1
)
àà1 2
;
àà2 3
}
ââ 
catch
ää 
(
ää 
	Exception
ää 
ex
ää 
)
ää  
{
ãã 
Console
åå 
.
åå 
	WriteLine
åå !
(
åå! "
$"
åå" $
$str
åå$ <
{
åå< =
ex
åå= ?
.
åå? @
Message
åå@ G
}
ååG H
"
ååH I
)
ååI J
;
ååJ K
}
çç 
}
éé 	
public
êê 
void
êê #
SendInGameChatMessage
êê )
(
êê) *
string
êê* 0
username
êê1 9
,
êê9 :
string
êê; A
matchId
êêB I
,
êêI J
string
êêK Q
message
êêR Y
)
êêY Z
{
ëë 	
List
íí 
<
íí 
string
íí 
>
íí 
playersInMatch
íí '
;
íí' (
lock
ìì 
(
ìì 
_matchPlayers
ìì 
)
ìì  
{
îî 
if
ïï 
(
ïï 
!
ïï 
_matchPlayers
ïï "
.
ïï" #
ContainsKey
ïï# .
(
ïï. /
matchId
ïï/ 6
)
ïï6 7
)
ïï7 8
return
ïï9 ?
;
ïï? @
playersInMatch
ññ 
=
ññ  
new
ññ! $
List
ññ% )
<
ññ) *
string
ññ* 0
>
ññ0 1
(
ññ1 2
_matchPlayers
ññ2 ?
[
ññ? @
matchId
ññ@ G
]
ññG H
)
ññH I
;
ññI J
}
óó 
foreach
ôô 
(
ôô 
var
ôô 
playerUsername
ôô '
in
ôô( *
playersInMatch
ôô+ 9
)
ôô9 :
{
öö 
lock
õõ 
(
õõ 
connectedPlayers
õõ &
)
õõ& '
{
úú 
if
ùù 
(
ùù 
connectedPlayers
ùù (
.
ùù( )
ContainsKey
ùù) 4
(
ùù4 5
playerUsername
ùù5 C
)
ùùC D
)
ùùD E
{
ûû 
var
üü 
callback
üü $
=
üü% &
connectedPlayers
üü' 7
[
üü7 8
playerUsername
üü8 F
]
üüF G
;
üüG H
try
†† 
{
°° 
callback
¢¢ $
.
¢¢$ %%
OnInGameMessageReceived
¢¢% <
(
¢¢< =
username
¢¢= E
,
¢¢E F
message
¢¢G N
)
¢¢N O
;
¢¢O P
}
££ 
catch
§§ 
(
§§ 
	Exception
§§ (
ex
§§) +
)
§§+ ,
{
•• 
Console
¶¶ #
.
¶¶# $
	WriteLine
¶¶$ -
(
¶¶- .
$"
¶¶. 0
$str
¶¶0 F
{
¶¶F G
playerUsername
¶¶G U
}
¶¶U V
$str
¶¶V X
{
¶¶X Y
ex
¶¶Y [
.
¶¶[ \
Message
¶¶\ c
}
¶¶c d
"
¶¶d e
)
¶¶e f
;
¶¶f g
}
ßß 
}
®® 
}
©© 
}
™™ 
}
´´ 	
public
≠≠ 
void
≠≠ 
SubmitGuess
≠≠ 
(
≠≠  
string
≠≠  &
username
≠≠' /
,
≠≠/ 0
string
≠≠1 7
matchId
≠≠8 ?
,
≠≠? @
int
≠≠A D
	drawingId
≠≠E N
,
≠≠N O
string
≠≠P V
guess
≠≠W \
)
≠≠\ ]
{
ÆÆ 	

DrawingDto
ØØ 
currentDrawing
ØØ %
=
ØØ& '
null
ØØ( ,
;
ØØ, -
lock
∞∞ 
(
∞∞ 
_matchDrawings
∞∞  
)
∞∞  !
{
±± 
if
≤≤ 
(
≤≤ 
_matchDrawings
≤≤ "
.
≤≤" #
ContainsKey
≤≤# .
(
≤≤. /
matchId
≤≤/ 6
)
≤≤6 7
)
≤≤7 8
{
≥≥ 
currentDrawing
¥¥ "
=
¥¥# $
_matchDrawings
¥¥% 3
[
¥¥3 4
matchId
¥¥4 ;
]
¥¥; <
.
¥¥< =
FirstOrDefault
¥¥= K
(
¥¥K L
d
¥¥L M
=>
¥¥N P
d
¥¥Q R
.
¥¥R S
	DrawingId
¥¥S \
==
¥¥] _
	drawingId
¥¥` i
)
¥¥i j
;
¥¥j k
}
µµ 
}
∂∂ 
if
∏∏ 
(
∏∏ 
currentDrawing
∏∏ 
==
∏∏ !
null
∏∏" &
)
∏∏& '
{
ππ 
Console
∫∫ 
.
∫∫ 
	WriteLine
∫∫ !
(
∫∫! "
$"
∫∫" $
$str
∫∫$ B
{
∫∫B C
	drawingId
∫∫C L
}
∫∫L M
$str
∫∫M a
{
∫∫a b
matchId
∫∫b i
}
∫∫i j
"
∫∫j k
)
∫∫k l
;
∫∫l m
return
ªª 
;
ªª 
}
ºº 
bool
ææ 
	isCorrect
ææ 
=
ææ 
string
ææ #
.
ææ# $
Equals
ææ$ *
(
ææ* +
guess
ææ+ 0
,
ææ0 1
currentDrawing
ææ2 @
.
ææ@ A
WordKey
ææA H
,
ææH I
StringComparison
ææJ Z
.
ææZ [
OrdinalIgnoreCase
ææ[ l
)
ææl m
;
ææm n
var
¿¿ 
newGuess
¿¿ 
=
¿¿ 
new
¿¿ 
GuessDto
¿¿ '
{
¡¡ 
GuesserUsername
¬¬ 
=
¬¬  !
username
¬¬" *
,
¬¬* +
	DrawingId
√√ 
=
√√ 
	drawingId
√√ %
,
√√% &
	GuessText
ƒƒ 
=
ƒƒ 
guess
ƒƒ !
,
ƒƒ! "
	IsCorrect
≈≈ 
=
≈≈ 
	isCorrect
≈≈ %
,
≈≈% &
WordKey
∆∆ 
=
∆∆ 
currentDrawing
∆∆ (
.
∆∆( )
WordKey
∆∆) 0
}
«« 
;
«« 
lock
…… 
(
…… 
_matchGuesses
…… 
)
……  
{
   
if
ÀÀ 
(
ÀÀ 
!
ÀÀ 
_matchGuesses
ÀÀ "
.
ÀÀ" #
ContainsKey
ÀÀ# .
(
ÀÀ. /
matchId
ÀÀ/ 6
)
ÀÀ6 7
)
ÀÀ7 8
{
ÃÃ 
_matchGuesses
ÕÕ !
[
ÕÕ! "
matchId
ÕÕ" )
]
ÕÕ) *
=
ÕÕ+ ,
new
ÕÕ- 0
List
ÕÕ1 5
<
ÕÕ5 6
GuessDto
ÕÕ6 >
>
ÕÕ> ?
(
ÕÕ? @
)
ÕÕ@ A
;
ÕÕA B
}
ŒŒ 
_matchGuesses
œœ 
[
œœ 
matchId
œœ %
]
œœ% &
.
œœ& '
	RemoveAll
œœ' 0
(
œœ0 1
g
œœ1 2
=>
œœ3 5
g
œœ6 7
.
œœ7 8
GuesserUsername
œœ8 G
==
œœH J
username
œœK S
&&
œœT V
g
œœW X
.
œœX Y
	DrawingId
œœY b
==
œœc e
	drawingId
œœf o
)
œœo p
;
œœp q
_matchGuesses
–– 
[
–– 
matchId
–– %
]
––% &
.
––& '
Add
––' *
(
––* +
newGuess
––+ 3
)
––3 4
;
––4 5
}
—— 
lock
”” 
(
”” 
_matchScores
”” 
)
”” 
{
‘‘ 
var
’’ 
playerToScore
’’ !
=
’’" #
_matchScores
’’$ 0
[
’’0 1
matchId
’’1 8
]
’’8 9
.
’’9 :
FirstOrDefault
’’: H
(
’’H I
p
’’I J
=>
’’K M
p
’’N O
.
’’O P
Username
’’P X
==
’’Y [
username
’’\ d
)
’’d e
;
’’e f
if
÷÷ 
(
÷÷ 
playerToScore
÷÷ !
!=
÷÷" $
null
÷÷% )
&&
÷÷* ,
	isCorrect
÷÷- 6
)
÷÷6 7
{
◊◊ 
playerToScore
ÿÿ !
.
ÿÿ! "
Score
ÿÿ" '
+=
ÿÿ( *
$num
ÿÿ+ -
;
ÿÿ- .
}
ŸŸ 
var
€€ 
artist
€€ 
=
€€ 
_matchScores
€€ )
[
€€) *
matchId
€€* 1
]
€€1 2
.
€€2 3
FirstOrDefault
€€3 A
(
€€A B
p
€€B C
=>
€€D F
p
€€G H
.
€€H I
Username
€€I Q
==
€€R T
currentDrawing
€€U c
.
€€c d
OwnerUsername
€€d q
)
€€q r
;
€€r s
if
‹‹ 
(
‹‹ 
artist
‹‹ 
!=
‹‹ 
null
‹‹ "
&&
‹‹# %
	isCorrect
‹‹& /
)
‹‹/ 0
{
›› 
artist
ﬁﬁ 
.
ﬁﬁ 
Score
ﬁﬁ  
+=
ﬁﬁ! #
$num
ﬁﬁ$ &
;
ﬁﬁ& '
}
ﬂﬂ 
}
‡‡ 5
'CheckIfAllGuessesForCurrentDrawingAreIn
‚‚ 3
(
‚‚3 4
matchId
‚‚4 ;
,
‚‚; <
currentDrawing
‚‚= K
)
‚‚K L
;
‚‚L M
}
„„ 	
private
ÂÂ 
void
ÂÂ 5
'CheckIfAllGuessesForCurrentDrawingAreIn
ÂÂ <
(
ÂÂ< =
string
ÂÂ= C
matchId
ÂÂD K
,
ÂÂK L

DrawingDto
ÂÂM W
currentDrawing
ÂÂX f
)
ÂÂf g
{
ÊÊ 	
int
ÁÁ 
totalPlayers
ÁÁ 
=
ÁÁ 
$num
ÁÁ  
;
ÁÁ  !
List
ËË 
<
ËË 
string
ËË 
>
ËË 
playersInMatch
ËË '
;
ËË' (
lock
ÈÈ 
(
ÈÈ 
_matchPlayers
ÈÈ 
)
ÈÈ  
{
ÍÍ 
if
ÎÎ 
(
ÎÎ 
!
ÎÎ 
_matchPlayers
ÎÎ "
.
ÎÎ" #
ContainsKey
ÎÎ# .
(
ÎÎ. /
matchId
ÎÎ/ 6
)
ÎÎ6 7
)
ÎÎ7 8
return
ÎÎ9 ?
;
ÎÎ? @
playersInMatch
ÏÏ 
=
ÏÏ  
_matchPlayers
ÏÏ! .
[
ÏÏ. /
matchId
ÏÏ/ 6
]
ÏÏ6 7
;
ÏÏ7 8
totalPlayers
ÌÌ 
=
ÌÌ 
playersInMatch
ÌÌ -
.
ÌÌ- .
Count
ÌÌ. 3
;
ÌÌ3 4
}
ÓÓ 
int
 #
guessesForThisDrawing
 %
=
& '
$num
( )
;
) *
lock
ÒÒ 
(
ÒÒ 
_matchGuesses
ÒÒ 
)
ÒÒ  
{
ÚÚ 
if
ÛÛ 
(
ÛÛ 
_matchGuesses
ÛÛ !
.
ÛÛ! "
ContainsKey
ÛÛ" -
(
ÛÛ- .
matchId
ÛÛ. 5
)
ÛÛ5 6
)
ÛÛ6 7
{
ÙÙ #
guessesForThisDrawing
ıı )
=
ıı* +
_matchGuesses
ıı, 9
[
ıı9 :
matchId
ıı: A
]
ııA B
.
ııB C
Count
ııC H
(
ııH I
g
ııI J
=>
ııK M
g
ııN O
.
ııO P
	DrawingId
ııP Y
==
ııZ \
currentDrawing
ıı] k
.
ıık l
	DrawingId
ııl u
)
ııu v
;
ııv w
}
ˆˆ 
}
˜˜ 
if
˘˘ 
(
˘˘ #
guessesForThisDrawing
˘˘ %
>=
˘˘& (
(
˘˘) *
totalPlayers
˘˘* 6
-
˘˘7 8
$num
˘˘9 :
)
˘˘: ;
)
˘˘; <
{
˙˙ 
Console
˚˚ 
.
˚˚ 
	WriteLine
˚˚ !
(
˚˚! "
$"
˚˚" $
$str
˚˚$ *
{
˚˚* +
matchId
˚˚+ 2
}
˚˚2 3
$str
˚˚3 V
{
˚˚V W
currentDrawing
˚˚W e
.
˚˚e f
	DrawingId
˚˚f o
}
˚˚o p
$str˚˚p É
"˚˚É Ñ
)˚˚Ñ Ö
;˚˚Ö Ü+
GoToNextDrawingOrAnswersPhase
¸¸ -
(
¸¸- .
matchId
¸¸. 5
)
¸¸5 6
;
¸¸6 7
}
˝˝ 
}
˛˛ 	
private
ÄÄ 
void
ÄÄ +
GoToNextDrawingOrAnswersPhase
ÄÄ 2
(
ÄÄ2 3
string
ÄÄ3 9
matchId
ÄÄ: A
)
ÄÄA B
{
ÅÅ 	
int
ÇÇ 
nextDrawingIndex
ÇÇ  
=
ÇÇ! "
$num
ÇÇ# $
;
ÇÇ$ %
lock
ÉÉ 
(
ÉÉ '
_matchCurrentDrawingIndex
ÉÉ +
)
ÉÉ+ ,
{
ÑÑ '
_matchCurrentDrawingIndex
ÖÖ )
[
ÖÖ) *
matchId
ÖÖ* 1
]
ÖÖ1 2
++
ÖÖ2 4
;
ÖÖ4 5
nextDrawingIndex
ÜÜ  
=
ÜÜ! "'
_matchCurrentDrawingIndex
ÜÜ# <
[
ÜÜ< =
matchId
ÜÜ= D
]
ÜÜD E
;
ÜÜE F
}
áá 
List
ââ 
<
ââ 

DrawingDto
ââ 
>
ââ 
drawings
ââ %
;
ââ% &
lock
ää 
(
ää 
_matchDrawings
ää  
)
ää  !
{
ãã 
drawings
åå 
=
åå 
_matchDrawings
åå )
[
åå) *
matchId
åå* 1
]
åå1 2
;
åå2 3
}
çç 
List
èè 
<
èè 
string
èè 
>
èè 
playersInMatch
èè '
;
èè' (
lock
êê 
(
êê 
_matchPlayers
êê 
)
êê  
{
ëë 
playersInMatch
íí 
=
íí  
new
íí! $
List
íí% )
<
íí) *
string
íí* 0
>
íí0 1
(
íí1 2
_matchPlayers
íí2 ?
[
íí? @
matchId
íí@ G
]
ííG H
)
ííH I
;
ííI J
}
ìì 
if
ïï 
(
ïï 
nextDrawingIndex
ïï  
<
ïï! "
drawings
ïï# +
.
ïï+ ,
Count
ïï, 1
)
ïï1 2
{
ññ 

DrawingDto
óó 
nextDrawing
óó &
=
óó' (
drawings
óó) 1
[
óó1 2
nextDrawingIndex
óó2 B
]
óóB C
;
óóC D
Console
òò 
.
òò 
	WriteLine
òò !
(
òò! "
$"
òò" $
$str
òò$ *
{
òò* +
matchId
òò+ 2
}
òò2 3
$str
òò3 L
{
òòL M
nextDrawing
òòM X
.
òòX Y
	DrawingId
òòY b
}
òòb c
$str
òòc e
{
òòe f
nextDrawing
òòf q
.
òòq r
OwnerUsername
òòr 
}òò Ä
$stròòÄ Å
"òòÅ Ç
)òòÇ É
;òòÉ Ñ
foreach
öö 
(
öö 
var
öö 
playerUsername
öö +
in
öö, .
playersInMatch
öö/ =
)
öö= >
{
õõ 
lock
úú 
(
úú 
connectedPlayers
úú *
)
úú* +
{
ùù 
if
ûû 
(
ûû 
connectedPlayers
ûû ,
.
ûû, -
ContainsKey
ûû- 8
(
ûû8 9
playerUsername
ûû9 G
)
ûûG H
)
ûûH I
{
üü 
try
†† 
{
°° 
connectedPlayers
¢¢  0
[
¢¢0 1
playerUsername
¢¢1 ?
]
¢¢? @
.
¢¢@ A
OnShowNextDrawing
¢¢A R
(
¢¢R S
nextDrawing
¢¢S ^
)
¢¢^ _
;
¢¢_ `
}
££ 
catch
§§ !
(
§§" #
	Exception
§§# ,
ex
§§- /
)
§§/ 0
{
•• 
Console
¶¶  '
.
¶¶' (
	WriteLine
¶¶( 1
(
¶¶1 2
$"
¶¶2 4
$str
¶¶4 S
{
¶¶S T
playerUsername
¶¶T b
}
¶¶b c
$str
¶¶c e
{
¶¶e f
ex
¶¶f h
.
¶¶h i
Message
¶¶i p
}
¶¶p q
"
¶¶q r
)
¶¶r s
;
¶¶s t
}
ßß 
}
®® 
}
©© 
}
™™ 
}
´´ 
else
¨¨ 
{
≠≠ 
Console
ÆÆ 
.
ÆÆ 
	WriteLine
ÆÆ !
(
ÆÆ! "
$"
ÆÆ" $
$str
ÆÆ$ *
{
ÆÆ* +
matchId
ÆÆ+ 2
}
ÆÆ2 3
$str
ÆÆ3 `
"
ÆÆ` a
)
ÆÆa b
;
ÆÆb c
List
∞∞ 
<
∞∞ 

DrawingDto
∞∞ 
>
∞∞  
allDrawings
∞∞! ,
=
∞∞- .
drawings
∞∞/ 7
;
∞∞7 8
List
±± 
<
±± 
GuessDto
±± 
>
±± 

allGuesses
±± )
;
±±) *
List
≤≤ 
<
≤≤ 
PlayerScoreDto
≤≤ #
>
≤≤# $
currentScores
≤≤% 2
;
≤≤2 3
lock
¥¥ 
(
¥¥ 
_matchGuesses
¥¥ #
)
¥¥# $
{
µµ 

allGuesses
∂∂ 
=
∂∂  
_matchGuesses
∂∂! .
.
∂∂. /
ContainsKey
∂∂/ :
(
∂∂: ;
matchId
∂∂; B
)
∂∂B C
?
∂∂D E
new
∂∂F I
List
∂∂J N
<
∂∂N O
GuessDto
∂∂O W
>
∂∂W X
(
∂∂X Y
_matchGuesses
∂∂Y f
[
∂∂f g
matchId
∂∂g n
]
∂∂n o
)
∂∂o p
:
∂∂q r
new
∂∂s v
List
∂∂w {
<
∂∂{ |
GuessDto∂∂| Ñ
>∂∂Ñ Ö
(∂∂Ö Ü
)∂∂Ü á
;∂∂á à
}
∑∑ 
lock
∏∏ 
(
∏∏ 
_matchScores
∏∏ "
)
∏∏" #
{
ππ 
currentScores
∫∫ !
=
∫∫" #
new
∫∫$ '
List
∫∫( ,
<
∫∫, -
PlayerScoreDto
∫∫- ;
>
∫∫; <
(
∫∫< =
_matchScores
∫∫= I
[
∫∫I J
matchId
∫∫J Q
]
∫∫Q R
)
∫∫R S
;
∫∫S T
}
ªª 
foreach
ΩΩ 
(
ΩΩ 
var
ΩΩ 
playerUsername
ΩΩ +
in
ΩΩ, .
playersInMatch
ΩΩ/ =
)
ΩΩ= >
{
ææ 
lock
øø 
(
øø 
connectedPlayers
øø *
)
øø* +
{
¿¿ 
if
¡¡ 
(
¡¡ 
connectedPlayers
¡¡ ,
.
¡¡, -
ContainsKey
¡¡- 8
(
¡¡8 9
playerUsername
¡¡9 G
)
¡¡G H
)
¡¡H I
{
¬¬ 
try
√√ 
{
ƒƒ 
connectedPlayers
≈≈  0
[
≈≈0 1
playerUsername
≈≈1 ?
]
≈≈? @
.
≈≈@ A!
OnAnswersPhaseStart
≈≈A T
(
≈≈T U
allDrawings
∆∆$ /
.
∆∆/ 0
ToArray
∆∆0 7
(
∆∆7 8
)
∆∆8 9
,
∆∆9 :

allGuesses
««$ .
.
««. /
ToArray
««/ 6
(
««6 7
)
««7 8
,
««8 9
currentScores
»»$ 1
.
»»1 2
ToArray
»»2 9
(
»»9 :
)
»»: ;
)
»»; <
;
»»< =
}
…… 
catch
   !
(
  " #
	Exception
  # ,
ex
  - /
)
  / 0
{
ÀÀ 
Console
ÃÃ  '
.
ÃÃ' (
	WriteLine
ÃÃ( 1
(
ÃÃ1 2
$"
ÃÃ2 4
$str
ÃÃ4 U
{
ÃÃU V
playerUsername
ÃÃV d
}
ÃÃd e
$str
ÃÃe g
{
ÃÃg h
ex
ÃÃh j
.
ÃÃj k
Message
ÃÃk r
}
ÃÃr s
"
ÃÃs t
)
ÃÃt u
;
ÃÃu v
}
ÕÕ 
}
ŒŒ 
}
œœ 
}
–– 
int
““ 
totalItemsToShow
““ $
=
““% &
allDrawings
““' 2
.
““2 3
Count
““3 8
+
““9 :

allGuesses
““; E
.
““E F
Count
““F K
;
““K L
int
”” 
delaySeconds
””  
=
””! "
(
””# $
totalItemsToShow
””$ 4
*
””5 6
SecondsPerGuess
””7 F
)
””F G
+
””H I
$num
””J K
;
””K L
Console
’’ 
.
’’ 
	WriteLine
’’ !
(
’’! "
$"
’’" $
$str
’’$ *
{
’’* +
matchId
’’+ 2
}
’’2 3
$str
’’3 L
{
’’L M
delaySeconds
’’M Y
}
’’Y Z
$str
’’Z c
"
’’c d
)
’’d e
;
’’e f
Task
◊◊ 
.
◊◊ 
Delay
◊◊ 
(
◊◊ 
TimeSpan
◊◊ #
.
◊◊# $
FromSeconds
◊◊$ /
(
◊◊/ 0
delaySeconds
◊◊0 <
)
◊◊< =
)
◊◊= >
.
◊◊> ?
ContinueWith
◊◊? K
(
◊◊K L
t
◊◊L M
=>
◊◊N P
{
ÿÿ 
NotifyGameEnd
ŸŸ !
(
ŸŸ! "
matchId
ŸŸ" )
)
ŸŸ) *
;
ŸŸ* +
}
⁄⁄ 
)
⁄⁄ 
;
⁄⁄ 
}
€€ 
}
‹‹ 	
private
ﬁﬁ 
void
ﬁﬁ 
NotifyGameEnd
ﬁﬁ "
(
ﬁﬁ" #
string
ﬁﬁ# )
matchId
ﬁﬁ* 1
)
ﬁﬁ1 2
{
ﬂﬂ 	
Console
‡‡ 
.
‡‡ 
	WriteLine
‡‡ 
(
‡‡ 
$"
‡‡  
$str
‡‡  &
{
‡‡& '
matchId
‡‡' .
}
‡‡. /
$str
‡‡/ ?
"
‡‡? @
)
‡‡@ A
;
‡‡A B
List
‚‚ 
<
‚‚ 
PlayerScoreDto
‚‚ 
>
‚‚  
finalScores
‚‚! ,
;
‚‚, -
lock
‰‰ 
(
‰‰ 
_matchScores
‰‰ 
)
‰‰ 
{
ÂÂ 
if
ÊÊ 
(
ÊÊ 
!
ÊÊ 
_matchScores
ÊÊ !
.
ÊÊ! "
ContainsKey
ÊÊ" -
(
ÊÊ- .
matchId
ÊÊ. 5
)
ÊÊ5 6
)
ÊÊ6 7
{
ÁÁ 
Console
ËË 
.
ËË 
	WriteLine
ËË %
(
ËË% &
$"
ËË& (
$str
ËË( .
{
ËË. /
matchId
ËË/ 6
}
ËË6 7
$str
ËË7 c
"
ËËc d
)
ËËd e
;
ËËe f
return
ÈÈ 
;
ÈÈ 
}
ÍÍ 
finalScores
ÎÎ 
=
ÎÎ 
_matchScores
ÎÎ *
[
ÎÎ* +
matchId
ÎÎ+ 2
]
ÎÎ2 3
.
ÎÎ3 4
OrderByDescending
ÎÎ4 E
(
ÎÎE F
s
ÎÎF G
=>
ÎÎH J
s
ÎÎK L
.
ÎÎL M
Score
ÎÎM R
)
ÎÎR S
.
ÎÎS T
ToList
ÎÎT Z
(
ÎÎZ [
)
ÎÎ[ \
;
ÎÎ\ ]
}
ÏÏ 
List
ÓÓ 
<
ÓÓ 
string
ÓÓ 
>
ÓÓ 
playersInMatch
ÓÓ '
;
ÓÓ' (
lock
ÔÔ 
(
ÔÔ 
_matchPlayers
ÔÔ 
)
ÔÔ  
{
 
if
ÒÒ 
(
ÒÒ 
!
ÒÒ 
_matchPlayers
ÒÒ "
.
ÒÒ" #
ContainsKey
ÒÒ# .
(
ÒÒ. /
matchId
ÒÒ/ 6
)
ÒÒ6 7
)
ÒÒ7 8
return
ÒÒ9 ?
;
ÒÒ? @
playersInMatch
ÚÚ 
=
ÚÚ  
new
ÚÚ! $
List
ÚÚ% )
<
ÚÚ) *
string
ÚÚ* 0
>
ÚÚ0 1
(
ÚÚ1 2
_matchPlayers
ÚÚ2 ?
[
ÚÚ? @
matchId
ÚÚ@ G
]
ÚÚG H
)
ÚÚH I
;
ÚÚI J
}
ÛÛ 
foreach
ıı 
(
ıı 
var
ıı 
playerUsername
ıı '
in
ıı( *
playersInMatch
ıı+ 9
)
ıı9 :
{
ˆˆ 
lock
˜˜ 
(
˜˜ 
connectedPlayers
˜˜ &
)
˜˜& '
{
¯¯ 
if
˘˘ 
(
˘˘ 
connectedPlayers
˘˘ (
.
˘˘( )
ContainsKey
˘˘) 4
(
˘˘4 5
playerUsername
˘˘5 C
)
˘˘C D
)
˘˘D E
{
˙˙ 
try
˚˚ 
{
¸¸ 
connectedPlayers
˝˝ ,
[
˝˝, -
playerUsername
˝˝- ;
]
˝˝; <
.
˝˝< =
	OnGameEnd
˝˝= F
(
˝˝F G
finalScores
˝˝G R
)
˝˝R S
;
˝˝S T
}
˛˛ 
catch
ˇˇ 
(
ˇˇ 
	Exception
ˇˇ (
ex
ˇˇ) +
)
ˇˇ+ ,
{
ÄÄ 
Console
ÅÅ #
.
ÅÅ# $
	WriteLine
ÅÅ$ -
(
ÅÅ- .
$"
ÅÅ. 0
$str
ÅÅ0 G
{
ÅÅG H
playerUsername
ÅÅH V
}
ÅÅV W
$str
ÅÅW Y
{
ÅÅY Z
ex
ÅÅZ \
.
ÅÅ\ ]
Message
ÅÅ] d
}
ÅÅd e
"
ÅÅe f
)
ÅÅf g
;
ÅÅg h
}
ÇÇ 
}
ÉÉ 
}
ÑÑ 
}
ÖÖ 
ClearMatchData
áá 
(
áá 
matchId
áá "
)
áá" #
;
áá# $
}
àà 	
private
ää 
void
ää 
ClearMatchData
ää #
(
ää# $
string
ää$ *
matchId
ää+ 2
)
ää2 3
{
ãã 	
lock
åå 
(
åå 
_matchDrawings
åå  
)
åå  !
{
åå" #
_matchDrawings
åå$ 2
.
åå2 3
Remove
åå3 9
(
åå9 :
matchId
åå: A
)
ååA B
;
ååB C
}
ååD E
lock
çç 
(
çç 
_matchPlayers
çç 
)
çç  
{
çç! "
_matchPlayers
çç# 0
.
çç0 1
Remove
çç1 7
(
çç7 8
matchId
çç8 ?
)
çç? @
;
çç@ A
}
ççB C
lock
éé 
(
éé 
_matchGuesses
éé 
)
éé  
{
éé! "
_matchGuesses
éé# 0
.
éé0 1
Remove
éé1 7
(
éé7 8
matchId
éé8 ?
)
éé? @
;
éé@ A
}
ééB C
lock
èè 
(
èè '
_matchCurrentDrawingIndex
èè +
)
èè+ ,
{
èè- .'
_matchCurrentDrawingIndex
èè/ H
.
èèH I
Remove
èèI O
(
èèO P
matchId
èèP W
)
èèW X
;
èèX Y
}
èèZ [
lock
êê 
(
êê 
_matchScores
êê 
)
êê 
{
êê  !
_matchScores
êê" .
.
êê. /
Remove
êê/ 5
(
êê5 6
matchId
êê6 =
)
êê= >
;
êê> ?
}
êê@ A
Console
íí 
.
íí 
	WriteLine
íí 
(
íí 
$"
íí  
$str
íí  6
{
íí6 7
matchId
íí7 >
}
íí> ?
$str
íí? H
"
ííH I
)
ííI J
;
ííJ K
}
ìì 	
private
ïï 
void
ïï '
CheckIfAllPlayersFinished
ïï .
(
ïï. /
string
ïï/ 5
matchId
ïï6 =
)
ïï= >
{
ññ 	
int
óó 
totalPlayers
óó 
=
óó 
$num
óó  
;
óó  !
int
òò 
totalDrawings
òò 
=
òò 
$num
òò  !
;
òò! "
lock
öö 
(
öö 
_matchPlayers
öö 
)
öö  
{
õõ 
if
úú 
(
úú 
_matchPlayers
úú !
.
úú! "
ContainsKey
úú" -
(
úú- .
matchId
úú. 5
)
úú5 6
)
úú6 7
totalPlayers
ùù  
=
ùù! "
_matchPlayers
ùù# 0
[
ùù0 1
matchId
ùù1 8
]
ùù8 9
.
ùù9 :
Count
ùù: ?
;
ùù? @
}
ûû 
lock
†† 
(
†† 
_matchDrawings
††  
)
††  !
{
°° 
if
¢¢ 
(
¢¢ 
_matchDrawings
¢¢ "
.
¢¢" #
ContainsKey
¢¢# .
(
¢¢. /
matchId
¢¢/ 6
)
¢¢6 7
)
¢¢7 8
totalDrawings
££ !
=
££" #
_matchDrawings
££$ 2
[
££2 3
matchId
££3 :
]
££: ;
.
££; <
Count
££< A
;
££A B
}
§§ 
if
¶¶ 
(
¶¶ 
totalPlayers
¶¶ 
>
¶¶ 
$num
¶¶  
&&
¶¶! #
totalDrawings
¶¶$ 1
>=
¶¶2 4
totalPlayers
¶¶5 A
)
¶¶A B
{
ßß 
Console
®® 
.
®® 
	WriteLine
®® !
(
®®! "
$"
®®" $
$str
®®$ *
{
®®* +
matchId
®®+ 2
}
®®2 3
$str
®®3 \
"
®®\ ]
)
®®] ^
;
®®^ _&
NotifyGuessingPhaseStart
©© (
(
©©( )
matchId
©©) 0
)
©©0 1
;
©©1 2
}
™™ 
else
´´ 
{
¨¨ 
Console
≠≠ 
.
≠≠ 
	WriteLine
≠≠ !
(
≠≠! "
$"
≠≠" $
$str
≠≠$ *
{
≠≠* +
matchId
≠≠+ 2
}
≠≠2 3
$str
≠≠3 J
{
≠≠J K
totalDrawings
≠≠K X
}
≠≠X Y
$str
≠≠Y Z
{
≠≠Z [
totalPlayers
≠≠[ g
}
≠≠g h
$str
≠≠h r
"
≠≠r s
)
≠≠s t
;
≠≠t u
}
ÆÆ 
}
ØØ 	
private
±± 
void
±± &
NotifyGuessingPhaseStart
±± -
(
±±- .
string
±±. 4
matchId
±±5 <
)
±±< =
{
≤≤ 	
List
≥≥ 
<
≥≥ 
string
≥≥ 
>
≥≥ 
playersInMatch
≥≥ '
;
≥≥' (
List
¥¥ 
<
¥¥ 

DrawingDto
¥¥ 
>
¥¥ 
drawings
¥¥ %
;
¥¥% &
lock
∂∂ 
(
∂∂ 
_matchPlayers
∂∂ 
)
∂∂  
{
∑∑ 
if
∏∏ 
(
∏∏ 
!
∏∏ 
_matchPlayers
∏∏ "
.
∏∏" #
ContainsKey
∏∏# .
(
∏∏. /
matchId
∏∏/ 6
)
∏∏6 7
)
∏∏7 8
return
∏∏9 ?
;
∏∏? @
playersInMatch
ππ 
=
ππ  
new
ππ! $
List
ππ% )
<
ππ) *
string
ππ* 0
>
ππ0 1
(
ππ1 2
_matchPlayers
ππ2 ?
[
ππ? @
matchId
ππ@ G
]
ππG H
)
ππH I
;
ππI J
}
∫∫ 
lock
ºº 
(
ºº 
_matchDrawings
ºº  
)
ºº  !
{
ΩΩ 
if
ææ 
(
ææ 
!
ææ 
_matchDrawings
ææ #
.
ææ# $
ContainsKey
ææ$ /
(
ææ/ 0
matchId
ææ0 7
)
ææ7 8
)
ææ8 9
return
ææ: @
;
ææ@ A
drawings
øø 
=
øø 
_matchDrawings
øø )
[
øø) *
matchId
øø* 1
]
øø1 2
;
øø2 3
}
¿¿ 
lock
¬¬ 
(
¬¬ '
_matchCurrentDrawingIndex
¬¬ +
)
¬¬+ ,
{
√√ '
_matchCurrentDrawingIndex
ƒƒ )
[
ƒƒ) *
matchId
ƒƒ* 1
]
ƒƒ1 2
=
ƒƒ3 4
$num
ƒƒ5 6
;
ƒƒ6 7
}
≈≈ 
lock
∆∆ 
(
∆∆ 
_matchScores
∆∆ 
)
∆∆ 
{
«« 
_matchScores
»» 
[
»» 
matchId
»» $
]
»»$ %
=
»»& '
playersInMatch
»»( 6
.
…… 
Select
…… 
(
…… 
username
…… $
=>
……% '
new
……( +
PlayerScoreDto
……, :
{
……; <
Username
……= E
=
……F G
username
……H P
,
……P Q
Score
……R W
=
……X Y
$num
……Z [
}
……\ ]
)
……] ^
.
   
ToList
   
(
   
)
   
;
   
}
ÀÀ 
lock
ÃÃ 
(
ÃÃ 
_matchGuesses
ÃÃ 
)
ÃÃ  
{
ÕÕ 
_matchGuesses
ŒŒ 
.
ŒŒ 
Remove
ŒŒ $
(
ŒŒ$ %
matchId
ŒŒ% ,
)
ŒŒ, -
;
ŒŒ- .
}
œœ 

DrawingDto
—— 
firstDrawing
—— #
=
——$ %
drawings
——& .
.
——. /
FirstOrDefault
——/ =
(
——= >
)
——> ?
;
——? @
if
““ 
(
““ 
firstDrawing
““ 
==
““ 
null
““  $
)
““$ %
{
”” 
Console
‘‘ 
.
‘‘ 
	WriteLine
‘‘ !
(
‘‘! "
$"
‘‘" $
$str
‘‘$ d
{
‘‘d e
matchId
‘‘e l
}
‘‘l m
$str
‘‘m n
"
‘‘n o
)
‘‘o p
;
‘‘p q
return
’’ 
;
’’ 
}
÷÷ 
foreach
ÿÿ 
(
ÿÿ 
var
ÿÿ 
username
ÿÿ !
in
ÿÿ" $
playersInMatch
ÿÿ% 3
)
ÿÿ3 4
{
ŸŸ 
lock
⁄⁄ 
(
⁄⁄ 
connectedPlayers
⁄⁄ &
)
⁄⁄& '
{
€€ 
if
‹‹ 
(
‹‹ 
connectedPlayers
‹‹ (
.
‹‹( )
ContainsKey
‹‹) 4
(
‹‹4 5
username
‹‹5 =
)
‹‹= >
)
‹‹> ?
{
›› 
var
ﬁﬁ 
callback
ﬁﬁ $
=
ﬁﬁ% &
connectedPlayers
ﬁﬁ' 7
[
ﬁﬁ7 8
username
ﬁﬁ8 @
]
ﬁﬁ@ A
;
ﬁﬁA B
try
ﬂﬂ 
{
‡‡ 
callback
·· $
.
··$ %"
OnGuessingPhaseStart
··% 9
(
··9 :
firstDrawing
··: F
)
··F G
;
··G H
}
‚‚ 
catch
„„ 
(
„„ 
	Exception
„„ (
ex
„„) +
)
„„+ ,
{
‰‰ 
Console
ÂÂ #
.
ÂÂ# $
	WriteLine
ÂÂ$ -
(
ÂÂ- .
$"
ÂÂ. 0
$str
ÂÂ0 @
{
ÂÂ@ A
username
ÂÂA I
}
ÂÂI J
$str
ÂÂJ L
{
ÂÂL M
ex
ÂÂM O
.
ÂÂO P
Message
ÂÂP W
}
ÂÂW X
"
ÂÂX Y
)
ÂÂY Z
;
ÂÂZ [
}
ÊÊ 
}
ÁÁ 
}
ËË 
}
ÈÈ 
}
ÍÍ 	
}
ÎÎ 
}ÏÏ æ
íC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Properties\AssemblyInfo.cs
[ 
assembly 	
:	 

AssemblyTitle 
( 
$str ,
), -
]- .
[		 
assembly		 	
:			 

AssemblyDescription		 
(		 
$str		 !
)		! "
]		" #
[

 
assembly

 	
:

	 
!
AssemblyConfiguration

  
(

  !
$str

! #
)

# $
]

$ %
[ 
assembly 	
:	 

AssemblyCompany 
( 
$str 
) 
] 
[ 
assembly 	
:	 

AssemblyProduct 
( 
$str .
). /
]/ 0
[ 
assembly 	
:	 

AssemblyCopyright 
( 
$str 0
)0 1
]1 2
[ 
assembly 	
:	 

AssemblyTrademark 
( 
$str 
)  
]  !
[ 
assembly 	
:	 

AssemblyCulture 
( 
$str 
) 
] 
[ 
assembly 	
:	 


ComVisible 
( 
false 
) 
] 
[ 
assembly 	
:	 

Guid 
( 
$str 6
)6 7
]7 8
[## 
assembly## 	
:##	 

AssemblyVersion## 
(## 
$str## $
)##$ %
]##% &
[$$ 
assembly$$ 	
:$$	 

AssemblyFileVersion$$ 
($$ 
$str$$ (
)$$( )
]$$) *¢
ÑC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\IService1.cs
	namespace 	
GuessMyMessServer
 
{		 
[

 
ServiceContract

 
]

 
public 

	interface 
	IService1 
{ 
[ 	
OperationContract	 
] 
string 
GetData 
( 
int 
value  
)  !
;! "
[ 	
OperationContract	 
] 
CompositeType $
GetDataUsingDataContract .
(. /
CompositeType/ <
	composite= F
)F G
;G H
} 
[ 
DataContract 
] 
public 

class 
CompositeType 
{ 
[ 	

DataMember	 
] 
public 
bool 
	BoolValue 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
true. 2
;2 3
[ 	

DataMember	 
] 
public 
string 
StringValue !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
$str2 :
;: ;
} 	
} ˘6
§C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\ServiceContracts\ISocialService.cs
	namespace 	
GuessMyMessServer
 
. 
	Contracts %
.% &
ServiceContracts& 6
{ 
[ 
ServiceContract 
( 
CallbackContract %
=& '
typeof( .
(. /"
ISocialServiceCallback/ E
)E F
)F G
]G H
public		 

	interface		 
ISocialService		 #
{

 
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
Connect 
( 
string 
username $
)$ %
;% &
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
string $
)$ %
)% &
]& '
Task 
< 
List 
< 
	FriendDto 
> 
> 
GetFriendsListAsync 1
(1 2
string2 8
username9 A
)A B
;B C
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
string $
)$ %
)% &
]& '
Task 
< 
List 
<  
FriendRequestInfoDto &
>& '
>' ("
GetFriendRequestsAsync) ?
(? @
string@ F
usernameG O
)O P
;P Q
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
string $
)$ %
)% &
]& '
Task 
< 
List 
< 
UserProfileDto  
>  !
>! "
SearchUsersAsync# 3
(3 4
string4 :
searchUsername; I
,I J
stringK Q
requesterUsernameR c
)c d
;d e
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
SendFriendRequest 
( 
string %
requesterUsername& 7
,7 8
string9 ?
targetUsername@ N
)N O
;O P
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void "
RespondToFriendRequest #
(# $
string$ *
targetUsername+ 9
,9 :
string; A
requesterUsernameB S
,S T
boolU Y
acceptedZ b
)b c
;c d
[   	
OperationContract  	 
(   
IsOneWay   #
=  $ %
true  & *
)  * +
]  + ,
void!! 
RemoveFriend!! 
(!! 
string!!  
username!!! )
,!!) *
string!!+ 1
friendToRemove!!2 @
)!!@ A
;!!A B
[## 	
OperationContract##	 
]## 
[$$ 	
FaultContract$$	 
($$ 
typeof$$ 
($$ 
string$$ $
)$$$ %
)$$% &
]$$& '
Task%% 
<%% 
OperationResultDto%% 
>%%  *
InviteFriendToGameByEmailAsync%%! ?
(%%? @
string%%@ F
fromUsername%%G S
,%%S T
string%%U [
friendEmail%%\ g
,%%g h
string%%i o
	matchCode%%p y
)%%y z
;%%z {
['' 	
OperationContract''	 
('' 
IsOneWay'' #
=''$ %
true''& *
)''* +
]''+ ,
void(( 
SendDirectMessage(( 
((( 
DirectMessageDto(( /
message((0 7
)((7 8
;((8 9
[** 	
OperationContract**	 
]** 
[++ 	
FaultContract++	 
(++ 
typeof++ 
(++ 
string++ $
)++$ %
)++% &
]++& '
Task,, 
<,, 
List,, 
<,, 
	FriendDto,, 
>,, 
>,, !
GetConversationsAsync,, 3
(,,3 4
string,,4 :
username,,; C
),,C D
;,,D E
[.. 	
OperationContract..	 
].. 
[// 	
FaultContract//	 
(// 
typeof// 
(// 
string// $
)//$ %
)//% &
]//& '
Task00 
<00 
List00 
<00 
DirectMessageDto00 "
>00" #
>00# $'
GetConversationHistoryAsync00% @
(00@ A
string00A G
user100H M
,00M N
string00O U
user200V [
)00[ \
;00\ ]
[22 	
OperationContract22	 
(22 
IsOneWay22 #
=22$ %
true22& *
)22* +
]22+ ,
void33 

Disconnect33 
(33 
string33 
username33 '
)33' (
;33( )
}44 
[66 
ServiceContract66 
]66 
public77 

	interface77 "
ISocialServiceCallback77 +
{88 
[99 	
OperationContract99	 
(99 
IsOneWay99 #
=99$ %
true99& *
)99* +
]99+ ,
void:: 
NotifyFriendRequest::  
(::  !
string::! '
fromUsername::( 4
)::4 5
;::5 6
[<< 	
OperationContract<<	 
(<< 
IsOneWay<< #
=<<$ %
true<<& *
)<<* +
]<<+ ,
void==  
NotifyFriendResponse== !
(==! "
string==" (
fromUsername==) 5
,==5 6
bool==7 ;
accepted==< D
)==D E
;==E F
[?? 	
OperationContract??	 
(?? 
IsOneWay?? #
=??$ %
true??& *
)??* +
]??+ ,
void@@ %
NotifyFriendStatusChanged@@ &
(@@& '
string@@' -
friendUsername@@. <
,@@< =
string@@> D
status@@E K
)@@K L
;@@L M
[BB 	
OperationContractBB	 
(BB 
IsOneWayBB #
=BB$ %
trueBB& *
)BB* +
]BB+ ,
voidCC !
NotifyMessageReceivedCC "
(CC" #
DirectMessageDtoCC# 3
messageCC4 ;
)CC; <
;CC< =
}DD 
}EE Æ
©C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\ServiceContracts\IUserProfileService.cs
	namespace		 	
GuessMyMessServer		
 
.		 
	Contracts		 %
.		% &
ServiceContracts		& 6
{

 
[ 
ServiceContract 
] 
public 

	interface 
IUserProfileService (
{ 
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
string $
)$ %
)% &
]& '
Task 
< 
UserProfileDto 
> 
GetUserProfileAsync 0
(0 1
string1 7
username8 @
)@ A
;A B
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
string $
)$ %
)% &
]& '
Task 
< 
OperationResultDto 
>  
UpdateProfileAsync! 3
(3 4
string4 :
username; C
,C D
UserProfileDtoE S
profileDataT _
)_ `
;` a
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
string $
)$ %
)% &
]& '
Task 
< 
OperationResultDto 
>  #
RequestChangeEmailAsync! 8
(8 9
string9 ?
username@ H
,H I
stringJ P
newEmailQ Y
)Y Z
;Z [
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
string $
)$ %
)% &
]& '
Task 
< 
OperationResultDto 
>  #
ConfirmChangeEmailAsync! 8
(8 9
string9 ?
username@ H
,H I
stringJ P
verificationCodeQ a
)a b
;b c
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
string $
)$ %
)% &
]& '
Task   
<   
OperationResultDto   
>    &
RequestChangePasswordAsync  ! ;
(  ; <
string  < B
username  C K
)  K L
;  L M
["" 	
OperationContract""	 
]"" 
[## 	
FaultContract##	 
(## 
typeof## 
(## 
string## $
)##$ %
)##% &
]##& '
Task$$ 
<$$ 
OperationResultDto$$ 
>$$  &
ConfirmChangePasswordAsync$$! ;
($$; <
string$$< B
username$$C K
,$$K L
string$$M S
newPassword$$T _
,$$_ `
string$$a g
verificationCode$$h x
)$$x y
;$$y z
[&& 	
OperationContract&&	 
]&& 
['' 	
FaultContract''	 
('' 
typeof'' 
('' 
string'' $
)''$ %
)''% &
]''& '
Task(( 
<(( 
List(( 
<(( 
	AvatarDto(( 
>(( 
>(( $
GetAvailableAvatarsAsync(( 6
(((6 7
)((7 8
;((8 9
})) 
}** ˚"
©C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\ServiceContracts\IMatchmakingService.cs
	namespace		 	
GuessMyMessServer		
 
.		 
	Contracts		 %
.		% &
ServiceContracts		& 6
{

 
[ 
ServiceContract 
( 
CallbackContract %
=& '
typeof( .
(. /'
IMatchmakingServiceCallback/ J
)J K
)K L
]L M
public 

	interface 
IMatchmakingService (
{ 
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
Connect 
( 
string 
username $
)$ %
;% &
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 

Disconnect 
( 
string 
username '
)' (
;( )
[ 	
OperationContract	 
] 
List 
< 
MatchInfoDto 
> 
GetPublicMatches +
(+ ,
), -
;- .
[ 	
OperationContract	 
] 
OperationResultDto 
CreateMatch &
(& '
string' -
hostUsername. :
,: ;
LobbySettingsDto< L
settingsM U
)U V
;V W
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
JoinPublicMatch 
( 
string #
username$ ,
,, -
string. 4
matchId5 <
)< =
;= >
[ 	
OperationContract	 
] 
OperationResultDto 
JoinPrivateMatch +
(+ ,
string, 2
username3 ;
,; <
string= C
	matchCodeD M
)M N
;N O
[   	
OperationContract  	 
(   
IsOneWay   #
=  $ %
true  & *
)  * +
]  + ,
void!! 
InviteToMatch!! 
(!! 
string!! !
inviterUsername!!" 1
,!!1 2
string!!3 9
invitedUsername!!: I
,!!I J
string!!K Q
matchId!!R Y
)!!Y Z
;!!Z [
}"" 
[$$ 
ServiceContract$$ 
]$$ 
public%% 

	interface%% '
IMatchmakingServiceCallback%% 0
{&& 
['' 	
OperationContract''	 
('' 
IsOneWay'' #
=''$ %
true''& *
)''* +
]''+ ,
void(( 
ReceiveMatchInvite(( 
(((  
string((  &
fromUsername((' 3
,((3 4
string((5 ;
matchId((< C
)((C D
;((D E
[** 	
OperationContract**	 
(** 
IsOneWay** #
=**$ %
true**& *
)*** +
]**+ ,
void++ 
MatchUpdate++ 
(++ 
MatchInfoDto++ %
	matchInfo++& /
)++/ 0
;++0 1
[-- 	
OperationContract--	 
(-- 
IsOneWay-- #
=--$ %
true--& *
)--* +
]--+ ,
void.. 
MatchJoined.. 
(.. 
string.. 
matchId..  '
,..' (
OperationResultDto..) ;
result..< B
)..B C
;..C D
[00 	
OperationContract00	 
(00 
IsOneWay00 #
=00$ %
true00& *
)00* +
]00+ ,
void11 
MatchmakingFailed11 
(11 
string11 %
reason11& ,
)11, -
;11- .
[33 	
OperationContract33	 
(33 
IsOneWay33 #
=33$ %
true33& *
)33* +
]33+ ,
void44 $
PublicMatchesListUpdated44 %
(44% &
List44& *
<44* +
MatchInfoDto44+ 7
>447 8
publicMatches449 F
)44F G
;44G H
}55 
}66 â)
£C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\ServiceContracts\ILobbyService.cs
	namespace		 	
GuessMyMessServer		
 
.		 
	Contracts		 %
.		% &
ServiceContracts		& 6
{

 
[ 
ServiceContract 
( 
CallbackContract %
=& '
typeof( .
(. /!
ILobbyServiceCallback/ D
)D E
)E F
]F G
public 

	interface 
ILobbyService "
{ 
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
ConnectToLobby 
( 
string "
username# +
,+ ,
string- 3
matchId4 ;
); <
;< =
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
SendLobbyMessage 
( 
string $
senderUsername% 3
,3 4
string5 ;
matchId< C
,C D
stringE K
messageL S
)S T
;T U
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
	StartGame 
( 
string 
hostUsername *
,* +
string, 2
matchId3 :
): ;
;; <
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 

LeaveLobby 
( 
string 
username '
,' (
string) /
matchId0 7
)7 8
;8 9
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 

KickPlayer 
( 
string 
hostUsername +
,+ ,
string- 3 
playerToKickUsername4 H
,H I
stringJ P
matchIdQ X
)X Y
;Y Z
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
StartKickVote 
( 
string !
voterUsername" /
,/ 0
string1 7
targetUsername8 F
,F G
stringH N
matchIdO V
)V W
;W X
[   	
OperationContract  	 
(   
IsOneWay   #
=  $ %
true  & *
)  * +
]  + ,
void!! 
SubmitKickVote!! 
(!! 
string!! "
voterUsername!!# 0
,!!0 1
string!!2 8
targetUsername!!9 G
,!!G H
string!!I O
matchId!!P W
,!!W X
bool!!Y ]
vote!!^ b
)!!b c
;!!c d
}"" 
[$$ 
ServiceContract$$ 
]$$ 
public%% 

	interface%% !
ILobbyServiceCallback%% *
{&& 
['' 	
OperationContract''	 
('' 
IsOneWay'' #
=''$ %
true''& *
)''* +
]''+ ,
void(( 
UpdateLobbyState(( 
((( 
LobbyStateDto(( +
lobbyStateDto((, 9
)((9 :
;((: ;
[** 	
OperationContract**	 
(** 
IsOneWay** #
=**$ %
true**& *
)*** +
]**+ ,
void++ 
ReceiveLobbyMessage++  
(++  !
ChatMessageDto++! /

messageDto++0 :
)++: ;
;++; <
[-- 	
OperationContract--	 
(-- 
IsOneWay-- #
=--$ %
true--& *
)--* +
]--+ ,
void.. 
OnGameStarting.. 
(.. 
int.. 
countdownSeconds..  0
)..0 1
;..1 2
[00 	
OperationContract00	 
(00 
IsOneWay00 #
=00$ %
true00& *
)00* +
]00+ ,
void11 
OnGameStarted11 
(11 
)11 
;11 
[33 	
OperationContract33	 
(33 
IsOneWay33 #
=33$ %
true33& *
)33* +
]33+ ,
void44 
KickedFromLobby44 
(44 
string44 #
reason44$ *
)44* +
;44+ ,
[66 	
OperationContract66	 
(66 
IsOneWay66 #
=66$ %
true66& *
)66* +
]66+ ,
void77 
UpdateKickVote77 
(77 
string77 "
targetUsername77# 1
,771 2
int773 6
currentVotes777 C
,77C D
int77E H
votesNeeded77I T
)77T U
;77U V
}88 
}99 ∂-
¢C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\ServiceContracts\IGameService.cs
	namespace		 	
GuessMyMessServer		
 
.		 
	Contracts		 %
.		% &
ServiceContracts		& 6
{

 
[ 
ServiceContract 
( 
CallbackContract %
=& '
typeof( .
(. / 
IGameServiceCallback/ C
)C D
)D E
]E F
public 

	interface 
IGameService !
{ 
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
Connect 
( 
string 
username $
,$ %
string& ,
matchId- 4
)4 5
;5 6
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 

Disconnect 
( 
string 
username '
,' (
string) /
matchId0 7
)7 8
;8 9
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 

SelectWord 
( 
string 
username '
,' (
string) /
matchId0 7
,7 8
string9 ?
selectedWord@ L
)L M
;M N
[ 	
OperationContract	 
] 
Task 
< 
List 
< 
WordDto 
> 
> 
GetRandomWordsAsync /
(/ 0
)0 1
;1 2
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
SubmitDrawing 
( 
string !
username" *
,* +
string, 2
matchId3 :
,: ;
byte< @
[@ A
]A B
drawingDataC N
)N O
;O P
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
SubmitGuess 
( 
string 
username  (
,( )
string* 0
matchId1 8
,8 9
int: =
	drawingId> G
,G H
stringI O
guessP U
)U V
;V W
[   	
OperationContract  	 
(   
IsOneWay   #
=  $ %
true  & *
)  * +
]  + ,
void!! !
SendInGameChatMessage!! "
(!!" #
string!!# )
username!!* 2
,!!2 3
string!!4 :
matchId!!; B
,!!B C
string!!D J
message!!K R
)!!R S
;!!S T
}"" 
[$$ 
ServiceContract$$ 
]$$ 
public%% 

	interface%%  
IGameServiceCallback%% )
{&& 
['' 	
OperationContract''	 
('' 
IsOneWay'' #
=''$ %
true''& *
)''* +
]''+ ,
void(( 
OnRoundStart(( 
((( 
int(( 
roundNumber(( )
,(() *
List((+ /
<((/ 0
string((0 6
>((6 7
wordOptions((8 C
)((C D
;((D E
[** 	
OperationContract**	 
(** 
IsOneWay** #
=**$ %
true**& *
)*** +
]**+ ,
void++ 
OnDrawingPhaseStart++  
(++  !
int++! $
durationSeconds++% 4
)++4 5
;++5 6
[-- 	
OperationContract--	 
(-- 
IsOneWay-- #
=--$ %
true--& *
)--* +
]--+ ,
void..  
OnGuessingPhaseStart.. !
(..! "

DrawingDto.." ,
drawing..- 4
)..4 5
;..5 6
[00 	
OperationContract00	 
(00 
IsOneWay00 #
=00$ %
true00& *
)00* +
]00+ ,
void11 #
OnInGameMessageReceived11 $
(11$ %
string11% +
sender11, 2
,112 3
string114 :
message11; B
)11B C
;11C D
[33 	
OperationContract33	 
(33 
IsOneWay33 #
=33$ %
true33& *
)33* +
]33+ ,
void44 
OnAnswersPhaseStart44  
(44  !

DrawingDto44! +
[44+ ,
]44, -
allDrawings44. 9
,449 :
GuessDto44; C
[44C D
]44D E

allGuesses44F P
,44P Q
PlayerScoreDto44R `
[44` a
]44a b
currentScores44c p
)44p q
;44q r
[66 	
OperationContract66	 
(66 
IsOneWay66 #
=66$ %
true66& *
)66* +
]66+ ,
void77 
OnShowNextDrawing77 
(77 

DrawingDto77 )
nextDrawing77* 5
)775 6
;776 7
[99 	
OperationContract99	 
(99 
IsOneWay99 #
=99$ %
true99& *
)99* +
]99+ ,
void:: 
	OnGameEnd:: 
(:: 
List:: 
<:: 
PlayerScoreDto:: *
>::* +
finalScores::, 7
)::7 8
;::8 9
};; 
}<< å
¨C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\ServiceContracts\IAuthenticationService.cs
	namespace		 	
GuessMyMessServer		
 
.		 
	Contracts		 %
.		% &
ServiceContracts		& 6
{

 
[ 
ServiceContract 
] 
public 

	interface "
IAuthenticationService +
{ 
[ 	
OperationContract	 
] 
Task 
< 
OperationResultDto 
>  

LoginAsync! +
(+ ,
string, 2
emailOrUsername3 B
,B C
stringD J
passwordK S
)S T
;T U
[ 	
OperationContract	 
] 
Task 
< 
OperationResultDto 
>  
RegisterAsync! .
(. /
UserProfileDto/ =
userProfile> I
,I J
stringK Q
passwordR Z
)Z [
;[ \
[ 	
OperationContract	 
] 
Task 
< 
OperationResultDto 
>  
VerifyAccountAsync! 3
(3 4
string4 :
email; @
,@ A
stringB H
verificationCodeI Y
)Y Z
;Z [
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
LogOut 
( 
string 
username #
)# $
;$ %
[ 	
OperationContract	 
] 
Task 
< 
OperationResultDto 
>  
LoginAsGuestAsync! 2
(2 3
string3 9
username: B
,B C
stringD J

avatarPathK U
)U V
;V W
[ 	
OperationContract	 
] 
Task 
< 
OperationResultDto 
>  )
SendPasswordRecoveryCodeAsync! >
(> ?
string? E
emailF K
)K L
;L M
[   	
OperationContract  	 
]   
Task!! 
<!! 
OperationResultDto!! 
>!!  &
ResetPasswordWithCodeAsync!!! ;
(!!; <
string!!< B
email!!C H
,!!H I
string!!J P
code!!Q U
,!!U V
string!!W ]
newPassword!!^ i
)!!i j
;!!j k
}"" 
}## Î
öC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\DataContracts\WordDto.cs
	namespace 	
GuessMyMessServer
 
. 
	Contracts %
.% &
DataContracts& 3
{ 
[ 
DataContract 
] 
public 

class 
WordDto 
{ 
[ 	

DataMember	 
] 
public		 
int		 
WordId		 
{		 
get		 
;		  
set		! $
;		$ %
}		& '
[ 	

DataMember	 
] 
public 
string 
WordKey 
{ 
get  #
;# $
set% (
;( )
}* +
} 
} —
°C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\DataContracts\UserProfileDto.cs
	namespace 	
GuessMyMessServer
 
. 
	Contracts %
.% &
DataContracts& 3
{		 
[

 
DataContract

 
]

 
public 

class 
UserProfileDto 
{ 
[ 	

DataMember	 
] 
public 
string "
Username# +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
[ 	

DataMember	 
] 
public 
string "
	FirstName# ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
[ 	

DataMember	 
] 
public 
string "
LastName# +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
[ 	

DataMember	 
] 
public 
string "
Email# (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
[ 	

DataMember	 
] 
public 
int 
GenderId 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

DataMember	 
] 
public 
int 
AvatarId 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

DataMember	 
] 
public 
List 
< 
SocialNetworkDto $
>$ %
socialNetworks& 4
{5 6
get7 :
;: ;
set< ?
;? @
}A B
} 
} Ü
£C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\DataContracts\SocialNetworkDto.cs
	namespace 	
GuessMyMessServer
 
. 
	Contracts %
.% &
DataContracts& 3
{		 
[

 
DataContract

 
]

 
public 

class 
SocialNetworkDto !
{ 
[ 	

DataMember	 
] 
public 
string 
NetworkType !
{" #
get$ '
;' (
set) ,
;, -
}. /
[ 	

DataMember	 
] 
public 
string 
UserLink 
{  
get! $
;$ %
set& )
;) *
}+ ,
} 
} ”
°C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\DataContracts\PlayerScoreDto.cs
	namespace 	
GuessMyMessServer
 
. 
	Contracts %
.% &
DataContracts& 3
{		 
[

 
DataContract

 
]

 
public 

class 
PlayerScoreDto 
{ 
[ 	

DataMember	 
] 
public 
string 
Username 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
int 
Score 
{ 
get 
; 
set  #
;# $
}% &
[ 	

DataMember	 
] 
public 
int 
? 
Rank 
{ 
get 
; 
set  #
;# $
}% &
} 
} ™	
•C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\DataContracts\OperationResultDto.cs
	namespace 	
GuessMyMessServer
 
. 
	Contracts %
.% &
DataContracts& 3
{		 
[

 
DataContract

 
]

 
public 

class 
OperationResultDto #
{ 
[ 	

DataMember	 
] 
public 
bool 
Success 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

DataMember	 
] 
public 
string 
Message 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 

Dictionary 
< 
string  
,  !
string" (
>( )
Data* .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
} 
} ˘
£C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\DataContracts\LobbySettingsDto.cs
	namespace 	
GuessMyMessServer
 
. 
	Contracts %
.% &
DataContracts& 3
{		 
[

 
DataContract

 
]

 
public 

class 
LobbySettingsDto !
{ 
[ 	

DataMember	 
] 
public 
string 
	MatchName 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
] 
public 
int 

MaxPlayers 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
int 
TotalRounds 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
int 
DifficultyId 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
] 
public 
bool 
	IsPrivate 
{ 
get  #
;# $
set% (
;( )
}* +
} 
} Û
üC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\DataContracts\MatchInfoDto.cs
	namespace 	
GuessMyMessServer
 
. 
	Contracts %
.% &
DataContracts& 3
{		 
[

 
DataContract

 
]

 
public 

class 
MatchInfoDto 
{ 
[ 	

DataMember	 
] 
public 
string 
MatchId 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
string 
	MatchCode 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
] 
public 
string 
	MatchName 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
] 
public 
string 
HostUsername "
{# $
get% (
;( )
set* -
;- .
}/ 0
[ 	

DataMember	 
] 
public 
int 
CurrentPlayers !
{" #
get$ '
;' (
set) ,
;, -
}. /
[ 	

DataMember	 
] 
public 
int 

MaxPlayers 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public   
string   
DifficultyName   $
{  % &
get  ' *
;  * +
set  , /
;  / 0
}  1 2
["" 	

DataMember""	 
]"" 
public## 
bool## 
	IsPrivate## 
{## 
get##  #
;### $
set##% (
;##( )
}##* +
}$$ 
}%% Û
úC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\DataContracts\FriendDto.cs
	namespace 	
GuessMyMessServer
 
. 
	Contracts %
.% &
DataContracts& 3
{		 
[

 
DataContract

 
]

 
public 

class 
	FriendDto 
{ 
[ 	

DataMember	 
] 
public 
string 
Username 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
bool 
IsOnline 
{ 
get "
;" #
set$ '
;' (
}) *
} 
} ÿ
†C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\DataContracts\LobbyStateDto.cs
	namespace 	
GuessMyMessServer
 
. 
	Contracts %
.% &
DataContracts& 3
{		 
[

 
DataContract

 
]

 
public 

class 
LobbyStateDto 
{ 
[ 	

DataMember	 
] 
public 
string 
	MatchName 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
] 
public 
string 
HostUsername "
{# $
get% (
;( )
set* -
;- .
}/ 0
[ 	

DataMember	 
] 
public 
string 

Difficulty  
{! "
get# &
;& '
set( +
;+ ,
}- .
[ 	

DataMember	 
] 
public 
int 
CurrentPlayers !
{" #
get$ '
;' (
set) ,
;, -
}. /
[ 	

DataMember	 
] 
public 
int 

MaxPlayers 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
string 
	MatchCode 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
] 
public   
List   
<   
string   
>   
PlayerUsernames   +
{  , -
get  . 1
;  1 2
set  3 6
;  6 7
}  8 9
}!! 
}"" ç
ùC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\DataContracts\DrawingDto.cs
	namespace 	
GuessMyMessServer
 
. 
	Contracts %
.% &
DataContracts& 3
{ 
[ 
DataContract 
] 
public 

class 

DrawingDto 
{ 
[ 	

DataMember	 
] 
public		 
int		 
	DrawingId		 
{		 
get		 "
;		" #
set		$ '
;		' (
}		) *
[ 	

DataMember	 
] 
public 
byte 
[ 
] 
DrawingData !
{" #
get$ '
;' (
set) ,
;, -
}. /
[ 	

DataMember	 
] 
public 
string 
OwnerUsername #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 	

DataMember	 
] 
public 
bool 
	IsGuessed 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
string 
WordKey 
{ 
get  #
;# $
set% (
;( )
}* +
} 
} ∏

£C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\DataContracts\DirectMessageDto.cs
	namespace 	
GuessMyMessServer
 
. 
	Contracts %
.% &
DataContracts& 3
{ 
[ 
DataContract 
] 
public 

class 
DirectMessageDto !
{ 
[		 	

DataMember			 
]		 
public

 
string

 
SenderUsername

 $
{

% &
get

' *
;

* +
set

, /
;

/ 0
}

1 2
[ 	

DataMember	 
] 
public 
string 
RecipientUsername '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
[ 	

DataMember	 
] 
public 
string 
Content 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
DateTime 
	Timestamp !
{" #
get$ '
;' (
set) ,
;, -
}. /
} 
} Ì
õC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\DataContracts\GuessDto.cs
	namespace 	
GuessMyMessServer
 
. 
	Contracts %
.% &
DataContracts& 3
{		 
[

 
DataContract

 
]

 
public 

class 
GuessDto 
{ 
[ 	

DataMember	 
] 
public 
string 
GuesserUsername %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
[ 	

DataMember	 
] 
public 
string 
	GuessText 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
] 
public 
bool 
	IsCorrect 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
int 
	DrawingId 
{ 
get "
;" #
set$ '
;' (
}) *
[ 	

DataMember	 
] 
public 
string 
WordKey 
{ 
get  #
;# $
set% (
;( )
}* +
} 
} ô
ßC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\DataContracts\FriendRequestInfoDto.cs
	namespace 	
GuessMyMessServer
 
. 
	Contracts %
.% &
DataContracts& 3
{		 
[

 
DataContract

 
]

 
public 

class  
FriendRequestInfoDto %
{ 
[ 	

DataMember	 
] 
public 
string 
RequesterUsername '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
[ 	

DataMember	 
] 
public 
DateTime 
RequestDate #
{$ %
get& )
;) *
set+ .
;. /
}0 1
} 
} ‰
úC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\DataContracts\AvatarDto.cs
	namespace 	
GuessMyMessServer
 
. 
	Contracts %
.% &
DataContracts& 3
{		 
[

 
DataContract

 
]

 
public 

class 
	AvatarDto 
{ 
[ 	

DataMember	 
] 
public 
int 
IdAvatar 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

DataMember	 
] 
public 
string 

AvatarName  
{! "
get# &
;& '
set( +
;+ ,
}- .
[ 	

DataMember	 
] 
public 
byte 
[ 
] 

AvatarData  
{! "
get# &
;& '
set( +
;+ ,
}- .
} 
} åõ
îC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\BusinessLogic\SocialLogic.cs
	namespace

 	
GuessMyMessServer


 
.

 
BusinessLogic

 )
{ 
public 

class 
SocialLogic 
{ 
private 
readonly 
IEmailService &
_emailService' 4
;4 5
public 
SocialLogic 
( 
IEmailService (
emailService) 5
)5 6
{ 	
_emailService 
= 
emailService (
;( )
} 	
public 
async 
Task 
< 
List 
< 
	FriendDto (
>( )
>) *
GetFriendsListAsync+ >
(> ?
string? E
usernameF N
)N O
{ 	
using 
( 
var 
context 
=  
new! $!
GuessMyMessDBEntities% :
(: ;
); <
)< =
{ 
var 
player 
= 
await "
context# *
.* +
Player+ 1
.1 2
FirstOrDefaultAsync2 E
(E F
pF G
=>H J
pK L
.L M
usernameM U
==V X
usernameY a
)a b
;b c
if 
( 
player 
== 
null "
)" #
{ 
throw 
new %
InvalidOperationException 7
(7 8
$str8 I
)I J
;J K
} 
const 
string 
AcceptedStatus +
=, -
$str. 8
;8 9
const   
string   
OnlineStatus   )
=  * +
$str  , 4
;  4 5
var"" 
friendships"" 
=""  !
await""" '
context""( /
.""/ 0

Friendship""0 :
.## 
Where## 
(## 
f## 
=>## 
(##  !
f##! "
.##" #
Player_idPlayer1### 3
==##4 6
player##7 =
.##= >
idPlayer##> F
||##G I
f##J K
.##K L
Player_idPlayer2##L \
==##] _
player##` f
.##f g
idPlayer##g o
)##o p
&&$$! #
f$$$ %
.$$% &
FriendShipStatus$$& 6
.$$6 7
status$$7 =
==$$> @
AcceptedStatus$$A O
)$$O P
.%% 
Select%% 
(%% 
f%% 
=>%%  
f%%! "
.%%" #
Player_idPlayer1%%# 3
==%%4 6
player%%7 =
.%%= >
idPlayer%%> F
?%%G H
f%%I J
.%%J K
Player1%%K R
:%%S T
f%%U V
.%%V W
Player%%W ]
)%%] ^
.&& 
Select&& 
(&& 
p&& 
=>&&  
new&&! $
{'' 
p(( 
.(( 
username(( "
,((" #
Status)) 
=))  
p))! "
.))" #

UserStatus))# -
.))- .
status)). 4
}** 
)** 
.++ 
ToListAsync++  
(++  !
)++! "
;++" #
return-- 
friendships-- "
.--" #
Select--# )
(--) *
f--* +
=>--, .
new--/ 2
	FriendDto--3 <
{.. 
Username// 
=// 
f//  
.//  !
username//! )
,//) *
IsOnline00 
=00 
f00  
.00  !
Status00! '
==00( *
OnlineStatus00+ 7
}11 
)11 
.11 
ToList11 
(11 
)11 
;11 
}22 
}33 	
public55 
async55 
Task55 
<55 
List55 
<55  
FriendRequestInfoDto55 3
>553 4
>554 5"
GetFriendRequestsAsync556 L
(55L M
string55M S
username55T \
)55\ ]
{66 	
using77 
(77 
var77 
context77 
=77  
new77! $!
GuessMyMessDBEntities77% :
(77: ;
)77; <
)77< =
{88 
var99 
player99 
=99 
await99 "
context99# *
.99* +
Player99+ 1
.991 2
FirstOrDefaultAsync992 E
(99E F
p99F G
=>99H J
p99K L
.99L M
username99M U
==99V X
username99Y a
)99a b
;99b c
if:: 
(:: 
player:: 
==:: 
null:: "
)::" #
{;; 
return<< 
new<< 
List<< #
<<<# $ 
FriendRequestInfoDto<<$ 8
><<8 9
(<<9 :
)<<: ;
;<<; <
}== 
const?? 
string?? 
PendingStatus?? *
=??+ ,
$str??- 6
;??6 7
returnAA 
awaitAA 
contextAA $
.AA$ %

FriendshipAA% /
.BB 
WhereBB 
(BB 
fBB 
=>BB 
fBB  !
.BB! "
Player_idPlayer2BB" 2
==BB3 5
playerBB6 <
.BB< =
idPlayerBB= E
&&BBF H
fBBI J
.BBJ K
FriendShipStatusBBK [
.BB[ \
statusBB\ b
==BBc e
PendingStatusBBf s
)BBs t
.CC 
SelectCC 
(CC 
fCC 
=>CC  
newCC! $ 
FriendRequestInfoDtoCC% 9
{DD 
RequesterUsernameEE )
=EE* +
fEE, -
.EE- .
PlayerEE. 4
.EE4 5
usernameEE5 =
}FF 
)FF 
.FF 
ToListAsyncFF "
(FF" #
)FF# $
;FF$ %
}GG 
}HH 	
publicJJ 
asyncJJ 
TaskJJ 
<JJ 
ListJJ 
<JJ 
UserProfileDtoJJ -
>JJ- .
>JJ. /
SearchUsersAsyncJJ0 @
(JJ@ A
stringJJA G
searchUsernameJJH V
,JJV W
stringJJX ^
requesterUsernameJJ_ p
)JJp q
{KK 	
usingLL 
(LL 
varLL 
contextLL 
=LL  
newLL! $!
GuessMyMessDBEntitiesLL% :
(LL: ;
)LL; <
)LL< =
{MM 
varNN 
	requesterNN 
=NN 
awaitNN  %
contextNN& -
.NN- .
PlayerNN. 4
.NN4 5
FirstOrDefaultAsyncNN5 H
(NNH I
pNNI J
=>NNK M
pNNN O
.NNO P
usernameNNP X
==NNY [
requesterUsernameNN\ m
)NNm n
;NNn o
ifOO 
(OO 
	requesterOO 
==OO  
nullOO! %
)OO% &
{PP 
throwQQ 
newQQ %
InvalidOperationExceptionQQ 7
(QQ7 8
$strQQ8 I
)QQI J
;QQJ K
}RR 
varTT 
requesterIdTT 
=TT  !
	requesterTT" +
.TT+ ,
idPlayerTT, 4
;TT4 5
varVV *
existingRelationshipsPlayerIdsVV 2
=VV3 4
awaitVV5 :
contextVV; B
.VVB C

FriendshipVVC M
.WW 
WhereWW 
(WW 
fWW 
=>WW 
fWW  !
.WW! "
Player_idPlayer1WW" 2
==WW3 5
requesterIdWW6 A
||WWB D
fWWE F
.WWF G
Player_idPlayer2WWG W
==WWX Z
requesterIdWW[ f
)WWf g
.XX 
SelectXX 
(XX 
fXX 
=>XX  
fXX! "
.XX" #
Player_idPlayer1XX# 3
==XX4 6
requesterIdXX7 B
?XXC D
fXXE F
.XXF G
Player_idPlayer2XXG W
:XXX Y
fXXZ [
.XX[ \
Player_idPlayer1XX\ l
)XXl m
.YY 
DistinctYY 
(YY 
)YY 
.ZZ 
ToListAsyncZZ  
(ZZ  !
)ZZ! "
;ZZ" #*
existingRelationshipsPlayerIds\\ .
.\\. /
Add\\/ 2
(\\2 3
requesterId\\3 >
)\\> ?
;\\? @
return^^ 
await^^ 
context^^ $
.^^$ %
Player^^% +
.__ 
Where__ 
(__ 
p__ 
=>__ 
p__  !
.__! "
username__" *
.__* +
Contains__+ 3
(__3 4
searchUsername__4 B
)__B C
&&__D F
!``  !*
existingRelationshipsPlayerIds``! ?
.``? @
Contains``@ H
(``H I
p``I J
.``J K
idPlayer``K S
)``S T
)``T U
.aa 
Selectaa 
(aa 
paa 
=>aa  
newaa! $
UserProfileDtoaa% 3
{bb 
Usernamecc  
=cc! "
pcc# $
.cc$ %
usernamecc% -
}dd 
)dd 
.dd 
ToListAsyncdd "
(dd" #
)dd# $
;dd$ %
}ee 
}ff 	
publichh 
asynchh 
Taskhh "
SendFriendRequestAsynchh 0
(hh0 1
stringhh1 7
requesterUsernamehh8 I
,hhI J
stringhhK Q
targetUsernamehhR `
)hh` a
{ii 	
usingjj 
(jj 
varjj 
contextjj 
=jj  
newjj! $!
GuessMyMessDBEntitiesjj% :
(jj: ;
)jj; <
)jj< =
{kk 
varll 
	requesterll 
=ll 
awaitll  %
contextll& -
.ll- .
Playerll. 4
.ll4 5
FirstOrDefaultAsyncll5 H
(llH I
pllI J
=>llK M
pllN O
.llO P
usernamellP X
==llY [
requesterUsernamell\ m
)llm n
;lln o
varmm 
targetmm 
=mm 
awaitmm "
contextmm# *
.mm* +
Playermm+ 1
.mm1 2
FirstOrDefaultAsyncmm2 E
(mmE F
pmmF G
=>mmH J
pmmK L
.mmL M
usernamemmM U
==mmV X
targetUsernamemmY g
)mmg h
;mmh i
ifoo 
(oo 
	requesteroo 
==oo  
nulloo! %
||oo& (
targetoo) /
==oo0 2
nulloo3 7
)oo7 8
{pp 
throwqq 
newqq %
InvalidOperationExceptionqq 7
(qq7 8
$strqq8 ^
)qq^ _
;qq_ `
}rr 
iftt 
(tt 
	requestertt 
.tt 
idPlayertt &
==tt' )
targettt* 0
.tt0 1
idPlayertt1 9
)tt9 :
{uu 
throwvv 
newvv 
ArgumentExceptionvv /
(vv/ 0
$strvv0 _
)vv_ `
;vv` a
}ww 
varyy 
existingyy 
=yy 
awaityy $
contextyy% ,
.yy, -

Friendshipyy- 7
.yy7 8
FirstOrDefaultAsyncyy8 K
(yyK L
fyyL M
=>yyN P
(zz 
fzz 
.zz 
Player_idPlayer1zz '
==zz( *
	requesterzz+ 4
.zz4 5
idPlayerzz5 =
&&zz> @
fzzA B
.zzB C
Player_idPlayer2zzC S
==zzT V
targetzzW ]
.zz] ^
idPlayerzz^ f
)zzf g
||zzh j
({{ 
f{{ 
.{{ 
Player_idPlayer1{{ '
=={{( *
target{{+ 1
.{{1 2
idPlayer{{2 :
&&{{; =
f{{> ?
.{{? @
Player_idPlayer2{{@ P
=={{Q S
	requester{{T ]
.{{] ^
idPlayer{{^ f
){{f g
){{g h
;{{h i
if}} 
(}} 
existing}} 
!=}} 
null}}  $
)}}$ %
{~~ 
throw 
new %
InvalidOperationException 7
(7 8
$str8 
)	 Ä
;
Ä Å
}
ÄÄ 
const
ÇÇ 
string
ÇÇ 
PendingStatus
ÇÇ *
=
ÇÇ+ ,
$str
ÇÇ- 6
;
ÇÇ6 7
var
ÉÉ !
pendingStatusEntity
ÉÉ '
=
ÉÉ( )
await
ÉÉ* /
context
ÉÉ0 7
.
ÉÉ7 8
FriendShipStatus
ÉÉ8 H
.
ÉÉH I!
FirstOrDefaultAsync
ÉÉI \
(
ÉÉ\ ]
fs
ÉÉ] _
=>
ÉÉ` b
fs
ÉÉc e
.
ÉÉe f
status
ÉÉf l
==
ÉÉm o
PendingStatus
ÉÉp }
)
ÉÉ} ~
;
ÉÉ~ 
if
ÑÑ 
(
ÑÑ !
pendingStatusEntity
ÑÑ '
==
ÑÑ( *
null
ÑÑ+ /
)
ÑÑ/ 0
{
ÖÖ 
throw
ÜÜ 
new
ÜÜ '
InvalidOperationException
ÜÜ 7
(
ÜÜ7 8
$str
ÜÜ8 x
)
ÜÜx y
;
ÜÜy z
}
áá 
var
ââ 

friendship
ââ 
=
ââ  
new
ââ! $

Friendship
ââ% /
{
ää 
Player_idPlayer1
ãã $
=
ãã% &
	requester
ãã' 0
.
ãã0 1
idPlayer
ãã1 9
,
ãã9 :
Player_idPlayer2
åå $
=
åå% &
target
åå' -
.
åå- .
idPlayer
åå. 6
,
åå6 71
#FriendShipStatus_idFriendShipStatus
çç 7
=
çç8 9!
pendingStatusEntity
çç: M
.
ççM N 
idFriendShipStatus
ççN `
}
éé 
;
éé 
context
èè 
.
èè 

Friendship
èè "
.
èè" #
Add
èè# &
(
èè& '

friendship
èè' 1
)
èè1 2
;
èè2 3
await
êê 
context
êê 
.
êê 
SaveChangesAsync
êê .
(
êê. /
)
êê/ 0
;
êê0 1
}
ëë 
}
íí 	
public
îî 
async
îî 
Task
îî )
RespondToFriendRequestAsync
îî 5
(
îî5 6
string
îî6 <
targetUsername
îî= K
,
îîK L
string
îîM S
requesterUsername
îîT e
,
îîe f
bool
îîg k
accepted
îîl t
)
îît u
{
ïï 	
using
ññ 
(
ññ 
var
ññ 
context
ññ 
=
ññ  
new
ññ! $#
GuessMyMessDBEntities
ññ% :
(
ññ: ;
)
ññ; <
)
ññ< =
{
óó 
var
òò 
target
òò 
=
òò 
await
òò "
context
òò# *
.
òò* +
Player
òò+ 1
.
òò1 2!
FirstOrDefaultAsync
òò2 E
(
òòE F
p
òòF G
=>
òòH J
p
òòK L
.
òòL M
username
òòM U
==
òòV X
targetUsername
òòY g
)
òòg h
;
òòh i
var
ôô 
	requester
ôô 
=
ôô 
await
ôô  %
context
ôô& -
.
ôô- .
Player
ôô. 4
.
ôô4 5!
FirstOrDefaultAsync
ôô5 H
(
ôôH I
p
ôôI J
=>
ôôK M
p
ôôN O
.
ôôO P
username
ôôP X
==
ôôY [
requesterUsername
ôô\ m
)
ôôm n
;
ôôn o
if
õõ 
(
õõ 
target
õõ 
==
õõ 
null
õõ "
||
õõ# %
	requester
õõ& /
==
õõ0 2
null
õõ3 7
)
õõ7 8
{
úú 
Console
ùù 
.
ùù 
	WriteLine
ùù %
(
ùù% &
$str
ùù& T
)
ùùT U
;
ùùU V
return
ûû 
;
ûû 
}
üü 
const
°° 
string
°° 
PendingStatus
°° *
=
°°+ ,
$str
°°- 6
;
°°6 7
var
¢¢ 

friendship
¢¢ 
=
¢¢  
await
¢¢! &
context
¢¢' .
.
¢¢. /

Friendship
¢¢/ 9
.
££ 
Include
££ 
(
££ 
f
££ 
=>
££ !
f
££" #
.
££# $
FriendShipStatus
££$ 4
)
££4 5
.
§§ !
FirstOrDefaultAsync
§§ (
(
§§( )
f
§§) *
=>
§§+ -
f
§§. /
.
§§/ 0
Player_idPlayer1
§§0 @
==
§§A C
	requester
§§D M
.
§§M N
idPlayer
§§N V
&&
§§W Y
f
••0 1
.
••1 2
Player_idPlayer2
••2 B
==
••C E
target
••F L
.
••L M
idPlayer
••M U
&&
••V X
f
¶¶0 1
.
¶¶1 2
FriendShipStatus
¶¶2 B
.
¶¶B C
status
¶¶C I
==
¶¶J L
PendingStatus
¶¶M Z
)
¶¶Z [
;
¶¶[ \
if
®® 
(
®® 

friendship
®® 
==
®® !
null
®®" &
)
®®& '
{
©© 
throw
™™ 
new
™™ '
InvalidOperationException
™™ 7
(
™™7 8
$str
™™8 g
)
™™g h
;
™™h i
}
´´ 
if
≠≠ 
(
≠≠ 
accepted
≠≠ 
)
≠≠ 
{
ÆÆ 
const
ØØ 
string
ØØ  
AcceptedStatus
ØØ! /
=
ØØ0 1
$str
ØØ2 <
;
ØØ< =
var
∞∞ "
acceptedStatusEntity
∞∞ ,
=
∞∞- .
await
∞∞/ 4
context
∞∞5 <
.
∞∞< =
FriendShipStatus
∞∞= M
.
∞∞M N!
FirstOrDefaultAsync
∞∞N a
(
∞∞a b
fs
∞∞b d
=>
∞∞e g
fs
∞∞h j
.
∞∞j k
status
∞∞k q
==
∞∞r t
AcceptedStatus∞∞u É
)∞∞É Ñ
;∞∞Ñ Ö
if
±± 
(
±± "
acceptedStatusEntity
±± ,
==
±±- /
null
±±0 4
)
±±4 5
{
≤≤ 
throw
≥≥ 
new
≥≥ !'
InvalidOperationException
≥≥" ;
(
≥≥; <
$str
≥≥< }
)
≥≥} ~
;
≥≥~ 
}
¥¥ 

friendship
µµ 
.
µµ 1
#FriendShipStatus_idFriendShipStatus
µµ B
=
µµC D"
acceptedStatusEntity
µµE Y
.
µµY Z 
idFriendShipStatus
µµZ l
;
µµl m
}
∂∂ 
else
∑∑ 
{
∏∏ 
context
ππ 
.
ππ 

Friendship
ππ &
.
ππ& '
Remove
ππ' -
(
ππ- .

friendship
ππ. 8
)
ππ8 9
;
ππ9 :
}
∫∫ 
await
ªª 
context
ªª 
.
ªª 
SaveChangesAsync
ªª .
(
ªª. /
)
ªª/ 0
;
ªª0 1
}
ºº 
}
ΩΩ 	
public
øø 
async
øø 
Task
øø 
RemoveFriendAsync
øø +
(
øø+ ,
string
øø, 2
username
øø3 ;
,
øø; <
string
øø= C
friendToRemove
øøD R
)
øøR S
{
¿¿ 	
using
¡¡ 
(
¡¡ 
var
¡¡ 
context
¡¡ 
=
¡¡  
new
¡¡! $#
GuessMyMessDBEntities
¡¡% :
(
¡¡: ;
)
¡¡; <
)
¡¡< =
{
¬¬ 
var
√√ 
player
√√ 
=
√√ 
await
√√ "
context
√√# *
.
√√* +
Player
√√+ 1
.
√√1 2!
FirstOrDefaultAsync
√√2 E
(
√√E F
p
√√F G
=>
√√H J
p
√√K L
.
√√L M
username
√√M U
==
√√V X
username
√√Y a
)
√√a b
;
√√b c
var
ƒƒ 
friend
ƒƒ 
=
ƒƒ 
await
ƒƒ "
context
ƒƒ# *
.
ƒƒ* +
Player
ƒƒ+ 1
.
ƒƒ1 2!
FirstOrDefaultAsync
ƒƒ2 E
(
ƒƒE F
p
ƒƒF G
=>
ƒƒH J
p
ƒƒK L
.
ƒƒL M
username
ƒƒM U
==
ƒƒV X
friendToRemove
ƒƒY g
)
ƒƒg h
;
ƒƒh i
if
∆∆ 
(
∆∆ 
player
∆∆ 
==
∆∆ 
null
∆∆ "
||
∆∆# %
friend
∆∆& ,
==
∆∆- /
null
∆∆0 4
)
∆∆4 5
{
«« 
Console
»» 
.
»» 
	WriteLine
»» %
(
»»% &
$str
»»& N
)
»»N O
;
»»O P
return
…… 
;
…… 
}
   
var
ÃÃ 

friendship
ÃÃ 
=
ÃÃ  
await
ÃÃ! &
context
ÃÃ' .
.
ÃÃ. /

Friendship
ÃÃ/ 9
.
ÃÃ9 :!
FirstOrDefaultAsync
ÃÃ: M
(
ÃÃM N
f
ÃÃN O
=>
ÃÃP R
(
ÕÕ 
f
ÕÕ 
.
ÕÕ 
Player_idPlayer1
ÕÕ '
==
ÕÕ( *
player
ÕÕ+ 1
.
ÕÕ1 2
idPlayer
ÕÕ2 :
&&
ÕÕ; =
f
ÕÕ> ?
.
ÕÕ? @
Player_idPlayer2
ÕÕ@ P
==
ÕÕQ S
friend
ÕÕT Z
.
ÕÕZ [
idPlayer
ÕÕ[ c
)
ÕÕc d
||
ÕÕe g
(
ŒŒ 
f
ŒŒ 
.
ŒŒ 
Player_idPlayer1
ŒŒ '
==
ŒŒ( *
friend
ŒŒ+ 1
.
ŒŒ1 2
idPlayer
ŒŒ2 :
&&
ŒŒ; =
f
ŒŒ> ?
.
ŒŒ? @
Player_idPlayer2
ŒŒ@ P
==
ŒŒQ S
player
ŒŒT Z
.
ŒŒZ [
idPlayer
ŒŒ[ c
)
ŒŒc d
)
ŒŒd e
;
ŒŒe f
if
–– 
(
–– 

friendship
–– 
!=
–– !
null
––" &
)
––& '
{
—— 
context
““ 
.
““ 

Friendship
““ &
.
““& '
Remove
““' -
(
““- .

friendship
““. 8
)
““8 9
;
““9 :
await
”” 
context
”” !
.
””! "
SaveChangesAsync
””" 2
(
””2 3
)
””3 4
;
””4 5
}
‘‘ 
else
’’ 
{
÷÷ 
Console
◊◊ 
.
◊◊ 
	WriteLine
◊◊ %
(
◊◊% &
$"
◊◊& (
$str
◊◊( Z
{
◊◊Z [
username
◊◊[ c
}
◊◊c d
$str
◊◊d i
{
◊◊i j
friendToRemove
◊◊j x
}
◊◊x y
$str
◊◊y z
"
◊◊z {
)
◊◊{ |
;
◊◊| }
}
ÿÿ 
}
ŸŸ 
}
⁄⁄ 	
public
‹‹ 
async
‹‹ 
Task
‹‹ %
UpdatePlayerStatusAsync
‹‹ 1
(
‹‹1 2
string
‹‹2 8
username
‹‹9 A
,
‹‹A B
string
‹‹C I
status
‹‹J P
)
‹‹P Q
{
›› 	
using
ﬁﬁ 
(
ﬁﬁ 
var
ﬁﬁ 
context
ﬁﬁ 
=
ﬁﬁ  
new
ﬁﬁ! $#
GuessMyMessDBEntities
ﬁﬁ% :
(
ﬁﬁ: ;
)
ﬁﬁ; <
)
ﬁﬁ< =
{
ﬂﬂ 
var
‡‡ 
player
‡‡ 
=
‡‡ 
await
‡‡ "
context
‡‡# *
.
‡‡* +
Player
‡‡+ 1
.
‡‡1 2!
FirstOrDefaultAsync
‡‡2 E
(
‡‡E F
p
‡‡F G
=>
‡‡H J
p
‡‡K L
.
‡‡L M
username
‡‡M U
==
‡‡V X
username
‡‡Y a
)
‡‡a b
;
‡‡b c
if
·· 
(
·· 
player
·· 
==
·· 
null
·· "
)
··" #
{
‚‚ 
throw
„„ 
new
„„ '
InvalidOperationException
„„ 7
(
„„7 8
$"
„„8 :
$str
„„: @
{
„„@ A
username
„„A I
}
„„I J
$str
„„J g
"
„„g h
)
„„h i
;
„„i j
}
‰‰ 
var
ÊÊ 

userStatus
ÊÊ 
=
ÊÊ  
await
ÊÊ! &
context
ÊÊ' .
.
ÊÊ. /

UserStatus
ÊÊ/ 9
.
ÊÊ9 :!
FirstOrDefaultAsync
ÊÊ: M
(
ÊÊM N
s
ÊÊN O
=>
ÊÊP R
s
ÊÊS T
.
ÊÊT U
status
ÊÊU [
==
ÊÊ\ ^
status
ÊÊ_ e
)
ÊÊe f
;
ÊÊf g
if
ÁÁ 
(
ÁÁ 

userStatus
ÁÁ 
==
ÁÁ !
null
ÁÁ" &
)
ÁÁ& '
{
ËË 
throw
ÈÈ 
new
ÈÈ '
InvalidOperationException
ÈÈ 7
(
ÈÈ7 8
$"
ÈÈ8 :
$str
ÈÈ: G
{
ÈÈG H
status
ÈÈH N
}
ÈÈN O
$str
ÈÈO ^
"
ÈÈ^ _
)
ÈÈ_ `
;
ÈÈ` a
}
ÍÍ 
if
ÏÏ 
(
ÏÏ 
player
ÏÏ 
.
ÏÏ %
UserStatus_idUserStatus
ÏÏ 2
!=
ÏÏ3 5

userStatus
ÏÏ6 @
.
ÏÏ@ A
idUserStatus
ÏÏA M
)
ÏÏM N
{
ÌÌ 
player
ÓÓ 
.
ÓÓ %
UserStatus_idUserStatus
ÓÓ 2
=
ÓÓ3 4

userStatus
ÓÓ5 ?
.
ÓÓ? @
idUserStatus
ÓÓ@ L
;
ÓÓL M
await
ÔÔ 
context
ÔÔ !
.
ÔÔ! "
SaveChangesAsync
ÔÔ" 2
(
ÔÔ2 3
)
ÔÔ3 4
;
ÔÔ4 5
}
 
}
ÒÒ 
}
ÚÚ 	
public
ÙÙ 
async
ÙÙ 
Task
ÙÙ $
SendDirectMessageAsync
ÙÙ 0
(
ÙÙ0 1
DirectMessageDto
ÙÙ1 A
message
ÙÙB I
)
ÙÙI J
{
ıı 	
if
ˆˆ 
(
ˆˆ 
message
ˆˆ 
==
ˆˆ 
null
ˆˆ 
||
ˆˆ  "
string
ˆˆ# )
.
ˆˆ) * 
IsNullOrWhiteSpace
ˆˆ* <
(
ˆˆ< =
message
ˆˆ= D
.
ˆˆD E
SenderUsername
ˆˆE S
)
ˆˆS T
||
ˆˆU W
string
˜˜ 
.
˜˜  
IsNullOrWhiteSpace
˜˜ )
(
˜˜) *
message
˜˜* 1
.
˜˜1 2
RecipientUsername
˜˜2 C
)
˜˜C D
||
˜˜E G
string
˜˜H N
.
˜˜N O 
IsNullOrWhiteSpace
˜˜O a
(
˜˜a b
message
˜˜b i
.
˜˜i j
Content
˜˜j q
)
˜˜q r
)
˜˜r s
{
¯¯ 
throw
˘˘ 
new
˘˘ 
ArgumentException
˘˘ +
(
˘˘+ ,
$str
˘˘, W
)
˘˘W X
;
˘˘X Y
}
˙˙ 
using
¸¸ 
(
¸¸ 
var
¸¸ 
	dbContext
¸¸  
=
¸¸! "
new
¸¸# &#
GuessMyMessDBEntities
¸¸' <
(
¸¸< =
)
¸¸= >
)
¸¸> ?
{
˝˝ 
var
˛˛ 
sender
˛˛ 
=
˛˛ 
await
˛˛ "
	dbContext
˛˛# ,
.
˛˛, -
Player
˛˛- 3
.
˛˛3 4!
FirstOrDefaultAsync
˛˛4 G
(
˛˛G H
p
˛˛H I
=>
˛˛J L
p
˛˛M N
.
˛˛N O
username
˛˛O W
==
˛˛X Z
message
˛˛[ b
.
˛˛b c
SenderUsername
˛˛c q
)
˛˛q r
;
˛˛r s
var
ˇˇ 
	recipient
ˇˇ 
=
ˇˇ 
await
ˇˇ  %
	dbContext
ˇˇ& /
.
ˇˇ/ 0
Player
ˇˇ0 6
.
ˇˇ6 7!
FirstOrDefaultAsync
ˇˇ7 J
(
ˇˇJ K
p
ˇˇK L
=>
ˇˇM O
p
ˇˇP Q
.
ˇˇQ R
username
ˇˇR Z
==
ˇˇ[ ]
message
ˇˇ^ e
.
ˇˇe f
RecipientUsername
ˇˇf w
)
ˇˇw x
;
ˇˇx y
if
ÅÅ 
(
ÅÅ 
sender
ÅÅ 
==
ÅÅ 
null
ÅÅ "
||
ÅÅ# %
	recipient
ÅÅ& /
==
ÅÅ0 2
null
ÅÅ3 7
)
ÅÅ7 8
{
ÇÇ 
throw
ÉÉ 
new
ÉÉ '
InvalidOperationException
ÉÉ 7
(
ÉÉ7 8
$str
ÉÉ8 p
)
ÉÉp q
;
ÉÉq r
}
ÑÑ 
var
ÜÜ 
	dbMessage
ÜÜ 
=
ÜÜ 
new
ÜÜ  #
DirectMessages
ÜÜ$ 2
{
áá 
SenderPlayerID
àà "
=
àà# $
sender
àà% +
.
àà+ ,
idPlayer
àà, 4
,
àà4 5
RecipientPlayerID
ââ %
=
ââ& '
	recipient
ââ( 1
.
ââ1 2
idPlayer
ââ2 :
,
ââ: ;
MessageContent
ää "
=
ää# $
message
ää% ,
.
ää, -
Content
ää- 4
,
ää4 5
	Timestamp
ãã 
=
ãã 
DateTime
ãã  (
.
ãã( )
UtcNow
ãã) /
}
åå 
;
åå 
	dbContext
éé 
.
éé 
DirectMessages
éé (
.
éé( )
Add
éé) ,
(
éé, -
	dbMessage
éé- 6
)
éé6 7
;
éé7 8
await
èè 
	dbContext
èè 
.
èè  
SaveChangesAsync
èè  0
(
èè0 1
)
èè1 2
;
èè2 3
message
ëë 
.
ëë 
	Timestamp
ëë !
=
ëë" #
	dbMessage
ëë$ -
.
ëë- .
	Timestamp
ëë. 7
;
ëë7 8
}
íí 
}
ìì 	
public
ïï 
async
ïï 
Task
ïï 
<
ïï 
List
ïï 
<
ïï 
	FriendDto
ïï (
>
ïï( )
>
ïï) *#
GetConversationsAsync
ïï+ @
(
ïï@ A
string
ïïA G
username
ïïH P
)
ïïP Q
{
ññ 	
using
óó 
(
óó 
var
óó 
	dbContext
óó  
=
óó! "
new
óó# &#
GuessMyMessDBEntities
óó' <
(
óó< =
)
óó= >
)
óó> ?
{
òò 
var
ôô 
user
ôô 
=
ôô 
await
ôô  
	dbContext
ôô! *
.
ôô* +
Player
ôô+ 1
.
ôô1 2!
FirstOrDefaultAsync
ôô2 E
(
ôôE F
p
ôôF G
=>
ôôH J
p
ôôK L
.
ôôL M
username
ôôM U
==
ôôV X
username
ôôY a
)
ôôa b
;
ôôb c
if
öö 
(
öö 
user
öö 
==
öö 
null
öö  
)
öö  !
{
õõ 
return
úú 
new
úú 
List
úú #
<
úú# $
	FriendDto
úú$ -
>
úú- .
(
úú. /
)
úú/ 0
;
úú0 1
}
ùù 
var
üü 
userId
üü 
=
üü 
user
üü !
.
üü! "
idPlayer
üü" *
;
üü* +
var
°° 
counterpartIds
°° "
=
°°# $
await
°°% *
	dbContext
°°+ 4
.
°°4 5
DirectMessages
°°5 C
.
¢¢ 
Where
¢¢ 
(
¢¢ 
m
¢¢ 
=>
¢¢ 
m
¢¢  !
.
¢¢! "
SenderPlayerID
¢¢" 0
==
¢¢1 3
userId
¢¢4 :
||
¢¢; =
m
¢¢> ?
.
¢¢? @
RecipientPlayerID
¢¢@ Q
==
¢¢R T
userId
¢¢U [
)
¢¢[ \
.
££ 
Select
££ 
(
££ 
m
££ 
=>
££  
m
££! "
.
££" #
SenderPlayerID
££# 1
==
££2 4
userId
££5 ;
?
££< =
m
££> ?
.
££? @
RecipientPlayerID
££@ Q
:
££R S
m
££T U
.
££U V
SenderPlayerID
££V d
)
££d e
.
§§ 
Distinct
§§ 
(
§§ 
)
§§ 
.
•• 
ToListAsync
••  
(
••  !
)
••! "
;
••" #
const
ßß 
string
ßß 
OnlineStatus
ßß )
=
ßß* +
$str
ßß, 4
;
ßß4 5
return
©© 
await
©© 
	dbContext
©© &
.
©©& '
Player
©©' -
.
™™ 
Where
™™ 
(
™™ 
p
™™ 
=>
™™ 
counterpartIds
™™  .
.
™™. /
Contains
™™/ 7
(
™™7 8
p
™™8 9
.
™™9 :
idPlayer
™™: B
)
™™B C
)
™™C D
.
´´ 
Select
´´ 
(
´´ 
p
´´ 
=>
´´  
new
´´! $
	FriendDto
´´% .
{
¨¨ 
Username
≠≠  
=
≠≠! "
p
≠≠# $
.
≠≠$ %
username
≠≠% -
,
≠≠- .
IsOnline
ÆÆ  
=
ÆÆ! "
p
ÆÆ# $
.
ÆÆ$ %

UserStatus
ÆÆ% /
.
ÆÆ/ 0
status
ÆÆ0 6
==
ÆÆ7 9
OnlineStatus
ÆÆ: F
}
ØØ 
)
ØØ 
.
∞∞ 
ToListAsync
∞∞  
(
∞∞  !
)
∞∞! "
;
∞∞" #
}
±± 
}
≤≤ 	
public
¥¥ 
async
¥¥ 
Task
¥¥ 
<
¥¥ 
List
¥¥ 
<
¥¥ 
DirectMessageDto
¥¥ /
>
¥¥/ 0
>
¥¥0 1)
GetConversationHistoryAsync
¥¥2 M
(
¥¥M N
string
¥¥N T
user1
¥¥U Z
,
¥¥Z [
string
¥¥\ b
user2
¥¥c h
)
¥¥h i
{
µµ 	
using
∂∂ 
(
∂∂ 
var
∂∂ 
	dbContext
∂∂  
=
∂∂! "
new
∂∂# &#
GuessMyMessDBEntities
∂∂' <
(
∂∂< =
)
∂∂= >
)
∂∂> ?
{
∑∑ 
var
∏∏ 
player1
∏∏ 
=
∏∏ 
await
∏∏ #
	dbContext
∏∏$ -
.
∏∏- .
Player
∏∏. 4
.
∏∏4 5!
FirstOrDefaultAsync
∏∏5 H
(
∏∏H I
p
∏∏I J
=>
∏∏K M
p
∏∏N O
.
∏∏O P
username
∏∏P X
==
∏∏Y [
user1
∏∏\ a
)
∏∏a b
;
∏∏b c
var
ππ 
player2
ππ 
=
ππ 
await
ππ #
	dbContext
ππ$ -
.
ππ- .
Player
ππ. 4
.
ππ4 5!
FirstOrDefaultAsync
ππ5 H
(
ππH I
p
ππI J
=>
ππK M
p
ππN O
.
ππO P
username
ππP X
==
ππY [
user2
ππ\ a
)
ππa b
;
ππb c
if
ªª 
(
ªª 
player1
ªª 
==
ªª 
null
ªª #
||
ªª$ &
player2
ªª' .
==
ªª/ 1
null
ªª2 6
)
ªª6 7
{
ºº 
return
ΩΩ 
new
ΩΩ 
List
ΩΩ #
<
ΩΩ# $
DirectMessageDto
ΩΩ$ 4
>
ΩΩ4 5
(
ΩΩ5 6
)
ΩΩ6 7
;
ΩΩ7 8
}
ææ 
return
¿¿ 
await
¿¿ 
	dbContext
¿¿ &
.
¿¿& '
DirectMessages
¿¿' 5
.
¡¡ 
Where
¡¡ 
(
¡¡ 
m
¡¡ 
=>
¡¡ 
(
¡¡  !
m
¡¡! "
.
¡¡" #
SenderPlayerID
¡¡# 1
==
¡¡2 4
player1
¡¡5 <
.
¡¡< =
idPlayer
¡¡= E
&&
¡¡F H
m
¡¡I J
.
¡¡J K
RecipientPlayerID
¡¡K \
==
¡¡] _
player2
¡¡` g
.
¡¡g h
idPlayer
¡¡h p
)
¡¡p q
||
¡¡r t
(
¬¬  !
m
¬¬! "
.
¬¬" #
SenderPlayerID
¬¬# 1
==
¬¬2 4
player2
¬¬5 <
.
¬¬< =
idPlayer
¬¬= E
&&
¬¬F H
m
¬¬I J
.
¬¬J K
RecipientPlayerID
¬¬K \
==
¬¬] _
player1
¬¬` g
.
¬¬g h
idPlayer
¬¬h p
)
¬¬p q
)
¬¬q r
.
√√ 
OrderBy
√√ 
(
√√ 
m
√√ 
=>
√√ !
m
√√" #
.
√√# $
	Timestamp
√√$ -
)
√√- .
.
ƒƒ 
Select
ƒƒ 
(
ƒƒ 
m
ƒƒ 
=>
ƒƒ  
new
ƒƒ! $
DirectMessageDto
ƒƒ% 5
{
≈≈ 
SenderUsername
∆∆ &
=
∆∆' (
m
∆∆) *
.
∆∆* +
Player1
∆∆+ 2
.
∆∆2 3
username
∆∆3 ;
,
∆∆; <
RecipientUsername
«« )
=
««* +
m
««, -
.
««- .
Player
««. 4
.
««4 5
username
««5 =
,
««= >
Content
»» 
=
»»  !
m
»»" #
.
»»# $
MessageContent
»»$ 2
,
»»2 3
	Timestamp
…… !
=
……" #
m
……$ %
.
……% &
	Timestamp
……& /
}
   
)
   
.
ÀÀ 
ToListAsync
ÀÀ  
(
ÀÀ  !
)
ÀÀ! "
;
ÀÀ" #
}
ÃÃ 
}
ÕÕ 	
}
ŒŒ 
}œœ àï
ôC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\BusinessLogic\MatchmakingLogic.cs
	namespace 	
GuessMyMessServer
 
. 
BusinessLogic )
{ 
public 

static 
class 
MatchmakingLogic (
{ 
private 
const 
string 
MatchStatusWaiting /
=0 1
$str2 ;
;; <
private 
static 
readonly  
ConcurrentDictionary  4
<4 5
string5 ;
,; <'
IMatchmakingServiceCallback= X
>X Y
_connectedUsersZ i
=j k
new  
ConcurrentDictionary $
<$ %
string% +
,+ ,'
IMatchmakingServiceCallback- H
>H I
(I J
)J K
;K L
private 
static 
readonly  
ConcurrentDictionary  4
<4 5
string5 ;
,; <

MatchLobby= G
>G H
_activeLobbiesI W
=X Y
new  
ConcurrentDictionary $
<$ %
string% +
,+ ,

MatchLobby- 7
>7 8
(8 9
)9 :
;: ;
public 
static 
void 
ConnectUser &
(& '
string' -
username. 6
,6 7'
IMatchmakingServiceCallback8 S
callbackT \
)\ ]
{ 	
_connectedUsers 
. 
TryAdd "
(" #
username# +
,+ ,
callback- 5
)5 6
;6 7
} 	
public 
static 
void 
DisconnectUser )
() *
string* 0
username1 9
)9 :
{ 	
_connectedUsers   
.   
	TryRemove   %
(  % &
username  & .
,  . /
out  0 3
_  4 5
)  5 6
;  6 7
var"" 
lobby"" 
="" 
_activeLobbies"" &
.""& '
Values""' -
.""- .
FirstOrDefault"". <
(""< =
l""= >
=>""? A
l""B C
.""C D
Players""D K
.""K L
Contains""L T
(""T U
username""U ]
)""] ^
)""^ _
;""_ `
if## 
(## 
lobby## 
!=## 
null## 
)## 
{$$ 
HandlePlayerLeave%% !
(%%! "
username%%" *
,%%* +
lobby%%, 1
.%%1 2
MatchId%%2 9
)%%9 :
;%%: ;
}&& 
}'' 	
public)) 
static)) 
OperationResultDto)) (
CreateMatch))) 4
())4 5
string))5 ;
hostUsername))< H
,))H I
LobbySettingsDto))J Z
settings))[ c
)))c d
{** 	
try++ 
{,, 
using-- 
(-- 
var-- 
context-- "
=--# $
new--% (!
GuessMyMessDBEntities--) >
(--> ?
)--? @
)--@ A
{.. 
var// 

hostPlayer// "
=//# $
context//% ,
.//, -
Player//- 3
.//3 4
FirstOrDefault//4 B
(//B C
p//C D
=>//E G
p//H I
.//I J
username//J R
==//S U
hostUsername//V b
)//b c
;//c d
if00 
(00 

hostPlayer00 "
==00# %
null00& *
)00* +
{11 
return22 
new22 "
OperationResultDto22# 5
{226 7
Success228 ?
=22@ A
false22B G
,22G H
Message22I P
=22Q R
$str22S i
}22j k
;22k l
}33 
string55 
newMatchCode55 '
=55( )
null55* .
;55. /
byte66 
isPrivateValue66 '
=66( )
(66* +
byte66+ /
)66/ 0
(660 1
settings661 9
.669 :
	IsPrivate66: C
?66D E
$num66F G
:66H I
$num66J K
)66K L
;66L M
if88 
(88 
settings88  
.88  !
	IsPrivate88! *
)88* +
{99 
newMatchCode:: $
=::% &
GenerateMatchCode::' 8
(::8 9
$num::9 :
)::: ;
;::; <
while;; 
(;; 
context;; &
.;;& '
Match;;' ,
.;;, -
Any;;- 0
(;;0 1
m;;1 2
=>;;3 5
m;;6 7
.;;7 8
	matchCode;;8 A
==;;B D
newMatchCode;;E Q
&&;;R T
m;;U V
.;;V W
matchStatus;;W b
==;;c e
MatchStatusWaiting;;f x
);;x y
);;y z
{<< 
newMatchCode== (
===) *
GenerateMatchCode==+ <
(==< =
$num=== >
)==> ?
;==? @
}>> 
}?? 
varAA 
newMatchAA  
=AA! "
newAA# &
MatchAA' ,
{BB 
	matchNameCC !
=CC" #
settingsCC$ ,
.CC, -
	MatchNameCC- 6
,CC6 7

maxPlayersDD "
=DD# $
settingsDD% -
.DD- .

MaxPlayersDD. 8
,DD8 9
currentPlayersEE &
=EE' (
$numEE) *
,EE* +
totalRoundsFF #
=FF$ %
settingsFF& .
.FF. /
TotalRoundsFF/ :
,FF: ;
	isPrivateGG !
=GG" #
isPrivateValueGG$ 2
,GG2 3
	matchCodeHH !
=HH" #
newMatchCodeHH$ 0
,HH0 1
matchStatusII #
=II$ %
MatchStatusWaitingII& 8
,II8 9
Player_idHostJJ %
=JJ& '

hostPlayerJJ( 2
.JJ2 3
idPlayerJJ3 ;
,JJ; <-
!MatchDifficulty_idMatchDifficultyKK 9
=KK: ;
settingsKK< D
.KKD E
DifficultyIdKKE Q
}LL 
;LL 
contextNN 
.NN 
MatchNN !
.NN! "
AddNN" %
(NN% &
newMatchNN& .
)NN. /
;NN/ 0
contextOO 
.OO 
SaveChangesOO '
(OO' (
)OO( )
;OO) *
stringQQ 
matchIdQQ "
=QQ# $
newMatchQQ% -
.QQ- .
idMatchQQ. 5
.QQ5 6
ToStringQQ6 >
(QQ> ?
)QQ? @
;QQ@ A
varRR 
lobbyRR 
=RR 
newRR  #

MatchLobbyRR$ .
(RR. /
matchIdRR/ 6
,RR6 7
newMatchCodeRR8 D
,RRD E
hostUsernameRRF R
,RRR S
settingsRRT \
)RR\ ]
{SS 
CurrentPlayersTT &
=TT' (
$numTT) *
}UU 
;UU 
lobbyVV 
.VV 
PlayersVV !
.VV! "
AddVV" %
(VV% &
hostUsernameVV& 2
)VV2 3
;VV3 4
_activeLobbiesWW "
.WW" #
TryAddWW# )
(WW) *
matchIdWW* 1
,WW1 2
lobbyWW3 8
)WW8 9
;WW9 :
ifYY 
(YY 
!YY 
settingsYY !
.YY! "
	IsPrivateYY" +
)YY+ ,
{ZZ $
BroadcastPublicMatchList[[ 0
([[0 1
)[[1 2
;[[2 3
}\\ 
return^^ 
new^^ 
OperationResultDto^^ 1
{__ 
Success`` 
=``  !
true``" &
,``& '
Messageaa 
=aa  !
$straa" 2
,aa2 3
Databb 
=bb 
newbb "

Dictionarybb# -
<bb- .
stringbb. 4
,bb4 5
stringbb6 <
>bb< =
{cc 
{dd 
$strdd '
,dd' (
matchIddd) 0
}dd1 2
,dd2 3
{ee 
$stree )
,ee) *
newMatchCodeee+ 7
}ee8 9
}ff 
}gg 
;gg 
}hh 
}ii 
catchjj 
(jj 
	Exceptionjj 
exjj 
)jj  
{kk 
returnll 
newll 
OperationResultDtoll -
{ll. /
Successll0 7
=ll8 9
falsell: ?
,ll? @
MessagellA H
=llI J
$strllK j
+llk l
exllm o
.llo p
Messagellp w
}llx y
;lly z
}mm 
}nn 	
publicpp 
staticpp 
Listpp 
<pp 
MatchInfoDtopp '
>pp' (
GetPublicMatchespp) 9
(pp9 :
)pp: ;
{qq 	
returnrr 
_activeLobbiesrr !
.rr! "
Valuesrr" (
.ss 
Wheress 
(ss 
lss 
=>ss 
!ss 
lss 
.ss 
Settingsss '
.ss' (
	IsPrivatess( 1
&&ss2 4
lss5 6
.ss6 7
Statusss7 =
==ss> @
$strssA J
)ssJ K
.tt 
Selecttt 
(tt 
ltt 
=>tt 
ltt 
.tt 
ToMatchInfoDtott -
(tt- .
)tt. /
)tt/ 0
.uu 
ToListuu 
(uu 
)uu 
;uu 
}vv 	
publicxx 
staticxx 
voidxx 
JoinPublicMatchxx *
(xx* +
stringxx+ 1
usernamexx2 :
,xx: ;
stringxx< B
matchIdxxC J
)xxJ K
{yy 	
_connectedUserszz 
.zz 
TryGetValuezz '
(zz' (
usernamezz( 0
,zz0 1
outzz2 5
varzz6 9
callbackzz: B
)zzB C
;zzC D
if{{ 
({{ 
callback{{ 
=={{ 
null{{  
){{  !
return{{" (
;{{( )
if}} 
(}} 
_activeLobbies}} 
.}} 
TryGetValue}} *
(}}* +
matchId}}+ 2
,}}2 3
out}}4 7
var}}8 ;
lobby}}< A
)}}A B
)}}B C
{~~ 
if 
( 
lobby 
. 
CurrentPlayers (
>=) +
lobby, 1
.1 2
Settings2 :
.: ;

MaxPlayers; E
)E F
{
ÄÄ 
callback
ÅÅ 
.
ÅÅ 
MatchJoined
ÅÅ (
(
ÅÅ( )
null
ÅÅ) -
,
ÅÅ- .
new
ÅÅ/ 2 
OperationResultDto
ÅÅ3 E
{
ÅÅF G
Success
ÅÅH O
=
ÅÅP Q
false
ÅÅR W
,
ÅÅW X
Message
ÅÅY `
=
ÅÅa b
$str
ÅÅc s
}
ÅÅt u
)
ÅÅu v
;
ÅÅv w
return
ÇÇ 
;
ÇÇ 
}
ÉÉ 
if
ÑÑ 
(
ÑÑ 
lobby
ÑÑ 
.
ÑÑ 
Status
ÑÑ  
!=
ÑÑ! #
$str
ÑÑ$ -
)
ÑÑ- .
{
ÖÖ 
callback
ÜÜ 
.
ÜÜ 
MatchJoined
ÜÜ (
(
ÜÜ( )
null
ÜÜ) -
,
ÜÜ- .
new
ÜÜ/ 2 
OperationResultDto
ÜÜ3 E
{
ÜÜF G
Success
ÜÜH O
=
ÜÜP Q
false
ÜÜR W
,
ÜÜW X
Message
ÜÜY `
=
ÜÜa b
$str
ÜÜc 
}ÜÜÄ Å
)ÜÜÅ Ç
;ÜÜÇ É
return
áá 
;
áá 
}
àà 
lobby
ää 
.
ää 
Players
ää 
.
ää 
Add
ää !
(
ää! "
username
ää" *
)
ää* +
;
ää+ ,
lobby
ãã 
.
ãã 
CurrentPlayers
ãã $
++
ãã$ &
;
ãã& '#
UpdatePlayerCountInDb
åå %
(
åå% &
lobby
åå& +
.
åå+ ,
MatchId
åå, 3
,
åå3 4
$num
åå5 6
)
åå6 7
;
åå7 8
callback
éé 
.
éé 
MatchJoined
éé $
(
éé$ %
matchId
éé% ,
,
éé, -
new
éé. 1 
OperationResultDto
éé2 D
{
ééE F
Success
ééG N
=
ééO P
true
ééQ U
}
ééV W
)
ééW X
;
ééX Y"
BroadcastLobbyUpdate
èè $
(
èè$ %
lobby
èè% *
)
èè* +
;
èè+ ,&
BroadcastPublicMatchList
êê (
(
êê( )
)
êê) *
;
êê* +
}
ëë 
else
íí 
{
ìì 
callback
îî 
.
îî 
MatchJoined
îî $
(
îî$ %
null
îî% )
,
îî) *
new
îî+ . 
OperationResultDto
îî/ A
{
îîB C
Success
îîD K
=
îîL M
false
îîN S
,
îîS T
Message
îîU \
=
îî] ^
$str
îî_ q
}
îîr s
)
îîs t
;
îît u
}
ïï 
}
ññ 	
public
òò 
static
òò  
OperationResultDto
òò (
JoinPrivateMatch
òò) 9
(
òò9 :
string
òò: @
username
òòA I
,
òòI J
string
òòK Q
	matchCode
òòR [
)
òò[ \
{
ôô 	
if
öö 
(
öö 
string
öö 
.
öö  
IsNullOrWhiteSpace
öö )
(
öö) *
	matchCode
öö* 3
)
öö3 4
)
öö4 5
{
õõ 
return
úú 
new
úú  
OperationResultDto
úú -
{
úú. /
Success
úú0 7
=
úú8 9
false
úú: ?
,
úú? @
Message
úúA H
=
úúI J
$str
úúK d
}
úúe f
;
úúf g
}
ùù 
var
üü 
lobby
üü 
=
üü 
_activeLobbies
üü &
.
üü& '
Values
üü' -
.
üü- .
FirstOrDefault
üü. <
(
üü< =
l
üü= >
=>
üü? A
l
üüB C
.
üüC D
	MatchCode
üüD M
==
üüN P
	matchCode
üüQ Z
&&
üü[ ]
l
üü^ _
.
üü_ `
Status
üü` f
==
üüg i
$str
üüj s
)
üüs t
;
üüt u
if
°° 
(
°° 
lobby
°° 
!=
°° 
null
°° 
)
°° 
{
¢¢ 
_connectedUsers
££ 
.
££  
TryGetValue
££  +
(
££+ ,
username
££, 4
,
££4 5
out
££6 9
var
££: =
callback
££> F
)
££F G
;
££G H
if
§§ 
(
§§ 
callback
§§ 
==
§§ 
null
§§  $
)
§§$ %
{
•• 
return
¶¶ 
new
¶¶  
OperationResultDto
¶¶ 1
{
¶¶2 3
Success
¶¶4 ;
=
¶¶< =
false
¶¶> C
,
¶¶C D
Message
¶¶E L
=
¶¶M N
$str
¶¶O d
}
¶¶e f
;
¶¶f g
}
ßß 
if
©© 
(
©© 
lobby
©© 
.
©© 
CurrentPlayers
©© (
>=
©©) +
lobby
©©, 1
.
©©1 2
Settings
©©2 :
.
©©: ;

MaxPlayers
©©; E
)
©©E F
{
™™ 
return
´´ 
new
´´  
OperationResultDto
´´ 1
{
´´2 3
Success
´´4 ;
=
´´< =
false
´´> C
,
´´C D
Message
´´E L
=
´´M N
$str
´´O _
}
´´` a
;
´´a b
}
¨¨ 
lobby
ÆÆ 
.
ÆÆ 
Players
ÆÆ 
.
ÆÆ 
Add
ÆÆ !
(
ÆÆ! "
username
ÆÆ" *
)
ÆÆ* +
;
ÆÆ+ ,
lobby
ØØ 
.
ØØ 
CurrentPlayers
ØØ $
++
ØØ$ &
;
ØØ& '#
UpdatePlayerCountInDb
∞∞ %
(
∞∞% &
lobby
∞∞& +
.
∞∞+ ,
MatchId
∞∞, 3
,
∞∞3 4
$num
∞∞5 6
)
∞∞6 7
;
∞∞7 8"
BroadcastLobbyUpdate
±± $
(
±±$ %
lobby
±±% *
)
±±* +
;
±±+ ,
return
≥≥ 
new
≥≥  
OperationResultDto
≥≥ -
{
¥¥ 
Success
µµ 
=
µµ 
true
µµ "
,
µµ" #
Message
∂∂ 
=
∂∂ 
$str
∂∂ 4
,
∂∂4 5
Data
∑∑ 
=
∑∑ 
new
∑∑ 

Dictionary
∑∑ )
<
∑∑) *
string
∑∑* 0
,
∑∑0 1
string
∑∑2 8
>
∑∑8 9
{
∑∑: ;
{
∑∑< =
$str
∑∑> G
,
∑∑G H
lobby
∑∑I N
.
∑∑N O
MatchId
∑∑O V
}
∑∑W X
}
∑∑Y Z
}
∏∏ 
;
∏∏ 
}
ππ 
else
∫∫ 
{
ªª 
return
ºº 
new
ºº  
OperationResultDto
ºº -
{
ºº. /
Success
ºº0 7
=
ºº8 9
false
ºº: ?
,
ºº? @
Message
ººA H
=
ººI J
$str
ººK k
}
ººl m
;
ººm n
}
ΩΩ 
}
ææ 	
public
¿¿ 
static
¿¿ 
void
¿¿ 
InviteToMatch
¿¿ (
(
¿¿( )
string
¿¿) /
inviterUsername
¿¿0 ?
,
¿¿? @
string
¿¿A G
invitedUsername
¿¿H W
,
¿¿W X
string
¿¿Y _
matchId
¿¿` g
)
¿¿g h
{
¡¡ 	
if
¬¬ 
(
¬¬ 
_connectedUsers
¬¬ 
.
¬¬  
TryGetValue
¬¬  +
(
¬¬+ ,
invitedUsername
¬¬, ;
,
¬¬; <
out
¬¬= @
var
¬¬A D
callback
¬¬E M
)
¬¬M N
)
¬¬N O
{
√√ 
callback
ƒƒ 
.
ƒƒ  
ReceiveMatchInvite
ƒƒ +
(
ƒƒ+ ,
inviterUsername
ƒƒ, ;
,
ƒƒ; <
matchId
ƒƒ= D
)
ƒƒD E
;
ƒƒE F
}
≈≈ 
}
∆∆ 	
public
»» 
static
»» 
void
»» 
HandlePlayerLeave
»» ,
(
»», -
string
»»- 3
username
»»4 <
,
»»< =
string
»»> D
matchId
»»E L
)
»»L M
{
…… 	
if
   
(
   
_activeLobbies
   
.
   
TryGetValue
   *
(
  * +
matchId
  + 2
,
  2 3
out
  4 7
var
  8 ;
lobby
  < A
)
  A B
)
  B C
{
ÀÀ 
bool
ÃÃ 
playerRemoved
ÃÃ "
=
ÃÃ# $
lobby
ÃÃ% *
.
ÃÃ* +
Players
ÃÃ+ 2
.
ÃÃ2 3
Remove
ÃÃ3 9
(
ÃÃ9 :
username
ÃÃ: B
)
ÃÃB C
;
ÃÃC D
if
ŒŒ 
(
ŒŒ 
playerRemoved
ŒŒ !
)
ŒŒ! "
{
œœ 
lobby
–– 
.
–– 
CurrentPlayers
–– (
--
––( *
;
––* +#
UpdatePlayerCountInDb
—— )
(
——) *
matchId
——* 1
,
——1 2
-
——3 4
$num
——4 5
)
——5 6
;
——6 7
Console
““ 
.
““ 
	WriteLine
““ %
(
““% &
$"
““& (
$str
““( B
{
““B C
username
““C K
}
““K L
$str
““L `
{
““` a
matchId
““a h
}
““h i
$str
““i v
{
““v w
lobby
““w |
.
““| }
CurrentPlayers““} ã
}““ã å
"““å ç
)““ç é
;““é è
}
”” 
if
’’ 
(
’’ 
lobby
’’ 
.
’’ 
Players
’’ !
.
’’! "
Count
’’" '
==
’’( *
$num
’’+ ,
||
’’- /
lobby
’’0 5
.
’’5 6
HostUsername
’’6 B
==
’’C E
username
’’F N
)
’’N O
{
÷÷ 
Console
◊◊ 
.
◊◊ 
	WriteLine
◊◊ %
(
◊◊% &
$"
◊◊& (
$str
◊◊( A
{
◊◊A B
matchId
◊◊B I
}
◊◊I J
$str
◊◊J w
"
◊◊w x
)
◊◊x y
;
◊◊y z
_activeLobbies
ÿÿ "
.
ÿÿ" #
	TryRemove
ÿÿ# ,
(
ÿÿ, -
matchId
ÿÿ- 4
,
ÿÿ4 5
out
ÿÿ6 9
_
ÿÿ: ;
)
ÿÿ; <
;
ÿÿ< =#
UpdateMatchStatusInDb
ŸŸ )
(
ŸŸ) *
matchId
ŸŸ* 1
,
ŸŸ1 2
$str
ŸŸ3 <
)
ŸŸ< =
;
ŸŸ= >
if
€€ 
(
€€ 
!
€€ 
lobby
€€ 
.
€€ 
Settings
€€ '
.
€€' (
	IsPrivate
€€( 1
)
€€1 2
{
‹‹ &
BroadcastPublicMatchList
›› 0
(
››0 1
)
››1 2
;
››2 3
}
ﬁﬁ 
}
ﬂﬂ 
else
‡‡ 
if
‡‡ 
(
‡‡ 
playerRemoved
‡‡ &
)
‡‡& '
{
·· "
BroadcastLobbyUpdate
‚‚ (
(
‚‚( )
lobby
‚‚) .
)
‚‚. /
;
‚‚/ 0
if
„„ 
(
„„ 
!
„„ 
lobby
„„ 
.
„„ 
Settings
„„ '
.
„„' (
	IsPrivate
„„( 1
)
„„1 2
{
‰‰ &
BroadcastPublicMatchList
ÂÂ 0
(
ÂÂ0 1
)
ÂÂ1 2
;
ÂÂ2 3
}
ÊÊ 
}
ÁÁ 
}
ËË 
}
ÈÈ 	
private
ÎÎ 
static
ÎÎ 
void
ÎÎ #
UpdatePlayerCountInDb
ÎÎ 1
(
ÎÎ1 2
string
ÎÎ2 8
matchId
ÎÎ9 @
,
ÎÎ@ A
int
ÎÎB E
change
ÎÎF L
)
ÎÎL M
{
ÏÏ 	
Task
ÌÌ 
.
ÌÌ 
Run
ÌÌ 
(
ÌÌ 
(
ÌÌ 
)
ÌÌ 
=>
ÌÌ 
{
ÓÓ 
try
ÔÔ 
{
 
using
ÒÒ 
(
ÒÒ 
var
ÒÒ 
context
ÒÒ &
=
ÒÒ' (
new
ÒÒ) ,#
GuessMyMessDBEntities
ÒÒ- B
(
ÒÒB C
)
ÒÒC D
)
ÒÒD E
{
ÚÚ 
if
ÛÛ 
(
ÛÛ 
int
ÛÛ 
.
ÛÛ  
TryParse
ÛÛ  (
(
ÛÛ( )
matchId
ÛÛ) 0
,
ÛÛ0 1
out
ÛÛ2 5
int
ÛÛ6 9
id
ÛÛ: <
)
ÛÛ< =
)
ÛÛ= >
{
ÙÙ 
var
ıı 
match
ıı  %
=
ıı& '
context
ıı( /
.
ıı/ 0
Match
ıı0 5
.
ıı5 6
Find
ıı6 :
(
ıı: ;
id
ıı; =
)
ıı= >
;
ıı> ?
if
ˆˆ 
(
ˆˆ  
match
ˆˆ  %
!=
ˆˆ& (
null
ˆˆ) -
)
ˆˆ- .
{
˜˜ 
match
¯¯  %
.
¯¯% &
currentPlayers
¯¯& 4
+=
¯¯5 7
change
¯¯8 >
;
¯¯> ?
if
˘˘  "
(
˘˘# $
match
˘˘$ )
.
˘˘) *
currentPlayers
˘˘* 8
<
˘˘9 :
$num
˘˘; <
)
˘˘< =
match
˘˘> C
.
˘˘C D
currentPlayers
˘˘D R
=
˘˘S T
$num
˘˘U V
;
˘˘V W
context
˙˙  '
.
˙˙' (
SaveChanges
˙˙( 3
(
˙˙3 4
)
˙˙4 5
;
˙˙5 6
}
˚˚ 
}
¸¸ 
}
˝˝ 
}
˛˛ 
catch
ˇˇ 
(
ˇˇ 
	Exception
ˇˇ  
ex
ˇˇ! #
)
ˇˇ# $
{
ÄÄ 
Console
ÅÅ 
.
ÅÅ 
	WriteLine
ÅÅ %
(
ÅÅ% &
$"
ÅÅ& (
$str
ÅÅ( V
{
ÅÅV W
matchId
ÅÅW ^
}
ÅÅ^ _
$str
ÅÅ_ a
{
ÅÅa b
ex
ÅÅb d
.
ÅÅd e
Message
ÅÅe l
}
ÅÅl m
"
ÅÅm n
)
ÅÅn o
;
ÅÅo p
}
ÇÇ 
}
ÉÉ 
)
ÉÉ 
;
ÉÉ 
}
ÑÑ 	
private
ÜÜ 
static
ÜÜ 
void
ÜÜ #
UpdateMatchStatusInDb
ÜÜ 1
(
ÜÜ1 2
string
ÜÜ2 8
matchId
ÜÜ9 @
,
ÜÜ@ A
string
ÜÜB H
status
ÜÜI O
)
ÜÜO P
{
áá 	
Task
àà 
.
àà 
Run
àà 
(
àà 
(
àà 
)
àà 
=>
àà 
{
ââ 
try
ää 
{
ãã 
using
åå 
(
åå 
var
åå 
context
åå &
=
åå' (
new
åå) ,#
GuessMyMessDBEntities
åå- B
(
ååB C
)
ååC D
)
ååD E
{
çç 
if
éé 
(
éé 
int
éé 
.
éé  
TryParse
éé  (
(
éé( )
matchId
éé) 0
,
éé0 1
out
éé2 5
int
éé6 9
id
éé: <
)
éé< =
)
éé= >
{
èè 
var
êê 
match
êê  %
=
êê& '
context
êê( /
.
êê/ 0
Match
êê0 5
.
êê5 6
Find
êê6 :
(
êê: ;
id
êê; =
)
êê= >
;
êê> ?
if
ëë 
(
ëë  
match
ëë  %
!=
ëë& (
null
ëë) -
)
ëë- .
{
íí 
match
ìì  %
.
ìì% &
matchStatus
ìì& 1
=
ìì2 3
status
ìì4 :
;
ìì: ;
context
îî  '
.
îî' (
SaveChanges
îî( 3
(
îî3 4
)
îî4 5
;
îî5 6
}
ïï 
}
ññ 
}
óó 
}
òò 
catch
ôô 
(
ôô 
	Exception
ôô  
ex
ôô! #
)
ôô# $
{
öö 
Console
õõ 
.
õõ 
	WriteLine
õõ %
(
õõ% &
$"
õõ& (
$str
õõ( V
{
õõV W
matchId
õõW ^
}
õõ^ _
$str
õõ_ a
{
õõa b
ex
õõb d
.
õõd e
Message
õõe l
}
õõl m
"
õõm n
)
õõn o
;
õõo p
}
úú 
}
ùù 
)
ùù 
;
ùù 
}
ûû 	
private
†† 
static
†† 
void
†† &
BroadcastPublicMatchList
†† 4
(
††4 5
)
††5 6
{
°° 	
var
¢¢ 
publicMatches
¢¢ 
=
¢¢ 
GetPublicMatches
¢¢  0
(
¢¢0 1
)
¢¢1 2
;
¢¢2 3
foreach
££ 
(
££ 
var
££ 
userCallback
££ %
in
££& (
_connectedUsers
££) 8
.
££8 9
Values
££9 ?
)
££? @
{
§§ 
try
•• 
{
¶¶ 
userCallback
ßß  
.
ßß  !&
PublicMatchesListUpdated
ßß! 9
(
ßß9 :
publicMatches
ßß: G
)
ßßG H
;
ßßH I
}
®® 
catch
©© 
(
©© 
	Exception
©©  
ex
©©! #
)
©©# $
{
™™ 
Console
´´ 
.
´´ 
	WriteLine
´´ %
(
´´% &
$"
´´& (
$str
´´( X
{
´´X Y
ex
´´Y [
.
´´[ \
Message
´´\ c
}
´´c d
"
´´d e
)
´´e f
;
´´f g
}
¨¨ 
}
≠≠ 
}
ÆÆ 	
private
∞∞ 
static
∞∞ 
void
∞∞ "
BroadcastLobbyUpdate
∞∞ 0
(
∞∞0 1

MatchLobby
∞∞1 ;
lobby
∞∞< A
)
∞∞A B
{
±± 	
var
≤≤ 
	matchInfo
≤≤ 
=
≤≤ 
lobby
≤≤ !
.
≤≤! "
ToMatchInfoDto
≤≤" 0
(
≤≤0 1
)
≤≤1 2
;
≤≤2 3
foreach
≥≥ 
(
≥≥ 
var
≥≥ 

playerName
≥≥ #
in
≥≥$ &
lobby
≥≥' ,
.
≥≥, -
Players
≥≥- 4
)
≥≥4 5
{
¥¥ 
if
µµ 
(
µµ 
_connectedUsers
µµ #
.
µµ# $
TryGetValue
µµ$ /
(
µµ/ 0

playerName
µµ0 :
,
µµ: ;
out
µµ< ?
var
µµ@ C
callback
µµD L
)
µµL M
)
µµM N
{
∂∂ 
try
∑∑ 
{
∏∏ 
callback
ππ  
.
ππ  !
MatchUpdate
ππ! ,
(
ππ, -
	matchInfo
ππ- 6
)
ππ6 7
;
ππ7 8
}
∫∫ 
catch
ªª 
(
ªª 
	Exception
ªª $
ex
ªª% '
)
ªª' (
{
ºº 
Console
ΩΩ 
.
ΩΩ  
	WriteLine
ΩΩ  )
(
ΩΩ) *
$"
ΩΩ* ,
$str
ΩΩ, O
{
ΩΩO P

playerName
ΩΩP Z
}
ΩΩZ [
$str
ΩΩ[ ]
{
ΩΩ] ^
ex
ΩΩ^ `
.
ΩΩ` a
Message
ΩΩa h
}
ΩΩh i
"
ΩΩi j
)
ΩΩj k
;
ΩΩk l
}
ææ 
}
øø 
}
¿¿ 
}
¡¡ 	
private
√√ 
static
√√ 
string
√√ 
GenerateMatchCode
√√ /
(
√√/ 0
int
√√0 3
length
√√4 :
)
√√: ;
{
ƒƒ 	
const
≈≈ 
string
≈≈ 
chars
≈≈ 
=
≈≈  
$str
≈≈! E
;
≈≈E F
using
∆∆ 
(
∆∆ 
var
∆∆ 
crypto
∆∆ 
=
∆∆ 
new
∆∆  #&
RNGCryptoServiceProvider
∆∆$ <
(
∆∆< =
)
∆∆= >
)
∆∆> ?
{
«« 
var
»» 
data
»» 
=
»» 
new
»» 
byte
»» #
[
»»# $
length
»»$ *
]
»»* +
;
»»+ ,
var
…… 
result
…… 
=
…… 
new
……  
StringBuilder
……! .
(
……. /
length
……/ 5
)
……5 6
;
……6 7
crypto
   
.
   
GetBytes
   
(
    
data
    $
)
  $ %
;
  % &
foreach
ÀÀ 
(
ÀÀ 
byte
ÀÀ 
b
ÀÀ 
in
ÀÀ  "
data
ÀÀ# '
)
ÀÀ' (
{
ÃÃ 
result
ÕÕ 
.
ÕÕ 
Append
ÕÕ !
(
ÕÕ! "
chars
ÕÕ" '
[
ÕÕ' (
b
ÕÕ( )
%
ÕÕ* +
chars
ÕÕ, 1
.
ÕÕ1 2
Length
ÕÕ2 8
]
ÕÕ8 9
)
ÕÕ9 :
;
ÕÕ: ;
}
ŒŒ 
return
œœ 
result
œœ 
.
œœ 
ToString
œœ &
(
œœ& '
)
œœ' (
;
œœ( )
}
–– 
}
—— 	
}
““ 
public
‘‘ 

class
‘‘ 

MatchLobby
‘‘ 
{
’’ 
public
÷÷ 
string
÷÷ 
MatchId
÷÷ 
{
÷÷ 
get
÷÷  #
;
÷÷# $
set
÷÷% (
;
÷÷( )
}
÷÷* +
public
◊◊ 
string
◊◊ 
	MatchCode
◊◊ 
{
◊◊  !
get
◊◊" %
;
◊◊% &
set
◊◊' *
;
◊◊* +
}
◊◊, -
public
ÿÿ 
string
ÿÿ 
HostUsername
ÿÿ "
{
ÿÿ# $
get
ÿÿ% (
;
ÿÿ( )
set
ÿÿ* -
;
ÿÿ- .
}
ÿÿ/ 0
public
ŸŸ 
LobbySettingsDto
ŸŸ 
Settings
ŸŸ  (
{
ŸŸ) *
get
ŸŸ+ .
;
ŸŸ. /
set
ŸŸ0 3
;
ŸŸ3 4
}
ŸŸ5 6
public
⁄⁄ 
List
⁄⁄ 
<
⁄⁄ 
string
⁄⁄ 
>
⁄⁄ 
Players
⁄⁄ #
{
⁄⁄$ %
get
⁄⁄& )
;
⁄⁄) *
set
⁄⁄+ .
;
⁄⁄. /
}
⁄⁄0 1
public
€€ 
string
€€ 
Status
€€ 
{
€€ 
get
€€ "
;
€€" #
set
€€$ '
;
€€' (
}
€€) *
public
‹‹ 
int
‹‹ 
CurrentPlayers
‹‹ !
{
‹‹" #
get
‹‹$ '
;
‹‹' (
set
‹‹) ,
;
‹‹, -
}
‹‹. /
public
ﬁﬁ 

MatchLobby
ﬁﬁ 
(
ﬁﬁ 
string
ﬁﬁ  
matchId
ﬁﬁ! (
,
ﬁﬁ( )
string
ﬁﬁ* 0
	matchCode
ﬁﬁ1 :
,
ﬁﬁ: ;
string
ﬁﬁ< B
hostUsername
ﬁﬁC O
,
ﬁﬁO P
LobbySettingsDto
ﬁﬁQ a
settings
ﬁﬁb j
)
ﬁﬁj k
{
ﬂﬂ 	
MatchId
‡‡ 
=
‡‡ 
matchId
‡‡ 
;
‡‡ 
	MatchCode
·· 
=
·· 
	matchCode
·· !
;
··! "
HostUsername
‚‚ 
=
‚‚ 
hostUsername
‚‚ '
;
‚‚' (
Settings
„„ 
=
„„ 
settings
„„ 
;
„„  
Players
‰‰ 
=
‰‰ 
new
‰‰ 
List
‰‰ 
<
‰‰ 
string
‰‰ %
>
‰‰% &
(
‰‰& '
)
‰‰' (
;
‰‰( )
Status
ÂÂ 
=
ÂÂ 
$str
ÂÂ 
;
ÂÂ 
CurrentPlayers
ÊÊ 
=
ÊÊ 
$num
ÊÊ 
;
ÊÊ 
}
ÁÁ 	
public
ÈÈ 
MatchInfoDto
ÈÈ 
ToMatchInfoDto
ÈÈ *
(
ÈÈ* +
)
ÈÈ+ ,
{
ÍÍ 	
string
ÎÎ 
difficultyName
ÎÎ !
=
ÎÎ" #
$str
ÎÎ$ -
;
ÎÎ- .
try
ÏÏ 
{
ÌÌ 
using
ÓÓ 
(
ÓÓ 
var
ÓÓ 
context
ÓÓ "
=
ÓÓ# $
new
ÓÓ% (#
GuessMyMessDBEntities
ÓÓ) >
(
ÓÓ> ?
)
ÓÓ? @
)
ÓÓ@ A
{
ÔÔ 
difficultyName
 "
=
# $
context
% ,
.
, -
MatchDifficulty
- <
.
ÒÒ( )
Where
ÒÒ) .
(
ÒÒ. /
d
ÒÒ/ 0
=>
ÒÒ1 3
d
ÒÒ4 5
.
ÒÒ5 6
idMatchDifficulty
ÒÒ6 G
==
ÒÒH J
Settings
ÒÒK S
.
ÒÒS T
DifficultyId
ÒÒT `
)
ÒÒ` a
.
ÚÚ( )
Select
ÚÚ) /
(
ÚÚ/ 0
d
ÚÚ0 1
=>
ÚÚ2 4
d
ÚÚ5 6
.
ÚÚ6 7

difficulty
ÚÚ7 A
)
ÚÚA B
.
ÛÛ( )
FirstOrDefault
ÛÛ) 7
(
ÛÛ7 8
)
ÛÛ8 9
??
ÛÛ: <
$str
ÛÛ= F
;
ÛÛF G
}
ÙÙ 
}
ıı 
catch
ˆˆ 
(
ˆˆ 
	Exception
ˆˆ 
ex
ˆˆ 
)
ˆˆ  
{
˜˜ 
Console
¯¯ 
.
¯¯ 
	WriteLine
¯¯ !
(
¯¯! "
$"
¯¯" $
$str
¯¯$ O
{
¯¯O P
this
¯¯P T
.
¯¯T U
MatchId
¯¯U \
}
¯¯\ ]
$str
¯¯] _
{
¯¯_ `
ex
¯¯` b
.
¯¯b c
Message
¯¯c j
}
¯¯j k
"
¯¯k l
)
¯¯l m
;
¯¯m n
}
˘˘ 
return
˙˙ 
new
˙˙ 
MatchInfoDto
˙˙ #
{
˚˚ 
MatchId
¸¸ 
=
¸¸ 
this
¸¸ 
.
¸¸ 
MatchId
¸¸ &
,
¸¸& '
	MatchName
˝˝ 
=
˝˝ 
this
˝˝  
.
˝˝  !
Settings
˝˝! )
.
˝˝) *
	MatchName
˝˝* 3
,
˝˝3 4
HostUsername
˛˛ 
=
˛˛ 
this
˛˛ #
.
˛˛# $
HostUsername
˛˛$ 0
,
˛˛0 1
CurrentPlayers
ˇˇ 
=
ˇˇ  
this
ˇˇ! %
.
ˇˇ% &
CurrentPlayers
ˇˇ& 4
,
ˇˇ4 5

MaxPlayers
ÄÄ 
=
ÄÄ 
this
ÄÄ !
.
ÄÄ! "
Settings
ÄÄ" *
.
ÄÄ* +

MaxPlayers
ÄÄ+ 5
,
ÄÄ5 6
DifficultyName
ÅÅ 
=
ÅÅ  
difficultyName
ÅÅ! /
}
ÇÇ 
;
ÇÇ 
}
ÉÉ 	
}
ÑÑ 
}ÖÖ ‡
°C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\DataContracts\ChatMessageDto.cs
	namespace 	
GuessMyMessServer
 
. 
	Contracts %
.% &
DataContracts& 3
{		 
[

 
DataContract

 
]

 
public 

class 
ChatMessageDto 
{ 
[ 	

DataMember	 
] 
public 
string 
SenderUsername $
{% &
get' *
;* +
set, /
;/ 0
}1 2
[ 	

DataMember	 
] 
public 
string 
MessageContent $
{% &
get' *
;* +
set, /
;/ 0
}1 2
[ 	

DataMember	 
] 
public 
DateTime 
	Timestamp !
{" #
get$ '
;' (
set) ,
;, -
}. /
} 
} ê 
ôC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\BusinessLogic\UserProfileLogic.cs
	namespace 	
GuessMyMessServer
 
. 
BusinessLogic )
{ 
public 

class 
UserProfileLogic !
{ 
private 
readonly 
IEmailService &
_emailService' 4
;4 5
private 
readonly !
GuessMyMessDBEntities .
_context/ 7
;7 8
private 
static 
readonly 
Random  &
_random' .
=/ 0
new1 4
Random5 ;
(; <
)< =
;= >
public 
UserProfileLogic 
(  
IEmailService  -
emailService. :
,: ;!
GuessMyMessDBEntities< Q
contextR Y
)Y Z
{ 	
_emailService 
= 
emailService (
;( )
_context 
= 
context 
; 
} 	
private 
string 
GenerateCode #
(# $
)$ %
=>& (
_random) 0
.0 1
Next1 5
(5 6
$num6 <
,< =
$num> D
)D E
.E F
ToStringF N
(N O
$strO S
)S T
;T U
public 
async 
Task 
< 
UserProfileDto (
>( )
GetUserProfileAsync* =
(= >
string> D
usernameE M
)M N
{ 	
var 
player 
= 
await 
_context '
.' (
Player( .
. 
AsNoTracking 
( 
) 
.   
Include   
(   
p   
=>   
p   
.    
Gender    &
)  & '
.!! 
Include!! 
(!! 
p!! 
=>!! 
p!! 
.!!  
Avatar!!  &
)!!& '
."" 
FirstOrDefaultAsync"" $
(""$ %
p""% &
=>""' )
p""* +
.""+ ,
username"", 4
==""5 7
username""8 @
)""@ A
;""A B
if$$ 
($$ 
player$$ 
==$$ 
null$$ 
)$$ 
{%% 
throw&& 
new&& %
InvalidOperationException&& 3
(&&3 4
$str&&4 E
)&&E F
;&&F G
}'' 
return)) 
new)) 
UserProfileDto)) %
{** 
Username++ 
=++ 
player++ !
.++! "
username++" *
,++* +
	FirstName,, 
=,, 
player,, "
.,," #
name,,# '
,,,' (
LastName-- 
=-- 
player-- !
.--! "
lastName--" *
,--* +
Email.. 
=.. 
player.. 
... 
email.. $
,..$ %
GenderId// 
=// 
player// !
.//! "
Gender_idGender//" 1
.//1 2
GetValueOrDefault//2 C
(//C D
)//D E
,//E F
AvatarId00 
=00 
player00 !
.00! "
Avatar_idAvatar00" 1
.001 2
GetValueOrDefault002 C
(00C D
)00D E
}11 
;11 
}22 	
public44 
async44 
Task44 
<44 
OperationResultDto44 ,
>44, -
UpdateProfileAsync44. @
(44@ A
string44A G
username44H P
,44P Q
UserProfileDto44R `
profileData44a l
)44l m
{55 	
if66 
(66 
profileData66 
==66 
null66 #
)66# $
{77 
throw88 
new88 !
ArgumentNullException88 /
(88/ 0
nameof880 6
(886 7
profileData887 B
)88B C
,88C D
$str88E \
)88\ ]
;88] ^
}99 
var;; 
playerToUpdate;; 
=;;  
await;;! &
_context;;' /
.;;/ 0
Player;;0 6
.;;6 7
FirstOrDefaultAsync;;7 J
(;;J K
p;;K L
=>;;M O
p;;P Q
.;;Q R
username;;R Z
==;;[ ]
username;;^ f
);;f g
;;;g h
if<< 
(<< 
playerToUpdate<< 
==<< !
null<<" &
)<<& '
{== 
throw>> 
new>> %
InvalidOperationException>> 3
(>>3 4
$str>>4 E
)>>E F
;>>F G
}?? 
playerToUpdateAA 
.AA 
nameAA 
=AA  !
profileDataAA" -
.AA- .
	FirstNameAA. 7
;AA7 8
playerToUpdateBB 
.BB 
lastNameBB #
=BB$ %
profileDataBB& 1
.BB1 2
LastNameBB2 :
;BB: ;
playerToUpdateCC 
.CC 
Gender_idGenderCC *
=CC+ ,
profileDataCC- 8
.CC8 9
GenderIdCC9 A
;CCA B
playerToUpdateDD 
.DD 
Avatar_idAvatarDD *
=DD+ ,
profileDataDD- 8
.DD8 9
AvatarIdDD9 A
>DDB C
$numDDD E
?DDF G
profileDataDDH S
.DDS T
AvatarIdDDT \
:DD] ^
playerToUpdateDD_ m
.DDm n
Avatar_idAvatarDDn }
;DD} ~
awaitFF 
_contextFF 
.FF 
SaveChangesAsyncFF +
(FF+ ,
)FF, -
;FF- .
returnGG 
newGG 
OperationResultDtoGG )
{GG* +
SuccessGG, 3
=GG4 5
trueGG6 :
,GG: ;
MessageGG< C
=GGD E
$strGGF e
}GGf g
;GGg h
}HH 	
publicJJ 
asyncJJ 
TaskJJ 
<JJ 
ListJJ 
<JJ 
	AvatarDtoJJ (
>JJ( )
>JJ) *$
GetAvailableAvatarsAsyncJJ+ C
(JJC D
)JJD E
{KK 	
varLL 
avatarsFromDbLL 
=LL 
awaitLL  %
_contextLL& .
.LL. /
AvatarLL/ 5
.LL5 6
AsNoTrackingLL6 B
(LLB C
)LLC D
.LLD E
ToListAsyncLLE P
(LLP Q
)LLQ R
;LLR S
varMM 
avatarsDtoListMM 
=MM  
newMM! $
ListMM% )
<MM) *
	AvatarDtoMM* 3
>MM3 4
(MM4 5
)MM5 6
;MM6 7
stringNN 
basePathNN 
=NN 
	AppDomainNN '
.NN' (
CurrentDomainNN( 5
.NN5 6
BaseDirectoryNN6 C
;NNC D
foreachPP 
(PP 
varPP 
avatarRecordPP %
inPP& (
avatarsFromDbPP) 6
)PP6 7
{QQ 
byteRR 
[RR 
]RR 
	imageDataRR  
=RR! "
nullRR# '
;RR' (
ifSS 
(SS 
!SS 
stringSS 
.SS 
IsNullOrEmptySS )
(SS) *
avatarRecordSS* 6
.SS6 7
	avatarUrlSS7 @
)SS@ A
)SSA B
{TT 
stringUU 
filePathUU #
=UU$ %
PathUU& *
.UU* +
CombineUU+ 2
(UU2 3
basePathUU3 ;
,UU; <
avatarRecordUU= I
.UUI J
	avatarUrlUUJ S
)UUS T
;UUT U
ifWW 
(WW 
FileWW 
.WW 
ExistsWW #
(WW# $
filePathWW$ ,
)WW, -
)WW- .
{XX 
tryYY 
{ZZ 
using[[ !
([[" #

FileStream[[# -
stream[[. 4
=[[5 6
new[[7 :

FileStream[[; E
([[E F
filePath[[F N
,[[N O
FileMode[[P X
.[[X Y
Open[[Y ]
,[[] ^

FileAccess[[_ i
.[[i j
Read[[j n
,[[n o
	FileShare[[p y
.[[y z
Read[[z ~
,[[~ 

bufferSize
[[Ä ä
:
[[ä ã
$num
[[å ê
,
[[ê ë
useAsync
[[í ö
:
[[ö õ
true
[[ú †
)
[[† °
)
[[° ¢
{\\ 
	imageData]]  )
=]]* +
new]], /
byte]]0 4
[]]4 5
stream]]5 ;
.]]; <
Length]]< B
]]]B C
;]]C D
int^^  #
	bytesRead^^$ -
=^^. /
$num^^0 1
;^^1 2
int__  #
totalBytesRead__$ 2
=__3 4
$num__5 6
;__6 7
while``  %
(``& '
totalBytesRead``' 5
<``6 7
	imageData``8 A
.``A B
Length``B H
&&``I K
(aa' (
	bytesReadaa( 1
=aa2 3
awaitaa4 9
streamaa: @
.aa@ A
	ReadAsyncaaA J
(aaJ K
	imageDataaaK T
,aaT U
totalBytesReadaaV d
,aad e
	imageDataaaf o
.aao p
Lengthaap v
-aaw x
totalBytesRead	aay á
)
aaá à
)
aaà â
>
aaä ã
$num
aaå ç
)
aaç é
{bb  !
totalBytesReadcc$ 2
+=cc3 5
	bytesReadcc6 ?
;cc? @
}dd  !
ifff  "
(ff# $
totalBytesReadff$ 2
!=ff3 5
	imageDataff6 ?
.ff? @
Lengthff@ F
)ffF G
{gg  !
Arrayhh$ )
.hh) *
Resizehh* 0
(hh0 1
refhh1 4
	imageDatahh5 >
,hh> ?
totalBytesReadhh@ N
)hhN O
;hhO P
Consoleii$ +
.ii+ ,
	WriteLineii, 5
(ii5 6
$"ii6 8
$strii8 J
{iiJ K
	imageDataiiK T
.iiT U
LengthiiU [
}ii[ \
$strii\ l
{iil m
totalBytesReadiim {
}ii{ |
$str	ii| Å
{
iiÅ Ç
filePath
iiÇ ä
}
iiä ã
"
iiã å
)
iiå ç
;
iiç é
}jj  !
}kk 
}ll 
catchmm 
(mm 
IOExceptionmm *
ioExmm+ /
)mm/ 0
{nn 
Consoleoo #
.oo# $
	WriteLineoo$ -
(oo- .
$"oo. 0
$stroo0 J
{ooJ K
filePathooK S
}ooS T
$strooT V
{ooV W
ioExooW [
.oo[ \
Messageoo\ c
}ooc d
"ood e
)ooe f
;oof g
}pp 
catchqq 
(qq 
	Exceptionqq (
exqq) +
)qq+ ,
{rr 
Consoless #
.ss# $
	WriteLiness$ -
(ss- .
$"ss. 0
$strss0 S
{ssS T
filePathssT \
}ss\ ]
$strss] _
{ss_ `
exss` b
.ssb c
Messagessc j
}ssj k
"ssk l
)ssl m
;ssm n
}tt 
}uu 
elsevv 
{ww 
Consolexx 
.xx  
	WriteLinexx  )
(xx) *
$"xx* ,
$strxx, T
{xxT U
filePathxxU ]
}xx] ^
"xx^ _
)xx_ `
;xx` a
}yy 
}zz 
avatarsDtoList{{ 
.{{ 
Add{{ "
({{" #
new{{# &
	AvatarDto{{' 0
{|| 
IdAvatar}} 
=}} 
avatarRecord}} +
.}}+ ,
idAvatar}}, 4
,}}4 5

AvatarName~~ 
=~~  
avatarRecord~~! -
.~~- .

avatarName~~. 8
,~~8 9

AvatarData 
=  
	imageData! *
}
ÄÄ 
)
ÄÄ 
;
ÄÄ 
}
ÅÅ 
return
ÇÇ 
avatarsDtoList
ÇÇ !
;
ÇÇ! "
}
ÉÉ 	
public
ÖÖ 
async
ÖÖ 
Task
ÖÖ 
<
ÖÖ  
OperationResultDto
ÖÖ ,
>
ÖÖ, -(
RequestChangePasswordAsync
ÖÖ. H
(
ÖÖH I
string
ÖÖI O
username
ÖÖP X
)
ÖÖX Y
{
ÜÜ 	
var
áá 
player
áá 
=
áá 
await
áá 
_context
áá '
.
áá' (
Player
áá( .
.
áá. /!
FirstOrDefaultAsync
áá/ B
(
ááB C
p
ááC D
=>
ááE G
p
ááH I
.
ááI J
username
ááJ R
==
ááS U
username
ááV ^
)
áá^ _
;
áá_ `
if
àà 
(
àà 
player
àà 
==
àà 
null
àà 
)
àà 
{
ââ 
throw
ää 
new
ää '
InvalidOperationException
ää 3
(
ää3 4
$str
ää4 E
)
ääE F
;
ääF G
}
ãã 
string
çç 
code
çç 
=
çç 
GenerateCode
çç &
(
çç& '
)
çç' (
;
çç( )
player
éé 
.
éé 
	temp_code
éé 
=
éé 
code
éé #
;
éé# $
player
èè 
.
èè 
temp_code_expiry
èè #
=
èè$ %
DateTime
èè& .
.
èè. /
UtcNow
èè/ 5
.
èè5 6

AddMinutes
èè6 @
(
èè@ A
$num
èèA C
)
èèC D
;
èèD E
await
êê 
_context
êê 
.
êê 
SaveChangesAsync
êê +
(
êê+ ,
)
êê, -
;
êê- .
var
íí 
emailTemplate
íí 
=
íí 
new
íí  #5
'PasswordChangeVerificationEmailTemplate
íí$ K
(
ííK L
player
ííL R
.
ííR S
username
ííS [
,
íí[ \
code
íí] a
)
íía b
;
ííb c
await
ìì 
_emailService
ìì 
.
ìì  
SendEmailAsync
ìì  .
(
ìì. /
player
ìì/ 5
.
ìì5 6
email
ìì6 ;
,
ìì; <
player
ìì= C
.
ììC D
username
ììD L
,
ììL M
emailTemplate
ììN [
)
ìì[ \
;
ìì\ ]
return
ïï 
new
ïï  
OperationResultDto
ïï )
{
ïï* +
Success
ïï, 3
=
ïï4 5
true
ïï6 :
,
ïï: ;
Message
ïï< C
=
ïïD E
$strïïF É
}ïïÑ Ö
;ïïÖ Ü
}
ññ 	
public
òò 
async
òò 
Task
òò 
<
òò  
OperationResultDto
òò ,
>
òò, -%
RequestChangeEmailAsync
òò. E
(
òòE F
string
òòF L
username
òòM U
,
òòU V
string
òòW ]
newEmail
òò^ f
)
òòf g
{
ôô 	
if
öö 
(
öö 
string
öö 
.
öö  
IsNullOrWhiteSpace
öö )
(
öö) *
newEmail
öö* 2
)
öö2 3
||
öö4 6
!
öö7 8
InputValidator
öö8 F
.
ööF G
IsValidEmail
ööG S
(
ööS T
newEmail
ööT \
)
öö\ ]
)
öö] ^
{
õõ 
throw
úú 
new
úú 
ArgumentException
úú +
(
úú+ ,
$str
úú, G
,
úúG H
nameof
úúI O
(
úúO P
newEmail
úúP X
)
úúX Y
)
úúY Z
;
úúZ [
}
ùù 
var
üü 
player
üü 
=
üü 
await
üü 
_context
üü '
.
üü' (
Player
üü( .
.
üü. /!
FirstOrDefaultAsync
üü/ B
(
üüB C
p
üüC D
=>
üüE G
p
üüH I
.
üüI J
username
üüJ R
==
üüS U
username
üüV ^
)
üü^ _
;
üü_ `
if
†† 
(
†† 
player
†† 
==
†† 
null
†† 
)
†† 
{
°° 
throw
¢¢ 
new
¢¢ '
InvalidOperationException
¢¢ 3
(
¢¢3 4
$str
¢¢4 E
)
¢¢E F
;
¢¢F G
}
££ 
if
§§ 
(
§§ 
await
§§ 
_context
§§ 
.
§§ 
Player
§§ %
.
§§% &
AnyAsync
§§& .
(
§§. /
p
§§/ 0
=>
§§1 3
p
§§4 5
.
§§5 6
email
§§6 ;
==
§§< >
newEmail
§§? G
)
§§G H
)
§§H I
{
•• 
throw
¶¶ 
new
¶¶ '
InvalidOperationException
¶¶ 3
(
¶¶3 4
$str
¶¶4 Z
)
¶¶Z [
;
¶¶[ \
}
ßß 
string
©© 
code
©© 
=
©© 
GenerateCode
©© &
(
©©& '
)
©©' (
;
©©( )
player
™™ 
.
™™ 
	temp_code
™™ 
=
™™ 
code
™™ #
;
™™# $
player
´´ 
.
´´ 
temp_code_expiry
´´ #
=
´´$ %
DateTime
´´& .
.
´´. /
UtcNow
´´/ 5
.
´´5 6

AddMinutes
´´6 @
(
´´@ A
$num
´´A C
)
´´C D
;
´´D E
player
¨¨ 
.
¨¨ 
new_email_pending
¨¨ $
=
¨¨% &
newEmail
¨¨' /
;
¨¨/ 0
await
≠≠ 
_context
≠≠ 
.
≠≠ 
SaveChangesAsync
≠≠ +
(
≠≠+ ,
)
≠≠, -
;
≠≠- .
var
ØØ 
emailTemplate
ØØ 
=
ØØ 
new
ØØ  #2
$EmailChangeVerificationEmailTemplate
ØØ$ H
(
ØØH I
player
ØØI O
.
ØØO P
username
ØØP X
,
ØØX Y
code
ØØZ ^
)
ØØ^ _
;
ØØ_ `
await
∞∞ 
_emailService
∞∞ 
.
∞∞  
SendEmailAsync
∞∞  .
(
∞∞. /
player
∞∞/ 5
.
∞∞5 6
email
∞∞6 ;
,
∞∞; <
player
∞∞= C
.
∞∞C D
username
∞∞D L
,
∞∞L M
emailTemplate
∞∞N [
)
∞∞[ \
;
∞∞\ ]
return
≤≤ 
new
≤≤  
OperationResultDto
≤≤ )
{
≤≤* +
Success
≤≤, 3
=
≤≤4 5
true
≤≤6 :
,
≤≤: ;
Message
≤≤< C
=
≤≤D E
$"
≤≤F H
$str
≤≤H t
{
≤≤t u
player
≤≤u {
.
≤≤{ |
email≤≤| Å
}≤≤Å Ç
$str≤≤Ç è
"≤≤è ê
}≤≤ë í
;≤≤í ì
}
≥≥ 	
public
µµ 
async
µµ 
Task
µµ 
<
µµ  
OperationResultDto
µµ ,
>
µµ, -(
ConfirmChangePasswordAsync
µµ. H
(
µµH I
string
µµI O
username
µµP X
,
µµX Y
string
µµZ `
newPassword
µµa l
,
µµl m
string
µµn t
verificationCodeµµu Ö
)µµÖ Ü
{
∂∂ 	
if
∑∑ 
(
∑∑ 
!
∑∑ 
InputValidator
∑∑ 
.
∑∑  
IsPasswordSecure
∑∑  0
(
∑∑0 1
newPassword
∑∑1 <
)
∑∑< =
)
∑∑= >
{
∏∏ 
throw
ππ 
new
ππ 
ArgumentException
ππ +
(
ππ+ ,
$str
ππ, g
,
ππg h
nameof
ππi o
(
ππo p
newPassword
ππp {
)
ππ{ |
)
ππ| }
;
ππ} ~
}
∫∫ 
var
ºº 
player
ºº 
=
ºº 
await
ºº 
_context
ºº '
.
ºº' (
Player
ºº( .
.
ºº. /!
FirstOrDefaultAsync
ºº/ B
(
ººB C
p
ººC D
=>
ººE G
p
ººH I
.
ººI J
username
ººJ R
==
ººS U
username
ººV ^
)
ºº^ _
;
ºº_ `
if
ΩΩ 
(
ΩΩ 
player
ΩΩ 
==
ΩΩ 
null
ΩΩ 
)
ΩΩ 
{
ææ 
throw
øø 
new
øø '
InvalidOperationException
øø 3
(
øø3 4
$str
øø4 E
)
øøE F
;
øøF G
}
¿¿ 
if
¡¡ 
(
¡¡ 
player
¡¡ 
.
¡¡ 
	temp_code
¡¡  
!=
¡¡! #
verificationCode
¡¡$ 4
||
¡¡5 7
player
¡¡8 >
.
¡¡> ?
temp_code_expiry
¡¡? O
<
¡¡P Q
DateTime
¡¡R Z
.
¡¡Z [
UtcNow
¡¡[ a
)
¡¡a b
{
¬¬ 
throw
√√ 
new
√√ '
InvalidOperationException
√√ 3
(
√√3 4
$str
√√4 [
)
√√[ \
;
√√\ ]
}
ƒƒ 
player
∆∆ 
.
∆∆ 
password
∆∆ 
=
∆∆ 
PasswordHasher
∆∆ ,
.
∆∆, -
HashPassword
∆∆- 9
(
∆∆9 :
newPassword
∆∆: E
)
∆∆E F
;
∆∆F G
player
«« 
.
«« 
	temp_code
«« 
=
«« 
null
«« #
;
««# $
player
»» 
.
»» 
temp_code_expiry
»» #
=
»»$ %
null
»»& *
;
»»* +
await
…… 
_context
…… 
.
…… 
SaveChangesAsync
…… +
(
……+ ,
)
……, -
;
……- .
return
ÀÀ 
new
ÀÀ  
OperationResultDto
ÀÀ )
{
ÀÀ* +
Success
ÀÀ, 3
=
ÀÀ4 5
true
ÀÀ6 :
,
ÀÀ: ;
Message
ÀÀ< C
=
ÀÀD E
$str
ÀÀF f
}
ÀÀg h
;
ÀÀh i
}
ÃÃ 	
public
ŒŒ 
async
ŒŒ 
Task
ŒŒ 
<
ŒŒ  
OperationResultDto
ŒŒ ,
>
ŒŒ, -%
ConfirmChangeEmailAsync
ŒŒ. E
(
ŒŒE F
string
ŒŒF L
username
ŒŒM U
,
ŒŒU V
string
ŒŒW ]
verificationCode
ŒŒ^ n
)
ŒŒn o
{
œœ 	
var
–– 
player
–– 
=
–– 
await
–– 
_context
–– '
.
––' (
Player
––( .
.
––. /!
FirstOrDefaultAsync
––/ B
(
––B C
p
––C D
=>
––E G
p
––H I
.
––I J
username
––J R
==
––S U
username
––V ^
)
––^ _
;
––_ `
if
—— 
(
—— 
player
—— 
==
—— 
null
—— 
)
—— 
{
““ 
throw
”” 
new
”” '
InvalidOperationException
”” 3
(
””3 4
$str
””4 E
)
””E F
;
””F G
}
‘‘ 
if
’’ 
(
’’ 
string
’’ 
.
’’ 
IsNullOrEmpty
’’ $
(
’’$ %
player
’’% +
.
’’+ ,
new_email_pending
’’, =
)
’’= >
)
’’> ?
{
÷÷ 
throw
◊◊ 
new
◊◊ '
InvalidOperationException
◊◊ 3
(
◊◊3 4
$str
◊◊4 W
)
◊◊W X
;
◊◊X Y
}
ÿÿ 
if
ŸŸ 
(
ŸŸ 
player
ŸŸ 
.
ŸŸ 
	temp_code
ŸŸ  
!=
ŸŸ! #
verificationCode
ŸŸ$ 4
||
ŸŸ5 7
player
ŸŸ8 >
.
ŸŸ> ?
temp_code_expiry
ŸŸ? O
<
ŸŸP Q
DateTime
ŸŸR Z
.
ŸŸZ [
UtcNow
ŸŸ[ a
)
ŸŸa b
{
⁄⁄ 
throw
€€ 
new
€€ '
InvalidOperationException
€€ 3
(
€€3 4
$str
€€4 [
)
€€[ \
;
€€\ ]
}
‹‹ 
if
ﬁﬁ 
(
ﬁﬁ 
await
ﬁﬁ 
_context
ﬁﬁ 
.
ﬁﬁ 
Player
ﬁﬁ %
.
ﬁﬁ% &
AnyAsync
ﬁﬁ& .
(
ﬁﬁ. /
p
ﬁﬁ/ 0
=>
ﬁﬁ1 3
p
ﬁﬁ4 5
.
ﬁﬁ5 6
email
ﬁﬁ6 ;
==
ﬁﬁ< >
player
ﬁﬁ? E
.
ﬁﬁE F
new_email_pending
ﬁﬁF W
&&
ﬁﬁX Z
p
ﬁﬁ[ \
.
ﬁﬁ\ ]
idPlayer
ﬁﬁ] e
!=
ﬁﬁf h
player
ﬁﬁi o
.
ﬁﬁo p
idPlayer
ﬁﬁp x
)
ﬁﬁx y
)
ﬁﬁy z
{
ﬂﬂ 
player
‡‡ 
.
‡‡ 
	temp_code
‡‡  
=
‡‡! "
null
‡‡# '
;
‡‡' (
player
·· 
.
·· 
temp_code_expiry
·· '
=
··( )
null
··* .
;
··. /
player
‚‚ 
.
‚‚ 
new_email_pending
‚‚ (
=
‚‚) *
null
‚‚+ /
;
‚‚/ 0
await
„„ 
_context
„„ 
.
„„ 
SaveChangesAsync
„„ /
(
„„/ 0
)
„„0 1
;
„„1 2
throw
‰‰ 
new
‰‰ '
InvalidOperationException
‰‰ 3
(
‰‰3 4
$str
‰‰4 j
)
‰‰j k
;
‰‰k l
}
ÂÂ 
player
ÁÁ 
.
ÁÁ 
email
ÁÁ 
=
ÁÁ 
player
ÁÁ !
.
ÁÁ! "
new_email_pending
ÁÁ" 3
;
ÁÁ3 4
player
ËË 
.
ËË 
	temp_code
ËË 
=
ËË 
null
ËË #
;
ËË# $
player
ÈÈ 
.
ÈÈ 
temp_code_expiry
ÈÈ #
=
ÈÈ$ %
null
ÈÈ& *
;
ÈÈ* +
player
ÍÍ 
.
ÍÍ 
new_email_pending
ÍÍ $
=
ÍÍ% &
null
ÍÍ' +
;
ÍÍ+ ,
await
ÎÎ 
_context
ÎÎ 
.
ÎÎ 
SaveChangesAsync
ÎÎ +
(
ÎÎ+ ,
)
ÎÎ, -
;
ÎÎ- .
return
ÌÌ 
new
ÌÌ  
OperationResultDto
ÌÌ )
{
ÌÌ* +
Success
ÌÌ, 3
=
ÌÌ4 5
true
ÌÌ6 :
,
ÌÌ: ;
Message
ÌÌ< C
=
ÌÌD E
$str
ÌÌF c
}
ÌÌd e
;
ÌÌe f
}
ÓÓ 	
}
ÔÔ 
} ‰ú
ìC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\BusinessLogic\LobbyLogic.cs
	namespace 	
GuessMyMessServer
 
. 
BusinessLogic )
{ 
public 

class 

LobbyLogic 
{ 
private 
static 
readonly  
ConcurrentDictionary  4
<4 5
string5 ;
,; <
Lobby= B
>B C
_lobbiesD L
=M N
newO R 
ConcurrentDictionaryS g
<g h
stringh n
,n o
Lobbyp u
>u v
(v w
)w x
;x y
private 
static 
readonly 
object  &
_lock' ,
=- .
new/ 2
object3 9
(9 :
): ;
;; <
private 
sealed 
class 
PlayerConnection -
{ 	
public 
string 
Username "
{# $
get% (
;( )
}* +
public !
ILobbyServiceCallback (
Callback) 1
{2 3
get4 7
;7 8
}9 :
public 
PlayerConnection #
(# $
string$ *
username+ 3
,3 4!
ILobbyServiceCallback5 J
callbackK S
)S T
{ 
Username 
= 
username #
;# $
Callback 
= 
callback #
;# $
} 
} 	
private 
sealed 
class 
Lobby "
{   	
public!! 
string!! 
MatchId!! !
{!!" #
get!!$ '
;!!' (
}!!) *
public"" 
string"" 
HostUsername"" &
{""' (
get"") ,
;"", -
}"". /
public## 
MatchInfoDto## 
	MatchInfo##  )
{##* +
get##, /
;##/ 0
}##1 2
public$$  
ConcurrentDictionary$$ '
<$$' (
string$$( .
,$$. /
PlayerConnection$$0 @
>$$@ A
Players$$B I
{$$J K
get$$L O
;$$O P
}$$Q R
=$$S T
new$$U X 
ConcurrentDictionary$$Y m
<$$m n
string$$n t
,$$t u
PlayerConnection	$$v Ü
>
$$Ü á
(
$$á à
)
$$à â
;
$$â ä
private%% 
Timer%% 
_countdownTimer%% )
;%%) *
private&& 
int&& 
_countdownSeconds&& )
=&&* +
$num&&, -
;&&- .
private'' 
volatile'' 
bool'' !
_gameHasStarted''" 1
=''2 3
false''4 9
;''9 :
public)) 
Lobby)) 
()) 
string)) 
matchId))  '
,))' (
string))) /
hostUsername))0 <
,))< =
MatchInfoDto))> J
	matchInfo))K T
)))T U
{** 
MatchId++ 
=++ 
matchId++ !
;++! "
HostUsername,, 
=,, 
hostUsername,, +
;,,+ ,
	MatchInfo-- 
=-- 
	matchInfo-- %
;--% &
}.. 
public00 
LobbyStateDto00  
GetCurrentState00! 0
(000 1
)001 2
{11 
return22 
new22 
LobbyStateDto22 (
{33 
	MatchName44 
=44 
	MatchInfo44  )
.44) *
	MatchName44* 3
,443 4
HostUsername55  
=55! "
HostUsername55# /
,55/ 0

Difficulty66 
=66  
	MatchInfo66! *
.66* +
DifficultyName66+ 9
,669 :
CurrentPlayers77 "
=77# $
Players77% ,
.77, -
Count77- 2
,772 3

MaxPlayers88 
=88  
	MatchInfo88! *
.88* +

MaxPlayers88+ 5
,885 6
	MatchCode99 
=99 
	MatchInfo99  )
.99) *
	IsPrivate99* 3
?994 5
	MatchInfo996 ?
.99? @
	MatchCode99@ I
:99J K
null99L P
,99P Q
PlayerUsernames:: #
=::$ %
Players::& -
.::- .
Keys::. 2
.::2 3
ToList::3 9
(::9 :
)::: ;
};; 
;;; 
}<< 
public>> 
void>> 
StartCountdown>> &
(>>& '
)>>' (
{?? 
_countdownSeconds@@ !
=@@" #
$num@@$ %
;@@% &
	BroadcastAA 
(AA 
connAA 
=>AA !
connAA" &
.AA& '
CallbackAA' /
.AA/ 0
OnGameStartingAA0 >
(AA> ?
_countdownSecondsAA? P
)AAP Q
)AAQ R
;AAR S
_countdownTimerBB 
=BB  !
newBB" %
TimerBB& +
(BB+ ,
CountdownTickBB, 9
,BB9 :
nullBB; ?
,BB? @
TimeSpanBBA I
.BBI J
FromSecondsBBJ U
(BBU V
$numBBV W
)BBW X
,BBX Y
TimeSpanBBZ b
.BBb c
FromSecondsBBc n
(BBn o
$numBBo p
)BBp q
)BBq r
;BBr s
}CC 
privateEE 
voidEE 
CountdownTickEE &
(EE& '
objectEE' -
stateEE. 3
)EE3 4
{FF 
_countdownTimerGG 
?GG  
.GG  !
ChangeGG! '
(GG' (
TimeoutGG( /
.GG/ 0
InfiniteGG0 8
,GG8 9
TimeoutGG: A
.GGA B
InfiniteGGB J
)GGJ K
;GGK L
_countdownSecondsHH !
--HH! #
;HH# $
ifII 
(II 
_countdownSecondsII %
>II& '
$numII( )
)II) *
{JJ 
	BroadcastKK 
(KK 
connKK "
=>KK# %
connKK& *
.KK* +
CallbackKK+ 3
.KK3 4
OnGameStartingKK4 B
(KKB C
_countdownSecondsKKC T
)KKT U
)KKU V
;KKV W
_countdownTimerLL #
?LL# $
.LL$ %
ChangeLL% +
(LL+ ,
TimeSpanLL, 4
.LL4 5
FromSecondsLL5 @
(LL@ A
$numLLA B
)LLB C
,LLC D
TimeSpanLLE M
.LLM N
FromSecondsLLN Y
(LLY Z
$numLLZ [
)LL[ \
)LL\ ]
;LL] ^
}MM 
elseNN 
{OO 
ifPP 
(PP 
!PP 
_gameHasStartedPP (
)PP( )
{QQ 
_gameHasStartedRR '
=RR( )
trueRR* .
;RR. /
_countdownTimerSS '
?SS' (
.SS( )
DisposeSS) 0
(SS0 1
)SS1 2
;SS2 3
_countdownTimerTT '
=TT( )
nullTT* .
;TT. /
	BroadcastVV !
(VV! "
connVV" &
=>VV' )
connVV* .
.VV. /
CallbackVV/ 7
.VV7 8
OnGameStartedVV8 E
(VVE F
)VVF G
)VVG H
;VVH I

LobbyLogicWW "
.WW" #
RemoveLobbyWW# .
(WW. /
MatchIdWW/ 6
)WW6 7
;WW7 8
}XX 
elseYY 
{ZZ 
_countdownTimer[[ '
?[[' (
.[[( )
Dispose[[) 0
([[0 1
)[[1 2
;[[2 3
_countdownTimer\\ '
=\\( )
null\\* .
;\\. /
}]] 
}^^ 
}__ 
publicaa 
voidaa 
	Broadcastaa !
(aa! "
Actionaa" (
<aa( )
PlayerConnectionaa) 9
>aa9 :
actionaa; A
)aaA B
{bb 
foreachcc 
(cc 
varcc 

playerConncc '
incc( *
Playerscc+ 2
.cc2 3
Valuescc3 9
)cc9 :
{dd 
tryee 
{ff 
actiongg 
(gg 

playerConngg )
)gg) *
;gg* +
}hh 
catchii 
(ii 
	Exceptionii $
exii% '
)ii' (
{jj 
Consolekk 
.kk  
	WriteLinekk  )
(kk) *
$"kk* ,
$strkk, B
{kkB C

playerConnkkC M
.kkM N
UsernamekkN V
}kkV W
$strkkW Y
{kkY Z
exkkZ \
.kk\ ]
Messagekk] d
}kkd e
"kke f
)kkf g
;kkg h
}ll 
}mm 
}nn 
}oo 	
publicqq 
voidqq 
Connectqq 
(qq 
stringqq "
usernameqq# +
,qq+ ,
stringqq- 3
matchIdqq4 ;
,qq; <!
ILobbyServiceCallbackqq= R
callbackqqS [
)qq[ \
{rr 	
Lobbyss 
lobbyss 
=ss 
GetOrCreateLobbyss *
(ss* +
matchIdss+ 2
,ss2 3
usernamess4 <
,ss< =
callbackss> F
)ssF G
;ssG H
ifuu 
(uu 
lobbyuu 
==uu 
nulluu 
)uu 
{vv 
returnww 
;ww 
}xx 
AddPlayerToLobbyzz 
(zz 
lobbyzz "
,zz" #
usernamezz$ ,
,zz, -
callbackzz. 6
)zz6 7
;zz7 8
}{{ 	
private}} 
Lobby}} 
GetOrCreateLobby}} &
(}}& '
string}}' -
matchId}}. 5
,}}5 6
string}}7 =
hostUsername}}> J
,}}J K!
ILobbyServiceCallback}}L a
callback}}b j
)}}j k
{~~ 	
Lobby 
lobby 
; 
lock
ÅÅ 
(
ÅÅ 
_lock
ÅÅ 
)
ÅÅ 
{
ÇÇ 
if
ÉÉ 
(
ÉÉ 
_lobbies
ÉÉ 
.
ÉÉ 
TryGetValue
ÉÉ (
(
ÉÉ( )
matchId
ÉÉ) 0
,
ÉÉ0 1
out
ÉÉ2 5
lobby
ÉÉ6 ;
)
ÉÉ; <
)
ÉÉ< =
{
ÑÑ 
return
ÖÖ 
lobby
ÖÖ  
;
ÖÖ  !
}
ÜÜ 
var
àà 
	matchInfo
àà 
=
àà 
GetMatchInfo
àà  ,
(
àà, -
matchId
àà- 4
)
àà4 5
;
àà5 6
if
ââ 
(
ââ 
	matchInfo
ââ 
==
ââ  
null
ââ! %
)
ââ% &
{
ää 
SafeCallback
ãã  
(
ãã  !
callback
ãã! )
,
ãã) *
(
ãã+ ,
)
ãã, -
=>
ãã. 0
callback
ãã1 9
.
ãã9 :
KickedFromLobby
ãã: I
(
ããI J
$str
ããJ \
)
ãã\ ]
)
ãã] ^
;
ãã^ _
return
åå 
null
åå 
;
åå  
}
çç 
lobby
èè 
=
èè 
new
èè 
Lobby
èè !
(
èè! "
matchId
èè" )
,
èè) *
hostUsername
èè+ 7
,
èè7 8
	matchInfo
èè9 B
)
èèB C
;
èèC D
if
ëë 
(
ëë 
!
ëë 
_lobbies
ëë 
.
ëë 
TryAdd
ëë $
(
ëë$ %
matchId
ëë% ,
,
ëë, -
lobby
ëë. 3
)
ëë3 4
)
ëë4 5
{
íí 
_lobbies
ìì 
.
ìì 
TryGetValue
ìì (
(
ìì( )
matchId
ìì) 0
,
ìì0 1
out
ìì2 5
lobby
ìì6 ;
)
ìì; <
;
ìì< =
}
îî 
}
ïï 
return
óó 
lobby
óó 
;
óó 
}
òò 	
private
öö 
void
öö 
AddPlayerToLobby
öö %
(
öö% &
Lobby
öö& +
lobby
öö, 1
,
öö1 2
string
öö3 9
username
öö: B
,
ööB C#
ILobbyServiceCallback
ööD Y
callback
ööZ b
)
ööb c
{
õõ 	
if
úú 
(
úú 
lobby
úú 
.
úú 
Players
úú 
.
úú 
Count
úú #
>=
úú$ &
lobby
úú' ,
.
úú, -
	MatchInfo
úú- 6
.
úú6 7

MaxPlayers
úú7 A
&&
úúB D
!
úúE F
lobby
úúF K
.
úúK L
Players
úúL S
.
úúS T
ContainsKey
úúT _
(
úú_ `
username
úú` h
)
úúh i
)
úúi j
{
ùù 
SafeCallback
ûû 
(
ûû 
callback
ûû %
,
ûû% &
(
ûû' (
)
ûû( )
=>
ûû* ,
callback
ûû- 5
.
ûû5 6
KickedFromLobby
ûû6 E
(
ûûE F
$str
ûûF V
)
ûûV W
)
ûûW X
;
ûûX Y
return
üü 
;
üü 
}
†† 
var
¢¢ 

connection
¢¢ 
=
¢¢ 
new
¢¢  
PlayerConnection
¢¢! 1
(
¢¢1 2
username
¢¢2 :
,
¢¢: ;
callback
¢¢< D
)
¢¢D E
;
¢¢E F
if
§§ 
(
§§ 
lobby
§§ 
.
§§ 
Players
§§ 
.
§§ 
TryAdd
§§ $
(
§§$ %
username
§§% -
,
§§- .

connection
§§/ 9
)
§§9 :
)
§§: ;
{
•• 
Console
¶¶ 
.
¶¶ 
	WriteLine
¶¶ !
(
¶¶! "
$"
¶¶" $
$str
¶¶$ +
{
¶¶+ ,
username
¶¶, 4
}
¶¶4 5
$str
¶¶5 I
{
¶¶I J
lobby
¶¶J O
.
¶¶O P
MatchId
¶¶P W
}
¶¶W X
"
¶¶X Y
)
¶¶Y Z
;
¶¶Z [!
BroadcastLobbyState
ßß #
(
ßß# $
lobby
ßß$ )
)
ßß) *
;
ßß* +
}
®® 
else
©© 
{
™™ 
if
´´ 
(
´´ 
lobby
´´ 
.
´´ 
Players
´´ !
.
´´! "
TryGetValue
´´" -
(
´´- .
username
´´. 6
,
´´6 7
out
´´8 ;
var
´´< ? 
existingConnection
´´@ R
)
´´R S
)
´´S T
{
¨¨ 
lobby
≠≠ 
.
≠≠ 
Players
≠≠ !
.
≠≠! "
	TryUpdate
≠≠" +
(
≠≠+ ,
username
≠≠, 4
,
≠≠4 5

connection
≠≠6 @
,
≠≠@ A 
existingConnection
≠≠B T
)
≠≠T U
;
≠≠U V
Console
ÆÆ 
.
ÆÆ 
	WriteLine
ÆÆ %
(
ÆÆ% &
$"
ÆÆ& (
$str
ÆÆ( /
{
ÆÆ/ 0
username
ÆÆ0 8
}
ÆÆ8 9
$str
ÆÆ9 O
{
ÆÆO P
lobby
ÆÆP U
.
ÆÆU V
MatchId
ÆÆV ]
}
ÆÆ] ^
"
ÆÆ^ _
)
ÆÆ_ `
;
ÆÆ` a
SafeCallback
∞∞  
(
∞∞  !
callback
∞∞! )
,
∞∞) *
(
∞∞+ ,
)
∞∞, -
=>
∞∞. 0
callback
∞∞1 9
.
∞∞9 :
UpdateLobbyState
∞∞: J
(
∞∞J K
lobby
∞∞K P
.
∞∞P Q
GetCurrentState
∞∞Q `
(
∞∞` a
)
∞∞a b
)
∞∞b c
)
∞∞c d
;
∞∞d e
}
±± 
}
≤≤ 
}
≥≥ 	
private
µµ 
static
µµ 
void
µµ 
SafeCallback
µµ (
(
µµ( )#
ILobbyServiceCallback
µµ) >
callback
µµ? G
,
µµG H
Action
µµI O
action
µµP V
)
µµV W
{
∂∂ 	
try
∑∑ 
{
∏∏ 
if
ππ 
(
ππ 
callback
ππ 
!=
ππ 
null
ππ  $
)
ππ$ %
{
∫∫ 
action
ªª 
(
ªª 
)
ªª 
;
ªª 
}
ºº 
}
ΩΩ 
catch
ææ 
(
ææ 
	Exception
ææ 
ex
ææ 
)
ææ  
{
øø 
Console
¿¿ 
.
¿¿ 
	WriteLine
¿¿ !
(
¿¿! "
$"
¿¿" $
$str
¿¿$ 5
{
¿¿5 6
ex
¿¿6 8
.
¿¿8 9
Message
¿¿9 @
}
¿¿@ A
"
¿¿A B
)
¿¿B C
;
¿¿C D
}
¡¡ 
}
¬¬ 	
public
ƒƒ 
void
ƒƒ 

Disconnect
ƒƒ 
(
ƒƒ 
string
ƒƒ %
username
ƒƒ& .
,
ƒƒ. /
string
ƒƒ0 6
matchId
ƒƒ7 >
)
ƒƒ> ?
{
≈≈ 	
MatchmakingLogic
∆∆ 
.
∆∆ 
HandlePlayerLeave
∆∆ .
(
∆∆. /
username
∆∆/ 7
,
∆∆7 8
matchId
∆∆9 @
)
∆∆@ A
;
∆∆A B
if
«« 
(
«« 
_lobbies
«« 
.
«« 
TryGetValue
«« $
(
««$ %
matchId
««% ,
,
««, -
out
««. 1
Lobby
««2 7
lobby
««8 =
)
««= >
)
««> ?
{
»» 
if
…… 
(
…… 
lobby
…… 
.
…… 
Players
…… !
.
……! "
	TryRemove
……" +
(
……+ ,
username
……, 4
,
……4 5
out
……6 9
_
……: ;
)
……; <
)
……< =
{
   
Console
ÀÀ 
.
ÀÀ 
	WriteLine
ÀÀ %
(
ÀÀ% &
$"
ÀÀ& (
$str
ÀÀ( /
{
ÀÀ/ 0
username
ÀÀ0 8
}
ÀÀ8 9
$str
ÀÀ9 R
{
ÀÀR S
matchId
ÀÀS Z
}
ÀÀZ [
"
ÀÀ[ \
)
ÀÀ\ ]
;
ÀÀ] ^
if
ÕÕ 
(
ÕÕ 
username
ÕÕ  
.
ÕÕ  !
Equals
ÕÕ! '
(
ÕÕ' (
lobby
ÕÕ( -
.
ÕÕ- .
HostUsername
ÕÕ. :
,
ÕÕ: ;
StringComparison
ÕÕ< L
.
ÕÕL M
OrdinalIgnoreCase
ÕÕM ^
)
ÕÕ^ _
)
ÕÕ_ `
{
ŒŒ 
Console
œœ 
.
œœ  
	WriteLine
œœ  )
(
œœ) *
$"
œœ* ,
$str
œœ, 1
{
œœ1 2
username
œœ2 :
}
œœ: ;
$str
œœ; G
{
œœG H
matchId
œœH O
}
œœO P
$str
œœP f
"
œœf g
)
œœg h
;
œœh i
lobby
–– 
.
–– 
	Broadcast
–– '
(
––' (
conn
––( ,
=>
––- /
{
—— 
SafeCallback
““ (
(
““( )
conn
““) -
.
““- .
Callback
““. 6
,
““6 7
(
““8 9
)
““9 :
=>
““; =
conn
““> B
.
““B C
Callback
““C K
.
““K L
KickedFromLobby
““L [
(
““[ \
$str
““\ w
)
““w x
)
““x y
;
““y z
}
”” 
)
”” 
;
”” 
RemoveLobby
‘‘ #
(
‘‘# $
matchId
‘‘$ +
)
‘‘+ ,
;
‘‘, -
}
’’ 
else
÷÷ 
{
◊◊ !
BroadcastLobbyState
ÿÿ +
(
ÿÿ+ ,
lobby
ÿÿ, 1
)
ÿÿ1 2
;
ÿÿ2 3
}
ŸŸ 
}
⁄⁄ 
if
‹‹ 
(
‹‹ 
!
‹‹ 
username
‹‹ 
.
‹‹ 
Equals
‹‹ $
(
‹‹$ %
lobby
‹‹% *
.
‹‹* +
HostUsername
‹‹+ 7
,
‹‹7 8
StringComparison
‹‹9 I
.
‹‹I J
OrdinalIgnoreCase
‹‹J [
)
‹‹[ \
&&
‹‹] _
lobby
‹‹` e
.
‹‹e f
Players
‹‹f m
.
‹‹m n
IsEmpty
‹‹n u
)
‹‹u v
{
›› 
Console
ﬁﬁ 
.
ﬁﬁ 
	WriteLine
ﬁﬁ %
(
ﬁﬁ% &
$"
ﬁﬁ& (
$str
ﬁﬁ( .
{
ﬁﬁ. /
matchId
ﬁﬁ/ 6
}
ﬁﬁ6 7
$str
ﬁﬁ7 K
"
ﬁﬁK L
)
ﬁﬁL M
;
ﬁﬁM N
RemoveLobby
ﬂﬂ 
(
ﬂﬂ  
matchId
ﬂﬂ  '
)
ﬂﬂ' (
;
ﬂﬂ( )
}
‡‡ 
}
·· 
}
‚‚ 	
public
‰‰ 
void
‰‰ 
SendMessage
‰‰ 
(
‰‰  
string
‰‰  &
senderUsername
‰‰' 5
,
‰‰5 6
string
‰‰7 =
matchId
‰‰> E
,
‰‰E F
string
‰‰G M

messageKey
‰‰N X
)
‰‰X Y
{
ÂÂ 	
if
ÊÊ 
(
ÊÊ 
_lobbies
ÊÊ 
.
ÊÊ 
TryGetValue
ÊÊ $
(
ÊÊ$ %
matchId
ÊÊ% ,
,
ÊÊ, -
out
ÊÊ. 1
Lobby
ÊÊ2 7
lobby
ÊÊ8 =
)
ÊÊ= >
)
ÊÊ> ?
{
ÁÁ 
var
ËË 

messageDto
ËË 
=
ËË  
new
ËË! $
ChatMessageDto
ËË% 3
{
ÈÈ 
SenderUsername
ÍÍ "
=
ÍÍ# $
senderUsername
ÍÍ% 3
,
ÍÍ3 4
MessageContent
ÎÎ "
=
ÎÎ# $

messageKey
ÎÎ% /
,
ÎÎ/ 0
	Timestamp
ÏÏ 
=
ÏÏ 
DateTime
ÏÏ  (
.
ÏÏ( )
UtcNow
ÏÏ) /
}
ÌÌ 
;
ÌÌ 
lobby
ÔÔ 
.
ÔÔ 
	Broadcast
ÔÔ 
(
ÔÔ  
conn
ÔÔ  $
=>
ÔÔ% '
{
 
SafeCallback
ÒÒ  
(
ÒÒ  !
conn
ÒÒ! %
.
ÒÒ% &
Callback
ÒÒ& .
,
ÒÒ. /
(
ÒÒ0 1
)
ÒÒ1 2
=>
ÒÒ3 5
conn
ÒÒ6 :
.
ÒÒ: ;
Callback
ÒÒ; C
.
ÒÒC D!
ReceiveLobbyMessage
ÒÒD W
(
ÒÒW X

messageDto
ÒÒX b
)
ÒÒb c
)
ÒÒc d
;
ÒÒd e
}
ÚÚ 
)
ÚÚ 
;
ÚÚ 
}
ÛÛ 
}
ÙÙ 	
public
ˆˆ 
void
ˆˆ 

KickPlayer
ˆˆ 
(
ˆˆ 
string
ˆˆ %
hostUsername
ˆˆ& 2
,
ˆˆ2 3
string
ˆˆ4 :"
playerToKickUsername
ˆˆ; O
,
ˆˆO P
string
ˆˆQ W
matchId
ˆˆX _
)
ˆˆ_ `
{
˜˜ 	
if
¯¯ 
(
¯¯ 
_lobbies
¯¯ 
.
¯¯ 
TryGetValue
¯¯ $
(
¯¯$ %
matchId
¯¯% ,
,
¯¯, -
out
¯¯. 1
Lobby
¯¯2 7
lobby
¯¯8 =
)
¯¯= >
)
¯¯> ?
{
˘˘ 
if
˙˙ 
(
˙˙ 
!
˙˙ 
hostUsername
˙˙ !
.
˙˙! "
Equals
˙˙" (
(
˙˙( )
lobby
˙˙) .
.
˙˙. /
HostUsername
˙˙/ ;
,
˙˙; <
StringComparison
˙˙= M
.
˙˙M N
OrdinalIgnoreCase
˙˙N _
)
˙˙_ `
)
˙˙` a
{
˚˚ 
Console
¸¸ 
.
¸¸ 
	WriteLine
¸¸ %
(
¸¸% &
$"
¸¸& (
$str
¸¸( =
{
¸¸= >
hostUsername
¸¸> J
}
¸¸J K
$str
¸¸K e
{
¸¸e f
matchId
¸¸f m
}
¸¸m n
$str
¸¸n o
"
¸¸o p
)
¸¸p q
;
¸¸q r
return
˝˝ 
;
˝˝ 
}
˛˛ 
if
ÄÄ 
(
ÄÄ 
hostUsername
ÄÄ  
.
ÄÄ  !
Equals
ÄÄ! '
(
ÄÄ' ("
playerToKickUsername
ÄÄ( <
,
ÄÄ< =
StringComparison
ÄÄ> N
.
ÄÄN O
OrdinalIgnoreCase
ÄÄO `
)
ÄÄ` a
)
ÄÄa b
{
ÅÅ 
return
ÇÇ 
;
ÇÇ 
}
ÉÉ 
if
ÖÖ 
(
ÖÖ 
lobby
ÖÖ 
.
ÖÖ 
Players
ÖÖ !
.
ÖÖ! "
	TryRemove
ÖÖ" +
(
ÖÖ+ ,"
playerToKickUsername
ÖÖ, @
,
ÖÖ@ A
out
ÖÖB E
PlayerConnection
ÖÖF V$
kickedPlayerConnection
ÖÖW m
)
ÖÖm n
)
ÖÖn o
{
ÜÜ 
MatchmakingLogic
áá $
.
áá$ %
HandlePlayerLeave
áá% 6
(
áá6 7"
playerToKickUsername
áá7 K
,
ááK L
matchId
ááM T
)
ááT U
;
ááU V
Console
àà 
.
àà 
	WriteLine
àà %
(
àà% &
$"
àà& (
$str
àà( /
{
àà/ 0"
playerToKickUsername
àà0 D
}
ààD E
$str
ààE X
{
ààX Y
matchId
ààY `
}
àà` a
$str
ààa j
{
ààj k
hostUsername
ààk w
}
ààw x
$str
ààx y
"
àày z
)
ààz {
;
àà{ |
try
ââ 
{
ää $
kickedPlayerConnection
ãã .
.
ãã. /
Callback
ãã/ 7
.
ãã7 8
KickedFromLobby
ãã8 G
(
ããG H
$str
ããH ]
)
ãã] ^
;
ãã^ _
}
åå 
catch
çç 
(
çç 
	Exception
çç $
ex
çç% '
)
çç' (
{
éé 
Console
èè 
.
èè  
	WriteLine
èè  )
(
èè) *
$"
èè* ,
$str
èè, K
{
èèK L"
playerToKickUsername
èèL `
}
èè` a
$str
èèa c
{
èèc d
ex
èèd f
.
èèf g
Message
èèg n
}
èèn o
"
èèo p
)
èèp q
;
èèq r
}
êê !
BroadcastLobbyState
íí '
(
íí' (
lobby
íí( -
)
íí- .
;
íí. /
}
ìì 
}
îî 
}
ïï 	
public
óó 
void
óó 
	StartGame
óó 
(
óó 
string
óó $
hostUsername
óó% 1
,
óó1 2
string
óó3 9
matchId
óó: A
)
óóA B
{
òò 	
if
ôô 
(
ôô 
_lobbies
ôô 
.
ôô 
TryGetValue
ôô $
(
ôô$ %
matchId
ôô% ,
,
ôô, -
out
ôô. 1
Lobby
ôô2 7
lobby
ôô8 =
)
ôô= >
)
ôô> ?
{
öö 
if
õõ 
(
õõ 
!
õõ 
hostUsername
õõ !
.
õõ! "
Equals
õõ" (
(
õõ( )
lobby
õõ) .
.
õõ. /
HostUsername
õõ/ ;
,
õõ; <
StringComparison
õõ= M
.
õõM N
OrdinalIgnoreCase
õõN _
)
õõ_ `
)
õõ` a
{
úú 
Console
ùù 
.
ùù 
	WriteLine
ùù %
(
ùù% &
$"
ùù& (
$str
ùù( C
{
ùùC D
hostUsername
ùùD P
}
ùùP Q
$str
ùùQ k
{
ùùk l
matchId
ùùl s
}
ùùs t
$str
ùùt u
"
ùùu v
)
ùùv w
;
ùùw x
return
ûû 
;
ûû 
}
üü 
if
°° 
(
°° 
lobby
°° 
.
°° 
Players
°° !
.
°°! "
Count
°°" '
<
°°( )
$num
°°* +
)
°°+ ,
{
¢¢ 
Console
££ 
.
££ 
	WriteLine
££ %
(
££% &
$"
££& (
$str
££( _
{
££_ `
matchId
££` g
}
££g h
$str
££h i
"
££i j
)
££j k
;
££k l
}
§§ 
Console
¶¶ 
.
¶¶ 
	WriteLine
¶¶ !
(
¶¶! "
$"
¶¶" $
$str
¶¶$ )
{
¶¶) *
hostUsername
¶¶* 6
}
¶¶6 7
$str
¶¶7 P
{
¶¶P Q
matchId
¶¶Q X
}
¶¶X Y
$str
¶¶Y Z
"
¶¶Z [
)
¶¶[ \
;
¶¶\ ]
lobby
ßß 
.
ßß 
StartCountdown
ßß $
(
ßß$ %
)
ßß% &
;
ßß& '
}
®® 
}
©© 	
private
´´ 
static
´´ 
void
´´ !
BroadcastLobbyState
´´ /
(
´´/ 0
Lobby
´´0 5
lobby
´´6 ;
)
´´; <
{
¨¨ 	
var
≠≠ 
state
≠≠ 
=
≠≠ 
lobby
≠≠ 
.
≠≠ 
GetCurrentState
≠≠ -
(
≠≠- .
)
≠≠. /
;
≠≠/ 0
lobby
ÆÆ 
.
ÆÆ 
	Broadcast
ÆÆ 
(
ÆÆ 
conn
ÆÆ  
=>
ÆÆ! #
{
ØØ 
SafeCallback
∞∞ 
(
∞∞ 
conn
∞∞ !
.
∞∞! "
Callback
∞∞" *
,
∞∞* +
(
∞∞, -
)
∞∞- .
=>
∞∞/ 1
conn
∞∞2 6
.
∞∞6 7
Callback
∞∞7 ?
.
∞∞? @
UpdateLobbyState
∞∞@ P
(
∞∞P Q
state
∞∞Q V
)
∞∞V W
)
∞∞W X
;
∞∞X Y
}
±± 
)
±± 
;
±± 
}
≤≤ 	
private
¥¥ 
static
¥¥ 
void
¥¥ 
RemoveLobby
¥¥ '
(
¥¥' (
string
¥¥( .
matchId
¥¥/ 6
)
¥¥6 7
{
µµ 	
if
∂∂ 
(
∂∂ 
_lobbies
∂∂ 
.
∂∂ 
	TryRemove
∂∂ "
(
∂∂" #
matchId
∂∂# *
,
∂∂* +
out
∂∂, /
_
∂∂0 1
)
∂∂1 2
)
∂∂2 3
{
∑∑ 
Console
∏∏ 
.
∏∏ 
	WriteLine
∏∏ !
(
∏∏! "
$"
∏∏" $
$str
∏∏$ *
{
∏∏* +
matchId
∏∏+ 2
}
∏∏2 3
$str
∏∏3 <
"
∏∏< =
)
∏∏= >
;
∏∏> ?
}
ππ 
}
∫∫ 	
private
ºº 
MatchInfoDto
ºº 
GetMatchInfo
ºº )
(
ºº) *
string
ºº* 0
matchId
ºº1 8
)
ºº8 9
{
ΩΩ 	
if
ææ 
(
ææ 
!
ææ 
int
ææ 
.
ææ 
TryParse
ææ 
(
ææ 
matchId
ææ %
,
ææ% &
out
ææ' *
int
ææ+ .
matchIdNumeric
ææ/ =
)
ææ= >
)
ææ> ?
{
øø 
Console
¿¿ 
.
¿¿ 
	WriteLine
¿¿ !
(
¿¿! "
$"
¿¿" $
$str
¿¿$ 4
{
¿¿4 5
matchId
¿¿5 <
}
¿¿< =
$str
¿¿= [
"
¿¿[ \
)
¿¿\ ]
;
¿¿] ^
return
¡¡ 
null
¡¡ 
;
¡¡ 
}
¬¬ 
try
√√ 
{
ƒƒ 
using
≈≈ 
(
≈≈ 
var
≈≈ 
context
≈≈ "
=
≈≈# $
new
≈≈% (#
GuessMyMessDBEntities
≈≈) >
(
≈≈> ?
)
≈≈? @
)
≈≈@ A
{
∆∆ 
var
«« 
match
«« 
=
«« 
context
««  '
.
««' (
Match
««( -
.
»» 
Include
»»  
(
»»  !
$str
»»! )
)
»») *
.
…… 
Include
……  
(
……  !
$str
……! 2
)
……2 3
.
   
FirstOrDefault
   '
(
  ' (
m
  ( )
=>
  * ,
m
  - .
.
  . /
idMatch
  / 6
==
  7 9
matchIdNumeric
  : H
)
  H I
;
  I J
if
ÃÃ 
(
ÃÃ 
match
ÃÃ 
!=
ÃÃ  
null
ÃÃ! %
)
ÃÃ% &
{
ÕÕ 
return
ŒŒ 
new
ŒŒ "
MatchInfoDto
ŒŒ# /
{
œœ 
MatchId
–– #
=
––$ %
matchId
––& -
,
––- .
	MatchCode
—— %
=
——& '
match
——( -
.
——- .
	matchCode
——. 7
,
——7 8
	MatchName
““ %
=
““& '
match
““( -
.
““- .
	matchName
““. 7
,
““7 8
HostUsername
”” (
=
””) *
match
””+ 0
.
””0 1
Player
””1 7
?
””7 8
.
””8 9
username
””9 A
,
””A B
DifficultyName
‘‘ *
=
‘‘+ ,
match
‘‘- 2
.
‘‘2 3
MatchDifficulty
‘‘3 B
?
‘‘B C
.
‘‘C D

difficulty
‘‘D N
,
‘‘N O
CurrentPlayers
’’ *
=
’’+ ,
_lobbies
’’- 5
.
’’5 6
TryGetValue
’’6 A
(
’’A B
matchId
’’B I
,
’’I J
out
’’K N
var
’’O R
lobby
’’S X
)
’’X Y
?
’’Z [
lobby
’’\ a
.
’’a b
Players
’’b i
.
’’i j
Count
’’j o
:
’’p q
$num
’’r s
,
’’s t

MaxPlayers
÷÷ &
=
÷÷' (
match
÷÷) .
.
÷÷. /

maxPlayers
÷÷/ 9
,
÷÷9 :
	IsPrivate
◊◊ %
=
◊◊& '
match
◊◊( -
.
◊◊- .
	isPrivate
◊◊. 7
==
◊◊8 :
$num
◊◊; <
}
ÿÿ 
;
ÿÿ 
}
ŸŸ 
}
⁄⁄ 
}
€€ 
catch
‹‹ 
(
‹‹ 
	Exception
‹‹ 
ex
‹‹ 
)
‹‹  
{
›› 
Console
ﬁﬁ 
.
ﬁﬁ 
	WriteLine
ﬁﬁ !
(
ﬁﬁ! "
$"
ﬁﬁ" $
$str
ﬁﬁ$ B
{
ﬁﬁB C
matchId
ﬁﬁC J
}
ﬁﬁJ K
$str
ﬁﬁK M
{
ﬁﬁM N
ex
ﬁﬁN P
.
ﬁﬁP Q
Message
ﬁﬁQ X
}
ﬁﬁX Y
"
ﬁﬁY Z
)
ﬁﬁZ [
;
ﬁﬁ[ \
}
ﬂﬂ 
return
‡‡ 
null
‡‡ 
;
‡‡ 
}
·· 	
public
„„ 
void
„„ 
CleanUpClient
„„ !
(
„„! "#
ILobbyServiceCallback
„„" 7
callback
„„8 @
)
„„@ A
{
‰‰ 	
string
ÂÂ 
userToRemove
ÂÂ 
=
ÂÂ  !
null
ÂÂ" &
;
ÂÂ& '
string
ÊÊ 
matchIdToRemove
ÊÊ "
=
ÊÊ# $
null
ÊÊ% )
;
ÊÊ) *
foreach
ËË 
(
ËË 
var
ËË 
	lobbyPair
ËË "
in
ËË# %
_lobbies
ËË& .
)
ËË. /
{
ÈÈ 
foreach
ÍÍ 
(
ÍÍ 
var
ÍÍ 

playerPair
ÍÍ '
in
ÍÍ( *
	lobbyPair
ÍÍ+ 4
.
ÍÍ4 5
Value
ÍÍ5 :
.
ÍÍ: ;
Players
ÍÍ; B
)
ÍÍB C
{
ÎÎ 
if
ÏÏ 
(
ÏÏ 

playerPair
ÏÏ "
.
ÏÏ" #
Value
ÏÏ# (
.
ÏÏ( )
Callback
ÏÏ) 1
==
ÏÏ2 4
callback
ÏÏ5 =
)
ÏÏ= >
{
ÌÌ 
userToRemove
ÓÓ $
=
ÓÓ% &

playerPair
ÓÓ' 1
.
ÓÓ1 2
Key
ÓÓ2 5
;
ÓÓ5 6
matchIdToRemove
ÔÔ '
=
ÔÔ( )
	lobbyPair
ÔÔ* 3
.
ÔÔ3 4
Key
ÔÔ4 7
;
ÔÔ7 8
break
 
;
 
}
ÒÒ 
}
ÚÚ 
if
ÛÛ 
(
ÛÛ 
userToRemove
ÛÛ  
!=
ÛÛ! #
null
ÛÛ$ (
)
ÛÛ( )
break
ÛÛ* /
;
ÛÛ/ 0
}
ÙÙ 
if
ˆˆ 
(
ˆˆ 
userToRemove
ˆˆ 
!=
ˆˆ 
null
ˆˆ  $
&&
ˆˆ% '
matchIdToRemove
ˆˆ( 7
!=
ˆˆ8 :
null
ˆˆ; ?
)
ˆˆ? @
{
˜˜ 

Disconnect
¯¯ 
(
¯¯ 
userToRemove
¯¯ '
,
¯¯' (
matchIdToRemove
¯¯) 8
)
¯¯8 9
;
¯¯9 :
}
˘˘ 
}
˙˙ 	
public
¸¸ 
void
¸¸ 
StartKickVote
¸¸ !
(
¸¸! "
string
¸¸" (
voterUsername
¸¸) 6
,
¸¸6 7
string
¸¸8 >
targetUsername
¸¸? M
,
¸¸M N
string
¸¸O U
matchId
¸¸V ]
)
¸¸] ^
{
˝˝ 	
Console
˛˛ 
.
˛˛ 
	WriteLine
˛˛ 
(
˛˛ 
$"
˛˛  
$str
˛˛  '
{
˛˛' (
voterUsername
˛˛( 5
}
˛˛5 6
$str
˛˛6 O
{
˛˛O P
targetUsername
˛˛P ^
}
˛˛^ _
$str
˛˛_ i
{
˛˛i j
matchId
˛˛j q
}
˛˛q r
$str
˛˛r s
"
˛˛s t
)
˛˛t u
;
˛˛u v
}
ˇˇ 	
public
ÅÅ 
void
ÅÅ 
SubmitKickVote
ÅÅ "
(
ÅÅ" #
string
ÅÅ# )
voterUsername
ÅÅ* 7
,
ÅÅ7 8
string
ÅÅ9 ?
targetUsername
ÅÅ@ N
,
ÅÅN O
string
ÅÅP V
matchId
ÅÅW ^
,
ÅÅ^ _
bool
ÅÅ` d
vote
ÅÅe i
)
ÅÅi j
{
ÇÇ 	
Console
ÉÉ 
.
ÉÉ 
	WriteLine
ÉÉ 
(
ÉÉ 
$"
ÉÉ  
$str
ÉÉ  '
{
ÉÉ' (
voterUsername
ÉÉ( 5
}
ÉÉ5 6
$str
ÉÉ6 =
{
ÉÉ= >
vote
ÉÉ> B
}
ÉÉB C
$str
ÉÉC L
{
ÉÉL M
targetUsername
ÉÉM [
}
ÉÉ[ \
$str
ÉÉ\ f
{
ÉÉf g
matchId
ÉÉg n
}
ÉÉn o
$str
ÉÉo p
"
ÉÉp q
)
ÉÉq r
;
ÉÉr s
}
ÑÑ 	
}
ÖÖ 
}ÜÜ …
íC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\BusinessLogic\GameLogic.cs
	namespace		 	
GuessMyMessServer		
 
.		 
BusinessLogic		 )
{

 
public 

class 
	GameLogic 
{ 
private 
readonly !
GuessMyMessDBEntities .
_context/ 7
;7 8
private 
static 
readonly 
Random  &
_random' .
=/ 0
new1 4
Random5 ;
(; <
)< =
;= >
public 
	GameLogic 
( !
GuessMyMessDBEntities .
context/ 6
)6 7
{ 	
_context 
= 
context 
; 
} 	
public 
async 
Task 
< 
List 
< 
WordDto &
>& '
>' (
GetRandomWordsAsync) <
(< =
)= >
{ 	
const 
int 
WordsToSelect #
=$ %
$num& '
;' (
var 
allWords 
= 
await  
_context! )
.) *
Word* .
. 
Select 
( 
w 
=> 
new  
WordDto! (
{ 
WordId 
= 
w 
. 
idWord %
,% &
WordKey 
= 
w 
.  
word1  %
} 
) 
. 
ToListAsync 
( 
) 
; 
if!! 
(!! 
allWords!! 
.!! 
Count!! 
<!!  
WordsToSelect!!! .
)!!. /
{"" 
throw## 
new## %
InvalidOperationException## 3
(##3 4
$str##4 i
)##i j
;##j k
}$$ 
var&& 
randomWords&& 
=&& 
allWords&& &
.'' 
OrderBy'' 
('' 
w'' 
=>'' 
_random'' %
.''% &
Next''& *
(''* +
)''+ ,
)'', -
.(( 
Take(( 
((( 
WordsToSelect(( #
)((# $
.)) 
ToList)) 
()) 
))) 
;)) 
return++ 
randomWords++ 
;++ 
},, 	
}-- 
}.. ›Å
úC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\BusinessLogic\AuthenticationLogic.cs
	namespace 	
GuessMyMessServer
 
. 
BusinessLogic )
{ 
public 

class 
AuthenticationLogic $
{ 
private 
readonly !
GuessMyMessDBEntities .
_context/ 7
;7 8
private 
readonly 
IEmailService &
_emailService' 4
;4 5
private 
static 
readonly 
Random  &
_random' .
=/ 0
new1 4
Random5 ;
(; <
)< =
;= >
public 
AuthenticationLogic "
(" #
IEmailService# 0
emailService1 =
,= >!
GuessMyMessDBEntities? T
contextU \
)\ ]
{ 	
_emailService 
= 
emailService (
;( )
_context 
= 
context 
; 
} 	
public 
async 
Task 
< 
OperationResultDto ,
>, -

LoginAsync. 8
(8 9
string9 ?
emailOrUsername@ O
,O P
stringQ W
passwordX `
)` a
{ 	
if 
( 
string 
. 
IsNullOrWhiteSpace )
() *
emailOrUsername* 9
)9 :
||; =
string> D
.D E
IsNullOrWhiteSpaceE W
(W X
passwordX `
)` a
)a b
{ 
throw 
new 
ArgumentException +
(+ ,
$str, W
)W X
;X Y
} 
const 
int 
StatusOnline "
=# $
$num% &
;& '
var!! 
player!! 
=!! 
await!! 
_context!! '
.!!' (
Player!!( .
.!!. /
FirstOrDefaultAsync!!/ B
(!!B C
p!!C D
=>!!E G
p"" 
."" 
username"" 
=="" 
emailOrUsername"" -
||"". 0
p""1 2
.""2 3
email""3 8
==""9 ;
emailOrUsername""< K
)""K L
;""L M
if$$ 
($$ 
player$$ 
==$$ 
null$$ 
)$$ 
{%% 
throw&& 
new&& %
InvalidOperationException&& 3
(&&3 4
$str&&4 L
)&&L M
;&&M N
}'' 
if)) 
()) 
player)) 
.)) 
is_verified)) "
==))# %
())& '
byte))' +
)))+ ,
$num)), -
)))- .
{** 
throw++ 
new++ %
InvalidOperationException++ 3
(++3 4
$str++4 r
)++r s
;++s t
},, 
if.. 
(.. 
!.. 
PasswordHasher.. 
...  
VerifyPassword..  .
(... /
password../ 7
,..7 8
player..9 ?
...? @
password..@ H
)..H I
)..I J
{// 
throw00 
new00 %
InvalidOperationException00 3
(003 4
$str004 L
)00L M
;00M N
}11 
player33 
.33 #
UserStatus_idUserStatus33 *
=33+ ,
StatusOnline33- 9
;339 :
await44 
_context44 
.44 
SaveChangesAsync44 +
(44+ ,
)44, -
;44- .
return66 
new66 
OperationResultDto66 )
{66* +
Success66, 3
=664 5
true666 :
,66: ;
Message66< C
=66D E
player66F L
.66L M
username66M U
}66V W
;66W X
}77 	
public99 
async99 
Task99 
<99 
OperationResultDto99 ,
>99, -
RegisterPlayerAsync99. A
(99A B
UserProfileDto99B P
userProfile99Q \
,99\ ]
string99^ d
password99e m
)99m n
{:: 	
if;; 
(;; 
userProfile;; 
==;; 
null;; #
||;;$ &
string;;' -
.;;- .
IsNullOrWhiteSpace;;. @
(;;@ A
password;;A I
);;I J
);;J K
{<< 
throw== 
new== !
ArgumentNullException== /
(==/ 0
nameof==0 6
(==6 7
userProfile==7 B
)==B C
,==C D
$str==E n
)==n o
;==o p
}>> 
if@@ 
(@@ 
string@@ 
.@@ 
IsNullOrWhiteSpace@@ )
(@@) *
userProfile@@* 5
.@@5 6
Username@@6 >
)@@> ?
||@@@ B
stringAA 
.AA 
IsNullOrWhiteSpaceAA )
(AA) *
userProfileAA* 5
.AA5 6
EmailAA6 ;
)AA; <
||AA= ?
stringBB 
.BB 
IsNullOrWhiteSpaceBB )
(BB) *
userProfileBB* 5
.BB5 6
	FirstNameBB6 ?
)BB? @
||BBA C
stringCC 
.CC 
IsNullOrWhiteSpaceCC )
(CC) *
userProfileCC* 5
.CC5 6
LastNameCC6 >
)CC> ?
)CC? @
{DD 
throwEE 
newEE 
ArgumentExceptionEE +
(EE+ ,
$strEE, o
)EEo p
;EEp q
}FF 
ifHH 
(HH 
!HH 
InputValidatorHH 
.HH  
IsValidEmailHH  ,
(HH, -
userProfileHH- 8
.HH8 9
EmailHH9 >
)HH> ?
)HH? @
{II 
throwJJ 
newJJ 
ArgumentExceptionJJ +
(JJ+ ,
$strJJ, b
)JJb c
;JJc d
}KK 
ifMM 
(MM 
!MM 
InputValidatorMM 
.MM  
IsPasswordSecureMM  0
(MM0 1
passwordMM1 9
)MM9 :
)MM: ;
{NN 
throwOO 
newOO 
ArgumentExceptionOO +
(OO+ ,
$strOO, c
)OOc d
;OOd e
}PP 
constRR 
intRR 
StatusOfflineRR #
=RR$ %
$numRR& '
;RR' (
stringSS 
verificationCodeSS #
=SS$ %
_randomSS& -
.SS- .
NextSS. 2
(SS2 3
$numSS3 9
,SS9 :
$numSS; A
)SSA B
.SSB C
ToStringSSC K
(SSK L
$strSSL P
)SSP Q
;SSQ R
ifUU 
(UU 
awaitUU 
_contextUU 
.UU 
PlayerUU %
.UU% &
AnyAsyncUU& .
(UU. /
pUU/ 0
=>UU1 3
pUU4 5
.UU5 6
usernameUU6 >
==UU? A
userProfileUUB M
.UUM N
UsernameUUN V
)UUV W
)UUW X
{VV 
throwWW 
newWW %
InvalidOperationExceptionWW 3
(WW3 4
$strWW4 U
)WWU V
;WWV W
}XX 
ifYY 
(YY 
awaitYY 
_contextYY 
.YY 
PlayerYY %
.YY% &
AnyAsyncYY& .
(YY. /
pYY/ 0
=>YY1 3
pYY4 5
.YY5 6
emailYY6 ;
==YY< >
userProfileYY? J
.YYJ K
EmailYYK P
)YYP Q
)YYQ R
{ZZ 
throw[[ 
new[[ %
InvalidOperationException[[ 3
([[3 4
$str[[4 V
)[[V W
;[[W X
}\\ 
try^^ 
{__ 
var`` 
emailTemplate`` !
=``" #
new``$ '%
VerificationEmailTemplate``( A
(``A B
userProfile``B M
.``M N
Username``N V
,``V W
verificationCode``X h
)``h i
;``i j
awaitaa 
_emailServiceaa #
.aa# $
SendEmailAsyncaa$ 2
(aa2 3
userProfileaa3 >
.aa> ?
Emailaa? D
,aaD E
userProfileaaF Q
.aaQ R
UsernameaaR Z
,aaZ [
emailTemplateaa\ i
)aai j
;aaj k
}bb 
catchcc 
(cc 
	Exceptioncc 
excc 
)cc  
{dd 
Consoleee 
.ee 
	WriteLineee !
(ee! "
$"ee" $
$stree$ <
{ee< =
exee= ?
.ee? @
Messageee@ G
}eeG H
"eeH I
)eeI J
;eeJ K
throwff 
newff %
InvalidOperationExceptionff 3
(ff3 4
$strff4 ~
,ff~ 
ex
ffÄ Ç
)
ffÇ É
;
ffÉ Ñ
}gg 
varii 
	newPlayerii 
=ii 
newii 
Playerii  &
{jj 
usernamekk 
=kk 
userProfilekk &
.kk& '
Usernamekk' /
,kk/ 0
emailll 
=ll 
userProfilell #
.ll# $
Emailll$ )
,ll) *
passwordmm 
=mm 
PasswordHashermm )
.mm) *
HashPasswordmm* 6
(mm6 7
passwordmm7 ?
)mm? @
,mm@ A
namenn 
=nn 
userProfilenn "
.nn" #
	FirstNamenn# ,
,nn, -
lastNameoo 
=oo 
userProfileoo &
.oo& '
LastNameoo' /
,oo/ 0
Gender_idGenderpp 
=pp  !
userProfilepp" -
.pp- .
GenderIdpp. 6
,pp6 7
Avatar_idAvatarqq 
=qq  !
userProfileqq" -
.qq- .
AvatarIdqq. 6
>qq7 8
$numqq9 :
?qq; <
userProfileqq= H
.qqH I
AvatarIdqqI Q
:qqR S
$numqqT U
,qqU V#
UserStatus_idUserStatusrr '
=rr( )
StatusOfflinerr* 7
,rr7 8
is_verifiedss 
=ss 
(ss 
bytess #
)ss# $
$numss$ %
,ss% &
verification_codett !
=tt" #
verificationCodett$ 4
,tt4 5
code_expiry_dateuu  
=uu! "
DateTimeuu# +
.uu+ ,
UtcNowuu, 2
.uu2 3

AddMinutesuu3 =
(uu= >
$numuu> @
)uu@ A
}vv 
;vv 
_contextxx 
.xx 
Playerxx 
.xx 
Addxx 
(xx  
	newPlayerxx  )
)xx) *
;xx* +
tryyy 
{zz 
await{{ 
_context{{ 
.{{ 
SaveChangesAsync{{ /
({{/ 0
){{0 1
;{{1 2
}|| 
catch}} 
(}} 
DbUpdateException}} $
dbEx}}% )
)}}) *
{~~ 
Console 
. 
	WriteLine !
(! "
$"" $
$str$ 4
{4 5
dbEx5 9
.9 :
InnerException: H
?H I
.I J
MessageJ Q
??R T
dbExU Y
.Y Z
MessageZ a
}a b
"b c
)c d
;d e
throw
ÄÄ 
new
ÄÄ '
InvalidOperationException
ÄÄ 3
(
ÄÄ3 4
$str
ÄÄ4 m
,
ÄÄm n
dbEx
ÄÄo s
)
ÄÄs t
;
ÄÄt u
}
ÅÅ 
return
ÉÉ 
new
ÉÉ  
OperationResultDto
ÉÉ )
{
ÉÉ* +
Success
ÉÉ, 3
=
ÉÉ4 5
true
ÉÉ6 :
,
ÉÉ: ;
Message
ÉÉ< C
=
ÉÉD E
$strÉÉF ë
}ÉÉí ì
;ÉÉì î
}
ÑÑ 	
public
ÖÖ 
async
ÖÖ 
Task
ÖÖ 
<
ÖÖ  
OperationResultDto
ÖÖ ,
>
ÖÖ, - 
VerifyAccountAsync
ÖÖ. @
(
ÖÖ@ A
string
ÖÖA G
email
ÖÖH M
,
ÖÖM N
string
ÖÖO U
code
ÖÖV Z
)
ÖÖZ [
{
ÜÜ 	
if
áá 
(
áá 
string
áá 
.
áá  
IsNullOrWhiteSpace
áá )
(
áá) *
email
áá* /
)
áá/ 0
||
áá1 3
string
áá4 :
.
áá: ; 
IsNullOrWhiteSpace
áá; M
(
ááM N
code
ááN R
)
ááR S
)
ááS T
{
àà 
throw
ââ 
new
ââ 
ArgumentException
ââ +
(
ââ+ ,
$str
ââ, J
)
ââJ K
;
ââK L
}
ää 
var
åå 
playerToVerify
åå 
=
åå  
await
åå! &
_context
åå' /
.
åå/ 0
Player
åå0 6
.
åå6 7!
FirstOrDefaultAsync
åå7 J
(
ååJ K
p
ååK L
=>
ååM O
p
ååP Q
.
ååQ R
email
ååR W
==
ååX Z
email
åå[ `
)
åå` a
;
ååa b
if
éé 
(
éé 
playerToVerify
éé 
==
éé !
null
éé" &
)
éé& '
{
èè 
throw
êê 
new
êê '
InvalidOperationException
êê 3
(
êê3 4
$str
êê4 Z
)
êêZ [
;
êê[ \
}
ëë 
if
ìì 
(
ìì 
playerToVerify
ìì 
.
ìì 
is_verified
ìì *
==
ìì+ -
(
ìì. /
byte
ìì/ 3
)
ìì3 4
$num
ìì4 5
)
ìì5 6
{
îî 
throw
ïï 
new
ïï '
InvalidOperationException
ïï 3
(
ïï3 4
$str
ïï4 W
)
ïïW X
;
ïïX Y
}
ññ 
if
òò 
(
òò 
playerToVerify
òò 
.
òò 
verification_code
òò 0
!=
òò1 3
code
òò4 8
||
òò9 ;
playerToVerify
òò< J
.
òòJ K
code_expiry_date
òòK [
<
òò\ ]
DateTime
òò^ f
.
òòf g
UtcNow
òòg m
)
òòm n
{
ôô 
throw
öö 
new
öö '
InvalidOperationException
öö 3
(
öö3 4
$str
öö4 [
)
öö[ \
;
öö\ ]
}
õõ 
playerToVerify
ùù 
.
ùù 
is_verified
ùù &
=
ùù' (
(
ùù) *
byte
ùù* .
)
ùù. /
$num
ùù/ 0
;
ùù0 1
playerToVerify
ûû 
.
ûû 
verification_code
ûû ,
=
ûû- .
null
ûû/ 3
;
ûû3 4
playerToVerify
üü 
.
üü 
code_expiry_date
üü +
=
üü, -
null
üü. 2
;
üü2 3
playerToVerify
†† 
.
†† %
UserStatus_idUserStatus
†† 2
=
††3 4
$num
††5 6
;
††6 7
await
¢¢ 
_context
¢¢ 
.
¢¢ 
SaveChangesAsync
¢¢ +
(
¢¢+ ,
)
¢¢, -
;
¢¢- .
return
§§ 
new
§§  
OperationResultDto
§§ )
{
§§* +
Success
§§, 3
=
§§4 5
true
§§6 :
,
§§: ;
Message
§§< C
=
§§D E
$str
§§F o
}
§§p q
;
§§q r
}
•• 	
public
¶¶ 
void
¶¶ 
LogOut
¶¶ 
(
¶¶ 
string
¶¶ !
username
¶¶" *
)
¶¶* +
{
ßß 	
const
®® 
int
®® 
StatusOffline
®® #
=
®®$ %
$num
®®& '
;
®®' (
var
™™ 
player
™™ 
=
™™ 
_context
™™ !
.
™™! "
Player
™™" (
.
™™( )
FirstOrDefault
™™) 7
(
™™7 8
p
™™8 9
=>
™™: <
p
™™= >
.
™™> ?
username
™™? G
==
™™H J
username
™™K S
)
™™S T
;
™™T U
if
´´ 
(
´´ 
player
´´ 
!=
´´ 
null
´´ 
)
´´ 
{
¨¨ 
player
≠≠ 
.
≠≠ %
UserStatus_idUserStatus
≠≠ .
=
≠≠/ 0
StatusOffline
≠≠1 >
;
≠≠> ?
_context
ÆÆ 
.
ÆÆ 
SaveChanges
ÆÆ $
(
ÆÆ$ %
)
ÆÆ% &
;
ÆÆ& '
}
ØØ 
}
∞∞ 	
}
±± 
}≤≤ 