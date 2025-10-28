�S
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Services\UserProfileService.cs
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
verificationCode	ppu �
)
pp� �
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
�� 	
public
�� 
async
�� 
Task
�� 
<
�� 
List
�� 
<
�� 
	AvatarDto
�� (
>
��( )
>
��) *&
GetAvailableAvatarsAsync
��+ C
(
��C D
)
��D E
{
�� 	
try
�� 
{
�� 
using
�� 
(
�� 
var
�� 
context
�� "
=
��# $
new
��% (#
GuessMyMessDBEntities
��) >
(
��> ?
)
��? @
)
��@ A
{
�� 
var
�� 
emailService
�� $
=
��% &
new
��' *
SmtpEmailService
��+ ;
(
��; <
)
��< =
;
��= >
var
�� 
logic
�� 
=
�� 
new
��  #
UserProfileLogic
��$ 4
(
��4 5
emailService
��5 A
,
��A B
context
��C J
)
��J K
;
��K L
return
�� 
await
��  
logic
��! &
.
��& '&
GetAvailableAvatarsAsync
��' ?
(
��? @
)
��@ A
;
��A B
}
�� 
}
�� 
catch
�� 
(
�� 
	Exception
�� 
ex
�� 
)
��  
{
�� 
throw
�� 
new
�� 
FaultException
�� (
(
��( )
ex
��) +
.
��+ ,
Message
��, 3
)
��3 4
;
��4 5
}
�� 
}
�� 	
}
�� 
}�� �'
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Utilities\Email\SmtpEmailService.cs
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
$str	4 �
)
� �
;
� �
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
}99 �
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Services\GameService.cs
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
})) �
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Utilities\InputValidator.cs
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
$num	} �
)
� �
)
� �
;
� �
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
}33 �	
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Utilities\Email\Templates\PasswordChangeVerificationEmailTemplate.cs
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
}## �
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Utilities\Email\IEmailService.cs
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
} �
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Utilities\Email\IEmailTemplate.cs
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
} �
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
} �9
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Services\AuthenticationService.cs
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
NotImplementedException	bbj �
(
bb� �
)
bb� �
;
bb� �
}
bb� �
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
NotImplementedException	dd~ �
(
dd� �
)
dd� �
;
dd� �
}
dd� �
}ee 
}ff �	
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Utilities\PasswordHasher.cs
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
} ��
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Services\SocialService.cs
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
ISocialServiceCallback	u �
>
� �
(
� �
)
� �
;
� �
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
$str	77v �
"
77� �
)
77� �
;
77� �
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
$str	<<p �
"
<<� �
)
<<� �
;
<<� �
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
$str	AAp �
"
AA� �
)
AA� �
;
AA� �
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
;	FF �
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
Message	KKz �
}
KK� �
$str
KK� �
"
KK� �
)
KK� �
;
KK� �
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
�� 	
public
�� 
void
�� 

Disconnect
�� 
(
�� 
string
�� %
username
��& .
)
��. /
{
�� 	
if
�� 
(
�� 
string
�� 
.
�� 
IsNullOrEmpty
�� $
(
��$ %
username
��% -
)
��- .
)
��. /
{
�� 
return
�� 
;
�� 
}
�� 
lock
�� 
(
�� 
connectedClients
�� "
)
��" #
{
�� 
connectedClients
��  
.
��  !
Remove
��! '
(
��' (
username
��( 0
)
��0 1
;
��1 2
}
�� 
Task
�� 
.
�� 
Run
�� 
(
�� 
async
�� 
(
�� 
)
�� 
=>
��  
{
�� 
try
�� 
{
�� 
await
�� 
_socialLogic
�� &
.
��& '%
UpdatePlayerStatusAsync
��' >
(
��> ?
username
��? G
,
��G H
$str
��I R
)
��R S
;
��S T
await
�� &
NotifyFriendStatusUpdate
�� 2
(
��2 3
username
��3 ;
,
��; <
$str
��= F
)
��F G
;
��G H
}
�� 
catch
�� 
(
�� 
	Exception
��  
ex
��! #
)
��# $
{
�� 
Console
�� 
.
�� 
	WriteLine
�� %
(
��% &
$"
��& (
$str
��( R
{
��R S
ex
��S U
.
��U V
Message
��V ]
}
��] ^
"
��^ _
)
��_ `
;
��` a
}
�� 
}
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
async
�� 
Task
�� 
<
�� 
List
�� 
<
�� 
	FriendDto
�� (
>
��( )
>
��) *!
GetFriendsListAsync
��+ >
(
��> ?
string
��? E
username
��F N
)
��N O
{
�� 	
try
�� 
{
�� 
return
�� 
await
�� 
_socialLogic
�� )
.
��) *!
GetFriendsListAsync
��* =
(
��= >
username
��> F
)
��F G
;
��G H
}
�� 
catch
�� 
(
�� 
	Exception
�� 
ex
�� 
)
��  
{
�� 
throw
�� 
new
�� 
FaultException
�� (
(
��( )
$"
��) +
$str
��+ M
{
��M N
ex
��N P
.
��P Q
Message
��Q X
}
��X Y
"
��Y Z
)
��Z [
;
��[ \
}
�� 
}
�� 	
public
�� 
async
�� 
Task
�� 
<
�� 
List
�� 
<
�� "
FriendRequestInfoDto
�� 3
>
��3 4
>
��4 5$
GetFriendRequestsAsync
��6 L
(
��L M
string
��M S
username
��T \
)
��\ ]
{
�� 	
try
�� 
{
�� 
return
�� 
await
�� 
_socialLogic
�� )
.
��) *$
GetFriendRequestsAsync
��* @
(
��@ A
username
��A I
)
��I J
;
��J K
}
�� 
catch
�� 
(
�� 
	Exception
�� 
ex
�� 
)
��  
{
�� 
throw
�� 
new
�� 
FaultException
�� (
(
��( )
$"
��) +
$str
��+ T
{
��T U
ex
��U W
.
��W X
Message
��X _
}
��_ `
"
��` a
)
��a b
;
��b c
}
�� 
}
�� 	
public
�� 
async
�� 
Task
�� 
<
�� 
List
�� 
<
�� 
UserProfileDto
�� -
>
��- .
>
��. /
SearchUsersAsync
��0 @
(
��@ A
string
��A G
searchUsername
��H V
,
��V W
string
��X ^
requesterUsername
��_ p
)
��p q
{
�� 	
try
�� 
{
�� 
return
�� 
await
�� 
_socialLogic
�� )
.
��) *
SearchUsersAsync
��* :
(
��: ;
searchUsername
��; I
,
��I J
requesterUsername
��K \
)
��\ ]
;
��] ^
}
�� 
catch
�� 
(
�� 
	Exception
�� 
ex
�� 
)
��  
{
�� 
throw
�� 
new
�� 
FaultException
�� (
(
��( )
$"
��) +
$str
��+ E
{
��E F
ex
��F H
.
��H I
Message
��I P
}
��P Q
"
��Q R
)
��R S
;
��S T
}
�� 
}
�� 	
public
�� 
async
�� 
void
�� 
SendFriendRequest
�� +
(
��+ ,
string
��, 2
requesterUsername
��3 D
,
��D E
string
��F L
targetUsername
��M [
)
��[ \
{
�� 	
try
�� 
{
�� 
await
�� 
_socialLogic
�� "
.
��" #$
SendFriendRequestAsync
��# 9
(
��9 :
requesterUsername
��: K
,
��K L
targetUsername
��M [
)
��[ \
;
��\ ]$
ISocialServiceCallback
�� &
callback
��' /
;
��/ 0
lock
�� 
(
�� 
connectedClients
�� &
)
��& '
{
�� 
connectedClients
�� $
.
��$ %
TryGetValue
��% 0
(
��0 1
targetUsername
��1 ?
,
��? @
out
��A D
callback
��E M
)
��M N
;
��N O
}
�� 
callback
�� 
?
�� 
.
�� !
NotifyFriendRequest
�� -
(
��- .
requesterUsername
��. ?
)
��? @
;
��@ A
}
�� 
catch
�� 
(
�� 
	Exception
�� 
ex
�� 
)
��  
{
�� 
Console
�� 
.
�� 
	WriteLine
�� !
(
��! "
$"
��" $
$str
��$ @
{
��@ A
ex
��A C
.
��C D
Message
��D K
}
��K L
"
��L M
)
��M N
;
��N O
}
�� 
}
�� 	
public
�� 
async
�� 
void
�� $
RespondToFriendRequest
�� 0
(
��0 1
string
��1 7
targetUsername
��8 F
,
��F G
string
��H N
requesterUsername
��O `
,
��` a
bool
��b f
accepted
��g o
)
��o p
{
�� 	
try
�� 
{
�� 
await
�� 
_socialLogic
�� "
.
��" #)
RespondToFriendRequestAsync
��# >
(
��> ?
targetUsername
��? M
,
��M N
requesterUsername
��O `
,
��` a
accepted
��b j
)
��j k
;
��k l$
ISocialServiceCallback
�� &
requesterCallback
��' 8
;
��8 9
lock
�� 
(
�� 
connectedClients
�� &
)
��& '
{
�� 
connectedClients
�� $
.
��$ %
TryGetValue
��% 0
(
��0 1
requesterUsername
��1 B
,
��B C
out
��D G
requesterCallback
��H Y
)
��Y Z
;
��Z [
}
�� 
requesterCallback
�� !
?
��! "
.
��" #"
NotifyFriendResponse
��# 7
(
��7 8
targetUsername
��8 F
,
��F G
accepted
��H P
)
��P Q
;
��Q R
if
�� 
(
�� 
accepted
�� 
)
�� 
{
�� 
bool
�� 
requesterIsOnline
�� *
;
��* +
bool
�� 
targetIsOnline
�� '
;
��' ($
ISocialServiceCallback
�� *
targetCallback
��+ 9
;
��9 :
lock
�� 
(
�� 
connectedClients
�� *
)
��* +
{
�� 
requesterIsOnline
�� )
=
��* +
connectedClients
��, <
.
��< =
ContainsKey
��= H
(
��H I
requesterUsername
��I Z
)
��Z [
;
��[ \
targetIsOnline
�� &
=
��' (
connectedClients
��) 9
.
��9 :
TryGetValue
��: E
(
��E F
targetUsername
��F T
,
��T U
out
��V Y
targetCallback
��Z h
)
��h i
;
��i j
}
�� 
requesterCallback
�� %
?
��% &
.
��& ''
NotifyFriendStatusChanged
��' @
(
��@ A
targetUsername
��A O
,
��O P
targetIsOnline
��Q _
?
��` a
$str
��b j
:
��k l
$str
��m v
)
��v w
;
��w x
targetCallback
�� "
?
��" #
.
��# $'
NotifyFriendStatusChanged
��$ =
(
��= >
requesterUsername
��> O
,
��O P
requesterIsOnline
��Q b
?
��c d
$str
��e m
:
��n o
$str
��p y
)
��y z
;
��z {
}
�� 
}
�� 
catch
�� 
(
�� 
	Exception
�� 
ex
�� 
)
��  
{
�� 
Console
�� 
.
�� 
	WriteLine
�� !
(
��! "
$"
��" $
$str
��$ E
{
��E F
ex
��F H
.
��H I
Message
��I P
}
��P Q
"
��Q R
)
��R S
;
��S T
}
�� 
}
�� 	
public
�� 
async
�� 
void
�� 
RemoveFriend
�� &
(
��& '
string
��' -
username
��. 6
,
��6 7
string
��8 >
friendToRemove
��? M
)
��M N
{
�� 	
try
�� 
{
�� 
await
�� 
_socialLogic
�� "
.
��" #
RemoveFriendAsync
��# 4
(
��4 5
username
��5 =
,
��= >
friendToRemove
��? M
)
��M N
;
��N O
}
�� 
catch
�� 
(
�� 
	Exception
�� 
ex
�� 
)
��  
{
�� 
Console
�� 
.
�� 
	WriteLine
�� !
(
��! "
$"
��" $
$str
��$ ;
{
��; <
ex
��< >
.
��> ?
Message
��? F
}
��F G
"
��G H
)
��H I
;
��I J
}
�� 
}
�� 	
public
�� 
async
�� 
void
�� 
SendDirectMessage
�� +
(
��+ ,
DirectMessageDto
��, <
message
��= D
)
��D E
{
�� 	
if
�� 
(
�� 
message
�� 
==
�� 
null
�� 
||
��  "
string
��# )
.
��) *
IsNullOrEmpty
��* 7
(
��7 8
message
��8 ?
.
��? @
RecipientUsername
��@ Q
)
��Q R
)
��R S
{
�� 
Console
�� 
.
�� 
	WriteLine
�� !
(
��! "
$str
��" D
)
��D E
;
��E F
return
�� 
;
�� 
}
�� 
try
�� 
{
�� 
await
�� 
_socialLogic
�� "
.
��" #$
SendDirectMessageAsync
��# 9
(
��9 :
message
��: A
)
��A B
;
��B C$
ISocialServiceCallback
�� &
callback
��' /
;
��/ 0
lock
�� 
(
�� 
connectedClients
�� &
)
��& '
{
�� 
connectedClients
�� $
.
��$ %
TryGetValue
��% 0
(
��0 1
message
��1 8
.
��8 9
RecipientUsername
��9 J
,
��J K
out
��L O
callback
��P X
)
��X Y
;
��Y Z
}
�� 
callback
�� 
?
�� 
.
�� #
NotifyMessageReceived
�� /
(
��/ 0
message
��0 7
)
��7 8
;
��8 9
}
�� 
catch
�� 
(
�� 
	Exception
�� 
ex
�� 
)
��  
{
�� 
Console
�� 
.
�� 
	WriteLine
�� !
(
��! "
$"
��" $
$str
��$ @
{
��@ A
ex
��A C
.
��C D
Message
��D K
}
��K L
"
��L M
)
��M N
;
��N O
}
�� 
}
�� 	
public
�� 
async
�� 
Task
�� 
<
�� 
List
�� 
<
�� 
	FriendDto
�� (
>
��( )
>
��) *#
GetConversationsAsync
��+ @
(
��@ A
string
��A G
username
��H P
)
��P Q
{
�� 	
try
�� 
{
�� 
return
�� 
await
�� 
_socialLogic
�� )
.
��) *#
GetConversationsAsync
��* ?
(
��? @
username
��@ H
)
��H I
;
��I J
}
�� 
catch
�� 
(
�� 
	Exception
�� 
ex
�� 
)
��  
{
�� 
throw
�� 
new
�� 
FaultException
�� (
(
��( )
$"
��) +
$str
��+ L
{
��L M
ex
��M O
.
��O P
Message
��P W
}
��W X
"
��X Y
)
��Y Z
;
��Z [
}
�� 
}
�� 	
public
�� 
async
�� 
Task
�� 
<
�� 
List
�� 
<
�� 
DirectMessageDto
�� /
>
��/ 0
>
��0 1)
GetConversationHistoryAsync
��2 M
(
��M N
string
��N T
user1
��U Z
,
��Z [
string
��\ b
user2
��c h
)
��h i
{
�� 	
try
�� 
{
�� 
return
�� 
await
�� 
_socialLogic
�� )
.
��) *)
GetConversationHistoryAsync
��* E
(
��E F
user1
��F K
,
��K L
user2
��M R
)
��R S
;
��S T
}
�� 
catch
�� 
(
�� 
	Exception
�� 
ex
�� 
)
��  
{
�� 
throw
�� 
new
�� 
FaultException
�� (
(
��( )
$"
��) +
$str
��+ W
{
��W X
ex
��X Z
.
��Z [
Message
��[ b
}
��b c
"
��c d
)
��d e
;
��e f
}
�� 
}
�� 	
public
�� 
Task
�� 
<
��  
OperationResultDto
�� &
>
��& ',
InviteFriendToGameByEmailAsync
��( F
(
��F G
string
��G M
fromUsername
��N Z
,
��Z [
string
��\ b
friendEmail
��c n
,
��n o
string
��p v
	matchCode��w �
)��� �
{
�� 	
Console
�� 
.
�� 
	WriteLine
�� 
(
�� 
$str
�� a
)
��a b
;
��b c
throw
�� 
new
�� %
NotImplementedException
�� -
(
��- .
$str
��. v
)
��v w
;
��w x
}
�� 	
}
�� 
}�� �	
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Utilities\Email\Templates\VerificationEmailTemplate.cs
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
} �	
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Utilities\Email\Templates\EmailChangeVerificationEmailTemplate.cs
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
}## �
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Properties\AssemblyInfo.cs
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
]$$) *�
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Services\LobbyService.cs
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
}88 �
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Services\MatchmakingService.cs
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
}// �
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
}-- �
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\ServiceContracts\IUserProfileService.cs
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
}** �6
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\ServiceContracts\ISocialService.cs
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
}EE �
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\ServiceContracts\IMatchmakingService.cs
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
}-- �)
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\ServiceContracts\ILobbyService.cs
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
}99 �%
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\ServiceContracts\IGameService.cs
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
}33 �
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\ServiceContracts\IAuthenticationService.cs
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
}## �
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\UserProfileDto.cs
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
} �
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\SocialNetworkDto.cs
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
} �
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\FriendDto.cs
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
} �

�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\LobbyStateDto.cs
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
} �
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\OperationResultDto.cs
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
} �
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\PlayerScoreDto.cs
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
} �
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\FriendRequestInfoDto.cs
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
} �
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\MatchInfoDto.cs
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
} �
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\AvatarDto.cs
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
} �

�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\ChatMessageDto.cs
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
} �
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\LobbySettingsDto.cs
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
} �

�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\Contracts\DataContracts\DirectMessageDto.cs
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
} ��
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\BusinessLogic\UserProfileLogic.cs
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
aa� �
:
aa� �
$num
aa� �
,
aa� �
useAsync
aa� �
:
aa� �
true
aa� �
)
aa� �
)
aa� �
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
�� 	
var
�� 
player
�� 
=
�� 
await
�� 
_context
�� '
.
��' (
Player
��( .
.
��. /!
FirstOrDefaultAsync
��/ B
(
��B C
p
��C D
=>
��E G
p
��H I
.
��I J
username
��J R
==
��S U
username
��V ^
)
��^ _
;
��_ `
if
�� 
(
�� 
player
�� 
==
�� 
null
�� 
)
�� 
{
�� 
throw
�� 
new
�� 
	Exception
�� #
(
��# $
$str
��$ <
)
��< =
;
��= >
}
�� 
string
�� 
code
�� 
=
�� 
GenerateCode
�� &
(
��& '
)
��' (
;
��( )
player
�� 
.
�� 
	temp_code
�� 
=
�� 
code
�� #
;
��# $
player
�� 
.
�� 
temp_code_expiry
�� #
=
��$ %
DateTime
��& .
.
��. /
UtcNow
��/ 5
.
��5 6

AddMinutes
��6 @
(
��@ A
$num
��A C
)
��C D
;
��D E
await
�� 
_context
�� 
.
�� 
SaveChangesAsync
�� +
(
��+ ,
)
��, -
;
��- .
var
�� 
emailTemplate
�� 
=
�� 
new
��  #5
'PasswordChangeVerificationEmailTemplate
��$ K
(
��K L
player
��L R
.
��R S
username
��S [
,
��[ \
code
��] a
)
��a b
;
��b c
await
�� 
_emailService
�� 
.
��  
SendEmailAsync
��  .
(
��. /
player
��/ 5
.
��5 6
email
��6 ;
,
��; <
player
��= C
.
��C D
username
��D L
,
��L M
emailTemplate
��N [
)
��[ \
;
��\ ]
return
�� 
new
��  
OperationResultDto
�� )
{
��* +
Success
��, 3
=
��4 5
true
��6 :
,
��: ;
Message
��< C
=
��D E
$str��F �
}��� �
;��� �
}
�� 	
public
�� 
async
�� 
Task
�� 
<
��  
OperationResultDto
�� ,
>
��, -%
RequestChangeEmailAsync
��. E
(
��E F
string
��F L
username
��M U
,
��U V
string
��W ]
newEmail
��^ f
)
��f g
{
�� 	
if
�� 
(
�� 
string
�� 
.
��  
IsNullOrWhiteSpace
�� )
(
��) *
newEmail
��* 2
)
��2 3
||
��4 6
!
��7 8
InputValidator
��8 F
.
��F G
IsValidEmail
��G S
(
��S T
newEmail
��T \
)
��\ ]
)
��] ^
{
�� 
throw
�� 
new
�� 
	Exception
�� #
(
��# $
$str
��$ S
)
��S T
;
��T U
}
�� 
var
�� 
player
�� 
=
�� 
await
�� 
_context
�� '
.
��' (
Player
��( .
.
��. /!
FirstOrDefaultAsync
��/ B
(
��B C
p
��C D
=>
��E G
p
��H I
.
��I J
username
��J R
==
��S U
username
��V ^
)
��^ _
;
��_ `
if
�� 
(
�� 
player
�� 
==
�� 
null
�� 
)
�� 
{
�� 
throw
�� 
new
�� 
	Exception
�� #
(
��# $
$str
��$ <
)
��< =
;
��= >
}
�� 
if
�� 
(
�� 
await
�� 
_context
�� 
.
�� 
Player
�� %
.
��% &
AnyAsync
��& .
(
��. /
p
��/ 0
=>
��1 3
p
��4 5
.
��5 6
email
��6 ;
==
��< >
newEmail
��? G
)
��G H
)
��H I
{
�� 
throw
�� 
new
�� 
	Exception
�� #
(
��# $
$str
��$ I
)
��I J
;
��J K
}
�� 
string
�� 
code
�� 
=
�� 
GenerateCode
�� &
(
��& '
)
��' (
;
��( )
player
�� 
.
�� 
	temp_code
�� 
=
�� 
code
�� #
;
��# $
player
�� 
.
�� 
temp_code_expiry
�� #
=
��$ %
DateTime
��& .
.
��. /
UtcNow
��/ 5
.
��5 6

AddMinutes
��6 @
(
��@ A
$num
��A C
)
��C D
;
��D E
player
�� 
.
�� 
new_email_pending
�� $
=
��% &
newEmail
��' /
;
��/ 0
await
�� 
_context
�� 
.
�� 
SaveChangesAsync
�� +
(
��+ ,
)
��, -
;
��- .
var
�� 
emailTemplate
�� 
=
�� 
new
��  #2
$EmailChangeVerificationEmailTemplate
��$ H
(
��H I
player
��I O
.
��O P
username
��P X
,
��X Y
code
��Z ^
)
��^ _
;
��_ `
await
�� 
_emailService
�� 
.
��  
SendEmailAsync
��  .
(
��. /
player
��/ 5
.
��5 6
email
��6 ;
,
��; <
player
��= C
.
��C D
username
��D L
,
��L M
emailTemplate
��N [
)
��[ \
;
��\ ]
return
�� 
new
��  
OperationResultDto
�� )
{
��* +
Success
��, 3
=
��4 5
true
��6 :
,
��: ;
Message
��< C
=
��D E
$"
��F H
$str
��H t
{
��t u
player
��u {
.
��{ |
email��| �
}��� �
$str��� �
"��� �
}��� �
;��� �
}
�� 	
public
�� 
async
�� 
Task
�� 
<
��  
OperationResultDto
�� ,
>
��, -(
ConfirmChangePasswordAsync
��. H
(
��H I
string
��I O
username
��P X
,
��X Y
string
��Z `
newPassword
��a l
,
��l m
string
��n t
verificationCode��u �
)��� �
{
�� 	
if
�� 
(
�� 
!
�� 
InputValidator
�� 
.
��  
IsPasswordSecure
��  0
(
��0 1
newPassword
��1 <
)
��< =
)
��= >
{
�� 
throw
�� 
new
�� 
	Exception
�� #
(
��# $
$str
��$ d
)
��d e
;
��e f
}
�� 
var
�� 
player
�� 
=
�� 
await
�� 
_context
�� '
.
��' (
Player
��( .
.
��. /!
FirstOrDefaultAsync
��/ B
(
��B C
p
��C D
=>
��E G
p
��H I
.
��I J
username
��J R
==
��S U
username
��V ^
)
��^ _
;
��_ `
if
�� 
(
�� 
player
�� 
==
�� 
null
�� 
)
�� 
{
�� 
throw
�� 
new
�� 
	Exception
�� #
(
��# $
$str
��$ <
)
��< =
;
��= >
}
�� 
if
�� 
(
�� 
player
�� 
.
�� 
	temp_code
��  
!=
��! #
verificationCode
��$ 4
||
��5 7
player
��8 >
.
��> ?
temp_code_expiry
��? O
<
��P Q
DateTime
��R Z
.
��Z [
UtcNow
��[ a
)
��a b
{
�� 
throw
�� 
new
�� 
	Exception
�� #
(
��# $
$str
��$ Q
)
��Q R
;
��R S
}
�� 
player
�� 
.
�� 
password
�� 
=
�� 
PasswordHasher
�� ,
.
��, -
HashPassword
��- 9
(
��9 :
newPassword
��: E
)
��E F
;
��F G
player
�� 
.
�� 
	temp_code
�� 
=
�� 
null
�� #
;
��# $
player
�� 
.
�� 
temp_code_expiry
�� #
=
��$ %
null
��& *
;
��* +
await
�� 
_context
�� 
.
�� 
SaveChangesAsync
�� +
(
��+ ,
)
��, -
;
��- .
return
�� 
new
��  
OperationResultDto
�� )
{
��* +
Success
��, 3
=
��4 5
true
��6 :
,
��: ;
Message
��< C
=
��D E
$str
��F i
}
��j k
;
��k l
}
�� 	
public
�� 
async
�� 
Task
�� 
<
��  
OperationResultDto
�� ,
>
��, -%
ConfirmChangeEmailAsync
��. E
(
��E F
string
��F L
username
��M U
,
��U V
string
��W ]
verificationCode
��^ n
)
��n o
{
�� 	
var
�� 
player
�� 
=
�� 
await
�� 
_context
�� '
.
��' (
Player
��( .
.
��. /!
FirstOrDefaultAsync
��/ B
(
��B C
p
��C D
=>
��E G
p
��H I
.
��I J
username
��J R
==
��S U
username
��V ^
)
��^ _
;
��_ `
if
�� 
(
�� 
player
�� 
==
�� 
null
�� 
)
�� 
{
�� 
throw
�� 
new
�� 
	Exception
�� #
(
��# $
$str
��$ <
)
��< =
;
��= >
}
�� 
if
�� 
(
�� 
string
�� 
.
�� 
IsNullOrEmpty
�� $
(
��$ %
player
��% +
.
��+ ,
new_email_pending
��, =
)
��= >
)
��> ?
{
�� 
throw
�� 
new
�� 
	Exception
�� #
(
��# $
$str
��$ J
)
��J K
;
��K L
}
�� 
if
�� 
(
�� 
player
�� 
.
�� 
	temp_code
��  
!=
��! #
verificationCode
��$ 4
||
��5 7
player
��8 >
.
��> ?
temp_code_expiry
��? O
<
��P Q
DateTime
��R Z
.
��Z [
UtcNow
��[ a
)
��a b
{
�� 
throw
�� 
new
�� 
	Exception
�� #
(
��# $
$str
��$ Q
)
��Q R
;
��R S
}
�� 
if
�� 
(
�� 
await
�� 
_context
�� 
.
�� 
Player
�� %
.
��% &
AnyAsync
��& .
(
��. /
p
��/ 0
=>
��1 3
p
��4 5
.
��5 6
email
��6 ;
==
��< >
player
��? E
.
��E F
new_email_pending
��F W
&&
��X Z
p
��[ \
.
��\ ]
idPlayer
��] e
!=
��f h
player
��i o
.
��o p
idPlayer
��p x
)
��x y
)
��y z
{
�� 
player
�� 
.
�� 
	temp_code
��  
=
��! "
null
��# '
;
��' (
player
�� 
.
�� 
temp_code_expiry
�� '
=
��( )
null
��* .
;
��. /
player
�� 
.
�� 
new_email_pending
�� (
=
��) *
null
��+ /
;
��/ 0
await
�� 
_context
�� 
.
�� 
SaveChangesAsync
�� /
(
��/ 0
)
��0 1
;
��1 2
throw
�� 
new
�� 
	Exception
�� #
(
��# $
$str
��$ e
)
��e f
;
��f g
}
�� 
player
�� 
.
�� 
email
�� 
=
�� 
player
�� !
.
��! "
new_email_pending
��" 3
;
��3 4
player
�� 
.
�� 
	temp_code
�� 
=
�� 
null
�� #
;
��# $
player
�� 
.
�� 
temp_code_expiry
�� #
=
��$ %
null
��& *
;
��* +
player
�� 
.
�� 
new_email_pending
�� $
=
��% &
null
��' +
;
��+ ,
await
�� 
_context
�� 
.
�� 
SaveChangesAsync
�� +
(
��+ ,
)
��, -
;
��- .
return
�� 
new
��  
OperationResultDto
�� )
{
��* +
Success
��, 3
=
��4 5
true
��6 :
,
��: ;
Message
��< C
=
��D E
$str
��F d
}
��e f
;
��f g
}
�� 	
}
�� 
}�� ٙ
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\BusinessLogic\SocialLogic.cs
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
�� 
const
�� 
string
�� 
PendingStatus
�� *
=
��+ ,
$str
��- 6
;
��6 7
var
�� !
pendingStatusEntity
�� '
=
��( )
await
��* /
context
��0 7
.
��7 8
FriendShipStatus
��8 H
.
��H I!
FirstOrDefaultAsync
��I \
(
��\ ]
fs
��] _
=>
��` b
fs
��c e
.
��e f
status
��f l
==
��m o
PendingStatus
��p }
)
��} ~
;
��~ 
if
�� 
(
�� !
pendingStatusEntity
�� '
==
��( *
null
��+ /
)
��/ 0
{
�� 
throw
�� 
new
�� 
	Exception
�� '
(
��' (
$str
��( d
)
��d e
;
��e f
}
�� 
var
�� 

friendship
�� 
=
��  
new
��! $

Friendship
��% /
{
�� 
Player_idPlayer1
�� $
=
��% &
	requester
��' 0
.
��0 1
idPlayer
��1 9
,
��9 :
Player_idPlayer2
�� $
=
��% &
target
��' -
.
��- .
idPlayer
��. 6
,
��6 71
#FriendShipStatus_idFriendShipStatus
�� 7
=
��8 9!
pendingStatusEntity
��: M
.
��M N 
idFriendShipStatus
��N `
}
�� 
;
�� 
context
�� 
.
�� 

Friendship
�� "
.
��" #
Add
��# &
(
��& '

friendship
��' 1
)
��1 2
;
��2 3
await
�� 
context
�� 
.
�� 
SaveChangesAsync
�� .
(
��. /
)
��/ 0
;
��0 1
}
�� 
}
�� 	
public
�� 
async
�� 
Task
�� )
RespondToFriendRequestAsync
�� 5
(
��5 6
string
��6 <
targetUsername
��= K
,
��K L
string
��M S
requesterUsername
��T e
,
��e f
bool
��g k
accepted
��l t
)
��t u
{
�� 	
using
�� 
(
�� 
var
�� 
context
�� 
=
��  
new
��! $#
GuessMyMessDBEntities
��% :
(
��: ;
)
��; <
)
��< =
{
�� 
var
�� 
target
�� 
=
�� 
await
�� "
context
��# *
.
��* +
Player
��+ 1
.
��1 2!
FirstOrDefaultAsync
��2 E
(
��E F
p
��F G
=>
��H J
p
��K L
.
��L M
username
��M U
==
��V X
targetUsername
��Y g
)
��g h
;
��h i
var
�� 
	requester
�� 
=
�� 
await
��  %
context
��& -
.
��- .
Player
��. 4
.
��4 5!
FirstOrDefaultAsync
��5 H
(
��H I
p
��I J
=>
��K M
p
��N O
.
��O P
username
��P X
==
��Y [
requesterUsername
��\ m
)
��m n
;
��n o
if
�� 
(
�� 
target
�� 
==
�� 
null
�� "
||
��# %
	requester
��& /
==
��0 2
null
��3 7
)
��7 8
{
�� 
Console
�� 
.
�� 
	WriteLine
�� %
(
��% &
$str
��& \
)
��\ ]
;
��] ^
return
�� 
;
�� 
}
�� 
const
�� 
string
�� 
PendingStatus
�� *
=
��+ ,
$str
��- 6
;
��6 7
var
�� 

friendship
�� 
=
��  
await
��! &
context
��' .
.
��. /

Friendship
��/ 9
.
�� 
Include
�� 
(
�� 
f
�� 
=>
�� !
f
��" #
.
��# $
FriendShipStatus
��$ 4
)
��4 5
.
�� !
FirstOrDefaultAsync
�� (
(
��( )
f
��) *
=>
��+ -
f
��. /
.
��/ 0
Player_idPlayer1
��0 @
==
��A C
	requester
��D M
.
��M N
idPlayer
��N V
&&
��W Y
f
��. /
.
��/ 0
Player_idPlayer2
��0 @
==
��A C
target
��D J
.
��J K
idPlayer
��K S
&&
��T V
f
��. /
.
��/ 0
FriendShipStatus
��0 @
.
��@ A
status
��A G
==
��H J
PendingStatus
��K X
)
��X Y
;
��Y Z
if
�� 
(
�� 

friendship
�� 
==
�� !
null
��" &
)
��& '
{
�� 
throw
�� 
new
�� 
	Exception
�� '
(
��' (
$str
��( c
)
��c d
;
��d e
}
�� 
if
�� 
(
�� 
accepted
�� 
)
�� 
{
�� 
const
�� 
string
��  
AcceptedStatus
��! /
=
��0 1
$str
��2 <
;
��< =
var
�� "
acceptedStatusEntity
�� ,
=
��- .
await
��/ 4
context
��5 <
.
��< =
FriendShipStatus
��= M
.
��M N!
FirstOrDefaultAsync
��N a
(
��a b
fs
��b d
=>
��e g
fs
��h j
.
��j k
status
��k q
==
��r t
AcceptedStatus��u �
)��� �
;��� �
if
�� 
(
�� "
acceptedStatusEntity
�� ,
==
��- /
null
��0 4
)
��4 5
{
�� 
throw
�� 
new
�� !
	Exception
��" +
(
��+ ,
$str
��, i
)
��i j
;
��j k
}
�� 

friendship
�� 
.
�� 1
#FriendShipStatus_idFriendShipStatus
�� B
=
��C D"
acceptedStatusEntity
��E Y
.
��Y Z 
idFriendShipStatus
��Z l
;
��l m
}
�� 
else
�� 
{
�� 
context
�� 
.
�� 

Friendship
�� &
.
��& '
Remove
��' -
(
��- .

friendship
��. 8
)
��8 9
;
��9 :
}
�� 
await
�� 
context
�� 
.
�� 
SaveChangesAsync
�� .
(
��. /
)
��/ 0
;
��0 1
}
�� 
}
�� 	
public
�� 
async
�� 
Task
�� 
RemoveFriendAsync
�� +
(
��+ ,
string
��, 2
username
��3 ;
,
��; <
string
��= C
friendToRemove
��D R
)
��R S
{
�� 	
using
�� 
(
�� 
var
�� 
context
�� 
=
��  
new
��! $#
GuessMyMessDBEntities
��% :
(
��: ;
)
��; <
)
��< =
{
�� 
var
�� 
player
�� 
=
�� 
await
�� "
context
��# *
.
��* +
Player
��+ 1
.
��1 2!
FirstOrDefaultAsync
��2 E
(
��E F
p
��F G
=>
��H J
p
��K L
.
��L M
username
��M U
==
��V X
username
��Y a
)
��a b
;
��b c
var
�� 
friend
�� 
=
�� 
await
�� "
context
��# *
.
��* +
Player
��+ 1
.
��1 2!
FirstOrDefaultAsync
��2 E
(
��E F
p
��F G
=>
��H J
p
��K L
.
��L M
username
��M U
==
��V X
friendToRemove
��Y g
)
��g h
;
��h i
if
�� 
(
�� 
player
�� 
==
�� 
null
�� "
||
��# %
friend
��& ,
==
��- /
null
��0 4
)
��4 5
{
�� 
Console
�� 
.
�� 
	WriteLine
�� %
(
��% &
$str
��& W
)
��W X
;
��X Y
return
�� 
;
�� 
}
�� 
var
�� 

friendship
�� 
=
��  
await
��! &
context
��' .
.
��. /

Friendship
��/ 9
.
��9 :!
FirstOrDefaultAsync
��: M
(
��M N
f
��N O
=>
��P R
(
�� 
f
�� 
.
�� 
Player_idPlayer1
�� '
==
��( *
player
��+ 1
.
��1 2
idPlayer
��2 :
&&
��; =
f
��> ?
.
��? @
Player_idPlayer2
��@ P
==
��Q S
friend
��T Z
.
��Z [
idPlayer
��[ c
)
��c d
||
��e g
(
�� 
f
�� 
.
�� 
Player_idPlayer1
�� '
==
��( *
friend
��+ 1
.
��1 2
idPlayer
��2 :
&&
��; =
f
��> ?
.
��? @
Player_idPlayer2
��@ P
==
��Q S
player
��T Z
.
��Z [
idPlayer
��[ c
)
��c d
)
��d e
;
��e f
if
�� 
(
�� 

friendship
�� 
!=
�� !
null
��" &
)
��& '
{
�� 
context
�� 
.
�� 

Friendship
�� &
.
��& '
Remove
��' -
(
��- .

friendship
��. 8
)
��8 9
;
��9 :
await
�� 
context
�� !
.
��! "
SaveChangesAsync
��" 2
(
��2 3
)
��3 4
;
��4 5
}
�� 
else
�� 
{
�� 
Console
�� 
.
�� 
	WriteLine
�� %
(
��% &
$"
��& (
$str
��( V
{
��V W
username
��W _
}
��_ `
$str
��` c
{
��c d
friendToRemove
��d r
}
��r s
$str
��s t
"
��t u
)
��u v
;
��v w
}
�� 
}
�� 
}
�� 	
public
�� 
async
�� 
Task
�� %
UpdatePlayerStatusAsync
�� 1
(
��1 2
string
��2 8
username
��9 A
,
��A B
string
��C I
status
��J P
)
��P Q
{
�� 	
using
�� 
(
�� 
var
�� 
context
�� 
=
��  
new
��! $#
GuessMyMessDBEntities
��% :
(
��: ;
)
��; <
)
��< =
{
�� 
var
�� 
player
�� 
=
�� 
await
�� "
context
��# *
.
��* +
Player
��+ 1
.
��1 2!
FirstOrDefaultAsync
��2 E
(
��E F
p
��F G
=>
��H J
p
��K L
.
��L M
username
��M U
==
��V X
username
��Y a
)
��a b
;
��b c
if
�� 
(
�� 
player
�� 
==
�� 
null
�� "
)
��" #
{
�� 
throw
�� 
new
�� 
	Exception
�� '
(
��' (
$"
��( *
$str
��* 3
{
��3 4
username
��4 <
}
��< =
$str
��= d
"
��d e
)
��e f
;
��f g
}
�� 
var
�� 

userStatus
�� 
=
��  
await
��! &
context
��' .
.
��. /

UserStatus
��/ 9
.
��9 :!
FirstOrDefaultAsync
��: M
(
��M N
s
��N O
=>
��P R
s
��S T
.
��T U
status
��U [
==
��\ ^
status
��_ e
)
��e f
;
��f g
if
�� 
(
�� 

userStatus
�� 
==
�� !
null
��" &
)
��& '
{
�� 
throw
�� 
new
�� 
	Exception
�� '
(
��' (
$"
��( *
$str
��* =
{
��= >
status
��> D
}
��D E
$str
��E T
"
��T U
)
��U V
;
��V W
}
�� 
if
�� 
(
�� 
player
�� 
.
�� %
UserStatus_idUserStatus
�� 2
!=
��3 5

userStatus
��6 @
.
��@ A
idUserStatus
��A M
)
��M N
{
�� 
player
�� 
.
�� %
UserStatus_idUserStatus
�� 2
=
��3 4

userStatus
��5 ?
.
��? @
idUserStatus
��@ L
;
��L M
await
�� 
context
�� !
.
��! "
SaveChangesAsync
��" 2
(
��2 3
)
��3 4
;
��4 5
}
�� 
}
�� 
}
�� 	
public
�� 
async
�� 
Task
�� $
SendDirectMessageAsync
�� 0
(
��0 1
DirectMessageDto
��1 A
message
��B I
)
��I J
{
�� 	
if
�� 
(
�� 
message
�� 
==
�� 
null
�� 
||
��  "
string
��# )
.
��) * 
IsNullOrWhiteSpace
��* <
(
��< =
message
��= D
.
��D E
SenderUsername
��E S
)
��S T
||
��U W
string
�� 
.
��  
IsNullOrWhiteSpace
�� )
(
��) *
message
��* 1
.
��1 2
RecipientUsername
��2 C
)
��C D
||
��E G
string
��H N
.
��N O 
IsNullOrWhiteSpace
��O a
(
��a b
message
��b i
.
��i j
Content
��j q
)
��q r
)
��r s
{
�� 
throw
�� 
new
�� 
ArgumentException
�� +
(
��+ ,
$str
��, Z
)
��Z [
;
��[ \
}
�� 
using
�� 
(
�� 
var
�� 
	dbContext
��  
=
��! "
new
��# &#
GuessMyMessDBEntities
��' <
(
��< =
)
��= >
)
��> ?
{
�� 
var
�� 
sender
�� 
=
�� 
await
�� "
	dbContext
��# ,
.
��, -
Player
��- 3
.
��3 4!
FirstOrDefaultAsync
��4 G
(
��G H
p
��H I
=>
��J L
p
��M N
.
��N O
username
��O W
==
��X Z
message
��[ b
.
��b c
SenderUsername
��c q
)
��q r
;
��r s
var
�� 
	recipient
�� 
=
�� 
await
��  %
	dbContext
��& /
.
��/ 0
Player
��0 6
.
��6 7!
FirstOrDefaultAsync
��7 J
(
��J K
p
��K L
=>
��M O
p
��P Q
.
��Q R
username
��R Z
==
��[ ]
message
��^ e
.
��e f
RecipientUsername
��f w
)
��w x
;
��x y
if
�� 
(
�� 
sender
�� 
==
�� 
null
�� "
||
��# %
	recipient
��& /
==
��0 2
null
��3 7
)
��7 8
{
�� 
throw
�� 
new
�� 
	Exception
�� '
(
��' (
$str
��( `
)
��` a
;
��a b
}
�� 
var
�� 
	dbMessage
�� 
=
�� 
new
��  #
DirectMessages
��$ 2
{
�� 
SenderPlayerID
�� "
=
��# $
sender
��% +
.
��+ ,
idPlayer
��, 4
,
��4 5
RecipientPlayerID
�� %
=
��& '
	recipient
��( 1
.
��1 2
idPlayer
��2 :
,
��: ;
MessageContent
�� "
=
��# $
message
��% ,
.
��, -
Content
��- 4
,
��4 5
	Timestamp
�� 
=
�� 
DateTime
��  (
.
��( )
UtcNow
��) /
}
�� 
;
�� 
	dbContext
�� 
.
�� 
DirectMessages
�� (
.
��( )
Add
��) ,
(
��, -
	dbMessage
��- 6
)
��6 7
;
��7 8
await
�� 
	dbContext
�� 
.
��  
SaveChangesAsync
��  0
(
��0 1
)
��1 2
;
��2 3
message
�� 
.
�� 
	Timestamp
�� !
=
��" #
	dbMessage
��$ -
.
��- .
	Timestamp
��. 7
;
��7 8
}
�� 
}
�� 	
public
�� 
async
�� 
Task
�� 
<
�� 
List
�� 
<
�� 
	FriendDto
�� (
>
��( )
>
��) *#
GetConversationsAsync
��+ @
(
��@ A
string
��A G
username
��H P
)
��P Q
{
�� 	
using
�� 
(
�� 
var
�� 
	dbContext
��  
=
��! "
new
��# &#
GuessMyMessDBEntities
��' <
(
��< =
)
��= >
)
��> ?
{
�� 
var
�� 
user
�� 
=
�� 
await
��  
	dbContext
��! *
.
��* +
Player
��+ 1
.
��1 2!
FirstOrDefaultAsync
��2 E
(
��E F
p
��F G
=>
��H J
p
��K L
.
��L M
username
��M U
==
��V X
username
��Y a
)
��a b
;
��b c
if
�� 
(
�� 
user
�� 
==
�� 
null
��  
)
��  !
{
�� 
return
�� 
new
�� 
List
�� #
<
��# $
	FriendDto
��$ -
>
��- .
(
��. /
)
��/ 0
;
��0 1
}
�� 
var
�� 
userId
�� 
=
�� 
user
�� !
.
��! "
idPlayer
��" *
;
��* +
var
�� 
counterpartIds
�� "
=
��# $
await
��% *
	dbContext
��+ 4
.
��4 5
DirectMessages
��5 C
.
�� 
Where
�� 
(
�� 
m
�� 
=>
�� 
m
��  !
.
��! "
SenderPlayerID
��" 0
==
��1 3
userId
��4 :
||
��; =
m
��> ?
.
��? @
RecipientPlayerID
��@ Q
==
��R T
userId
��U [
)
��[ \
.
�� 
Select
�� 
(
�� 
m
�� 
=>
��  
m
��! "
.
��" #
SenderPlayerID
��# 1
==
��2 4
userId
��5 ;
?
��< =
m
��> ?
.
��? @
RecipientPlayerID
��@ Q
:
��R S
m
��T U
.
��U V
SenderPlayerID
��V d
)
��d e
.
�� 
Distinct
�� 
(
�� 
)
�� 
.
�� 
ToListAsync
��  
(
��  !
)
��! "
;
��" #
const
�� 
string
�� 
OnlineStatus
�� )
=
��* +
$str
��, 4
;
��4 5
return
�� 
await
�� 
	dbContext
�� &
.
��& '
Player
��' -
.
�� 
Where
�� 
(
�� 
p
�� 
=>
�� 
counterpartIds
��  .
.
��. /
Contains
��/ 7
(
��7 8
p
��8 9
.
��9 :
idPlayer
��: B
)
��B C
)
��C D
.
�� 
Select
�� 
(
�� 
p
�� 
=>
��  
new
��! $
	FriendDto
��% .
{
�� 
Username
��  
=
��! "
p
��# $
.
��$ %
username
��% -
,
��- .
IsOnline
��  
=
��! "
p
��# $
.
��$ %

UserStatus
��% /
.
��/ 0
status
��0 6
==
��7 9
OnlineStatus
��: F
}
�� 
)
�� 
.
�� 
ToListAsync
��  
(
��  !
)
��! "
;
��" #
}
�� 
}
�� 	
public
�� 
async
�� 
Task
�� 
<
�� 
List
�� 
<
�� 
DirectMessageDto
�� /
>
��/ 0
>
��0 1)
GetConversationHistoryAsync
��2 M
(
��M N
string
��N T
user1
��U Z
,
��Z [
string
��\ b
user2
��c h
)
��h i
{
�� 	
using
�� 
(
�� 
var
�� 
	dbContext
��  
=
��! "
new
��# &#
GuessMyMessDBEntities
��' <
(
��< =
)
��= >
)
��> ?
{
�� 
var
�� 
player1
�� 
=
�� 
await
�� #
	dbContext
��$ -
.
��- .
Player
��. 4
.
��4 5!
FirstOrDefaultAsync
��5 H
(
��H I
p
��I J
=>
��K M
p
��N O
.
��O P
username
��P X
==
��Y [
user1
��\ a
)
��a b
;
��b c
var
�� 
player2
�� 
=
�� 
await
�� #
	dbContext
��$ -
.
��- .
Player
��. 4
.
��4 5!
FirstOrDefaultAsync
��5 H
(
��H I
p
��I J
=>
��K M
p
��N O
.
��O P
username
��P X
==
��Y [
user2
��\ a
)
��a b
;
��b c
if
�� 
(
�� 
player1
�� 
==
�� 
null
�� #
||
��$ &
player2
��' .
==
��/ 1
null
��2 6
)
��6 7
{
�� 
return
�� 
new
�� 
List
�� #
<
��# $
DirectMessageDto
��$ 4
>
��4 5
(
��5 6
)
��6 7
;
��7 8
}
�� 
return
�� 
await
�� 
	dbContext
�� &
.
��& '
DirectMessages
��' 5
.
�� 
Where
�� 
(
�� 
m
�� 
=>
�� 
(
��  !
m
��! "
.
��" #
SenderPlayerID
��# 1
==
��2 4
player1
��5 <
.
��< =
idPlayer
��= E
&&
��F H
m
��I J
.
��J K
RecipientPlayerID
��K \
==
��] _
player2
��` g
.
��g h
idPlayer
��h p
)
��p q
||
��r t
(
��  !
m
��! "
.
��" #
SenderPlayerID
��# 1
==
��2 4
player2
��5 <
.
��< =
idPlayer
��= E
&&
��F H
m
��I J
.
��J K
RecipientPlayerID
��K \
==
��] _
player1
��` g
.
��g h
idPlayer
��h p
)
��p q
)
��q r
.
�� 
OrderBy
�� 
(
�� 
m
�� 
=>
�� !
m
��" #
.
��# $
	Timestamp
��$ -
)
��- .
.
�� 
Select
�� 
(
�� 
m
�� 
=>
��  
new
��! $
DirectMessageDto
��% 5
{
�� 
SenderUsername
�� &
=
��' (
m
��) *
.
��* +
Player1
��+ 2
.
��2 3
username
��3 ;
,
��; <
RecipientUsername
�� )
=
��* +
m
��, -
.
��- .
Player
��. 4
.
��4 5
username
��5 =
,
��= >
Content
�� 
=
��  !
m
��" #
.
��# $
MessageContent
��$ 2
,
��2 3
	Timestamp
�� !
=
��" #
m
��$ %
.
��% &
	Timestamp
��& /
}
�� 
)
�� 
.
�� 
ToListAsync
��  
(
��  !
)
��! "
;
��" #
}
�� 
}
�� 	
}
�� 
}�� �
�C:\Users\zenbook i5\Tecnologias_para_la_construccion_de_sw\ServidorProyecto\GuessMyMessServer\GuessMyMessServer\BusinessLogic\AuthenticationLogic.cs
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
�� 
{
�� 
await
�� 
_context
�� 
.
�� 
SaveChangesAsync
�� /
(
��/ 0
)
��0 1
;
��1 2
}
�� 
catch
�� 
(
�� 
DbUpdateException
�� $
dbEx
��% )
)
��) *
{
�� 
Console
�� 
.
�� 
	WriteLine
�� !
(
��! "
$"
��" $
$str
��$ <
{
��< =
dbEx
��= A
.
��A B
InnerException
��B P
?
��P Q
.
��Q R
Message
��R Y
??
��Z \
dbEx
��] a
.
��a b
Message
��b i
}
��i j
"
��j k
)
��k l
;
��l m
throw
�� 
new
�� 
	Exception
�� #
(
��# $
$str
��$ e
)
��e f
;
��f g
}
�� 
return
�� 
new
��  
OperationResultDto
�� )
{
��* +
Success
��, 3
=
��4 5
true
��6 :
,
��: ;
Message
��< C
=
��D E
$str��F �
}��� �
;��� �
}
�� 	
public
�� 
async
�� 
Task
�� 
<
��  
OperationResultDto
�� ,
>
��, - 
VerifyAccountAsync
��. @
(
��@ A
string
��A G
email
��H M
,
��M N
string
��O U
code
��V Z
)
��Z [
{
�� 	
if
�� 
(
�� 
string
�� 
.
��  
IsNullOrWhiteSpace
�� )
(
��) *
email
��* /
)
��/ 0
||
��1 3
string
��4 :
.
��: ; 
IsNullOrWhiteSpace
��; M
(
��M N
code
��N R
)
��R S
)
��S T
{
�� 
throw
�� 
new
�� 
	Exception
�� #
(
��# $
$str
��$ M
)
��M N
;
��N O
}
�� 
var
�� 
playerToVerify
�� 
=
��  
await
��! &
_context
��' /
.
��/ 0
Player
��0 6
.
��6 7!
FirstOrDefaultAsync
��7 J
(
��J K
p
��K L
=>
��M O
p
��P Q
.
��Q R
email
��R W
==
��X Z
email
��[ `
)
��` a
;
��a b
if
�� 
(
�� 
playerToVerify
�� 
==
�� !
null
��" &
)
��& '
{
�� 
throw
�� 
new
�� 
	Exception
�� #
(
��# $
$str
��$ Q
)
��Q R
;
��R S
}
�� 
if
�� 
(
�� 
playerToVerify
�� 
.
�� 
is_verified
�� *
==
��+ -
(
��. /
byte
��/ 3
)
��3 4
$num
��4 5
)
��5 6
{
�� 
throw
�� 
new
�� 
	Exception
�� #
(
��# $
$str
��$ E
)
��E F
;
��F G
}
�� 
if
�� 
(
�� 
playerToVerify
�� 
.
�� 
verification_code
�� 0
!=
��1 3
code
��4 8
||
��9 ;
playerToVerify
��< J
.
��J K
code_expiry_date
��K [
<
��\ ]
DateTime
��^ f
.
��f g
UtcNow
��g m
)
��m n
{
�� 
throw
�� 
new
�� 
	Exception
�� #
(
��# $
$str
��$ Q
)
��Q R
;
��R S
}
�� 
playerToVerify
�� 
.
�� 
is_verified
�� &
=
��' (
(
��) *
byte
��* .
)
��. /
$num
��/ 0
;
��0 1
playerToVerify
�� 
.
�� 
verification_code
�� ,
=
��- .
null
��/ 3
;
��3 4
playerToVerify
�� 
.
�� 
code_expiry_date
�� +
=
��, -
null
��. 2
;
��2 3
playerToVerify
�� 
.
�� %
UserStatus_idUserStatus
�� 2
=
��3 4
$num
��5 6
;
��6 7
await
�� 
_context
�� 
.
�� 
SaveChangesAsync
�� +
(
��+ ,
)
��, -
;
��- .
return
�� 
new
��  
OperationResultDto
�� )
{
��* +
Success
��, 3
=
��4 5
true
��6 :
,
��: ;
Message
��< C
=
��D E
$str
��F q
}
��r s
;
��s t
}
�� 	
public
�� 
void
�� 
LogOut
�� 
(
�� 
string
�� !
username
��" *
)
��* +
{
�� 	
const
�� 
int
�� 
StatusOffline
�� #
=
��$ %
$num
��& '
;
��' (
var
�� 
player
�� 
=
�� 
_context
�� !
.
��! "
Player
��" (
.
��( )
FirstOrDefault
��) 7
(
��7 8
p
��8 9
=>
��: <
p
��= >
.
��> ?
username
��? G
==
��H J
username
��K S
)
��S T
;
��T U
if
�� 
(
�� 
player
�� 
!=
�� 
null
�� 
)
�� 
{
�� 
player
�� 
.
�� %
UserStatus_idUserStatus
�� .
=
��/ 0
StatusOffline
��1 >
;
��> ?
_context
�� 
.
�� 
SaveChanges
�� $
(
��$ %
)
��% &
;
��& '
}
�� 
}
�� 	
}
�� 
}�� 