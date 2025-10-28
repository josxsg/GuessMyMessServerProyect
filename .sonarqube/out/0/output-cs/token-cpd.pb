∑S
éC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Services\UserProfileService.cs
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
public 
UserProfileService !
(! "
)" #
{ 	
} 	
public 
async 
Task 
< 
UserProfileDto (
>( )
GetUserProfileAsync* =
(= >
string> D
usernameE M
)M N
{ 	
try 
{ 
using 
( 
var 
context "
=# $
new% (!
GuessMyMessDBEntities) >
(> ?
)? @
)@ A
{ 
var 
emailService $
=% &
new' *
SmtpEmailService+ ;
(; <
)< =
;= >
var 
logic 
= 
new  #
UserProfileLogic$ 4
(4 5
emailService5 A
,A B
contextC J
)J K
;K L
return 
await  
logic! &
.& '
GetUserProfileAsync' :
(: ;
username; C
)C D
;D E
}   
}!! 
catch"" 
("" 
	Exception"" 
ex"" 
)""  
{## 
throw$$ 
new$$ 
FaultException$$ (
($$( )
ex$$) +
.$$+ ,
Message$$, 3
)$$3 4
;$$4 5
}%% 
}&& 	
public(( 
async(( 
Task(( 
<(( 
OperationResultDto(( ,
>((, -
UpdateProfileAsync((. @
(((@ A
string((A G
username((H P
,((P Q
UserProfileDto((R `
profileData((a l
)((l m
{)) 	
try** 
{++ 
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
var// 
emailService// $
=//% &
new//' *
SmtpEmailService//+ ;
(//; <
)//< =
;//= >
var00 
logic00 
=00 
new00  #
UserProfileLogic00$ 4
(004 5
emailService005 A
,00A B
context00C J
)00J K
;00K L
return11 
await11  
logic11! &
.11& '
UpdateProfileAsync11' 9
(119 :
username11: B
,11B C
profileData11D O
)11O P
;11P Q
}22 
}33 
catch44 
(44 
	Exception44 
ex44 
)44  
{55 
throw66 
new66 
FaultException66 (
(66( )
ex66) +
.66+ ,
Message66, 3
)663 4
;664 5
}77 
}88 	
public:: 
async:: 
Task:: 
<:: 
OperationResultDto:: ,
>::, -#
RequestChangeEmailAsync::. E
(::E F
string::F L
username::M U
,::U V
string::W ]
newEmail::^ f
)::f g
{;; 	
try<< 
{== 
using?? 
(?? 
var?? 
context?? "
=??# $
new??% (!
GuessMyMessDBEntities??) >
(??> ?
)??? @
)??@ A
{@@ 
varAA 
emailServiceAA $
=AA% &
newAA' *
SmtpEmailServiceAA+ ;
(AA; <
)AA< =
;AA= >
varBB 
logicBB 
=BB 
newBB  #
UserProfileLogicBB$ 4
(BB4 5
emailServiceBB5 A
,BBA B
contextBBC J
)BBJ K
;BBK L
returnCC 
awaitCC  
logicCC! &
.CC& '#
RequestChangeEmailAsyncCC' >
(CC> ?
usernameCC? G
,CCG H
newEmailCCI Q
)CCQ R
;CCR S
}DD 
}EE 
catchFF 
(FF 
	ExceptionFF 
exFF 
)FF  
{GG 
throwHH 
newHH 
FaultExceptionHH (
(HH( )
exHH) +
.HH+ ,
MessageHH, 3
)HH3 4
;HH4 5
}II 
}JJ 	
publicLL 
asyncLL 
TaskLL 
<LL 
OperationResultDtoLL ,
>LL, -#
ConfirmChangeEmailAsyncLL. E
(LLE F
stringLLF L
usernameLLM U
,LLU V
stringLLW ]
verificationCodeLL^ n
)LLn o
{MM 	
tryNN 
{OO 
usingQQ 
(QQ 
varQQ 
contextQQ "
=QQ# $
newQQ% (!
GuessMyMessDBEntitiesQQ) >
(QQ> ?
)QQ? @
)QQ@ A
{RR 
varSS 
emailServiceSS $
=SS% &
newSS' *
SmtpEmailServiceSS+ ;
(SS; <
)SS< =
;SS= >
varTT 
logicTT 
=TT 
newTT  #
UserProfileLogicTT$ 4
(TT4 5
emailServiceTT5 A
,TTA B
contextTTC J
)TTJ K
;TTK L
returnUU 
awaitUU  
logicUU! &
.UU& '#
ConfirmChangeEmailAsyncUU' >
(UU> ?
usernameUU? G
,UUG H
verificationCodeUUI Y
)UUY Z
;UUZ [
}VV 
}WW 
catchXX 
(XX 
	ExceptionXX 
exXX 
)XX  
{YY 
throwZZ 
newZZ 
FaultExceptionZZ (
(ZZ( )
exZZ) +
.ZZ+ ,
MessageZZ, 3
)ZZ3 4
;ZZ4 5
}[[ 
}\\ 	
public^^ 
async^^ 
Task^^ 
<^^ 
OperationResultDto^^ ,
>^^, -&
RequestChangePasswordAsync^^. H
(^^H I
string^^I O
username^^P X
)^^X Y
{__ 	
try`` 
{aa 
usingcc 
(cc 
varcc 
contextcc "
=cc# $
newcc% (!
GuessMyMessDBEntitiescc) >
(cc> ?
)cc? @
)cc@ A
{dd 
varee 
emailServiceee $
=ee% &
newee' *
SmtpEmailServiceee+ ;
(ee; <
)ee< =
;ee= >
varff 
logicff 
=ff 
newff  #
UserProfileLogicff$ 4
(ff4 5
emailServiceff5 A
,ffA B
contextffC J
)ffJ K
;ffK L
returngg 
awaitgg  
logicgg! &
.gg& '&
RequestChangePasswordAsyncgg' A
(ggA B
usernameggB J
)ggJ K
;ggK L
}hh 
}ii 
catchjj 
(jj 
	Exceptionjj 
exjj 
)jj  
{kk 
throwll 
newll 
FaultExceptionll (
(ll( )
exll) +
.ll+ ,
Messagell, 3
)ll3 4
;ll4 5
}mm 
}nn 	
publicpp 
asyncpp 
Taskpp 
<pp 
OperationResultDtopp ,
>pp, -&
ConfirmChangePasswordAsyncpp. H
(ppH I
stringppI O
usernameppP X
,ppX Y
stringppZ `
newPasswordppa l
,ppl m
stringppn t
verificationCode	ppu Ö
)
ppÖ Ü
{qq 	
tryrr 
{ss 
usinguu 
(uu 
varuu 
contextuu "
=uu# $
newuu% (!
GuessMyMessDBEntitiesuu) >
(uu> ?
)uu? @
)uu@ A
{vv 
varww 
emailServiceww $
=ww% &
newww' *
SmtpEmailServiceww+ ;
(ww; <
)ww< =
;ww= >
varxx 
logicxx 
=xx 
newxx  #
UserProfileLogicxx$ 4
(xx4 5
emailServicexx5 A
,xxA B
contextxxC J
)xxJ K
;xxK L
returnyy 
awaityy  
logicyy! &
.yy& '&
ConfirmChangePasswordAsyncyy' A
(yyA B
usernameyyB J
,yyJ K
newPasswordyyL W
,yyW X
verificationCodeyyY i
)yyi j
;yyj k
}zz 
}{{ 
catch|| 
(|| 
	Exception|| 
ex|| 
)||  
{}} 
throw~~ 
new~~ 
FaultException~~ (
(~~( )
ex~~) +
.~~+ ,
Message~~, 3
)~~3 4
;~~4 5
} 
}
ÄÄ 	
public
ÇÇ 
async
ÇÇ 
Task
ÇÇ 
<
ÇÇ 
List
ÇÇ 
<
ÇÇ 
	AvatarDto
ÇÇ (
>
ÇÇ( )
>
ÇÇ) *&
GetAvailableAvatarsAsync
ÇÇ+ C
(
ÇÇC D
)
ÇÇD E
{
ÉÉ 	
try
ÑÑ 
{
ÖÖ 
using
áá 
(
áá 
var
áá 
context
áá "
=
áá# $
new
áá% (#
GuessMyMessDBEntities
áá) >
(
áá> ?
)
áá? @
)
áá@ A
{
àà 
var
ââ 
emailService
ââ $
=
ââ% &
new
ââ' *
SmtpEmailService
ââ+ ;
(
ââ; <
)
ââ< =
;
ââ= >
var
ää 
logic
ää 
=
ää 
new
ää  #
UserProfileLogic
ää$ 4
(
ää4 5
emailService
ää5 A
,
ääA B
context
ääC J
)
ääJ K
;
ääK L
return
ãã 
await
ãã  
logic
ãã! &
.
ãã& '&
GetAvailableAvatarsAsync
ãã' ?
(
ãã? @
)
ãã@ A
;
ããA B
}
åå 
}
çç 
catch
éé 
(
éé 
	Exception
éé 
ex
éé 
)
éé  
{
èè 
throw
êê 
new
êê 
FaultException
êê (
(
êê( )
ex
êê) +
.
êê+ ,
Message
êê, 3
)
êê3 4
;
êê4 5
}
ëë 
}
íí 	
}
ìì 
}îî Û'
ìC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Utilities\Email\SmtpEmailService.cs
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
}99 ˜
áC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Services\GameService.cs
	namespace		 	
GuessMyMessServer		
 
.		 
Services		 $
{

 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?

PerSession? I
)I J
]J K
public 

class 
GameService 
: 
IGameService +
{ 
private  
IGameServiceCallback $
callback% -
;- .
public 
GameService 
( 
) 
{ 	
callback 
= 
OperationContext '
.' (
Current( /
./ 0
GetCallbackChannel0 B
<B C 
IGameServiceCallbackC W
>W X
(X Y
)Y Z
;Z [
} 	
public 
void 

SelectWord 
( 
string %
username& .
,. /
string0 6
matchId7 >
,> ?
string@ F
selectedWordG S
)S T
{ 	
throw 
new #
NotImplementedException -
(- .
). /
;/ 0
} 	
public 
void 
SubmitDrawing !
(! "
string" (
username) 1
,1 2
string3 9
matchId: A
,A B
byteC G
[G H
]H I
drawingDataJ U
)U V
{ 	
throw 
new #
NotImplementedException -
(- .
). /
;/ 0
} 	
public 
void 
SubmitGuess 
(  
string  &
username' /
,/ 0
string1 7
matchId8 ?
,? @
stringA G
guessH M
)M N
{   	
throw!! 
new!! #
NotImplementedException!! -
(!!- .
)!!. /
;!!/ 0
}"" 	
public$$ 
void$$ !
SendInGameChatMessage$$ )
($$) *
string$$* 0
username$$1 9
,$$9 :
string$$; A
matchId$$B I
,$$I J
string$$K Q
message$$R Y
)$$Y Z
{%% 	
throw&& 
new&& #
NotImplementedException&& -
(&&- .
)&&. /
;&&/ 0
}'' 	
}(( 
})) ’
ãC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Utilities\InputValidator.cs
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
(-- 
password-- 
.-- 
All-- 
(-- 
char-- !
.--! "
IsLetterOrDigit--" 1
)--1 2
)--2 3
return.. 
false.. 
;.. 
return00 
true00 
;00 
}11 	
}22 
}33 Ï	
¥C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Utilities\Email\Templates\PasswordChangeVerificationEmailTemplate.cs
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
}## ó
êC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Utilities\Email\IEmailService.cs
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
} ﬁ
ëC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Utilities\Email\IEmailTemplate.cs
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
} ñ
{C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Service1.cs
	namespace 	
GuessMyMessServer
 
{		 
public 

class 
Service1 
: 
	IService1 %
{ 
public 
string 
GetData 
( 
int !
value" '
)' (
{ 	
return 
string 
. 
Format  
(  !
$str! 3
,3 4
value5 :
): ;
;; <
} 	
public 
CompositeType $
GetDataUsingDataContract 5
(5 6
CompositeType6 C
	compositeD M
)M N
{ 	
if 
( 
	composite 
== 
null !
)! "
{ 
throw 
new !
ArgumentNullException /
(/ 0
$str0 ;
); <
;< =
} 
if 
( 
	composite 
. 
	BoolValue #
)# $
{ 
	composite 
. 
StringValue %
+=& (
$str) 1
;1 2
} 
return 
	composite 
; 
} 	
} 
} ‘9
ëC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Services\AuthenticationService.cs
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
public 
async 
Task 
< 
OperationResultDto ,
>, -

LoginAsync. 8
(8 9
string9 ?
emailOrUsername@ O
,O P
stringQ W
passwordX `
)` a
{ 	
try 
{ 
using 
( 
var 
context "
=# $
new% (!
GuessMyMessDBEntities) >
(> ?
)? @
)@ A
{ 
var 
emailService $
=% &
new' *
SmtpEmailService+ ;
(; <
)< =
;= >
var 
logic 
= 
new  #
AuthenticationLogic$ 7
(7 8
emailService8 D
,D E
contextF M
)M N
;N O
return"" 
await""  
logic""! &
.""& '

LoginAsync""' 1
(""1 2
emailOrUsername""2 A
,""A B
password""C K
)""K L
;""L M
}## 
}$$ 
catch%% 
(%% 
	Exception%% 
ex%% 
)%%  
{&& 
throw'' 
new'' 
FaultException'' (
(''( )
ex'') +
.''+ ,
Message'', 3
)''3 4
;''4 5
}(( 
})) 	
public++ 
async++ 
Task++ 
<++ 
OperationResultDto++ ,
>++, -
RegisterAsync++. ;
(++; <
UserProfileDto++< J
userProfile++K V
,++V W
string++X ^
password++_ g
)++g h
{,, 	
try-- 
{.. 
using00 
(00 
var00 
context00 "
=00# $
new00% (!
GuessMyMessDBEntities00) >
(00> ?
)00? @
)00@ A
{11 
var22 
emailService22 $
=22% &
new22' *
SmtpEmailService22+ ;
(22; <
)22< =
;22= >
var33 
logic33 
=33 
new33  #
AuthenticationLogic33$ 7
(337 8
emailService338 D
,33D E
context33F M
)33M N
;33N O
return44 
await44  
logic44! &
.44& '
RegisterPlayerAsync44' :
(44: ;
userProfile44; F
,44F G
password44H P
)44P Q
;44Q R
}55 
}66 
catch77 
(77 
	Exception77 
ex77 
)77  
{88 
throw99 
new99 
FaultException99 (
(99( )
ex99) +
.99+ ,
Message99, 3
)993 4
;994 5
}:: 
};; 	
public== 
async== 
Task== 
<== 
OperationResultDto== ,
>==, -
VerifyAccountAsync==. @
(==@ A
string==A G
email==H M
,==M N
string==O U
code==V Z
)==Z [
{>> 	
try?? 
{@@ 
usingBB 
(BB 
varBB 
contextBB "
=BB# $
newBB% (!
GuessMyMessDBEntitiesBB) >
(BB> ?
)BB? @
)BB@ A
{CC 
varDD 
emailServiceDD $
=DD% &
newDD' *
SmtpEmailServiceDD+ ;
(DD; <
)DD< =
;DD= >
varEE 
logicEE 
=EE 
newEE  #
AuthenticationLogicEE$ 7
(EE7 8
emailServiceEE8 D
,EED E
contextEEF M
)EEM N
;EEN O
returnFF 
awaitFF  
logicFF! &
.FF& '
VerifyAccountAsyncFF' 9
(FF9 :
emailFF: ?
,FF? @
codeFFA E
)FFE F
;FFF G
}GG 
}HH 
catchII 
(II 
	ExceptionII 
exII 
)II  
{JJ 
throwKK 
newKK 
FaultExceptionKK (
(KK( )
exKK) +
.KK+ ,
MessageKK, 3
)KK3 4
;KK4 5
}LL 
}MM 	
publicOO 
voidOO 
LogOutOO 
(OO 
stringOO !
usernameOO" *
)OO* +
{PP 	
tryQQ 
{RR 
usingTT 
(TT 
varTT 
contextTT "
=TT# $
newTT% (!
GuessMyMessDBEntitiesTT) >
(TT> ?
)TT? @
)TT@ A
{UU 
varVV 
emailServiceVV $
=VV% &
newVV' *
SmtpEmailServiceVV+ ;
(VV; <
)VV< =
;VV= >
varWW 
logicWW 
=WW 
newWW  #
AuthenticationLogicWW$ 7
(WW7 8
emailServiceWW8 D
,WWD E
contextWWF M
)WWM N
;WWN O
logicXX 
.XX 
LogOutXX  
(XX  !
usernameXX! )
)XX) *
;XX* +
}YY 
}ZZ 
catch[[ 
([[ 
	Exception[[ 
ex[[ 
)[[  
{\\ 
Console]] 
.]] 
	WriteLine]] !
(]]! "
$"]]" $
$str]]$ >
{]]> ?
ex]]? A
.]]A B
Message]]B I
}]]I J
"]]J K
)]]K L
;]]L M
}^^ 
}__ 	
publicbb 
Taskbb 
<bb 
OperationResultDtobb &
>bb& '
LoginAsGuestAsyncbb( 9
(bb9 :
stringbb: @
usernamebbA I
,bbI J
stringbbK Q

avatarPathbbR \
)bb\ ]
{bb^ _
throwbb` e
newbbf i$
NotImplementedException	bbj Å
(
bbÅ Ç
)
bbÇ É
;
bbÉ Ñ
}
bbÖ Ü
publiccc 
Taskcc 
<cc 
OperationResultDtocc &
>cc& ')
SendPasswordRecoveryCodeAsynccc( E
(ccE F
stringccF L
emailccM R
)ccR S
{ccT U
throwccV [
newcc\ _#
NotImplementedExceptioncc` w
(ccw x
)ccx y
;ccy z
}cc{ |
publicdd 
Taskdd 
<dd 
OperationResultDtodd &
>dd& '&
ResetPasswordWithCodeAsyncdd( B
(ddB C
stringddC I
emailddJ O
,ddO P
stringddQ W
codeddX \
,dd\ ]
stringdd^ d
newPassworddde p
)ddp q
{ddr s
throwddt y
newddz }$
NotImplementedException	dd~ ï
(
ddï ñ
)
ddñ ó
;
ddó ò
}
ddô ö
}ee 
}ff Â	
ãC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Utilities\PasswordHasher.cs
	namespace 	
GuessMyMessServer
 
. 
	Utilities %
{ 
public		 

class		 
PasswordHasher		 
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
} ΩŒ
âC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Services\SocialService.cs
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
$str##$ b
{##b c
ex##c e
.##e f
Message##f m
}##m n
"##n o
)##o p
;##p q
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
{.. 
try// 
{00 
Console11 #
.11# $
	WriteLine11$ -
(11- .
$"11. 0
$str110 >
{11> ?
friendUsername11? M
}11M N
$str11N U
{11U V
username11V ^
}11^ _
$str11_ a
{11a b
status11b h
}11h i
$str11i m
"11m n
)11n o
;11o p
callback22 $
?22$ %
.22% &%
NotifyFriendStatusChanged22& ?
(22? @
username22@ H
,22H I
status22J P
)22P Q
;22Q R
Console33 #
.33# $
	WriteLine33$ -
(33- .
$"33. 0
$str330 G
{33G H
friendUsername33H V
}33V W
$str33W X
"33X Y
)33Y Z
;33Z [
}44 
catch55 
(55 #
ObjectDisposedException55 6
odEx557 ;
)55; <
{66 
Console77 #
.77# $
	WriteLine77$ -
(77- .
$"77. 0
$str770 E
{77E F
friendUsername77F T
}77T U
$str77U h
{77h i
odEx77i m
.77m n
Message77n u
}77u v
$str	77v ç
"
77ç é
)
77é è
;
77è ê
clientsToRemove88 +
.88+ ,
Add88, /
(88/ 0
friendUsername880 >
)88> ?
;88? @
}99 
catch:: 
(:: /
#CommunicationObjectAbortedException:: B
coaEx::C H
)::H I
{;; 
Console<< #
.<<# $
	WriteLine<<$ -
(<<- .
$"<<. 0
$str<<0 E
{<<E F
friendUsername<<F T
}<<T U
$str<<U a
{<<a b
coaEx<<b g
.<<g h
Message<<h o
}<<o p
$str	<<p á
"
<<á à
)
<<à â
;
<<â ä
clientsToRemove== +
.==+ ,
Add==, /
(==/ 0
friendUsername==0 >
)==> ?
;==? @
}>> 
catch?? 
(?? /
#CommunicationObjectFaultedException?? B
cofEx??C H
)??H I
{@@ 
ConsoleAA #
.AA# $
	WriteLineAA$ -
(AA- .
$"AA. 0
$strAA0 E
{AAE F
friendUsernameAAF T
}AAT U
$strAAU a
{AAa b
cofExAAb g
.AAg h
MessageAAh o
}AAo p
$str	AAp á
"
AAá à
)
AAà â
;
AAâ ä
clientsToRemoveBB +
.BB+ ,
AddBB, /
(BB/ 0
friendUsernameBB0 >
)BB> ?
;BB? @
}CC 
catchDD 
(DD 
TimeoutExceptionDD /
tExDD0 3
)DD3 4
{EE 
ConsoleFF #
.FF# $
	WriteLineFF$ -
(FF- .
$"FF. 0
$strFF0 G
{FFG H
friendUsernameFFH V
}FFV W
$strFFW Y
{FFY Z
tExFFZ ]
.FF] ^
MessageFF^ e
}FFe f
$strFFf }
"FF} ~
)FF~ 
;	FF Ä
clientsToRemoveGG +
.GG+ ,
AddGG, /
(GG/ 0
friendUsernameGG0 >
)GG> ?
;GG? @
}HH 
catchII 
(II 
	ExceptionII (
exII) +
)II+ ,
{JJ 
ConsoleKK #
.KK# $
	WriteLineKK$ -
(KK- .
$"KK. 0
$strKK0 N
{KKN O
friendUsernameKKO ]
}KK] ^
$strKK^ `
{KK` a
exKKa c
.KKc d
GetTypeKKd k
(KKk l
)KKl m
.KKm n
NameKKn r
}KKr s
$strKKs v
{KKv w
exKKw y
.KKy z
Message	KKz Å
}
KKÅ Ç
$str
KKÇ ô
"
KKô ö
)
KKö õ
;
KKõ ú
clientsToRemoveLL +
.LL+ ,
AddLL, /
(LL/ 0
friendUsernameLL0 >
)LL> ?
;LL? @
}MM 
}NN 
elseOO 
{PP 
ConsoleQQ 
.QQ  
	WriteLineQQ  )
(QQ) *
$"QQ* ,
{QQ, -
friendUsernameQQ- ;
}QQ; <
$strQQ< I
{QQI J
usernameQQJ R
}QQR S
$strQQS u
"QQu v
)QQv w
;QQw x
}RR 
}SS 
foreachUU 
(UU 
varUU 
clientToRemoveUU +
inUU, .
clientsToRemoveUU/ >
)UU> ?
{VV 
ifWW 
(WW 
connectedClientsWW (
.WW( )
ContainsKeyWW) 4
(WW4 5
clientToRemoveWW5 C
)WWC D
)WWD E
{XX 
ConsoleYY 
.YY  
	WriteLineYY  )
(YY) *
$"YY* ,
$strYY, H
{YYH I
clientToRemoveYYI W
}YYW X
"YYX Y
)YYY Z
;YYZ [
connectedClientsZZ (
.ZZ( )
RemoveZZ) /
(ZZ/ 0
clientToRemoveZZ0 >
)ZZ> ?
;ZZ? @
}[[ 
}\\ 
}]] 
}^^ 	
public`` 
void`` 
Connect`` 
(`` 
string`` "
username``# +
)``+ ,
{aa 	
ifbb 
(bb 
stringbb 
.bb 
IsNullOrEmptybb $
(bb$ %
usernamebb% -
)bb- .
)bb. /
{cc 
returndd 
;dd 
}ee 
vargg 
callbackgg 
=gg 
OperationContextgg +
.gg+ ,
Currentgg, 3
.gg3 4
GetCallbackChannelgg4 F
<ggF G"
ISocialServiceCallbackggG ]
>gg] ^
(gg^ _
)gg_ `
;gg` a
lockhh 
(hh 
connectedClientshh "
)hh" #
{ii 
ifjj 
(jj 
!jj 
connectedClientsjj %
.jj% &
ContainsKeyjj& 1
(jj1 2
usernamejj2 :
)jj: ;
)jj; <
{kk 
connectedClientsll $
.ll$ %
Addll% (
(ll( )
usernamell) 1
,ll1 2
callbackll3 ;
)ll; <
;ll< =
}mm 
elsenn 
{oo 
connectedClientspp $
[pp$ %
usernamepp% -
]pp- .
=pp/ 0
callbackpp1 9
;pp9 :
}qq 
}rr 
Tasktt 
.tt 
Runtt 
(tt 
asynctt 
(tt 
)tt 
=>tt  
{uu 
tryvv 
{ww 
awaitxx 
_socialLogicxx &
.xx& '#
UpdatePlayerStatusAsyncxx' >
(xx> ?
usernamexx? G
,xxG H
$strxxI Q
)xxQ R
;xxR S
awaityy $
NotifyFriendStatusUpdateyy 2
(yy2 3
usernameyy3 ;
,yy; <
$stryy= E
)yyE F
;yyF G
}zz 
catch{{ 
({{ 
	Exception{{  
ex{{! #
){{# $
{|| 
Console}} 
.}} 
	WriteLine}} %
(}}% &
$"}}& (
$str}}( O
{}}O P
ex}}P R
.}}R S
Message}}S Z
}}}Z [
"}}[ \
)}}\ ]
;}}] ^
}~~ 
} 
) 
; 
}
ÄÄ 	
public
ÇÇ 
void
ÇÇ 

Disconnect
ÇÇ 
(
ÇÇ 
string
ÇÇ %
username
ÇÇ& .
)
ÇÇ. /
{
ÉÉ 	
if
ÑÑ 
(
ÑÑ 
string
ÑÑ 
.
ÑÑ 
IsNullOrEmpty
ÑÑ $
(
ÑÑ$ %
username
ÑÑ% -
)
ÑÑ- .
)
ÑÑ. /
{
ÖÖ 
return
ÜÜ 
;
ÜÜ 
}
áá 
lock
ââ 
(
ââ 
connectedClients
ââ "
)
ââ" #
{
ää 
connectedClients
ãã  
.
ãã  !
Remove
ãã! '
(
ãã' (
username
ãã( 0
)
ãã0 1
;
ãã1 2
}
åå 
Task
éé 
.
éé 
Run
éé 
(
éé 
async
éé 
(
éé 
)
éé 
=>
éé  
{
èè 
try
êê 
{
ëë 
await
íí 
_socialLogic
íí &
.
íí& '%
UpdatePlayerStatusAsync
íí' >
(
íí> ?
username
íí? G
,
ííG H
$str
ííI R
)
ííR S
;
ííS T
await
ìì &
NotifyFriendStatusUpdate
ìì 2
(
ìì2 3
username
ìì3 ;
,
ìì; <
$str
ìì= F
)
ììF G
;
ììG H
}
îî 
catch
ïï 
(
ïï 
	Exception
ïï  
ex
ïï! #
)
ïï# $
{
ññ 
Console
óó 
.
óó 
	WriteLine
óó %
(
óó% &
$"
óó& (
$str
óó( R
{
óóR S
ex
óóS U
.
óóU V
Message
óóV ]
}
óó] ^
"
óó^ _
)
óó_ `
;
óó` a
}
òò 
}
ôô 
)
ôô 
;
ôô 
}
öö 	
public
úú 
async
úú 
Task
úú 
<
úú 
List
úú 
<
úú 
	FriendDto
úú (
>
úú( )
>
úú) *!
GetFriendsListAsync
úú+ >
(
úú> ?
string
úú? E
username
úúF N
)
úúN O
{
ùù 	
try
ûû 
{
üü 
return
†† 
await
†† 
_socialLogic
†† )
.
††) *!
GetFriendsListAsync
††* =
(
††= >
username
††> F
)
††F G
;
††G H
}
°° 
catch
¢¢ 
(
¢¢ 
	Exception
¢¢ 
ex
¢¢ 
)
¢¢  
{
££ 
throw
§§ 
new
§§ 
FaultException
§§ (
(
§§( )
$"
§§) +
$str
§§+ M
{
§§M N
ex
§§N P
.
§§P Q
Message
§§Q X
}
§§X Y
"
§§Y Z
)
§§Z [
;
§§[ \
}
•• 
}
¶¶ 	
public
®® 
async
®® 
Task
®® 
<
®® 
List
®® 
<
®® "
FriendRequestInfoDto
®® 3
>
®®3 4
>
®®4 5$
GetFriendRequestsAsync
®®6 L
(
®®L M
string
®®M S
username
®®T \
)
®®\ ]
{
©© 	
try
™™ 
{
´´ 
return
¨¨ 
await
¨¨ 
_socialLogic
¨¨ )
.
¨¨) *$
GetFriendRequestsAsync
¨¨* @
(
¨¨@ A
username
¨¨A I
)
¨¨I J
;
¨¨J K
}
≠≠ 
catch
ÆÆ 
(
ÆÆ 
	Exception
ÆÆ 
ex
ÆÆ 
)
ÆÆ  
{
ØØ 
throw
∞∞ 
new
∞∞ 
FaultException
∞∞ (
(
∞∞( )
$"
∞∞) +
$str
∞∞+ T
{
∞∞T U
ex
∞∞U W
.
∞∞W X
Message
∞∞X _
}
∞∞_ `
"
∞∞` a
)
∞∞a b
;
∞∞b c
}
±± 
}
≤≤ 	
public
¥¥ 
async
¥¥ 
Task
¥¥ 
<
¥¥ 
List
¥¥ 
<
¥¥ 
UserProfileDto
¥¥ -
>
¥¥- .
>
¥¥. /
SearchUsersAsync
¥¥0 @
(
¥¥@ A
string
¥¥A G
searchUsername
¥¥H V
,
¥¥V W
string
¥¥X ^
requesterUsername
¥¥_ p
)
¥¥p q
{
µµ 	
try
∂∂ 
{
∑∑ 
return
∏∏ 
await
∏∏ 
_socialLogic
∏∏ )
.
∏∏) *
SearchUsersAsync
∏∏* :
(
∏∏: ;
searchUsername
∏∏; I
,
∏∏I J
requesterUsername
∏∏K \
)
∏∏\ ]
;
∏∏] ^
}
ππ 
catch
∫∫ 
(
∫∫ 
	Exception
∫∫ 
ex
∫∫ 
)
∫∫  
{
ªª 
throw
ºº 
new
ºº 
FaultException
ºº (
(
ºº( )
$"
ºº) +
$str
ºº+ E
{
ººE F
ex
ººF H
.
ººH I
Message
ººI P
}
ººP Q
"
ººQ R
)
ººR S
;
ººS T
}
ΩΩ 
}
ææ 	
public
¿¿ 
async
¿¿ 
void
¿¿ 
SendFriendRequest
¿¿ +
(
¿¿+ ,
string
¿¿, 2
requesterUsername
¿¿3 D
,
¿¿D E
string
¿¿F L
targetUsername
¿¿M [
)
¿¿[ \
{
¡¡ 	
try
¬¬ 
{
√√ 
await
ƒƒ 
_socialLogic
ƒƒ "
.
ƒƒ" #$
SendFriendRequestAsync
ƒƒ# 9
(
ƒƒ9 :
requesterUsername
ƒƒ: K
,
ƒƒK L
targetUsername
ƒƒM [
)
ƒƒ[ \
;
ƒƒ\ ]$
ISocialServiceCallback
∆∆ &
callback
∆∆' /
;
∆∆/ 0
lock
«« 
(
«« 
connectedClients
«« &
)
««& '
{
»» 
connectedClients
…… $
.
……$ %
TryGetValue
……% 0
(
……0 1
targetUsername
……1 ?
,
……? @
out
……A D
callback
……E M
)
……M N
;
……N O
}
   
callback
ÀÀ 
?
ÀÀ 
.
ÀÀ !
NotifyFriendRequest
ÀÀ -
(
ÀÀ- .
requesterUsername
ÀÀ. ?
)
ÀÀ? @
;
ÀÀ@ A
}
ÃÃ 
catch
ÕÕ 
(
ÕÕ 
	Exception
ÕÕ 
ex
ÕÕ 
)
ÕÕ  
{
ŒŒ 
Console
œœ 
.
œœ 
	WriteLine
œœ !
(
œœ! "
$"
œœ" $
$str
œœ$ @
{
œœ@ A
ex
œœA C
.
œœC D
Message
œœD K
}
œœK L
"
œœL M
)
œœM N
;
œœN O
}
–– 
}
—— 	
public
”” 
async
”” 
void
”” $
RespondToFriendRequest
”” 0
(
””0 1
string
””1 7
targetUsername
””8 F
,
””F G
string
””H N
requesterUsername
””O `
,
””` a
bool
””b f
accepted
””g o
)
””o p
{
‘‘ 	
try
’’ 
{
÷÷ 
await
◊◊ 
_socialLogic
◊◊ "
.
◊◊" #)
RespondToFriendRequestAsync
◊◊# >
(
◊◊> ?
targetUsername
◊◊? M
,
◊◊M N
requesterUsername
◊◊O `
,
◊◊` a
accepted
◊◊b j
)
◊◊j k
;
◊◊k l$
ISocialServiceCallback
ŸŸ &
requesterCallback
ŸŸ' 8
;
ŸŸ8 9
lock
⁄⁄ 
(
⁄⁄ 
connectedClients
⁄⁄ &
)
⁄⁄& '
{
€€ 
connectedClients
‹‹ $
.
‹‹$ %
TryGetValue
‹‹% 0
(
‹‹0 1
requesterUsername
‹‹1 B
,
‹‹B C
out
‹‹D G
requesterCallback
‹‹H Y
)
‹‹Y Z
;
‹‹Z [
}
›› 
requesterCallback
ﬁﬁ !
?
ﬁﬁ! "
.
ﬁﬁ" #"
NotifyFriendResponse
ﬁﬁ# 7
(
ﬁﬁ7 8
targetUsername
ﬁﬁ8 F
,
ﬁﬁF G
accepted
ﬁﬁH P
)
ﬁﬁP Q
;
ﬁﬁQ R
if
‡‡ 
(
‡‡ 
accepted
‡‡ 
)
‡‡ 
{
·· 
bool
‚‚ 
requesterIsOnline
‚‚ *
;
‚‚* +
bool
„„ 
targetIsOnline
„„ '
;
„„' ($
ISocialServiceCallback
‰‰ *
targetCallback
‰‰+ 9
;
‰‰9 :
lock
ÊÊ 
(
ÊÊ 
connectedClients
ÊÊ *
)
ÊÊ* +
{
ÁÁ 
requesterIsOnline
ËË )
=
ËË* +
connectedClients
ËË, <
.
ËË< =
ContainsKey
ËË= H
(
ËËH I
requesterUsername
ËËI Z
)
ËËZ [
;
ËË[ \
targetIsOnline
ÈÈ &
=
ÈÈ' (
connectedClients
ÈÈ) 9
.
ÈÈ9 :
TryGetValue
ÈÈ: E
(
ÈÈE F
targetUsername
ÈÈF T
,
ÈÈT U
out
ÈÈV Y
targetCallback
ÈÈZ h
)
ÈÈh i
;
ÈÈi j
}
ÍÍ 
requesterCallback
ÏÏ %
?
ÏÏ% &
.
ÏÏ& ''
NotifyFriendStatusChanged
ÏÏ' @
(
ÏÏ@ A
targetUsername
ÏÏA O
,
ÏÏO P
targetIsOnline
ÏÏQ _
?
ÏÏ` a
$str
ÏÏb j
:
ÏÏk l
$str
ÏÏm v
)
ÏÏv w
;
ÏÏw x
targetCallback
ÌÌ "
?
ÌÌ" #
.
ÌÌ# $'
NotifyFriendStatusChanged
ÌÌ$ =
(
ÌÌ= >
requesterUsername
ÌÌ> O
,
ÌÌO P
requesterIsOnline
ÌÌQ b
?
ÌÌc d
$str
ÌÌe m
:
ÌÌn o
$str
ÌÌp y
)
ÌÌy z
;
ÌÌz {
}
ÓÓ 
}
ÔÔ 
catch
 
(
 
	Exception
 
ex
 
)
  
{
ÒÒ 
Console
ÚÚ 
.
ÚÚ 
	WriteLine
ÚÚ !
(
ÚÚ! "
$"
ÚÚ" $
$str
ÚÚ$ E
{
ÚÚE F
ex
ÚÚF H
.
ÚÚH I
Message
ÚÚI P
}
ÚÚP Q
"
ÚÚQ R
)
ÚÚR S
;
ÚÚS T
}
ÛÛ 
}
ÙÙ 	
public
ˆˆ 
async
ˆˆ 
void
ˆˆ 
RemoveFriend
ˆˆ &
(
ˆˆ& '
string
ˆˆ' -
username
ˆˆ. 6
,
ˆˆ6 7
string
ˆˆ8 >
friendToRemove
ˆˆ? M
)
ˆˆM N
{
˜˜ 	
try
¯¯ 
{
˘˘ 
await
˙˙ 
_socialLogic
˙˙ "
.
˙˙" #
RemoveFriendAsync
˙˙# 4
(
˙˙4 5
username
˙˙5 =
,
˙˙= >
friendToRemove
˙˙? M
)
˙˙M N
;
˙˙N O
}
˚˚ 
catch
¸¸ 
(
¸¸ 
	Exception
¸¸ 
ex
¸¸ 
)
¸¸  
{
˝˝ 
Console
˛˛ 
.
˛˛ 
	WriteLine
˛˛ !
(
˛˛! "
$"
˛˛" $
$str
˛˛$ ;
{
˛˛; <
ex
˛˛< >
.
˛˛> ?
Message
˛˛? F
}
˛˛F G
"
˛˛G H
)
˛˛H I
;
˛˛I J
}
ˇˇ 
}
ÄÄ 	
public
ÇÇ 
async
ÇÇ 
void
ÇÇ 
SendDirectMessage
ÇÇ +
(
ÇÇ+ ,
DirectMessageDto
ÇÇ, <
message
ÇÇ= D
)
ÇÇD E
{
ÉÉ 	
if
ÑÑ 
(
ÑÑ 
message
ÑÑ 
==
ÑÑ 
null
ÑÑ 
||
ÑÑ  "
string
ÑÑ# )
.
ÑÑ) *
IsNullOrEmpty
ÑÑ* 7
(
ÑÑ7 8
message
ÑÑ8 ?
.
ÑÑ? @
RecipientUsername
ÑÑ@ Q
)
ÑÑQ R
)
ÑÑR S
{
ÖÖ 
Console
ÜÜ 
.
ÜÜ 
	WriteLine
ÜÜ !
(
ÜÜ! "
$str
ÜÜ" D
)
ÜÜD E
;
ÜÜE F
return
áá 
;
áá 
}
àà 
try
ää 
{
ãã 
await
åå 
_socialLogic
åå "
.
åå" #$
SendDirectMessageAsync
åå# 9
(
åå9 :
message
åå: A
)
ååA B
;
ååB C$
ISocialServiceCallback
éé &
callback
éé' /
;
éé/ 0
lock
èè 
(
èè 
connectedClients
èè &
)
èè& '
{
êê 
connectedClients
ëë $
.
ëë$ %
TryGetValue
ëë% 0
(
ëë0 1
message
ëë1 8
.
ëë8 9
RecipientUsername
ëë9 J
,
ëëJ K
out
ëëL O
callback
ëëP X
)
ëëX Y
;
ëëY Z
}
íí 
callback
ìì 
?
ìì 
.
ìì #
NotifyMessageReceived
ìì /
(
ìì/ 0
message
ìì0 7
)
ìì7 8
;
ìì8 9
}
îî 
catch
ïï 
(
ïï 
	Exception
ïï 
ex
ïï 
)
ïï  
{
ññ 
Console
óó 
.
óó 
	WriteLine
óó !
(
óó! "
$"
óó" $
$str
óó$ @
{
óó@ A
ex
óóA C
.
óóC D
Message
óóD K
}
óóK L
"
óóL M
)
óóM N
;
óóN O
}
òò 
}
ôô 	
public
õõ 
async
õõ 
Task
õõ 
<
õõ 
List
õõ 
<
õõ 
	FriendDto
õõ (
>
õõ( )
>
õõ) *#
GetConversationsAsync
õõ+ @
(
õõ@ A
string
õõA G
username
õõH P
)
õõP Q
{
úú 	
try
ùù 
{
ûû 
return
üü 
await
üü 
_socialLogic
üü )
.
üü) *#
GetConversationsAsync
üü* ?
(
üü? @
username
üü@ H
)
üüH I
;
üüI J
}
†† 
catch
°° 
(
°° 
	Exception
°° 
ex
°° 
)
°°  
{
¢¢ 
throw
££ 
new
££ 
FaultException
££ (
(
££( )
$"
££) +
$str
££+ L
{
££L M
ex
££M O
.
££O P
Message
££P W
}
££W X
"
££X Y
)
££Y Z
;
££Z [
}
§§ 
}
•• 	
public
ßß 
async
ßß 
Task
ßß 
<
ßß 
List
ßß 
<
ßß 
DirectMessageDto
ßß /
>
ßß/ 0
>
ßß0 1)
GetConversationHistoryAsync
ßß2 M
(
ßßM N
string
ßßN T
user1
ßßU Z
,
ßßZ [
string
ßß\ b
user2
ßßc h
)
ßßh i
{
®® 	
try
©© 
{
™™ 
return
´´ 
await
´´ 
_socialLogic
´´ )
.
´´) *)
GetConversationHistoryAsync
´´* E
(
´´E F
user1
´´F K
,
´´K L
user2
´´M R
)
´´R S
;
´´S T
}
¨¨ 
catch
≠≠ 
(
≠≠ 
	Exception
≠≠ 
ex
≠≠ 
)
≠≠  
{
ÆÆ 
throw
ØØ 
new
ØØ 
FaultException
ØØ (
(
ØØ( )
$"
ØØ) +
$str
ØØ+ W
{
ØØW X
ex
ØØX Z
.
ØØZ [
Message
ØØ[ b
}
ØØb c
"
ØØc d
)
ØØd e
;
ØØe f
}
∞∞ 
}
±± 	
public
≥≥ 
Task
≥≥ 
<
≥≥  
OperationResultDto
≥≥ &
>
≥≥& ',
InviteFriendToGameByEmailAsync
≥≥( F
(
≥≥F G
string
≥≥G M
fromUsername
≥≥N Z
,
≥≥Z [
string
≥≥\ b
friendEmail
≥≥c n
,
≥≥n o
string
≥≥p v
	matchCode≥≥w Ä
)≥≥Ä Å
{
¥¥ 	
Console
µµ 
.
µµ 
	WriteLine
µµ 
(
µµ 
$str
µµ a
)
µµa b
;
µµb c
throw
∂∂ 
new
∂∂ %
NotImplementedException
∂∂ -
(
∂∂- .
$str
∂∂. v
)
∂∂v w
;
∂∂w x
}
∑∑ 	
}
∏∏ 
}ππ ú	
¶C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Utilities\Email\Templates\VerificationEmailTemplate.cs
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
} „	
±C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Utilities\Email\Templates\EmailChangeVerificationEmailTemplate.cs
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
}## ∂
äC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Properties\AssemblyInfo.cs
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
]$$) *∑
àC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Services\LobbyService.cs
	namespace		 	
GuessMyMessServer		
 
.		 
Services		 $
{

 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?

PerSession? I
)I J
]J K
public 

class 
LobbyService 
: 
ILobbyService  -
{ 
private !
ILobbyServiceCallback %
callback& .
;. /
public 
LobbyService 
( 
) 
{ 	
callback 
= 
OperationContext '
.' (
Current( /
./ 0
GetCallbackChannel0 B
<B C!
ILobbyServiceCallbackC X
>X Y
(Y Z
)Z [
;[ \
} 	
public 
void 
ConnectToLobby "
(" #
string# )
username* 2
,2 3
string4 :
matchId; B
)B C
{ 	
throw 
new #
NotImplementedException -
(- .
). /
;/ 0
} 	
public 
void 
SendLobbyMessage $
($ %
string% +
senderUsername, :
,: ;
string< B
matchIdC J
,J K
stringL R
messageS Z
)Z [
{ 	
throw 
new #
NotImplementedException -
(- .
). /
;/ 0
} 	
public 
void 
	StartGame 
( 
string $
hostUsername% 1
,1 2
string3 9
matchId: A
)A B
{   	
throw!! 
new!! #
NotImplementedException!! -
(!!- .
)!!. /
;!!/ 0
}"" 	
public$$ 
void$$ 

LeaveLobby$$ 
($$ 
string$$ %
username$$& .
,$$. /
string$$0 6
matchId$$7 >
)$$> ?
{%% 	
throw&& 
new&& #
NotImplementedException&& -
(&&- .
)&&. /
;&&/ 0
}'' 	
public)) 
void)) 

KickPlayer)) 
()) 
string)) %
hostUsername))& 2
,))2 3
string))4 : 
playerToKickUsername)); O
,))O P
string))Q W
matchId))X _
)))_ `
{** 	
throw++ 
new++ #
NotImplementedException++ -
(++- .
)++. /
;++/ 0
},, 	
public.. 
void.. 
StartKickVote.. !
(..! "
string.." (
voterUsername..) 6
,..6 7
string..8 >
targetUsername..? M
,..M N
string..O U
matchId..V ]
)..] ^
{// 	
throw00 
new00 #
NotImplementedException00 -
(00- .
)00. /
;00/ 0
}11 	
public33 
void33 
SubmitKickVote33 "
(33" #
string33# )
voterUsername33* 7
,337 8
string339 ?
targetUsername33@ N
,33N O
string33P V
matchId33W ^
,33^ _
bool33` d
vote33e i
)33i j
{44 	
throw55 
new55 #
NotImplementedException55 -
(55- .
)55. /
;55/ 0
}66 	
}77 
}88 ¿
éC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Services\MatchmakingService.cs
	namespace

 	
GuessMyMessServer


 
.

 
Services

 $
{ 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?

PerSession? I
)I J
]J K
public 

class 
MatchmakingService #
:$ %
IMatchmakingService& 9
{ 
private '
IMatchmakingServiceCallback +
callback, 4
;4 5
public 
MatchmakingService !
(! "
)" #
{ 	
callback 
= 
OperationContext '
.' (
Current( /
./ 0
GetCallbackChannel0 B
<B C'
IMatchmakingServiceCallbackC ^
>^ _
(_ `
)` a
;a b
} 	
public 
List 
< 
MatchInfoDto  
>  !
GetPublicMatches" 2
(2 3
)3 4
{ 	
throw 
new #
NotImplementedException -
(- .
). /
;/ 0
} 	
public 
OperationResultDto !
CreateMatch" -
(- .
string. 4
hostUsername5 A
,A B
LobbySettingsDtoC S
settingsT \
)\ ]
{ 	
throw 
new #
NotImplementedException -
(- .
). /
;/ 0
} 	
public   
void   
JoinPublicMatch   #
(  # $
string  $ *
username  + 3
,  3 4
string  5 ;
matchId  < C
)  C D
{!! 	
throw"" 
new"" #
NotImplementedException"" -
(""- .
)"". /
;""/ 0
}## 	
public%% 
OperationResultDto%% !
JoinPrivateMatch%%" 2
(%%2 3
string%%3 9
username%%: B
,%%B C
string%%D J
	matchCode%%K T
)%%T U
{&& 	
throw'' 
new'' #
NotImplementedException'' -
(''- .
)''. /
;''/ 0
}(( 	
public** 
void** 
InviteToMatch** !
(**! "
string**" (
inviterUsername**) 8
,**8 9
string**: @
invitedUsername**A P
,**P Q
string**R X
matchId**Y `
)**` a
{++ 	
throw,, 
new,, #
NotImplementedException,, -
(,,- .
),,. /
;,,/ 0
}-- 	
}.. 
}// ≥
|C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\IService1.cs
	namespace 	
GuessMyMessServer
 
{		 
[ 
ServiceContract 
] 
public 

	interface 
	IService1 
{ 
[ 	
OperationContract	 
] 
string 
GetData 
( 
int 
value  
)  !
;! "
[ 	
OperationContract	 
] 
CompositeType $
GetDataUsingDataContract .
(. /
CompositeType/ <
	composite= F
)F G
;G H
} 
[ 
DataContract 
] 
public 

class 
CompositeType 
{ 
bool 
	boolValue 
= 
true 
; 
string 
stringValue 
= 
$str %
;% &
[ 	

DataMember	 
] 
public   
bool   
	BoolValue   
{!! 	
get"" 
{"" 
return"" 
	boolValue"" "
;""" #
}""$ %
set## 
{## 
	boolValue## 
=## 
value## #
;### $
}##% &
}$$ 	
[&& 	

DataMember&&	 
]&& 
public'' 
string'' 
StringValue'' !
{(( 	
get)) 
{)) 
return)) 
stringValue)) $
;))$ %
}))& '
set** 
{** 
stringValue** 
=** 
value**  %
;**% &
}**' (
}++ 	
},, 
}-- ¶
°C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\ServiceContracts\IUserProfileService.cs
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
}** Ò6
úC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\ServiceContracts\ISocialService.cs
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
}EE ±
°C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\ServiceContracts\IMatchmakingService.cs
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
] 
List 
< 
MatchInfoDto 
> 
GetPublicMatches +
(+ ,
), -
;- .
[ 	
OperationContract	 
] 
OperationResultDto 
CreateMatch &
(& '
string' -
hostUsername. :
,: ;
LobbySettingsDto< L
settingsM U
)U V
;V W
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
JoinPublicMatch 
( 
string #
username$ ,
,, -
string. 4
matchId5 <
)< =
;= >
[ 	
OperationContract	 
] 
OperationResultDto 
JoinPrivateMatch +
(+ ,
string, 2
username3 ;
,; <
string= C
	matchCodeD M
)M N
;N O
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
InviteToMatch 
( 
string !
inviterUsername" 1
,1 2
string3 9
invitedUsername: I
,I J
stringK Q
matchIdR Y
)Y Z
;Z [
} 
[ 
ServiceContract 
] 
public 

	interface '
IMatchmakingServiceCallback 0
{   
[!! 	
OperationContract!!	 
(!! 
IsOneWay!! #
=!!$ %
true!!& *
)!!* +
]!!+ ,
void"" 
ReceiveMatchInvite"" 
(""  
string""  &
fromUsername""' 3
,""3 4
string""5 ;
matchId""< C
)""C D
;""D E
[$$ 	
OperationContract$$	 
($$ 
IsOneWay$$ #
=$$$ %
true$$& *
)$$* +
]$$+ ,
void%% 
MatchUpdate%% 
(%% 
MatchInfoDto%% %
	matchInfo%%& /
)%%/ 0
;%%0 1
['' 	
OperationContract''	 
('' 
IsOneWay'' #
=''$ %
true''& *
)''* +
]''+ ,
void(( 
MatchJoined(( 
((( 
string(( 
matchId((  '
)((' (
;((( )
[** 	
OperationContract**	 
(** 
IsOneWay** #
=**$ %
true**& *
)*** +
]**+ ,
void++ 
MatchmakingFailed++ 
(++ 
string++ %
reason++& ,
)++, -
;++- .
},, 
}-- Å)
õC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\ServiceContracts\ILobbyService.cs
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
}99 ç%
öC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\ServiceContracts\IGameService.cs
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
void 

SelectWord 
( 
string 
username '
,' (
string) /
matchId0 7
,7 8
string9 ?
selectedWord@ L
)L M
;M N
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
SubmitDrawing 
( 
string !
username" *
,* +
string, 2
matchId3 :
,: ;
byte< @
[@ A
]A B
drawingDataC N
)N O
;O P
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
SubmitGuess 
( 
string 
username  (
,( )
string* 0
matchId1 8
,8 9
string: @
guessA F
)F G
;G H
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void !
SendInGameChatMessage "
(" #
string# )
username* 2
,2 3
string4 :
matchId; B
,B C
stringD J
messageK R
)R S
;S T
} 
[ 
ServiceContract 
] 
public 

	interface  
IGameServiceCallback )
{ 
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
OnRoundStart 
( 
int 
roundNumber )
,) *
List+ /
</ 0
string0 6
>6 7
wordOptions8 C
)C D
;D E
[!! 	
OperationContract!!	 
(!! 
IsOneWay!! #
=!!$ %
true!!& *
)!!* +
]!!+ ,
void"" 
OnDrawingPhaseStart""  
(""  !
int""! $
durationSeconds""% 4
)""4 5
;""5 6
[$$ 	
OperationContract$$	 
($$ 
IsOneWay$$ #
=$$$ %
true$$& *
)$$* +
]$$+ ,
void%%  
OnGuessingPhaseStart%% !
(%%! "
byte%%" &
[%%& '
]%%' (
drawingData%%) 4
,%%4 5
string%%6 <
artistUsername%%= K
)%%K L
;%%L M
['' 	
OperationContract''	 
('' 
IsOneWay'' #
=''$ %
true''& *
)''* +
]''+ ,
void(( $
OnPlayerGuessedCorrectly(( %
(((% &
string((& ,
username((- 5
)((5 6
;((6 7
[** 	
OperationContract**	 
(** 
IsOneWay** #
=**$ %
true**& *
)*** +
]**+ ,
void++ 
OnTimeUpdate++ 
(++ 
int++ 
remainingSeconds++ .
)++. /
;++/ 0
[-- 	
OperationContract--	 
(-- 
IsOneWay-- #
=--$ %
true--& *
)--* +
]--+ ,
void.. 

OnRoundEnd.. 
(.. 
List.. 
<.. 
PlayerScoreDto.. +
>..+ ,
roundScores..- 8
,..8 9
string..: @
correctWord..A L
)..L M
;..M N
[00 	
OperationContract00	 
(00 
IsOneWay00 #
=00$ %
true00& *
)00* +
]00+ ,
void11 
	OnGameEnd11 
(11 
List11 
<11 
PlayerScoreDto11 *
>11* +
finalScores11, 7
)117 8
;118 9
}22 
}33 Ñ
§C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\ServiceContracts\IAuthenticationService.cs
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
}## …
ôC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\UserProfileDto.cs
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
} ˛
õC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\SocialNetworkDto.cs
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
} Î
îC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\FriendDto.cs
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
} ‹

òC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\LobbyStateDto.cs
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
string 
LobbyId 
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
public 
List 
< 
string 
> 
Players #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 	

DataMember	 
] 
public 
LobbySettingsDto 
CurrentSettings  /
{0 1
get2 5
;5 6
set7 :
;: ;
}< =
} 
} ˚
ùC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\OperationResultDto.cs
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
} 
} À
ôC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\PlayerScoreDto.cs
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
} ë
üC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\FriendRequestInfoDto.cs
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
} «
óC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\MatchInfoDto.cs
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
	MatchName 
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
string 
HostUsername "
{# $
get% (
;( )
set* -
;- .
}/ 0
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
string 
DifficultyName $
{% &
get' *
;* +
set, /
;/ 0
}1 2
} 
} ‹
îC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\AvatarDto.cs
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
} ¨

ôC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\ChatMessageDto.cs
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
string 
RecipientUsername '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
[ 	

DataMember	 
] 
public 
string 
Content 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
DateTime 
	Timestamp !
{" #
get$ '
;' (
set) ,
;, -
}. /
} 
} Ï
õC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\LobbySettingsDto.cs
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
int 
Rounds 
{ 
get 
;  
set! $
;$ %
}& '
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
} ∞

õC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\DirectMessageDto.cs
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
} Ñº
ëC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\BusinessLogic\UserProfileLogic.cs
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
private 
readonly 
IEmailService &
_emailService' 4
;4 5
private 
readonly !
GuessMyMessDBEntities .
_context/ 7
;7 8
private 
static 
readonly 
Random  &
_random' .
=/ 0
new1 4
Random5 ;
(; <
)< =
;= >
public 
UserProfileLogic 
(  
IEmailService  -
emailService. :
,: ;!
GuessMyMessDBEntities< Q
contextR Y
)Y Z
{ 	
_emailService 
= 
emailService (
;( )
_context 
= 
context 
; 
} 	
private 
string 
GenerateCode #
(# $
)$ %
=>& (
_random) 0
.0 1
Next1 5
(5 6
$num6 <
,< =
$num> D
)D E
.E F
ToStringF N
(N O
$strO S
)S T
;T U
public 
async 
Task 
< 
UserProfileDto (
>( )
GetUserProfileAsync* =
(= >
string> D
usernameE M
)M N
{   	
var"" 
player"" 
="" 
await"" 
_context"" '
.""' (
Player""( .
.## 
AsNoTracking## 
(## 
)## 
.$$ 
Include$$ 
($$ 
p$$ 
=>$$ 
p$$ 
.$$  
Gender$$  &
)$$& '
.%% 
Include%% 
(%% 
p%% 
=>%% 
p%% 
.%%  
Avatar%%  &
)%%& '
.&& 
FirstOrDefaultAsync&& $
(&&$ %
p&&% &
=>&&' )
p&&* +
.&&+ ,
username&&, 4
==&&5 7
username&&8 @
)&&@ A
;&&A B
if(( 
((( 
player(( 
==(( 
null(( 
)(( 
{)) 
throw** 
new** 
	Exception** #
(**# $
$str**$ <
)**< =
;**= >
}++ 
return-- 
new-- 
UserProfileDto-- %
{.. 
Username// 
=// 
player// !
.//! "
username//" *
,//* +
	FirstName00 
=00 
player00 "
.00" #
name00# '
,00' (
LastName11 
=11 
player11 !
.11! "
lastName11" *
,11* +
Email22 
=22 
player22 
.22 
email22 $
,22$ %
GenderId33 
=33 
player33 !
.33! "
Gender_idGender33" 1
.331 2
GetValueOrDefault332 C
(33C D
)33D E
,33E F
AvatarId44 
=44 
player44 !
.44! "
Avatar_idAvatar44" 1
.441 2
GetValueOrDefault442 C
(44C D
)44D E
}55 
;55 
}66 	
public88 
async88 
Task88 
<88 
OperationResultDto88 ,
>88, -
UpdateProfileAsync88. @
(88@ A
string88A G
username88H P
,88P Q
UserProfileDto88R `
profileData88a l
)88l m
{99 	
if:: 
(:: 
profileData:: 
==:: 
null:: #
)::# $
{;; 
throw<< 
new<< !
ArgumentNullException<< /
(<</ 0
nameof<<0 6
(<<6 7
profileData<<7 B
)<<B C
,<<C D
$str<<E a
)<<a b
;<<b c
}== 
var@@ 
playerToUpdate@@ 
=@@  
await@@! &
_context@@' /
.@@/ 0
Player@@0 6
.@@6 7
FirstOrDefaultAsync@@7 J
(@@J K
p@@K L
=>@@M O
p@@P Q
.@@Q R
username@@R Z
==@@[ ]
username@@^ f
)@@f g
;@@g h
ifAA 
(AA 
playerToUpdateAA 
==AA !
nullAA" &
)AA& '
{BB 
throwCC 
newCC 
	ExceptionCC #
(CC# $
$strCC$ <
)CC< =
;CC= >
}DD 
playerToUpdateFF 
.FF 
nameFF 
=FF  !
profileDataFF" -
.FF- .
	FirstNameFF. 7
;FF7 8
playerToUpdateGG 
.GG 
lastNameGG #
=GG$ %
profileDataGG& 1
.GG1 2
LastNameGG2 :
;GG: ;
playerToUpdateHH 
.HH 
Gender_idGenderHH *
=HH+ ,
profileDataHH- 8
.HH8 9
GenderIdHH9 A
;HHA B
playerToUpdateII 
.II 
Avatar_idAvatarII *
=II+ ,
profileDataII- 8
.II8 9
AvatarIdII9 A
>IIB C
$numIID E
?IIF G
profileDataIIH S
.IIS T
AvatarIdIIT \
:II] ^
playerToUpdateII_ m
.IIm n
Avatar_idAvatarIIn }
;II} ~
awaitKK 
_contextKK 
.KK 
SaveChangesAsyncKK +
(KK+ ,
)KK, -
;KK- .
returnLL 
newLL 
OperationResultDtoLL )
{LL* +
SuccessLL, 3
=LL4 5
trueLL6 :
,LL: ;
MessageLL< C
=LLD E
$strLLF i
}LLj k
;LLk l
}MM 	
publicOO 
asyncOO 
TaskOO 
<OO 
ListOO 
<OO 
	AvatarDtoOO (
>OO( )
>OO) *$
GetAvailableAvatarsAsyncOO+ C
(OOC D
)OOD E
{PP 	
varRR 
avatarsFromDbRR 
=RR 
awaitRR  %
_contextRR& .
.RR. /
AvatarRR/ 5
.RR5 6
AsNoTrackingRR6 B
(RRB C
)RRC D
.RRD E
ToListAsyncRRE P
(RRP Q
)RRQ R
;RRR S
varSS 
avatarsDtoListSS 
=SS  
newSS! $
ListSS% )
<SS) *
	AvatarDtoSS* 3
>SS3 4
(SS4 5
)SS5 6
;SS6 7
stringTT 
basePathTT 
=TT 
	AppDomainTT '
.TT' (
CurrentDomainTT( 5
.TT5 6
BaseDirectoryTT6 C
;TTC D
foreachVV 
(VV 
varVV 
avatarRecordVV %
inVV& (
avatarsFromDbVV) 6
)VV6 7
{WW 
byteXX 
[XX 
]XX 
	imageDataXX  
=XX! "
nullXX# '
;XX' (
ifYY 
(YY 
!YY 
stringYY 
.YY 
IsNullOrEmptyYY )
(YY) *
avatarRecordYY* 6
.YY6 7
	avatarUrlYY7 @
)YY@ A
)YYA B
{ZZ 
string[[ 
filePath[[ #
=[[$ %
Path[[& *
.[[* +
Combine[[+ 2
([[2 3
basePath[[3 ;
,[[; <
avatarRecord[[= I
.[[I J
	avatarUrl[[J S
)[[S T
;[[T U
if]] 
(]] 
File]] 
.]] 
Exists]] #
(]]# $
filePath]]$ ,
)]], -
)]]- .
{^^ 
try__ 
{`` 
usingaa !
(aa" #

FileStreamaa# -
streamaa. 4
=aa5 6
newaa7 :

FileStreamaa; E
(aaE F
filePathaaF N
,aaN O
FileModeaaP X
.aaX Y
OpenaaY ]
,aa] ^

FileAccessaa_ i
.aai j
Readaaj n
,aan o
	FileShareaap y
.aay z
Readaaz ~
,aa~ 

bufferSize
aaÄ ä
:
aaä ã
$num
aaå ê
,
aaê ë
useAsync
aaí ö
:
aaö õ
true
aaú †
)
aa† °
)
aa° ¢
{bb 
	imageDatacc  )
=cc* +
newcc, /
bytecc0 4
[cc4 5
streamcc5 ;
.cc; <
Lengthcc< B
]ccB C
;ccC D
awaitdd  %
streamdd& ,
.dd, -
	ReadAsyncdd- 6
(dd6 7
	imageDatadd7 @
,dd@ A
$numddB C
,ddC D
	imageDataddE N
.ddN O
LengthddO U
)ddU V
;ddV W
}ee 
}ff 
catchgg 
(gg 
IOExceptiongg *
ioExgg+ /
)gg/ 0
{hh 
Consoleii #
.ii# $
	WriteLineii$ -
(ii- .
$"ii. 0
$strii0 P
{iiP Q
filePathiiQ Y
}iiY Z
$striiZ \
{ii\ ]
ioExii] a
.iia b
Messageiib i
}iii j
"iij k
)iik l
;iil m
}jj 
catchkk 
(kk 
	Exceptionkk (
exkk) +
)kk+ ,
{ll 
Consolemm #
.mm# $
	WriteLinemm$ -
(mm- .
$"mm. 0
$strmm0 T
{mmT U
filePathmmU ]
}mm] ^
$strmm^ `
{mm` a
exmma c
.mmc d
Messagemmd k
}mmk l
"mml m
)mmm n
;mmn o
}nn 
}oo 
elsepp 
{qq 
Consolerr 
.rr  
	WriteLinerr  )
(rr) *
$"rr* ,
$strrr, i
{rri j
filePathrrj r
}rrr s
"rrs t
)rrt u
;rru v
}ss 
}tt 
avatarsDtoListuu 
.uu 
Adduu "
(uu" #
newuu# &
	AvatarDtouu' 0
{vv 
IdAvatarww 
=ww 
avatarRecordww +
.ww+ ,
idAvatarww, 4
,ww4 5

AvatarNamexx 
=xx  
avatarRecordxx! -
.xx- .

avatarNamexx. 8
,xx8 9

AvatarDatayy 
=yy  
	imageDatayy! *
}zz 
)zz 
;zz 
}{{ 
return|| 
avatarsDtoList|| !
;||! "
}}} 	
public 
async 
Task 
< 
OperationResultDto ,
>, -&
RequestChangePasswordAsync. H
(H I
stringI O
usernameP X
)X Y
{
ÄÄ 	
var
ÇÇ 
player
ÇÇ 
=
ÇÇ 
await
ÇÇ 
_context
ÇÇ '
.
ÇÇ' (
Player
ÇÇ( .
.
ÇÇ. /!
FirstOrDefaultAsync
ÇÇ/ B
(
ÇÇB C
p
ÇÇC D
=>
ÇÇE G
p
ÇÇH I
.
ÇÇI J
username
ÇÇJ R
==
ÇÇS U
username
ÇÇV ^
)
ÇÇ^ _
;
ÇÇ_ `
if
ÉÉ 
(
ÉÉ 
player
ÉÉ 
==
ÉÉ 
null
ÉÉ 
)
ÉÉ 
{
ÑÑ 
throw
ÖÖ 
new
ÖÖ 
	Exception
ÖÖ #
(
ÖÖ# $
$str
ÖÖ$ <
)
ÖÖ< =
;
ÖÖ= >
}
ÜÜ 
string
àà 
code
àà 
=
àà 
GenerateCode
àà &
(
àà& '
)
àà' (
;
àà( )
player
ââ 
.
ââ 
	temp_code
ââ 
=
ââ 
code
ââ #
;
ââ# $
player
ää 
.
ää 
temp_code_expiry
ää #
=
ää$ %
DateTime
ää& .
.
ää. /
UtcNow
ää/ 5
.
ää5 6

AddMinutes
ää6 @
(
ää@ A
$num
ääA C
)
ääC D
;
ääD E
await
ãã 
_context
ãã 
.
ãã 
SaveChangesAsync
ãã +
(
ãã+ ,
)
ãã, -
;
ãã- .
var
çç 
emailTemplate
çç 
=
çç 
new
çç  #5
'PasswordChangeVerificationEmailTemplate
çç$ K
(
ççK L
player
ççL R
.
ççR S
username
ççS [
,
çç[ \
code
çç] a
)
çça b
;
ççb c
await
éé 
_emailService
éé 
.
éé  
SendEmailAsync
éé  .
(
éé. /
player
éé/ 5
.
éé5 6
email
éé6 ;
,
éé; <
player
éé= C
.
ééC D
username
ééD L
,
ééL M
emailTemplate
ééN [
)
éé[ \
;
éé\ ]
return
êê 
new
êê  
OperationResultDto
êê )
{
êê* +
Success
êê, 3
=
êê4 5
true
êê6 :
,
êê: ;
Message
êê< C
=
êêD E
$strêêF á
}êêà â
;êêâ ä
}
ëë 	
public
ìì 
async
ìì 
Task
ìì 
<
ìì  
OperationResultDto
ìì ,
>
ìì, -%
RequestChangeEmailAsync
ìì. E
(
ììE F
string
ììF L
username
ììM U
,
ììU V
string
ììW ]
newEmail
ìì^ f
)
ììf g
{
îî 	
if
ïï 
(
ïï 
string
ïï 
.
ïï  
IsNullOrWhiteSpace
ïï )
(
ïï) *
newEmail
ïï* 2
)
ïï2 3
||
ïï4 6
!
ïï7 8
InputValidator
ïï8 F
.
ïïF G
IsValidEmail
ïïG S
(
ïïS T
newEmail
ïïT \
)
ïï\ ]
)
ïï] ^
{
ññ 
throw
óó 
new
óó 
	Exception
óó #
(
óó# $
$str
óó$ S
)
óóS T
;
óóT U
}
òò 
var
õõ 
player
õõ 
=
õõ 
await
õõ 
_context
õõ '
.
õõ' (
Player
õõ( .
.
õõ. /!
FirstOrDefaultAsync
õõ/ B
(
õõB C
p
õõC D
=>
õõE G
p
õõH I
.
õõI J
username
õõJ R
==
õõS U
username
õõV ^
)
õõ^ _
;
õõ_ `
if
úú 
(
úú 
player
úú 
==
úú 
null
úú 
)
úú 
{
ùù 
throw
ûû 
new
ûû 
	Exception
ûû #
(
ûû# $
$str
ûû$ <
)
ûû< =
;
ûû= >
}
üü 
if
†† 
(
†† 
await
†† 
_context
†† 
.
†† 
Player
†† %
.
††% &
AnyAsync
††& .
(
††. /
p
††/ 0
=>
††1 3
p
††4 5
.
††5 6
email
††6 ;
==
††< >
newEmail
††? G
)
††G H
)
††H I
{
°° 
throw
¢¢ 
new
¢¢ 
	Exception
¢¢ #
(
¢¢# $
$str
¢¢$ I
)
¢¢I J
;
¢¢J K
}
££ 
string
•• 
code
•• 
=
•• 
GenerateCode
•• &
(
••& '
)
••' (
;
••( )
player
¶¶ 
.
¶¶ 
	temp_code
¶¶ 
=
¶¶ 
code
¶¶ #
;
¶¶# $
player
ßß 
.
ßß 
temp_code_expiry
ßß #
=
ßß$ %
DateTime
ßß& .
.
ßß. /
UtcNow
ßß/ 5
.
ßß5 6

AddMinutes
ßß6 @
(
ßß@ A
$num
ßßA C
)
ßßC D
;
ßßD E
player
®® 
.
®® 
new_email_pending
®® $
=
®®% &
newEmail
®®' /
;
®®/ 0
await
©© 
_context
©© 
.
©© 
SaveChangesAsync
©© +
(
©©+ ,
)
©©, -
;
©©- .
var
´´ 
emailTemplate
´´ 
=
´´ 
new
´´  #2
$EmailChangeVerificationEmailTemplate
´´$ H
(
´´H I
player
´´I O
.
´´O P
username
´´P X
,
´´X Y
code
´´Z ^
)
´´^ _
;
´´_ `
await
¨¨ 
_emailService
¨¨ 
.
¨¨  
SendEmailAsync
¨¨  .
(
¨¨. /
player
¨¨/ 5
.
¨¨5 6
email
¨¨6 ;
,
¨¨; <
player
¨¨= C
.
¨¨C D
username
¨¨D L
,
¨¨L M
emailTemplate
¨¨N [
)
¨¨[ \
;
¨¨\ ]
return
ÆÆ 
new
ÆÆ  
OperationResultDto
ÆÆ )
{
ÆÆ* +
Success
ÆÆ, 3
=
ÆÆ4 5
true
ÆÆ6 :
,
ÆÆ: ;
Message
ÆÆ< C
=
ÆÆD E
$"
ÆÆF H
$str
ÆÆH t
{
ÆÆt u
player
ÆÆu {
.
ÆÆ{ |
emailÆÆ| Å
}ÆÆÅ Ç
$strÆÆÇ ì
"ÆÆì î
}ÆÆï ñ
;ÆÆñ ó
}
ØØ 	
public
±± 
async
±± 
Task
±± 
<
±±  
OperationResultDto
±± ,
>
±±, -(
ConfirmChangePasswordAsync
±±. H
(
±±H I
string
±±I O
username
±±P X
,
±±X Y
string
±±Z `
newPassword
±±a l
,
±±l m
string
±±n t
verificationCode±±u Ö
)±±Ö Ü
{
≤≤ 	
if
≥≥ 
(
≥≥ 
!
≥≥ 
InputValidator
≥≥ 
.
≥≥  
IsPasswordSecure
≥≥  0
(
≥≥0 1
newPassword
≥≥1 <
)
≥≥< =
)
≥≥= >
{
¥¥ 
throw
µµ 
new
µµ 
	Exception
µµ #
(
µµ# $
$str
µµ$ d
)
µµd e
;
µµe f
}
∂∂ 
var
ππ 
player
ππ 
=
ππ 
await
ππ 
_context
ππ '
.
ππ' (
Player
ππ( .
.
ππ. /!
FirstOrDefaultAsync
ππ/ B
(
ππB C
p
ππC D
=>
ππE G
p
ππH I
.
ππI J
username
ππJ R
==
ππS U
username
ππV ^
)
ππ^ _
;
ππ_ `
if
∫∫ 
(
∫∫ 
player
∫∫ 
==
∫∫ 
null
∫∫ 
)
∫∫ 
{
ªª 
throw
ºº 
new
ºº 
	Exception
ºº #
(
ºº# $
$str
ºº$ <
)
ºº< =
;
ºº= >
}
ΩΩ 
if
ææ 
(
ææ 
player
ææ 
.
ææ 
	temp_code
ææ  
!=
ææ! #
verificationCode
ææ$ 4
||
ææ5 7
player
ææ8 >
.
ææ> ?
temp_code_expiry
ææ? O
<
ææP Q
DateTime
ææR Z
.
ææZ [
UtcNow
ææ[ a
)
ææa b
{
øø 
throw
¿¿ 
new
¿¿ 
	Exception
¿¿ #
(
¿¿# $
$str
¿¿$ Q
)
¿¿Q R
;
¿¿R S
}
¡¡ 
player
√√ 
.
√√ 
password
√√ 
=
√√ 
PasswordHasher
√√ ,
.
√√, -
HashPassword
√√- 9
(
√√9 :
newPassword
√√: E
)
√√E F
;
√√F G
player
ƒƒ 
.
ƒƒ 
	temp_code
ƒƒ 
=
ƒƒ 
null
ƒƒ #
;
ƒƒ# $
player
≈≈ 
.
≈≈ 
temp_code_expiry
≈≈ #
=
≈≈$ %
null
≈≈& *
;
≈≈* +
await
∆∆ 
_context
∆∆ 
.
∆∆ 
SaveChangesAsync
∆∆ +
(
∆∆+ ,
)
∆∆, -
;
∆∆- .
return
»» 
new
»»  
OperationResultDto
»» )
{
»»* +
Success
»», 3
=
»»4 5
true
»»6 :
,
»»: ;
Message
»»< C
=
»»D E
$str
»»F i
}
»»j k
;
»»k l
}
…… 	
public
ÀÀ 
async
ÀÀ 
Task
ÀÀ 
<
ÀÀ  
OperationResultDto
ÀÀ ,
>
ÀÀ, -%
ConfirmChangeEmailAsync
ÀÀ. E
(
ÀÀE F
string
ÀÀF L
username
ÀÀM U
,
ÀÀU V
string
ÀÀW ]
verificationCode
ÀÀ^ n
)
ÀÀn o
{
ÃÃ 	
var
ŒŒ 
player
ŒŒ 
=
ŒŒ 
await
ŒŒ 
_context
ŒŒ '
.
ŒŒ' (
Player
ŒŒ( .
.
ŒŒ. /!
FirstOrDefaultAsync
ŒŒ/ B
(
ŒŒB C
p
ŒŒC D
=>
ŒŒE G
p
ŒŒH I
.
ŒŒI J
username
ŒŒJ R
==
ŒŒS U
username
ŒŒV ^
)
ŒŒ^ _
;
ŒŒ_ `
if
œœ 
(
œœ 
player
œœ 
==
œœ 
null
œœ 
)
œœ 
{
–– 
throw
—— 
new
—— 
	Exception
—— #
(
——# $
$str
——$ <
)
——< =
;
——= >
}
““ 
if
”” 
(
”” 
string
”” 
.
”” 
IsNullOrEmpty
”” $
(
””$ %
player
””% +
.
””+ ,
new_email_pending
””, =
)
””= >
)
””> ?
{
‘‘ 
throw
’’ 
new
’’ 
	Exception
’’ #
(
’’# $
$str
’’$ J
)
’’J K
;
’’K L
}
÷÷ 
if
◊◊ 
(
◊◊ 
player
◊◊ 
.
◊◊ 
	temp_code
◊◊  
!=
◊◊! #
verificationCode
◊◊$ 4
||
◊◊5 7
player
◊◊8 >
.
◊◊> ?
temp_code_expiry
◊◊? O
<
◊◊P Q
DateTime
◊◊R Z
.
◊◊Z [
UtcNow
◊◊[ a
)
◊◊a b
{
ÿÿ 
throw
ŸŸ 
new
ŸŸ 
	Exception
ŸŸ #
(
ŸŸ# $
$str
ŸŸ$ Q
)
ŸŸQ R
;
ŸŸR S
}
⁄⁄ 
if
‹‹ 
(
‹‹ 
await
‹‹ 
_context
‹‹ 
.
‹‹ 
Player
‹‹ %
.
‹‹% &
AnyAsync
‹‹& .
(
‹‹. /
p
‹‹/ 0
=>
‹‹1 3
p
‹‹4 5
.
‹‹5 6
email
‹‹6 ;
==
‹‹< >
player
‹‹? E
.
‹‹E F
new_email_pending
‹‹F W
&&
‹‹X Z
p
‹‹[ \
.
‹‹\ ]
idPlayer
‹‹] e
!=
‹‹f h
player
‹‹i o
.
‹‹o p
idPlayer
‹‹p x
)
‹‹x y
)
‹‹y z
{
›› 
player
ﬁﬁ 
.
ﬁﬁ 
	temp_code
ﬁﬁ  
=
ﬁﬁ! "
null
ﬁﬁ# '
;
ﬁﬁ' (
player
ﬂﬂ 
.
ﬂﬂ 
temp_code_expiry
ﬂﬂ '
=
ﬂﬂ( )
null
ﬂﬂ* .
;
ﬂﬂ. /
player
‡‡ 
.
‡‡ 
new_email_pending
‡‡ (
=
‡‡) *
null
‡‡+ /
;
‡‡/ 0
await
·· 
_context
·· 
.
·· 
SaveChangesAsync
·· /
(
··/ 0
)
··0 1
;
··1 2
throw
‚‚ 
new
‚‚ 
	Exception
‚‚ #
(
‚‚# $
$str
‚‚$ e
)
‚‚e f
;
‚‚f g
}
„„ 
player
ÂÂ 
.
ÂÂ 
email
ÂÂ 
=
ÂÂ 
player
ÂÂ !
.
ÂÂ! "
new_email_pending
ÂÂ" 3
;
ÂÂ3 4
player
ÊÊ 
.
ÊÊ 
	temp_code
ÊÊ 
=
ÊÊ 
null
ÊÊ #
;
ÊÊ# $
player
ÁÁ 
.
ÁÁ 
temp_code_expiry
ÁÁ #
=
ÁÁ$ %
null
ÁÁ& *
;
ÁÁ* +
player
ËË 
.
ËË 
new_email_pending
ËË $
=
ËË% &
null
ËË' +
;
ËË+ ,
await
ÈÈ 
_context
ÈÈ 
.
ÈÈ 
SaveChangesAsync
ÈÈ +
(
ÈÈ+ ,
)
ÈÈ, -
;
ÈÈ- .
return
ÎÎ 
new
ÎÎ  
OperationResultDto
ÎÎ )
{
ÎÎ* +
Success
ÎÎ, 3
=
ÎÎ4 5
true
ÎÎ6 :
,
ÎÎ: ;
Message
ÎÎ< C
=
ÎÎD E
$str
ÎÎF d
}
ÎÎe f
;
ÎÎf g
}
ÏÏ 	
}
ÌÌ 
}ÓÓ Ÿô
åC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\BusinessLogic\SocialLogic.cs
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
new 
	Exception '
(' (
$str( @
)@ A
;A B
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
newQQ 
	ExceptionQQ '
(QQ' (
$strQQ( L
)QQL M
;QQM N
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
newqq 
	Exceptionqq '
(qq' (
$strqq( W
)qqW X
;qqX Y
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
newvv 
	Exceptionvv '
(vv' (
$strvv( V
)vvV W
;vvW X
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
new 
	Exception '
(' (
$str( l
)l m
;m n
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
ÜÜ 
	Exception
ÜÜ '
(
ÜÜ' (
$str
ÜÜ( d
)
ÜÜd e
;
ÜÜe f
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
ùù& \
)
ùù\ ]
;
ùù] ^
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
••. /
.
••/ 0
Player_idPlayer2
••0 @
==
••A C
target
••D J
.
••J K
idPlayer
••K S
&&
••T V
f
¶¶. /
.
¶¶/ 0
FriendShipStatus
¶¶0 @
.
¶¶@ A
status
¶¶A G
==
¶¶H J
PendingStatus
¶¶K X
)
¶¶X Y
;
¶¶Y Z
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
™™ 
	Exception
™™ '
(
™™' (
$str
™™( c
)
™™c d
;
™™d e
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
≥≥ !
	Exception
≥≥" +
(
≥≥+ ,
$str
≥≥, i
)
≥≥i j
;
≥≥j k
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
»»& W
)
»»W X
;
»»X Y
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
◊◊( V
{
◊◊V W
username
◊◊W _
}
◊◊_ `
$str
◊◊` c
{
◊◊c d
friendToRemove
◊◊d r
}
◊◊r s
$str
◊◊s t
"
◊◊t u
)
◊◊u v
;
◊◊v w
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
„„ 
	Exception
„„ '
(
„„' (
$"
„„( *
$str
„„* 3
{
„„3 4
username
„„4 <
}
„„< =
$str
„„= d
"
„„d e
)
„„e f
;
„„f g
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
ÈÈ 
	Exception
ÈÈ '
(
ÈÈ' (
$"
ÈÈ( *
$str
ÈÈ* =
{
ÈÈ= >
status
ÈÈ> D
}
ÈÈD E
$str
ÈÈE T
"
ÈÈT U
)
ÈÈU V
;
ÈÈV W
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
˘˘, Z
)
˘˘Z [
;
˘˘[ \
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
ÉÉ 
	Exception
ÉÉ '
(
ÉÉ' (
$str
ÉÉ( `
)
ÉÉ` a
;
ÉÉa b
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
}œœ ß
îC:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\BusinessLogic\AuthenticationLogic.cs
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
private 
readonly !
GuessMyMessDBEntities .
_context/ 7
;7 8
private 
readonly 
IEmailService &
_emailService' 4
;4 5
private 
static 
readonly 
Random  &
_random' .
=/ 0
new1 4
Random5 ;
(; <
)< =
;= >
public 
AuthenticationLogic "
(" #
IEmailService# 0
emailService1 =
,= >!
GuessMyMessDBEntities? T
contextU \
)\ ]
{ 	
_emailService 
= 
emailService (
;( )
_context 
= 
context 
; 
} 	
public 
async 
Task 
< 
OperationResultDto ,
>, -

LoginAsync. 8
(8 9
string9 ?
emailOrUsername@ O
,O P
stringQ W
passwordX `
)` a
{ 	
if 
( 
string 
. 
IsNullOrWhiteSpace )
() *
emailOrUsername* 9
)9 :
||; =
string> D
.D E
IsNullOrWhiteSpaceE W
(W X
passwordX `
)` a
)a b
{ 
throw 
new 
	Exception #
(# $
$str$ S
)S T
;T U
}   
const"" 
int"" 
StatusOnline"" "
=""# $
$num""% &
;""& '
var&& 
player&& 
=&& 
await&& 
_context&& '
.&&' (
Player&&( .
.&&. /
FirstOrDefaultAsync&&/ B
(&&B C
p&&C D
=>&&E G
p'' 
.'' 
username'' 
=='' 
emailOrUsername'' -
||''. 0
p''1 2
.''2 3
email''3 8
==''9 ;
emailOrUsername''< K
)''K L
;''L M
if)) 
()) 
player)) 
==)) 
null)) 
))) 
{** 
throw++ 
new++ 
	Exception++ #
(++# $
$str++$ ?
)++? @
;++@ A
},, 
if.. 
(.. 
player.. 
... 
is_verified.. "
==..# %
(..& '
byte..' +
)..+ ,
$num.., -
)..- .
{// 
throw00 
new00 
	Exception00 #
(00# $
$str00$ c
)00c d
;00d e
}11 
if44 
(44 
!44 
PasswordHasher44 
.44  
VerifyPassword44  .
(44. /
password44/ 7
,447 8
player449 ?
.44? @
password44@ H
)44H I
)44I J
{55 
throw66 
new66 
	Exception66 #
(66# $
$str66$ ?
)66? @
;66@ A
}77 
player99 
.99 #
UserStatus_idUserStatus99 *
=99+ ,
StatusOnline99- 9
;999 :
await:: 
_context:: 
.:: 
SaveChangesAsync:: +
(::+ ,
)::, -
;::- .
return<< 
new<< 
OperationResultDto<< )
{<<* +
Success<<, 3
=<<4 5
true<<6 :
,<<: ;
Message<<< C
=<<D E
player<<F L
.<<L M
username<<M U
}<<V W
;<<W X
}== 	
public?? 
async?? 
Task?? 
<?? 
OperationResultDto?? ,
>??, -
RegisterPlayerAsync??. A
(??A B
UserProfileDto??B P
userProfile??Q \
,??\ ]
string??^ d
password??e m
)??m n
{@@ 	
ifAA 
(AA 
userProfileAA 
==AA 
nullAA #
||AA$ &
stringAA' -
.AA- .
IsNullOrWhiteSpaceAA. @
(AA@ A
passwordAAA I
)AAI J
)AAJ K
{BB 
throwCC 
newCC 
	ExceptionCC #
(CC# $
$strCC$ \
)CC\ ]
;CC] ^
}DD 
ifFF 
(FF 
stringFF 
.FF 
IsNullOrWhiteSpaceFF )
(FF) *
userProfileFF* 5
.FF5 6
UsernameFF6 >
)FF> ?
||FF@ B
stringGG 
.GG 
IsNullOrWhiteSpaceGG )
(GG) *
userProfileGG* 5
.GG5 6
EmailGG6 ;
)GG; <
||GG= ?
stringHH 
.HH 
IsNullOrWhiteSpaceHH )
(HH) *
userProfileHH* 5
.HH5 6
	FirstNameHH6 ?
)HH? @
||HHA C
stringII 
.II 
IsNullOrWhiteSpaceII )
(II) *
userProfileII* 5
.II5 6
LastNameII6 >
)II> ?
)II? @
{JJ 
throwKK 
newKK 
	ExceptionKK #
(KK# $
$strKK$ k
)KKk l
;KKl m
}LL 
ifNN 
(NN 
!NN 
InputValidatorNN 
.NN  
IsValidEmailNN  ,
(NN, -
userProfileNN- 8
.NN8 9
EmailNN9 >
)NN> ?
)NN? @
{OO 
throwPP 
newPP 
	ExceptionPP #
(PP# $
$strPP$ o
)PPo p
;PPp q
}QQ 
ifSS 
(SS 
!SS 
InputValidatorSS 
.SS  
IsPasswordSecureSS  0
(SS0 1
passwordSS1 9
)SS9 :
)SS: ;
{TT 
throwUU 
newUU 
	ExceptionUU #
(UU# $
$strUU$ ^
)UU^ _
;UU_ `
}VV 
constXX 
intXX 
StatusOfflineXX #
=XX$ %
$numXX& '
;XX' (
stringYY 
verificationCodeYY #
=YY$ %
_randomYY& -
.YY- .
NextYY. 2
(YY2 3
$numYY3 9
,YY9 :
$numYY; A
)YYA B
.YYB C
ToStringYYC K
(YYK L
$strYYL P
)YYP Q
;YYQ R
if\\ 
(\\ 
await\\ 
_context\\ 
.\\ 
Player\\ %
.\\% &
AnyAsync\\& .
(\\. /
p\\/ 0
=>\\1 3
p\\4 5
.\\5 6
username\\6 >
==\\? A
userProfile\\B M
.\\M N
Username\\N V
)\\V W
)\\W X
{]] 
throw^^ 
new^^ 
	Exception^^ #
(^^# $
$str^^$ J
)^^J K
;^^K L
}__ 
if`` 
(`` 
await`` 
_context`` 
.`` 
Player`` %
.``% &
AnyAsync``& .
(``. /
p``/ 0
=>``1 3
p``4 5
.``5 6
email``6 ;
==``< >
userProfile``? J
.``J K
Email``K P
)``P Q
)``Q R
{aa 
throwbb 
newbb 
	Exceptionbb #
(bb# $
$strbb$ O
)bbO P
;bbP Q
}cc 
tryee 
{ff 
vargg 
emailTemplategg !
=gg" #
newgg$ '%
VerificationEmailTemplategg( A
(ggA B
userProfileggB M
.ggM N
UsernameggN V
,ggV W
verificationCodeggX h
)ggh i
;ggi j
awaithh 
_emailServicehh #
.hh# $
SendEmailAsynchh$ 2
(hh2 3
userProfilehh3 >
.hh> ?
Emailhh? D
,hhD E
userProfilehhF Q
.hhQ R
UsernamehhR Z
,hhZ [
emailTemplatehh\ i
)hhi j
;hhj k
}ii 
catchjj 
(jj 
	Exceptionjj 
exjj 
)jj  
{kk 
Consolell 
.ll 
	WriteLinell !
(ll! "
$"ll" $
$strll$ B
{llB C
exllC E
.llE F
MessagellF M
}llM N
"llN O
)llO P
;llP Q
throwmm 
newmm 
	Exceptionmm #
(mm# $
$strmm$ u
)mmu v
;mmv w
}nn 
varpp 
	newPlayerpp 
=pp 
newpp 
Playerpp  &
{qq 
usernamerr 
=rr 
userProfilerr &
.rr& '
Usernamerr' /
,rr/ 0
emailss 
=ss 
userProfiless #
.ss# $
Emailss$ )
,ss) *
passwordtt 
=tt 
PasswordHashertt )
.tt) *
HashPasswordtt* 6
(tt6 7
passwordtt7 ?
)tt? @
,tt@ A
nameuu 
=uu 
userProfileuu "
.uu" #
	FirstNameuu# ,
,uu, -
lastNamevv 
=vv 
userProfilevv &
.vv& '
LastNamevv' /
,vv/ 0
Gender_idGenderww 
=ww  !
userProfileww" -
.ww- .
GenderIdww. 6
,ww6 7
Avatar_idAvatarxx 
=xx  !
userProfilexx" -
.xx- .
AvatarIdxx. 6
>xx7 8
$numxx9 :
?xx; <
userProfilexx= H
.xxH I
AvatarIdxxI Q
:xxR S
$numxxT U
,xxU V#
UserStatus_idUserStatusyy '
=yy( )
StatusOfflineyy* 7
,yy7 8
is_verifiedzz 
=zz 
(zz 
bytezz #
)zz# $
$numzz$ %
,zz% &
verification_code{{ !
={{" #
verificationCode{{$ 4
,{{4 5
code_expiry_date||  
=||! "
DateTime||# +
.||+ ,
UtcNow||, 2
.||2 3

AddMinutes||3 =
(||= >
$num||> @
)||@ A
}}} 
;}} 
_context 
. 
Player 
. 
Add 
(  
	newPlayer  )
)) *
;* +
try
ÄÄ 
{
ÅÅ 
await
ÇÇ 
_context
ÇÇ 
.
ÇÇ 
SaveChangesAsync
ÇÇ /
(
ÇÇ/ 0
)
ÇÇ0 1
;
ÇÇ1 2
}
ÉÉ 
catch
ÑÑ 
(
ÑÑ 
DbUpdateException
ÑÑ $
dbEx
ÑÑ% )
)
ÑÑ) *
{
ÖÖ 
Console
ÜÜ 
.
ÜÜ 
	WriteLine
ÜÜ !
(
ÜÜ! "
$"
ÜÜ" $
$str
ÜÜ$ <
{
ÜÜ< =
dbEx
ÜÜ= A
.
ÜÜA B
InnerException
ÜÜB P
?
ÜÜP Q
.
ÜÜQ R
Message
ÜÜR Y
??
ÜÜZ \
dbEx
ÜÜ] a
.
ÜÜa b
Message
ÜÜb i
}
ÜÜi j
"
ÜÜj k
)
ÜÜk l
;
ÜÜl m
throw
áá 
new
áá 
	Exception
áá #
(
áá# $
$str
áá$ e
)
ááe f
;
ááf g
}
àà 
return
ää 
new
ää  
OperationResultDto
ää )
{
ää* +
Success
ää, 3
=
ää4 5
true
ää6 :
,
ää: ;
Message
ää< C
=
ääD E
$strääF é
}ääè ê
;ääê ë
}
ãã 	
public
çç 
async
çç 
Task
çç 
<
çç  
OperationResultDto
çç ,
>
çç, - 
VerifyAccountAsync
çç. @
(
çç@ A
string
ççA G
email
ççH M
,
ççM N
string
ççO U
code
ççV Z
)
ççZ [
{
éé 	
if
èè 
(
èè 
string
èè 
.
èè  
IsNullOrWhiteSpace
èè )
(
èè) *
email
èè* /
)
èè/ 0
||
èè1 3
string
èè4 :
.
èè: ; 
IsNullOrWhiteSpace
èè; M
(
èèM N
code
èèN R
)
èèR S
)
èèS T
{
êê 
throw
ëë 
new
ëë 
	Exception
ëë #
(
ëë# $
$str
ëë$ M
)
ëëM N
;
ëëN O
}
íí 
var
ïï 
playerToVerify
ïï 
=
ïï  
await
ïï! &
_context
ïï' /
.
ïï/ 0
Player
ïï0 6
.
ïï6 7!
FirstOrDefaultAsync
ïï7 J
(
ïïJ K
p
ïïK L
=>
ïïM O
p
ïïP Q
.
ïïQ R
email
ïïR W
==
ïïX Z
email
ïï[ `
)
ïï` a
;
ïïa b
if
óó 
(
óó 
playerToVerify
óó 
==
óó !
null
óó" &
)
óó& '
{
òò 
throw
ôô 
new
ôô 
	Exception
ôô #
(
ôô# $
$str
ôô$ Q
)
ôôQ R
;
ôôR S
}
öö 
if
úú 
(
úú 
playerToVerify
úú 
.
úú 
is_verified
úú *
==
úú+ -
(
úú. /
byte
úú/ 3
)
úú3 4
$num
úú4 5
)
úú5 6
{
ùù 
throw
ûû 
new
ûû 
	Exception
ûû #
(
ûû# $
$str
ûû$ E
)
ûûE F
;
ûûF G
}
üü 
if
°° 
(
°° 
playerToVerify
°° 
.
°° 
verification_code
°° 0
!=
°°1 3
code
°°4 8
||
°°9 ;
playerToVerify
°°< J
.
°°J K
code_expiry_date
°°K [
<
°°\ ]
DateTime
°°^ f
.
°°f g
UtcNow
°°g m
)
°°m n
{
¢¢ 
throw
££ 
new
££ 
	Exception
££ #
(
££# $
$str
££$ Q
)
££Q R
;
££R S
}
§§ 
playerToVerify
¶¶ 
.
¶¶ 
is_verified
¶¶ &
=
¶¶' (
(
¶¶) *
byte
¶¶* .
)
¶¶. /
$num
¶¶/ 0
;
¶¶0 1
playerToVerify
ßß 
.
ßß 
verification_code
ßß ,
=
ßß- .
null
ßß/ 3
;
ßß3 4
playerToVerify
®® 
.
®® 
code_expiry_date
®® +
=
®®, -
null
®®. 2
;
®®2 3
playerToVerify
©© 
.
©© %
UserStatus_idUserStatus
©© 2
=
©©3 4
$num
©©5 6
;
©©6 7
await
´´ 
_context
´´ 
.
´´ 
SaveChangesAsync
´´ +
(
´´+ ,
)
´´, -
;
´´- .
return
≠≠ 
new
≠≠  
OperationResultDto
≠≠ )
{
≠≠* +
Success
≠≠, 3
=
≠≠4 5
true
≠≠6 :
,
≠≠: ;
Message
≠≠< C
=
≠≠D E
$str
≠≠F q
}
≠≠r s
;
≠≠s t
}
ÆÆ 	
public
∞∞ 
void
∞∞ 
LogOut
∞∞ 
(
∞∞ 
string
∞∞ !
username
∞∞" *
)
∞∞* +
{
±± 	
const
≤≤ 
int
≤≤ 
StatusOffline
≤≤ #
=
≤≤$ %
$num
≤≤& '
;
≤≤' (
var
µµ 
player
µµ 
=
µµ 
_context
µµ !
.
µµ! "
Player
µµ" (
.
µµ( )
FirstOrDefault
µµ) 7
(
µµ7 8
p
µµ8 9
=>
µµ: <
p
µµ= >
.
µµ> ?
username
µµ? G
==
µµH J
username
µµK S
)
µµS T
;
µµT U
if
∂∂ 
(
∂∂ 
player
∂∂ 
!=
∂∂ 
null
∂∂ 
)
∂∂ 
{
∑∑ 
player
∏∏ 
.
∏∏ %
UserStatus_idUserStatus
∏∏ .
=
∏∏/ 0
StatusOffline
∏∏1 >
;
∏∏> ?
_context
ππ 
.
ππ 
SaveChanges
ππ $
(
ππ$ %
)
ππ% &
;
ππ& '
}
∫∫ 
}
ªª 	
}
ºº 
}ΩΩ 