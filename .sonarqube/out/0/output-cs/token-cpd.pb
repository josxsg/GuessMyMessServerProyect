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
} á)
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
= 
Environment 
.  "
GetEnvironmentVariable  6
(6 7
$str7 N
)N O
??  
ConfigurationManager +
.+ ,
AppSettings, 7
[7 8
$str8 B
]B C
;C D
_senderName 
=  
ConfigurationManager .
.. /
AppSettings/ :
[: ;
$str; G
]G H
??I K
$strL `
;` a
if 
( 
string 
. 
IsNullOrEmpty $
($ %
_host% *
)* +
||, .
string/ 5
.5 6
IsNullOrEmpty6 C
(C D
_userD I
)I J
||K M
stringN T
.T U
IsNullOrEmptyU b
(b c
_passc h
)h i
)i j
{ 
throw   
new   %
InvalidOperationException   3
(  3 4
$str	  4 ç
)
  ç é
;
  é è
}!! 
}"" 	
public$$ 
async$$ 
Task$$ 
SendEmailAsync$$ (
($$( )
string$$) /
recipientEmail$$0 >
,$$> ?
string$$@ F
recipientName$$G T
,$$T U
IEmailTemplate$$V d
template$$e m
)$$m n
{%% 	
var&& 
message&& 
=&& 
new&& 
MimeMessage&& )
(&&) *
)&&* +
;&&+ ,
message'' 
.'' 
From'' 
.'' 
Add'' 
('' 
new''  
MailboxAddress''! /
(''/ 0
_senderName''0 ;
,''; <
_user''= B
)''B C
)''C D
;''D E
message(( 
.(( 
To(( 
.(( 
Add(( 
((( 
new(( 
MailboxAddress(( -
(((- .
recipientName((. ;
,((; <
recipientEmail((= K
)((K L
)((L M
;((M N
message)) 
.)) 
Subject)) 
=)) 
template)) &
.))& '
Subject))' .
;)). /
var++ 
bodyBuilder++ 
=++ 
new++ !
BodyBuilder++" -
{,, 
HtmlBody-- 
=-- 
template-- #
.--# $
HtmlBody--$ ,
}.. 
;.. 
message// 
.// 
Body// 
=// 
bodyBuilder// &
.//& '
ToMessageBody//' 4
(//4 5
)//5 6
;//6 7
using11 
(11 
var11 
client11 
=11 
new11  #

SmtpClient11$ .
(11. /
)11/ 0
)110 1
{22 
await33 
client33 
.33 
ConnectAsync33 )
(33) *
_host33* /
,33/ 0
_port331 6
,336 7
SecureSocketOptions338 K
.33K L
StartTls33L T
)33T U
;33U V
await44 
client44 
.44 
AuthenticateAsync44 .
(44. /
_user44/ 4
,444 5
_pass446 ;
)44; <
;44< =
await55 
client55 
.55 
	SendAsync55 &
(55& '
message55' .
)55. /
;55/ 0
await66 
client66 
.66 
DisconnectAsync66 ,
(66, -
true66- 1
)661 2
;662 3
}77 
}88 	
}99 
}:: ª
ïC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Utilities\BadWordValidator.cs
	namespace 	
GuessMyMessServer
 
. 
	Utilities %
{ 
public 

static 
class 
BadWordValidator (
{ 
private 
static 
readonly 
HashSet  '
<' (
string( .
>. /
_bannedWords0 <
== >
new? B
HashSetC J
<J K
stringK Q
>Q R
(R S
StringComparerS a
.a b
OrdinalIgnoreCaseb s
)s t
{ 	
$str 
, 
$str 
, 
$str 
, 
$str 
, 
$str 
, 
$str 
, 
$str 
, 
$str 
, 
$str 
, 
$str 
, 
$str 
, 
$str 
} 	
;	 

public 
static 
string 

BanMessage '
(' (
string( .
message/ 6
)6 7
{ 	
if 
( 
string 
. 
IsNullOrWhiteSpace )
() *
message* 1
)1 2
)2 3
return4 :
message; B
;B C
string   
processedMessage   #
=  $ %
message  & -
;  - .
foreach"" 
("" 
var"" 
badWord""  
in""! #
_bannedWords""$ 0
)""0 1
{## 
string&& 
pattern&& 
=&&  
$@"&&! $
$str&&$ &
{&&& '
Regex&&' ,
.&&, -
Escape&&- 3
(&&3 4
badWord&&4 ;
)&&; <
}&&< =
$str&&= ?
"&&? @
;&&@ A
processedMessage((  
=((! "
Regex((# (
.((( )
Replace(() 0
(((0 1
processedMessage((1 A
,((A B
pattern((C J
,((J K
match((L Q
=>((R T
{)) 
return++ 
new++ 
string++ %
(++% &
$char++& )
,++) *
match+++ 0
.++0 1
Length++1 7
)++7 8
;++8 9
},, 
,,, 
RegexOptions,, 
.,,  

IgnoreCase,,  *
),,* +
;,,+ ,
}-- 
return// 
processedMessage// #
;//# $
}00 	
}11 
}22 ‹Q
èC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Services\GameService.cs
	namespace 	
GuessMyMessServer
 
. 
Services $
{ 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?

PerSession? I
,I J
ConcurrencyModeK Z
=[ \
ConcurrencyMode] l
.l m
	Reentrantm v
)v w
]w x
public 

class 
GameService 
: 
IGameService +
{ 
private 
static 
readonly 
ILog  $
_log% )
=* +

LogManager, 6
.6 7
	GetLogger7 @
(@ A
typeofA G
(G H
GameServiceH S
)S T
)T U
;U V
private 
readonly  
IGameServiceCallback -
	_callback. 7
;7 8
private 
string 
_connectedUsername )
;) *
private 
string 
_connectedMatchId (
;( )
private 
	GameLogic 
Logic 
=>  "
Bootstrapper# /
./ 0
	Container0 9
.9 :
Resolve: A
<A B
	GameLogicB K
>K L
(L M
)M N
;N O
public 
GameService 
( 
) 
{ 	
Bootstrapper 
. 
Init 
( 
) 
;  
	_callback 
= 
OperationContext (
.( )
Current) 0
.0 1
GetCallbackChannel1 C
<C D 
IGameServiceCallbackD X
>X Y
(Y Z
)Z [
;[ \$
SubscribeToChannelEvents $
($ %
)% &
;& '
} 	
private!! 
void!! $
SubscribeToChannelEvents!! -
(!!- .
)!!. /
{"" 	
IContextChannel## 
channel## #
=##$ %
OperationContext##& 6
.##6 7
Current##7 >
.##> ?
Channel##? F
;##F G
channel$$ 
.$$ 
Faulted$$ 
+=$$ #
Channel_FaultedOrClosed$$ 6
;$$6 7
channel%% 
.%% 
Closed%% 
+=%% #
Channel_FaultedOrClosed%% 5
;%%5 6
}&& 	
public(( 
void(( 
Connect(( 
((( 
string(( "
username((# +
,((+ ,
string((- 3
matchId((4 ;
)((; <
{)) 	
try** 
{++ 
_connectedUsername,, "
=,,# $
username,,% -
;,,- .
_connectedMatchId-- !
=--" #
matchId--$ +
;--+ ,
Logic.. 
... 
ConnectPlayer.. #
(..# $
username..$ ,
,.., -
matchId... 5
,..5 6
	_callback..7 @
)..@ A
;..A B
}// 
catch00 
(00 
	Exception00 
ex00 
)00  
{00! "
_log00# '
.00' (
Error00( -
(00- .
$"00. 0
$str000 G
"00G H
,00H I
ex00J L
)00L M
;00M N
}00O P
}11 	
public33 
void33 

Disconnect33 
(33 
string33 %
username33& .
,33. /
string330 6
matchId337 >
)33> ?
{44 	
if55 
(55 
ValidateSession55 
(55  
username55  (
)55( )
)55) *
{66 
PerformDisconnect77 !
(77! "
isCrash77" )
:77) *
false77+ 0
)770 1
;771 2
}88 
}99 	
public;; 
void;; 

SelectWord;; 
(;; 
string;; %
username;;& .
,;;. /
string;;0 6
matchId;;7 >
,;;> ?
string;;@ F
selectedWord;;G S
);;S T
{<< 	
if== 
(== 
ValidateSession== 
(==  
username==  (
)==( )
)==) *
{>> 
Logic?? 
.??  
RegisterSelectedWord?? *
(??* +
username??+ 3
,??3 4
matchId??5 <
,??< =
selectedWord??> J
)??J K
;??K L
}@@ 
}AA 	
publicCC 
asyncCC 
TaskCC 
<CC 
ListCC 
<CC 
WordDtoCC &
>CC& '
>CC' (
GetRandomWordsAsyncCC) <
(CC< =
stringCC= C
usernameCCD L
)CCL M
{DD 	
tryEE 
{FF 
returnGG 
awaitGG 
LogicGG "
.GG" #
GetRandomWordsAsyncGG# 6
(GG6 7
usernameGG7 ?
)GG? @
;GG@ A
}HH 
catchII 
(II 
	ExceptionII 
exII 
)II  
{JJ 
_logKK 
.KK 
ErrorKK 
(KK 
$strKK 4
,KK4 5
exKK6 8
)KK8 9
;KK9 :
throwLL 
newLL 
FaultExceptionLL (
<LL( )
ServiceFaultDtoLL) 8
>LL8 9
(LL9 :
newLL: =
ServiceFaultDtoLL> M
(LLM N
ServiceErrorTypeLLN ^
.LL^ _
DatabaseErrorLL_ l
,LLl m
LangLLn r
.LLr s"
Error_GameWordsFailed	LLs à
)
LLà â
)
LLâ ä
;
LLä ã
}MM 
}NN 	
publicPP 
voidPP 
SubmitDrawingPP !
(PP! "
stringPP" (
usernamePP) 1
,PP1 2
stringPP3 9
matchIdPP: A
,PPA B
bytePPC G
[PPG H
]PPH I
drawingDataPPJ U
)PPU V
{QQ 	
ifRR 
(RR 
ValidateSessionRR 
(RR  
usernameRR  (
)RR( )
)RR) *
LogicSS 
.SS 

AddDrawingSS  
(SS  !
usernameSS! )
,SS) *
matchIdSS+ 2
,SS2 3
drawingDataSS4 ?
)SS? @
;SS@ A
}TT 	
publicVV 
voidVV 
SubmitGuessVV 
(VV  
stringVV  &
usernameVV' /
,VV/ 0
stringVV1 7
matchIdVV8 ?
,VV? @
intVVA D
	drawingIdVVE N
,VVN O
stringVVP V
guessVVW \
)VV\ ]
{WW 	
ifXX 
(XX 
ValidateSessionXX 
(XX  
usernameXX  (
)XX( )
)XX) *
LogicYY 
.YY 
ProcessGuessYY "
(YY" #
usernameYY# +
,YY+ ,
matchIdYY- 4
,YY4 5
	drawingIdYY6 ?
,YY? @
guessYYA F
)YYF G
;YYG H
}ZZ 	
public\\ 
void\\ !
SendInGameChatMessage\\ )
(\\) *
string\\* 0
username\\1 9
,\\9 :
string\\; A
matchId\\B I
,\\I J
string\\K Q
message\\R Y
)\\Y Z
{]] 	
if^^ 
(^^ 
ValidateSession^^ 
(^^  
username^^  (
)^^( )
)^^) *
Logic__ 
.__  
BroadcastChatMessage__ *
(__* +
username__+ 3
,__3 4
matchId__5 <
,__< =
message__> E
)__E F
;__F G
}`` 	
publicbb 
asyncbb 
voidbb 
	StartGamebb #
(bb# $
stringbb$ *
matchIdbb+ 2
,bb2 3
intbb4 7
totalRoundsbb8 C
,bbC D
ListbbE I
<bbI J
stringbbJ P
>bbP Q
playerUsernamesbbR a
)bba b
{cc 	
trydd 
{ee 
awaitff 
Logicff 
.ff 
StartGameAsyncff *
(ff* +
matchIdff+ 2
,ff2 3
totalRoundsff4 ?
,ff? @
playerUsernamesffA P
)ffP Q
;ffQ R
}gg 
catchhh 
(hh 
	Exceptionhh 
exhh 
)hh  
{hh! "
_loghh# '
.hh' (
Errorhh( -
(hh- .
$"hh. 0
$strhh0 C
"hhC D
,hhD E
exhhF H
)hhH I
;hhI J
}hhK L
}ii 	
privatekk 
boolkk 
ValidateSessionkk $
(kk$ %
stringkk% +
usernamekk, 4
)kk4 5
=>kk6 8
_connectedUsernamekk9 K
==kkL N
usernamekkO W
;kkW X
privatemm 
voidmm 
PerformDisconnectmm &
(mm& '
boolmm' +
isCrashmm, 3
)mm3 4
{nn 	
ifoo 
(oo 
!oo 
stringoo 
.oo 
IsNullOrEmptyoo %
(oo% &
_connectedUsernameoo& 8
)oo8 9
)oo9 :
{pp 
ifqq 
(qq 
isCrashqq 
)qq 
{rr 
Logicss 
.ss 
ForceDisconnectionss ,
(ss, -
_connectedUsernamess- ?
,ss? @
_connectedMatchIdssA R
)ssR S
;ssS T
}tt 
elseuu 
{vv 
Logicww 
.ww 
DisconnectPlayerww *
(ww* +
_connectedUsernameww+ =
,ww= >
_connectedMatchIdww? P
)wwP Q
;wwQ R
}xx 
_connectedUsernamezz "
=zz# $
nullzz% )
;zz) *
}{{ 
}|| 	
private~~ 
void~~ #
Channel_FaultedOrClosed~~ ,
(~~, -
object~~- 3
sender~~4 :
,~~: ;
	EventArgs~~< E
e~~F G
)~~G H
{ 	
PerformDisconnect
ÄÄ 
(
ÄÄ 
isCrash
ÄÄ %
:
ÄÄ% &
true
ÄÄ' +
)
ÄÄ+ ,
;
ÄÄ, -
}
ÅÅ 	
}
ÇÇ 
}ÉÉ Ÿz
ñC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Services\MatchmakingService.cs
	namespace 	
GuessMyMessServer
 
. 
Services $
{ 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?

PerSession? I
,I J
ConcurrencyModeK Z
=[ \
ConcurrencyMode] l
.l m
	Reentrantm v
)v w
]w x
public 

class 
MatchmakingService #
:$ %
IMatchmakingService& 9
{ 
private 
static 
readonly 
ILog  $
_log% )
=* +

LogManager, 6
.6 7
	GetLogger7 @
(@ A
typeofA G
(G H
MatchmakingServiceH Z
)Z [
)[ \
;\ ]
private 
string 
_connectedUsername )
;) *
private '
IMatchmakingServiceCallback +
	_callback, 5
;5 6
private 
MatchmakingLogic  
Logic! &
=>' )
Bootstrapper* 6
.6 7
	Container7 @
.@ A
ResolveA H
<H I
MatchmakingLogicI Y
>Y Z
(Z [
)[ \
;\ ]
public 
MatchmakingService !
(! "
)" #
{ 	
Bootstrapper 
. 
Init 
( 
) 
;  
InitializeCallback 
( 
)  
;  !
}   	
public## 
MatchmakingService## !
(##! "
MatchmakingLogic##" 2
matchmakingLogic##3 C
)##C D
{$$ 	
InitializeCallback%% 
(%% 
)%%  
;%%  !
}&& 	
private(( 
void(( 
InitializeCallback(( '
(((' (
)((( )
{)) 	
	_callback** 
=** 
OperationContext** (
.**( )
Current**) 0
.**0 1
GetCallbackChannel**1 C
<**C D'
IMatchmakingServiceCallback**D _
>**_ `
(**` a
)**a b
;**b c
IContextChannel++ 
channel++ #
=++$ %
OperationContext++& 6
.++6 7
Current++7 >
.++> ?
Channel++? F
;++F G
channel,, 
.,, 
Closing,, 
+=,, 
Channel_Closing,, .
;,,. /
channel-- 
.-- 
Faulted-- 
+=-- 
Channel_Faulted-- .
;--. /
}.. 	
public00 
void00 
Connect00 
(00 
string00 "
username00# +
)00+ ,
{11 	
try22 
{33 
_connectedUsername44 "
=44# $
username44% -
;44- .
_log55 
.55 
Info55 
(55 
$"55 
$str55 6
{556 7
username557 ?
}55? @
$str55@ X
{55X Y
OperationContext55Y i
.55i j
Current55j q
.55q r
	SessionId55r {
}55{ |
$str55| ~
"55~ 
)	55 Ä
;
55Ä Å
Logic66 
.66 
ConnectUser66 !
(66! "
username66" *
)66* +
;66+ ,
}77 
catch88 
(88 
	Exception88 
ex88 
)88  
{99 
_log:: 
.:: 
Error:: 
(:: 
$":: 
$str:: 4
{::4 5
username::5 =
}::= >
$str::> O
"::O P
,::P Q
ex::R T
)::T U
;::U V
};; 
}<< 	
public>> 
void>> 

Disconnect>> 
(>> 
string>> %
username>>& .
)>>. /
{?? 	
if@@ 
(@@ 
!@@ 
IsSessionValid@@ 
(@@  
username@@  (
)@@( )
)@@) *
return@@+ 1
;@@1 2
tryAA 
{AA 
PerformDisconnectAA #
(AA# $
)AA$ %
;AA% &
}AA' (
catchBB 
(BB 
	ExceptionBB 
exBB 
)BB  
{BB! "
_logBB# '
.BB' (
WarnBB( ,
(BB, -
$"BB- /
$strBB/ S
{BBS T
usernameBBT \
}BB\ ]
$strBB] ^
"BB^ _
,BB_ `
exBBa c
)BBc d
;BBd e
}BBf g
}CC 	
publicEE 
asyncEE 
TaskEE 
<EE 
OperationResultDtoEE ,
>EE, -
CreateMatchEE. 9
(EE9 :
stringEE: @
hostUsernameEEA M
,EEM N
LobbySettingsDtoEEO _
settingsEE` h
)EEh i
{FF 	
ifGG 
(GG 
!GG 
IsSessionValidGG 
(GG  
hostUsernameGG  ,
)GG, -
)GG- .
ThrowSessionFaultGG/ @
(GG@ A
)GGA B
;GGB C
_logHH 
.HH 
InfoHH 
(HH 
$"HH 
$strHH 2
{HH2 3
hostUsernameHH3 ?
}HH? @
"HH@ A
)HHA B
;HHB C
returnII 
awaitII 
LogicII 
.II 
CreateMatchAsyncII /
(II/ 0
hostUsernameII0 <
,II< =
settingsII> F
)IIF G
;IIG H
}JJ 	
publicLL 
asyncLL 
TaskLL 
<LL 
ListLL 
<LL 
MatchInfoDtoLL +
>LL+ ,
>LL, -
GetPublicMatchesLL. >
(LL> ?
)LL? @
{MM 	
returnOO 
awaitOO 
TaskOO 
.OO 
RunOO !
(OO! "
(OO" #
)OO# $
=>OO% '
LogicOO( -
.OO- .
GetPublicMatchesOO. >
(OO> ?
)OO? @
)OO@ A
;OOA B
}PP 	
publicRR 
asyncRR 
voidRR 
JoinPublicMatchRR )
(RR) *
stringRR* 0
usernameRR1 9
,RR9 :
stringRR; A
matchIdRRB I
)RRI J
{SS 	
ifTT 
(TT 
!TT 
IsSessionValidTT 
(TT  
usernameTT  (
)TT( )
)TT) *
{UU 
NotifyCallbackErrorVV #
(VV# $
LangVV$ (
.VV( )!
Error_SessionMismatchVV) >
)VV> ?
;VV? @
returnWW 
;WW 
}XX 
tryYY 
{ZZ 
var[[ 
result[[ 
=[[ 
await[[ "
Logic[[# (
.[[( ) 
JoinPublicMatchAsync[[) =
([[= >
username[[> F
,[[F G
matchId[[H O
)[[O P
;[[P Q
	_callback\\ 
.\\ 
MatchJoined\\ %
(\\% &
result\\& ,
.\\, -
Data\\- 1
[\\1 2
$str\\2 ;
]\\; <
,\\< =
result\\> D
)\\D E
;\\E F
}]] 
catch^^ 
(^^ 
FaultException^^ !
<^^! "
ServiceFaultDto^^" 1
>^^1 2
fEx^^3 6
)^^6 7
{__ 
_log`` 
.`` 
Info`` 
(`` 
$"`` 
$str`` 4
{``4 5
fEx``5 8
.``8 9
Detail``9 ?
.``? @
Message``@ G
}``G H
"``H I
)``I J
;``J K
	_callbackaa 
.aa 
MatchJoinedaa %
(aa% &
nullaa& *
,aa* +
newaa, /
OperationResultDtoaa0 B
{aaC D
SuccessaaE L
=aaM N
falseaaO T
,aaT U
MessageaaV ]
=aa^ _
fExaa` c
.aac d
Detailaad j
.aaj k
Messageaak r
}aas t
)aat u
;aau v
}bb 
catchcc 
(cc 
	Exceptioncc 
excc 
)cc  
{dd 
_logee 
.ee 
Erroree 
(ee 
$"ee 
$stree B
{eeB C
matchIdeeC J
}eeJ K
$streeK L
"eeL M
,eeM N
exeeO Q
)eeQ R
;eeR S
	_callbackff 
.ff 
MatchJoinedff %
(ff% &
nullff& *
,ff* +
newff, /
OperationResultDtoff0 B
{ffC D
SuccessffE L
=ffM N
falseffO T
,ffT U
MessageffV ]
=ff^ _
Langff` d
.ffd e
Error_ServerGenericffe x
}ffy z
)ffz {
;ff{ |
}gg 
}hh 	
publicjj 
asyncjj 
Taskjj 
<jj 
OperationResultDtojj ,
>jj, -
JoinPrivateMatchjj. >
(jj> ?
stringjj? E
usernamejjF N
,jjN O
stringjjP V
	matchCodejjW `
)jj` a
{kk 	
ifll 
(ll 
!ll 
IsSessionValidll 
(ll  
usernamell  (
)ll( )
)ll) *
ThrowSessionFaultll+ <
(ll< =
)ll= >
;ll> ?
_logmm 
.mm 
Infomm 
(mm 
$"mm 
$strmm 7
{mm7 8
usernamemm8 @
}mm@ A
$strmmA H
{mmH I
	matchCodemmI R
}mmR S
"mmS T
)mmT U
;mmU V
returnnn 
awaitnn 
Logicnn 
.nn !
JoinPrivateMatchAsyncnn 4
(nn4 5
usernamenn5 =
,nn= >
	matchCodenn? H
)nnH I
;nnI J
}oo 	
publicqq 
voidqq 
InviteToMatchqq !
(qq! "
stringqq" (
inviterUsernameqq) 8
,qq8 9
stringqq: @
invitedUsernameqqA P
,qqP Q
stringqqR X
matchIdqqY `
)qq` a
{rr 	
ifss 
(ss 
!ss 
IsSessionValidss 
(ss  
inviterUsernamess  /
)ss/ 0
)ss0 1
returnss2 8
;ss8 9
trytt 
{tt 
Logictt 
.tt 
InviteToMatchtt %
(tt% &
inviterUsernamett& 5
,tt5 6
invitedUsernamett7 F
,ttF G
matchIdttH O
)ttO P
;ttP Q
}ttR S
catchuu 
(uu 
	Exceptionuu 
exuu 
)uu  
{uu! "
_loguu# '
.uu' (
Warnuu( ,
(uu, -
$"uu- /
$struu/ >
{uu> ?
invitedUsernameuu? N
}uuN O
"uuO P
,uuP Q
exuuR T
)uuT U
;uuU V
}uuW X
}vv 	
publicxx 
asyncxx 
Taskxx 
InviteGuestByEmailxx ,
(xx, -
stringxx- 3
inviterUsernamexx4 C
,xxC D
stringxxE K
targetEmailxxL W
,xxW X
stringxxY _
matchIdxx` g
)xxg h
{yy 	
ifzz 
(zz 
!zz 
IsSessionValidzz 
(zz  
inviterUsernamezz  /
)zz/ 0
)zz0 1
ThrowSessionFaultzz2 C
(zzC D
)zzD E
;zzE F
await{{ 
Logic{{ 
.{{ #
InviteGuestByEmailAsync{{ /
({{/ 0
inviterUsername{{0 ?
,{{? @
targetEmail{{A L
,{{L M
matchId{{N U
){{U V
;{{V W
}|| 	
private 
bool 
IsSessionValid #
(# $
string$ *
username+ 3
)3 4
{
ÄÄ 	
if
ÅÅ 
(
ÅÅ  
_connectedUsername
ÅÅ "
==
ÅÅ# %
username
ÅÅ& .
)
ÅÅ. /
return
ÅÅ0 6
true
ÅÅ7 ;
;
ÅÅ; <
_log
ÇÇ 
.
ÇÇ 
Warn
ÇÇ 
(
ÇÇ 
$"
ÇÇ 
$str
ÇÇ 6
{
ÇÇ6 7 
_connectedUsername
ÇÇ7 I
}
ÇÇI J
$str
ÇÇJ ]
{
ÇÇ] ^
username
ÇÇ^ f
}
ÇÇf g
$str
ÇÇg i
"
ÇÇi j
)
ÇÇj k
;
ÇÇk l
return
ÉÉ 
false
ÉÉ 
;
ÉÉ 
}
ÑÑ 	
private
ÖÖ 
void
ÖÖ 
PerformDisconnect
ÖÖ &
(
ÖÖ& '
)
ÖÖ' (
{
ÜÜ 	
if
áá 
(
áá 
!
áá 
string
áá 
.
áá 
IsNullOrEmpty
áá %
(
áá% & 
_connectedUsername
áá& 8
)
áá8 9
)
áá9 :
{
àà 
Logic
ââ 
.
ââ 
DisconnectUser
ââ $
(
ââ$ % 
_connectedUsername
ââ% 7
)
ââ7 8
;
ââ8 9
_log
ää 
.
ää 
Info
ää 
(
ää 
$"
ää 
$str
ää C
{
ääC D 
_connectedUsername
ääD V
}
ääV W
$str
ääW Y
"
ääY Z
)
ääZ [
;
ää[ \ 
_connectedUsername
ãã "
=
ãã# $
null
ãã% )
;
ãã) *
}
åå 
}
çç 	
private
éé 
void
éé !
NotifyCallbackError
éé (
(
éé( )
string
éé) /
message
éé0 7
)
éé7 8
{
èè 	
try
êê 
{
êê 
	_callback
êê 
?
êê 
.
êê 
MatchmakingFailed
êê .
(
êê. /
message
êê/ 6
)
êê6 7
;
êê7 8
}
êê9 :
catch
êê; @
{
êêA B
}
êêC D
}
ëë 	
private
íí 
void
íí 
ThrowSessionFault
íí &
(
íí& '
)
íí' (
{
ìì 	
throw
îî 
new
îî 
FaultException
îî $
<
îî$ %
ServiceFaultDto
îî% 4
>
îî4 5
(
îî5 6
new
îî6 9
ServiceFaultDto
îî: I
(
îîI J
ServiceErrorType
îîJ Z
.
îîZ [
OperationFailed
îî[ j
,
îîj k
Lang
îîl p
.
îîp q$
Error_SessionMismatchîîq Ü
)îîÜ á
,îîá à
newîîâ å
FaultReasonîîç ò
(îîò ô
$strîîô ™
)îî™ ´
)îî´ ¨
;îî¨ ≠
}
ïï 	
private
ññ 
void
ññ 
Channel_Closing
ññ $
(
ññ$ %
object
ññ% +
sender
ññ, 2
,
ññ2 3
	EventArgs
ññ4 =
e
ññ> ?
)
ññ? @
{
ññA B
PerformDisconnect
ññC T
(
ññT U
)
ññU V
;
ññV W
}
ññX Y
private
óó 
void
óó 
Channel_Faulted
óó $
(
óó$ %
object
óó% +
sender
óó, 2
,
óó2 3
	EventArgs
óó4 =
e
óó> ?
)
óó? @
{
óóA B
_log
óóC G
.
óóG H
Warn
óóH L
(
óóL M
$"
óóM O
$str
óóO i
{
óói j 
_connectedUsername
óój |
}
óó| }
$str
óó} 
"óó Ä
)óóÄ Å
;óóÅ Ç!
PerformDisconnectóóÉ î
(óóî ï
)óóï ñ
;óóñ ó
}óóò ô
}
ôô 
}öö Å

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
} µ<
ñC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Services\UserProfileService.cs
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
.> ?
PerCall? F
)F G
]G H
public 

class 
UserProfileService #
:$ %
IUserProfileService& 9
{ 
private 
static 
readonly 
ILog  $
_log% )
=* +

LogManager, 6
.6 7
	GetLogger7 @
(@ A
typeofA G
(G H
UserProfileServiceH Z
)Z [
)[ \
;\ ]
private 
UserProfileLogic  
Logic! &
=>' )
Bootstrapper* 6
.6 7
	Container7 @
.@ A
ResolveA H
<H I
UserProfileLogicI Y
>Y Z
(Z [
)[ \
;\ ]
public 
UserProfileService !
(! "
)" #
{ 	
Bootstrapper 
. 
Init 
( 
) 
;  
} 	
public 
UserProfileService !
(! "
UserProfileLogic" 2
profileLogic3 ?
)? @
{ 	
} 	
public!! 
async!! 
Task!! 
<!! 
UserProfileDto!! (
>!!( )
GetUserProfileAsync!!* =
(!!= >
string!!> D
username!!E M
)!!M N
{"" 	
_log## 
.## 
Info## 
(## 
$"## 
$str## 4
{##4 5
username##5 =
}##= >
"##> ?
)##? @
;##@ A
return$$ 
await$$ 
Logic$$ 
.$$ 
GetUserProfileAsync$$ 2
($$2 3
username$$3 ;
)$$; <
;$$< =
}%% 	
public'' 
async'' 
Task'' 
<'' 
OperationResultDto'' ,
>'', -
UpdateProfileAsync''. @
(''@ A
string''A G
username''H P
,''P Q
UserProfileDto''R `
profileData''a l
)''l m
{(( 	
_log)) 
.)) 
Info)) 
()) 
$")) 
$str)) 3
{))3 4
username))4 <
}))< =
"))= >
)))> ?
;))? @
return** 
await** 
Logic** 
.** 
UpdateProfileAsync** 1
(**1 2
username**2 :
,**: ;
profileData**< G
)**G H
;**H I
}++ 	
public-- 
async-- 
Task-- 
<-- 
OperationResultDto-- ,
>--, -)
AddOrUpdateSocialNetworkAsync--. K
(--K L
string--L R
username--S [
,--[ \
SocialNetworkDto--] m
socialNetwork--n {
)--{ |
{.. 	
_log// 
.// 
Info// 
(// 
$"// 
$str// :
{//: ;
socialNetwork//; H
?//H I
.//I J
NetworkType//J U
}//U V
$str//V ]
{//] ^
username//^ f
}//f g
"//g h
)//h i
;//i j
return00 
await00 
Logic00 
.00 )
AddOrUpdateSocialNetworkAsync00 <
(00< =
username00= E
,00E F
socialNetwork00G T
)00T U
;00U V
}11 	
public33 
async33 
Task33 
<33 
List33 
<33 
	AvatarDto33 (
>33( )
>33) *$
GetAvailableAvatarsAsync33+ C
(33C D
)33D E
{44 	
return55 
await55 
Logic55 
.55 $
GetAvailableAvatarsAsync55 7
(557 8
)558 9
;559 :
}66 	
public88 
async88 
Task88 
<88 
OperationResultDto88 ,
>88, -#
RequestChangeEmailAsync88. E
(88E F
string88F L
username88M U
,88U V
string88W ]
newEmail88^ f
)88f g
{99 	
_log:: 
.:: 
Info:: 
(:: 
$":: 
$str:: 1
{::1 2
username::2 :
}::: ;
"::; <
)::< =
;::= >
return;; 
await;; 
Logic;; 
.;; #
RequestChangeEmailAsync;; 6
(;;6 7
username;;7 ?
,;;? @
newEmail;;A I
);;I J
;;;J K
}<< 	
public>> 
async>> 
Task>> 
<>> 
OperationResultDto>> ,
>>>, -#
ConfirmChangeEmailAsync>>. E
(>>E F
string>>F L
username>>M U
,>>U V
string>>W ]
verificationCode>>^ n
)>>n o
{?? 	
_log@@ 
.@@ 
Info@@ 
(@@ 
$"@@ 
$str@@ 8
{@@8 9
username@@9 A
}@@A B
"@@B C
)@@C D
;@@D E
returnAA 
awaitAA 
LogicAA 
.AA #
ConfirmChangeEmailAsyncAA 6
(AA6 7
usernameAA7 ?
,AA? @
verificationCodeAAA Q
)AAQ R
;AAR S
}BB 	
publicDD 
asyncDD 
TaskDD 
<DD 
OperationResultDtoDD ,
>DD, -&
RequestChangePasswordAsyncDD. H
(DDH I
stringDDI O
usernameDDP X
)DDX Y
{EE 	
_logFF 
.FF 
InfoFF 
(FF 
$"FF 
$strFF 4
{FF4 5
usernameFF5 =
}FF= >
"FF> ?
)FF? @
;FF@ A
returnGG 
awaitGG 
LogicGG 
.GG &
RequestChangePasswordAsyncGG 9
(GG9 :
usernameGG: B
)GGB C
;GGC D
}HH 	
publicJJ 
asyncJJ 
TaskJJ 
<JJ 
OperationResultDtoJJ ,
>JJ, -&
ConfirmChangePasswordAsyncJJ. H
(JJH I
stringJJI O
usernameJJP X
,JJX Y
stringJJZ `
newPasswordJJa l
,JJl m
stringJJn t
verificationCode	JJu Ö
)
JJÖ Ü
{KK 	
_logLL 
.LL 
InfoLL 
(LL 
$"LL 
$strLL ;
{LL; <
usernameLL< D
}LLD E
"LLE F
)LLF G
;LLG H
returnMM 
awaitMM 
LogicMM 
.MM &
ConfirmChangePasswordAsyncMM 9
(MM9 :
usernameMM: B
,MMB C
newPasswordMMD O
,MMO P
verificationCodeMMQ a
)MMa b
;MMb c
}NN 	
publicPP 
asyncPP 
TaskPP 
<PP 
ListPP 
<PP 
PlayerScoreDtoPP -
>PP- .
>PP. /!
GetGlobalRankingAsyncPP0 E
(PPE F
)PPF G
{QQ 	
_logRR 
.RR 
InfoRR 
(RR 
$strRR 0
)RR0 1
;RR1 2
returnSS 
awaitSS 
LogicSS 
.SS !
GetGlobalRankingAsyncSS 4
(SS4 5
)SS5 6
;SS6 7
}TT 	
}UU 
}VV Ê
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
} ´
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
)0 1
{ 
return 
false 
; 
} 
try 
{ 
var 
regex 
= 
new 
Regex  %
(% &
$str& H
,H I
RegexOptionsJ V
.V W

IgnoreCaseW a
,a b
TimeSpanc k
.k l
FromMillisecondsl |
(| }
$num	} Ä
)
Ä Å
)
Å Ç
;
Ç É
return 
regex 
. 
IsMatch $
($ %
email% *
)* +
;+ ,
} 
catch 
( &
RegexMatchTimeoutException -
)- .
{ 
return 
false 
; 
} 
} 	
public 
static 
bool 
IsPasswordSecure +
(+ ,
string, 2
password3 ;
); <
{ 	
if   
(   
string   
.   
IsNullOrWhiteSpace   )
(  ) *
password  * 2
)  2 3
)  3 4
{!! 
return"" 
false"" 
;"" 
}## 
if%% 
(%% 
password%% 
.%% 
Length%% 
<%%  !
$num%%" #
)%%# $
{&& 
return'' 
false'' 
;'' 
}(( 
if** 
(** 
!** 
password** 
.** 
Any** 
(** 
char** "
.**" #
IsUpper**# *
)*** +
)**+ ,
{++ 
return,, 
false,, 
;,, 
}-- 
if// 
(// 
!// 
password// 
.// 
Any// 
(// 
char// "
.//" #
IsLower//# *
)//* +
)//+ ,
{00 
return11 
false11 
;11 
}22 
if44 
(44 
!44 
password44 
.44 
Any44 
(44 
char44 "
.44" #
IsDigit44# *
)44* +
)44+ ,
{55 
return66 
false66 
;66 
}77 
if99 
(99 
!99 
password99 
.99 
Contains99 "
(99" #
$str99# &
)99& '
)99' (
{:: 
return;; 
false;; 
;;; 
}<< 
if>> 
(>> 
password>> 
.>> 
All>> 
(>> 
char>> !
.>>! "
IsLetterOrDigit>>" 1
)>>1 2
)>>2 3
{?? 
return@@ 
false@@ 
;@@ 
}AA 
returnCC 
trueCC 
;CC 
}DD 	
}EE 
}FF Ù	
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
}## Î	
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
}## §	
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
} ›
¥C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Utilities\Email\Templates\InvitationForMatchEmailTemplate.cs
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
class		 +
InvitationForMatchEmailTemplate		 0
:		1 2
IEmailTemplate		3 A
{

 
public 
string 
Subject 
=>  
$str! R
;R S
public 
string 
HtmlBody 
{  
get! $
;$ %
}& '
public +
InvitationForMatchEmailTemplate .
(. /
string/ 5
verificationCode6 F
)F G
{ 	
HtmlBody 
= 
$@" 
$str Y
{Y Z
verificationCodeZ j
}j k
$strk 
" 
; 
}   	
}!! 
}"" Æ
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
.> ?
PerCall? F
,F G
ConcurrencyModeH W
=X Y
ConcurrencyModeZ i
.i j
	Reentrantj s
)s t
]t u
public 

class 
SocialService 
:  
ISocialService! /
{ 
private 
static 
readonly 
ILog  $
_log% )
=* +

LogManager, 6
.6 7
	GetLogger7 @
(@ A
typeofA G
(G H
SocialServiceH U
)U V
)V W
;W X
private 
SocialLogic 
Logic !
=>" $
Bootstrapper% 1
.1 2
	Container2 ;
.; <
Resolve< C
<C D
SocialLogicD O
>O P
(P Q
)Q R
;R S
private 
static 
readonly 

Dictionary  *
<* +
string+ 1
,1 2"
ISocialServiceCallback3 I
>I J
ConnectedClientsK [
=\ ]
new^ a

Dictionaryb l
<l m
stringm s
,s t#
ISocialServiceCallback	u ã
>
ã å
(
å ç
)
ç é
;
é è
private 
static 
readonly 
object  &
_clientLock' 2
=3 4
new5 8
object9 ?
(? @
)@ A
;A B
public 
SocialService 
( 
) 
{ 	
Bootstrapper 
. 
Init 
( 
) 
;  
} 	
public!! 
SocialService!! 
(!! 
SocialLogic!! (
socialLogic!!) 4
)!!4 5
{"" 	
}$$ 	
public&& 
void&& 
Connect&& 
(&& 
string&& "
username&&# +
)&&+ ,
{'' 	
if(( 
((( 
string(( 
.(( 
IsNullOrWhiteSpace(( )
((() *
username((* 2
)((2 3
)((3 4
return((5 ;
;((; <
try)) 
{** 
var++ 
callback++ 
=++ 
OperationContext++ /
.++/ 0
Current++0 7
.++7 8
GetCallbackChannel++8 J
<++J K"
ISocialServiceCallback++K a
>++a b
(++b c
)++c d
;++d e
lock,, 
(,, 
_clientLock,, !
),,! "
{-- 
if.. 
(.. 
ConnectedClients.. (
...( )
ContainsKey..) 4
(..4 5
username..5 =
)..= >
)..> ?
ConnectedClients..@ P
[..P Q
username..Q Y
]..Y Z
=..[ \
callback..] e
;..e f
else// 
ConnectedClients// )
.//) *
Add//* -
(//- .
username//. 6
,//6 7
callback//8 @
)//@ A
;//A B
}00 
_log11 
.11 
Info11 
(11 
$"11 
$str11 1
{111 2
username112 :
}11: ;
$str11; G
"11G H
)11H I
;11I J
Task33 
.33 
Run33 
(33 
async33 
(33  
)33  !
=>33" $
{33% &
await44 
Logic44 
.44  #
UpdatePlayerStatusAsync44  7
(447 8
username448 @
,44@ A
$str44B J
)44J K
;44K L
await55 $
NotifyFriendStatusUpdate55 2
(552 3
username553 ;
,55; <
$str55= E
)55E F
;55F G
}66 
)66 
;66 
}77 
catch88 
(88 
	Exception88 
ex88 
)88  
{88! "
_log88# '
.88' (
Error88( -
(88- .
$"88. 0
$str880 G
{88G H
username88H P
}88P Q
$str88Q R
"88R S
,88S T
ex88U W
)88W X
;88X Y
}88Z [
}99 	
public;; 
void;; 

Disconnect;; 
(;; 
string;; %
username;;& .
);;. /
{<< 	
if== 
(== 
string== 
.== 
IsNullOrWhiteSpace== )
(==) *
username==* 2
)==2 3
)==3 4
return==5 ;
;==; <
try>> 
{?? 
lock@@ 
(@@ 
_clientLock@@ !
)@@! "
{@@# $
if@@% '
(@@( )
ConnectedClients@@) 9
.@@9 :
ContainsKey@@: E
(@@E F
username@@F N
)@@N O
)@@O P
ConnectedClients@@Q a
.@@a b
Remove@@b h
(@@h i
username@@i q
)@@q r
;@@r s
}@@t u
_logAA 
.AA 
InfoAA 
(AA 
$"AA 
$strAA 1
{AA1 2
usernameAA2 :
}AA: ;
$strAA; J
"AAJ K
)AAK L
;AAL M
TaskCC 
.CC 
RunCC 
(CC 
asyncCC 
(CC  
)CC  !
=>CC" $
{CC% &
awaitDD 
LogicDD 
.DD  #
UpdatePlayerStatusAsyncDD  7
(DD7 8
usernameDD8 @
,DD@ A
$strDDB K
)DDK L
;DDL M
awaitEE $
NotifyFriendStatusUpdateEE 2
(EE2 3
usernameEE3 ;
,EE; <
$strEE= F
)EEF G
;EEG H
}FF 
)FF 
;FF 
}GG 
catchHH 
(HH 
	ExceptionHH 
exHH 
)HH  
{HH! "
_logHH# '
.HH' (
WarnHH( ,
(HH, -
$"HH- /
$strHH/ I
{HHI J
usernameHHJ R
}HHR S
$strHHS T
"HHT U
,HHU V
exHHW Y
)HHY Z
;HHZ [
}HH\ ]
}II 	
publicKK 
asyncKK 
TaskKK 
<KK 
ListKK 
<KK 
	FriendDtoKK (
>KK( )
>KK) *
GetFriendsListAsyncKK+ >
(KK> ?
stringKK? E
usernameKKF N
)KKN O
{LL 	
varMM 
friendsMM 
=MM 
awaitMM 
LogicMM  %
.MM% &
GetFriendsListAsyncMM& 9
(MM9 :
usernameMM: B
)MMB C
;MMC D
lockNN 
(NN 
_clientLockNN 
)NN 
{OO 
foreachPP 
(PP 
varPP 
friendPP #
inPP$ &
friendsPP' .
)PP. /
{QQ 
ifRR 
(RR 
ConnectedClientsRR (
.RR( )
ContainsKeyRR) 4
(RR4 5
friendRR5 ;
.RR; <
UsernameRR< D
)RRD E
)RRE F
friendRRG M
.RRM N
IsOnlineRRN V
=RRW X
trueRRY ]
;RR] ^
}SS 
}TT 
returnUU 
friendsUU 
;UU 
}VV 	
publicXX 
asyncXX 
TaskXX 
<XX 
ListXX 
<XX  
FriendRequestInfoDtoXX 3
>XX3 4
>XX4 5"
GetFriendRequestsAsyncXX6 L
(XXL M
stringXXM S
usernameXXT \
)XX\ ]
=>XX^ `
awaitXXa f
LogicXXg l
.XXl m#
GetFriendRequestsAsync	XXm É
(
XXÉ Ñ
username
XXÑ å
)
XXå ç
;
XXç é
publicYY 
asyncYY 
TaskYY 
<YY 
ListYY 
<YY 
UserProfileDtoYY -
>YY- .
>YY. /
SearchUsersAsyncYY0 @
(YY@ A
stringYYA G
searchUsernameYYH V
,YYV W
stringYYX ^
requesterUsernameYY_ p
)YYp q
=>YYr t
awaitYYu z
Logic	YY{ Ä
.
YYÄ Å
SearchUsersAsync
YYÅ ë
(
YYë í
searchUsername
YYí †
,
YY† °
requesterUsername
YY¢ ≥
)
YY≥ ¥
;
YY¥ µ
public[[ 
async[[ 
void[[ 
SendFriendRequest[[ +
([[+ ,
string[[, 2
requesterUsername[[3 D
,[[D E
string[[F L
targetUsername[[M [
)[[[ \
{\\ 	
try]] 
{^^ 
await__ 
Logic__ 
.__ "
SendFriendRequestAsync__ 2
(__2 3
requesterUsername__3 D
,__D E
targetUsername__F T
)__T U
;__U V
NotifyIfConnected`` !
(``! "
targetUsername``" 0
,``0 1
cb``2 4
=>``5 7
cb``8 :
.``: ;
NotifyFriendRequest``; N
(``N O
requesterUsername``O `
)``` a
)``a b
;``b c
}aa 
catchbb 
(bb 
	Exceptionbb 
exbb 
)bb  
{bb! "
_logbb# '
.bb' (
Errorbb( -
(bb- .
$"bb. 0
$strbb0 L
"bbL M
,bbM N
exbbO Q
)bbQ R
;bbR S
}bbT U
}cc 	
publicee 
asyncee 
voidee "
RespondToFriendRequestee 0
(ee0 1
stringee1 7
targetUsernameee8 F
,eeF G
stringeeH N
requesterUsernameeeO `
,ee` a
booleeb f
acceptedeeg o
)eeo p
{ff 	
trygg 
{hh 
awaitii 
Logicii 
.ii '
RespondToFriendRequestAsyncii 7
(ii7 8
targetUsernameii8 F
,iiF G
requesterUsernameiiH Y
,iiY Z
acceptedii[ c
)iic d
;iid e
NotifyIfConnectedjj !
(jj! "
requesterUsernamejj" 3
,jj3 4
cbjj5 7
=>jj8 :
cbjj; =
.jj= > 
NotifyFriendResponsejj> R
(jjR S
targetUsernamejjS a
,jja b
acceptedjjc k
)jjk l
)jjl m
;jjm n
ifkk 
(kk 
acceptedkk 
)kk 
awaitkk #%
NotifyNewFriendshipStatuskk$ =
(kk= >
targetUsernamekk> L
,kkL M
requesterUsernamekkN _
)kk_ `
;kk` a
}ll 
catchmm 
(mm 
	Exceptionmm 
exmm 
)mm  
{mm! "
_logmm# '
.mm' (
Errormm( -
(mm- .
$"mm. 0
$strmm0 H
"mmH I
,mmI J
exmmK M
)mmM N
;mmN O
}mmP Q
}nn 	
publicpp 
asyncpp 
Taskpp 
<pp 
OperationResultDtopp ,
>pp, -
RemoveFriendAsyncpp. ?
(pp? @
stringpp@ F
usernameppG O
,ppO P
stringppQ W
friendToRemoveppX f
)ppf g
{qq 	
tryrr 
{ss 
vartt 
resulttt 
=tt 
awaittt "
Logictt# (
.tt( )
RemoveFriendAsynctt) :
(tt: ;
usernamett; C
,ttC D
friendToRemovettE S
)ttS T
;ttT U
ifvv 
(vv 
resultvv 
.vv 
Successvv "
)vv" #
{ww 
NotifyIfConnectedxx %
(xx% &
friendToRemovexx& 4
,xx4 5
cbxx6 8
=>xx9 ;
cbxx< >
.xx> ?
NotifyFriendRemovedxx? R
(xxR S
usernamexxS [
)xx[ \
)xx\ ]
;xx] ^
}yy 
returnzz 
resultzz 
;zz 
}{{ 
catch|| 
(|| 
	Exception|| 
ex|| 
)||  
{}} 
_log~~ 
.~~ 
Error~~ 
(~~ 
$"~~ 
$str~~ 2
"~~2 3
,~~3 4
ex~~5 7
)~~7 8
;~~8 9
throw 
new 
FaultException (
<( )
ServiceFaultDto) 8
>8 9
(9 :
new: =
ServiceFaultDto> M
(M N
ServiceErrorTypeN ^
.^ _
OperationFailed_ n
,n o
$str	p Ö
)
Ö Ü
,
Ü á
new
à ã
FaultReason
å ó
(
ó ò
ex
ò ö
.
ö õ
Message
õ ¢
)
¢ £
)
£ §
;
§ •
}
ÄÄ 
}
ÅÅ 	
public
ÉÉ 
async
ÉÉ 
Task
ÉÉ 
<
ÉÉ 
DirectMessageDto
ÉÉ *
>
ÉÉ* +$
SendDirectMessageAsync
ÉÉ, B
(
ÉÉB C
DirectMessageDto
ÉÉC S
message
ÉÉT [
)
ÉÉ[ \
{
ÑÑ 	
try
ÖÖ 
{
ÜÜ 
var
àà 
processedMessage
àà $
=
àà% &
await
àà' ,
Logic
àà- 2
.
àà2 3$
SendDirectMessageAsync
àà3 I
(
ààI J
message
ààJ Q
)
ààQ R
;
ààR S
NotifyIfConnected
ãã !
(
ãã! "
message
ãã" )
.
ãã) *
RecipientUsername
ãã* ;
,
ãã; <
cb
ãã= ?
=>
ãã@ B
cb
ããC E
.
ããE F#
NotifyMessageReceived
ããF [
(
ãã[ \
processedMessage
ãã\ l
)
ããl m
)
ããm n
;
ããn o
return
éé 
processedMessage
éé '
;
éé' (
}
èè 
catch
êê 
(
êê 
	Exception
êê 
ex
êê 
)
êê  
{
ëë 
_log
íí 
.
íí 
Error
íí 
(
íí 
$"
íí 
$str
íí -
"
íí- .
,
íí. /
ex
íí0 2
)
íí2 3
;
íí3 4
throw
ìì 
;
ìì 
}
îî 
}
ïï 	
public
óó 
async
óó 
Task
óó 
<
óó 
List
óó 
<
óó 
	FriendDto
óó (
>
óó( )
>
óó) *#
GetConversationsAsync
óó+ @
(
óó@ A
string
óóA G
username
óóH P
)
óóP Q
=>
óóR T
await
óóU Z
Logic
óó[ `
.
óó` a#
GetConversationsAsync
óóa v
(
óóv w
username
óów 
)óó Ä
;óóÄ Å
public
òò 
async
òò 
Task
òò 
<
òò 
List
òò 
<
òò 
DirectMessageDto
òò /
>
òò/ 0
>
òò0 1)
GetConversationHistoryAsync
òò2 M
(
òòM N
string
òòN T
user1
òòU Z
,
òòZ [
string
òò\ b
user2
òòc h
)
òòh i
=>
òòj l
await
òòm r
Logic
òòs x
.
òòx y*
GetConversationHistoryAsyncòòy î
(òòî ï
user1òòï ö
,òòö õ
user2òòú °
)òò° ¢
;òò¢ £
public
öö 
async
öö 
Task
öö 
<
öö 
FriendProfileDto
öö *
>
öö* +#
GetFriendProfileAsync
öö, A
(
ööA B
string
ööB H
username
ööI Q
)
ööQ R
{
õõ 	
try
úú 
{
ùù 
return
ûû 
await
ûû 
Logic
ûû "
.
ûû" ##
GetFriendProfileAsync
ûû# 8
(
ûû8 9
username
ûû9 A
)
ûûA B
;
ûûB C
}
üü 
catch
†† 
(
†† 
	Exception
†† 
ex
†† 
)
††  
{
°° 
_log
¢¢ 
.
¢¢ 
Error
¢¢ 
(
¢¢ 
$"
¢¢ 
$str
¢¢ 7
{
¢¢7 8
username
¢¢8 @
}
¢¢@ A
"
¢¢A B
,
¢¢B C
ex
¢¢D F
)
¢¢F G
;
¢¢G H
throw
££ 
new
££ 
FaultException
££ (
<
££( )
ServiceFaultDto
££) 8
>
££8 9
(
££9 :
new
££: =
ServiceFaultDto
££> M
(
££M N
ServiceErrorType
££N ^
.
££^ _
OperationFailed
££_ n
,
££n o
$str££p ç
)££ç é
,££é è
new££ê ì
FaultReason££î ü
(££ü †
ex££† ¢
.££¢ £
Message£££ ™
)££™ ´
)££´ ¨
;££¨ ≠
}
§§ 
}
•• 	
public
ßß 
Task
ßß 
<
ßß  
OperationResultDto
ßß &
>
ßß& ',
InviteFriendToGameByEmailAsync
ßß( F
(
ßßF G
string
ßßG M
fromUsername
ßßN Z
,
ßßZ [
string
ßß\ b
friendEmail
ßßc n
,
ßßn o
string
ßßp v
	matchCodeßßw Ä
)ßßÄ Å
{
®® 	
var
©© 
fault
©© 
=
©© 
new
©© 
ServiceFaultDto
©© +
(
©©+ ,
ServiceErrorType
©©, <
.
©©< =
OperationFailed
©©= L
,
©©L M
$str
©©N d
)
©©d e
;
©©e f
throw
™™ 
new
™™ 
FaultException
™™ $
<
™™$ %
ServiceFaultDto
™™% 4
>
™™4 5
(
™™5 6
fault
™™6 ;
,
™™; <
new
™™= @
FaultReason
™™A L
(
™™L M
$str
™™M ^
)
™™^ _
)
™™_ `
;
™™` a
}
´´ 	
private
≠≠ 
async
≠≠ 
Task
≠≠ &
NotifyFriendStatusUpdate
≠≠ 3
(
≠≠3 4
string
≠≠4 :
username
≠≠; C
,
≠≠C D
string
≠≠E K
status
≠≠L R
)
≠≠R S
{
ÆÆ 	
var
ØØ 
friends
ØØ 
=
ØØ 
await
ØØ 
Logic
ØØ  %
.
ØØ% &!
GetFriendsListAsync
ØØ& 9
(
ØØ9 :
username
ØØ: B
)
ØØB C
;
ØØC D
foreach
∞∞ 
(
∞∞ 
var
∞∞ 
friend
∞∞ 
in
∞∞  "
friends
∞∞# *
)
∞∞* +
NotifyIfConnected
∞∞, =
(
∞∞= >
friend
∞∞> D
.
∞∞D E
Username
∞∞E M
,
∞∞M N
cb
∞∞O Q
=>
∞∞R T
cb
∞∞U W
.
∞∞W X'
NotifyFriendStatusChanged
∞∞X q
(
∞∞q r
username
∞∞r z
,
∞∞z {
status∞∞| Ç
)∞∞Ç É
)∞∞É Ñ
;∞∞Ñ Ö
}
±± 	
private
≥≥ 
async
≥≥ 
Task
≥≥ '
NotifyNewFriendshipStatus
≥≥ 4
(
≥≥4 5
string
≥≥5 ;
u1
≥≥< >
,
≥≥> ?
string
≥≥@ F
u2
≥≥G I
)
≥≥I J
{
¥¥ 	
bool
µµ 
u2Online
µµ 
=
µµ 
false
µµ !
,
µµ! "
u1Online
µµ# +
=
µµ, -
false
µµ. 3
;
µµ3 4
lock
∂∂ 
(
∂∂ 
_clientLock
∂∂ 
)
∂∂ 
{
∂∂  
u2Online
∂∂! )
=
∂∂* +
ConnectedClients
∂∂, <
.
∂∂< =
ContainsKey
∂∂= H
(
∂∂H I
u2
∂∂I K
)
∂∂K L
;
∂∂L M
u1Online
∂∂N V
=
∂∂W X
ConnectedClients
∂∂Y i
.
∂∂i j
ContainsKey
∂∂j u
(
∂∂u v
u1
∂∂v x
)
∂∂x y
;
∂∂y z
}
∂∂{ |
NotifyIfConnected
∑∑ 
(
∑∑ 
u1
∑∑  
,
∑∑  !
cb
∑∑" $
=>
∑∑% '
cb
∑∑( *
.
∑∑* +'
NotifyFriendStatusChanged
∑∑+ D
(
∑∑D E
u2
∑∑E G
,
∑∑G H
u2Online
∑∑I Q
?
∑∑R S
$str
∑∑T \
:
∑∑] ^
$str
∑∑_ h
)
∑∑h i
)
∑∑i j
;
∑∑j k
NotifyIfConnected
∏∏ 
(
∏∏ 
u2
∏∏  
,
∏∏  !
cb
∏∏" $
=>
∏∏% '
cb
∏∏( *
.
∏∏* +'
NotifyFriendStatusChanged
∏∏+ D
(
∏∏D E
u1
∏∏E G
,
∏∏G H
u1Online
∏∏I Q
?
∏∏R S
$str
∏∏T \
:
∏∏] ^
$str
∏∏_ h
)
∏∏h i
)
∏∏i j
;
∏∏j k
await
ππ 
Task
ππ 
.
ππ 
CompletedTask
ππ $
;
ππ$ %
}
∫∫ 	
private
ºº 
void
ºº 
NotifyIfConnected
ºº &
(
ºº& '
string
ºº' -
target
ºº. 4
,
ºº4 5
Action
ºº6 <
<
ºº< =$
ISocialServiceCallback
ºº= S
>
ººS T
action
ººU [
)
ºº[ \
{
ΩΩ 	$
ISocialServiceCallback
ææ "
cb
ææ# %
=
ææ& '
null
ææ( ,
;
ææ, -
lock
øø 
(
øø 
_clientLock
øø 
)
øø 
{
øø  
ConnectedClients
øø! 1
.
øø1 2
TryGetValue
øø2 =
(
øø= >
target
øø> D
,
øøD E
out
øøF I
cb
øøJ L
)
øøL M
;
øøM N
}
øøO P
if
¿¿ 
(
¿¿ 
cb
¿¿ 
!=
¿¿ 
null
¿¿ 
)
¿¿ 
{
¡¡ 
try
¬¬ 
{
¬¬ 
action
¬¬ 
(
¬¬ 
cb
¬¬ 
)
¬¬  
;
¬¬  !
}
¬¬" #
catch
√√ 
{
√√ 
lock
√√ 
(
√√ 
_clientLock
√√ )
)
√√) *
{
√√+ ,
ConnectedClients
√√- =
.
√√= >
Remove
√√> D
(
√√D E
target
√√E K
)
√√K L
;
√√L M
}
√√N O
}
√√P Q
}
ƒƒ 
}
≈≈ 	
}
∆∆ 
}«« â2
ôC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Services\AuthenticationService.cs
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
.> ?
PerCall? F
)F G
]G H
public 

class !
AuthenticationService &
:' ("
IAuthenticationService) ?
{ 
private 
static 
readonly 
ILog  $
_log% )
=* +

LogManager, 6
.6 7
	GetLogger7 @
(@ A
typeofA G
(G H!
AuthenticationServiceH ]
)] ^
)^ _
;_ `
private 
AuthenticationLogic #
Logic$ )
=>* ,
Bootstrapper- 9
.9 :
	Container: C
.C D
ResolveD K
<K L
AuthenticationLogicL _
>_ `
(` a
)a b
;b c
public !
AuthenticationService $
($ %
)% &
{ 	
Bootstrapper 
. 
Init 
( 
) 
;  
} 	
public 
async 
Task 
< 
OperationResultDto ,
>, -

LoginAsync. 8
(8 9
string9 ?
emailOrUsername@ O
,O P
stringQ W
passwordX `
)` a
{ 	
_log 
. 
Info 
( 
$" 
$str 4
{4 5
emailOrUsername5 D
}D E
"E F
)F G
;G H
return 
await 
Logic 
. 

LoginAsync )
() *
emailOrUsername* 9
,9 :
password; C
)C D
;D E
}   	
public"" 
async"" 
Task"" 
<"" 
OperationResultDto"" ,
>"", -
RegisterAsync"". ;
(""; <
UserProfileDto""< J
userProfile""K V
,""V W
string""X ^
password""_ g
)""g h
{## 	
_log$$ 
.$$ 
Info$$ 
($$ 
$"$$ 
$str$$ ;
{$$; <
userProfile$$< G
?$$G H
.$$H I
Username$$I Q
??$$R T
$str$$U ^
}$$^ _
"$$_ `
)$$` a
;$$a b
return%% 
await%% 
Logic%% 
.%% 
RegisterPlayerAsync%% 2
(%%2 3
userProfile%%3 >
,%%> ?
password%%@ H
)%%H I
;%%I J
}&& 	
public(( 
async(( 
Task(( 
<(( 
OperationResultDto(( ,
>((, -
VerifyAccountAsync((. @
(((@ A
string((A G
email((H M
,((M N
string((O U
verificationCode((V f
)((f g
{)) 	
_log** 
.** 
Info** 
(** 
$"** 
$str** :
{**: ;
email**; @
}**@ A
"**A B
)**B C
;**C D
return++ 
await++ 
Logic++ 
.++ 
VerifyAccountAsync++ 1
(++1 2
email++2 7
,++7 8
verificationCode++9 I
)++I J
;++J K
},, 	
public.. 
async.. 
Task.. 
<.. 
OperationResultDto.. ,
>.., -
LoginAsGuestAsync... ?
(..? @
string..@ F
email..G L
,..L M
string..N T
code..U Y
)..Y Z
{// 	
_log00 
.00 
Info00 
(00 
$"00 
$str00 <
{00< =
code00= A
}00A B
"00B C
)00C D
;00D E
return11 
await11 
Logic11 
.11 
LoginAsGuestAsync11 0
(110 1
email111 6
,116 7
code118 <
)11< =
;11= >
}22 	
public44 
async44 
void44 
LogOut44  
(44  !
string44! '
username44( 0
)440 1
{55 	
await88 
Logic88 
.88 
LogOutAsync88 #
(88# $
username88$ ,
)88, -
;88- .
}99 	
public;; 
Task;; 
<;; 
OperationResultDto;; &
>;;& ')
SendPasswordRecoveryCodeAsync;;( E
(;;E F
string;;F L
email;;M R
);;R S
{<< 	
var== 
fault== 
=== 
new== 
ServiceFaultDto== +
(==+ ,
ServiceErrorType==, <
.==< =
OperationFailed=== L
,==L M
$str==N v
)==v w
;==w x
throw>> 
new>> 
FaultException>> $
<>>$ %
ServiceFaultDto>>% 4
>>>4 5
(>>5 6
fault>>6 ;
,>>; <
new>>= @
FaultReason>>A L
(>>L M
$str>>M ^
)>>^ _
)>>_ `
;>>` a
}?? 	
publicAA 
TaskAA 
<AA 
OperationResultDtoAA &
>AA& '&
ResetPasswordWithCodeAsyncAA( B
(AAB C
stringAAC I
emailAAJ O
,AAO P
stringAAQ W
codeAAX \
,AA\ ]
stringAA^ d
newPasswordAAe p
)AAp q
{BB 	
varCC 
faultCC 
=CC 
newCC 
ServiceFaultDtoCC +
(CC+ ,
ServiceErrorTypeCC, <
.CC< =
OperationFailedCC= L
,CCL M
$strCCN s
)CCs t
;CCt u
throwDD 
newDD 
FaultExceptionDD $
<DD$ %
ServiceFaultDtoDD% 4
>DD4 5
(DD5 6
faultDD6 ;
,DD; <
newDD= @
FaultReasonDDA L
(DDL M
$strDDM ^
)DD^ _
)DD_ `
;DD` a
}EE 	
}FF 
}GG ì?
êC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Services\LobbyService.cs
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
,I J
ConcurrencyModeK Z
=[ \
ConcurrencyMode] l
.l m
	Reentrantm v
)v w
]w x
public 

class 
LobbyService 
: 
ILobbyService  -
{ 
private 
static 
readonly 
ILog  $
_log% )
=* +

LogManager, 6
.6 7
	GetLogger7 @
(@ A
typeofA G
(G H
LobbyServiceH T
)T U
)U V
;V W
private 
string 
_connectedUsername )
;) *
private 
string 
_connectedMatchId (
;( )
private 

LobbyLogic 
Logic  
=>! #
Bootstrapper$ 0
.0 1
	Container1 :
.: ;
Resolve; B
<B C

LobbyLogicC M
>M N
(N O
)O P
;P Q
public 
LobbyService 
( 
) 
{ 	
Bootstrapper 
. 
Init 
( 
) 
;  $
SubscribeToChannelEvents $
($ %
)% &
;& '
} 	
public 
LobbyService 
( 

LobbyLogic &

lobbyLogic' 1
)1 2
{   	$
SubscribeToChannelEvents!! $
(!!$ %
)!!% &
;!!& '
}"" 	
private$$ 
void$$ $
SubscribeToChannelEvents$$ -
($$- .
)$$. /
{%% 	
IContextChannel&& 
channel&& #
=&&$ %
OperationContext&&& 6
.&&6 7
Current&&7 >
.&&> ?
Channel&&? F
;&&F G
channel'' 
.'' 
Faulted'' 
+='' #
Channel_FaultedOrClosed'' 6
;''6 7
channel(( 
.(( 
Closed(( 
+=(( #
Channel_FaultedOrClosed(( 5
;((5 6
})) 	
public++ 
async++ 
void++ 
ConnectToLobby++ (
(++( )
string++) /
username++0 8
,++8 9
string++: @
matchId++A H
)++H I
{,, 	
try-- 
{.. 
_connectedUsername// "
=//# $
username//% -
;//- .
_connectedMatchId00 !
=00" #
matchId00$ +
;00+ ,
_log11 
.11 
Info11 
(11 
$"11 
$str11 ;
{11; <
username11< D
}11D E
$str11E Q
{11Q R
matchId11R Y
}11Y Z
$str11Z \
"11\ ]
)11] ^
;11^ _
await22 
Logic22 
.22 
ConnectAsync22 (
(22( )
username22) 1
,221 2
matchId223 :
)22: ;
;22; <
}33 
catch44 
(44 
	Exception44 
ex44 
)44  
{44! "
_log44# '
.44' (
Error44( -
(44- .
$"44. 0
$str440 B
{44B C
username44C K
}44K L
$str44L M
"44M N
,44N O
ex44P R
)44R S
;44S T
}44U V
}55 	
public77 
void77 
SendLobbyMessage77 $
(77$ %
string77% +
senderUsername77, :
,77: ;
string77< B
matchId77C J
,77J K
string77L R
message77S Z
)77Z [
{88 	
if99 
(99 
ValidateSession99 
(99  
senderUsername99  .
,99. /
matchId990 7
)997 8
)998 9
Logic:: 
.:: 
SendMessage:: !
(::! "
senderUsername::" 0
,::0 1
matchId::2 9
,::9 :
message::; B
)::B C
;::C D
};; 	
public== 
void== 
	StartGame== 
(== 
string== $
hostUsername==% 1
,==1 2
string==3 9
matchId==: A
)==A B
{>> 	
if?? 
(?? 
ValidateSession?? 
(??  
hostUsername??  ,
,??, -
matchId??. 5
)??5 6
)??6 7
Logic@@ 
.@@ 
	StartGame@@ 
(@@  
hostUsername@@  ,
,@@, -
matchId@@. 5
)@@5 6
;@@6 7
}AA 	
publicCC 
voidCC 

LeaveLobbyCC 
(CC 
stringCC %
usernameCC& .
,CC. /
stringCC0 6
matchIdCC7 >
)CC> ?
{DD 	
ifEE 
(EE 
ValidateSessionEE 
(EE  
usernameEE  (
,EE( )
matchIdEE* 1
)EE1 2
)EE2 3
PerformDisconnectFF !
(FF! "
)FF" #
;FF# $
}GG 	
publicII 
voidII 

KickPlayerII 
(II 
stringII %
hostUsernameII& 2
,II2 3
stringII4 : 
playerToKickUsernameII; O
,IIO P
stringIIQ W
matchIdIIX _
)II_ `
{JJ 	
ifKK 
(KK 
ValidateSessionKK 
(KK  
hostUsernameKK  ,
,KK, -
matchIdKK. 5
)KK5 6
)KK6 7
LogicLL 
.LL 

KickPlayerLL  
(LL  !
hostUsernameLL! -
,LL- . 
playerToKickUsernameLL/ C
,LLC D
matchIdLLE L
)LLL M
;LLM N
}MM 	
publicOO 
voidOO 
StartKickVoteOO !
(OO! "
stringOO" (
vOO) *
,OO* +
stringOO, 2
tOO3 4
,OO4 5
stringOO6 <
mOO= >
)OO> ?
{OO@ A
}OOB C
publicPP 
voidPP 
SubmitKickVotePP "
(PP" #
stringPP# )
vPP* +
,PP+ ,
stringPP- 3
tPP4 5
,PP5 6
stringPP7 =
mPP> ?
,PP? @
boolPPA E
bPPF G
)PPG H
{PPI J
}PPK L
privateRR 
boolRR 
ValidateSessionRR $
(RR$ %
stringRR% +
usernameRR, 4
,RR4 5
stringRR6 <
matchIdRR= D
)RRD E
=>RRF H
_connectedUsernameRRI [
==RR\ ^
usernameRR_ g
&&RRh j
_connectedMatchIdRRk |
==RR} 
matchId
RRÄ á
;
RRá à
privateTT 
voidTT 
PerformDisconnectTT &
(TT& '
)TT' (
{UU 	
ifVV 
(VV 
!VV 
stringVV 
.VV 
IsNullOrEmptyVV %
(VV% &
_connectedUsernameVV& 8
)VV8 9
)VV9 :
{WW 
LogicYY 
.YY 

DisconnectYY  
(YY  !
_connectedUsernameYY! 3
,YY3 4
_connectedMatchIdYY5 F
)YYF G
;YYG H
_connectedUsernameZZ "
=ZZ# $
nullZZ% )
;ZZ) *
}[[ 
}\\ 	
private^^ 
void^^ #
Channel_FaultedOrClosed^^ ,
(^^, -
object^^- 3
sender^^4 :
,^^: ;
	EventArgs^^< E
e^^F G
)^^G H
{^^I J
PerformDisconnect^^K \
(^^\ ]
)^^] ^
;^^^ _
}^^` a
}__ 
}`` ü
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
} µ
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
]$$) *
[%% 
assembly%% 	
:%%	 

log4net%% 
.%% 
Config%% 
.%% 
XmlConfigurator%% )
(%%) *
Watch%%* /
=%%0 1
true%%2 6
)%%6 7
]%%7 8¢
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
} ë
°C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\DataAccess\Repositories\WordRepository.cs
	namespace 	
GuessMyMessServer
 
. 

DataAccess &
.& '
Repositories' 3
{		 
public

 

class

 
WordRepository

 
:

  !
IWordRepository

" 1
{ 
private 
readonly !
GuessMyMessDBEntities .
_context/ 7
;7 8
public 
WordRepository 
( !
GuessMyMessDBEntities 3
context4 ;
); <
{ 	
_context 
= 
context 
; 
} 	
public 
async 
Task 
< 
List 
< 
Word #
># $
>$ %
GetRandomWordsAsync& 9
(9 :
int: =
count> C
,C D
intE H
difficultyIdI U
)U V
{ 	
return 
await 
_context !
.! "
Word" &
. 
Where 
( 
w 
=> 
w 
. +
WordDifficulty_idWordDifficulty =
==> @
difficultyIdA M
)M N
. 
OrderBy 
( 
w 
=> 
Guid "
." #
NewGuid# *
(* +
)+ ,
), -
. 
Take 
( 
count 
) 
. 
ToListAsync 
( 
) 
; 
} 	
} 
} ∑R
£C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\DataAccess\Repositories\SocialRepository.cs
	namespace 	
GuessMyMessServer
 
. 

DataAccess &
.& '
Repositories' 3
{ 
public		 

class		 
SocialRepository		 !
:		" #
ISocialRepository		$ 5
{

 
private 
readonly !
GuessMyMessDBEntities .
_context/ 7
;7 8
public 
SocialRepository 
(  !
GuessMyMessDBEntities  5
context6 =
)= >
{ 	
_context 
= 
context 
; 
} 	
public 
async 
Task 
< 

Friendship $
>$ %
GetFriendshipAsync& 8
(8 9
int9 <
userId1= D
,D E
intF I
userId2J Q
)Q R
{ 	
return 
await 
_context !
.! "

Friendship" ,
. 
FirstOrDefaultAsync $
($ %
f% &
=>' )
( 
f 
. 
Player_idPlayer1 '
==( *
userId1+ 2
&&3 5
f6 7
.7 8
Player_idPlayer28 H
==I K
userId2L S
)S T
||U W
( 
f 
. 
Player_idPlayer1 '
==( *
userId2+ 2
&&3 5
f6 7
.7 8
Player_idPlayer28 H
==I K
userId1L S
)S T
)T U
;U V
} 	
public 
async 
Task 
< 
List 
< 

Friendship )
>) *
>* +
GetFriendsListAsync, ?
(? @
int@ C
userIdD J
)J K
{ 	
const 
int 
StatusAccepted $
=% &
$num' (
;( )
return 
await 
_context !
.! "

Friendship" ,
. 
Include 
( 
f 
=> 
f 
.  
Player  &
)& '
.   
Include   
(   
f   
=>   
f   
.    
Player1    '
)  ' (
.!! 
Where!! 
(!! 
f!! 
=>!! 
(!! 
f!! 
.!! 
Player_idPlayer1!! /
==!!0 2
userId!!3 9
||!!: <
f!!= >
.!!> ?
Player_idPlayer2!!? O
==!!P R
userId!!S Y
)!!Y Z
&&"" 
f""  
.""  !/
#FriendShipStatus_idFriendShipStatus""! D
==""E G
StatusAccepted""H V
)""V W
.## 
ToListAsync## 
(## 
)## 
;## 
}$$ 	
public&& 
async&& 
Task&& 
<&& 
bool&& 
>&& 
AreFriendsAsync&&  /
(&&/ 0
int&&0 3
userId1&&4 ;
,&&; <
int&&= @
userId2&&A H
)&&H I
{'' 	
const(( 
int(( 
StatusAccepted(( $
=((% &
$num((' (
;((( )
return** 
await** 
_context** !
.**! "

Friendship**" ,
.++ 
AnyAsync++ 
(++ 
f++ 
=>++ 
(,, 
(,, 
f,, 
.,, 
Player_idPlayer1,, (
==,,) +
userId1,,, 3
&&,,4 6
f,,7 8
.,,8 9
Player_idPlayer2,,9 I
==,,J L
userId2,,M T
),,T U
||,,V X
(-- 
f-- 
.-- 
Player_idPlayer1-- (
==--) +
userId2--, 3
&&--4 6
f--7 8
.--8 9
Player_idPlayer2--9 I
==--J L
userId1--M T
)--T U
)--U V
&&.. 
f.. 
... /
#FriendShipStatus_idFriendShipStatus.. <
==..= ?
StatusAccepted..@ N
)..N O
;..O P
}// 	
public11 
void11 
AddFriendship11 !
(11! "

Friendship11" ,

friendship11- 7
)117 8
{22 	
_context33 
.33 

Friendship33 
.33  
Add33  #
(33# $

friendship33$ .
)33. /
;33/ 0
}44 	
public66 
void66 
RemoveFriendship66 $
(66$ %

Friendship66% /

friendship660 :
)66: ;
{77 	
if88 
(88 

friendship88 
!=88 
null88 "
)88" #
{99 
_context:: 
.:: 

Friendship:: #
.::# $
Remove::$ *
(::* +

friendship::+ 5
)::5 6
;::6 7
};; 
}<< 	
public>> 
async>> 
Task>> 
<>> 
List>> 
<>> 

Friendship>> )
>>>) *
>>>* +#
GetPendingRequestsAsync>>, C
(>>C D
int>>D G
userId>>H N
)>>N O
{?? 	
constAA 
intAA 
StatusPendingAA #
=AA$ %
$numAA& '
;AA' (
returnFF 
awaitFF 
_contextFF !
.FF! "

FriendshipFF" ,
.GG 
IncludeGG 
(GG 
fGG 
=>GG 
fGG 
.GG  
PlayerGG  &
)GG& '
.HH 
WhereHH 
(HH 
fHH 
=>HH 
fHH 
.HH 
Player_idPlayer2HH .
==HH/ 1
userIdHH2 8
&&HH9 ;
fHH< =
.HH= >/
#FriendShipStatus_idFriendShipStatusHH> a
==HHb d
StatusPendingHHe r
)HHr s
.II 
ToListAsyncII 
(II 
)II 
;II 
}JJ 	
publicLL 
asyncLL 
TaskLL 
<LL 
intLL 
>LL 
SaveChangesAsyncLL /
(LL/ 0
)LL0 1
{MM 	
returnNN 
awaitNN 
_contextNN !
.NN! "
SaveChangesAsyncNN" 2
(NN2 3
)NN3 4
;NN4 5
}OO 	
publicQQ 
voidQQ 
AddDirectMessageQQ $
(QQ$ %
DirectMessagesQQ% 3
messageQQ4 ;
)QQ; <
{RR 	
_contextSS 
.SS 
DirectMessagesSS #
.SS# $
AddSS$ '
(SS' (
messageSS( /
)SS/ 0
;SS0 1
}TT 	
publicVV 
asyncVV 
TaskVV 
<VV 
ListVV 
<VV 
DirectMessagesVV -
>VV- .
>VV. /'
GetConversationHistoryAsyncVV0 K
(VVK L
intVVL O
userId1VVP W
,VVW X
intVVY \
userId2VV] d
)VVd e
{WW 	
returnXX 
awaitXX 
_contextXX !
.XX! "
DirectMessagesXX" 0
.YY 
AsNoTrackingYY 
(YY 
)YY 
.ZZ 
IncludeZZ 
(ZZ 
mZZ 
=>ZZ 
mZZ 
.ZZ  
PlayerZZ  &
)ZZ& '
.[[ 
Include[[ 
([[ 
m[[ 
=>[[ 
m[[ 
.[[  
Player1[[  '
)[[' (
.\\ 
Where\\ 
(\\ 
m\\ 
=>\\ 
(\\ 
m\\ 
.\\ 
SenderPlayerID\\ -
==\\. 0
userId1\\1 8
&&\\9 ;
m\\< =
.\\= >
RecipientPlayerID\\> O
==\\P R
userId2\\S Z
)\\Z [
||\\\ ^
(]] 
m]] 
.]] 
SenderPlayerID]] -
==]]. 0
userId2]]1 8
&&]]9 ;
m]]< =
.]]= >
RecipientPlayerID]]> O
==]]P R
userId1]]S Z
)]]Z [
)]][ \
.^^ 
OrderBy^^ 
(^^ 
m^^ 
=>^^ 
m^^ 
.^^  
	Timestamp^^  )
)^^) *
.__ 
ToListAsync__ 
(__ 
)__ 
;__ 
}`` 	
publicbb 
asyncbb 
Taskbb 
<bb 
Listbb 
<bb 
Playerbb %
>bb% &
>bb& ')
GetUsersWithConversationAsyncbb( E
(bbE F
intbbF I
userIdbbJ P
)bbP Q
{cc 	
varee 
counterpartIdsee 
=ee  
awaitee! &
_contextee' /
.ee/ 0
DirectMessagesee0 >
.ff 
Whereff 
(ff 
mff 
=>ff 
mff 
.ff 
SenderPlayerIDff ,
==ff- /
userIdff0 6
||ff7 9
mff: ;
.ff; <
RecipientPlayerIDff< M
==ffN P
userIdffQ W
)ffW X
.gg 
Selectgg 
(gg 
mgg 
=>gg 
mgg 
.gg 
SenderPlayerIDgg -
==gg. 0
userIdgg1 7
?gg8 9
mgg: ;
.gg; <
RecipientPlayerIDgg< M
:ggN O
mggP Q
.ggQ R
SenderPlayerIDggR `
)gg` a
.hh 
Distincthh 
(hh 
)hh 
.ii 
ToListAsyncii 
(ii 
)ii 
;ii 
returnll 
awaitll 
_contextll !
.ll! "
Playerll" (
.mm 
AsNoTrackingmm 
(mm 
)mm 
.nn 
Wherenn 
(nn 
pnn 
=>nn 
counterpartIdsnn *
.nn* +
Containsnn+ 3
(nn3 4
pnn4 5
.nn5 6
idPlayernn6 >
)nn> ?
)nn? @
.oo 
Includeoo 
(oo 
poo 
=>oo 
poo 
.oo  

UserStatusoo  *
)oo* +
.pp 
ToListAsyncpp 
(pp 
)pp 
;pp 
}qq 	
}rr 
}ss Å
™C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\DataAccess\Repositories\SocialNetworkRepository.cs
	namespace 	
GuessMyMessServer
 
. 

DataAccess &
.& '
Repositories' 3
{ 
public		 

class		 #
SocialNetworkRepository		 (
:		) *$
ISocialNetworkRepository		+ C
{

 
private 
readonly !
GuessMyMessDBEntities .
_context/ 7
;7 8
public #
SocialNetworkRepository &
(& '!
GuessMyMessDBEntities' <
context= D
)D E
{ 	
_context 
= 
context 
; 
} 	
public 
async 
Task 
< 
TypeSocialNetwork +
>+ ,
GetTypeByNameAsync- ?
(? @
string@ F
typeNameG O
)O P
{ 	
return 
await 
_context !
.! "
TypeSocialNetwork" 3
. 
FirstOrDefaultAsync $
($ %
t% &
=>' )
t* +
.+ ,
type, 0
==1 3
typeName4 <
)< =
;= >
} 	
public 
async 
Task 
< 
SocialNetwork '
>' ('
GetPlayerSocialNetworkAsync) D
(D E
intE H
playerIdI Q
,Q R
intS V
typeIdW ]
)] ^
{ 	
return 
await 
_context !
.! "
SocialNetwork" /
. 
FirstOrDefaultAsync $
($ %
s% &
=>' )
s* +
.+ ,
Player_idPlayer, ;
==< >
playerId? G
&&H J
s* +
.+ ,1
%TypeSocialNetwork_idTypeSocialNetwork, Q
==R T
typeIdU [
)[ \
;\ ]
} 	
public 
void 
AddSocialNetwork $
($ %
SocialNetwork% 2
socialNetwork3 @
)@ A
{   	
_context!! 
.!! 
SocialNetwork!! "
.!!" #
Add!!# &
(!!& '
socialNetwork!!' 4
)!!4 5
;!!5 6
}"" 	
public$$ 
async$$ 
Task$$ 
<$$ 
int$$ 
>$$ 
SaveChangesAsync$$ /
($$/ 0
)$$0 1
{%% 	
return&& 
await&& 
_context&& !
.&&! "
SaveChangesAsync&&" 2
(&&2 3
)&&3 4
;&&4 5
}'' 	
public)) 
async)) 
Task)) 
<)) 
List)) 
<)) 
SocialNetwork)) ,
>)), -
>))- ."
GetSocialNetworksAsync))/ E
())E F
int))F I
playerId))J R
)))R S
{** 	
return++ 
await++ 
_context++ !
.++! "
SocialNetwork++" /
.,, 
Include,, 
(,, 
s,, 
=>,, 
s,, 
.,,  
TypeSocialNetwork,,  1
),,1 2
.-- 
Where-- 
(-- 
s-- 
=>-- 
s-- 
.-- 
Player_idPlayer-- -
==--. 0
playerId--1 9
)--9 :
... 
ToListAsync.. 
(.. 
).. 
;.. 
}// 	
}00 
}11 ÚM
£C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\DataAccess\Repositories\PlayerRepository.cs
	namespace		 	
GuessMyMessServer		
 
.		 

DataAccess		 &
.		& '
Repositories		' 3
{

 
public 

class 
PlayerRepository !
:" #
IPlayerRepository$ 5
{ 
private 
readonly !
GuessMyMessDBEntities .
_context/ 7
;7 8
public 
PlayerRepository 
(  !
GuessMyMessDBEntities  5
context6 =
)= >
{ 	
_context 
= 
context 
; 
} 	
public 
async 
Task 
< 
Player  
>  !$
GetPlayerByUsernameAsync" :
(: ;
string; A
usernameB J
)J K
{ 	
if 
( 
string 
. 
IsNullOrWhiteSpace )
() *
username* 2
)2 3
)3 4
{ 
return 
null 
; 
} 
return 
await 
_context !
.! "
Player" (
. 
FirstOrDefaultAsync $
($ %
p% &
=>' )
p* +
.+ ,
username, 4
==5 7
username8 @
)@ A
;A B
} 	
public 
async 
Task 
< 
Player  
>  !!
GetPlayerByEmailAsync" 7
(7 8
string8 >
email? D
)D E
{   	
if!! 
(!! 
string!! 
.!! 
IsNullOrWhiteSpace!! )
(!!) *
email!!* /
)!!/ 0
)!!0 1
{"" 
return## 
null## 
;## 
}$$ 
return&& 
await&& 
_context&& !
.&&! "
Player&&" (
.'' 
FirstOrDefaultAsync'' $
(''$ %
p''% &
=>''' )
p''* +
.''+ ,
email'', 1
==''2 4
email''5 :
)'': ;
;''; <
}(( 	
public** 
void** 
	AddPlayer** 
(** 
Player** $
player**% +
)**+ ,
{++ 	
if,, 
(,, 
player,, 
==,, 
null,, 
),, 
{-- 
throw.. 
new.. !
ArgumentNullException.. /
(../ 0
nameof..0 6
(..6 7
player..7 =
)..= >
)..> ?
;..? @
}// 
_context00 
.00 
Player00 
.00 
Add00 
(00  
player00  &
)00& '
;00' (
}11 	
public33 
async33 
Task33 
<33 
int33 
>33 
SaveChangesAsync33 /
(33/ 0
)330 1
{44 	
return55 
await55 
_context55 !
.55! "
SaveChangesAsync55" 2
(552 3
)553 4
;554 5
}66 	
public88 
async88 
Task88 
<88 
Player88  
>88  !%
GetPlayerProfileDataAsync88" ;
(88; <
string88< B
username88C K
)88K L
{99 	
if:: 
(:: 
string:: 
.:: 
IsNullOrWhiteSpace:: )
(::) *
username::* 2
)::2 3
)::3 4
return::5 ;
null::< @
;::@ A
return<< 
await<< 
_context<< !
.<<! "
Player<<" (
.== 
AsNoTracking== 
(== 
)== 
.>> 
Include>> 
(>> 
p>> 
=>>> 
p>> 
.>>  
Gender>>  &
)>>& '
.?? 
Include?? 
(?? 
p?? 
=>?? 
p?? 
.??  
Avatar??  &
)??& '
.@@ 
Include@@ 
(@@ 
p@@ 
=>@@ 
p@@ 
.@@  
SocialNetwork@@  -
.@@- .
Select@@. 4
(@@4 5
sn@@5 7
=>@@8 :
sn@@; =
.@@= >
TypeSocialNetwork@@> O
)@@O P
)@@P Q
.AA 
FirstOrDefaultAsyncAA $
(AA$ %
pAA% &
=>AA' )
pAA* +
.AA+ ,
usernameAA, 4
==AA5 7
usernameAA8 @
)AA@ A
;AAA B
}BB 	
publicDD 
asyncDD 
TaskDD 
<DD 
ListDD 
<DD 
PlayerDD %
>DD% &
>DD& '(
SearchPlayersNotFriendsAsyncDD( D
(DDD E
stringDDE K

searchTextDDL V
,DDV W
intDDX [
requesterIdDD\ g
)DDg h
{EE 	
varFF 
	friendIdsFF 
=FF 
awaitFF !
_contextFF" *
.FF* +

FriendshipFF+ 5
.GG 
WhereGG 
(GG 
fGG 
=>GG 
fGG 
.GG 
Player_idPlayer1GG .
==GG/ 1
requesterIdGG2 =
||GG> @
fGGA B
.GGB C
Player_idPlayer2GGC S
==GGT V
requesterIdGGW b
)GGb c
.HH 
SelectHH 
(HH 
fHH 
=>HH 
fHH 
.HH 
Player_idPlayer1HH /
==HH0 2
requesterIdHH3 >
?HH? @
fHHA B
.HHB C
Player_idPlayer2HHC S
:HHT U
fHHV W
.HHW X
Player_idPlayer1HHX h
)HHh i
.II 
DistinctII 
(II 
)II 
.JJ 
ToListAsyncJJ 
(JJ 
)JJ 
;JJ 
	friendIdsLL 
.LL 
AddLL 
(LL 
requesterIdLL %
)LL% &
;LL& '
returnNN 
awaitNN 
_contextNN !
.NN! "
PlayerNN" (
.OO 
AsNoTrackingOO 
(OO 
)OO 
.PP 
WherePP 
(PP 
pPP 
=>PP 
pPP 
.PP 
usernamePP &
.PP& '
ContainsPP' /
(PP/ 0

searchTextPP0 :
)PP: ;
&&PP< >
!QQ 
	friendIdsQQ &
.QQ& '
ContainsQQ' /
(QQ/ 0
pQQ0 1
.QQ1 2
idPlayerQQ2 :
)QQ: ;
)QQ; <
.RR 
ToListAsyncRR 
(RR 
)RR 
;RR 
}SS 	
publicUU 
asyncUU 
TaskUU 
<UU 
intUU 
?UU 
>UU  
GetUserStatusIdAsyncUU  4
(UU4 5
stringUU5 ;

statusNameUU< F
)UUF G
{VV 	
varWW 
statusWW 
=WW 
awaitWW 
_contextWW '
.WW' (

UserStatusWW( 2
.WW2 3
FirstOrDefaultAsyncWW3 F
(WWF G
sWWG H
=>WWI K
sWWL M
.WWM N
statusWWN T
==WWU W

statusNameWWX b
)WWb c
;WWc d
returnXX 
statusXX 
?XX 
.XX 
idUserStatusXX '
;XX' (
}YY 	
public[[ 
async[[ 
Task[[ 
<[[ 
List[[ 
<[[ 
PlayerScoreDto[[ -
>[[- .
>[[. /!
GetGlobalRankingAsync[[0 E
([[E F
)[[F G
{\\ 	
var]] 
rawData]] 
=]] 
await]] 
_context]]  (
.]]( )
Player]]) /
.^^ 
	GroupJoin^^ 
(^^ 
_context__ 
.__ 
MatchHistory__ )
,__) *
player`` 
=>`` 
player`` $
.``$ %
idPlayer``% -
,``- .
matchaa 
=>aa 
matchaa "
.aa" #
Player_idPlayeraa# 2
,aa2 3
(bb 
playerbb 
,bb 
matchesbb $
)bb$ %
=>bb& (
newbb) ,
{cc 
Usernamedd  
=dd! "
playerdd# )
.dd) *
usernamedd* 2
,dd2 3

TotalScoreee "
=ee# $
matchesee% ,
.ee, -
Sumee- 0
(ee0 1
mee1 2
=>ee3 5
(ee6 7
intee7 :
?ee: ;
)ee; <
mee< =
.ee= >

finalScoreee> H
)eeH I
??eeJ L
$numeeM N
}ff 
)gg 
.hh 
OrderByDescendinghh "
(hh" #
xhh# $
=>hh% '
xhh( )
.hh) *

TotalScorehh* 4
)hh4 5
.ii 
ToListAsyncii 
(ii 
)ii 
;ii 
varkk 
rankingListkk 
=kk 
rawDatakk %
.kk% &
Selectkk& ,
(kk, -
(kk- .
itemkk. 2
,kk2 3
indexkk4 9
)kk9 :
=>kk; =
newkk> A
PlayerScoreDtokkB P
{ll 
Rankmm 
=mm 
indexmm 
+mm 
$nummm  
,mm  !
Usernamenn 
=nn 
itemnn 
.nn  
Usernamenn  (
,nn( )
Scoreoo 
=oo 
itemoo 
.oo 

TotalScoreoo '
}pp 
)pp 
.pp 
ToListpp 
(pp 
)pp 
;pp 
returnrr 
rankingListrr 
;rr 
}ss 	
}tt 
}uu ˙G
¢C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\DataAccess\Repositories\MatchRepository.cs
	namespace 	
GuessMyMessServer
 
. 

DataAccess &
.& '
Repositories' 3
{ 
public		 

class		 
MatchRepository		  
:		! "
IMatchRepository		# 3
{

 
private 
readonly !
GuessMyMessDBEntities .
_context/ 7
;7 8
public 
MatchRepository 
( !
GuessMyMessDBEntities 4
context5 <
)< =
{ 	
_context 
= 
context 
; 
} 	
public 
async 
Task 
< 
Match 
>  
GetMatchByIdAsync! 2
(2 3
int3 6
matchId7 >
)> ?
{ 	
return 
await 
_context !
.! "
Match" '
.' (
	FindAsync( 1
(1 2
matchId2 9
)9 :
;: ;
} 	
public 
async 
Task 
< 
Match 
>  
GetMatchByCodeAsync! 4
(4 5
string5 ;
code< @
)@ A
{ 	
return 
await 
_context !
.! "
Match" '
.' (
FirstOrDefaultAsync( ;
(; <
m< =
=>> @
mA B
.B C
	matchCodeC L
==M O
codeP T
)T U
;U V
} 	
public 
async 
Task 
< 
Match 
>  !
GetMatchByPlayerAsync! 6
(6 7
string7 =
username> F
)F G
{ 	
var!! 
activeHistory!! 
=!! 
await!!  %
_context!!& .
.!!. /
MatchHistory!!/ ;
."" 
Include"" 
("" 
h"" 
=>"" 
h"" 
.""  
Match""  %
)""% &
.## 
Include## 
(## 
h## 
=>## 
h## 
.##  
Player##  &
)##& '
.$$ 
Where$$ 
($$ 
h$$ 
=>$$ 
h$$ 
.$$ 
Player$$ $
.$$$ %
username$$% -
==$$. 0
username$$1 9
)$$9 :
.%% 
OrderByDescending%% "
(%%" #
h%%# $
=>%%% '
h%%( )
.%%) *
idMatchHistory%%* 8
)%%8 9
.&& 
FirstOrDefaultAsync&& $
(&&$ %
)&&% &
;&&& '
return)) 
activeHistory))  
?))  !
.))! "
Match))" '
;))' (
}** 	
public,, 
async,, 
Task,, 
<,, 
bool,, 
>,,  
MatchCodeExistsAsync,,  4
(,,4 5
string,,5 ;
code,,< @
),,@ A
{-- 	
return// 
await// 
_context// !
.//! "
Match//" '
.//' (
AnyAsync//( 0
(//0 1
m//1 2
=>//3 5
m//6 7
.//7 8
	matchCode//8 A
==//B D
code//E I
&&//J L
m//M N
.//N O
matchStatus//O Z
==//[ ]
$str//^ g
)//g h
;//h i
}00 	
public22 
async22 
Task22 
<22 
string22  
>22  !"
GetDifficultyNameAsync22" 8
(228 9
int229 <
difficultyId22= I
)22I J
{33 	
var44 
diff44 
=44 
await44 
_context44 %
.44% &
MatchDifficulty44& 5
.445 6
	FindAsync446 ?
(44? @
difficultyId44@ L
)44L M
;44M N
return55 
diff55 
?55 
.55 

difficulty55 #
??55$ &
$str55' 0
;550 1
}66 	
public88 
async88 
Task88 
<88 
List88 
<88 
Match88 $
>88$ %
>88% &(
GetPublicWaitingMatchesAsync88' C
(88C D
)88D E
{99 	
return;; 
await;; 
_context;; !
.;;! "
Match;;" '
.<< 
Where<< 
(<< 
m<< 
=><< 
m<< 
.<< 
	isPrivate<< '
==<<( *
$num<<+ ,
&&<<- /
m<<0 1
.<<1 2
matchStatus<<2 =
==<<> @
$str<<A J
)<<J K
.== 
ToListAsync== 
(== 
)== 
;== 
}>> 	
public@@ 
void@@ 
AddMatch@@ 
(@@ 
Match@@ "
match@@# (
)@@( )
{AA 	
_contextBB 
.BB 
MatchBB 
.BB 
AddBB 
(BB 
matchBB $
)BB$ %
;BB% &
}CC 	
publicEE 
asyncEE 
TaskEE 
<EE 
intEE 
>EE 
SaveChangesAsyncEE /
(EE/ 0
)EE0 1
{FF 	
returnGG 
awaitGG 
_contextGG !
.GG! "
SaveChangesAsyncGG" 2
(GG2 3
)GG3 4
;GG4 5
}HH 	
publicJJ 
asyncJJ 
TaskJJ 
<JJ 
boolJJ 
>JJ 
IsMatchPrivateAsyncJJ  3
(JJ3 4
intJJ4 7
matchIdJJ8 ?
)JJ? @
{KK 	
varLL 
matchLL 
=LL 
awaitLL 
_contextLL &
.LL& '
MatchLL' ,
.MM 
SelectMM 
(MM 
mMM 
=>MM 
newMM  
{MM! "
mMM# $
.MM$ %
idMatchMM% ,
,MM, -
mMM. /
.MM/ 0
	isPrivateMM0 9
}MM: ;
)MM; <
.NN 
FirstOrDefaultAsyncNN $
(NN$ %
mNN% &
=>NN' )
mNN* +
.NN+ ,
idMatchNN, 3
==NN4 6
matchIdNN7 >
)NN> ?
;NN? @
returnRR 
matchRR 
!=RR 
nullRR  
&&RR! #
matchRR$ )
.RR) *
	isPrivateRR* 3
==RR4 6
$numRR7 8
;RR8 9
}SS 	
publicUU 
asyncUU 
TaskUU 
<UU 
boolUU 
>UU (
PlayerHasHistoryInMatchAsyncUU  <
(UU< =
intUU= @
matchIdUUA H
,UUH I
intUUJ M
playerIdUUN V
)UUV W
{VV 	
returnWW 
awaitWW 
_contextWW !
.WW! "
MatchHistoryWW" .
.WW. /
AnyAsyncWW/ 7
(WW7 8
hWW8 9
=>WW: <
hWW= >
.WW> ?
Match_idMatchWW? L
==WWM O
matchIdWWP W
&&WWX Z
hWW[ \
.WW\ ]
Player_idPlayerWW] l
==WWm o
playerIdWWp x
)WWx y
;WWy z
}XX 	
publicZZ 
voidZZ 
AddMatchHistoryZZ #
(ZZ# $
MatchHistoryZZ$ 0
historyZZ1 8
)ZZ8 9
{[[ 	
_context\\ 
.\\ 
MatchHistory\\ !
.\\! "
Add\\" %
(\\% &
history\\& -
)\\- .
;\\. /
}]] 	
public__ 
async__ 
Task__ 
<__ 
List__ 
<__ 
MatchHistory__ +
>__+ ,
>__, -)
GetMatchHistoryByMatchIdAsync__. K
(__K L
int__L O
matchId__P W
)__W X
{`` 	
returnaa 
awaitaa 
_contextaa !
.aa! "
MatchHistoryaa" .
.bb 
Wherebb 
(bb 
hbb 
=>bb 
hbb 
.bb 
Match_idMatchbb +
==bb, .
matchIdbb/ 6
)bb6 7
.cc 
ToListAsynccc 
(cc 
)cc 
;cc 
}dd 	
publicff 
asyncff 
Taskff 
<ff 
MatchHistoryff &
>ff& '%
GetMatchHistoryEntryAsyncff( A
(ffA B
intffB E
matchIdffF M
,ffM N
intffO R
playerIdffS [
)ff[ \
{gg 	
returnhh 
awaithh 
_contexthh !
.hh! "
MatchHistoryhh" .
.ii 
FirstOrDefaultAsyncii $
(ii$ %
hii% &
=>ii' )
hii* +
.ii+ ,
Match_idMatchii, 9
==ii: <
matchIdii= D
&&iiE G
hiiH I
.iiI J
Player_idPlayeriiJ Y
==iiZ \
playerIdii] e
)iie f
;iif g
}jj 	
}kk 
}ll ’
£C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\DataAccess\Repositories\AvatarRepository.cs
	namespace 	
GuessMyMessServer
 
. 

DataAccess &
.& '
Repositories' 3
{ 
public 

class 
AvatarRepository !
:" #
IAvatarRepository$ 5
{		 
private

 
readonly

 !
GuessMyMessDBEntities

 .
_context

/ 7
;

7 8
public 
AvatarRepository 
(  !
GuessMyMessDBEntities  5
context6 =
)= >
{ 	
_context 
= 
context 
; 
} 	
public 
async 
Task 
< 
List 
< 
Avatar %
>% &
>& '
GetAllAvatarsAsync( :
(: ;
); <
{ 	
return 
await 
_context !
.! "
Avatar" (
.( )
AsNoTracking) 5
(5 6
)6 7
.7 8
ToListAsync8 C
(C D
)D E
;E F
} 	
public 
async 
Task 
< 
Avatar  
>  !
GetAvatarByIdAsync" 4
(4 5
int5 8
id9 ;
); <
{ 	
return 
await 
_context !
.! "
Avatar" (
.( )
	FindAsync) 2
(2 3
id3 5
)5 6
;6 7
} 	
} 
} «
¢C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\DataAccess\Abstractions\IWordRepository.cs
	namespace 	
GuessMyMessServer
 
. 

DataAccess &
.& '
Abstractions' 3
{ 
public 

	interface 
IWordRepository $
{ 
Task		 
<		 
List		 
<		 
Word		 
>		 
>		 
GetRandomWordsAsync		 ,
(		, -
int		- 0
count		1 6
,		6 7
int		8 ;
difficultyId		< H
)		H I
;		I J
}

 
} ≠
§C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\DataAccess\Abstractions\ISocialRepository.cs
	namespace 	
GuessMyMessServer
 
. 

DataAccess &
.& '
Abstractions' 3
{ 
public 

	interface 
ISocialRepository &
{ 
Task		 
<		 

Friendship		 
>		 
GetFriendshipAsync		 +
(		+ ,
int		, /
userId1		0 7
,		7 8
int		9 <
userId2		= D
)		D E
;		E F
Task

 
<

 
List

 
<

 

Friendship

 
>

 
>

 
GetFriendsListAsync

 2
(

2 3
int

3 6
userId

7 =
)

= >
;

> ?
Task 
< 
bool 
> 
AreFriendsAsync "
(" #
int# &
userId1' .
,. /
int0 3
userId24 ;
); <
;< =
void 
AddFriendship 
( 

Friendship %

friendship& 0
)0 1
;1 2
void 
RemoveFriendship 
( 

Friendship (

friendship) 3
)3 4
;4 5
Task 
< 
List 
< 

Friendship 
> 
> #
GetPendingRequestsAsync 6
(6 7
int7 :
userId; A
)A B
;B C
Task 
< 
int 
> 
SaveChangesAsync "
(" #
)# $
;$ %
void 
AddDirectMessage 
( 
DirectMessages ,
message- 4
)4 5
;5 6
Task 
< 
List 
< 
DirectMessages  
>  !
>! "'
GetConversationHistoryAsync# >
(> ?
int? B
userId1C J
,J K
intL O
userId2P W
)W X
;X Y
Task 
< 
List 
< 
Player 
> 
> )
GetUsersWithConversationAsync 8
(8 9
int9 <
userId= C
)C D
;D E
} 
} è
´C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\DataAccess\Abstractions\ISocialNetworkRepository.cs
	namespace 	
GuessMyMessServer
 
. 

DataAccess &
.& '
Abstractions' 3
{ 
public 

	interface $
ISocialNetworkRepository -
{ 
Task		 
<		 
TypeSocialNetwork		 
>		 
GetTypeByNameAsync		  2
(		2 3
string		3 9
typeName		: B
)		B C
;		C D
Task

 
<

 
SocialNetwork

 
>

 '
GetPlayerSocialNetworkAsync

 7
(

7 8
int

8 ;
playerId

< D
,

D E
int

F I
typeId

J P
)

P Q
;

Q R
void 
AddSocialNetwork 
( 
SocialNetwork +
socialNetwork, 9
)9 :
;: ;
Task 
< 
int 
> 
SaveChangesAsync "
(" #
)# $
;$ %
Task 
< 
List 
< 
SocialNetwork 
>  
>  !"
GetSocialNetworksAsync" 8
(8 9
int9 <
playerId= E
)E F
;F G
} 
} º
§C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\DataAccess\Abstractions\IPlayerRepository.cs
	namespace 	
GuessMyMessServer
 
. 

DataAccess &
.& '
Abstractions' 3
{ 
public 

	interface 
IPlayerRepository &
{		 
Task

 
<

 
Player

 
>

 $
GetPlayerByUsernameAsync

 -
(

- .
string

. 4
username

5 =
)

= >
;

> ?
Task 
< 
Player 
> !
GetPlayerByEmailAsync *
(* +
string+ 1
email2 7
)7 8
;8 9
void 
	AddPlayer 
( 
Player 
player $
)$ %
;% &
Task 
< 
int 
> 
SaveChangesAsync "
(" #
)# $
;$ %
Task 
< 
Player 
> %
GetPlayerProfileDataAsync .
(. /
string/ 5
username6 >
)> ?
;? @
Task 
< 
List 
< 
Player 
> 
> (
SearchPlayersNotFriendsAsync 7
(7 8
string8 >

searchText? I
,I J
intK N
requesterIdO Z
)Z [
;[ \
Task 
< 
int 
? 
>  
GetUserStatusIdAsync '
(' (
string( .

statusName/ 9
)9 :
;: ;
Task 
< 
List 
< 
PlayerScoreDto  
>  !
>! "!
GetGlobalRankingAsync# 8
(8 9
)9 :
;: ;
} 
} ƒ
£C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\DataAccess\Abstractions\IMatchRepository.cs
	namespace 	
GuessMyMessServer
 
. 

DataAccess &
.& '
Abstractions' 3
{ 
public 

	interface 
IMatchRepository %
{ 
Task		 
<		 
Match		 
>		 
GetMatchByIdAsync		 %
(		% &
int		& )
matchId		* 1
)		1 2
;		2 3
void

 
AddMatch

 
(

 
Match

 
match

 !
)

! "
;

" #
Task 
< 
int 
> 
SaveChangesAsync "
(" #
)# $
;$ %
Task 
< 
Match 
> 
GetMatchByCodeAsync '
(' (
string( .
code/ 3
)3 4
;4 5
Task 
< 
Match 
> !
GetMatchByPlayerAsync )
() *
string* 0
username1 9
)9 :
;: ;
Task 
< 
bool 
>  
MatchCodeExistsAsync '
(' (
string( .
code/ 3
)3 4
;4 5
Task 
< 
string 
> "
GetDifficultyNameAsync +
(+ ,
int, /
difficultyId0 <
)< =
;= >
Task 
< 
List 
< 
Match 
> 
> (
GetPublicWaitingMatchesAsync 6
(6 7
)7 8
;8 9
Task 
< 
bool 
> 
IsMatchPrivateAsync &
(& '
int' *
matchId+ 2
)2 3
;3 4
Task 
< 
bool 
> (
PlayerHasHistoryInMatchAsync /
(/ 0
int0 3
matchId4 ;
,; <
int= @
playerIdA I
)I J
;J K
void 
AddMatchHistory 
( 
MatchHistory )
history* 1
)1 2
;2 3
Task 
< 
List 
< 
MatchHistory 
> 
>  )
GetMatchHistoryByMatchIdAsync! >
(> ?
int? B
matchIdC J
)J K
;K L
Task 
< 
MatchHistory 
> %
GetMatchHistoryEntryAsync 4
(4 5
int5 8
matchId9 @
,@ A
intB E
playerIdF N
)N O
;O P
} 
} †
§C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\DataAccess\Abstractions\IAvatarRepository.cs
	namespace 	
GuessMyMessServer
 
. 

DataAccess &
.& '
Abstractions' 3
{ 
public 

	interface 
IAvatarRepository &
{ 
Task		 
<		 
List		 
<		 
Avatar		 
>		 
>		 
GetAllAvatarsAsync		 -
(		- .
)		. /
;		/ 0
Task

 
<

 
Avatar

 
>

 
GetAvatarByIdAsync

 '
(

' (
int

( +
id

, .
)

. /
;

/ 0
} 
} ô%
©C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\ServiceContracts\IUserProfileService.cs
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
] 
public		 

	interface		 
IUserProfileService		 (
{

 
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
ServiceFaultDto -
)- .
). /
]/ 0
Task 
< 
UserProfileDto 
> 
GetUserProfileAsync 0
(0 1
string1 7
username8 @
)@ A
;A B
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
ServiceFaultDto -
)- .
). /
]/ 0
Task 
< 
OperationResultDto 
>  
UpdateProfileAsync! 3
(3 4
string4 :
username; C
,C D
UserProfileDtoE S
profileDataT _
)_ `
;` a
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
ServiceFaultDto -
)- .
). /
]/ 0
Task 
< 
OperationResultDto 
>  )
AddOrUpdateSocialNetworkAsync! >
(> ?
string? E
usernameF N
,N O
SocialNetworkDtoP `
socialNetworka n
)n o
;o p
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
ServiceFaultDto -
)- .
). /
]/ 0
Task 
< 
OperationResultDto 
>  #
RequestChangeEmailAsync! 8
(8 9
string9 ?
username@ H
,H I
stringJ P
newEmailQ Y
)Y Z
;Z [
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
ServiceFaultDto -
)- .
). /
]/ 0
Task 
< 
OperationResultDto 
>  #
ConfirmChangeEmailAsync! 8
(8 9
string9 ?
username@ H
,H I
stringJ P
verificationCodeQ a
)a b
;b c
[ 	
OperationContract	 
] 
[   	
FaultContract  	 
(   
typeof   
(   
ServiceFaultDto   -
)  - .
)  . /
]  / 0
Task!! 
<!! 
OperationResultDto!! 
>!!  &
RequestChangePasswordAsync!!! ;
(!!; <
string!!< B
username!!C K
)!!K L
;!!L M
[## 	
OperationContract##	 
]## 
[$$ 	
FaultContract$$	 
($$ 
typeof$$ 
($$ 
ServiceFaultDto$$ -
)$$- .
)$$. /
]$$/ 0
Task%% 
<%% 
OperationResultDto%% 
>%%  &
ConfirmChangePasswordAsync%%! ;
(%%; <
string%%< B
username%%C K
,%%K L
string%%M S
newPassword%%T _
,%%_ `
string%%a g
verificationCode%%h x
)%%x y
;%%y z
['' 	
OperationContract''	 
]'' 
[(( 	
FaultContract((	 
((( 
typeof(( 
((( 
ServiceFaultDto(( -
)((- .
)((. /
]((/ 0
Task)) 
<)) 
List)) 
<)) 
	AvatarDto)) 
>)) 
>)) $
GetAvailableAvatarsAsync)) 6
())6 7
)))7 8
;))8 9
[++ 	
OperationContract++	 
]++ 
[,, 	
FaultContract,,	 
(,, 
typeof,, 
(,, 
ServiceFaultDto,, -
),,- .
),,. /
],,/ 0
Task-- 
<-- 
List-- 
<-- 
PlayerScoreDto--  
>--  !
>--! "!
GetGlobalRankingAsync--# 8
(--8 9
)--9 :
;--: ;
}.. 
}// â)
£C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\ServiceContracts\ILobbyService.cs
	namespace 	
GuessMyMessServer
 
. 
	Contracts %
.% &
ServiceContracts& 6
{ 
[ 
ServiceContract 
( 
CallbackContract %
=& '
typeof( .
(. /!
ILobbyServiceCallback/ D
)D E
)E F
]F G
public 

	interface 
ILobbyService "
{ 
[		 	
OperationContract			 
(		 
IsOneWay		 #
=		$ %
true		& *
)		* +
]		+ ,
void

 
ConnectToLobby

 
(

 
string

 "
username

# +
,

+ ,
string

- 3
matchId

4 ;
)

; <
;

< =
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
SendLobbyMessage 
( 
string $
senderUsername% 3
,3 4
string5 ;
matchId< C
,C D
stringE K
messageL S
)S T
;T U
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
	StartGame 
( 
string 
hostUsername *
,* +
string, 2
matchId3 :
): ;
;; <
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 

LeaveLobby 
( 
string 
username '
,' (
string) /
matchId0 7
)7 8
;8 9
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 

KickPlayer 
( 
string 
hostUsername +
,+ ,
string- 3 
playerToKickUsername4 H
,H I
stringJ P
matchIdQ X
)X Y
;Y Z
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
StartKickVote 
( 
string !
voterUsername" /
,/ 0
string1 7
targetUsername8 F
,F G
stringH N
matchIdO V
)V W
;W X
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
SubmitKickVote 
( 
string "
voterUsername# 0
,0 1
string2 8
targetUsername9 G
,G H
stringI O
matchIdP W
,W X
boolY ]
vote^ b
)b c
;c d
} 
[ 
ServiceContract 
] 
public   

	interface   !
ILobbyServiceCallback   *
{!! 
["" 	
OperationContract""	 
("" 
IsOneWay"" #
=""$ %
true""& *
)""* +
]""+ ,
void## 
UpdateLobbyState## 
(## 
LobbyStateDto## +
lobbyStateDto##, 9
)##9 :
;##: ;
[%% 	
OperationContract%%	 
(%% 
IsOneWay%% #
=%%$ %
true%%& *
)%%* +
]%%+ ,
void&& 
ReceiveLobbyMessage&&  
(&&  !
ChatMessageDto&&! /

messageDto&&0 :
)&&: ;
;&&; <
[(( 	
OperationContract((	 
((( 
IsOneWay(( #
=(($ %
true((& *
)((* +
]((+ ,
void)) 
OnGameStarting)) 
()) 
int)) 
countdownSeconds))  0
)))0 1
;))1 2
[++ 	
OperationContract++	 
(++ 
IsOneWay++ #
=++$ %
true++& *
)++* +
]+++ ,
void,, 
OnGameStarted,, 
(,, 
),, 
;,, 
[.. 	
OperationContract..	 
(.. 
IsOneWay.. #
=..$ %
true..& *
)..* +
]..+ ,
void// 
KickedFromLobby// 
(// 
string// #
reason//$ *
)//* +
;//+ ,
[11 	
OperationContract11	 
(11 
IsOneWay11 #
=11$ %
true11& *
)11* +
]11+ ,
void22 
UpdateKickVote22 
(22 
string22 "
targetUsername22# 1
,221 2
int223 6
currentVotes227 C
,22C D
int22E H
votesNeeded22I T
)22T U
;22U V
}33 
}44 ˇ=
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
( 
ServiceFaultDto -
)- .
). /
]/ 0
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
( 
ServiceFaultDto -
)- .
). /
]/ 0
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
( 
ServiceFaultDto -
)- .
). /
]/ 0
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
]   
[!! 	
FaultContract!!	 
(!! 
typeof!! 
(!! 
ServiceFaultDto!! -
)!!- .
)!!. /
]!!/ 0
Task"" 
<"" 
OperationResultDto"" 
>""  
RemoveFriendAsync""! 2
(""2 3
string""3 9
username"": B
,""B C
string""D J
friendToRemove""K Y
)""Y Z
;""Z [
[$$ 	
OperationContract$$	 
]$$ 
[%% 	
FaultContract%%	 
(%% 
typeof%% 
(%% 
ServiceFaultDto%% -
)%%- .
)%%. /
]%%/ 0
Task&& 
<&& 
OperationResultDto&& 
>&&  *
InviteFriendToGameByEmailAsync&&! ?
(&&? @
string&&@ F
fromUsername&&G S
,&&S T
string&&U [
friendEmail&&\ g
,&&g h
string&&i o
	matchCode&&p y
)&&y z
;&&z {
[(( 	
OperationContract((	 
](( 
Task)) 
<)) 
DirectMessageDto)) 
>)) "
SendDirectMessageAsync)) 5
())5 6
DirectMessageDto))6 F
message))G N
)))N O
;))O P
[++ 	
OperationContract++	 
]++ 
[,, 	
FaultContract,,	 
(,, 
typeof,, 
(,, 
ServiceFaultDto,, -
),,- .
),,. /
],,/ 0
Task-- 
<-- 
List-- 
<-- 
	FriendDto-- 
>-- 
>-- !
GetConversationsAsync-- 3
(--3 4
string--4 :
username--; C
)--C D
;--D E
[// 	
OperationContract//	 
]// 
[00 	
FaultContract00	 
(00 
typeof00 
(00 
ServiceFaultDto00 -
)00- .
)00. /
]00/ 0
Task11 
<11 
List11 
<11 
DirectMessageDto11 "
>11" #
>11# $'
GetConversationHistoryAsync11% @
(11@ A
string11A G
user111H M
,11M N
string11O U
user211V [
)11[ \
;11\ ]
[33 	
OperationContract33	 
(33 
IsOneWay33 #
=33$ %
true33& *
)33* +
]33+ ,
void44 

Disconnect44 
(44 
string44 
username44 '
)44' (
;44( )
[66 	
OperationContract66	 
]66 
[77 	
FaultContract77	 
(77 
typeof77 
(77 
ServiceFaultDto77 -
)77- .
)77. /
]77/ 0
Task88 
<88 
FriendProfileDto88 
>88 !
GetFriendProfileAsync88 4
(884 5
string885 ;
username88< D
)88D E
;88E F
}99 
[;; 
ServiceContract;; 
];; 
public<< 

	interface<< "
ISocialServiceCallback<< +
{== 
[>> 	
OperationContract>>	 
(>> 
IsOneWay>> #
=>>$ %
true>>& *
)>>* +
]>>+ ,
void?? 
NotifyFriendRequest??  
(??  !
string??! '
fromUsername??( 4
)??4 5
;??5 6
[AA 	
OperationContractAA	 
(AA 
IsOneWayAA #
=AA$ %
trueAA& *
)AA* +
]AA+ ,
voidBB  
NotifyFriendResponseBB !
(BB! "
stringBB" (
fromUsernameBB) 5
,BB5 6
boolBB7 ;
acceptedBB< D
)BBD E
;BBE F
[DD 	
OperationContractDD	 
(DD 
IsOneWayDD #
=DD$ %
trueDD& *
)DD* +
]DD+ ,
voidEE %
NotifyFriendStatusChangedEE &
(EE& '
stringEE' -
friendUsernameEE. <
,EE< =
stringEE> D
statusEEE K
)EEK L
;EEL M
[GG 	
OperationContractGG	 
(GG 
IsOneWayGG #
=GG$ %
trueGG& *
)GG* +
]GG+ ,
voidHH !
NotifyMessageReceivedHH "
(HH" #
DirectMessageDtoHH# 3
messageHH4 ;
)HH; <
;HH< =
[JJ 	
OperationContractJJ	 
(JJ 
IsOneWayJJ #
=JJ$ %
trueJJ& *
)JJ* +
]JJ+ ,
voidKK 
NotifyFriendRemovedKK  
(KK  !
stringKK! '
requesterUsernameKK( 9
)KK9 :
;KK: ;
}LL 
}MM ‰+
©C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\ServiceContracts\IMatchmakingService.cs
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
(. /'
IMatchmakingServiceCallback/ J
)J K
)K L
]L M
public		 

	interface		 
IMatchmakingService		 (
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
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 

Disconnect 
( 
string 
username '
)' (
;( )
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
ServiceFaultDto -
)- .
). /
]/ 0
Task 
< 
List 
< 
MatchInfoDto 
> 
>  
GetPublicMatches! 1
(1 2
)2 3
;3 4
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
ServiceFaultDto -
)- .
). /
]/ 0
Task 
< 
OperationResultDto 
>  
CreateMatch! ,
(, -
string- 3
hostUsername4 @
,@ A
LobbySettingsDtoB R
settingsS [
)[ \
;\ ]
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
JoinPublicMatch 
( 
string #
username$ ,
,, -
string. 4
matchId5 <
)< =
;= >
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
ServiceFaultDto -
)- .
). /
]/ 0
Task 
< 
OperationResultDto 
>  
JoinPrivateMatch! 1
(1 2
string2 8
username9 A
,A B
stringC I
	matchCodeJ S
)S T
;T U
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
[## 	
OperationContract##	 
]## 
[$$ 	
FaultContract$$	 
($$ 
typeof$$ 
($$ 
ServiceFaultDto$$ -
)$$- .
)$$. /
]$$/ 0
Task%% 
InviteGuestByEmail%% 
(%%  
string%%  &
inviterUsername%%' 6
,%%6 7
string%%8 >
targetEmail%%? J
,%%J K
string%%L R
matchId%%S Z
)%%Z [
;%%[ \
}&& 
[(( 
ServiceContract(( 
](( 
public)) 

	interface)) '
IMatchmakingServiceCallback)) 0
{** 
[++ 	
OperationContract++	 
(++ 
IsOneWay++ #
=++$ %
true++& *
)++* +
]+++ ,
void,, 
ReceiveMatchInvite,, 
(,,  
string,,  &
fromUsername,,' 3
,,,3 4
string,,5 ;
matchId,,< C
),,C D
;,,D E
[.. 	
OperationContract..	 
(.. 
IsOneWay.. #
=..$ %
true..& *
)..* +
]..+ ,
void// 
MatchUpdate// 
(// 
MatchInfoDto// %
	matchInfo//& /
)/// 0
;//0 1
[11 	
OperationContract11	 
(11 
IsOneWay11 #
=11$ %
true11& *
)11* +
]11+ ,
void22 
MatchJoined22 
(22 
string22 
matchId22  '
,22' (
OperationResultDto22) ;
result22< B
)22B C
;22C D
[44 	
OperationContract44	 
(44 
IsOneWay44 #
=44$ %
true44& *
)44* +
]44+ ,
void55 
MatchmakingFailed55 
(55 
string55 %
reason55& ,
)55, -
;55- .
[77 	
OperationContract77	 
(77 
IsOneWay77 #
=77$ %
true77& *
)77* +
]77+ ,
void88 $
PublicMatchesListUpdated88 %
(88% &
List88& *
<88* +
MatchInfoDto88+ 7
>887 8
publicMatches889 F
)88F G
;88G H
}99 
}:: ¿2
¢C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\ServiceContracts\IGameService.cs
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
(. / 
IGameServiceCallback/ C
)C D
)D E
]E F
public		 

	interface		 
IGameService		 !
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
,$ %
string& ,
matchId- 4
)4 5
;5 6
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 

Disconnect 
( 
string 
username '
,' (
string) /
matchId0 7
)7 8
;8 9
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 

SelectWord 
( 
string 
username '
,' (
string) /
matchId0 7
,7 8
string9 ?
selectedWord@ L
)L M
;M N
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
ServiceFaultDto -
)- .
). /
]/ 0
Task 
< 
List 
< 
WordDto 
> 
> 
GetRandomWordsAsync /
(/ 0
string0 6
username7 ?
)? @
;@ A
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
SubmitDrawing 
( 
string !
username" *
,* +
string, 2
matchId3 :
,: ;
byte< @
[@ A
]A B
drawingDataC N
)N O
;O P
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
SubmitGuess 
( 
string 
username  (
,( )
string* 0
matchId1 8
,8 9
int: =
	drawingId> G
,G H
stringI O
guessP U
)U V
;V W
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void !
SendInGameChatMessage "
(" #
string# )
username* 2
,2 3
string4 :
matchId; B
,B C
stringD J
messageK R
)R S
;S T
[!! 	
OperationContract!!	 
(!! 
IsOneWay!! #
=!!$ %
true!!& *
)!!* +
]!!+ ,
void"" 
	StartGame"" 
("" 
string"" 
matchId"" %
,""% &
int""' *
totalRounds""+ 6
,""6 7
List""8 <
<""< =
string""= C
>""C D
playerUsernames""E T
)""T U
;""U V
}## 
[%% 
ServiceContract%% 
]%% 
public&& 

	interface&&  
IGameServiceCallback&& )
{'' 
[(( 	
OperationContract((	 
((( 
IsOneWay(( #
=(($ %
true((& *
)((* +
]((+ ,
void)) 
OnRoundStart)) 
()) 
int)) 
roundNumber)) )
,))) *
List))+ /
<))/ 0
string))0 6
>))6 7
wordOptions))8 C
)))C D
;))D E
[++ 	
OperationContract++	 
(++ 
IsOneWay++ #
=++$ %
true++& *
)++* +
]+++ ,
void,, 
OnDrawingPhaseStart,,  
(,,  !
int,,! $
durationSeconds,,% 4
),,4 5
;,,5 6
[.. 	
OperationContract..	 
(.. 
IsOneWay.. #
=..$ %
true..& *
)..* +
]..+ ,
void//  
OnGuessingPhaseStart// !
(//! "

DrawingDto//" ,
drawing//- 4
)//4 5
;//5 6
[11 	
OperationContract11	 
(11 
IsOneWay11 #
=11$ %
true11& *
)11* +
]11+ ,
void22 #
OnInGameMessageReceived22 $
(22$ %
string22% +
sender22, 2
,222 3
string224 :
message22; B
)22B C
;22C D
[44 	
OperationContract44	 
(44 
IsOneWay44 #
=44$ %
true44& *
)44* +
]44+ ,
void55 
OnAnswersPhaseStart55  
(55  !

DrawingDto55! +
[55+ ,
]55, -
allDrawings55. 9
,559 :
GuessDto55; C
[55C D
]55D E

allGuesses55F P
,55P Q
PlayerScoreDto55R `
[55` a
]55a b
currentScores55c p
)55p q
;55q r
[77 	
OperationContract77	 
(77 
IsOneWay77 #
=77$ %
true77& *
)77* +
]77+ ,
void88 
OnShowNextDrawing88 
(88 

DrawingDto88 )
nextDrawing88* 5
)885 6
;886 7
[:: 	
OperationContract::	 
(:: 
IsOneWay:: #
=::$ %
true::& *
)::* +
]::+ ,
void;; 
	OnGameEnd;; 
(;; 
List;; 
<;; 
PlayerScoreDto;; *
>;;* +
finalScores;;, 7
);;7 8
;;;8 9
}<< 
}== Á
¨C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\ServiceContracts\IAuthenticationService.cs
	namespace 	
GuessMyMessServer
 
. 
	Contracts %
.% &
ServiceContracts& 6
{ 
[ 
ServiceContract 
] 
public 

	interface "
IAuthenticationService +
{		 
[

 	
OperationContract

	 
]

 
[ 	
FaultContract	 
( 
typeof 
( 
ServiceFaultDto -
)- .
). /
]/ 0
Task 
< 
OperationResultDto 
>  

LoginAsync! +
(+ ,
string, 2
emailOrUsername3 B
,B C
stringD J
passwordK S
)S T
;T U
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
ServiceFaultDto -
)- .
). /
]/ 0
Task 
< 
OperationResultDto 
>  
RegisterAsync! .
(. /
UserProfileDto/ =
userProfile> I
,I J
stringK Q
passwordR Z
)Z [
;[ \
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
ServiceFaultDto -
)- .
). /
]/ 0
Task 
< 
OperationResultDto 
>  
VerifyAccountAsync! 3
(3 4
string4 :
email; @
,@ A
stringB H
verificationCodeI Y
)Y Z
;Z [
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
LogOut 
( 
string 
username #
)# $
;$ %
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
ServiceFaultDto -
)- .
). /
]/ 0
Task 
< 
OperationResultDto 
>  
LoginAsGuestAsync! 2
(2 3
string3 9
email: ?
,? @
stringA G
codeH L
)L M
;M N
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
ServiceFaultDto -
)- .
). /
]/ 0
Task 
< 
OperationResultDto 
>  )
SendPasswordRecoveryCodeAsync! >
(> ?
string? E
emailF K
)K L
;L M
[!! 	
OperationContract!!	 
]!! 
["" 	
FaultContract""	 
("" 
typeof"" 
("" 
ServiceFaultDto"" -
)""- .
)"". /
]""/ 0
Task## 
<## 
OperationResultDto## 
>##  &
ResetPasswordWithCodeAsync##! ;
(##; <
string##< B
email##C H
,##H I
string##J P
code##Q U
,##U V
string##W ]
newPassword##^ i
)##i j
;##j k
}$$ 
}%% Î
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
} ‰
©C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\DataContracts\Shared\ServiceFaultDto.cs
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
class 
ServiceFaultDto  
{ 
[ 	

DataMember	 
] 
public		 
ServiceErrorType		 
	ErrorType		  )
{		* +
get		, /
;		/ 0
set		1 4
;		4 5
}		6 7
[ 	

DataMember	 
] 
public 
string 
Message 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
string 
Target 
{ 
get "
;" #
set$ '
;' (
}) *
public 
ServiceFaultDto 
( 
ServiceErrorType /
type0 4
,4 5
string6 <
message= D
,D E
stringF L
targetM S
=T U
nullV Z
)Z [
{ 	
	ErrorType 
= 
type 
; 
Message 
= 
message 
; 
Target 
= 
target 
; 
} 	
} 
} ñ∂
îC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\BusinessLogic\SocialLogic.cs
	namespace 	
GuessMyMessServer
 
. 
BusinessLogic )
{ 
public 

class 
SocialLogic 
{ 
private 
static 
readonly 
ILog  $
_log% )
=* +

LogManager, 6
.6 7
	GetLogger7 @
(@ A
typeofA G
(G H
SocialLogicH S
)S T
)T U
;U V
private 
readonly 
ISocialRepository *
_socialRepository+ <
;< =
private 
readonly 
IPlayerRepository *
_playerRepository+ <
;< =
private 
readonly $
ISocialNetworkRepository 1$
_socialNetworkRepository2 J
;J K
private 
const 
int 
StatusAccepted (
=) *
$num+ ,
;, -
private 
const 
int 
StatusPending '
=( )
$num* +
;+ ,
private 
const 
string 
OnlineStatusString /
=0 1
$str2 :
;: ;
public 
SocialLogic 
( 
ISocialRepository ,
socialRepository- =
,= >
IPlayerRepository? P
playerRepositoryQ a
,a b$
ISocialNetworkRepositoryc {$
socialNetworkRepository	| ì
)
ì î
{ 	
_socialRepository 
= 
socialRepository  0
;0 1
_playerRepository 
= 
playerRepository  0
;0 1$
_socialNetworkRepository $
=% &#
socialNetworkRepository' >
;> ?
} 	
public   
async   
Task   
<   
List   
<   
	FriendDto   (
>  ( )
>  ) *
GetFriendsListAsync  + >
(  > ?
string  ? E
username  F N
)  N O
{!! 	
var"" 
user"" 
="" 
await"" 
_playerRepository"" .
."". /$
GetPlayerByUsernameAsync""/ G
(""G H
username""H P
)""P Q
;""Q R
if## 
(## 
user## 
==## 
null## 
)## 
{$$ 
_log%% 
.%% 
Warn%% 
(%% 
$"%% 
$str%% 9
{%%9 :
username%%: B
}%%B C
$str%%C O
"%%O P
)%%P Q
;%%Q R
ThrowServiceFault&& !
(&&! "
ServiceErrorType&&" 2
.&&2 3
NotFound&&3 ;
,&&; <
$str&&= N
)&&N O
;&&O P
}'' 
try)) 
{** 
var++ 
friendships++ 
=++  !
await++" '
_socialRepository++( 9
.++9 :
GetFriendsListAsync++: M
(++M N
user++N R
.++R S
idPlayer++S [
)++[ \
;++\ ]
return,, 
friendships,, "
.,," #
Select,,# )
(,,) *
f,,* +
=>,,, .
{-- 
var.. 
friendEntity.. $
=..% &
f..' (
...( )
Player_idPlayer1..) 9
==..: <
user..= A
...A B
idPlayer..B J
?..K L
f..M N
...N O
Player1..O V
:..W X
f..Y Z
...Z [
Player..[ a
;..a b
return// 
new// 
	FriendDto// (
{00 
Username11  
=11! "
friendEntity11# /
.11/ 0
username110 8
,118 9
IsOnline22  
=22! "
friendEntity22# /
.22/ 0

UserStatus220 :
?22: ;
.22; <
status22< B
==22C E
OnlineStatusString22F X
}33 
;33 
}44 
)44 
.44 
ToList44 
(44 
)44 
;44 
}55 
catch66 
(66 
	Exception66 
ex66 
)66  
{77 
_log88 
.88 
Error88 
(88 
$"88 
$str88 @
{88@ A
username88A I
}88I J
$str88J L
"88L M
,88M N
ex88O Q
)88Q R
;88R S
ThrowServiceFault99 !
(99! "
ServiceErrorType99" 2
.992 3
DatabaseError993 @
,99@ A
$str99B d
)99d e
;99e f
return:: 
null:: 
;:: 
};; 
}<< 	
public>> 
async>> 
Task>> 
<>> 
List>> 
<>>  
FriendRequestInfoDto>> 3
>>>3 4
>>>4 5"
GetFriendRequestsAsync>>6 L
(>>L M
string>>M S
username>>T \
)>>\ ]
{?? 	
var@@ 
user@@ 
=@@ 
await@@ 
_playerRepository@@ .
.@@. /$
GetPlayerByUsernameAsync@@/ G
(@@G H
username@@H P
)@@P Q
;@@Q R
ifAA 
(AA 
userAA 
==AA 
nullAA 
)AA 
{BB 
returnCC 
newCC 
ListCC 
<CC   
FriendRequestInfoDtoCC  4
>CC4 5
(CC5 6
)CC6 7
;CC7 8
}DD 
tryFF 
{GG 
varHH 
requestsHH 
=HH 
awaitHH $
_socialRepositoryHH% 6
.HH6 7#
GetPendingRequestsAsyncHH7 N
(HHN O
userHHO S
.HHS T
idPlayerHHT \
)HH\ ]
;HH] ^
returnII 
requestsII 
.II  
SelectII  &
(II& '
fII' (
=>II) +
newII, / 
FriendRequestInfoDtoII0 D
{JJ 
RequesterUsernameKK %
=KK& '
fKK( )
.KK) *
PlayerKK* 0
.KK0 1
usernameKK1 9
}LL 
)LL 
.LL 
ToListLL 
(LL 
)LL 
;LL 
}MM 
catchNN 
(NN 
	ExceptionNN 
exNN 
)NN  
{OO 
_logPP 
.PP 
ErrorPP 
(PP 
$"PP 
$strPP C
{PPC D
usernamePPD L
}PPL M
$strPPM O
"PPO P
,PPP Q
exPPR T
)PPT U
;PPU V
ThrowServiceFaultQQ !
(QQ! "
ServiceErrorTypeQQ" 2
.QQ2 3
DatabaseErrorQQ3 @
,QQ@ A
$strQQB g
)QQg h
;QQh i
returnRR 
nullRR 
;RR 
}SS 
}TT 	
publicVV 
asyncVV 
TaskVV 
<VV 
ListVV 
<VV 
UserProfileDtoVV -
>VV- .
>VV. /
SearchUsersAsyncVV0 @
(VV@ A
stringVVA G
searchUsernameVVH V
,VVV W
stringVVX ^
requesterUsernameVV_ p
)VVp q
{WW 	
varXX 
	requesterXX 
=XX 
awaitXX !
_playerRepositoryXX" 3
.XX3 4$
GetPlayerByUsernameAsyncXX4 L
(XXL M
requesterUsernameXXM ^
)XX^ _
;XX_ `
ifYY 
(YY 
	requesterYY 
==YY 
nullYY !
)YY! "
{ZZ 
_log[[ 
.[[ 
Warn[[ 
([[ 
$"[[ 
$str[[ ;
{[[; <
requesterUsername[[< M
}[[M N
$str[[N Z
"[[Z [
)[[[ \
;[[\ ]
ThrowServiceFault\\ !
(\\! "
ServiceErrorType\\" 2
.\\2 3
NotFound\\3 ;
,\\; <
$str\\= X
)\\X Y
;\\Y Z
}]] 
try__ 
{`` 
varaa 
playersaa 
=aa 
awaitaa #
_playerRepositoryaa$ 5
.aa5 6(
SearchPlayersNotFriendsAsyncaa6 R
(aaR S
searchUsernameaaS a
,aaa b
	requesteraac l
.aal m
idPlayeraam u
)aau v
;aav w
returnbb 
playersbb 
.bb 
Selectbb %
(bb% &
pbb& '
=>bb( *
newbb+ .
UserProfileDtobb/ =
{cc 
Usernamedd 
=dd 
pdd  
.dd  !
usernamedd! )
}ee 
)ee 
.ee 
ToListee 
(ee 
)ee 
;ee 
}ff 
catchgg 
(gg 
	Exceptiongg 
exgg 
)gg  
{hh 
_logii 
.ii 
Errorii 
(ii 
$"ii 
$strii 8
{ii8 9
requesterUsernameii9 J
}iiJ K
$striiK M
"iiM N
,iiN O
exiiP R
)iiR S
;iiS T
ThrowServiceFaultjj !
(jj! "
ServiceErrorTypejj" 2
.jj2 3
DatabaseErrorjj3 @
,jj@ A
$strjjB \
)jj\ ]
;jj] ^
returnkk 
nullkk 
;kk 
}ll 
}mm 	
publicoo 
asyncoo 
Taskoo 
<oo 
OperationResultDtooo ,
>oo, -"
SendFriendRequestAsyncoo. D
(ooD E
stringooE K
requesterUsernameooL ]
,oo] ^
stringoo_ e
targetUsernameoof t
)oot u
{pp 	
ifqq 
(qq 
requesterUsernameqq !
==qq" $
targetUsernameqq% 3
)qq3 4
{rr 
ThrowServiceFaultss !
(ss! "
ServiceErrorTypess" 2
.ss2 3
OperationFailedss3 B
,ssB C
$strssD s
)sss t
;sst u
}tt 
varvv 
	requestervv 
=vv 
awaitvv !
_playerRepositoryvv" 3
.vv3 4$
GetPlayerByUsernameAsyncvv4 L
(vvL M
requesterUsernamevvM ^
)vv^ _
;vv_ `
varww 
targetww 
=ww 
awaitww 
_playerRepositoryww 0
.ww0 1$
GetPlayerByUsernameAsyncww1 I
(wwI J
targetUsernamewwJ X
)wwX Y
;wwY Z
ifyy 
(yy 
	requesteryy 
==yy 
nullyy !
||yy" $
targetyy% +
==yy, .
nullyy/ 3
)yy3 4
{zz 
ThrowServiceFault{{ !
({{! "
ServiceErrorType{{" 2
.{{2 3
NotFound{{3 ;
,{{; <
$str{{= [
){{[ \
;{{\ ]
}|| 
var~~ 
existing~~ 
=~~ 
await~~  
_socialRepository~~! 2
.~~2 3
GetFriendshipAsync~~3 E
(~~E F
	requester~~F O
.~~O P
idPlayer~~P X
,~~X Y
target~~Z `
.~~` a
idPlayer~~a i
)~~i j
;~~j k
if 
( 
existing 
!= 
null  
)  !
{
ÄÄ 
string
ÅÅ 
msg
ÅÅ 
=
ÅÅ 
existing
ÅÅ %
.
ÅÅ% &1
#FriendShipStatus_idFriendShipStatus
ÅÅ& I
==
ÅÅJ L
StatusAccepted
ÅÅM [
?
ÇÇ 
$str
ÇÇ 0
:
ÉÉ 
$str
ÉÉ 5
;
ÉÉ5 6
_log
ÖÖ 
.
ÖÖ 
Info
ÖÖ 
(
ÖÖ 
$"
ÖÖ 
$str
ÖÖ 6
{
ÖÖ6 7
msg
ÖÖ7 :
}
ÖÖ: ;
"
ÖÖ; <
)
ÖÖ< =
;
ÖÖ= >
ThrowServiceFault
ÜÜ !
(
ÜÜ! "
ServiceErrorType
ÜÜ" 2
.
ÜÜ2 3
OperationFailed
ÜÜ3 B
,
ÜÜB C
msg
ÜÜD G
)
ÜÜG H
;
ÜÜH I
}
áá 
var
ââ 

friendship
ââ 
=
ââ 
new
ââ  

Friendship
ââ! +
{
ää 
Player_idPlayer1
ãã  
=
ãã! "
	requester
ãã# ,
.
ãã, -
idPlayer
ãã- 5
,
ãã5 6
Player_idPlayer2
åå  
=
åå! "
target
åå# )
.
åå) *
idPlayer
åå* 2
,
åå2 31
#FriendShipStatus_idFriendShipStatus
çç 3
=
çç4 5
StatusPending
çç6 C
}
éé 
;
éé 
_socialRepository
êê 
.
êê 
AddFriendship
êê +
(
êê+ ,

friendship
êê, 6
)
êê6 7
;
êê7 8
try
íí 
{
ìì 
await
îî 
_socialRepository
îî '
.
îî' (
SaveChangesAsync
îî( 8
(
îî8 9
)
îî9 :
;
îî: ;
_log
ïï 
.
ïï 
Info
ïï 
(
ïï 
$"
ïï 
$str
ïï 2
{
ïï2 3
requesterUsername
ïï3 D
}
ïïD E
$str
ïïE K
{
ïïK L
targetUsername
ïïL Z
}
ïïZ [
$str
ïï[ ]
"
ïï] ^
)
ïï^ _
;
ïï_ `
return
ññ 
new
ññ  
OperationResultDto
ññ -
{
ññ. /
Success
ññ0 7
=
ññ8 9
true
ññ: >
,
ññ> ?
Message
ññ@ G
=
ññH I
$str
ññJ `
}
ñña b
;
ññb c
}
óó 
catch
òò 
(
òò 
	Exception
òò 
ex
òò 
)
òò  
{
ôô 
_log
öö 
.
öö 
Error
öö 
(
öö 
$"
öö 
$str
öö @
{
öö@ A
targetUsername
ööA O
}
ööO P
$str
ööP R
"
ööR S
,
ööS T
ex
ööU W
)
ööW X
;
ööX Y
ThrowServiceFault
õõ !
(
õõ! "
ServiceErrorType
õõ" 2
.
õõ2 3
DatabaseError
õõ3 @
,
õõ@ A
$str
õõB b
)
õõb c
;
õõc d
return
úú 
null
úú 
;
úú 
}
ùù 
}
ûû 	
public
†† 
async
†† 
Task
†† 
<
††  
OperationResultDto
†† ,
>
††, -)
RespondToFriendRequestAsync
††. I
(
††I J
string
††J P
targetUsername
††Q _
,
††_ `
string
††a g
requesterUsername
††h y
,
††y z
bool
††{ 
accepted††Ä à
)††à â
{
°° 	
var
¢¢ 
target
¢¢ 
=
¢¢ 
await
¢¢ 
_playerRepository
¢¢ 0
.
¢¢0 1&
GetPlayerByUsernameAsync
¢¢1 I
(
¢¢I J
targetUsername
¢¢J X
)
¢¢X Y
;
¢¢Y Z
var
££ 
	requester
££ 
=
££ 
await
££ !
_playerRepository
££" 3
.
££3 4&
GetPlayerByUsernameAsync
££4 L
(
££L M
requesterUsername
££M ^
)
££^ _
;
££_ `
if
•• 
(
•• 
target
•• 
==
•• 
null
•• 
||
•• !
	requester
••" +
==
••, .
null
••/ 3
)
••3 4
{
¶¶ 
ThrowServiceFault
ßß !
(
ßß! "
ServiceErrorType
ßß" 2
.
ßß2 3
NotFound
ßß3 ;
,
ßß; <
$str
ßß= O
)
ßßO P
;
ßßP Q
}
®® 
var
™™ 

friendship
™™ 
=
™™ 
await
™™ "
_socialRepository
™™# 4
.
™™4 5 
GetFriendshipAsync
™™5 G
(
™™G H
	requester
™™H Q
.
™™Q R
idPlayer
™™R Z
,
™™Z [
target
™™\ b
.
™™b c
idPlayer
™™c k
)
™™k l
;
™™l m
if
´´ 
(
´´ 

friendship
´´ 
==
´´ 
null
´´ "
)
´´" #
{
¨¨ 
ThrowServiceFault
≠≠ !
(
≠≠! "
ServiceErrorType
≠≠" 2
.
≠≠2 3
NotFound
≠≠3 ;
,
≠≠; <
$str
≠≠= X
)
≠≠X Y
;
≠≠Y Z
}
ÆÆ 
if
∞∞ 
(
∞∞ 

friendship
∞∞ 
.
∞∞ 1
#FriendShipStatus_idFriendShipStatus
∞∞ >
!=
∞∞? A
StatusPending
∞∞B O
)
∞∞O P
{
±± 
ThrowServiceFault
≤≤ !
(
≤≤! "
ServiceErrorType
≤≤" 2
.
≤≤2 3
NotFound
≤≤3 ;
,
≤≤; <
$str
≤≤= j
)
≤≤j k
;
≤≤k l
}
≥≥ 
if
µµ 
(
µµ 

friendship
µµ 
.
µµ 
Player_idPlayer2
µµ +
!=
µµ, .
target
µµ/ 5
.
µµ5 6
idPlayer
µµ6 >
)
µµ> ?
{
∂∂ 
ThrowServiceFault
∑∑ !
(
∑∑! "
ServiceErrorType
∑∑" 2
.
∑∑2 3
OperationFailed
∑∑3 B
,
∑∑B C
$str
∑∑D i
)
∑∑i j
;
∑∑j k
}
∏∏ 
if
∫∫ 
(
∫∫ 
accepted
∫∫ 
)
∫∫ 
{
ªª 

friendship
ºº 
.
ºº 1
#FriendShipStatus_idFriendShipStatus
ºº >
=
ºº? @
StatusAccepted
ººA O
;
ººO P
_log
ΩΩ 
.
ΩΩ 
Info
ΩΩ 
(
ΩΩ 
$"
ΩΩ 
$str
ΩΩ 8
{
ΩΩ8 9
targetUsername
ΩΩ9 G
}
ΩΩG H
$str
ΩΩH J
"
ΩΩJ K
)
ΩΩK L
;
ΩΩL M
}
ææ 
else
øø 
{
¿¿ 
_socialRepository
¡¡ !
.
¡¡! "
RemoveFriendship
¡¡" 2
(
¡¡2 3

friendship
¡¡3 =
)
¡¡= >
;
¡¡> ?
_log
¬¬ 
.
¬¬ 
Info
¬¬ 
(
¬¬ 
$"
¬¬ 
$str
¬¬ 8
{
¬¬8 9
targetUsername
¬¬9 G
}
¬¬G H
$str
¬¬H J
"
¬¬J K
)
¬¬K L
;
¬¬L M
}
√√ 
try
≈≈ 
{
∆∆ 
await
«« 
_socialRepository
«« '
.
««' (
SaveChangesAsync
««( 8
(
««8 9
)
««9 :
;
««: ;
return
»» 
new
»»  
OperationResultDto
»» -
{
»». /
Success
»»0 7
=
»»8 9
true
»»: >
,
»»> ?
Message
»»@ G
=
»»H I
accepted
»»J R
?
»»S T
$str
»»U g
:
»»h i
$str
»»j |
}
»»} ~
;
»»~ 
}
…… 
catch
   
(
   
	Exception
   
ex
   
)
    
{
ÀÀ 
_log
ÃÃ 
.
ÃÃ 
Error
ÃÃ 
(
ÃÃ 
$"
ÃÃ 
$str
ÃÃ >
{
ÃÃ> ?
targetUsername
ÃÃ? M
}
ÃÃM N
$str
ÃÃN P
"
ÃÃP Q
,
ÃÃQ R
ex
ÃÃS U
)
ÃÃU V
;
ÃÃV W
ThrowServiceFault
ÕÕ !
(
ÕÕ! "
ServiceErrorType
ÕÕ" 2
.
ÕÕ2 3
DatabaseError
ÕÕ3 @
,
ÕÕ@ A
$str
ÕÕB _
)
ÕÕ_ `
;
ÕÕ` a
return
ŒŒ 
null
ŒŒ 
;
ŒŒ 
}
œœ 
}
–– 	
public
““ 
async
““ 
Task
““ 
<
““  
OperationResultDto
““ ,
>
““, -
RemoveFriendAsync
““. ?
(
““? @
string
““@ F
username
““G O
,
““O P
string
““Q W
friendToRemove
““X f
)
““f g
{
”” 	
var
‘‘ 
result
‘‘ 
=
‘‘ 
new
‘‘  
OperationResultDto
‘‘ /
{
‘‘0 1
Success
‘‘2 9
=
‘‘: ;
false
‘‘< A
}
‘‘B C
;
‘‘C D
var
÷÷ 
player
÷÷ 
=
÷÷ 
await
÷÷ 
_playerRepository
÷÷ 0
.
÷÷0 1&
GetPlayerByUsernameAsync
÷÷1 I
(
÷÷I J
username
÷÷J R
)
÷÷R S
;
÷÷S T
var
◊◊ 
friend
◊◊ 
=
◊◊ 
await
◊◊ 
_playerRepository
◊◊ 0
.
◊◊0 1&
GetPlayerByUsernameAsync
◊◊1 I
(
◊◊I J
friendToRemove
◊◊J X
)
◊◊X Y
;
◊◊Y Z
if
ŸŸ 
(
ŸŸ 
player
ŸŸ 
==
ŸŸ 
null
ŸŸ 
||
ŸŸ !
friend
ŸŸ" (
==
ŸŸ) +
null
ŸŸ, 0
)
ŸŸ0 1
{
⁄⁄ 
result
€€ 
.
€€ 
Message
€€ 
=
€€  
$str
€€! 9
;
€€9 :
return
‹‹ 
result
‹‹ 
;
‹‹ 
}
›› 
var
ﬂﬂ 

friendship
ﬂﬂ 
=
ﬂﬂ 
await
ﬂﬂ "
_socialRepository
ﬂﬂ# 4
.
ﬂﬂ4 5 
GetFriendshipAsync
ﬂﬂ5 G
(
ﬂﬂG H
player
ﬂﬂH N
.
ﬂﬂN O
idPlayer
ﬂﬂO W
,
ﬂﬂW X
friend
ﬂﬂY _
.
ﬂﬂ_ `
idPlayer
ﬂﬂ` h
)
ﬂﬂh i
;
ﬂﬂi j
if
·· 
(
·· 

friendship
·· 
!=
·· 
null
·· "
)
··" #
{
‚‚ 
_socialRepository
„„ !
.
„„! "
RemoveFriendship
„„" 2
(
„„2 3

friendship
„„3 =
)
„„= >
;
„„> ?
try
‰‰ 
{
ÂÂ 
if
ÊÊ 
(
ÊÊ 
await
ÊÊ 
_socialRepository
ÊÊ /
.
ÊÊ/ 0
SaveChangesAsync
ÊÊ0 @
(
ÊÊ@ A
)
ÊÊA B
>
ÊÊC D
$num
ÊÊE F
)
ÊÊF G
{
ÁÁ 
_log
ËË 
.
ËË 
Info
ËË !
(
ËË! "
$"
ËË" $
$str
ËË$ @
{
ËË@ A
username
ËËA I
}
ËËI J
$str
ËËJ Q
{
ËËQ R
friendToRemove
ËËR `
}
ËË` a
$str
ËËa c
"
ËËc d
)
ËËd e
;
ËËe f
result
ÈÈ 
.
ÈÈ 
Success
ÈÈ &
=
ÈÈ' (
true
ÈÈ) -
;
ÈÈ- .
result
ÍÍ 
.
ÍÍ 
Message
ÍÍ &
=
ÍÍ' (
$str
ÍÍ) I
;
ÍÍI J
}
ÎÎ 
else
ÏÏ 
{
ÌÌ 
result
ÓÓ 
.
ÓÓ 
Message
ÓÓ &
=
ÓÓ' (
$str
ÓÓ) V
;
ÓÓV W
}
ÔÔ 
}
 
catch
ÒÒ 
(
ÒÒ 
	Exception
ÒÒ  
ex
ÒÒ! #
)
ÒÒ# $
{
ÚÚ 
_log
ÛÛ 
.
ÛÛ 
Error
ÛÛ 
(
ÛÛ 
$str
ÛÛ ;
,
ÛÛ; <
ex
ÛÛ= ?
)
ÛÛ? @
;
ÛÛ@ A
ThrowServiceFault
ÙÙ %
(
ÙÙ% &
ServiceErrorType
ÙÙ& 6
.
ÙÙ6 7
DatabaseError
ÙÙ7 D
,
ÙÙD E
$str
ÙÙF q
)
ÙÙq r
;
ÙÙr s
}
ıı 
}
ˆˆ 
else
˜˜ 
{
¯¯ 
result
˘˘ 
.
˘˘ 
Message
˘˘ 
=
˘˘  
$str
˘˘! 8
;
˘˘8 9
}
˙˙ 
return
¸¸ 
result
¸¸ 
;
¸¸ 
}
˝˝ 	
public
ˇˇ 
async
ˇˇ 
Task
ˇˇ 
<
ˇˇ 
FriendProfileDto
ˇˇ *
>
ˇˇ* +#
GetFriendProfileAsync
ˇˇ, A
(
ˇˇA B
string
ˇˇB H
username
ˇˇI Q
)
ˇˇQ R
{
ÄÄ 	
var
ÅÅ 
player
ÅÅ 
=
ÅÅ 
await
ÅÅ 
_playerRepository
ÅÅ 0
.
ÅÅ0 1&
GetPlayerByUsernameAsync
ÅÅ1 I
(
ÅÅI J
username
ÅÅJ R
)
ÅÅR S
;
ÅÅS T
if
ÇÇ 
(
ÇÇ 
player
ÇÇ 
==
ÇÇ 
null
ÇÇ 
)
ÇÇ 
{
ÉÉ 
ThrowServiceFault
ÑÑ !
(
ÑÑ! "
ServiceErrorType
ÑÑ" 2
.
ÑÑ2 3
NotFound
ÑÑ3 ;
,
ÑÑ; <
$str
ÑÑ= U
)
ÑÑU V
;
ÑÑV W
}
ÖÖ 
var
áá 
socialNetworks
áá 
=
áá  
await
áá! &&
_socialNetworkRepository
áá' ?
.
áá? @$
GetSocialNetworksAsync
áá@ V
(
ááV W
player
ááW ]
.
áá] ^
idPlayer
áá^ f
)
ááf g
;
áág h
var
ââ 
dto
ââ 
=
ââ 
new
ââ 
FriendProfileDto
ââ *
{
ää 
	FirstName
ãã 
=
ãã 
player
ãã "
.
ãã" #
name
ãã# '
,
ãã' (
LastName
åå 
=
åå 
player
åå !
.
åå! "
lastName
åå" *
,
åå* +
Email
çç 
=
çç 
player
çç 
.
çç 
email
çç $
,
çç$ %
GenderId
éé 
=
éé 
player
éé !
.
éé! "
Gender_idGender
éé" 1
.
éé1 2
GetValueOrDefault
éé2 C
(
ééC D
)
ééD E
,
ééE F
SocialNetworks
èè 
=
èè  
socialNetworks
èè! /
.
èè/ 0
Select
èè0 6
(
èè6 7
sn
èè7 9
=>
èè: <
new
èè= @
SocialNetworkDto
èèA Q
{
êê 
NetworkType
ëë 
=
ëë  !
sn
ëë" $
.
ëë$ %
TypeSocialNetwork
ëë% 6
.
ëë6 7
type
ëë7 ;
,
ëë; <
UserLink
íí 
=
íí 
sn
íí !
.
íí! "
userLink
íí" *
}
ìì 
)
ìì 
.
ìì 
ToList
ìì 
(
ìì 
)
ìì 
}
îî 
;
îî 
return
ññ 
dto
ññ 
;
ññ 
}
óó 	
public
ôô 
async
ôô 
Task
ôô %
UpdatePlayerStatusAsync
ôô 1
(
ôô1 2
string
ôô2 8
username
ôô9 A
,
ôôA B
string
ôôC I
status
ôôJ P
)
ôôP Q
{
öö 	
var
õõ 
player
õõ 
=
õõ 
await
õõ 
_playerRepository
õõ 0
.
õõ0 1&
GetPlayerByUsernameAsync
õõ1 I
(
õõI J
username
õõJ R
)
õõR S
;
õõS T
if
úú 
(
úú 
player
úú 
==
úú 
null
úú 
)
úú 
{
ùù 
_log
ûû 
.
ûû 
Warn
ûû 
(
ûû 
$"
ûû 
$str
ûû 0
{
ûû0 1
username
ûû1 9
}
ûû9 :
$str
ûû: F
"
ûûF G
)
ûûG H
;
ûûH I
return
üü 
;
üü 
}
†† 
var
¢¢ 
statusId
¢¢ 
=
¢¢ 
await
¢¢  
_playerRepository
¢¢! 2
.
¢¢2 3"
GetUserStatusIdAsync
¢¢3 G
(
¢¢G H
status
¢¢H N
)
¢¢N O
;
¢¢O P
if
££ 
(
££ 
statusId
££ 
==
££ 
null
££  
)
££  !
{
§§ 
_log
•• 
.
•• 
Warn
•• 
(
•• 
$"
•• 
$str
•• :
{
••: ;
status
••; A
}
••A B
$str
••B D
"
••D E
)
••E F
;
••F G
return
¶¶ 
;
¶¶ 
}
ßß 
if
©© 
(
©© 
player
©© 
.
©© %
UserStatus_idUserStatus
©© .
!=
©©/ 1
statusId
©©2 :
)
©©: ;
{
™™ 
player
´´ 
.
´´ %
UserStatus_idUserStatus
´´ .
=
´´/ 0
statusId
´´1 9
;
´´9 :
try
¨¨ 
{
≠≠ 
await
ÆÆ 
_playerRepository
ÆÆ +
.
ÆÆ+ ,
SaveChangesAsync
ÆÆ, <
(
ÆÆ< =
)
ÆÆ= >
;
ÆÆ> ?
_log
ØØ 
.
ØØ 
Debug
ØØ 
(
ØØ 
$"
ØØ !
$str
ØØ! '
{
ØØ' (
username
ØØ( 0
}
ØØ0 1
$str
ØØ1 F
{
ØØF G
status
ØØG M
}
ØØM N
$str
ØØN P
"
ØØP Q
)
ØØQ R
;
ØØR S
}
∞∞ 
catch
±± 
(
±± 
	Exception
±±  
ex
±±! #
)
±±# $
{
≤≤ 
_log
≥≥ 
.
≥≥ 
Error
≥≥ 
(
≥≥ 
$"
≥≥ !
$str
≥≥! <
{
≥≥< =
username
≥≥= E
}
≥≥E F
$str
≥≥F H
"
≥≥H I
,
≥≥I J
ex
≥≥K M
)
≥≥M N
;
≥≥N O
}
¥¥ 
}
µµ 
}
∂∂ 	
public
∏∏ 
async
∏∏ 
Task
∏∏ 
<
∏∏ 
DirectMessageDto
∏∏ *
>
∏∏* +$
SendDirectMessageAsync
∏∏, B
(
∏∏B C
DirectMessageDto
∏∏C S
message
∏∏T [
)
∏∏[ \
{
ππ 	
if
∫∫ 
(
∫∫ 
message
∫∫ 
==
∫∫ 
null
∫∫ 
||
∫∫  "
string
∫∫# )
.
∫∫) * 
IsNullOrWhiteSpace
∫∫* <
(
∫∫< =
message
∫∫= D
.
∫∫D E
Content
∫∫E L
)
∫∫L M
)
∫∫M N
{
ªª 
ThrowServiceFault
ºº !
(
ºº! "
ServiceErrorType
ºº" 2
.
ºº2 3
OperationFailed
ºº3 B
,
ººB C
$str
ººD V
)
ººV W
;
ººW X
return
ΩΩ 
null
ΩΩ 
;
ΩΩ 
}
ææ 
string
¿¿ 
cleanContent
¿¿ 
=
¿¿  !
BadWordValidator
¿¿" 2
.
¿¿2 3

BanMessage
¿¿3 =
(
¿¿= >
message
¿¿> E
.
¿¿E F
Content
¿¿F M
)
¿¿M N
;
¿¿N O
message
¡¡ 
.
¡¡ 
Content
¡¡ 
=
¡¡ 
cleanContent
¡¡ *
;
¡¡* +
var
√√ 
sender
√√ 
=
√√ 
await
√√ 
_playerRepository
√√ 0
.
√√0 1&
GetPlayerByUsernameAsync
√√1 I
(
√√I J
message
√√J Q
.
√√Q R
SenderUsername
√√R `
)
√√` a
;
√√a b
var
ƒƒ 
	recipient
ƒƒ 
=
ƒƒ 
await
ƒƒ !
_playerRepository
ƒƒ" 3
.
ƒƒ3 4&
GetPlayerByUsernameAsync
ƒƒ4 L
(
ƒƒL M
message
ƒƒM T
.
ƒƒT U
RecipientUsername
ƒƒU f
)
ƒƒf g
;
ƒƒg h
if
∆∆ 
(
∆∆ 
sender
∆∆ 
==
∆∆ 
null
∆∆ 
||
∆∆ !
	recipient
∆∆" +
==
∆∆, .
null
∆∆/ 3
)
∆∆3 4
{
«« 
ThrowServiceFault
»» !
(
»»! "
ServiceErrorType
»»" 2
.
»»2 3
NotFound
»»3 ;
,
»»; <
$str
»»= ]
)
»»] ^
;
»»^ _
return
…… 
null
…… 
;
…… 
}
   
var
ÃÃ 
	dbMessage
ÃÃ 
=
ÃÃ 
new
ÃÃ 
DirectMessages
ÃÃ  .
{
ÕÕ 
SenderPlayerID
ŒŒ 
=
ŒŒ  
sender
ŒŒ! '
.
ŒŒ' (
idPlayer
ŒŒ( 0
,
ŒŒ0 1
RecipientPlayerID
œœ !
=
œœ" #
	recipient
œœ$ -
.
œœ- .
idPlayer
œœ. 6
,
œœ6 7
MessageContent
–– 
=
––  
message
––! (
.
––( )
Content
––) 0
,
––0 1
	Timestamp
—— 
=
—— 
DateTime
—— $
.
——$ %
UtcNow
——% +
}
““ 
;
““ 
_socialRepository
‘‘ 
.
‘‘ 
AddDirectMessage
‘‘ .
(
‘‘. /
	dbMessage
‘‘/ 8
)
‘‘8 9
;
‘‘9 :
try
÷÷ 
{
◊◊ 
await
ÿÿ 
_socialRepository
ÿÿ '
.
ÿÿ' (
SaveChangesAsync
ÿÿ( 8
(
ÿÿ8 9
)
ÿÿ9 :
;
ÿÿ: ;
message
ŸŸ 
.
ŸŸ 
	Timestamp
ŸŸ !
=
ŸŸ" #
	dbMessage
ŸŸ$ -
.
ŸŸ- .
	Timestamp
ŸŸ. 7
;
ŸŸ7 8
return
€€ 
message
€€ 
;
€€ 
}
‹‹ 
catch
›› 
(
›› 
	Exception
›› 
ex
›› 
)
››  
{
ﬁﬁ 
_log
ﬂﬂ 
.
ﬂﬂ 
Error
ﬂﬂ 
(
ﬂﬂ 
$"
ﬂﬂ 
$str
ﬂﬂ 9
{
ﬂﬂ9 :
message
ﬂﬂ: A
.
ﬂﬂA B
SenderUsername
ﬂﬂB P
}
ﬂﬂP Q
$str
ﬂﬂQ S
"
ﬂﬂS T
,
ﬂﬂT U
ex
ﬂﬂV X
)
ﬂﬂX Y
;
ﬂﬂY Z
ThrowServiceFault
‡‡ !
(
‡‡! "
ServiceErrorType
‡‡" 2
.
‡‡2 3
DatabaseError
‡‡3 @
,
‡‡@ A
$str
‡‡B [
)
‡‡[ \
;
‡‡\ ]
return
·· 
null
·· 
;
·· 
}
‚‚ 
}
„„ 	
public
ÂÂ 
async
ÂÂ 
Task
ÂÂ 
<
ÂÂ 
List
ÂÂ 
<
ÂÂ 
	FriendDto
ÂÂ (
>
ÂÂ( )
>
ÂÂ) *#
GetConversationsAsync
ÂÂ+ @
(
ÂÂ@ A
string
ÂÂA G
username
ÂÂH P
)
ÂÂP Q
{
ÊÊ 	
var
ÁÁ 
user
ÁÁ 
=
ÁÁ 
await
ÁÁ 
_playerRepository
ÁÁ .
.
ÁÁ. /&
GetPlayerByUsernameAsync
ÁÁ/ G
(
ÁÁG H
username
ÁÁH P
)
ÁÁP Q
;
ÁÁQ R
if
ËË 
(
ËË 
user
ËË 
==
ËË 
null
ËË 
)
ËË 
{
ÈÈ 
ThrowServiceFault
ÍÍ !
(
ÍÍ! "
ServiceErrorType
ÍÍ" 2
.
ÍÍ2 3
NotFound
ÍÍ3 ;
,
ÍÍ; <
$str
ÍÍ= N
)
ÍÍN O
;
ÍÍO P
}
ÎÎ 
try
ÌÌ 
{
ÓÓ 
var
ÔÔ 
usersWithChat
ÔÔ !
=
ÔÔ" #
await
ÔÔ$ )
_socialRepository
ÔÔ* ;
.
ÔÔ; <+
GetUsersWithConversationAsync
ÔÔ< Y
(
ÔÔY Z
user
ÔÔZ ^
.
ÔÔ^ _
idPlayer
ÔÔ_ g
)
ÔÔg h
;
ÔÔh i
return
 
usersWithChat
 $
.
$ %
Select
% +
(
+ ,
p
, -
=>
. 0
new
1 4
	FriendDto
5 >
{
ÒÒ 
Username
ÚÚ 
=
ÚÚ 
p
ÚÚ  
.
ÚÚ  !
username
ÚÚ! )
,
ÚÚ) *
IsOnline
ÛÛ 
=
ÛÛ 
p
ÛÛ  
.
ÛÛ  !

UserStatus
ÛÛ! +
?
ÛÛ+ ,
.
ÛÛ, -
status
ÛÛ- 3
==
ÛÛ4 6 
OnlineStatusString
ÛÛ7 I
}
ÙÙ 
)
ÙÙ 
.
ÙÙ 
ToList
ÙÙ 
(
ÙÙ 
)
ÙÙ 
;
ÙÙ 
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
˜˜ 
_log
¯¯ 
.
¯¯ 
Error
¯¯ 
(
¯¯ 
$"
¯¯ 
$str
¯¯ >
{
¯¯> ?
username
¯¯? G
}
¯¯G H
$str
¯¯H J
"
¯¯J K
,
¯¯K L
ex
¯¯M O
)
¯¯O P
;
¯¯P Q
ThrowServiceFault
˘˘ !
(
˘˘! "
ServiceErrorType
˘˘" 2
.
˘˘2 3
DatabaseError
˘˘3 @
,
˘˘@ A
$str
˘˘B e
)
˘˘e f
;
˘˘f g
return
˙˙ 
null
˙˙ 
;
˙˙ 
}
˚˚ 
}
¸¸ 	
public
˛˛ 
async
˛˛ 
Task
˛˛ 
<
˛˛ 
List
˛˛ 
<
˛˛ 
DirectMessageDto
˛˛ /
>
˛˛/ 0
>
˛˛0 1)
GetConversationHistoryAsync
˛˛2 M
(
˛˛M N
string
˛˛N T
user1
˛˛U Z
,
˛˛Z [
string
˛˛\ b
user2
˛˛c h
)
˛˛h i
{
ˇˇ 	
var
ÄÄ 
p1
ÄÄ 
=
ÄÄ 
await
ÄÄ 
_playerRepository
ÄÄ ,
.
ÄÄ, -&
GetPlayerByUsernameAsync
ÄÄ- E
(
ÄÄE F
user1
ÄÄF K
)
ÄÄK L
;
ÄÄL M
var
ÅÅ 
p2
ÅÅ 
=
ÅÅ 
await
ÅÅ 
_playerRepository
ÅÅ ,
.
ÅÅ, -&
GetPlayerByUsernameAsync
ÅÅ- E
(
ÅÅE F
user2
ÅÅF K
)
ÅÅK L
;
ÅÅL M
if
ÉÉ 
(
ÉÉ 
p1
ÉÉ 
==
ÉÉ 
null
ÉÉ 
||
ÉÉ 
p2
ÉÉ  
==
ÉÉ! #
null
ÉÉ$ (
)
ÉÉ( )
{
ÑÑ 
return
ÖÖ 
new
ÖÖ 
List
ÖÖ 
<
ÖÖ  
DirectMessageDto
ÖÖ  0
>
ÖÖ0 1
(
ÖÖ1 2
)
ÖÖ2 3
;
ÖÖ3 4
}
ÜÜ 
try
àà 
{
ââ 
var
ää 
messages
ää 
=
ää 
await
ää $
_socialRepository
ää% 6
.
ää6 7)
GetConversationHistoryAsync
ää7 R
(
ääR S
p1
ääS U
.
ääU V
idPlayer
ääV ^
,
ää^ _
p2
ää` b
.
ääb c
idPlayer
ääc k
)
ääk l
;
ääl m
return
ãã 
messages
ãã 
.
ãã  
Select
ãã  &
(
ãã& '
m
ãã' (
=>
ãã) +
new
ãã, /
DirectMessageDto
ãã0 @
{
åå 
SenderUsername
çç "
=
çç# $
m
çç% &
.
çç& '
Player1
çç' .
.
çç. /
username
çç/ 7
,
çç7 8
RecipientUsername
éé %
=
éé& '
m
éé( )
.
éé) *
Player
éé* 0
.
éé0 1
username
éé1 9
,
éé9 :
Content
èè 
=
èè 
m
èè 
.
èè  
MessageContent
èè  .
,
èè. /
	Timestamp
êê 
=
êê 
m
êê  !
.
êê! "
	Timestamp
êê" +
}
ëë 
)
ëë 
.
ëë 
ToList
ëë 
(
ëë 
)
ëë 
;
ëë 
}
íí 
catch
ìì 
(
ìì 
	Exception
ìì 
ex
ìì 
)
ìì  
{
îî 
_log
ïï 
.
ïï 
Error
ïï 
(
ïï 
$str
ïï ;
,
ïï; <
ex
ïï= ?
)
ïï? @
;
ïï@ A
ThrowServiceFault
ññ !
(
ññ! "
ServiceErrorType
ññ" 2
.
ññ2 3
DatabaseError
ññ3 @
,
ññ@ A
$str
ññB d
)
ññd e
;
ññe f
return
óó 
null
óó 
;
óó 
}
òò 
}
ôô 	
private
õõ 
void
õõ 
ThrowServiceFault
õõ &
(
õõ& '
ServiceErrorType
õõ' 7
type
õõ8 <
,
õõ< =
string
õõ> D
message
õõE L
)
õõL M
{
úú 	
var
ùù 
fault
ùù 
=
ùù 
new
ùù 
ServiceFaultDto
ùù +
(
ùù+ ,
type
ùù, 0
,
ùù0 1
message
ùù2 9
)
ùù9 :
;
ùù: ;
throw
ûû 
new
ûû 
FaultException
ûû $
<
ûû$ %
ServiceFaultDto
ûû% 4
>
ûû4 5
(
ûû5 6
fault
ûû6 ;
,
ûû; <
new
ûû= @
FaultReason
ûûA L
(
ûûL M
message
ûûM T
)
ûûT U
)
ûûU V
;
ûûV W
}
üü 	
}
†† 
}°° Û
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
} ãƒ
ôC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\BusinessLogic\MatchmakingLogic.cs
	namespace 	
GuessMyMessServer
 
. 
BusinessLogic )
{ 
public 

class 
MatchmakingLogic !
{ 
private 
static 
readonly 
ILog  $
_log% )
=* +

LogManager, 6
.6 7
	GetLogger7 @
(@ A
typeofA G
(G H
MatchmakingLogicH X
)X Y
)Y Z
;Z [
private 
const 
string 
MatchStatusWaiting /
=0 1
$str2 ;
;; <
private 
static 
readonly  
ConcurrentDictionary  4
<4 5
string5 ;
,; <'
IMatchmakingServiceCallback= X
>X Y
_connectedUsersZ i
=j k
new  
ConcurrentDictionary $
<$ %
string% +
,+ ,'
IMatchmakingServiceCallback- H
>H I
(I J
)J K
;K L
private 
static 
readonly  
ConcurrentDictionary  4
<4 5
string5 ;
,; <

MatchLobby= G
>G H
_activeLobbiesI W
=X Y
new  
ConcurrentDictionary $
<$ %
string% +
,+ ,

MatchLobby- 7
>7 8
(8 9
)9 :
;: ;
private!! 
readonly!! 
IMatchRepository!! )
_matchRepository!!* :
;!!: ;
private"" 
readonly"" 
IPlayerRepository"" *
_playerRepository""+ <
;""< =
private## 
readonly## 
IEmailService## &
_emailService##' 4
;##4 5
public%% 
MatchmakingLogic%% 
(%%  
IMatchRepository&& 
matchRepository&& ,
,&&, -
IPlayerRepository'' 
playerRepository'' .
,''. /
IEmailService(( 
emailService(( &
)((& '
{)) 	
_matchRepository** 
=** 
matchRepository** .
;**. /
_playerRepository++ 
=++ 
playerRepository++  0
;++0 1
_emailService,, 
=,, 
emailService,, (
;,,( )
}-- 	
public// 
void// 
ConnectUser// 
(//  
string//  &
username//' /
)/// 0
{00 	
var11 
callback11 
=11 
OperationContext11 +
.11+ ,
Current11, 3
.113 4
GetCallbackChannel114 F
<11F G'
IMatchmakingServiceCallback11G b
>11b c
(11c d
)11d e
;11e f
_connectedUsers22 
.22 
AddOrUpdate22 '
(22' (
username22( 0
,220 1
callback222 :
,22: ;
(22< =
key22= @
,22@ A
old22B E
)22E F
=>22G I
callback22J R
)22R S
;22S T
_log33 
.33 
Info33 
(33 
$"33 
$str33 
{33 
username33 '
}33' (
$str33( C
"33C D
)33D E
;33E F
}44 	
public66 
void66 
DisconnectUser66 "
(66" #
string66# )
username66* 2
)662 3
{77 	
_connectedUsers88 
.88 
	TryRemove88 %
(88% &
username88& .
,88. /
out880 3
_884 5
)885 6
;886 7
_log99 
.99 
Info99 
(99 
$"99 
$str99 
{99 
username99 '
}99' (
$str99( H
"99H I
)99I J
;99J K
var;; 
lobby;; 
=;; 
_activeLobbies;; &
.;;& '
Values;;' -
.;;- .
FirstOrDefault;;. <
(;;< =
l;;= >
=>;;? A
l;;B C
.;;C D
Players;;D K
.;;K L
Contains;;L T
(;;T U
username;;U ]
);;] ^
);;^ _
;;;_ `
if<< 
(<< 
lobby<< 
!=<< 
null<< 
)<< 
{== 
HandlePlayerLeave>> !
(>>! "
username>>" *
,>>* +
lobby>>, 1
.>>1 2
MatchId>>2 9
)>>9 :
;>>: ;
}?? 
}@@ 	
publicBB 
asyncBB 
TaskBB 
<BB 
OperationResultDtoBB ,
>BB, -
CreateMatchAsyncBB. >
(BB> ?
stringBB? E
hostUsernameBBF R
,BBR S
LobbySettingsDtoBBT d
settingsBBe m
)BBm n
{CC 	
varDD 

hostPlayerDD 
=DD 
awaitDD "
_playerRepositoryDD# 4
.DD4 5$
GetPlayerByUsernameAsyncDD5 M
(DDM N
hostUsernameDDN Z
)DDZ [
;DD[ \
ifEE 
(EE 

hostPlayerEE 
==EE 
nullEE "
)EE" #
{FF 
_logGG 
.GG 
WarnGG 
(GG 
$"GG 
$strGG 6
{GG6 7
hostUsernameGG7 C
}GGC D
$strGGD P
"GGP Q
)GGQ R
;GGR S
ThrowServiceFaultHH !
(HH! "
ServiceErrorTypeHH" 2
.HH2 3
NotFoundHH3 ;
,HH; <
$strHH= S
)HHS T
;HHT U
}II 
stringKK 
newMatchCodeKK 
=KK  !
nullKK" &
;KK& '
byteLL 
isPrivateValueLL 
=LL  !
(LL" #
byteLL# '
)LL' (
(LL( )
settingsLL) 1
.LL1 2
	IsPrivateLL2 ;
?LL< =
$numLL> ?
:LL@ A
$numLLB C
)LLC D
;LLD E
ifNN 
(NN 
settingsNN 
.NN 
	IsPrivateNN "
)NN" #
{OO 
newMatchCodePP 
=PP 
GenerateMatchCodePP 0
(PP0 1
$numPP1 2
)PP2 3
;PP3 4
whileQQ 
(QQ 
awaitQQ 
_matchRepositoryQQ -
.QQ- . 
MatchCodeExistsAsyncQQ. B
(QQB C
newMatchCodeQQC O
)QQO P
)QQP Q
{RR 
newMatchCodeSS  
=SS! "
GenerateMatchCodeSS# 4
(SS4 5
$numSS5 6
)SS6 7
;SS7 8
}TT 
}UU 
varWW 
newMatchWW 
=WW 
newWW 
MatchWW $
{XX 
	matchNameYY 
=YY 
settingsYY $
.YY$ %
	MatchNameYY% .
,YY. /

maxPlayersZZ 
=ZZ 
settingsZZ %
.ZZ% &

MaxPlayersZZ& 0
,ZZ0 1
currentPlayers[[ 
=[[  
$num[[! "
,[[" #
totalRounds\\ 
=\\ 
settings\\ &
.\\& '
TotalRounds\\' 2
,\\2 3
	isPrivate]] 
=]] 
isPrivateValue]] *
,]]* +
	matchCode^^ 
=^^ 
newMatchCode^^ (
,^^( )
matchStatus__ 
=__ 
MatchStatusWaiting__ 0
,__0 1
Player_idHost`` 
=`` 

hostPlayer``  *
.``* +
idPlayer``+ 3
,``3 4-
!MatchDifficulty_idMatchDifficultyaa 1
=aa2 3
settingsaa4 <
.aa< =
DifficultyIdaa= I
}bb 
;bb 
_matchRepositorydd 
.dd 
AddMatchdd %
(dd% &
newMatchdd& .
)dd. /
;dd/ 0
tryff 
{gg 
awaithh 
_matchRepositoryhh &
.hh& '
SaveChangesAsynchh' 7
(hh7 8
)hh8 9
;hh9 :
stringjj 
matchIdjj 
=jj  
newMatchjj! )
.jj) *
idMatchjj* 1
.jj1 2
ToStringjj2 :
(jj: ;
)jj; <
;jj< =
varll 
lobbyll 
=ll 
newll 

MatchLobbyll  *
(ll* +
matchIdll+ 2
,ll2 3
newMatchCodell4 @
,ll@ A
hostUsernamellB N
,llN O
settingsllP X
)llX Y
;llY Z
lobbymm 
.mm 
Playersmm 
.mm 
Addmm !
(mm! "
hostUsernamemm" .
)mm. /
;mm/ 0
lobbynn 
.nn 
CurrentPlayersnn $
=nn% &
$numnn' (
;nn( )
lobbyoo 
.oo 
DifficultyNameoo $
=oo% &
awaitoo' ,
_matchRepositoryoo- =
.oo= >"
GetDifficultyNameAsyncoo> T
(ooT U
settingsooU ]
.oo] ^
DifficultyIdoo^ j
)ooj k
;ook l
_activeLobbiesqq 
.qq 
TryAddqq %
(qq% &
matchIdqq& -
,qq- .
lobbyqq/ 4
)qq4 5
;qq5 6
_logss 
.ss 
Infoss 
(ss 
$"ss 
$strss +
{ss+ ,
matchIdss, 3
}ss3 4
$strss4 8
{ss8 9
hostUsernamess9 E
}ssE F
"ssF G
)ssG H
;ssH I
ifuu 
(uu 
!uu 
settingsuu 
.uu 
	IsPrivateuu '
)uu' (
{vv $
BroadcastPublicMatchListww ,
(ww, -
)ww- .
;ww. /
}xx 
returnzz 
newzz 
OperationResultDtozz -
{{{ 
Success|| 
=|| 
true|| "
,||" #
Message}} 
=}} 
$str}} .
,}}. /
Data~~ 
=~~ 
new~~ 

Dictionary~~ )
<~~) *
string~~* 0
,~~0 1
string~~2 8
>~~8 9
{ 
{
ÄÄ 
$str
ÄÄ #
,
ÄÄ# $
matchId
ÄÄ% ,
}
ÄÄ- .
,
ÄÄ. /
{
ÅÅ 
$str
ÅÅ %
,
ÅÅ% &
newMatchCode
ÅÅ' 3
}
ÅÅ4 5
}
ÇÇ 
}
ÉÉ 
;
ÉÉ 
}
ÑÑ 
catch
ÖÖ 
(
ÖÖ 
	Exception
ÖÖ 
ex
ÖÖ 
)
ÖÖ  
{
ÜÜ 
_log
áá 
.
áá 
Error
áá 
(
áá 
$"
áá 
$str
áá 7
{
áá7 8
hostUsername
áá8 D
}
ááD E
$str
ááE F
"
ááF G
,
ááG H
ex
ááI K
)
ááK L
;
ááL M
ThrowServiceFault
àà !
(
àà! "
ServiceErrorType
àà" 2
.
àà2 3
DatabaseError
àà3 @
,
àà@ A
$str
ààB [
)
àà[ \
;
àà\ ]
return
ââ 
null
ââ 
;
ââ 
}
ää 
}
ãã 	
public
çç 
List
çç 
<
çç 
MatchInfoDto
çç  
>
çç  !
GetPublicMatches
çç" 2
(
çç2 3
)
çç3 4
{
éé 	
return
èè 
_activeLobbies
èè !
.
èè! "
Values
èè" (
.
êê 
Where
êê 
(
êê 
l
êê 
=>
êê 
!
êê 
l
êê 
.
êê 
Settings
êê '
.
êê' (
	IsPrivate
êê( 1
&&
êê2 4
l
êê5 6
.
êê6 7
Status
êê7 =
==
êê> @ 
MatchStatusWaiting
êêA S
)
êêS T
.
ëë 
Select
ëë 
(
ëë 
l
ëë 
=>
ëë 
l
ëë 
.
ëë 
ToMatchInfoDto
ëë -
(
ëë- .
)
ëë. /
)
ëë/ 0
.
íí 
ToList
íí 
(
íí 
)
íí 
;
íí 
}
ìì 	
public
ïï 
async
ïï 
Task
ïï 
<
ïï  
OperationResultDto
ïï ,
>
ïï, -"
JoinPublicMatchAsync
ïï. B
(
ïïB C
string
ïïC I
username
ïïJ R
,
ïïR S
string
ïïT Z
matchId
ïï[ b
)
ïïb c
{
ññ 	
if
óó 
(
óó 
!
óó 
_connectedUsers
óó  
.
óó  !
ContainsKey
óó! ,
(
óó, -
username
óó- 5
)
óó5 6
)
óó6 7
{
òò 
ThrowServiceFault
ôô !
(
ôô! "
ServiceErrorType
ôô" 2
.
ôô2 3
OperationFailed
ôô3 B
,
ôôB C
$str
ôôD h
)
ôôh i
;
ôôi j
}
öö 
if
úú 
(
úú 
!
úú 
_activeLobbies
úú 
.
úú  
TryGetValue
úú  +
(
úú+ ,
matchId
úú, 3
,
úú3 4
out
úú5 8
var
úú9 <
lobby
úú= B
)
úúB C
)
úúC D
{
ùù 
ThrowServiceFault
ûû !
(
ûû! "
ServiceErrorType
ûû" 2
.
ûû2 3
MatchNotFound
ûû3 @
,
ûû@ A
$str
ûûB _
)
ûû_ `
;
ûû` a
}
üü 
return
°° 
await
°° $
JoinLobbyInternalAsync
°° /
(
°°/ 0
username
°°0 8
,
°°8 9
lobby
°°: ?
)
°°? @
;
°°@ A
}
¢¢ 	
public
§§ 
async
§§ 
Task
§§ 
<
§§  
OperationResultDto
§§ ,
>
§§, -#
JoinPrivateMatchAsync
§§. C
(
§§C D
string
§§D J
username
§§K S
,
§§S T
string
§§U [
	matchCode
§§\ e
)
§§e f
{
•• 	
if
¶¶ 
(
¶¶ 
string
¶¶ 
.
¶¶  
IsNullOrWhiteSpace
¶¶ )
(
¶¶) *
	matchCode
¶¶* 3
)
¶¶3 4
)
¶¶4 5
{
ßß 
ThrowServiceFault
®® !
(
®®! "
ServiceErrorType
®®" 2
.
®®2 3
OperationFailed
®®3 B
,
®®B C
$str
®®D ]
)
®®] ^
;
®®^ _
}
©© 
var
´´ 
lobby
´´ 
=
´´ 
_activeLobbies
´´ &
.
´´& '
Values
´´' -
.
´´- .
FirstOrDefault
´´. <
(
´´< =
l
´´= >
=>
´´? A
l
´´B C
.
´´C D
	MatchCode
´´D M
==
´´N P
	matchCode
´´Q Z
&&
´´[ ]
l
´´^ _
.
´´_ `
Status
´´` f
==
´´g i 
MatchStatusWaiting
´´j |
)
´´| }
;
´´} ~
if
≠≠ 
(
≠≠ 
lobby
≠≠ 
==
≠≠ 
null
≠≠ 
)
≠≠ 
{
ÆÆ 
ThrowServiceFault
ØØ !
(
ØØ! "
ServiceErrorType
ØØ" 2
.
ØØ2 3
MatchNotFound
ØØ3 @
,
ØØ@ A
$str
ØØB b
)
ØØb c
;
ØØc d
}
∞∞ 
return
≤≤ 
await
≤≤ $
JoinLobbyInternalAsync
≤≤ /
(
≤≤/ 0
username
≤≤0 8
,
≤≤8 9
lobby
≤≤: ?
)
≤≤? @
;
≤≤@ A
}
≥≥ 	
private
µµ 
async
µµ 
Task
µµ 
<
µµ  
OperationResultDto
µµ -
>
µµ- .$
JoinLobbyInternalAsync
µµ/ E
(
µµE F
string
µµF L
username
µµM U
,
µµU V

MatchLobby
µµW a
lobby
µµb g
)
µµg h
{
∂∂ 	
if
∑∑ 
(
∑∑ 
lobby
∑∑ 
.
∑∑ 
Players
∑∑ 
.
∑∑ 
Contains
∑∑ &
(
∑∑& '
username
∑∑' /
)
∑∑/ 0
)
∑∑0 1
{
∏∏ 
return
ππ 
new
ππ  
OperationResultDto
ππ -
{
ππ. /
Success
ππ0 7
=
ππ8 9
true
ππ: >
,
ππ> ?
Message
ππ@ G
=
ππH I
$str
ππJ ]
,
ππ] ^
Data
ππ_ c
=
ππd e
new
ππf i

Dictionary
ππj t
<
ππt u
string
ππu {
,
ππ{ |
stringππ} É
>ππÉ Ñ
{ππÖ Ü
{ππá à
$strππâ í
,ππí ì
lobbyππî ô
.ππô ö
MatchIdππö °
}ππ¢ £
}ππ§ •
}ππ¶ ß
;ππß ®
}
∫∫ 
if
ºº 
(
ºº 
lobby
ºº 
.
ºº 
CurrentPlayers
ºº $
>=
ºº% '
lobby
ºº( -
.
ºº- .
Settings
ºº. 6
.
ºº6 7

MaxPlayers
ºº7 A
)
ººA B
{
ΩΩ 
ThrowServiceFault
ææ !
(
ææ! "
ServiceErrorType
ææ" 2
.
ææ2 3
	LobbyFull
ææ3 <
,
ææ< =
$str
ææ> R
)
ææR S
;
ææS T
}
øø 
if
¡¡ 
(
¡¡ 
lobby
¡¡ 
.
¡¡ 
Status
¡¡ 
!=
¡¡  
MatchStatusWaiting
¡¡  2
)
¡¡2 3
{
¬¬ 
ThrowServiceFault
√√ !
(
√√! "
ServiceErrorType
√√" 2
.
√√2 3
GameInProgress
√√3 A
,
√√A B
$str
√√C _
)
√√_ `
;
√√` a
}
ƒƒ 
lobby
∆∆ 
.
∆∆ 
Players
∆∆ 
.
∆∆ 
Add
∆∆ 
(
∆∆ 
username
∆∆ &
)
∆∆& '
;
∆∆' (
lobby
«« 
.
«« 
CurrentPlayers
««  
++
««  "
;
««" #
await
…… (
UpdatePlayerCountInDbAsync
…… ,
(
……, -
lobby
……- 2
.
……2 3
MatchId
……3 :
,
……: ;
$num
……< =
)
……= >
;
……> ?
_log
ÀÀ 
.
ÀÀ 
Info
ÀÀ 
(
ÀÀ 
$"
ÀÀ 
$str
ÀÀ 
{
ÀÀ 
username
ÀÀ '
}
ÀÀ' (
$str
ÀÀ( 7
{
ÀÀ7 8
lobby
ÀÀ8 =
.
ÀÀ= >
MatchId
ÀÀ> E
}
ÀÀE F
$str
ÀÀF G
"
ÀÀG H
)
ÀÀH I
;
ÀÀI J"
BroadcastLobbyUpdate
ÕÕ  
(
ÕÕ  !
lobby
ÕÕ! &
)
ÕÕ& '
;
ÕÕ' (
if
ŒŒ 
(
ŒŒ 
!
ŒŒ 
lobby
ŒŒ 
.
ŒŒ 
Settings
ŒŒ 
.
ŒŒ  
	IsPrivate
ŒŒ  )
)
ŒŒ) *
{
œœ &
BroadcastPublicMatchList
–– (
(
––( )
)
––) *
;
––* +
}
—— 
return
”” 
new
””  
OperationResultDto
”” )
{
‘‘ 
Success
’’ 
=
’’ 
true
’’ 
,
’’ 
Message
÷÷ 
=
÷÷ 
$str
÷÷ 0
,
÷÷0 1
Data
◊◊ 
=
◊◊ 
new
◊◊ 

Dictionary
◊◊ %
<
◊◊% &
string
◊◊& ,
,
◊◊, -
string
◊◊. 4
>
◊◊4 5
{
◊◊6 7
{
◊◊8 9
$str
◊◊: C
,
◊◊C D
lobby
◊◊E J
.
◊◊J K
MatchId
◊◊K R
}
◊◊S T
}
◊◊U V
}
ÿÿ 
;
ÿÿ 
}
ŸŸ 	
public
€€ 
void
€€ 
InviteToMatch
€€ !
(
€€! "
string
€€" (
inviterUsername
€€) 8
,
€€8 9
string
€€: @
invitedUsername
€€A P
,
€€P Q
string
€€R X
matchId
€€Y `
)
€€` a
{
‹‹ 	
if
›› 
(
›› 
_connectedUsers
›› 
.
››  
TryGetValue
››  +
(
››+ ,
invitedUsername
››, ;
,
››; <
out
››= @
var
››A D
callback
››E M
)
››M N
)
››N O
{
ﬁﬁ 
SafeCallback
ﬂﬂ 
(
ﬂﬂ 
callback
ﬂﬂ %
,
ﬂﬂ% &
c
ﬂﬂ' (
=>
ﬂﬂ) +
c
ﬂﬂ, -
.
ﬂﬂ- . 
ReceiveMatchInvite
ﬂﬂ. @
(
ﬂﬂ@ A
inviterUsername
ﬂﬂA P
,
ﬂﬂP Q
matchId
ﬂﬂR Y
)
ﬂﬂY Z
)
ﬂﬂZ [
;
ﬂﬂ[ \
_log
‡‡ 
.
‡‡ 
Info
‡‡ 
(
‡‡ 
$"
‡‡ 
$str
‡‡ )
{
‡‡) *
inviterUsername
‡‡* 9
}
‡‡9 :
$str
‡‡: >
{
‡‡> ?
invitedUsername
‡‡? N
}
‡‡N O
$str
‡‡O W
{
‡‡W X
matchId
‡‡X _
}
‡‡_ `
$str
‡‡` a
"
‡‡a b
)
‡‡b c
;
‡‡c d
}
·· 
else
‚‚ 
{
„„ 
_log
‰‰ 
.
‰‰ 
Info
‰‰ 
(
‰‰ 
$"
‰‰ 
$str
‰‰ +
{
‰‰+ ,
invitedUsername
‰‰, ;
}
‰‰; <
$str
‰‰< K
"
‰‰K L
)
‰‰L M
;
‰‰M N
}
ÂÂ 
}
ÊÊ 	
public
ËË 
async
ËË 
Task
ËË %
InviteGuestByEmailAsync
ËË 1
(
ËË1 2
string
ËË2 8
inviterUsername
ËË9 H
,
ËËH I
string
ËËJ P
targetEmail
ËËQ \
,
ËË\ ]
string
ËË^ d
matchId
ËËe l
)
ËËl m
{
ÈÈ 	
var
ÍÍ 
existingUser
ÍÍ 
=
ÍÍ 
await
ÍÍ $
_playerRepository
ÍÍ% 6
.
ÍÍ6 7#
GetPlayerByEmailAsync
ÍÍ7 L
(
ÍÍL M
targetEmail
ÍÍM X
)
ÍÍX Y
;
ÍÍY Z
if
ÎÎ 
(
ÎÎ 
existingUser
ÎÎ 
!=
ÎÎ 
null
ÎÎ  $
)
ÎÎ$ %
{
ÏÏ 
ThrowServiceFault
ÌÌ !
(
ÌÌ! "
ServiceErrorType
ÌÌ" 2
.
ÌÌ2 3$
EmailAlreadyRegistered
ÌÌ3 I
,
ÌÌI J
$strÌÌK Å
)ÌÌÅ Ç
;ÌÌÇ É
}
ÓÓ 
string
 
code
 
=
  
GuestInviteManager
 ,
.
, -
CreateInvite
- 9
(
9 :
targetEmail
: E
,
E F
matchId
G N
)
N O
;
O P
try
ÚÚ 
{
ÛÛ 
var
ÙÙ 
emailTemplate
ÙÙ !
=
ÙÙ" #
new
ÙÙ$ '-
InvitationForMatchEmailTemplate
ÙÙ( G
(
ÙÙG H
code
ÙÙH L
)
ÙÙL M
;
ÙÙM N
await
ıı 
_emailService
ıı #
.
ıı# $
SendEmailAsync
ıı$ 2
(
ıı2 3
targetEmail
ıı3 >
,
ıı> ?
$str
ıı@ Q
,
ııQ R
emailTemplate
ııS `
)
ıı` a
;
ııa b
_log
ˆˆ 
.
ˆˆ 
Info
ˆˆ 
(
ˆˆ 
$"
ˆˆ 
$str
ˆˆ 1
{
ˆˆ1 2
targetEmail
ˆˆ2 =
}
ˆˆ= >
"
ˆˆ> ?
)
ˆˆ? @
;
ˆˆ@ A
}
˜˜ 
catch
¯¯ 
(
¯¯ 
	Exception
¯¯ 
ex
¯¯ 
)
¯¯  
{
˘˘ 
_log
˙˙ 
.
˙˙ 
Error
˙˙ 
(
˙˙ 
$"
˙˙ 
$str
˙˙ ;
{
˙˙; <
targetEmail
˙˙< G
}
˙˙G H
"
˙˙H I
,
˙˙I J
ex
˙˙K M
)
˙˙M N
;
˙˙N O
ThrowServiceFault
˚˚ !
(
˚˚! "
ServiceErrorType
˚˚" 2
.
˚˚2 3
OperationFailed
˚˚3 B
,
˚˚B C
$str
˚˚D f
)
˚˚f g
;
˚˚g h
}
¸¸ 
}
˝˝ 	
public
ˇˇ 
void
ˇˇ 
HandlePlayerLeave
ˇˇ %
(
ˇˇ% &
string
ˇˇ& ,
username
ˇˇ- 5
,
ˇˇ5 6
string
ˇˇ7 =
matchId
ˇˇ> E
)
ˇˇE F
{
ÄÄ 	
if
ÅÅ 
(
ÅÅ 
_activeLobbies
ÅÅ 
.
ÅÅ 
TryGetValue
ÅÅ *
(
ÅÅ* +
matchId
ÅÅ+ 2
,
ÅÅ2 3
out
ÅÅ4 7
var
ÅÅ8 ;
lobby
ÅÅ< A
)
ÅÅA B
)
ÅÅB C
{
ÇÇ 
bool
ÉÉ 
removed
ÉÉ 
=
ÉÉ 
lobby
ÉÉ $
.
ÉÉ$ %
Players
ÉÉ% ,
.
ÉÉ, -
Remove
ÉÉ- 3
(
ÉÉ3 4
username
ÉÉ4 <
)
ÉÉ< =
;
ÉÉ= >
if
ÑÑ 
(
ÑÑ 
removed
ÑÑ 
)
ÑÑ 
{
ÖÖ 
lobby
ÜÜ 
.
ÜÜ 
CurrentPlayers
ÜÜ (
--
ÜÜ( *
;
ÜÜ* +
_
áá 
=
áá (
UpdatePlayerCountInDbAsync
áá 2
(
áá2 3
matchId
áá3 :
,
áá: ;
-
áá< =
$num
áá= >
)
áá> ?
;
áá? @
_log
àà 
.
àà 
Info
àà 
(
àà 
$"
àà  
$str
àà  '
{
àà' (
username
àà( 0
}
àà0 1
$str
àà1 7
{
àà7 8
matchId
àà8 ?
}
àà? @
$str
àà@ A
"
ààA B
)
ààB C
;
ààC D
}
ââ 
if
ãã 
(
ãã 
lobby
ãã 
.
ãã 
Players
ãã !
.
ãã! "
Count
ãã" '
==
ãã( *
$num
ãã+ ,
||
ãã- /
(
ãã0 1
lobby
ãã1 6
.
ãã6 7
HostUsername
ãã7 C
==
ããD F
username
ããG O
&&
ããP R
lobby
ããS X
.
ããX Y
Status
ããY _
==
ãã` b
$str
ããc l
)
ããl m
)
ããm n
{
åå 
_log
çç 
.
çç 
Info
çç 
(
çç 
$"
çç  
$str
çç  .
{
çç. /
matchId
çç/ 6
}
çç6 7
$str
çç7 8
"
çç8 9
)
çç9 :
;
çç: ;
_activeLobbies
éé "
.
éé" #
	TryRemove
éé# ,
(
éé, -
matchId
éé- 4
,
éé4 5
out
éé6 9
_
éé: ;
)
éé; <
;
éé< =
if
êê 
(
êê 
lobby
êê 
.
êê 
Status
êê $
!=
êê% '
$str
êê( 2
)
êê2 3
{
ëë 
_
íí 
=
íí (
UpdateMatchStatusInDbAsync
íí 6
(
íí6 7
matchId
íí7 >
,
íí> ?
$str
íí@ I
)
ííI J
;
ííJ K
}
ìì 
if
ïï 
(
ïï 
!
ïï 
lobby
ïï 
.
ïï 
Settings
ïï '
.
ïï' (
	IsPrivate
ïï( 1
)
ïï1 2
{
ññ &
BroadcastPublicMatchList
óó 0
(
óó0 1
)
óó1 2
;
óó2 3
}
òò 
}
ôô 
else
öö 
if
öö 
(
öö 
removed
öö  
)
öö  !
{
õõ "
BroadcastLobbyUpdate
úú (
(
úú( )
lobby
úú) .
)
úú. /
;
úú/ 0
if
ùù 
(
ùù 
!
ùù 
lobby
ùù 
.
ùù 
Settings
ùù '
.
ùù' (
	IsPrivate
ùù( 1
)
ùù1 2
{
ûû &
BroadcastPublicMatchList
üü 0
(
üü0 1
)
üü1 2
;
üü2 3
}
†† 
}
°° 
}
¢¢ 
}
££ 	
public
•• 
void
•• 
SetMatchAsPlaying
•• %
(
••% &
string
••& ,
matchId
••- 4
)
••4 5
{
¶¶ 	
if
ßß 
(
ßß 
_activeLobbies
ßß 
.
ßß 
TryGetValue
ßß *
(
ßß* +
matchId
ßß+ 2
,
ßß2 3
out
ßß4 7
var
ßß8 ;
lobby
ßß< A
)
ßßA B
)
ßßB C
{
®® 
lobby
©© 
.
©© 
Status
©© 
=
©© 
$str
©© (
;
©©( )
_
™™ 
=
™™ (
UpdateMatchStatusInDbAsync
™™ .
(
™™. /
matchId
™™/ 6
,
™™6 7
$str
™™8 A
)
™™A B
;
™™B C&
BroadcastPublicMatchList
´´ (
(
´´( )
)
´´) *
;
´´* +
}
¨¨ 
}
≠≠ 	
public
ØØ 
void
ØØ  
SetMatchAsFinished
ØØ &
(
ØØ& '
string
ØØ' -
matchId
ØØ. 5
)
ØØ5 6
{
∞∞ 	
if
±± 
(
±± 
_activeLobbies
±± 
.
±± 
TryGetValue
±± *
(
±±* +
matchId
±±+ 2
,
±±2 3
out
±±4 7
var
±±8 ;
lobby
±±< A
)
±±A B
)
±±B C
{
≤≤ 
lobby
≥≥ 
.
≥≥ 
Status
≥≥ 
=
≥≥ 
$str
≥≥ )
;
≥≥) *
}
¥¥ 
}
µµ 	
private
∑∑ 
async
∑∑ 
Task
∑∑ (
UpdatePlayerCountInDbAsync
∑∑ 5
(
∑∑5 6
string
∑∑6 <

matchIdStr
∑∑= G
,
∑∑G H
int
∑∑I L
change
∑∑M S
)
∑∑S T
{
∏∏ 	
if
ππ 
(
ππ 
!
ππ 
int
ππ 
.
ππ 
TryParse
ππ 
(
ππ 

matchIdStr
ππ (
,
ππ( )
out
ππ* -
int
ππ. 1
matchId
ππ2 9
)
ππ9 :
)
ππ: ;
{
∫∫ 
return
ªª 
;
ªª 
}
ºº 
try
ææ 
{
øø 
var
¿¿ 
match
¿¿ 
=
¿¿ 
await
¿¿ !
_matchRepository
¿¿" 2
.
¿¿2 3
GetMatchByIdAsync
¿¿3 D
(
¿¿D E
matchId
¿¿E L
)
¿¿L M
;
¿¿M N
if
¡¡ 
(
¡¡ 
match
¡¡ 
!=
¡¡ 
null
¡¡ !
)
¡¡! "
{
¬¬ 
match
√√ 
.
√√ 
currentPlayers
√√ (
+=
√√) +
change
√√, 2
;
√√2 3
if
ƒƒ 
(
ƒƒ 
match
ƒƒ 
.
ƒƒ 
currentPlayers
ƒƒ ,
<
ƒƒ- .
$num
ƒƒ/ 0
)
ƒƒ0 1
{
≈≈ 
match
∆∆ 
.
∆∆ 
currentPlayers
∆∆ ,
=
∆∆- .
$num
∆∆/ 0
;
∆∆0 1
}
«« 
await
»» 
_matchRepository
»» *
.
»»* +
SaveChangesAsync
»»+ ;
(
»»; <
)
»»< =
;
»»= >
}
…… 
}
   
catch
ÀÀ 
(
ÀÀ 
	Exception
ÀÀ 
ex
ÀÀ 
)
ÀÀ  
{
ÃÃ 
_log
ÕÕ 
.
ÕÕ 
Error
ÕÕ 
(
ÕÕ 
$"
ÕÕ 
$str
ÕÕ F
{
ÕÕF G
matchId
ÕÕG N
}
ÕÕN O
"
ÕÕO P
,
ÕÕP Q
ex
ÕÕR T
)
ÕÕT U
;
ÕÕU V
}
ŒŒ 
}
œœ 	
private
—— 
async
—— 
Task
—— (
UpdateMatchStatusInDbAsync
—— 5
(
——5 6
string
——6 <

matchIdStr
——= G
,
——G H
string
——I O
status
——P V
)
——V W
{
““ 	
if
”” 
(
”” 
!
”” 
int
”” 
.
”” 
TryParse
”” 
(
”” 

matchIdStr
”” (
,
””( )
out
””* -
int
””. 1
matchId
””2 9
)
””9 :
)
””: ;
{
‘‘ 
return
’’ 
;
’’ 
}
÷÷ 
using
ÿÿ 
(
ÿÿ 
var
ÿÿ 
scope
ÿÿ 
=
ÿÿ 
Bootstrapper
ÿÿ +
.
ÿÿ+ ,
	Container
ÿÿ, 5
.
ÿÿ5 6 
BeginLifetimeScope
ÿÿ6 H
(
ÿÿH I
)
ÿÿI J
)
ÿÿJ K
{
ŸŸ 
try
⁄⁄ 
{
€€ 
var
‹‹ 
	matchRepo
‹‹ !
=
‹‹" #
scope
‹‹$ )
.
‹‹) *
Resolve
‹‹* 1
<
‹‹1 2
IMatchRepository
‹‹2 B
>
‹‹B C
(
‹‹C D
)
‹‹D E
;
‹‹E F
var
ﬁﬁ 
match
ﬁﬁ 
=
ﬁﬁ 
await
ﬁﬁ  %
	matchRepo
ﬁﬁ& /
.
ﬁﬁ/ 0
GetMatchByIdAsync
ﬁﬁ0 A
(
ﬁﬁA B
matchId
ﬁﬁB I
)
ﬁﬁI J
;
ﬁﬁJ K
if
ﬂﬂ 
(
ﬂﬂ 
match
ﬂﬂ 
!=
ﬂﬂ  
null
ﬂﬂ! %
)
ﬂﬂ% &
{
‡‡ 
match
·· 
.
·· 
matchStatus
·· )
=
··* +
status
··, 2
;
··2 3
await
‚‚ 
	matchRepo
‚‚ '
.
‚‚' (
SaveChangesAsync
‚‚( 8
(
‚‚8 9
)
‚‚9 :
;
‚‚: ;
}
„„ 
}
‰‰ 
catch
ÂÂ 
(
ÂÂ 
	Exception
ÂÂ  
ex
ÂÂ! #
)
ÂÂ# $
{
ÊÊ 
_log
ÁÁ 
.
ÁÁ 
Error
ÁÁ 
(
ÁÁ 
$"
ÁÁ !
$str
ÁÁ! D
{
ÁÁD E
matchId
ÁÁE L
}
ÁÁL M
"
ÁÁM N
,
ÁÁN O
ex
ÁÁP R
)
ÁÁR S
;
ÁÁS T
}
ËË 
}
ÈÈ 
}
ÍÍ 	
private
ÏÏ 
void
ÏÏ &
BroadcastPublicMatchList
ÏÏ -
(
ÏÏ- .
)
ÏÏ. /
{
ÌÌ 	
var
ÓÓ 
list
ÓÓ 
=
ÓÓ 
GetPublicMatches
ÓÓ '
(
ÓÓ' (
)
ÓÓ( )
;
ÓÓ) *
foreach
ÔÔ 
(
ÔÔ 
var
ÔÔ 
cb
ÔÔ 
in
ÔÔ 
_connectedUsers
ÔÔ .
.
ÔÔ. /
Values
ÔÔ/ 5
)
ÔÔ5 6
{
 
SafeCallback
ÒÒ 
(
ÒÒ 
cb
ÒÒ 
,
ÒÒ  
c
ÒÒ! "
=>
ÒÒ# %
c
ÒÒ& '
.
ÒÒ' (&
PublicMatchesListUpdated
ÒÒ( @
(
ÒÒ@ A
list
ÒÒA E
)
ÒÒE F
)
ÒÒF G
;
ÒÒG H
}
ÚÚ 
}
ÛÛ 	
private
ıı 
void
ıı "
BroadcastLobbyUpdate
ıı )
(
ıı) *

MatchLobby
ıı* 4
lobby
ıı5 :
)
ıı: ;
{
ˆˆ 	
var
˜˜ 
info
˜˜ 
=
˜˜ 
lobby
˜˜ 
.
˜˜ 
ToMatchInfoDto
˜˜ +
(
˜˜+ ,
)
˜˜, -
;
˜˜- .
foreach
¯¯ 
(
¯¯ 
var
¯¯ 
p
¯¯ 
in
¯¯ 
lobby
¯¯ #
.
¯¯# $
Players
¯¯$ +
)
¯¯+ ,
{
˘˘ 
if
˙˙ 
(
˙˙ 
_connectedUsers
˙˙ #
.
˙˙# $
TryGetValue
˙˙$ /
(
˙˙/ 0
p
˙˙0 1
,
˙˙1 2
out
˙˙3 6
var
˙˙7 :
cb
˙˙; =
)
˙˙= >
)
˙˙> ?
{
˚˚ 
SafeCallback
¸¸  
(
¸¸  !
cb
¸¸! #
,
¸¸# $
c
¸¸% &
=>
¸¸' )
c
¸¸* +
.
¸¸+ ,
MatchUpdate
¸¸, 7
(
¸¸7 8
info
¸¸8 <
)
¸¸< =
)
¸¸= >
;
¸¸> ?
}
˝˝ 
}
˛˛ 
}
ˇˇ 	
private
ÅÅ 
void
ÅÅ 
SafeCallback
ÅÅ !
(
ÅÅ! ")
IMatchmakingServiceCallback
ÅÅ" =
callback
ÅÅ> F
,
ÅÅF G
Action
ÅÅH N
<
ÅÅN O)
IMatchmakingServiceCallback
ÅÅO j
>
ÅÅj k
action
ÅÅl r
)
ÅÅr s
{
ÇÇ 	
try
ÉÉ 
{
ÑÑ 
action
ÖÖ 
(
ÖÖ 
callback
ÖÖ 
)
ÖÖ  
;
ÖÖ  !
}
ÜÜ 
catch
áá 
(
áá 
	Exception
áá 
)
áá 
{
àà 
}
ââ 
}
ää 	
private
åå 
string
åå 
GenerateMatchCode
åå (
(
åå( )
int
åå) ,
length
åå- 3
)
åå3 4
{
çç 	
const
éé 
string
éé 
chars
éé 
=
éé  
$str
éé! E
;
ééE F
using
èè 
(
èè 
var
èè 
crypto
èè 
=
èè 
new
èè  #&
RNGCryptoServiceProvider
èè$ <
(
èè< =
)
èè= >
)
èè> ?
{
êê 
var
ëë 
data
ëë 
=
ëë 
new
ëë 
byte
ëë #
[
ëë# $
length
ëë$ *
]
ëë* +
;
ëë+ ,
crypto
íí 
.
íí 
GetBytes
íí 
(
íí  
data
íí  $
)
íí$ %
;
íí% &
var
ìì 
result
ìì 
=
ìì 
new
ìì  
StringBuilder
ìì! .
(
ìì. /
length
ìì/ 5
)
ìì5 6
;
ìì6 7
foreach
îî 
(
îî 
byte
îî 
b
îî 
in
îî  "
data
îî# '
)
îî' (
result
îî) /
.
îî/ 0
Append
îî0 6
(
îî6 7
chars
îî7 <
[
îî< =
b
îî= >
%
îî? @
chars
îîA F
.
îîF G
Length
îîG M
]
îîM N
)
îîN O
;
îîO P
return
ïï 
result
ïï 
.
ïï 
ToString
ïï &
(
ïï& '
)
ïï' (
;
ïï( )
}
ññ 
}
óó 	
private
ôô 
void
ôô 
ThrowServiceFault
ôô &
(
ôô& '
ServiceErrorType
ôô' 7
type
ôô8 <
,
ôô< =
string
ôô> D
message
ôôE L
)
ôôL M
{
öö 	
throw
õõ 
new
õõ 
FaultException
õõ $
<
õõ$ %
ServiceFaultDto
õõ% 4
>
õõ4 5
(
õõ5 6
new
õõ6 9
ServiceFaultDto
õõ: I
(
õõI J
type
õõJ N
,
õõN O
message
õõP W
)
õõW X
,
õõX Y
new
õõZ ]
FaultReason
õõ^ i
(
õõi j
message
õõj q
)
õõq r
)
õõr s
;
õõs t
}
úú 	
}
ùù 
public
üü 

class
üü 

MatchLobby
üü 
{
†† 
public
°° 
string
°° 
MatchId
°° 
{
°° 
get
°°  #
;
°°# $
set
°°% (
;
°°( )
}
°°* +
public
¢¢ 
string
¢¢ 
	MatchCode
¢¢ 
{
¢¢  !
get
¢¢" %
;
¢¢% &
set
¢¢' *
;
¢¢* +
}
¢¢, -
public
££ 
string
££ 
HostUsername
££ "
{
££# $
get
££% (
;
££( )
set
££* -
;
££- .
}
££/ 0
public
§§ 
LobbySettingsDto
§§ 
Settings
§§  (
{
§§) *
get
§§+ .
;
§§. /
set
§§0 3
;
§§3 4
}
§§5 6
public
•• 
List
•• 
<
•• 
string
•• 
>
•• 
Players
•• #
{
••$ %
get
••& )
;
••) *
set
••+ .
;
••. /
}
••0 1
=
••2 3
new
••4 7
List
••8 <
<
••< =
string
••= C
>
••C D
(
••D E
)
••E F
;
••F G
public
¶¶ 
string
¶¶ 
Status
¶¶ 
{
¶¶ 
get
¶¶ "
;
¶¶" #
set
¶¶$ '
;
¶¶' (
}
¶¶) *
=
¶¶+ ,
$str
¶¶- 6
;
¶¶6 7
public
ßß 
int
ßß 
CurrentPlayers
ßß !
{
ßß" #
get
ßß$ '
;
ßß' (
set
ßß) ,
;
ßß, -
}
ßß. /
public
®® 
string
®® 
DifficultyName
®® $
{
®®% &
get
®®' *
;
®®* +
set
®®, /
;
®®/ 0
}
®®1 2
public
™™ 

MatchLobby
™™ 
(
™™ 
string
™™  
matchId
™™! (
,
™™( )
string
™™* 0
	matchCode
™™1 :
,
™™: ;
string
™™< B
host
™™C G
,
™™G H
LobbySettingsDto
™™I Y
settings
™™Z b
)
™™b c
{
´´ 	
MatchId
¨¨ 
=
¨¨ 
matchId
¨¨ 
;
¨¨ 
	MatchCode
≠≠ 
=
≠≠ 
	matchCode
≠≠ !
;
≠≠! "
HostUsername
ÆÆ 
=
ÆÆ 
host
ÆÆ 
;
ÆÆ  
Settings
ØØ 
=
ØØ 
settings
ØØ 
;
ØØ  
}
∞∞ 	
public
≤≤ 
MatchInfoDto
≤≤ 
ToMatchInfoDto
≤≤ *
(
≤≤* +
)
≤≤+ ,
{
≥≥ 	
return
¥¥ 
new
¥¥ 
MatchInfoDto
¥¥ #
{
µµ 
MatchId
∂∂ 
=
∂∂ 
this
∂∂ 
.
∂∂ 
MatchId
∂∂ &
,
∂∂& '
	MatchName
∑∑ 
=
∑∑ 
this
∑∑  
.
∑∑  !
Settings
∑∑! )
.
∑∑) *
	MatchName
∑∑* 3
,
∑∑3 4
HostUsername
∏∏ 
=
∏∏ 
this
∏∏ #
.
∏∏# $
HostUsername
∏∏$ 0
,
∏∏0 1
CurrentPlayers
ππ 
=
ππ  
this
ππ! %
.
ππ% &
CurrentPlayers
ππ& 4
,
ππ4 5

MaxPlayers
∫∫ 
=
∫∫ 
this
∫∫ !
.
∫∫! "
Settings
∫∫" *
.
∫∫* +

MaxPlayers
∫∫+ 5
,
∫∫5 6
DifficultyName
ªª 
=
ªª  
this
ªª! %
.
ªª% &
DifficultyName
ªª& 4
??
ªª5 7
$str
ªª8 A
}
ºº 
;
ºº 
}
ΩΩ 	
}
ææ 
}øø Ì
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
} ˘
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
} ™	
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
} ∏

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
} ‡
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
} ÿ
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
}"" ‰
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
} ¥
£C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\DataContracts\FriendProfileDto.cs
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
FriendProfileDto !
{ 
[		 	

DataMember			 
]		 
public

 
string

 
	FirstName

 
{

  !
get

" %
;

% &
set

' *
;

* +
}

, -
[ 	

DataMember	 
] 
public 
string 
LastName 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

DataMember	 
] 
public 
int 
GenderId 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

DataMember	 
] 
public 
List 
< 
SocialNetworkDto $
>$ %
SocialNetworks& 4
{5 6
get7 :
;: ;
set< ?
;? @
}A B
} 
} ≈
™C:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\Contracts\DataContracts\Shared\ServiceErrorType.cs
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
( 
Name 
= 
$str +
)+ ,
], -
public 

enum 
ServiceErrorType  
{ 
[ 	

EnumMember	 
] 
Unknown 
= 
$num  
,  !
[		 	

EnumMember			 
]		 
DatabaseError		 "
=		# $
$num		% &
,		& '
[

 	

EnumMember

	 
]

 
OperationFailed

 $
=

% &
$num

' (
,

( )
[ 	

EnumMember	 
] 
ConnectionTimeout &
=' (
$num) *
,* +
[ 	

EnumMember	 
] 
InvalidCredentials '
=( )
$num* ,
,, -
[ 	

EnumMember	 
] 
UserAlreadyExists &
=' (
$num) +
,+ ,
[ 	

EnumMember	 
] "
EmailAlreadyRegistered +
=, -
$num. 0
,0 1
[ 	

EnumMember	 
] 
AccountNotVerified '
=( )
$num* ,
,, -
[ 	

EnumMember	 
] 
	LobbyFull 
=  
$num! #
,# $
[ 	

EnumMember	 
] 
MatchNotFound "
=# $
$num% '
,' (
[ 	

EnumMember	 
] 
GameInProgress #
=$ %
$num& (
,( )
[ 	

EnumMember	 
] 
PlayerBanned !
=" #
$num$ &
,& '
[ 	

EnumMember	 
] 
NotFound 
= 
$num  "
," #
[ 	

EnumMember	 
] 
DuplicateRecord $
=% &
$num' )
} 
} ô
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
} Û
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
}%% ”
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
} ç
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
} ´™
ôC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\BusinessLogic\UserProfileLogic.cs
	namespace 	
GuessMyMessServer
 
. 
BusinessLogic )
{ 
public 

class 
UserProfileLogic !
{ 
private 
static 
readonly 
ILog  $
_log% )
=* +

LogManager, 6
.6 7
	GetLogger7 @
(@ A
typeofA G
(G H
UserProfileLogicH X
)X Y
)Y Z
;Z [
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
;= >
private 
readonly 
IPlayerRepository *
_playerRepository+ <
;< =
private 
readonly 
IAvatarRepository *
_avatarRepository+ <
;< =
private 
readonly $
ISocialNetworkRepository 1
_socialRepository2 C
;C D
private 
readonly 
IEmailService &
_emailService' 4
;4 5
public 
UserProfileLogic 
(  
IPlayerRepository 
playerRepository .
,. /
IAvatarRepository 
avatarRepository .
,. /$
ISocialNetworkRepository $
socialRepository% 5
,5 6
IEmailService 
emailService &
)& '
{   	
_playerRepository!! 
=!! 
playerRepository!!  0
;!!0 1
_avatarRepository"" 
="" 
avatarRepository""  0
;""0 1
_socialRepository## 
=## 
socialRepository##  0
;##0 1
_emailService$$ 
=$$ 
emailService$$ (
;$$( )
}%% 	
private'' 
string'' 
GenerateCode'' #
(''# $
)''$ %
=>''& (
_random'') 0
.''0 1
Next''1 5
(''5 6
$num''6 <
,''< =
$num''> D
)''D E
.''E F
ToString''F N
(''N O
$str''O S
)''S T
;''T U
public)) 
async)) 
Task)) 
<)) 
UserProfileDto)) (
>))( )
GetUserProfileAsync))* =
())= >
string))> D
username))E M
)))M N
{** 	
try++ 
{,, 
var-- 
player-- 
=-- 
await-- "
_playerRepository--# 4
.--4 5%
GetPlayerProfileDataAsync--5 N
(--N O
username--O W
)--W X
;--X Y
if// 
(// 
player// 
==// 
null// "
)//" #
{00 
_log11 
.11 
Warn11 
(11 
$"11  
$str11  =
{11= >
username11> F
}11F G
$str11G S
"11S T
)11T U
;11U V
ThrowServiceFault22 %
(22% &
ServiceErrorType22& 6
.226 7
NotFound227 ?
,22? @
$str22A R
)22R S
;22S T
}33 
var55 
socialNetworksList55 &
=55' (
player55) /
.55/ 0
SocialNetwork550 =
.55= >
Select55> D
(55D E
sn55E G
=>55H J
new55K N
SocialNetworkDto55O _
{66 
NetworkType77 
=77  !
sn77" $
.77$ %
TypeSocialNetwork77% 6
.776 7
type777 ;
,77; <
UserLink88 
=88 
sn88 !
.88! "
userLink88" *
}99 
)99 
.99 
ToList99 
(99 
)99 
;99 
return;; 
new;; 
UserProfileDto;; )
{<< 
Username== 
=== 
player== %
.==% &
username==& .
,==. /
	FirstName>> 
=>> 
player>>  &
.>>& '
name>>' +
,>>+ ,
LastName?? 
=?? 
player?? %
.??% &
lastName??& .
,??. /
Email@@ 
=@@ 
player@@ "
.@@" #
email@@# (
,@@( )
GenderIdAA 
=AA 
playerAA %
.AA% &
Gender_idGenderAA& 5
.AA5 6
GetValueOrDefaultAA6 G
(AAG H
)AAH I
,AAI J
AvatarIdBB 
=BB 
playerBB %
.BB% &
Avatar_idAvatarBB& 5
.BB5 6
GetValueOrDefaultBB6 G
(BBG H
)BBH I
,BBI J
socialNetworksCC "
=CC# $
socialNetworksListCC% 7
}DD 
;DD 
}EE 
catchFF 
(FF 
	ExceptionFF 
exFF 
)FF  
whenFF! %
(FF& '
!FF' (
(FF( )
exFF) +
isFF, .
FaultExceptionFF/ =
<FF= >
ServiceFaultDtoFF> M
>FFM N
)FFN O
)FFO P
{GG 
_logHH 
.HH 
ErrorHH 
(HH 
$"HH 
$strHH ;
{HH; <
usernameHH< D
}HHD E
$strHHE G
"HHG H
,HHH I
exHHJ L
)HHL M
;HHM N
ThrowServiceFaultII !
(II! "
ServiceErrorTypeII" 2
.II2 3
DatabaseErrorII3 @
,II@ A
$strIIB d
)IId e
;IIe f
returnJJ 
nullJJ 
;JJ 
}KK 
}LL 	
publicNN 
asyncNN 
TaskNN 
<NN 
OperationResultDtoNN ,
>NN, -
UpdateProfileAsyncNN. @
(NN@ A
stringNNA G
usernameNNH P
,NNP Q
UserProfileDtoNNR `
profileDataNNa l
)NNl m
{OO 	
ifPP 
(PP 
profileDataPP 
==PP 
nullPP #
)PP# $
{QQ 
ThrowServiceFaultRR !
(RR! "
ServiceErrorTypeRR" 2
.RR2 3
OperationFailedRR3 B
,RRB C
$strRRD [
)RR[ \
;RR\ ]
}SS 
ifUU 
(UU 
profileDataUU 
.UU 
AvatarIdUU $
>UU% &
$numUU' (
)UU( )
{VV 
varWW 
avatarWW 
=WW 
awaitWW "
_avatarRepositoryWW# 4
.WW4 5
GetAvatarByIdAsyncWW5 G
(WWG H
profileDataWWH S
.WWS T
AvatarIdWWT \
)WW\ ]
;WW] ^
ifXX 
(XX 
avatarXX 
==XX 
nullXX "
)XX" #
{YY 
ThrowServiceFaultZZ %
(ZZ% &
ServiceErrorTypeZZ& 6
.ZZ6 7
OperationFailedZZ7 F
,ZZF G
$strZZH i
)ZZi j
;ZZj k
}[[ 
}\\ 
var^^ 
playerToUpdate^^ 
=^^  
await^^! &
_playerRepository^^' 8
.^^8 9$
GetPlayerByUsernameAsync^^9 Q
(^^Q R
username^^R Z
)^^Z [
;^^[ \
if`` 
(`` 
playerToUpdate`` 
==`` !
null``" &
)``& '
{aa 
ThrowServiceFaultbb !
(bb! "
ServiceErrorTypebb" 2
.bb2 3
NotFoundbb3 ;
,bb; <
$strbb= N
)bbN O
;bbO P
}cc 
playerToUpdateee 
.ee 
nameee 
=ee  !
profileDataee" -
.ee- .
	FirstNameee. 7
;ee7 8
playerToUpdateff 
.ff 
lastNameff #
=ff$ %
profileDataff& 1
.ff1 2
LastNameff2 :
;ff: ;
playerToUpdategg 
.gg 
Gender_idGendergg *
=gg+ ,
profileDatagg- 8
.gg8 9
GenderIdgg9 A
;ggA B
ifii 
(ii 
profileDataii 
.ii 
AvatarIdii $
>ii% &
$numii' (
)ii( )
{jj 
playerToUpdatekk 
.kk 
Avatar_idAvatarkk .
=kk/ 0
profileDatakk1 <
.kk< =
AvatarIdkk= E
;kkE F
}ll 
trynn 
{oo 
awaitpp 
_playerRepositorypp '
.pp' (
SaveChangesAsyncpp( 8
(pp8 9
)pp9 :
;pp: ;
_logqq 
.qq 
Infoqq 
(qq 
$"qq 
$strqq C
{qqC D
usernameqqD L
}qqL M
$strqqM O
"qqO P
)qqP Q
;qqQ R
returnrr 
newrr 
OperationResultDtorr -
{rr. /
Successrr0 7
=rr8 9
truerr: >
,rr> ?
Messagerr@ G
=rrH I
$strrrJ i
}rrj k
;rrk l
}ss 
catchtt 
(tt 
	Exceptiontt 
extt 
)tt  
{uu 
_logvv 
.vv 
Errorvv 
(vv 
$"vv 
$strvv B
{vvB C
usernamevvC K
}vvK L
$strvvL N
"vvN O
,vvO P
exvvQ S
)vvS T
;vvT U
ThrowServiceFaultww !
(ww! "
ServiceErrorTypeww" 2
.ww2 3
DatabaseErrorww3 @
,ww@ A
$strwwB ]
)ww] ^
;ww^ _
returnxx 
nullxx 
;xx 
}yy 
}zz 	
public|| 
async|| 
Task|| 
<|| 
OperationResultDto|| ,
>||, -)
AddOrUpdateSocialNetworkAsync||. K
(||K L
string||L R
username||S [
,||[ \
SocialNetworkDto||] m
socialNetworkDto||n ~
)||~ 
{}} 	
if~~ 
(~~ 
socialNetworkDto~~  
==~~! #
null~~$ (
||~~) +
string~~, 2
.~~2 3
IsNullOrWhiteSpace~~3 E
(~~E F
socialNetworkDto~~F V
.~~V W
UserLink~~W _
)~~_ `
)~~` a
{ 
ThrowServiceFault
ÄÄ !
(
ÄÄ! "
ServiceErrorType
ÄÄ" 2
.
ÄÄ2 3
OperationFailed
ÄÄ3 B
,
ÄÄB C
$str
ÄÄD b
)
ÄÄb c
;
ÄÄc d
}
ÅÅ 
var
ÉÉ 
player
ÉÉ 
=
ÉÉ 
await
ÉÉ 
_playerRepository
ÉÉ 0
.
ÉÉ0 1&
GetPlayerByUsernameAsync
ÉÉ1 I
(
ÉÉI J
username
ÉÉJ R
)
ÉÉR S
;
ÉÉS T
if
ÑÑ 
(
ÑÑ 
player
ÑÑ 
==
ÑÑ 
null
ÑÑ 
)
ÑÑ 
{
ÖÖ 
ThrowServiceFault
ÜÜ !
(
ÜÜ! "
ServiceErrorType
ÜÜ" 2
.
ÜÜ2 3
NotFound
ÜÜ3 ;
,
ÜÜ; <
$str
ÜÜ= N
)
ÜÜN O
;
ÜÜO P
}
áá 
var
ââ 
networkType
ââ 
=
ââ 
await
ââ #
_socialRepository
ââ$ 5
.
ââ5 6 
GetTypeByNameAsync
ââ6 H
(
ââH I
socialNetworkDto
ââI Y
.
ââY Z
NetworkType
ââZ e
)
ââe f
;
ââf g
if
ää 
(
ää 
networkType
ää 
==
ää 
null
ää #
)
ää# $
{
ãã 
ThrowServiceFault
åå !
(
åå! "
ServiceErrorType
åå" 2
.
åå2 3
OperationFailed
åå3 B
,
ååB C
$"
ååD F
$str
ååF c
{
ååc d
socialNetworkDto
ååd t
.
ååt u
NetworkTypeååu Ä
}ååÄ Å
"ååÅ Ç
)ååÇ É
;ååÉ Ñ
}
çç 
var
èè 
existingSocial
èè 
=
èè  
await
èè! &
_socialRepository
èè' 8
.
èè8 9)
GetPlayerSocialNetworkAsync
èè9 T
(
èèT U
player
èèU [
.
èè[ \
idPlayer
èè\ d
,
èèd e
networkType
èèf q
.
èèq r"
idTypeSocialNetworkèèr Ö
)èèÖ Ü
;èèÜ á
if
ëë 
(
ëë 
existingSocial
ëë 
!=
ëë !
null
ëë" &
)
ëë& '
{
íí 
existingSocial
ìì 
.
ìì 
userLink
ìì '
=
ìì( )
socialNetworkDto
ìì* :
.
ìì: ;
UserLink
ìì; C
.
ììC D
Trim
ììD H
(
ììH I
)
ììI J
;
ììJ K
}
îî 
else
ïï 
{
ññ 
var
óó 
	newSocial
óó 
=
óó 
new
óó  #
SocialNetwork
óó$ 1
{
òò 
Player_idPlayer
ôô #
=
ôô$ %
player
ôô& ,
.
ôô, -
idPlayer
ôô- 5
,
ôô5 63
%TypeSocialNetwork_idTypeSocialNetwork
öö 9
=
öö: ;
networkType
öö< G
.
ööG H!
idTypeSocialNetwork
ööH [
,
öö[ \
userLink
õõ 
=
õõ 
socialNetworkDto
õõ /
.
õõ/ 0
UserLink
õõ0 8
.
õõ8 9
Trim
õõ9 =
(
õõ= >
)
õõ> ?
}
úú 
;
úú 
_socialRepository
ùù !
.
ùù! "
AddSocialNetwork
ùù" 2
(
ùù2 3
	newSocial
ùù3 <
)
ùù< =
;
ùù= >
}
ûû 
try
†† 
{
°° 
await
¢¢ 
_socialRepository
¢¢ '
.
¢¢' (
SaveChangesAsync
¢¢( 8
(
¢¢8 9
)
¢¢9 :
;
¢¢: ;
return
££ 
new
££  
OperationResultDto
££ -
{
££. /
Success
££0 7
=
££8 9
true
££: >
,
££> ?
Message
££@ G
=
££H I
$str
££J c
}
££d e
;
££e f
}
§§ 
catch
•• 
(
•• 
	Exception
•• 
ex
•• 
)
••  
{
¶¶ 
_log
ßß 
.
ßß 
Error
ßß 
(
ßß 
$"
ßß 
$str
ßß >
{
ßß> ?
username
ßß? G
}
ßßG H
$str
ßßH J
"
ßßJ K
,
ßßK L
ex
ßßM O
)
ßßO P
;
ßßP Q
ThrowServiceFault
®® !
(
®®! "
ServiceErrorType
®®" 2
.
®®2 3
DatabaseError
®®3 @
,
®®@ A
$str
®®B b
)
®®b c
;
®®c d
return
©© 
null
©© 
;
©© 
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
≠≠ 
	AvatarDto
≠≠ (
>
≠≠( )
>
≠≠) *&
GetAvailableAvatarsAsync
≠≠+ C
(
≠≠C D
)
≠≠D E
{
ÆÆ 	
var
ØØ 
avatarsDtoList
ØØ 
=
ØØ  
new
ØØ! $
List
ØØ% )
<
ØØ) *
	AvatarDto
ØØ* 3
>
ØØ3 4
(
ØØ4 5
)
ØØ5 6
;
ØØ6 7
string
∞∞ 
basePath
∞∞ 
=
∞∞ 
	AppDomain
∞∞ '
.
∞∞' (
CurrentDomain
∞∞( 5
.
∞∞5 6
BaseDirectory
∞∞6 C
;
∞∞C D
try
≤≤ 
{
≥≥ 
var
¥¥ 
avatarsFromDb
¥¥ !
=
¥¥" #
await
¥¥$ )
_avatarRepository
¥¥* ;
.
¥¥; < 
GetAllAvatarsAsync
¥¥< N
(
¥¥N O
)
¥¥O P
;
¥¥P Q
foreach
∂∂ 
(
∂∂ 
var
∂∂ 
avatarRecord
∂∂ )
in
∂∂* ,
avatarsFromDb
∂∂- :
)
∂∂: ;
{
∑∑ 
byte
∏∏ 
[
∏∏ 
]
∏∏ 
	imageData
∏∏ $
=
∏∏% &
null
∏∏' +
;
∏∏+ ,
if
ππ 
(
ππ 
!
ππ 
string
ππ 
.
ππ  
IsNullOrEmpty
ππ  -
(
ππ- .
avatarRecord
ππ. :
.
ππ: ;
	avatarUrl
ππ; D
)
ππD E
)
ππE F
{
∫∫ 
string
ªª 
filePath
ªª '
=
ªª( )
Path
ªª* .
.
ªª. /
Combine
ªª/ 6
(
ªª6 7
basePath
ªª7 ?
,
ªª? @
avatarRecord
ªªA M
.
ªªM N
	avatarUrl
ªªN W
)
ªªW X
;
ªªX Y
	imageData
ºº !
=
ºº" #
await
ºº$ )
ReadFileAsync
ºº* 7
(
ºº7 8
filePath
ºº8 @
)
ºº@ A
;
ººA B
}
ΩΩ 
avatarsDtoList
øø "
.
øø" #
Add
øø# &
(
øø& '
new
øø' *
	AvatarDto
øø+ 4
{
¿¿ 
IdAvatar
¡¡  
=
¡¡! "
avatarRecord
¡¡# /
.
¡¡/ 0
idAvatar
¡¡0 8
,
¡¡8 9

AvatarName
¬¬ "
=
¬¬# $
avatarRecord
¬¬% 1
.
¬¬1 2

avatarName
¬¬2 <
,
¬¬< =

AvatarData
√√ "
=
√√# $
	imageData
√√% .
}
ƒƒ 
)
ƒƒ 
;
ƒƒ 
}
≈≈ 
}
∆∆ 
catch
«« 
(
«« 
	Exception
«« 
ex
«« 
)
««  
{
»» 
_log
…… 
.
…… 
Error
…… 
(
…… 
$str
…… :
,
……: ;
ex
……< >
)
……> ?
;
……? @
ThrowServiceFault
   !
(
  ! "
ServiceErrorType
  " 2
.
  2 3
OperationFailed
  3 B
,
  B C
$str
  D a
)
  a b
;
  b c
}
ÀÀ 
return
ÕÕ 
avatarsDtoList
ÕÕ !
;
ÕÕ! "
}
ŒŒ 	
public
–– 
async
–– 
Task
–– 
<
––  
OperationResultDto
–– ,
>
––, -(
RequestChangePasswordAsync
––. H
(
––H I
string
––I O
username
––P X
)
––X Y
{
—— 	
var
““ 
player
““ 
=
““ 
await
““ 
_playerRepository
““ 0
.
““0 1&
GetPlayerByUsernameAsync
““1 I
(
““I J
username
““J R
)
““R S
;
““S T
if
”” 
(
”” 
player
”” 
==
”” 
null
”” 
)
”” 
{
‘‘ 
ThrowServiceFault
’’ !
(
’’! "
ServiceErrorType
’’" 2
.
’’2 3
NotFound
’’3 ;
,
’’; <
$str
’’= N
)
’’N O
;
’’O P
}
÷÷ 
string
ÿÿ 
code
ÿÿ 
=
ÿÿ 
GenerateCode
ÿÿ &
(
ÿÿ& '
)
ÿÿ' (
;
ÿÿ( )
player
ŸŸ 
.
ŸŸ 
	temp_code
ŸŸ 
=
ŸŸ 
code
ŸŸ #
;
ŸŸ# $
player
⁄⁄ 
.
⁄⁄ 
temp_code_expiry
⁄⁄ #
=
⁄⁄$ %
DateTime
⁄⁄& .
.
⁄⁄. /
UtcNow
⁄⁄/ 5
.
⁄⁄5 6

AddMinutes
⁄⁄6 @
(
⁄⁄@ A
$num
⁄⁄A C
)
⁄⁄C D
;
⁄⁄D E
try
‹‹ 
{
›› 
await
ﬁﬁ 
_playerRepository
ﬁﬁ '
.
ﬁﬁ' (
SaveChangesAsync
ﬁﬁ( 8
(
ﬁﬁ8 9
)
ﬁﬁ9 :
;
ﬁﬁ: ;
var
‡‡ 
emailTemplate
‡‡ !
=
‡‡" #
new
‡‡$ '5
'PasswordChangeVerificationEmailTemplate
‡‡( O
(
‡‡O P
player
‡‡P V
.
‡‡V W
username
‡‡W _
,
‡‡_ `
code
‡‡a e
)
‡‡e f
;
‡‡f g
await
·· 
_emailService
·· #
.
··# $
SendEmailAsync
··$ 2
(
··2 3
player
··3 9
.
··9 :
email
··: ?
,
··? @
player
··A G
.
··G H
username
··H P
,
··P Q
emailTemplate
··R _
)
··_ `
;
··` a
return
„„ 
new
„„  
OperationResultDto
„„ -
{
„„. /
Success
„„0 7
=
„„8 9
true
„„: >
,
„„> ?
Message
„„@ G
=
„„H I
$str
„„J c
}
„„d e
;
„„e f
}
‰‰ 
catch
ÂÂ 
(
ÂÂ 
	Exception
ÂÂ 
ex
ÂÂ 
)
ÂÂ  
{
ÊÊ 
_log
ÁÁ 
.
ÁÁ 
Error
ÁÁ 
(
ÁÁ 
$"
ÁÁ 
$str
ÁÁ A
{
ÁÁA B
username
ÁÁB J
}
ÁÁJ K
$str
ÁÁK M
"
ÁÁM N
,
ÁÁN O
ex
ÁÁP R
)
ÁÁR S
;
ÁÁS T
ThrowServiceFault
ËË !
(
ËË! "
ServiceErrorType
ËË" 2
.
ËË2 3
OperationFailed
ËË3 B
,
ËËB C
$str
ËËD `
)
ËË` a
;
ËËa b
return
ÈÈ 
null
ÈÈ 
;
ÈÈ 
}
ÍÍ 
}
ÎÎ 	
public
ÌÌ 
async
ÌÌ 
Task
ÌÌ 
<
ÌÌ  
OperationResultDto
ÌÌ ,
>
ÌÌ, -(
ConfirmChangePasswordAsync
ÌÌ. H
(
ÌÌH I
string
ÌÌI O
username
ÌÌP X
,
ÌÌX Y
string
ÌÌZ `
newPassword
ÌÌa l
,
ÌÌl m
string
ÌÌn t
verificationCodeÌÌu Ö
)ÌÌÖ Ü
{
ÓÓ 	
if
ÔÔ 
(
ÔÔ 
!
ÔÔ 
InputValidator
ÔÔ 
.
ÔÔ  
IsPasswordSecure
ÔÔ  0
(
ÔÔ0 1
newPassword
ÔÔ1 <
)
ÔÔ< =
)
ÔÔ= >
{
 
ThrowServiceFault
ÒÒ !
(
ÒÒ! "
ServiceErrorType
ÒÒ" 2
.
ÒÒ2 3
OperationFailed
ÒÒ3 B
,
ÒÒB C
$str
ÒÒD s
)
ÒÒs t
;
ÒÒt u
}
ÚÚ 
var
ÙÙ 
player
ÙÙ 
=
ÙÙ 
await
ÙÙ 
_playerRepository
ÙÙ 0
.
ÙÙ0 1&
GetPlayerByUsernameAsync
ÙÙ1 I
(
ÙÙI J
username
ÙÙJ R
)
ÙÙR S
;
ÙÙS T
if
ıı 
(
ıı 
player
ıı 
==
ıı 
null
ıı 
)
ıı 
{
ˆˆ 
ThrowServiceFault
˜˜ !
(
˜˜! "
ServiceErrorType
˜˜" 2
.
˜˜2 3
NotFound
˜˜3 ;
,
˜˜; <
$str
˜˜= N
)
˜˜N O
;
˜˜O P
}
¯¯ 
if
˙˙ 
(
˙˙ 
player
˙˙ 
.
˙˙ 
	temp_code
˙˙  
!=
˙˙! #
verificationCode
˙˙$ 4
||
˙˙5 7
player
˙˙8 >
.
˙˙> ?
temp_code_expiry
˙˙? O
<
˙˙P Q
DateTime
˙˙R Z
.
˙˙Z [
UtcNow
˙˙[ a
)
˙˙a b
{
˚˚ 
ThrowServiceFault
¸¸ !
(
¸¸! "
ServiceErrorType
¸¸" 2
.
¸¸2 3 
InvalidCredentials
¸¸3 E
,
¸¸E F
$str
¸¸G a
)
¸¸a b
;
¸¸b c
}
˝˝ 
player
ˇˇ 
.
ˇˇ 
password
ˇˇ 
=
ˇˇ 
PasswordHasher
ˇˇ ,
.
ˇˇ, -
HashPassword
ˇˇ- 9
(
ˇˇ9 :
newPassword
ˇˇ: E
)
ˇˇE F
;
ˇˇF G
player
ÄÄ 
.
ÄÄ 
	temp_code
ÄÄ 
=
ÄÄ 
null
ÄÄ #
;
ÄÄ# $
player
ÅÅ 
.
ÅÅ 
temp_code_expiry
ÅÅ #
=
ÅÅ$ %
null
ÅÅ& *
;
ÅÅ* +
try
ÉÉ 
{
ÑÑ 
await
ÖÖ 
_playerRepository
ÖÖ '
.
ÖÖ' (
SaveChangesAsync
ÖÖ( 8
(
ÖÖ8 9
)
ÖÖ9 :
;
ÖÖ: ;
return
ÜÜ 
new
ÜÜ  
OperationResultDto
ÜÜ -
{
ÜÜ. /
Success
ÜÜ0 7
=
ÜÜ8 9
true
ÜÜ: >
,
ÜÜ> ?
Message
ÜÜ@ G
=
ÜÜH I
$str
ÜÜJ j
}
ÜÜk l
;
ÜÜl m
}
áá 
catch
àà 
(
àà 
	Exception
àà 
ex
àà 
)
àà  
{
ââ 
_log
ää 
.
ää 
Error
ää 
(
ää 
$"
ää 
$str
ää C
{
ääC D
username
ääD L
}
ääL M
$str
ääM O
"
ääO P
,
ääP Q
ex
ääR T
)
ääT U
;
ääU V
ThrowServiceFault
ãã !
(
ãã! "
ServiceErrorType
ãã" 2
.
ãã2 3
DatabaseError
ãã3 @
,
ãã@ A
$str
ããB ^
)
ãã^ _
;
ãã_ `
return
åå 
null
åå 
;
åå 
}
çç 
}
éé 	
public
êê 
async
êê 
Task
êê 
<
êê  
OperationResultDto
êê ,
>
êê, -%
RequestChangeEmailAsync
êê. E
(
êêE F
string
êêF L
username
êêM U
,
êêU V
string
êêW ]
newEmail
êê^ f
)
êêf g
{
ëë 	
if
íí 
(
íí 
!
íí 
InputValidator
íí 
.
íí  
IsValidEmail
íí  ,
(
íí, -
newEmail
íí- 5
)
íí5 6
)
íí6 7
{
ìì 
ThrowServiceFault
îî !
(
îî! "
ServiceErrorType
îî" 2
.
îî2 3
OperationFailed
îî3 B
,
îîB C
$str
îîD [
)
îî[ \
;
îî\ ]
}
ïï 
var
óó 
player
óó 
=
óó 
await
óó 
_playerRepository
óó 0
.
óó0 1&
GetPlayerByUsernameAsync
óó1 I
(
óóI J
username
óóJ R
)
óóR S
;
óóS T
if
òò 
(
òò 
player
òò 
==
òò 
null
òò 
)
òò 
{
ôô 
ThrowServiceFault
öö !
(
öö! "
ServiceErrorType
öö" 2
.
öö2 3
NotFound
öö3 ;
,
öö; <
$str
öö= N
)
ööN O
;
ööO P
}
õõ 
var
ùù 
existingUser
ùù 
=
ùù 
await
ùù $
_playerRepository
ùù% 6
.
ùù6 7#
GetPlayerByEmailAsync
ùù7 L
(
ùùL M
newEmail
ùùM U
)
ùùU V
;
ùùV W
if
ûû 
(
ûû 
existingUser
ûû 
!=
ûû 
null
ûû  $
)
ûû$ %
{
üü 
ThrowServiceFault
†† !
(
††! "
ServiceErrorType
††" 2
.
††2 3$
EmailAlreadyRegistered
††3 I
,
††I J
$str
††K m
)
††m n
;
††n o
}
°° 
string
££ 
code
££ 
=
££ 
GenerateCode
££ &
(
££& '
)
££' (
;
££( )
player
§§ 
.
§§ 
	temp_code
§§ 
=
§§ 
code
§§ #
;
§§# $
player
•• 
.
•• 
temp_code_expiry
•• #
=
••$ %
DateTime
••& .
.
••. /
UtcNow
••/ 5
.
••5 6

AddMinutes
••6 @
(
••@ A
$num
••A C
)
••C D
;
••D E
player
¶¶ 
.
¶¶ 
new_email_pending
¶¶ $
=
¶¶% &
newEmail
¶¶' /
;
¶¶/ 0
try
®® 
{
©© 
await
™™ 
_playerRepository
™™ '
.
™™' (
SaveChangesAsync
™™( 8
(
™™8 9
)
™™9 :
;
™™: ;
var
¨¨ 
emailTemplate
¨¨ !
=
¨¨" #
new
¨¨$ '2
$EmailChangeVerificationEmailTemplate
¨¨( L
(
¨¨L M
player
¨¨M S
.
¨¨S T
username
¨¨T \
,
¨¨\ ]
code
¨¨^ b
)
¨¨b c
;
¨¨c d
await
≠≠ 
_emailService
≠≠ #
.
≠≠# $
SendEmailAsync
≠≠$ 2
(
≠≠2 3
player
≠≠3 9
.
≠≠9 :
email
≠≠: ?
,
≠≠? @
player
≠≠A G
.
≠≠G H
username
≠≠H P
,
≠≠P Q
emailTemplate
≠≠R _
)
≠≠_ `
;
≠≠` a
return
ØØ 
new
ØØ  
OperationResultDto
ØØ -
{
ØØ. /
Success
ØØ0 7
=
ØØ8 9
true
ØØ: >
,
ØØ> ?
Message
ØØ@ G
=
ØØH I
$str
ØØJ y
}
ØØz {
;
ØØ{ |
}
∞∞ 
catch
±± 
(
±± 
	Exception
±± 
ex
±± 
)
±±  
{
≤≤ 
_log
≥≥ 
.
≥≥ 
Error
≥≥ 
(
≥≥ 
$"
≥≥ 
$str
≥≥ @
{
≥≥@ A
username
≥≥A I
}
≥≥I J
$str
≥≥J L
"
≥≥L M
,
≥≥M N
ex
≥≥O Q
)
≥≥Q R
;
≥≥R S
ThrowServiceFault
¥¥ !
(
¥¥! "
ServiceErrorType
¥¥" 2
.
¥¥2 3
OperationFailed
¥¥3 B
,
¥¥B C
$str
¥¥D `
)
¥¥` a
;
¥¥a b
return
µµ 
null
µµ 
;
µµ 
}
∂∂ 
}
∑∑ 	
public
ππ 
async
ππ 
Task
ππ 
<
ππ  
OperationResultDto
ππ ,
>
ππ, -%
ConfirmChangeEmailAsync
ππ. E
(
ππE F
string
ππF L
username
ππM U
,
ππU V
string
ππW ]
verificationCode
ππ^ n
)
ππn o
{
∫∫ 	
var
ªª 
player
ªª 
=
ªª 
await
ªª 
_playerRepository
ªª 0
.
ªª0 1&
GetPlayerByUsernameAsync
ªª1 I
(
ªªI J
username
ªªJ R
)
ªªR S
;
ªªS T
if
ºº 
(
ºº 
player
ºº 
==
ºº 
null
ºº 
)
ºº 
{
ΩΩ 
ThrowServiceFault
ææ !
(
ææ! "
ServiceErrorType
ææ" 2
.
ææ2 3
NotFound
ææ3 ;
,
ææ; <
$str
ææ= N
)
ææN O
;
ææO P
}
øø 
if
¡¡ 
(
¡¡ 
string
¡¡ 
.
¡¡ 
IsNullOrEmpty
¡¡ $
(
¡¡$ %
player
¡¡% +
.
¡¡+ ,
new_email_pending
¡¡, =
)
¡¡= >
)
¡¡> ?
{
¬¬ 
ThrowServiceFault
√√ !
(
√√! "
ServiceErrorType
√√" 2
.
√√2 3
OperationFailed
√√3 B
,
√√B C
$str
√√D f
)
√√f g
;
√√g h
}
ƒƒ 
if
∆∆ 
(
∆∆ 
player
∆∆ 
.
∆∆ 
	temp_code
∆∆  
!=
∆∆! #
verificationCode
∆∆$ 4
||
∆∆5 7
player
∆∆8 >
.
∆∆> ?
temp_code_expiry
∆∆? O
<
∆∆P Q
DateTime
∆∆R Z
.
∆∆Z [
UtcNow
∆∆[ a
)
∆∆a b
{
«« 
ThrowServiceFault
»» !
(
»»! "
ServiceErrorType
»»" 2
.
»»2 3 
InvalidCredentials
»»3 E
,
»»E F
$str
»»G a
)
»»a b
;
»»b c
}
…… 
var
ÀÀ 
collisionUser
ÀÀ 
=
ÀÀ 
await
ÀÀ  %
_playerRepository
ÀÀ& 7
.
ÀÀ7 8#
GetPlayerByEmailAsync
ÀÀ8 M
(
ÀÀM N
player
ÀÀN T
.
ÀÀT U
new_email_pending
ÀÀU f
)
ÀÀf g
;
ÀÀg h
if
ÃÃ 
(
ÃÃ 
collisionUser
ÃÃ 
!=
ÃÃ  
null
ÃÃ! %
&&
ÃÃ& (
collisionUser
ÃÃ) 6
.
ÃÃ6 7
idPlayer
ÃÃ7 ?
!=
ÃÃ@ B
player
ÃÃC I
.
ÃÃI J
idPlayer
ÃÃJ R
)
ÃÃR S
{
ÕÕ 
player
ŒŒ 
.
ŒŒ 
	temp_code
ŒŒ  
=
ŒŒ! "
null
ŒŒ# '
;
ŒŒ' (
player
œœ 
.
œœ 
new_email_pending
œœ (
=
œœ) *
null
œœ+ /
;
œœ/ 0
await
–– 
_playerRepository
–– '
.
––' (
SaveChangesAsync
––( 8
(
––8 9
)
––9 :
;
––: ;
ThrowServiceFault
““ !
(
““! "
ServiceErrorType
““" 2
.
““2 3$
EmailAlreadyRegistered
““3 I
,
““I J
$str
““K q
)
““q r
;
““r s
}
”” 
player
’’ 
.
’’ 
email
’’ 
=
’’ 
player
’’ !
.
’’! "
new_email_pending
’’" 3
;
’’3 4
player
÷÷ 
.
÷÷ 
	temp_code
÷÷ 
=
÷÷ 
null
÷÷ #
;
÷÷# $
player
◊◊ 
.
◊◊ 
temp_code_expiry
◊◊ #
=
◊◊$ %
null
◊◊& *
;
◊◊* +
player
ÿÿ 
.
ÿÿ 
new_email_pending
ÿÿ $
=
ÿÿ% &
null
ÿÿ' +
;
ÿÿ+ ,
try
⁄⁄ 
{
€€ 
await
‹‹ 
_playerRepository
‹‹ '
.
‹‹' (
SaveChangesAsync
‹‹( 8
(
‹‹8 9
)
‹‹9 :
;
‹‹: ;
return
›› 
new
››  
OperationResultDto
›› -
{
››. /
Success
››0 7
=
››8 9
true
››: >
,
››> ?
Message
››@ G
=
››H I
$str
››J g
}
››h i
;
››i j
}
ﬁﬁ 
catch
ﬂﬂ 
(
ﬂﬂ 
	Exception
ﬂﬂ 
ex
ﬂﬂ 
)
ﬂﬂ  
{
‡‡ 
_log
·· 
.
·· 
Error
·· 
(
·· 
$"
·· 
$str
·· @
{
··@ A
username
··A I
}
··I J
$str
··J L
"
··L M
,
··M N
ex
··O Q
)
··Q R
;
··R S
ThrowServiceFault
‚‚ !
(
‚‚! "
ServiceErrorType
‚‚" 2
.
‚‚2 3
DatabaseError
‚‚3 @
,
‚‚@ A
$str
‚‚B [
)
‚‚[ \
;
‚‚\ ]
return
„„ 
null
„„ 
;
„„ 
}
‰‰ 
}
ÂÂ 	
public
ÁÁ 
async
ÁÁ 
Task
ÁÁ 
<
ÁÁ 
List
ÁÁ 
<
ÁÁ 
PlayerScoreDto
ÁÁ -
>
ÁÁ- .
>
ÁÁ. /#
GetGlobalRankingAsync
ÁÁ0 E
(
ÁÁE F
)
ÁÁF G
{
ËË 	
try
ÈÈ 
{
ÍÍ 
return
ÎÎ 
await
ÎÎ 
_playerRepository
ÎÎ .
.
ÎÎ. /#
GetGlobalRankingAsync
ÎÎ/ D
(
ÎÎD E
)
ÎÎE F
;
ÎÎF G
}
ÏÏ 
catch
ÌÌ 
(
ÌÌ 
	Exception
ÌÌ 
ex
ÌÌ 
)
ÌÌ  
{
ÓÓ 
_log
ÔÔ 
.
ÔÔ 
Error
ÔÔ 
(
ÔÔ 
$str
ÔÔ =
,
ÔÔ= >
ex
ÔÔ? A
)
ÔÔA B
;
ÔÔB C
ThrowServiceFault
 !
(
! "
ServiceErrorType
" 2
.
2 3
DatabaseError
3 @
,
@ A
$str
B f
)
f g
;
g h
return
ÒÒ 
null
ÒÒ 
;
ÒÒ 
}
ÚÚ 
}
ÛÛ 	
private
ıı 
async
ıı 
Task
ıı 
<
ıı 
byte
ıı 
[
ıı  
]
ıı  !
>
ıı! "
ReadFileAsync
ıı# 0
(
ıı0 1
string
ıı1 7
filePath
ıı8 @
)
ıı@ A
{
ˆˆ 	
if
˜˜ 
(
˜˜ 
!
˜˜ 
File
˜˜ 
.
˜˜ 
Exists
˜˜ 
(
˜˜ 
filePath
˜˜ %
)
˜˜% &
)
˜˜& '
{
¯¯ 
return
˘˘ 
null
˘˘ 
;
˘˘ 
}
˙˙ 
try
¸¸ 
{
˝˝ 
using
˛˛ 
(
˛˛ 

FileStream
˛˛ !
stream
˛˛" (
=
˛˛) *
new
˛˛+ .

FileStream
˛˛/ 9
(
˛˛9 :
filePath
˛˛: B
,
˛˛B C
FileMode
˛˛D L
.
˛˛L M
Open
˛˛M Q
,
˛˛Q R

FileAccess
˛˛S ]
.
˛˛] ^
Read
˛˛^ b
,
˛˛b c
	FileShare
˛˛d m
.
˛˛m n
Read
˛˛n r
,
˛˛r s
$num
˛˛t x
,
˛˛x y
true
˛˛z ~
)
˛˛~ 
)˛˛ Ä
{
ˇˇ 
byte
ÄÄ 
[
ÄÄ 
]
ÄÄ 
buffer
ÄÄ !
=
ÄÄ" #
new
ÄÄ$ '
byte
ÄÄ( ,
[
ÄÄ, -
stream
ÄÄ- 3
.
ÄÄ3 4
Length
ÄÄ4 :
]
ÄÄ: ;
;
ÄÄ; <
await
ÅÅ 
stream
ÅÅ  
.
ÅÅ  !
	ReadAsync
ÅÅ! *
(
ÅÅ* +
buffer
ÅÅ+ 1
,
ÅÅ1 2
$num
ÅÅ3 4
,
ÅÅ4 5
buffer
ÅÅ6 <
.
ÅÅ< =
Length
ÅÅ= C
)
ÅÅC D
;
ÅÅD E
return
ÇÇ 
buffer
ÇÇ !
;
ÇÇ! "
}
ÉÉ 
}
ÑÑ 
catch
ÖÖ 
(
ÖÖ 
	Exception
ÖÖ 
ex
ÖÖ 
)
ÖÖ  
{
ÜÜ 
_log
áá 
.
áá 
Warn
áá 
(
áá 
$"
áá 
$str
áá /
{
áá/ 0
filePath
áá0 8
}
áá8 9
"
áá9 :
,
áá: ;
ex
áá< >
)
áá> ?
;
áá? @
return
àà 
null
àà 
;
àà 
}
ââ 
}
ää 	
private
åå 
void
åå 
ThrowServiceFault
åå &
(
åå& '
ServiceErrorType
åå' 7
type
åå8 <
,
åå< =
string
åå> D
message
ååE L
)
ååL M
{
çç 	
var
éé 
fault
éé 
=
éé 
new
éé 
ServiceFaultDto
éé +
(
éé+ ,
type
éé, 0
,
éé0 1
message
éé2 9
)
éé9 :
;
éé: ;
throw
èè 
new
èè 
FaultException
èè $
<
èè$ %
ServiceFaultDto
èè% 4
>
èè4 5
(
èè5 6
fault
èè6 ;
,
èè; <
new
èè= @
FaultReason
èèA L
(
èèL M
message
èèM T
)
èèT U
)
èèU V
;
èèV W
}
êê 	
}
ëë 
}íí •ø
ìC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\BusinessLogic\LobbyLogic.cs
	namespace 	
GuessMyMessServer
 
. 
BusinessLogic )
{ 
public 

class 

LobbyLogic 
{ 
private 
static 
readonly 
ILog  $
_log% )
=* +

LogManager, 6
.6 7
	GetLogger7 @
(@ A
typeofA G
(G H

LobbyLogicH R
)R S
)S T
;T U
private 
static 
readonly  
ConcurrentDictionary  4
<4 5
string5 ;
,; <
Lobby= B
>B C
_lobbiesD L
=M N
newO R 
ConcurrentDictionaryS g
<g h
stringh n
,n o
Lobbyp u
>u v
(v w
)w x
;x y
private 
static 
readonly 
object  &
_lock' ,
=- .
new/ 2
object3 9
(9 :
): ;
;; <
private 
readonly 
IMatchRepository )
_matchRepository* :
;: ;
private 
readonly 
MatchmakingLogic )
_matchmakingLogic* ;
;; <
public 

LobbyLogic 
( 
IMatchRepository *
matchRepository+ :
,: ;
MatchmakingLogic< L
matchmakingLogicM ]
)] ^
{ 	
_matchRepository 
= 
matchRepository .
;. /
_matchmakingLogic 
= 
matchmakingLogic  0
;0 1
}   	
private"" 
sealed"" 
class"" 
PlayerConnection"" -
{## 	
public$$ 
string$$ 
Username$$ "
{$$# $
get$$% (
;$$( )
}$$* +
public%% 
string%% 
DisplayName%% %
{%%& '
get%%( +
;%%+ ,
}%%- .
public&& !
ILobbyServiceCallback&& (
Callback&&) 1
{&&2 3
get&&4 7
;&&7 8
}&&9 :
public(( 
PlayerConnection(( #
(((# $
string(($ *
username((+ 3
,((3 4
string((5 ;
displayName((< G
,((G H!
ILobbyServiceCallback((I ^
callback((_ g
)((g h
{)) 
Username** 
=** 
username** #
;**# $
DisplayName++ 
=++ 
displayName++ )
;++) *
Callback,, 
=,, 
callback,, #
;,,# $
}-- 
}.. 	
private00 
sealed00 
class00 
Lobby00 "
{11 	
public22 
string22 
MatchId22 !
{22" #
get22$ '
;22' (
}22) *
public33 
string33 
HostUsername33 &
{33' (
get33) ,
;33, -
}33. /
public44 
MatchInfoDto44 
	MatchInfo44  )
{44* +
get44, /
;44/ 0
}441 2
public55  
ConcurrentDictionary55 '
<55' (
string55( .
,55. /
PlayerConnection550 @
>55@ A
Players55B I
{55J K
get55L O
;55O P
}55Q R
=55S T
new55U X 
ConcurrentDictionary55Y m
<55m n
string55n t
,55t u
PlayerConnection	55v Ü
>
55Ü á
(
55á à
)
55à â
;
55â ä
private77 
Timer77 
_countdownTimer77 )
;77) *
private88 
int88 
_countdownSeconds88 )
=88* +
$num88, -
;88- .
private99 
volatile99 
bool99 !
_gameHasStarted99" 1
=992 3
false994 9
;999 :
private:: 
int:: 
_guestCounter:: %
=::& '
$num::( )
;::) *
public<< 
int<< 
GetNextGuestNumber<< )
(<<) *
)<<* +
=><<, .
_guestCounter<</ <
++<<< >
;<<> ?
public>> 
Lobby>> 
(>> 
string>> 
matchId>>  '
,>>' (
string>>) /
hostUsername>>0 <
,>>< =
MatchInfoDto>>> J
	matchInfo>>K T
)>>T U
{?? 
MatchId@@ 
=@@ 
matchId@@ !
;@@! "
HostUsernameAA 
=AA 
hostUsernameAA +
;AA+ ,
	MatchInfoBB 
=BB 
	matchInfoBB %
;BB% &
}CC 
publicEE 
LobbyStateDtoEE  
GetCurrentStateEE! 0
(EE0 1
)EE1 2
{FF 
returnGG 
newGG 
LobbyStateDtoGG (
{HH 
	MatchNameII 
=II 
	MatchInfoII  )
.II) *
	MatchNameII* 3
,II3 4
HostUsernameJJ  
=JJ! "
HostUsernameJJ# /
,JJ/ 0

DifficultyKK 
=KK  
	MatchInfoKK! *
.KK* +
DifficultyNameKK+ 9
,KK9 :
CurrentPlayersLL "
=LL# $
PlayersLL% ,
.LL, -
CountLL- 2
,LL2 3

MaxPlayersMM 
=MM  
	MatchInfoMM! *
.MM* +

MaxPlayersMM+ 5
,MM5 6
	MatchCodeNN 
=NN 
	MatchInfoNN  )
.NN) *
	IsPrivateNN* 3
?NN4 5
	MatchInfoNN6 ?
.NN? @
	MatchCodeNN@ I
:NNJ K
nullNNL P
,NNP Q
PlayerUsernamesOO #
=OO$ %
PlayersOO& -
.OO- .
ValuesOO. 4
.OO4 5
SelectOO5 ;
(OO; <
pOO< =
=>OO> @
pOOA B
.OOB C
DisplayNameOOC N
)OON O
.OOO P
ToListOOP V
(OOV W
)OOW X
}PP 
;PP 
}QQ 
publicSS 
voidSS 
StartCountdownSS &
(SS& '
ILogSS' +
logSS, /
,SS/ 0
ActionSS1 7
<SS7 8
stringSS8 >
>SS> ?
onGameStartedSS@ M
)SSM N
{TT 
_countdownSecondsUU !
=UU" #
$numUU$ %
;UU% &
logVV 
.VV 
InfoVV 
(VV 
$"VV 
$strVV !
{VV! "
MatchIdVV" )
}VV) *
$strVV* >
"VV> ?
)VV? @
;VV@ A
	BroadcastXX 
(XX 
connXX 
=>XX !
connXX" &
.XX& '
CallbackXX' /
.XX/ 0
OnGameStartingXX0 >
(XX> ?
_countdownSecondsXX? P
)XXP Q
)XXQ R
;XXR S
_countdownTimerZZ 
=ZZ  !
newZZ" %
TimerZZ& +
(ZZ+ ,
stateZZ, 1
=>ZZ2 4
{[[ 
try\\ 
{]] 
_countdownTimer^^ '
?^^' (
.^^( )
Change^^) /
(^^/ 0
Timeout^^0 7
.^^7 8
Infinite^^8 @
,^^@ A
Timeout^^B I
.^^I J
Infinite^^J R
)^^R S
;^^S T
_countdownSeconds__ )
--__) +
;__+ ,
ifaa 
(aa 
_countdownSecondsaa -
>aa. /
$numaa0 1
)aa1 2
{bb 
	Broadcastcc %
(cc% &
conncc& *
=>cc+ -
conncc. 2
.cc2 3
Callbackcc3 ;
.cc; <
OnGameStartingcc< J
(ccJ K
_countdownSecondsccK \
)cc\ ]
)cc] ^
;cc^ _
_countdownTimerdd +
?dd+ ,
.dd, -
Changedd- 3
(dd3 4
TimeSpandd4 <
.dd< =
FromSecondsdd= H
(ddH I
$numddI J
)ddJ K
,ddK L
TimeSpanddM U
.ddU V
FromSecondsddV a
(dda b
$numddb c
)ddc d
)ddd e
;dde f
}ee 
elseff 
{gg 
ifhh 
(hh  
!hh  !
_gameHasStartedhh! 0
)hh0 1
{ii 
_gameHasStartedjj  /
=jj0 1
truejj2 6
;jj6 7
_countdownTimerkk  /
?kk/ 0
.kk0 1
Disposekk1 8
(kk8 9
)kk9 :
;kk: ;
_countdownTimerll  /
=ll0 1
nullll2 6
;ll6 7
lognn  #
.nn# $
Infonn$ (
(nn( )
$"nn) +
$strnn+ 1
{nn1 2
MatchIdnn2 9
}nn9 :
$strnn: I
"nnI J
)nnJ K
;nnK L
	Broadcastoo  )
(oo) *
connoo* .
=>oo/ 1
connoo2 6
.oo6 7
Callbackoo7 ?
.oo? @
OnGameStartedoo@ M
(ooM N
)ooN O
)ooO P
;ooP Q
onGameStartedpp  -
?pp- .
.pp. /
Invokepp/ 5
(pp5 6
MatchIdpp6 =
)pp= >
;pp> ?
}qq 
}rr 
}ss 
catchtt 
(tt 
	Exceptiontt $
extt% '
)tt' (
{uu 
logvv 
.vv 
Errorvv !
(vv! "
$"vv" $
$strvv$ *
{vv* +
MatchIdvv+ 2
}vv2 3
$strvv3 N
"vvN O
,vvO P
exvvQ S
)vvS T
;vvT U
}ww 
}xx 
,xx 
nullxx 
,xx 
TimeSpanxx !
.xx! "
FromSecondsxx" -
(xx- .
$numxx. /
)xx/ 0
,xx0 1
TimeSpanxx2 :
.xx: ;
FromSecondsxx; F
(xxF G
$numxxG H
)xxH I
)xxI J
;xxJ K
}yy 
public{{ 
void{{ 
	Broadcast{{ !
({{! "
Action{{" (
<{{( )
PlayerConnection{{) 9
>{{9 :
action{{; A
){{A B
{|| 
foreach}} 
(}} 
var}} 

playerConn}} '
in}}( *
Players}}+ 2
.}}2 3
Values}}3 9
)}}9 :
{~~ 
try 
{
ÄÄ 
action
ÅÅ 
(
ÅÅ 

playerConn
ÅÅ )
)
ÅÅ) *
;
ÅÅ* +
}
ÇÇ 
catch
ÉÉ 
{
ÑÑ 
}
ÖÖ 
}
ÜÜ 
}
áá 
}
àà 	
public
ää 
async
ää 
Task
ää 
ConnectAsync
ää &
(
ää& '
string
ää' -
username
ää. 6
,
ää6 7
string
ää8 >
matchId
ää? F
)
ääF G
{
ãã 	
var
åå 
callback
åå 
=
åå 
OperationContext
åå +
.
åå+ ,
Current
åå, 3
.
åå3 4 
GetCallbackChannel
åå4 F
<
ååF G#
ILobbyServiceCallback
ååG \
>
åå\ ]
(
åå] ^
)
åå^ _
;
åå_ `
Lobby
çç 
lobby
çç 
=
çç 
await
çç #
GetOrCreateLobbyAsync
çç  5
(
çç5 6
matchId
çç6 =
,
çç= >
username
çç? G
,
ççG H
callback
ççI Q
)
ççQ R
;
ççR S
if
èè 
(
èè 
lobby
èè 
==
èè 
null
èè 
)
èè 
{
êê 
return
ëë 
;
ëë 
}
íí 
AddPlayerToLobby
îî 
(
îî 
lobby
îî "
,
îî" #
username
îî$ ,
,
îî, -
callback
îî. 6
)
îî6 7
;
îî7 8
}
ïï 	
public
óó 
void
óó 

Disconnect
óó 
(
óó 
string
óó %
username
óó& .
,
óó. /
string
óó0 6
matchId
óó7 >
)
óó> ?
{
òò 	
_matchmakingLogic
ôô 
.
ôô 
HandlePlayerLeave
ôô /
(
ôô/ 0
username
ôô0 8
,
ôô8 9
matchId
ôô: A
)
ôôA B
;
ôôB C
if
õõ 
(
õõ 
_lobbies
õõ 
.
õõ 
TryGetValue
õõ $
(
õõ$ %
matchId
õõ% ,
,
õõ, -
out
õõ. 1
Lobby
õõ2 7
lobby
õõ8 =
)
õõ= >
)
õõ> ?
{
úú 
if
ùù 
(
ùù 
lobby
ùù 
.
ùù 
Players
ùù !
.
ùù! "
	TryRemove
ùù" +
(
ùù+ ,
username
ùù, 4
,
ùù4 5
out
ùù6 9
PlayerConnection
ùù: J
removedPlayer
ùùK X
)
ùùX Y
)
ùùY Z
{
ûû 
_log
üü 
.
üü 
Info
üü 
(
üü 
$"
üü  
$str
üü  (
{
üü( )
removedPlayer
üü) 6
.
üü6 7
DisplayName
üü7 B
}
üüB C
$str
üüC P
{
üüP Q
matchId
üüQ X
}
üüX Y
$str
üüY Z
"
üüZ [
)
üü[ \
;
üü\ ]
if
°° 
(
°° 
username
°°  
.
°°  !
Equals
°°! '
(
°°' (
lobby
°°( -
.
°°- .
HostUsername
°°. :
,
°°: ;
StringComparison
°°< L
.
°°L M
OrdinalIgnoreCase
°°M ^
)
°°^ _
)
°°_ `
{
¢¢ 
_log
££ 
.
££ 
Info
££ !
(
££! "
$"
££" $
$str
££$ @
{
££@ A
matchId
££A H
}
££H I
$str
££I J
"
££J K
)
££K L
;
££L M
lobby
§§ 
.
§§ 
	Broadcast
§§ '
(
§§' (
conn
§§( ,
=>
§§- /
{
•• 
SafeCallback
¶¶ (
(
¶¶( )
conn
¶¶) -
.
¶¶- .
Callback
¶¶. 6
,
¶¶6 7
(
¶¶8 9
)
¶¶9 :
=>
¶¶; =
conn
¶¶> B
.
¶¶B C
Callback
¶¶C K
.
¶¶K L
KickedFromLobby
¶¶L [
(
¶¶[ \
Lang
¶¶\ `
.
¶¶` a
Error_HostLeft
¶¶a o
)
¶¶o p
)
¶¶p q
;
¶¶q r
}
ßß 
)
ßß 
;
ßß 
RemoveLobby
®® #
(
®®# $
matchId
®®$ +
)
®®+ ,
;
®®, -
}
©© 
else
™™ 
{
´´ !
BroadcastLobbyState
¨¨ +
(
¨¨+ ,
lobby
¨¨, 1
)
¨¨1 2
;
¨¨2 3
}
≠≠ 
}
ÆÆ 
if
∞∞ 
(
∞∞ 
lobby
∞∞ 
.
∞∞ 
Players
∞∞ !
.
∞∞! "
IsEmpty
∞∞" )
)
∞∞) *
{
±± 
RemoveLobby
≤≤ 
(
≤≤  
matchId
≤≤  '
)
≤≤' (
;
≤≤( )
}
≥≥ 
}
¥¥ 
}
µµ 	
public
∑∑ 
void
∑∑ 
SendMessage
∑∑ 
(
∑∑  
string
∑∑  &
senderUsername
∑∑' 5
,
∑∑5 6
string
∑∑7 =
matchId
∑∑> E
,
∑∑E F
string
∑∑G M
messageContent
∑∑N \
)
∑∑\ ]
{
∏∏ 	
if
ππ 
(
ππ 
_lobbies
ππ 
.
ππ 
TryGetValue
ππ $
(
ππ$ %
matchId
ππ% ,
,
ππ, -
out
ππ. 1
Lobby
ππ2 7
lobby
ππ8 =
)
ππ= >
)
ππ> ?
{
∫∫ 
string
ªª 
senderDisplayName
ªª (
=
ªª) *
senderUsername
ªª+ 9
;
ªª9 :
if
ΩΩ 
(
ΩΩ 
lobby
ΩΩ 
.
ΩΩ 
Players
ΩΩ !
.
ΩΩ! "
TryGetValue
ΩΩ" -
(
ΩΩ- .
senderUsername
ΩΩ. <
,
ΩΩ< =
out
ΩΩ> A
var
ΩΩB E
senderConnection
ΩΩF V
)
ΩΩV W
)
ΩΩW X
{
ææ 
senderDisplayName
øø %
=
øø& '
senderConnection
øø( 8
.
øø8 9
DisplayName
øø9 D
;
øøD E
}
¿¿ 
string
¬¬ 
cleanMessage
¬¬ #
=
¬¬$ %
BadWordValidator
¬¬& 6
.
¬¬6 7

BanMessage
¬¬7 A
(
¬¬A B
messageContent
¬¬B P
)
¬¬P Q
;
¬¬Q R
var
ƒƒ 

messageDto
ƒƒ 
=
ƒƒ  
new
ƒƒ! $
ChatMessageDto
ƒƒ% 3
{
≈≈ 
SenderUsername
∆∆ "
=
∆∆# $
senderDisplayName
∆∆% 6
,
∆∆6 7
MessageContent
«« "
=
««# $
cleanMessage
««% 1
,
««1 2
	Timestamp
»» 
=
»» 
DateTime
»»  (
.
»»( )
UtcNow
»») /
}
…… 
;
…… 
lobby
ÀÀ 
.
ÀÀ 
	Broadcast
ÀÀ 
(
ÀÀ  
conn
ÀÀ  $
=>
ÀÀ% '
conn
ÀÀ( ,
.
ÀÀ, -
Callback
ÀÀ- 5
.
ÀÀ5 6!
ReceiveLobbyMessage
ÀÀ6 I
(
ÀÀI J

messageDto
ÀÀJ T
)
ÀÀT U
)
ÀÀU V
;
ÀÀV W
}
ÃÃ 
}
ÕÕ 	
public
œœ 
void
œœ 

KickPlayer
œœ 
(
œœ 
string
œœ %
hostUsername
œœ& 2
,
œœ2 3
string
œœ4 :"
playerToKickUsername
œœ; O
,
œœO P
string
œœQ W
matchId
œœX _
)
œœ_ `
{
–– 	
if
—— 
(
—— 
_lobbies
—— 
.
—— 
TryGetValue
—— $
(
——$ %
matchId
——% ,
,
——, -
out
——. 1
Lobby
——2 7
lobby
——8 =
)
——= >
)
——> ?
{
““ 
if
”” 
(
”” 
!
”” 
hostUsername
”” !
.
””! "
Equals
””" (
(
””( )
lobby
””) .
.
””. /
HostUsername
””/ ;
,
””; <
StringComparison
””= M
.
””M N
OrdinalIgnoreCase
””N _
)
””_ `
)
””` a
{
‘‘ 
_log
’’ 
.
’’ 
Warn
’’ 
(
’’ 
$"
’’  
$str
’’  .
{
’’. /
hostUsername
’’/ ;
}
’’; <
$str
’’< M
{
’’M N
matchId
’’N U
}
’’U V
$str
’’V W
"
’’W X
)
’’X Y
;
’’Y Z
return
÷÷ 
;
÷÷ 
}
◊◊ 
var
ŸŸ 

targetPair
ŸŸ 
=
ŸŸ  
lobby
ŸŸ! &
.
ŸŸ& '
Players
ŸŸ' .
.
ŸŸ. /
FirstOrDefault
ŸŸ/ =
(
ŸŸ= >
p
ŸŸ> ?
=>
ŸŸ@ B
p
ŸŸC D
.
ŸŸD E
Value
ŸŸE J
.
ŸŸJ K
DisplayName
ŸŸK V
.
ŸŸV W
Equals
ŸŸW ]
(
ŸŸ] ^"
playerToKickUsername
ŸŸ^ r
,
ŸŸr s
StringComparisonŸŸt Ñ
.ŸŸÑ Ö!
OrdinalIgnoreCaseŸŸÖ ñ
)ŸŸñ ó
)ŸŸó ò
;ŸŸò ô
if
€€ 
(
€€ 

targetPair
€€ 
.
€€ 
Value
€€ $
==
€€% '
null
€€( ,
)
€€, -
{
‹‹ 
if
›› 
(
›› 
lobby
›› 
.
›› 
Players
›› %
.
››% &
TryGetValue
››& 1
(
››1 2"
playerToKickUsername
››2 F
,
››F G
out
››H K
var
››L O
conn
››P T
)
››T U
)
››U V
{
ﬁﬁ 

targetPair
ﬂﬂ "
=
ﬂﬂ# $
new
ﬂﬂ% (
KeyValuePair
ﬂﬂ) 5
<
ﬂﬂ5 6
string
ﬂﬂ6 <
,
ﬂﬂ< =
PlayerConnection
ﬂﬂ> N
>
ﬂﬂN O
(
ﬂﬂO P"
playerToKickUsername
ﬂﬂP d
,
ﬂﬂd e
conn
ﬂﬂf j
)
ﬂﬂj k
;
ﬂﬂk l
}
‡‡ 
}
·· 
if
„„ 
(
„„ 

targetPair
„„ 
.
„„ 
Value
„„ $
==
„„% '
null
„„( ,
)
„„, -
{
‰‰ 
_log
ÂÂ 
.
ÂÂ 
Warn
ÂÂ 
(
ÂÂ 
$"
ÂÂ  
$str
ÂÂ  5
{
ÂÂ5 6"
playerToKickUsername
ÂÂ6 J
}
ÂÂJ K
$str
ÂÂK `
"
ÂÂ` a
)
ÂÂa b
;
ÂÂb c
return
ÊÊ 
;
ÊÊ 
}
ÁÁ 
string
ÈÈ  
targetRealUsername
ÈÈ )
=
ÈÈ* +

targetPair
ÈÈ, 6
.
ÈÈ6 7
Key
ÈÈ7 :
;
ÈÈ: ;
if
ÎÎ 
(
ÎÎ 
hostUsername
ÎÎ  
.
ÎÎ  !
Equals
ÎÎ! '
(
ÎÎ' ( 
targetRealUsername
ÎÎ( :
,
ÎÎ: ;
StringComparison
ÎÎ< L
.
ÎÎL M
OrdinalIgnoreCase
ÎÎM ^
)
ÎÎ^ _
)
ÎÎ_ `
{
ÏÏ 
return
ÌÌ 
;
ÌÌ 
}
ÓÓ 
if
 
(
 
lobby
 
.
 
Players
 !
.
! "
	TryRemove
" +
(
+ , 
targetRealUsername
, >
,
> ?
out
@ C
PlayerConnection
D T

kickedConn
U _
)
_ `
)
` a
{
ÒÒ 
_matchmakingLogic
ÚÚ %
.
ÚÚ% &
HandlePlayerLeave
ÚÚ& 7
(
ÚÚ7 8 
targetRealUsername
ÚÚ8 J
,
ÚÚJ K
matchId
ÚÚL S
)
ÚÚS T
;
ÚÚT U
_log
ÙÙ 
.
ÙÙ 
Info
ÙÙ 
(
ÙÙ 
$"
ÙÙ  
$str
ÙÙ  (
{
ÙÙ( ) 
targetRealUsername
ÙÙ) ;
}
ÙÙ; <
$str
ÙÙ< J
{
ÙÙJ K
matchId
ÙÙK R
}
ÙÙR S
$str
ÙÙS T
"
ÙÙT U
)
ÙÙU V
;
ÙÙV W
SafeCallback
ıı  
(
ıı  !

kickedConn
ıı! +
.
ıı+ ,
Callback
ıı, 4
,
ıı4 5
(
ıı6 7
)
ıı7 8
=>
ıı9 ;

kickedConn
ıı< F
.
ııF G
Callback
ııG O
.
ııO P
KickedFromLobby
ııP _
(
ıı_ `
Lang
ıı` d
.
ııd e 
Error_KickedByHost
ııe w
)
ııw x
)
ııx y
;
ııy z!
BroadcastLobbyState
˜˜ '
(
˜˜' (
lobby
˜˜( -
)
˜˜- .
;
˜˜. /
}
¯¯ 
}
˘˘ 
}
˙˙ 	
public
¸¸ 
void
¸¸ 
	StartGame
¸¸ 
(
¸¸ 
string
¸¸ $
hostUsername
¸¸% 1
,
¸¸1 2
string
¸¸3 9
matchId
¸¸: A
)
¸¸A B
{
˝˝ 	
if
˛˛ 
(
˛˛ 
_lobbies
˛˛ 
.
˛˛ 
TryGetValue
˛˛ $
(
˛˛$ %
matchId
˛˛% ,
,
˛˛, -
out
˛˛. 1
Lobby
˛˛2 7
lobby
˛˛8 =
)
˛˛= >
)
˛˛> ?
{
ˇˇ 
if
ÄÄ 
(
ÄÄ 
!
ÄÄ 
hostUsername
ÄÄ !
.
ÄÄ! "
Equals
ÄÄ" (
(
ÄÄ( )
lobby
ÄÄ) .
.
ÄÄ. /
HostUsername
ÄÄ/ ;
,
ÄÄ; <
StringComparison
ÄÄ= M
.
ÄÄM N
OrdinalIgnoreCase
ÄÄN _
)
ÄÄ_ `
)
ÄÄ` a
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
ÖÖ! "
Count
ÖÖ" '
<
ÖÖ( )
$num
ÖÖ* +
)
ÖÖ+ ,
{
ÜÜ 
return
áá 
;
áá 
}
àà 
_log
ää 
.
ää 
Info
ää 
(
ää 
$"
ää 
$str
ää >
{
ää> ?
matchId
ää? F
}
ääF G
$str
ääG H
"
ääH I
)
ääI J
;
ääJ K
lobby
åå 
.
åå 
StartCountdown
åå $
(
åå$ %
_log
åå% )
,
åå) *
(
åå+ ,
id
åå, .
)
åå. /
=>
åå0 2
{
çç 
_matchmakingLogic
éé %
.
éé% &
SetMatchAsPlaying
éé& 7
(
éé7 8
id
éé8 :
)
éé: ;
;
éé; <
RemoveLobby
èè 
(
èè  
id
èè  "
)
èè" #
;
èè# $
}
êê 
)
êê 
;
êê 
}
ëë 
}
íí 	
public
îî 
void
îî 
CleanUpClient
îî !
(
îî! "#
ILobbyServiceCallback
îî" 7
callback
îî8 @
)
îî@ A
{
ïï 	
string
ññ 
userToRemove
ññ 
=
ññ  !
null
ññ" &
;
ññ& '
string
óó 
matchIdToRemove
óó "
=
óó# $
null
óó% )
;
óó) *
foreach
ôô 
(
ôô 
var
ôô 
	lobbyPair
ôô "
in
ôô# %
_lobbies
ôô& .
)
ôô. /
{
öö 
foreach
õõ 
(
õõ 
var
õõ 

playerPair
õõ '
in
õõ( *
	lobbyPair
õõ+ 4
.
õõ4 5
Value
õõ5 :
.
õõ: ;
Players
õõ; B
)
õõB C
{
úú 
if
ùù 
(
ùù 

playerPair
ùù "
.
ùù" #
Value
ùù# (
.
ùù( )
Callback
ùù) 1
==
ùù2 4
callback
ùù5 =
)
ùù= >
{
ûû 
userToRemove
üü $
=
üü% &

playerPair
üü' 1
.
üü1 2
Key
üü2 5
;
üü5 6
matchIdToRemove
†† '
=
††( )
	lobbyPair
††* 3
.
††3 4
Key
††4 7
;
††7 8
break
°° 
;
°° 
}
¢¢ 
}
££ 
if
•• 
(
•• 
userToRemove
••  
!=
••! #
null
••$ (
)
••( )
{
¶¶ 
break
ßß 
;
ßß 
}
®® 
}
©© 
if
´´ 
(
´´ 
userToRemove
´´ 
!=
´´ 
null
´´  $
&&
´´% '
matchIdToRemove
´´( 7
!=
´´8 :
null
´´; ?
)
´´? @
{
¨¨ 

Disconnect
≠≠ 
(
≠≠ 
userToRemove
≠≠ '
,
≠≠' (
matchIdToRemove
≠≠) 8
)
≠≠8 9
;
≠≠9 :
}
ÆÆ 
}
ØØ 	
private
±± 
async
±± 
Task
±± 
<
±± 
Lobby
±±  
>
±±  !#
GetOrCreateLobbyAsync
±±" 7
(
±±7 8
string
±±8 >
matchId
±±? F
,
±±F G
string
±±H N
hostUsername
±±O [
,
±±[ \#
ILobbyServiceCallback
±±] r
callback
±±s {
)
±±{ |
{
≤≤ 	
if
≥≥ 
(
≥≥ 
_lobbies
≥≥ 
.
≥≥ 
TryGetValue
≥≥ $
(
≥≥$ %
matchId
≥≥% ,
,
≥≥, -
out
≥≥. 1
Lobby
≥≥2 7
existingLobby
≥≥8 E
)
≥≥E F
)
≥≥F G
{
¥¥ 
return
µµ 
existingLobby
µµ $
;
µµ$ %
}
∂∂ 
var
∏∏ 
	matchInfo
∏∏ 
=
∏∏ 
await
∏∏ !
GetMatchInfoAsync
∏∏" 3
(
∏∏3 4
matchId
∏∏4 ;
)
∏∏; <
;
∏∏< =
if
∫∫ 
(
∫∫ 
	matchInfo
∫∫ 
==
∫∫ 
null
∫∫ !
)
∫∫! "
{
ªª 
SafeCallback
ºº 
(
ºº 
callback
ºº %
,
ºº% &
(
ºº' (
)
ºº( )
=>
ºº* ,
callback
ºº- 5
.
ºº5 6
KickedFromLobby
ºº6 E
(
ººE F
Lang
ººF J
.
ººJ K!
Error_MatchNotFound
ººK ^
)
ºº^ _
)
ºº_ `
;
ºº` a
return
ΩΩ 
null
ΩΩ 
;
ΩΩ 
}
ææ 
lock
¿¿ 
(
¿¿ 
_lock
¿¿ 
)
¿¿ 
{
¡¡ 
if
¬¬ 
(
¬¬ 
_lobbies
¬¬ 
.
¬¬ 
TryGetValue
¬¬ (
(
¬¬( )
matchId
¬¬) 0
,
¬¬0 1
out
¬¬2 5
existingLobby
¬¬6 C
)
¬¬C D
)
¬¬D E
{
√√ 
return
ƒƒ 
existingLobby
ƒƒ (
;
ƒƒ( )
}
≈≈ 
var
«« 
newLobby
«« 
=
«« 
new
«« "
Lobby
««# (
(
««( )
matchId
««) 0
,
««0 1
hostUsername
««2 >
,
««> ?
	matchInfo
««@ I
)
««I J
;
««J K
_lobbies
»» 
.
»» 
TryAdd
»» 
(
»»  
matchId
»»  '
,
»»' (
newLobby
»») 1
)
»»1 2
;
»»2 3
_log
…… 
.
…… 
Info
…… 
(
…… 
$"
…… 
$str
…… "
{
……" #
matchId
……# *
}
……* +
$str
……+ B
"
……B C
)
……C D
;
……D E
return
   
newLobby
   
;
    
}
ÀÀ 
}
ÃÃ 	
private
ŒŒ 
async
ŒŒ 
Task
ŒŒ 
<
ŒŒ 
MatchInfoDto
ŒŒ '
>
ŒŒ' (
GetMatchInfoAsync
ŒŒ) :
(
ŒŒ: ;
string
ŒŒ; A
matchId
ŒŒB I
)
ŒŒI J
{
œœ 	
if
–– 
(
–– 
!
–– 
int
–– 
.
–– 
TryParse
–– 
(
–– 
matchId
–– %
,
––% &
out
––' *
int
––+ .
id
––/ 1
)
––1 2
)
––2 3
{
—— 
return
““ 
null
““ 
;
““ 
}
”” 
try
’’ 
{
÷÷ 
var
◊◊ 
match
◊◊ 
=
◊◊ 
await
◊◊ !
_matchRepository
◊◊" 2
.
◊◊2 3
GetMatchByIdAsync
◊◊3 D
(
◊◊D E
id
◊◊E G
)
◊◊G H
;
◊◊H I
if
ÿÿ 
(
ÿÿ 
match
ÿÿ 
==
ÿÿ 
null
ÿÿ !
||
ÿÿ" $
match
ÿÿ% *
.
ÿÿ* +
matchStatus
ÿÿ+ 6
!=
ÿÿ7 9
$str
ÿÿ: C
)
ÿÿC D
{
ŸŸ 
return
⁄⁄ 
null
⁄⁄ 
;
⁄⁄  
}
€€ 
string
›› 
diffName
›› 
=
››  !
await
››" '
_matchRepository
››( 8
.
››8 9$
GetDifficultyNameAsync
››9 O
(
››O P
match
››P U
.
››U V/
!MatchDifficulty_idMatchDifficulty
››V w
.
››w x 
GetValueOrDefault››x â
(››â ä
)››ä ã
)››ã å
;››å ç
return
ﬂﬂ 
new
ﬂﬂ 
MatchInfoDto
ﬂﬂ '
{
‡‡ 
MatchId
·· 
=
·· 
matchId
·· %
,
··% &
	MatchCode
‚‚ 
=
‚‚ 
match
‚‚  %
.
‚‚% &
	matchCode
‚‚& /
,
‚‚/ 0
	MatchName
„„ 
=
„„ 
match
„„  %
.
„„% &
	matchName
„„& /
,
„„/ 0
HostUsername
‰‰  
=
‰‰! "
$str
‰‰# )
,
‰‰) *
DifficultyName
ÂÂ "
=
ÂÂ# $
diffName
ÂÂ% -
,
ÂÂ- .

MaxPlayers
ÊÊ 
=
ÊÊ  
match
ÊÊ! &
.
ÊÊ& '

maxPlayers
ÊÊ' 1
,
ÊÊ1 2
	IsPrivate
ÁÁ 
=
ÁÁ 
match
ÁÁ  %
.
ÁÁ% &
	isPrivate
ÁÁ& /
==
ÁÁ0 2
$num
ÁÁ3 4
}
ËË 
;
ËË 
}
ÈÈ 
catch
ÍÍ 
(
ÍÍ 
	Exception
ÍÍ 
ex
ÍÍ 
)
ÍÍ  
{
ÎÎ 
_log
ÏÏ 
.
ÏÏ 
Error
ÏÏ 
(
ÏÏ 
$"
ÏÏ 
$str
ÏÏ ;
{
ÏÏ; <
matchId
ÏÏ< C
}
ÏÏC D
"
ÏÏD E
,
ÏÏE F
ex
ÏÏG I
)
ÏÏI J
;
ÏÏJ K
return
ÌÌ 
null
ÌÌ 
;
ÌÌ 
}
ÓÓ 
}
ÔÔ 	
private
ÒÒ 
void
ÒÒ 
AddPlayerToLobby
ÒÒ %
(
ÒÒ% &
Lobby
ÒÒ& +
lobby
ÒÒ, 1
,
ÒÒ1 2
string
ÒÒ3 9
username
ÒÒ: B
,
ÒÒB C#
ILobbyServiceCallback
ÒÒD Y
callback
ÒÒZ b
)
ÒÒb c
{
ÚÚ 	
if
ÛÛ 
(
ÛÛ 
lobby
ÛÛ 
.
ÛÛ 
Players
ÛÛ 
.
ÛÛ 
Count
ÛÛ #
>=
ÛÛ$ &
lobby
ÛÛ' ,
.
ÛÛ, -
	MatchInfo
ÛÛ- 6
.
ÛÛ6 7

MaxPlayers
ÛÛ7 A
&&
ÛÛB D
!
ÛÛE F
lobby
ÛÛF K
.
ÛÛK L
Players
ÛÛL S
.
ÛÛS T
ContainsKey
ÛÛT _
(
ÛÛ_ `
username
ÛÛ` h
)
ÛÛh i
)
ÛÛi j
{
ÙÙ 
SafeCallback
ıı 
(
ıı 
callback
ıı %
,
ıı% &
(
ıı' (
)
ıı( )
=>
ıı* ,
callback
ıı- 5
.
ıı5 6
KickedFromLobby
ıı6 E
(
ııE F
Lang
ııF J
.
ııJ K
Error_LobbyFull
ııK Z
)
ııZ [
)
ıı[ \
;
ıı\ ]
return
ˆˆ 
;
ˆˆ 
}
˜˜ 
string
˘˘ 
displayName
˘˘ 
=
˘˘  
username
˘˘! )
;
˘˘) *
bool
˙˙ 
isGuest
˙˙ 
=
˙˙ 
false
˙˙  
;
˙˙  !
if
¸¸ 
(
¸¸ 
username
¸¸ 
.
¸¸ 

StartsWith
¸¸ #
(
¸¸# $
$str
¸¸$ ,
)
¸¸, -
)
¸¸- .
{
˝˝ 
if
˛˛ 
(
˛˛ 
lobby
˛˛ 
.
˛˛ 
Players
˛˛ !
.
˛˛! "
TryGetValue
˛˛" -
(
˛˛- .
username
˛˛. 6
,
˛˛6 7
out
˛˛8 ;
var
˛˛< ?
existing
˛˛@ H
)
˛˛H I
)
˛˛I J
{
ˇˇ 
displayName
ÄÄ 
=
ÄÄ  !
existing
ÄÄ" *
.
ÄÄ* +
DisplayName
ÄÄ+ 6
;
ÄÄ6 7
}
ÅÅ 
else
ÇÇ 
{
ÉÉ 
displayName
ÑÑ 
=
ÑÑ  !
$"
ÑÑ" $
{
ÑÑ$ %
Lang
ÑÑ% )
.
ÑÑ) *

Info_Guest
ÑÑ* 4
}
ÑÑ4 5
$str
ÑÑ5 6
{
ÑÑ6 7
lobby
ÑÑ7 <
.
ÑÑ< = 
GetNextGuestNumber
ÑÑ= O
(
ÑÑO P
)
ÑÑP Q
}
ÑÑQ R
"
ÑÑR S
;
ÑÑS T
isGuest
ÖÖ 
=
ÖÖ 
true
ÖÖ "
;
ÖÖ" #
}
ÜÜ 
}
áá 
var
ââ 

connection
ââ 
=
ââ 
new
ââ  
PlayerConnection
ââ! 1
(
ââ1 2
username
ââ2 :
,
ââ: ;
displayName
ââ< G
,
ââG H
callback
ââI Q
)
ââQ R
;
ââR S
if
ãã 
(
ãã 
lobby
ãã 
.
ãã 
Players
ãã 
.
ãã 
TryAdd
ãã $
(
ãã$ %
username
ãã% -
,
ãã- .

connection
ãã/ 9
)
ãã9 :
)
ãã: ;
{
åå 
_log
çç 
.
çç 
Info
çç 
(
çç 
$"
çç 
$str
çç $
{
çç$ %
displayName
çç% 0
}
çç0 1
$str
çç1 B
{
ççB C
lobby
ççC H
.
ççH I
MatchId
ççI P
}
ççP Q
$str
ççQ R
"
ççR S
)
ççS T
;
ççT U
if
èè 
(
èè 
isGuest
èè 
)
èè 
{
êê 
SafeCallback
ëë  
(
ëë  !
callback
ëë! )
,
ëë) *
(
ëë+ ,
)
ëë, -
=>
ëë. 0
callback
ëë1 9
.
ëë9 :!
ReceiveLobbyMessage
ëë: M
(
ëëM N
new
ëëN Q
ChatMessageDto
ëëR `
{
íí 
SenderUsername
ìì &
=
ìì' (
$str
ìì) 1
,
ìì1 2
MessageContent
îî &
=
îî' (
$"
îî) +
{
îî+ ,
Lang
îî, 0
.
îî0 1
Info_GuestName
îî1 ?
}
îî? @
$str
îî@ A
{
îîA B
displayName
îîB M
}
îîM N
"
îîN O
,
îîO P
	Timestamp
ïï !
=
ïï" #
DateTime
ïï$ ,
.
ïï, -
UtcNow
ïï- 3
}
ññ 
)
ññ 
)
ññ 
;
ññ 
}
óó !
BroadcastLobbyState
ôô #
(
ôô# $
lobby
ôô$ )
)
ôô) *
;
ôô* +
}
öö 
else
õõ 
{
úú 
if
ùù 
(
ùù 
lobby
ùù 
.
ùù 
Players
ùù !
.
ùù! "
TryGetValue
ùù" -
(
ùù- .
username
ùù. 6
,
ùù6 7
out
ùù8 ;
var
ùù< ?
oldConn
ùù@ G
)
ùùG H
)
ùùH I
{
ûû 
var
üü 
newConn
üü 
=
üü  !
new
üü" %
PlayerConnection
üü& 6
(
üü6 7
username
üü7 ?
,
üü? @
oldConn
üüA H
.
üüH I
DisplayName
üüI T
,
üüT U
callback
üüV ^
)
üü^ _
;
üü_ `
lobby
†† 
.
†† 
Players
†† !
.
††! "
	TryUpdate
††" +
(
††+ ,
username
††, 4
,
††4 5
newConn
††6 =
,
††= >
oldConn
††? F
)
††F G
;
††G H
_log
°° 
.
°° 
Info
°° 
(
°° 
$"
°°  
$str
°°  (
{
°°( )
username
°°) 1
}
°°1 2
$str
°°2 I
"
°°I J
)
°°J K
;
°°K L
SafeCallback
¢¢  
(
¢¢  !
callback
¢¢! )
,
¢¢) *
(
¢¢+ ,
)
¢¢, -
=>
¢¢. 0
callback
¢¢1 9
.
¢¢9 :
UpdateLobbyState
¢¢: J
(
¢¢J K
lobby
¢¢K P
.
¢¢P Q
GetCurrentState
¢¢Q `
(
¢¢` a
)
¢¢a b
)
¢¢b c
)
¢¢c d
;
¢¢d e
}
££ 
}
§§ 
}
•• 	
private
ßß 
static
ßß 
void
ßß !
BroadcastLobbyState
ßß /
(
ßß/ 0
Lobby
ßß0 5
lobby
ßß6 ;
)
ßß; <
{
®® 	
var
©© 
state
©© 
=
©© 
lobby
©© 
.
©© 
GetCurrentState
©© -
(
©©- .
)
©©. /
;
©©/ 0
lobby
™™ 
.
™™ 
	Broadcast
™™ 
(
™™ 
conn
™™  
=>
™™! #
conn
™™$ (
.
™™( )
Callback
™™) 1
.
™™1 2
UpdateLobbyState
™™2 B
(
™™B C
state
™™C H
)
™™H I
)
™™I J
;
™™J K
}
´´ 	
private
≠≠ 
static
≠≠ 
void
≠≠ 
RemoveLobby
≠≠ '
(
≠≠' (
string
≠≠( .
matchId
≠≠/ 6
)
≠≠6 7
{
ÆÆ 	
_lobbies
ØØ 
.
ØØ 
	TryRemove
ØØ 
(
ØØ 
matchId
ØØ &
,
ØØ& '
out
ØØ( +
_
ØØ, -
)
ØØ- .
;
ØØ. /
}
∞∞ 	
private
≤≤ 
static
≤≤ 
void
≤≤ 
SafeCallback
≤≤ (
(
≤≤( )#
ILobbyServiceCallback
≤≤) >
callback
≤≤? G
,
≤≤G H
Action
≤≤I O
action
≤≤P V
)
≤≤V W
{
≥≥ 	
try
¥¥ 
{
µµ 
action
∂∂ 
(
∂∂ 
)
∂∂ 
;
∂∂ 
}
∑∑ 
catch
∏∏ 
(
∏∏ 
	Exception
∏∏ 
ex
∏∏ 
)
∏∏  
{
ππ 
_log
∫∫ 
.
∫∫ 
Warn
∫∫ 
(
∫∫ 
$str
∫∫ Q
,
∫∫Q R
ex
∫∫S U
)
∫∫U V
;
∫∫V W
}
ªª 
}
ºº 	
private
ææ 
void
ææ 
ThrowServiceFault
ææ &
(
ææ& '
ServiceErrorType
ææ' 7
type
ææ8 <
,
ææ< =
string
ææ> D
message
ææE L
)
ææL M
{
øø 	
var
¿¿ 
fault
¿¿ 
=
¿¿ 
new
¿¿ 
ServiceFaultDto
¿¿ +
(
¿¿+ ,
type
¿¿, 0
,
¿¿0 1
message
¿¿2 9
)
¿¿9 :
;
¿¿: ;
throw
¡¡ 
new
¡¡ 
FaultException
¡¡ $
<
¡¡$ %
ServiceFaultDto
¡¡% 4
>
¡¡4 5
(
¡¡5 6
fault
¡¡6 ;
,
¡¡; <
new
¡¡= @
FaultReason
¡¡A L
(
¡¡L M
message
¡¡M T
)
¡¡T U
)
¡¡U V
;
¡¡V W
}
¬¬ 	
}
√√ 
}ƒƒ π≈
íC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\BusinessLogic\GameLogic.cs
	namespace 	
GuessMyMessServer
 
. 
BusinessLogic )
{ 
public 

enum 

MatchPhase 
{ 

NotStarted 
, 
Drawing 
, 
Guessing 
, 
Answers 
, 
Finished 
} 
public 

class 

MatchState 
{ 
public 
string 
MatchId 
{ 
get  #
;# $
set% (
;( )
}* +
public 

MatchPhase 
Phase 
{  !
get" %
;% &
set' *
;* +
}, -
=. /

MatchPhase0 :
.: ;

NotStarted; E
;E F
public 
Timer 
	GameTimer 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
int 
CurrentRound 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$num0 1
;1 2
public   
int   
TotalRounds   
{    
get  ! $
;  $ %
set  & )
;  ) *
}  + ,
public!! 
int!! 
CurrentDrawingIndex!! &
{!!' (
get!!) ,
;!!, -
set!!. 1
;!!1 2
}!!3 4
=!!5 6
$num!!7 8
;!!8 9
public"" 
List"" 
<"" 
string"" 
>"" 
Players"" #
{""$ %
get""& )
;"") *
set""+ .
;"". /
}""0 1
=""2 3
new""4 7
List""8 <
<""< =
string""= C
>""C D
(""D E
)""E F
;""F G
public## 

Dictionary## 
<## 
string##  
,##  !
string##" (
>##( )
PlayerSelectedWords##* =
{##> ?
get##@ C
;##C D
set##E H
;##H I
}##J K
=##L M
new##N Q

Dictionary##R \
<##\ ]
string##] c
,##c d
string##e k
>##k l
(##l m
)##m n
;##n o
public$$ 
List$$ 
<$$ 

DrawingDto$$ 
>$$ 
Drawings$$  (
{$$) *
get$$+ .
;$$. /
set$$0 3
;$$3 4
}$$5 6
=$$7 8
new$$9 <
List$$= A
<$$A B

DrawingDto$$B L
>$$L M
($$M N
)$$N O
;$$O P
public%% 
List%% 
<%% 
GuessDto%% 
>%% 
Guesses%% %
{%%& '
get%%( +
;%%+ ,
set%%- 0
;%%0 1
}%%2 3
=%%4 5
new%%6 9
List%%: >
<%%> ?
GuessDto%%? G
>%%G H
(%%H I
)%%I J
;%%J K
public&& 
List&& 
<&& 
PlayerScoreDto&& "
>&&" #
Scores&&$ *
{&&+ ,
get&&- 0
;&&0 1
set&&2 5
;&&5 6
}&&7 8
=&&9 :
new&&; >
List&&? C
<&&C D
PlayerScoreDto&&D R
>&&R S
(&&S T
)&&T U
;&&U V
public'' 

Dictionary'' 
<'' 
string''  
,''  !
int''" %
>''% &
PlayerWarnings''' 5
{''6 7
get''8 ;
;''; <
set''= @
;''@ A
}''B C
=''D E
new''F I

Dictionary''J T
<''T U
string''U [
,''[ \
int''] `
>''` a
(''a b
)''b c
;''c d
public)) 
void)) 
DisposeTimer))  
())  !
)))! "
{** 	
	GameTimer++ 
?++ 
.++ 
Dispose++ 
(++ 
)++  
;++  !
	GameTimer,, 
=,, 
null,, 
;,, 
}-- 	
}.. 
public00 

class00 
	GameLogic00 
{11 
private22 
static22 
readonly22 
ILog22  $
_log22% )
=22* +

LogManager22, 6
.226 7
	GetLogger227 @
(22@ A
typeof22A G
(22G H
	GameLogic22H Q
)22Q R
)22R S
;22S T
private33 
static33 
readonly33  
ConcurrentDictionary33  4
<334 5
string335 ;
,33; < 
IGameServiceCallback33= Q
>33Q R
_connectedPlayers33S d
=33e f
new33g j 
ConcurrentDictionary33k 
<	33 Ä
string
33Ä Ü
,
33Ü á"
IGameServiceCallback
33à ú
>
33ú ù
(
33ù û
)
33û ü
;
33ü †
private44 
static44 
readonly44 

Dictionary44  *
<44* +
string44+ 1
,441 2

MatchState443 =
>44= >
_matches44? G
=44H I
new44J M

Dictionary44N X
<44X Y
string44Y _
,44_ `

MatchState44a k
>44k l
(44l m
)44m n
;44n o
private55 
static55 
readonly55 
object55  &
_gameStateLock55' 5
=556 7
new558 ;
object55< B
(55B C
)55C D
;55D E
private77 
const77 
int77 
CorrectGuessScore77 +
=77, -
$num77. 0
;770 1
private88 
const88 
int88 (
DrawingGuessedCorrectlyScore88 6
=887 8
$num889 ;
;88; <
private:: 
readonly:: 
IWordRepository:: (
_wordRepository::) 8
;::8 9
private;; 
readonly;; 
IMatchRepository;; )
_matchRepository;;* :
;;;: ;
private<< 
readonly<< 
IPlayerRepository<< *
_playerRepository<<+ <
;<<< =
public>> 
	GameLogic>> 
(>> 
IWordRepository?? 
wordRepository?? *
,??* +
IMatchRepository@@ 
matchRepository@@ ,
,@@, -
IPlayerRepositoryAA 
playerRepositoryAA .
)AA. /
{BB 	
_wordRepositoryCC 
=CC 
wordRepositoryCC ,
;CC, -
_matchRepositoryDD 
=DD 
matchRepositoryDD .
;DD. /
_playerRepositoryEE 
=EE 
playerRepositoryEE  0
;EE0 1
}FF 	
publicHH 
voidHH 
ConnectPlayerHH !
(HH! "
stringHH" (
usernameHH) 1
,HH1 2
stringHH3 9
matchIdHH: A
,HHA B 
IGameServiceCallbackHHC W
callbackHHX `
)HH` a
{II 	
_connectedPlayersJJ 
.JJ 
AddOrUpdateJJ )
(JJ) *
usernameJJ* 2
,JJ2 3
callbackJJ4 <
,JJ< =
(JJ> ?
keyJJ? B
,JJB C
oldJJD G
)JJG H
=>JJI K
callbackJJL T
)JJT U
;JJU V
lockLL 
(LL 
_gameStateLockLL  
)LL  !
{MM 
ifNN 
(NN 
!NN 
_matchesNN 
.NN 
ContainsKeyNN )
(NN) *
matchIdNN* 1
)NN1 2
)NN2 3
{OO 
_matchesPP 
[PP 
matchIdPP $
]PP$ %
=PP& '
newPP( +

MatchStatePP, 6
{PP7 8
MatchIdPP9 @
=PPA B
matchIdPPC J
}PPK L
;PPL M
}QQ 
varSS 
matchSS 
=SS 
_matchesSS $
[SS$ %
matchIdSS% ,
]SS, -
;SS- .
ifTT 
(TT 
!TT 
matchTT 
.TT 
PlayersTT "
.TT" #
ContainsTT# +
(TT+ ,
usernameTT, 4
)TT4 5
)TT5 6
{UU 
matchVV 
.VV 
PlayersVV !
.VV! "
AddVV" %
(VV% &
usernameVV& .
)VV. /
;VV/ 0
}WW 
}XX 
_logYY 
.YY 
InfoYY 
(YY 
$"YY 
$strYY +
{YY+ ,
usernameYY, 4
}YY4 5
$strYY5 J
{YYJ K
matchIdYYK R
}YYR S
$strYYS T
"YYT U
)YYU V
;YYV W
}ZZ 	
public\\ 
void\\ 
DisconnectPlayer\\ $
(\\$ %
string\\% +
username\\, 4
,\\4 5
string\\6 <
matchId\\= D
)\\D E
{]] 	
_connectedPlayers^^ 
.^^ 
	TryRemove^^ '
(^^' (
username^^( 0
,^^0 1
out^^2 5
_^^6 7
)^^7 8
;^^8 9
bool__ 
shouldEndMatch__ 
=__  !
false__" '
;__' (
bool`` 
shouldClear`` 
=`` 
false`` $
;``$ %
lockaa 
(aa 
_gameStateLockaa  
)aa  !
{bb 
ifcc 
(cc 
matchIdcc 
!=cc 
nullcc #
&&cc$ &
_matchescc' /
.cc/ 0
TryGetValuecc0 ;
(cc; <
matchIdcc< C
,ccC D
outccE H
varccI L
matchccM R
)ccR S
)ccS T
{dd 
ifff 
(ff 
matchff 
.ff 
Playersff %
.ff% &
Containsff& .
(ff. /
usernameff/ 7
)ff7 8
)ff8 9
{gg 
matchhh 
.hh 
Playershh %
.hh% &
Removehh& ,
(hh, -
usernamehh- 5
)hh5 6
;hh6 7
matchii 
.ii 
Scoresii $
.ii$ %
	RemoveAllii% .
(ii. /
sii/ 0
=>ii1 3
sii4 5
.ii5 6
Usernameii6 >
==ii? A
usernameiiB J
)iiJ K
;iiK L
ifjj 
(jj 
matchjj !
.jj! "
PlayerSelectedWordsjj" 5
.jj5 6
ContainsKeyjj6 A
(jjA B
usernamejjB J
)jjJ K
)jjK L
{kk 
matchll !
.ll! "
PlayerSelectedWordsll" 5
.ll5 6
Removell6 <
(ll< =
usernamell= E
)llE F
;llF G
}mm 
ifoo 
(oo 
matchoo !
.oo! "
Playersoo" )
.oo) *
Countoo* /
>oo0 1
$numoo2 3
)oo3 4
{pp 
BroadcastToMatchqq ,
(qq, -
matchIdqq- 4
,qq4 5
cqq6 7
=>qq8 :
cqq; <
.qq< =#
OnInGameMessageReceivedqq= T
(qqT U
$strqqU ]
,qq] ^
$"qq_ a
$strqqa n
{qqn o
usernameqqo w
}qqw x
"qqx y
)qqy z
)qqz {
;qq{ |
}rr 
iftt 
(tt 
matchtt !
.tt! "
Playerstt" )
.tt) *
Counttt* /
==tt0 2
$numtt3 4
)tt4 5
{uu 
shouldClearvv '
=vv( )
truevv* .
;vv. /
}ww 
elsexx 
ifxx 
(xx  !
matchxx! &
.xx& '
Playersxx' .
.xx. /
Countxx/ 4
<xx5 6
$numxx7 8
&&xx9 ;
matchxx< A
.xxA B
PhasexxB G
!=xxH J

MatchPhasexxK U
.xxU V
FinishedxxV ^
&&xx_ a
matchxxb g
.xxg h
Phasexxh m
!=xxn p

MatchPhasexxq {
.xx{ |

NotStarted	xx| Ü
)
xxÜ á
{yy 
shouldEndMatchzz *
=zz+ ,
truezz- 1
;zz1 2
}{{ 
else|| 
{}} 0
$CheckPhaseProgressionAfterDisconnect~~ @
(~~@ A
match~~A F
,~~F G
username~~H P
)~~P Q
;~~Q R
} 
}
ÄÄ 
}
ÅÅ 
}
ÇÇ 
if
ÑÑ 
(
ÑÑ 
shouldClear
ÑÑ 
)
ÑÑ 
{
ÖÖ 
StopMatchTimer
ÜÜ 
(
ÜÜ 
matchId
ÜÜ &
)
ÜÜ& '
;
ÜÜ' (
lock
áá 
(
áá 
_gameStateLock
áá $
)
áá$ %
{
àà 
_matches
ââ 
.
ââ 
Remove
ââ #
(
ââ# $
matchId
ââ$ +
)
ââ+ ,
;
ââ, -
}
ää 
_log
ãã 
.
ãã 
Info
ãã 
(
ãã 
$"
ãã 
$str
ãã -
{
ãã- .
matchId
ãã. 5
}
ãã5 6
$str
ãã6 S
"
ããS T
)
ããT U
;
ããU V
}
åå 
else
çç 
if
çç 
(
çç 
shouldEndMatch
çç #
)
çç# $
{
éé 
Task
èè 
.
èè 
Run
èè 
(
èè 
async
èè 
(
èè  
)
èè  !
=>
èè" $
{
êê 
BroadcastToMatch
ëë $
(
ëë$ %
matchId
ëë% ,
,
ëë, -
c
ëë. /
=>
ëë0 2
c
ëë3 4
.
ëë4 5%
OnInGameMessageReceived
ëë5 L
(
ëëL M
$str
ëëM U
,
ëëU V
$str
ëëW r
)
ëër s
)
ëës t
;
ëët u
await
íí  
NotifyGameEndAsync
íí ,
(
íí, -
matchId
íí- 4
)
íí4 5
;
íí5 6
}
ìì 
)
ìì 
;
ìì 
}
îî 
}
ïï 	
private
óó 
void
óó 2
$CheckPhaseProgressionAfterDisconnect
óó 9
(
óó9 :

MatchState
óó: D
match
óóE J
,
óóJ K
string
óóL R
leaverUsername
óóS a
)
óóa b
{
òò 	
if
ôô 
(
ôô 
match
ôô 
.
ôô 
Phase
ôô 
==
ôô 

MatchPhase
ôô )
.
ôô) *
Drawing
ôô* 1
)
ôô1 2
{
öö 
int
õõ 
validDrawings
õõ !
=
õõ" #
match
õõ$ )
.
õõ) *
Drawings
õõ* 2
.
õõ2 3
Count
õõ3 8
(
õõ8 9
d
õõ9 :
=>
õõ; =
match
õõ> C
.
õõC D
Players
õõD K
.
õõK L
Contains
õõL T
(
õõT U
d
õõU V
.
õõV W
OwnerUsername
õõW d
)
õõd e
)
õõe f
;
õõf g
if
ùù 
(
ùù 
validDrawings
ùù !
>=
ùù" $
match
ùù% *
.
ùù* +
Players
ùù+ 2
.
ùù2 3
Count
ùù3 8
&&
ùù9 ;
match
ùù< A
.
ùùA B
Players
ùùB I
.
ùùI J
Count
ùùJ O
>
ùùP Q
$num
ùùR S
)
ùùS T
{
ûû 
_log
üü 
.
üü 
Info
üü 
(
üü 
$"
üü  
$str
üü  S
{
üüS T
match
üüT Y
.
üüY Z
MatchId
üüZ a
}
üüa b
"
üüb c
)
üüc d
;
üüd e&
NotifyGuessingPhaseStart
†† ,
(
††, -
match
††- 2
.
††2 3
MatchId
††3 :
)
††: ;
;
††; <
}
°° 
}
¢¢ 
else
££ 
if
££ 
(
££ 
match
££ 
.
££ 
Phase
££  
==
££! #

MatchPhase
££$ .
.
££. /
Guessing
££/ 7
)
££7 8
{
§§ 
if
•• 
(
•• 
match
•• 
.
•• !
CurrentDrawingIndex
•• -
<
••. /
match
••0 5
.
••5 6
Drawings
••6 >
.
••> ?
Count
••? D
)
••D E
{
¶¶ 
var
ßß 
currentDrawing
ßß &
=
ßß' (
match
ßß) .
.
ßß. /
Drawings
ßß/ 7
[
ßß7 8
match
ßß8 =
.
ßß= >!
CurrentDrawingIndex
ßß> Q
]
ßßQ R
;
ßßR S
if
©© 
(
©© 
currentDrawing
©© &
.
©©& '
OwnerUsername
©©' 4
==
©©5 7
leaverUsername
©©8 F
)
©©F G
{
™™ 
_log
´´ 
.
´´ 
Info
´´ !
(
´´! "
$"
´´" $
$str
´´$ 9
{
´´9 :
match
´´: ?
.
´´? @
MatchId
´´@ G
}
´´G H
$str
´´H [
"
´´[ \
)
´´\ ]
;
´´] ^
Task
¨¨ 
.
¨¨ 
Run
¨¨  
(
¨¨  !
(
¨¨! "
)
¨¨" #
=>
¨¨$ &+
GoToNextDrawingOrAnswersPhase
¨¨' D
(
¨¨D E
match
¨¨E J
.
¨¨J K
MatchId
¨¨K R
)
¨¨R S
)
¨¨S T
;
¨¨T U
}
≠≠ 
else
ÆÆ 
{
ØØ $
CheckDrawingCompletion
∞∞ .
(
∞∞. /
match
∞∞/ 4
,
∞∞4 5
currentDrawing
∞∞6 D
.
∞∞D E
	DrawingId
∞∞E N
)
∞∞N O
;
∞∞O P
}
±± 
}
≤≤ 
}
≥≥ 
}
¥¥ 	
public
∂∂ 
void
∂∂  
ForceDisconnection
∂∂ &
(
∂∂& '
string
∂∂' -
username
∂∂. 6
,
∂∂6 7
string
∂∂8 >
matchId
∂∂? F
)
∂∂F G
{
∑∑ 	
const
∏∏ 
int
∏∏ 
StatusOffline
∏∏ #
=
∏∏$ %
$num
∏∏& '
;
∏∏' (
DisconnectPlayer
ππ 
(
ππ 
username
ππ %
,
ππ% &
matchId
ππ' .
)
ππ. /
;
ππ/ 0
UpdateUserStatus
∫∫ 
(
∫∫ 
username
∫∫ %
,
∫∫% &
StatusOffline
∫∫' 4
)
∫∫4 5
;
∫∫5 6
}
ªª 	
private
ΩΩ 
void
ΩΩ 
UpdateUserStatus
ΩΩ %
(
ΩΩ% &
string
ΩΩ& ,
username
ΩΩ- 5
,
ΩΩ5 6
int
ΩΩ7 :
statusId
ΩΩ; C
)
ΩΩC D
{
ææ 	
Task
øø 
.
øø 
Run
øø 
(
øø 
async
øø 
(
øø 
)
øø 
=>
øø  
{
¿¿ 
try
¡¡ 
{
¬¬ 
var
√√ 
player
√√ 
=
√√  
await
√√! &
_playerRepository
√√' 8
.
√√8 9&
GetPlayerByUsernameAsync
√√9 Q
(
√√Q R
username
√√R Z
)
√√Z [
;
√√[ \
if
ƒƒ 
(
ƒƒ 
player
ƒƒ 
!=
ƒƒ !
null
ƒƒ" &
)
ƒƒ& '
{
≈≈ 
player
∆∆ 
.
∆∆ %
UserStatus_idUserStatus
∆∆ 6
=
∆∆7 8
statusId
∆∆9 A
;
∆∆A B
await
«« 
_playerRepository
«« /
.
««/ 0
SaveChangesAsync
««0 @
(
««@ A
)
««A B
;
««B C
}
»» 
}
…… 
catch
   
(
   
	Exception
    
ex
  ! #
)
  # $
{
ÀÀ 
_log
ÃÃ 
.
ÃÃ 
Error
ÃÃ 
(
ÃÃ 
$"
ÃÃ !
$str
ÃÃ! ;
{
ÃÃ; <
username
ÃÃ< D
}
ÃÃD E
$str
ÃÃE I
{
ÃÃI J
statusId
ÃÃJ R
}
ÃÃR S
"
ÃÃS T
,
ÃÃT U
ex
ÃÃV X
)
ÃÃX Y
;
ÃÃY Z
}
ÕÕ 
}
ŒŒ 
)
ŒŒ 
;
ŒŒ 
}
œœ 	
public
—— 
async
—— 
Task
—— 
StartGameAsync
—— (
(
——( )
string
——) /
matchId
——0 7
,
——7 8
int
——9 <
totalRounds
——= H
,
——H I
List
——J N
<
——N O
string
——O U
>
——U V
playersFromLobby
——W g
)
——g h
{
““ 	
StopMatchTimer
”” 
(
”” 
matchId
”” "
)
””" #
;
””# $
lock
’’ 
(
’’ 
_gameStateLock
’’  
)
’’  !
{
÷÷ 
if
◊◊ 
(
◊◊ 
!
◊◊ 
_matches
◊◊ 
.
◊◊ 
ContainsKey
◊◊ )
(
◊◊) *
matchId
◊◊* 1
)
◊◊1 2
)
◊◊2 3
{
ÿÿ 
_matches
ŸŸ 
[
ŸŸ 
matchId
ŸŸ $
]
ŸŸ$ %
=
ŸŸ& '
new
ŸŸ( +

MatchState
ŸŸ, 6
{
ŸŸ7 8
MatchId
ŸŸ9 @
=
ŸŸA B
matchId
ŸŸC J
}
ŸŸK L
;
ŸŸL M
}
⁄⁄ 
var
‹‹ 
match
‹‹ 
=
‹‹ 
_matches
‹‹ $
[
‹‹$ %
matchId
‹‹% ,
]
‹‹, -
;
‹‹- .
match
›› 
.
›› 
CurrentRound
›› "
=
››# $
$num
››% &
;
››& '
match
ﬁﬁ 
.
ﬁﬁ 
TotalRounds
ﬁﬁ !
=
ﬁﬁ" #
totalRounds
ﬁﬁ$ /
;
ﬁﬁ/ 0
match
ﬂﬂ 
.
ﬂﬂ 
Phase
ﬂﬂ 
=
ﬂﬂ 

MatchPhase
ﬂﬂ (
.
ﬂﬂ( )

NotStarted
ﬂﬂ) 3
;
ﬂﬂ3 4
match
‡‡ 
.
‡‡ 
Players
‡‡ 
=
‡‡ 
match
‡‡  %
.
‡‡% &
Players
‡‡& -
.
‡‡- .
Union
‡‡. 3
(
‡‡3 4
playersFromLobby
‡‡4 D
)
‡‡D E
.
‡‡E F
Distinct
‡‡F N
(
‡‡N O
)
‡‡O P
.
‡‡P Q
ToList
‡‡Q W
(
‡‡W X
)
‡‡X Y
;
‡‡Y Z
if
‚‚ 
(
‚‚ 
match
‚‚ 
.
‚‚ 
Scores
‚‚  
.
‚‚  !
Count
‚‚! &
==
‚‚' )
$num
‚‚* +
)
‚‚+ ,
{
„„ 
match
‰‰ 
.
‰‰ 
Scores
‰‰  
=
‰‰! "
match
‰‰# (
.
‰‰( )
Players
‰‰) 0
.
‰‰0 1
Select
‰‰1 7
(
‰‰7 8
u
‰‰8 9
=>
‰‰: <
new
‰‰= @
PlayerScoreDto
‰‰A O
{
‰‰P Q
Username
‰‰R Z
=
‰‰[ \
u
‰‰] ^
,
‰‰^ _
Score
‰‰` e
=
‰‰f g
$num
‰‰h i
}
‰‰j k
)
‰‰k l
.
‰‰l m
ToList
‰‰m s
(
‰‰s t
)
‰‰t u
;
‰‰u v
}
ÂÂ 
}
ÊÊ 
await
ËË %
RegisterMatchStartAsync
ËË )
(
ËË) *
matchId
ËË* 1
,
ËË1 2
playersFromLobby
ËË3 C
)
ËËC D
;
ËËD E
await
ÈÈ  
StartNewRoundAsync
ÈÈ $
(
ÈÈ$ %
matchId
ÈÈ% ,
)
ÈÈ, -
;
ÈÈ- .
}
ÍÍ 	
private
ÏÏ 
async
ÏÏ 
Task
ÏÏ  
StartNewRoundAsync
ÏÏ -
(
ÏÏ- .
string
ÏÏ. 4
matchId
ÏÏ5 <
)
ÏÏ< =
{
ÌÌ 	
StopMatchTimer
ÓÓ 
(
ÓÓ 
matchId
ÓÓ "
)
ÓÓ" #
;
ÓÓ# $
int
ÔÔ 
roundToSend
ÔÔ 
=
ÔÔ 
$num
ÔÔ 
;
ÔÔ  
lock
ÒÒ 
(
ÒÒ 
_gameStateLock
ÒÒ  
)
ÒÒ  !
{
ÚÚ 
if
ÛÛ 
(
ÛÛ 
!
ÛÛ 
_matches
ÛÛ 
.
ÛÛ 
TryGetValue
ÛÛ )
(
ÛÛ) *
matchId
ÛÛ* 1
,
ÛÛ1 2
out
ÛÛ3 6
var
ÛÛ7 :
match
ÛÛ; @
)
ÛÛ@ A
)
ÛÛA B
{
ÙÙ 
return
ıı 
;
ıı 
}
ˆˆ 
match
¯¯ 
.
¯¯ 
Phase
¯¯ 
=
¯¯ 

MatchPhase
¯¯ (
.
¯¯( )
Drawing
¯¯) 0
;
¯¯0 1
match
˘˘ 
.
˘˘ !
CurrentDrawingIndex
˘˘ )
=
˘˘* +
$num
˘˘, -
;
˘˘- .
match
˙˙ 
.
˙˙ 
Drawings
˙˙ 
.
˙˙ 
Clear
˙˙ $
(
˙˙$ %
)
˙˙% &
;
˙˙& '
match
˚˚ 
.
˚˚ 
Guesses
˚˚ 
.
˚˚ 
Clear
˚˚ #
(
˚˚# $
)
˚˚$ %
;
˚˚% &
match
¸¸ 
.
¸¸ !
PlayerSelectedWords
¸¸ )
.
¸¸) *
Clear
¸¸* /
(
¸¸/ 0
)
¸¸0 1
;
¸¸1 2
roundToSend
˛˛ 
=
˛˛ 
match
˛˛ #
.
˛˛# $
CurrentRound
˛˛$ 0
;
˛˛0 1
}
ˇˇ 
BroadcastToMatch
ÅÅ 
(
ÅÅ 
matchId
ÅÅ $
,
ÅÅ$ %
callback
ÅÅ& .
=>
ÅÅ/ 1
callback
ÅÅ2 :
.
ÅÅ: ;
OnRoundStart
ÅÅ; G
(
ÅÅG H
roundToSend
ÅÅH S
,
ÅÅS T
new
ÅÅU X
List
ÅÅY ]
<
ÅÅ] ^
string
ÅÅ^ d
>
ÅÅd e
(
ÅÅe f
)
ÅÅf g
)
ÅÅg h
)
ÅÅh i
;
ÅÅi j
}
ÇÇ 	
public
ÑÑ 
async
ÑÑ 
Task
ÑÑ 
<
ÑÑ 
List
ÑÑ 
<
ÑÑ 
WordDto
ÑÑ &
>
ÑÑ& '
>
ÑÑ' (!
GetRandomWordsAsync
ÑÑ) <
(
ÑÑ< =
string
ÑÑ= C
username
ÑÑD L
)
ÑÑL M
{
ÖÖ 	
try
ÜÜ 
{
áá 
var
ää 
currentMatch
ää  
=
ää! "
await
ää# (
_matchRepository
ää) 9
.
ää9 :#
GetMatchByPlayerAsync
ää: O
(
ääO P
username
ääP X
)
ääX Y
;
ääY Z
if
åå 
(
åå 
currentMatch
åå  
==
åå! #
null
åå$ (
)
åå( )
{
çç 
throw
éé 
new
éé 
FaultException
éé ,
<
éé, -
ServiceFaultDto
éé- <
>
éé< =
(
éé= >
new
èè 
ServiceFaultDto
èè *
(
èè* +
ServiceErrorType
èè+ ;
.
èè; <
MatchNotFound
èè< I
,
èèI J
$str
èèK ]
)
èè] ^
,
èè^ _
new
êê 
FaultReason
êê &
(
êê& '
$str
êê' 8
)
êê8 9
)
êê9 :
;
êê: ;
}
ëë 
int
ïï 
difficultyId
ïï  
=
ïï! "
currentMatch
ïï# /
.
ïï/ 0/
!MatchDifficulty_idMatchDifficulty
ïï0 Q
??
ïïR T
$num
ïïT U
;
ïïV W
var
òò 
words
òò 
=
òò 
await
òò !
_wordRepository
òò" 1
.
òò1 2!
GetRandomWordsAsync
òò2 E
(
òòE F
$num
òòF G
,
òòG H
difficultyId
òòI U
)
òòU V
;
òòV W
if
öö 
(
öö 
words
öö 
==
öö 
null
öö !
||
öö" $
words
öö% *
.
öö* +
Count
öö+ 0
==
öö1 3
$num
öö4 5
)
öö5 6
{
õõ 
throw
úú 
new
úú 
FaultException
úú ,
<
úú, -
ServiceFaultDto
úú- <
>
úú< =
(
úú= >
new
ùù 
ServiceFaultDto
ùù *
(
ùù* +
ServiceErrorType
ùù+ ;
.
ùù; <
DatabaseError
ùù< I
,
ùùI J
$str
ùùK p
)
ùùp q
,
ùùq r
new
ûû 
FaultReason
ûû &
(
ûû& '
$str
ûû' 7
)
ûû7 8
)
ûû8 9
;
ûû9 :
}
üü 
return
¢¢ 
words
¢¢ 
.
¢¢ 
Select
¢¢ #
(
¢¢# $
w
¢¢$ %
=>
¢¢& (
new
¢¢) ,
WordDto
¢¢- 4
{
££ 
WordId
§§ 
=
§§ 
w
§§ 
.
§§ 
idWord
§§ %
,
§§% &
WordKey
•• 
=
•• 
w
•• 
.
••  
word1
••  %
}
¶¶ 
)
¶¶ 
.
¶¶ 
ToList
¶¶ 
(
¶¶ 
)
¶¶ 
;
¶¶ 
}
ßß 
catch
®® 
(
®® 
	Exception
®® 
ex
®® 
)
®®  
{
©© 
_log
™™ 
.
™™ 
Error
™™ 
(
™™ 
$str
™™ ;
,
™™; <
ex
™™= ?
)
™™? @
;
™™@ A
throw
´´ 
new
´´ 
FaultException
´´ (
<
´´( )
ServiceFaultDto
´´) 8
>
´´8 9
(
´´9 :
new
¨¨ 
ServiceFaultDto
¨¨ '
(
¨¨' (
	Contracts
¨¨( 1
.
¨¨1 2
DataContracts
¨¨2 ?
.
¨¨? @
ServiceErrorType
¨¨@ P
.
¨¨P Q
DatabaseError
¨¨Q ^
,
¨¨^ _
$str
¨¨` {
)
¨¨{ |
,
¨¨| }
new
≠≠ 
FaultReason
≠≠ #
(
≠≠# $
$str
≠≠$ 4
)
≠≠4 5
)
≠≠5 6
;
≠≠6 7
}
ÆÆ 
}
ØØ 	
public
∞∞ 
void
∞∞ "
RegisterSelectedWord
∞∞ (
(
∞∞( )
string
∞∞) /
username
∞∞0 8
,
∞∞8 9
string
∞∞: @
matchId
∞∞A H
,
∞∞H I
string
∞∞J P
selectedWord
∞∞Q ]
)
∞∞] ^
{
±± 	
lock
≤≤ 
(
≤≤ 
_gameStateLock
≤≤  
)
≤≤  !
{
≥≥ 
if
¥¥ 
(
¥¥ 
_matches
¥¥ 
.
¥¥ 
TryGetValue
¥¥ (
(
¥¥( )
matchId
¥¥) 0
,
¥¥0 1
out
¥¥2 5
var
¥¥6 9
match
¥¥: ?
)
¥¥? @
)
¥¥@ A
{
µµ 
match
∂∂ 
.
∂∂ !
PlayerSelectedWords
∂∂ -
[
∂∂- .
username
∂∂. 6
]
∂∂6 7
=
∂∂8 9
selectedWord
∂∂: F
;
∂∂F G
}
∑∑ 
}
∏∏ 
}
ππ 	
public
ªª 
void
ªª 

AddDrawing
ªª 
(
ªª 
string
ªª %
username
ªª& .
,
ªª. /
string
ªª0 6
matchId
ªª7 >
,
ªª> ?
byte
ªª@ D
[
ªªD E
]
ªªE F
drawingData
ªªG R
)
ªªR S
{
ºº 	
bool
ΩΩ !
allDrawingsReceived
ΩΩ $
=
ΩΩ% &
false
ΩΩ' ,
;
ΩΩ, -
lock
øø 
(
øø 
_gameStateLock
øø  
)
øø  !
{
¿¿ 
if
¡¡ 
(
¡¡ 
!
¡¡ 
_matches
¡¡ 
.
¡¡ 
TryGetValue
¡¡ )
(
¡¡) *
matchId
¡¡* 1
,
¡¡1 2
out
¡¡3 6
var
¡¡7 :
match
¡¡; @
)
¡¡@ A
)
¡¡A B
{
¬¬ 
return
√√ 
;
√√ 
}
ƒƒ 
if
∆∆ 
(
∆∆ 
match
∆∆ 
.
∆∆ 
Phase
∆∆ 
!=
∆∆  "

MatchPhase
∆∆# -
.
∆∆- .
Drawing
∆∆. 5
)
∆∆5 6
{
«« 
return
»» 
;
»» 
}
…… 
string
ÀÀ 

wordToSave
ÀÀ !
=
ÀÀ" #
match
ÀÀ$ )
.
ÀÀ) *!
PlayerSelectedWords
ÀÀ* =
.
ÀÀ= >
ContainsKey
ÀÀ> I
(
ÀÀI J
username
ÀÀJ R
)
ÀÀR S
?
ÀÀT U
match
ÀÀV [
.
ÀÀ[ \!
PlayerSelectedWords
ÀÀ\ o
[
ÀÀo p
username
ÀÀp x
]
ÀÀx y
:
ÀÀz {
$strÀÀ| Ö
;ÀÀÖ Ü
if
ÕÕ 
(
ÕÕ 
!
ÕÕ 
match
ÕÕ 
.
ÕÕ 
Drawings
ÕÕ #
.
ÕÕ# $
Any
ÕÕ$ '
(
ÕÕ' (
d
ÕÕ( )
=>
ÕÕ* ,
d
ÕÕ- .
.
ÕÕ. /
OwnerUsername
ÕÕ/ <
==
ÕÕ= ?
username
ÕÕ@ H
)
ÕÕH I
)
ÕÕI J
{
ŒŒ 
match
œœ 
.
œœ 
Drawings
œœ "
.
œœ" #
Add
œœ# &
(
œœ& '
new
œœ' *

DrawingDto
œœ+ 5
{
–– 
OwnerUsername
—— %
=
——& '
username
——( 0
,
——0 1
DrawingData
““ #
=
““$ %
drawingData
““& 1
,
““1 2
WordKey
”” 
=
””  !

wordToSave
””" ,
,
””, -
	IsGuessed
‘‘ !
=
‘‘" #
false
‘‘$ )
,
‘‘) *
	DrawingId
’’ !
=
’’" #
match
’’$ )
.
’’) *
Drawings
’’* 2
.
’’2 3
Count
’’3 8
+
’’9 :
$num
’’; <
}
÷÷ 
)
÷÷ 
;
÷÷ 
}
◊◊ 
int
ŸŸ 
validDrawings
ŸŸ !
=
ŸŸ" #
match
ŸŸ$ )
.
ŸŸ) *
Drawings
ŸŸ* 2
.
ŸŸ2 3
Count
ŸŸ3 8
(
ŸŸ8 9
d
ŸŸ9 :
=>
ŸŸ; =
match
ŸŸ> C
.
ŸŸC D
Players
ŸŸD K
.
ŸŸK L
Contains
ŸŸL T
(
ŸŸT U
d
ŸŸU V
.
ŸŸV W
OwnerUsername
ŸŸW d
)
ŸŸd e
)
ŸŸe f
;
ŸŸf g
if
⁄⁄ 
(
⁄⁄ 
validDrawings
⁄⁄ !
>=
⁄⁄" $
match
⁄⁄% *
.
⁄⁄* +
Players
⁄⁄+ 2
.
⁄⁄2 3
Count
⁄⁄3 8
&&
⁄⁄9 ;
match
⁄⁄< A
.
⁄⁄A B
Players
⁄⁄B I
.
⁄⁄I J
Count
⁄⁄J O
>
⁄⁄P Q
$num
⁄⁄R S
)
⁄⁄S T
{
€€ !
allDrawingsReceived
‹‹ '
=
‹‹( )
true
‹‹* .
;
‹‹. /
}
›› 
}
ﬁﬁ 
if
‡‡ 
(
‡‡ !
allDrawingsReceived
‡‡ #
)
‡‡# $
{
·· &
NotifyGuessingPhaseStart
‚‚ (
(
‚‚( )
matchId
‚‚) 0
)
‚‚0 1
;
‚‚1 2
}
„„ 
}
‰‰ 	
private
ÊÊ 
void
ÊÊ &
NotifyGuessingPhaseStart
ÊÊ -
(
ÊÊ- .
string
ÊÊ. 4
matchId
ÊÊ5 <
)
ÊÊ< =
{
ÁÁ 	

DrawingDto
ËË 
firstDrawing
ËË #
=
ËË$ %
null
ËË& *
;
ËË* +
lock
ÍÍ 
(
ÍÍ 
_gameStateLock
ÍÍ  
)
ÍÍ  !
{
ÎÎ 
if
ÏÏ 
(
ÏÏ 
!
ÏÏ 
_matches
ÏÏ 
.
ÏÏ 
TryGetValue
ÏÏ )
(
ÏÏ) *
matchId
ÏÏ* 1
,
ÏÏ1 2
out
ÏÏ3 6
var
ÏÏ7 :
match
ÏÏ; @
)
ÏÏ@ A
)
ÏÏA B
{
ÌÌ 
return
ÓÓ 
;
ÓÓ 
}
ÔÔ 
match
ÒÒ 
.
ÒÒ 
Phase
ÒÒ 
=
ÒÒ 

MatchPhase
ÒÒ (
.
ÒÒ( )
Guessing
ÒÒ) 1
;
ÒÒ1 2
match
ÚÚ 
.
ÚÚ !
CurrentDrawingIndex
ÚÚ )
=
ÚÚ* +
$num
ÚÚ, -
;
ÚÚ- .
match
ÛÛ 
.
ÛÛ 
Guesses
ÛÛ 
.
ÛÛ 
Clear
ÛÛ #
(
ÛÛ# $
)
ÛÛ$ %
;
ÛÛ% &
firstDrawing
ıı 
=
ıı 
match
ıı $
.
ıı$ %
Drawings
ıı% -
.
ıı- .
FirstOrDefault
ıı. <
(
ıı< =
d
ıı= >
=>
ıı? A
match
ııB G
.
ııG H
Players
ııH O
.
ııO P
Contains
ııP X
(
ııX Y
d
ııY Z
.
ııZ [
OwnerUsername
ıı[ h
)
ııh i
)
ııi j
;
ııj k
}
ˆˆ 
if
¯¯ 
(
¯¯ 
firstDrawing
¯¯ 
!=
¯¯ 
null
¯¯  $
)
¯¯$ %
{
˘˘ 
BroadcastToMatch
˙˙  
(
˙˙  !
matchId
˙˙! (
,
˙˙( )
c
˙˙* +
=>
˙˙, .
c
˙˙/ 0
.
˙˙0 1"
OnGuessingPhaseStart
˙˙1 E
(
˙˙E F
firstDrawing
˙˙F R
)
˙˙R S
)
˙˙S T
;
˙˙T U
}
˚˚ 
else
¸¸ 
{
˝˝ 
Task
˛˛ 
.
˛˛ 
Run
˛˛ 
(
˛˛ 
(
˛˛ 
)
˛˛ 
=>
˛˛ +
GoToNextDrawingOrAnswersPhase
˛˛ <
(
˛˛< =
matchId
˛˛= D
)
˛˛D E
)
˛˛E F
;
˛˛F G
}
ˇˇ 
}
ÄÄ 	
public
ÇÇ 
void
ÇÇ 
ProcessGuess
ÇÇ  
(
ÇÇ  !
string
ÇÇ! '
username
ÇÇ( 0
,
ÇÇ0 1
string
ÇÇ2 8
matchId
ÇÇ9 @
,
ÇÇ@ A
int
ÇÇB E
	drawingId
ÇÇF O
,
ÇÇO P
string
ÇÇQ W
	guessText
ÇÇX a
)
ÇÇa b
{
ÉÉ 	
lock
ÑÑ 
(
ÑÑ 
_gameStateLock
ÑÑ  
)
ÑÑ  !
{
ÖÖ 
if
ÜÜ 
(
ÜÜ 
!
ÜÜ 
_matches
ÜÜ 
.
ÜÜ 
TryGetValue
ÜÜ )
(
ÜÜ) *
matchId
ÜÜ* 1
,
ÜÜ1 2
out
ÜÜ3 6
var
ÜÜ7 :
match
ÜÜ; @
)
ÜÜ@ A
)
ÜÜA B
{
áá 
return
àà 
;
àà 
}
ââ 
if
ãã 
(
ãã 
match
ãã 
.
ãã 
Phase
ãã 
!=
ãã  "

MatchPhase
ãã# -
.
ãã- .
Guessing
ãã. 6
)
ãã6 7
{
åå 
return
çç 
;
çç 
}
éé 
var
êê 
drawing
êê 
=
êê 
match
êê #
.
êê# $
Drawings
êê$ ,
.
êê, -
FirstOrDefault
êê- ;
(
êê; <
d
êê< =
=>
êê> @
d
êêA B
.
êêB C
	DrawingId
êêC L
==
êêM O
	drawingId
êêP Y
)
êêY Z
;
êêZ [
if
ëë 
(
ëë 
drawing
ëë 
==
ëë 
null
ëë #
)
ëë# $
{
íí 
return
ìì 
;
ìì 
}
îî 
bool
ññ 
	isCorrect
ññ 
=
ññ  
string
ññ! '
.
ññ' (
Equals
ññ( .
(
ññ. /
	guessText
ññ/ 8
,
ññ8 9
drawing
ññ: A
.
ññA B
WordKey
ññB I
,
ññI J
StringComparison
ññK [
.
ññ[ \
OrdinalIgnoreCase
ññ\ m
)
ññm n
;
ññn o
bool
óó %
alreadyGuessedCorrectly
óó ,
=
óó- .
match
óó/ 4
.
óó4 5
Guesses
óó5 <
.
óó< =
Any
óó= @
(
óó@ A
g
óóA B
=>
óóC E
g
óóF G
.
óóG H
GuesserUsername
óóH W
==
óóX Z
username
óó[ c
&&
óód f
g
óóg h
.
óóh i
	DrawingId
óói r
==
óós u
	drawingId
óóv 
&&óóÄ Ç
góóÉ Ñ
.óóÑ Ö
	IsCorrectóóÖ é
)óóé è
;óóè ê
if
ôô 
(
ôô 
!
ôô %
alreadyGuessedCorrectly
ôô ,
)
ôô, -
{
öö 
match
õõ 
.
õõ 
Guesses
õõ !
.
õõ! "
Add
õõ" %
(
õõ% &
new
õõ& )
GuessDto
õõ* 2
{
úú 
GuesserUsername
ùù '
=
ùù( )
username
ùù* 2
,
ùù2 3
	DrawingId
ûû !
=
ûû" #
	drawingId
ûû$ -
,
ûû- .
	GuessText
üü !
=
üü" #
	guessText
üü$ -
,
üü- .
	IsCorrect
†† !
=
††" #
	isCorrect
††$ -
,
††- .
WordKey
°° 
=
°°  !
drawing
°°" )
.
°°) *
WordKey
°°* 1
}
¢¢ 
)
¢¢ 
;
¢¢ 
if
§§ 
(
§§ 
	isCorrect
§§ !
)
§§! "
{
•• 
ApplyScores
¶¶ #
(
¶¶# $
match
¶¶$ )
,
¶¶) *
username
¶¶+ 3
,
¶¶3 4
drawing
¶¶5 <
.
¶¶< =
OwnerUsername
¶¶= J
)
¶¶J K
;
¶¶K L
}
ßß 
}
®® $
CheckDrawingCompletion
™™ &
(
™™& '
match
™™' ,
,
™™, -
	drawingId
™™. 7
)
™™7 8
;
™™8 9
}
´´ 
}
¨¨ 	
private
ÆÆ 
void
ÆÆ 
ApplyScores
ÆÆ  
(
ÆÆ  !

MatchState
ÆÆ! +
match
ÆÆ, 1
,
ÆÆ1 2
string
ÆÆ3 9
guesser
ÆÆ: A
,
ÆÆA B
string
ÆÆC I
artist
ÆÆJ P
)
ÆÆP Q
{
ØØ 	
var
∞∞ 
guesserScore
∞∞ 
=
∞∞ 
match
∞∞ $
.
∞∞$ %
Scores
∞∞% +
.
∞∞+ ,
FirstOrDefault
∞∞, :
(
∞∞: ;
p
∞∞; <
=>
∞∞= ?
p
∞∞@ A
.
∞∞A B
Username
∞∞B J
==
∞∞K M
guesser
∞∞N U
)
∞∞U V
;
∞∞V W
if
±± 
(
±± 
guesserScore
±± 
!=
±± 
null
±±  $
)
±±$ %
{
≤≤ 
guesserScore
≥≥ 
.
≥≥ 
Score
≥≥ "
+=
≥≥# %
CorrectGuessScore
≥≥& 7
;
≥≥7 8
}
¥¥ 
var
∂∂ 
artistScore
∂∂ 
=
∂∂ 
match
∂∂ #
.
∂∂# $
Scores
∂∂$ *
.
∂∂* +
FirstOrDefault
∂∂+ 9
(
∂∂9 :
p
∂∂: ;
=>
∂∂< >
p
∂∂? @
.
∂∂@ A
Username
∂∂A I
==
∂∂J L
artist
∂∂M S
)
∂∂S T
;
∂∂T U
if
∑∑ 
(
∑∑ 
artistScore
∑∑ 
!=
∑∑ 
null
∑∑ #
)
∑∑# $
{
∏∏ 
artistScore
ππ 
.
ππ 
Score
ππ !
+=
ππ" $*
DrawingGuessedCorrectlyScore
ππ% A
;
ππA B
}
∫∫ 
}
ªª 	
private
ΩΩ 
void
ΩΩ $
CheckDrawingCompletion
ΩΩ +
(
ΩΩ+ ,

MatchState
ΩΩ, 6
match
ΩΩ7 <
,
ΩΩ< =
int
ΩΩ> A
currentDrawingId
ΩΩB R
)
ΩΩR S
{
ææ 	
if
øø 
(
øø 
match
øø 
.
øø !
CurrentDrawingIndex
øø )
>=
øø* ,
match
øø- 2
.
øø2 3
Drawings
øø3 ;
.
øø; <
Count
øø< A
)
øøA B
{
¿¿ 
return
¡¡ 
;
¡¡ 
}
¬¬ 
if
ƒƒ 
(
ƒƒ 
match
ƒƒ 
.
ƒƒ 
Drawings
ƒƒ 
[
ƒƒ 
match
ƒƒ $
.
ƒƒ$ %!
CurrentDrawingIndex
ƒƒ% 8
]
ƒƒ8 9
.
ƒƒ9 :
	DrawingId
ƒƒ: C
!=
ƒƒD F
currentDrawingId
ƒƒG W
)
ƒƒW X
{
≈≈ 
return
∆∆ 
;
∆∆ 
}
«« 
int
…… 
totalPlayers
…… 
=
…… 
match
…… $
.
……$ %
Players
……% ,
.
……, -
Count
……- 2
;
……2 3
int
   #
guessesForThisDrawing
   %
=
  & '
match
  ( -
.
  - .
Guesses
  . 5
.
  5 6
Count
  6 ;
(
  ; <
g
  < =
=>
  > @
g
  A B
.
  B C
	DrawingId
  C L
==
  M O
currentDrawingId
  P `
&&
  a c
match
  d i
.
  i j
Players
  j q
.
  q r
Contains
  r z
(
  z {
g
  { |
.
  | }
GuesserUsername  } å
)  å ç
)  ç é
;  é è
if
ÃÃ 
(
ÃÃ #
guessesForThisDrawing
ÃÃ %
>=
ÃÃ& (
(
ÃÃ) *
totalPlayers
ÃÃ* 6
-
ÃÃ7 8
$num
ÃÃ9 :
)
ÃÃ: ;
)
ÃÃ; <
{
ÕÕ 
Task
ŒŒ 
.
ŒŒ 
Run
ŒŒ 
(
ŒŒ 
(
ŒŒ 
)
ŒŒ 
=>
ŒŒ +
GoToNextDrawingOrAnswersPhase
ŒŒ <
(
ŒŒ< =
match
ŒŒ= B
.
ŒŒB C
MatchId
ŒŒC J
)
ŒŒJ K
)
ŒŒK L
;
ŒŒL M
}
œœ 
}
–– 	
private
““ 
void
““ +
GoToNextDrawingOrAnswersPhase
““ 2
(
““2 3
string
““3 9
matchId
““: A
)
““A B
{
”” 	

DrawingDto
‘‘ 
nextDrawing
‘‘ "
=
‘‘# $
null
‘‘% )
;
‘‘) *
bool
’’  
shouldStartAnswers
’’ #
=
’’$ %
false
’’& +
;
’’+ ,
lock
◊◊ 
(
◊◊ 
_gameStateLock
◊◊  
)
◊◊  !
{
ÿÿ 
if
ŸŸ 
(
ŸŸ 
!
ŸŸ 
_matches
ŸŸ 
.
ŸŸ 
TryGetValue
ŸŸ )
(
ŸŸ) *
matchId
ŸŸ* 1
,
ŸŸ1 2
out
ŸŸ3 6
var
ŸŸ7 :
match
ŸŸ; @
)
ŸŸ@ A
)
ŸŸA B
{
⁄⁄ 
return
€€ 
;
€€ 
}
‹‹ 
if
ﬁﬁ 
(
ﬁﬁ 
match
ﬁﬁ 
.
ﬁﬁ 
Phase
ﬁﬁ 
!=
ﬁﬁ  "

MatchPhase
ﬁﬁ# -
.
ﬁﬁ- .
Guessing
ﬁﬁ. 6
)
ﬁﬁ6 7
{
ﬂﬂ 
return
‡‡ 
;
‡‡ 
}
·· 
match
„„ 
.
„„ !
CurrentDrawingIndex
„„ )
++
„„) +
;
„„+ ,
while
ÂÂ 
(
ÂÂ 
match
ÂÂ 
.
ÂÂ !
CurrentDrawingIndex
ÂÂ 0
<
ÂÂ1 2
match
ÂÂ3 8
.
ÂÂ8 9
Drawings
ÂÂ9 A
.
ÂÂA B
Count
ÂÂB G
)
ÂÂG H
{
ÊÊ 
var
ÁÁ 
	candidate
ÁÁ !
=
ÁÁ" #
match
ÁÁ$ )
.
ÁÁ) *
Drawings
ÁÁ* 2
[
ÁÁ2 3
match
ÁÁ3 8
.
ÁÁ8 9!
CurrentDrawingIndex
ÁÁ9 L
]
ÁÁL M
;
ÁÁM N
if
ËË 
(
ËË 
match
ËË 
.
ËË 
Players
ËË %
.
ËË% &
Contains
ËË& .
(
ËË. /
	candidate
ËË/ 8
.
ËË8 9
OwnerUsername
ËË9 F
)
ËËF G
)
ËËG H
{
ÈÈ 
nextDrawing
ÍÍ #
=
ÍÍ$ %
	candidate
ÍÍ& /
;
ÍÍ/ 0
break
ÎÎ 
;
ÎÎ 
}
ÏÏ 
match
ÌÌ 
.
ÌÌ !
CurrentDrawingIndex
ÌÌ -
++
ÌÌ- /
;
ÌÌ/ 0
}
ÓÓ 
if
 
(
 
nextDrawing
 
==
  "
null
# '
)
' (
{
ÒÒ  
shouldStartAnswers
ÚÚ &
=
ÚÚ' (
true
ÚÚ) -
;
ÚÚ- .
}
ÛÛ 
}
ÙÙ 
if
ˆˆ 
(
ˆˆ 
nextDrawing
ˆˆ 
!=
ˆˆ 
null
ˆˆ #
)
ˆˆ# $
{
˜˜ 
BroadcastToMatch
¯¯  
(
¯¯  !
matchId
¯¯! (
,
¯¯( )
c
¯¯* +
=>
¯¯, .
c
¯¯/ 0
.
¯¯0 1
OnShowNextDrawing
¯¯1 B
(
¯¯B C
nextDrawing
¯¯C N
)
¯¯N O
)
¯¯O P
;
¯¯P Q
}
˘˘ 
else
˙˙ 
if
˙˙ 
(
˙˙  
shouldStartAnswers
˙˙ '
)
˙˙' (
{
˚˚ 
StartAnswersPhase
¸¸ !
(
¸¸! "
matchId
¸¸" )
)
¸¸) *
;
¸¸* +
}
˝˝ 
}
˛˛ 	
private
ÄÄ 
void
ÄÄ 
StartAnswersPhase
ÄÄ &
(
ÄÄ& '
string
ÄÄ' -
matchId
ÄÄ. 5
)
ÄÄ5 6
{
ÅÅ 	
const
ÇÇ 
int
ÇÇ 
FiveSeconds
ÇÇ !
=
ÇÇ" #
$num
ÇÇ$ %
;
ÇÇ% &
const
ÉÉ 
int
ÉÉ 
FifteenSeconds
ÉÉ $
=
ÉÉ% &
$num
ÉÉ' )
;
ÉÉ) *

MatchState
ÑÑ 
snapshot
ÑÑ 
;
ÑÑ  
lock
ÖÖ 
(
ÖÖ 
_gameStateLock
ÖÖ  
)
ÖÖ  !
{
ÜÜ 
if
áá 
(
áá 
!
áá 
_matches
áá 
.
áá 
TryGetValue
áá )
(
áá) *
matchId
áá* 1
,
áá1 2
out
áá3 6
var
áá7 :
match
áá; @
)
áá@ A
)
ááA B
{
àà 
return
ââ 
;
ââ 
}
ää 
match
ãã 
.
ãã 
Phase
ãã 
=
ãã 

MatchPhase
ãã (
.
ãã( )
Answers
ãã) 0
;
ãã0 1
var
çç 
activeDrawings
çç "
=
çç# $
match
çç% *
.
çç* +
Drawings
çç+ 3
.
éé 
Where
éé 
(
éé 
d
éé 
=>
éé 
match
éé  %
.
éé% &
Players
éé& -
.
éé- .
Contains
éé. 6
(
éé6 7
d
éé7 8
.
éé8 9
OwnerUsername
éé9 F
)
ééF G
)
ééG H
.
èè 
ToList
èè 
(
èè 
)
èè 
;
èè 
var
ëë 
activeGuesses
ëë !
=
ëë" #
match
ëë$ )
.
ëë) *
Guesses
ëë* 1
.
íí 
Where
íí 
(
íí 
g
íí 
=>
íí 
match
íí  %
.
íí% &
Players
íí& -
.
íí- .
Contains
íí. 6
(
íí6 7
g
íí7 8
.
íí8 9
GuesserUsername
íí9 H
)
ííH I
&&
ííJ L
activeDrawings
ìì  .
.
ìì. /
Any
ìì/ 2
(
ìì2 3
d
ìì3 4
=>
ìì5 7
d
ìì8 9
.
ìì9 :
	DrawingId
ìì: C
==
ììD F
g
ììG H
.
ììH I
	DrawingId
ììI R
)
ììR S
)
ììS T
.
îî 
ToList
îî 
(
îî 
)
îî 
;
îî 
snapshot
ññ 
=
ññ 
new
ññ 

MatchState
ññ )
{
óó 
Drawings
òò 
=
òò 
activeDrawings
òò -
,
òò- .
Guesses
ôô 
=
ôô 
activeGuesses
ôô +
,
ôô+ ,
Scores
öö 
=
öö 
new
öö  
List
öö! %
<
öö% &
PlayerScoreDto
öö& 4
>
öö4 5
(
öö5 6
match
öö6 ;
.
öö; <
Scores
öö< B
)
ööB C
,
ööC D
CurrentRound
õõ  
=
õõ! "
match
õõ# (
.
õõ( )
CurrentRound
õõ) 5
}
úú 
;
úú 
}
ùù 
BroadcastToMatch
üü 
(
üü 
matchId
üü $
,
üü$ %
c
üü& '
=>
üü( *
c
üü+ ,
.
üü, -!
OnAnswersPhaseStart
üü- @
(
üü@ A
snapshot
†† 
.
†† 
Drawings
†† !
.
††! "
ToArray
††" )
(
††) *
)
††* +
,
††+ ,
snapshot
°° 
.
°° 
Guesses
°°  
.
°°  !
ToArray
°°! (
(
°°( )
)
°°) *
,
°°* +
snapshot
¢¢ 
.
¢¢ 
Scores
¢¢ 
.
¢¢  
ToArray
¢¢  '
(
¢¢' (
)
¢¢( )
)
¢¢) *
)
¢¢* +
;
¢¢+ ,
int
§§ 

totalItems
§§ 
=
§§ 
snapshot
§§ %
.
§§% &
Drawings
§§& .
.
§§. /
Count
§§/ 4
+
§§5 6
snapshot
§§7 ?
.
§§? @
Guesses
§§@ G
.
§§G H
Count
§§H M
;
§§M N
int
•• 
delaySeconds
•• 
=
•• 
(
••  

totalItems
••  *
*
••+ ,
FiveSeconds
••- 8
)
••8 9
+
••: ;
FifteenSeconds
••< J
;
••J K

StartTimer
ßß 
(
ßß 
matchId
ßß 
,
ßß 
TimerCallback
ßß  -
,
ßß- .
new
ßß/ 2
Tuple
ßß3 8
<
ßß8 9
string
ßß9 ?
,
ßß? @
int
ßßA D
>
ßßD E
(
ßßE F
matchId
ßßF M
,
ßßM N
snapshot
ßßO W
.
ßßW X
CurrentRound
ßßX d
)
ßßd e
,
ßße f
delaySeconds
ßßg s
)
ßßs t
;
ßßt u
}
®® 	
private
™™ 
void
™™ 
TimerCallback
™™ "
(
™™" #
object
™™# )
state
™™* /
)
™™/ 0
{
´´ 	
var
¨¨ 
tuple
¨¨ 
=
¨¨ 
(
¨¨ 
Tuple
¨¨ 
<
¨¨ 
string
¨¨ %
,
¨¨% &
int
¨¨' *
>
¨¨* +
)
¨¨+ ,
state
¨¨, 1
;
¨¨1 2
Task
≠≠ 
.
≠≠ 
Run
≠≠ 
(
≠≠ 
(
≠≠ 
)
≠≠ 
=>
≠≠ #
CheckEndOfRoundOrGame
≠≠ 0
(
≠≠0 1
tuple
≠≠1 6
.
≠≠6 7
Item1
≠≠7 <
,
≠≠< =
tuple
≠≠> C
.
≠≠C D
Item2
≠≠D I
)
≠≠I J
)
≠≠J K
;
≠≠K L
}
ÆÆ 	
private
∞∞ 
async
∞∞ 
Task
∞∞ #
CheckEndOfRoundOrGame
∞∞ 0
(
∞∞0 1
string
∞∞1 7
matchId
∞∞8 ?
,
∞∞? @
int
∞∞A D
expectedRound
∞∞E R
)
∞∞R S
{
±± 	
bool
≤≤ 
startNextRound
≤≤ 
=
≤≤  !
false
≤≤" '
;
≤≤' (
lock
¥¥ 
(
¥¥ 
_gameStateLock
¥¥  
)
¥¥  !
{
µµ 
if
∂∂ 
(
∂∂ 
!
∂∂ 
_matches
∂∂ 
.
∂∂ 
TryGetValue
∂∂ )
(
∂∂) *
matchId
∂∂* 1
,
∂∂1 2
out
∂∂3 6
var
∂∂7 :
match
∂∂; @
)
∂∂@ A
)
∂∂A B
{
∑∑ 
return
∏∏ 
;
∏∏ 
}
ππ 
if
∫∫ 
(
∫∫ 
match
∫∫ 
.
∫∫ 
CurrentRound
∫∫ &
!=
∫∫' )
expectedRound
∫∫* 7
)
∫∫7 8
{
ªª 
return
ºº 
;
ºº 
}
ΩΩ 
if
øø 
(
øø 
match
øø 
.
øø 
CurrentRound
øø &
<
øø' (
match
øø) .
.
øø. /
TotalRounds
øø/ :
)
øø: ;
{
¿¿ 
match
¡¡ 
.
¡¡ 
CurrentRound
¡¡ &
++
¡¡& (
;
¡¡( )
startNextRound
¬¬ "
=
¬¬# $
true
¬¬% )
;
¬¬) *
}
√√ 
}
ƒƒ 
if
∆∆ 
(
∆∆ 
startNextRound
∆∆ 
)
∆∆ 
{
«« 
await
»»  
StartNewRoundAsync
»» (
(
»»( )
matchId
»») 0
)
»»0 1
;
»»1 2
}
…… 
else
   
{
ÀÀ 
await
ÃÃ  
NotifyGameEndAsync
ÃÃ (
(
ÃÃ( )
matchId
ÃÃ) 0
)
ÃÃ0 1
;
ÃÃ1 2
}
ÕÕ 
}
ŒŒ 	
private
–– 
async
–– 
Task
––  
NotifyGameEndAsync
–– -
(
––- .
string
––. 4
matchId
––5 <
)
––< =
{
—— 	
StopMatchTimer
““ 
(
““ 
matchId
““ "
)
““" #
;
““# $
List
”” 
<
”” 
PlayerScoreDto
”” 
>
””  
finalScores
””! ,
=
””- .
null
””/ 3
;
””3 4
lock
’’ 
(
’’ 
_gameStateLock
’’  
)
’’  !
{
÷÷ 
if
◊◊ 
(
◊◊ 
_matches
◊◊ 
.
◊◊ 
TryGetValue
◊◊ (
(
◊◊( )
matchId
◊◊) 0
,
◊◊0 1
out
◊◊2 5
var
◊◊6 9
match
◊◊: ?
)
◊◊? @
)
◊◊@ A
{
ÿÿ 
match
ŸŸ 
.
ŸŸ 
Phase
ŸŸ 
=
ŸŸ  !

MatchPhase
ŸŸ" ,
.
ŸŸ, -
Finished
ŸŸ- 5
;
ŸŸ5 6
finalScores
⁄⁄ 
=
⁄⁄  !
match
⁄⁄" '
.
⁄⁄' (
Scores
⁄⁄( .
.
⁄⁄. /
OrderByDescending
⁄⁄/ @
(
⁄⁄@ A
s
⁄⁄A B
=>
⁄⁄C E
s
⁄⁄F G
.
⁄⁄G H
Score
⁄⁄H M
)
⁄⁄M N
.
⁄⁄N O
ToList
⁄⁄O U
(
⁄⁄U V
)
⁄⁄V W
;
⁄⁄W X
}
€€ 
}
‹‹ 
if
ﬁﬁ 
(
ﬁﬁ 
finalScores
ﬁﬁ 
!=
ﬁﬁ 
null
ﬁﬁ #
)
ﬁﬁ# $
{
ﬂﬂ 
await
‡‡ #
RegisterMatchEndAsync
‡‡ +
(
‡‡+ ,
matchId
‡‡, 3
,
‡‡3 4
finalScores
‡‡5 @
)
‡‡@ A
;
‡‡A B
BroadcastToMatch
··  
(
··  !
matchId
··! (
,
··( )
c
··* +
=>
··, .
c
··/ 0
.
··0 1
	OnGameEnd
··1 :
(
··: ;
finalScores
··; F
)
··F G
)
··G H
;
··H I
}
‚‚ 
}
„„ 	
public
ÂÂ 
void
ÂÂ "
BroadcastChatMessage
ÂÂ (
(
ÂÂ( )
string
ÂÂ) /
sender
ÂÂ0 6
,
ÂÂ6 7
string
ÂÂ8 >
matchId
ÂÂ? F
,
ÂÂF G
string
ÂÂH N
msg
ÂÂO R
)
ÂÂR S
{
ÊÊ 	
List
ÁÁ 
<
ÁÁ 
string
ÁÁ 
>
ÁÁ 
players
ÁÁ  
=
ÁÁ! "
null
ÁÁ# '
;
ÁÁ' (
bool
ËË 
kick
ËË 
=
ËË 
false
ËË 
;
ËË 
int
ÈÈ 
warningsCount
ÈÈ 
=
ÈÈ 
$num
ÈÈ  !
;
ÈÈ! "
string
ÍÍ 
cleanMessage
ÍÍ 
=
ÍÍ  !
msg
ÍÍ" %
;
ÍÍ% &
lock
ÏÏ 
(
ÏÏ 
_gameStateLock
ÏÏ  
)
ÏÏ  !
{
ÌÌ 
if
ÓÓ 
(
ÓÓ 
_matches
ÓÓ 
.
ÓÓ 
TryGetValue
ÓÓ (
(
ÓÓ( )
matchId
ÓÓ) 0
,
ÓÓ0 1
out
ÓÓ2 5
var
ÓÓ6 9
match
ÓÓ: ?
)
ÓÓ? @
)
ÓÓ@ A
{
ÔÔ 
players
 
=
 
new
 !
List
" &
<
& '
string
' -
>
- .
(
. /
match
/ 4
.
4 5
Players
5 <
)
< =
;
= >
cleanMessage
ÛÛ  
=
ÛÛ! "
BadWordValidator
ÛÛ# 3
.
ÛÛ3 4

BanMessage
ÛÛ4 >
(
ÛÛ> ?
msg
ÛÛ? B
)
ÛÛB C
;
ÛÛC D
if
ˆˆ 
(
ˆˆ 
cleanMessage
ˆˆ $
!=
ˆˆ% '
msg
ˆˆ( +
)
ˆˆ+ ,
{
˜˜ 
if
˘˘ 
(
˘˘ 
!
˘˘ 
match
˘˘ "
.
˘˘" #
PlayerWarnings
˘˘# 1
.
˘˘1 2
ContainsKey
˘˘2 =
(
˘˘= >
sender
˘˘> D
)
˘˘D E
)
˘˘E F
{
˙˙ 
match
˚˚ !
.
˚˚! "
PlayerWarnings
˚˚" 0
[
˚˚0 1
sender
˚˚1 7
]
˚˚7 8
=
˚˚9 :
$num
˚˚; <
;
˚˚< =
}
¸¸ 
match
ˇˇ 
.
ˇˇ 
PlayerWarnings
ˇˇ ,
[
ˇˇ, -
sender
ˇˇ- 3
]
ˇˇ3 4
++
ˇˇ4 6
;
ˇˇ6 7
warningsCount
ÄÄ %
=
ÄÄ& '
match
ÄÄ( -
.
ÄÄ- .
PlayerWarnings
ÄÄ. <
[
ÄÄ< =
sender
ÄÄ= C
]
ÄÄC D
;
ÄÄD E
if
ÉÉ 
(
ÉÉ 
warningsCount
ÉÉ )
>=
ÉÉ* ,
$num
ÉÉ- .
)
ÉÉ. /
{
ÑÑ 
kick
ÖÖ  
=
ÖÖ! "
true
ÖÖ# '
;
ÖÖ' (
}
ÜÜ 
}
áá 
}
àà 
}
ââ 
if
åå 
(
åå 
kick
åå 
)
åå 
{
çç  
ForceDisconnection
èè "
(
èè" #
sender
èè# )
,
èè) *
matchId
èè+ 2
)
èè2 3
;
èè3 4
BroadcastToMatch
ëë  
(
ëë  !
matchId
ëë! (
,
ëë( )
c
ëë* +
=>
ëë, .
c
ëë/ 0
.
ëë0 1%
OnInGameMessageReceived
ëë1 H
(
ëëH I
$str
ëëI Q
,
ëëQ R
$"
ëëS U
$str
ëëU `
{
ëë` a
sender
ëëa g
}
ëëg h
$strëëh î
"ëëî ï
)ëëï ñ
)ëëñ ó
;ëëó ò
return
íí 
;
íí 
}
ìì 
if
ïï 
(
ïï 
players
ïï 
!=
ïï 
null
ïï 
)
ïï  
{
ññ 
if
òò 
(
òò 
cleanMessage
òò  
!=
òò! #
msg
òò$ '
)
òò' (
{
ôô 
NotifyPlayer
úú  
(
úú  !
sender
úú! '
,
úú' (
c
úú) *
=>
úú+ -
c
úú. /
.
úú/ 0%
OnInGameMessageReceived
úú0 G
(
úúG H
$str
úúH P
,
úúP Q
$"
úúR T
$str
úúT \
{
úú\ ]
warningsCount
úú] j
}
úúj k
"
úúk l
)
úúl m
)
úúm n
;
úún o
}
ùù 
foreach
†† 
(
†† 
var
†† 
u
†† 
in
†† !
players
††" )
)
††) *
{
°° 
NotifyPlayer
¢¢  
(
¢¢  !
u
¢¢! "
,
¢¢" #
c
¢¢$ %
=>
¢¢& (
c
¢¢) *
.
¢¢* +%
OnInGameMessageReceived
¢¢+ B
(
¢¢B C
sender
¢¢C I
,
¢¢I J
cleanMessage
¢¢K W
)
¢¢W X
)
¢¢X Y
;
¢¢Y Z
}
££ 
}
§§ 
}
•• 	
private
¶¶ 
async
¶¶ 
Task
¶¶ %
RegisterMatchStartAsync
¶¶ 2
(
¶¶2 3
string
¶¶3 9

matchIdStr
¶¶: D
,
¶¶D E
List
¶¶F J
<
¶¶J K
string
¶¶K Q
>
¶¶Q R
playerUsernames
¶¶S b
)
¶¶b c
{
ßß 	
if
®® 
(
®® 
!
®® 
int
®® 
.
®® 
TryParse
®® 
(
®® 

matchIdStr
®® (
,
®®( )
out
®®* -
int
®®. 1
matchId
®®2 9
)
®®9 :
)
®®: ;
{
©© 
return
™™ 
;
™™ 
}
´´ 
try
≠≠ 
{
ÆÆ 
var
ØØ 
match
ØØ 
=
ØØ 
await
ØØ !
_matchRepository
ØØ" 2
.
ØØ2 3
GetMatchByIdAsync
ØØ3 D
(
ØØD E
matchId
ØØE L
)
ØØL M
;
ØØM N
if
∞∞ 
(
∞∞ 
match
∞∞ 
!=
∞∞ 
null
∞∞ !
)
∞∞! "
{
±± 
match
≤≤ 
.
≤≤ 
matchStatus
≤≤ %
=
≤≤& '
$str
≤≤( 1
;
≤≤1 2
foreach
¥¥ 
(
¥¥ 
var
¥¥  
username
¥¥! )
in
¥¥* ,
playerUsernames
¥¥- <
)
¥¥< =
{
µµ 
var
∂∂ 
player
∂∂ "
=
∂∂# $
await
∂∂% *
_playerRepository
∂∂+ <
.
∂∂< =&
GetPlayerByUsernameAsync
∂∂= U
(
∂∂U V
username
∂∂V ^
)
∂∂^ _
;
∂∂_ `
if
∑∑ 
(
∑∑ 
player
∑∑ "
!=
∑∑# %
null
∑∑& *
)
∑∑* +
{
∏∏ 
bool
ππ  
exists
ππ! '
=
ππ( )
await
ππ* /
_matchRepository
ππ0 @
.
ππ@ A*
PlayerHasHistoryInMatchAsync
ππA ]
(
ππ] ^
matchId
ππ^ e
,
ππe f
player
ππg m
.
ππm n
idPlayer
ππn v
)
ππv w
;
ππw x
if
∫∫ 
(
∫∫  
!
∫∫  !
exists
∫∫! '
)
∫∫' (
{
ªª 
_matchRepository
ºº  0
.
ºº0 1
AddMatchHistory
ºº1 @
(
ºº@ A
new
ººA D
MatchHistory
ººE Q
{
ΩΩ  !
Match_idMatch
ææ$ 1
=
ææ2 3
matchId
ææ4 ;
,
ææ; <
Player_idPlayer
øø$ 3
=
øø4 5
player
øø6 <
.
øø< =
idPlayer
øø= E
,
øøE F

finalScore
¿¿$ .
=
¿¿/ 0
$num
¿¿1 2
,
¿¿2 3
ranking
¡¡$ +
=
¡¡, -
$num
¡¡. /
}
¬¬  !
)
¬¬! "
;
¬¬" #
}
√√ 
}
ƒƒ 
}
≈≈ 
await
∆∆ 
_matchRepository
∆∆ *
.
∆∆* +
SaveChangesAsync
∆∆+ ;
(
∆∆; <
)
∆∆< =
;
∆∆= >
}
«« 
}
»» 
catch
…… 
(
…… 
	Exception
…… 
ex
…… 
)
……  
{
   
_log
ÀÀ 
.
ÀÀ 
Error
ÀÀ 
(
ÀÀ 
$"
ÀÀ 
$str
ÀÀ >
{
ÀÀ> ?
matchId
ÀÀ? F
}
ÀÀF G
"
ÀÀG H
,
ÀÀH I
ex
ÀÀJ L
)
ÀÀL M
;
ÀÀM N
}
ÃÃ 
}
ÕÕ 	
private
œœ 
async
œœ 
Task
œœ #
RegisterMatchEndAsync
œœ 0
(
œœ0 1
string
œœ1 7

matchIdStr
œœ8 B
,
œœB C
List
œœD H
<
œœH I
PlayerScoreDto
œœI W
>
œœW X
finalScores
œœY d
)
œœd e
{
–– 	
if
—— 
(
—— 
!
—— 
int
—— 
.
—— 
TryParse
—— 
(
—— 

matchIdStr
—— (
,
——( )
out
——* -
int
——. 1
matchId
——2 9
)
——9 :
)
——: ;
{
““ 
return
”” 
;
”” 
}
‘‘ 
try
÷÷ 
{
◊◊ 
var
ÿÿ 
match
ÿÿ 
=
ÿÿ 
await
ÿÿ !
_matchRepository
ÿÿ" 2
.
ÿÿ2 3
GetMatchByIdAsync
ÿÿ3 D
(
ÿÿD E
matchId
ÿÿE L
)
ÿÿL M
;
ÿÿM N
if
ŸŸ 
(
ŸŸ 
match
ŸŸ 
!=
ŸŸ 
null
ŸŸ !
)
ŸŸ! "
{
⁄⁄ 
match
€€ 
.
€€ 
matchStatus
€€ %
=
€€& '
$str
€€( 2
;
€€2 3
var
›› 
	histories
›› !
=
››" #
await
››$ )
_matchRepository
››* :
.
››: ;+
GetMatchHistoryByMatchIdAsync
››; X
(
››X Y
matchId
››Y `
)
››` a
;
››a b
for
ﬂﬂ 
(
ﬂﬂ 
int
ﬂﬂ 
i
ﬂﬂ 
=
ﬂﬂ  
$num
ﬂﬂ! "
;
ﬂﬂ" #
i
ﬂﬂ$ %
<
ﬂﬂ& '
finalScores
ﬂﬂ( 3
.
ﬂﬂ3 4
Count
ﬂﬂ4 9
;
ﬂﬂ9 :
i
ﬂﬂ; <
++
ﬂﬂ< >
)
ﬂﬂ> ?
{
‡‡ 
var
·· 
score
·· !
=
··" #
finalScores
··$ /
[
··/ 0
i
··0 1
]
··1 2
;
··2 3
var
‚‚ 
player
‚‚ "
=
‚‚# $
await
‚‚% *
_playerRepository
‚‚+ <
.
‚‚< =&
GetPlayerByUsernameAsync
‚‚= U
(
‚‚U V
score
‚‚V [
.
‚‚[ \
Username
‚‚\ d
)
‚‚d e
;
‚‚e f
if
„„ 
(
„„ 
player
„„ "
!=
„„# %
null
„„& *
)
„„* +
{
‰‰ 
var
ÂÂ 
entry
ÂÂ  %
=
ÂÂ& '
	histories
ÂÂ( 1
.
ÂÂ1 2
FirstOrDefault
ÂÂ2 @
(
ÂÂ@ A
h
ÂÂA B
=>
ÂÂC E
h
ÂÂF G
.
ÂÂG H
Player_idPlayer
ÂÂH W
==
ÂÂX Z
player
ÂÂ[ a
.
ÂÂa b
idPlayer
ÂÂb j
)
ÂÂj k
;
ÂÂk l
if
ÊÊ 
(
ÊÊ  
entry
ÊÊ  %
!=
ÊÊ& (
null
ÊÊ) -
)
ÊÊ- .
{
ÁÁ 
entry
ËË  %
.
ËË% &

finalScore
ËË& 0
=
ËË1 2
score
ËË3 8
.
ËË8 9
Score
ËË9 >
;
ËË> ?
entry
ÈÈ  %
.
ÈÈ% &
ranking
ÈÈ& -
=
ÈÈ. /
i
ÈÈ0 1
+
ÈÈ2 3
$num
ÈÈ4 5
;
ÈÈ5 6
}
ÍÍ 
}
ÎÎ 
}
ÏÏ 
await
ÌÌ 
_matchRepository
ÌÌ *
.
ÌÌ* +
SaveChangesAsync
ÌÌ+ ;
(
ÌÌ; <
)
ÌÌ< =
;
ÌÌ= >
}
ÓÓ 
}
ÔÔ 
catch
 
(
 
	Exception
 
ex
 
)
  
{
ÒÒ 
_log
ÚÚ 
.
ÚÚ 
Error
ÚÚ 
(
ÚÚ 
$"
ÚÚ 
$str
ÚÚ <
{
ÚÚ< =
matchId
ÚÚ= D
}
ÚÚD E
"
ÚÚE F
,
ÚÚF G
ex
ÚÚH J
)
ÚÚJ K
;
ÚÚK L
}
ÛÛ 
}
ÙÙ 	
private
ˆˆ 
void
ˆˆ 
StopMatchTimer
ˆˆ #
(
ˆˆ# $
string
ˆˆ$ *
matchId
ˆˆ+ 2
)
ˆˆ2 3
{
˜˜ 	
lock
¯¯ 
(
¯¯ 
_gameStateLock
¯¯  
)
¯¯  !
{
˘˘ 
if
˙˙ 
(
˙˙ 
_matches
˙˙ 
.
˙˙ 
TryGetValue
˙˙ (
(
˙˙( )
matchId
˙˙) 0
,
˙˙0 1
out
˙˙2 5
var
˙˙6 9
match
˙˙: ?
)
˙˙? @
)
˙˙@ A
{
˚˚ 
try
¸¸ 
{
˝˝ 
match
˛˛ 
.
˛˛ 
DisposeTimer
˛˛ *
(
˛˛* +
)
˛˛+ ,
;
˛˛, -
}
ˇˇ 
catch
ÄÄ 
(
ÄÄ 
	Exception
ÄÄ $
ex
ÄÄ% '
)
ÄÄ' (
{
ÅÅ 
_log
ÇÇ 
.
ÇÇ 
Warn
ÇÇ !
(
ÇÇ! "
$"
ÇÇ" $
$str
ÇÇ$ D
{
ÇÇD E
matchId
ÇÇE L
}
ÇÇL M
"
ÇÇM N
,
ÇÇN O
ex
ÇÇP R
)
ÇÇR S
;
ÇÇS T
}
ÉÉ 
}
ÑÑ 
}
ÖÖ 
}
ÜÜ 	
private
àà 
void
àà 

StartTimer
àà 
(
àà  
string
àà  &
matchId
àà' .
,
àà. /
TimerCallback
àà0 =
callback
àà> F
,
ààF G
object
ààH N
state
ààO T
,
ààT U
int
ààV Y
delaySeconds
ààZ f
)
ààf g
{
ââ 	
const
ää 
int
ää 
OneThousand
ää !
=
ää" #
$num
ää$ (
;
ää( )
lock
ãã 
(
ãã 
_gameStateLock
ãã  
)
ãã  !
{
åå 
if
çç 
(
çç 
_matches
çç 
.
çç 
TryGetValue
çç (
(
çç( )
matchId
çç) 0
,
çç0 1
out
çç2 5
var
çç6 9
match
çç: ?
)
çç? @
)
çç@ A
{
éé 
match
èè 
.
èè 
DisposeTimer
èè &
(
èè& '
)
èè' (
;
èè( )
match
êê 
.
êê 
	GameTimer
êê #
=
êê$ %
new
êê& )
Timer
êê* /
(
êê/ 0
callback
êê0 8
,
êê8 9
state
êê: ?
,
êê? @
delaySeconds
êêA M
*
êêN O
OneThousand
êêP [
,
êê[ \
Timeout
êê] d
.
êêd e
Infinite
êêe m
)
êêm n
;
êên o
}
ëë 
}
íí 
}
ìì 	
private
ïï 
void
ïï 
BroadcastToMatch
ïï %
(
ïï% &
string
ïï& ,
matchId
ïï- 4
,
ïï4 5
Action
ïï6 <
<
ïï< ="
IGameServiceCallback
ïï= Q
>
ïïQ R
action
ïïS Y
)
ïïY Z
{
ññ 	
List
óó 
<
óó 
string
óó 
>
óó 
players
óó  
=
óó! "
null
óó# '
;
óó' (
lock
òò 
(
òò 
_gameStateLock
òò  
)
òò  !
{
ôô 
if
öö 
(
öö 
_matches
öö 
.
öö 
TryGetValue
öö (
(
öö( )
matchId
öö) 0
,
öö0 1
out
öö2 5
var
öö6 9
match
öö: ?
)
öö? @
)
öö@ A
{
õõ 
players
úú 
=
úú 
new
úú !
List
úú" &
<
úú& '
string
úú' -
>
úú- .
(
úú. /
match
úú/ 4
.
úú4 5
Players
úú5 <
)
úú< =
;
úú= >
}
ùù 
}
ûû 
if
†† 
(
†† 
players
†† 
!=
†† 
null
†† 
)
††  
{
°° 
foreach
¢¢ 
(
¢¢ 
var
¢¢ 
user
¢¢ !
in
¢¢" $
players
¢¢% ,
)
¢¢, -
NotifyPlayer
¢¢. :
(
¢¢: ;
user
¢¢; ?
,
¢¢? @
action
¢¢A G
)
¢¢G H
;
¢¢H I
}
££ 
}
§§ 	
private
¶¶ 
void
¶¶ 
NotifyPlayer
¶¶ !
(
¶¶! "
string
¶¶" (
username
¶¶) 1
,
¶¶1 2
Action
¶¶3 9
<
¶¶9 :"
IGameServiceCallback
¶¶: N
>
¶¶N O
action
¶¶P V
)
¶¶V W
{
ßß 	
if
®® 
(
®® 
_connectedPlayers
®® !
.
®®! "
TryGetValue
®®" -
(
®®- .
username
®®. 6
,
®®6 7
out
®®8 ;
var
®®< ?
cb
®®@ B
)
®®B C
)
®®C D
{
©© 
try
™™ 
{
´´ 
action
¨¨ 
(
¨¨ 
cb
¨¨ 
)
¨¨ 
;
¨¨ 
}
≠≠ 
catch
ÆÆ 
(
ÆÆ $
CommunicationException
ÆÆ -
)
ÆÆ- .
{
ØØ 
}
∞∞ 
catch
±± 
(
±± 
	Exception
±±  
ex
±±! #
)
±±# $
{
≤≤ 
_log
≥≥ 
.
≥≥ 
Warn
≥≥ 
(
≥≥ 
$"
≥≥  
$str
≥≥  7
{
≥≥7 8
username
≥≥8 @
}
≥≥@ A
"
≥≥A B
,
≥≥B C
ex
≥≥D F
)
≥≥F G
;
≥≥G H
}
¥¥ 
}
µµ 
}
∂∂ 	
}
∑∑ 
}∏∏ ∂!
îC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\BusinessLogic\GuestInvite.cs
	namespace 	
GuessMyMessServer
 
. 
BusinessLogic )
{ 
public 

class 
GuestInvite 
{ 
public		 
string		 
Email		 
{		 
get		 !
;		! "
set		# &
;		& '
}		( )
public

 
string

 
Code

 
{

 
get

  
;

  !
set

" %
;

% &
}

' (
public 
string 
MatchId 
{ 
get  #
;# $
set% (
;( )
}* +
public 
DateTime 

Expiration "
{# $
get% (
;( )
set* -
;- .
}/ 0
} 
public 

static 
class 
GuestInviteManager *
{ 
private 
static 
readonly  
ConcurrentDictionary  4
<4 5
string5 ;
,; <
GuestInvite= H
>H I
_invitesJ R
=S T
newU X 
ConcurrentDictionaryY m
<m n
stringn t
,t u
GuestInvite	v Å
>
Å Ç
(
Ç É
)
É Ñ
;
Ñ Ö
public 
static 
string 
CreateInvite )
() *
string* 0
email1 6
,6 7
string8 >
matchId? F
)F G
{ 	
var 
code 
= 
new 
Random !
(! "
)" #
.# $
Next$ (
(( )
$num) /
,/ 0
$num1 7
)7 8
.8 9
ToString9 A
(A B
)B C
;C D
var 
invite 
= 
new 
GuestInvite (
{ 
Email 
= 
email 
, 
Code 
= 
code 
, 
MatchId 
= 
matchId !
,! "

Expiration 
= 
DateTime %
.% &
UtcNow& ,
., -

AddMinutes- 7
(7 8
$num8 :
): ;
} 
; 
_invites 
. 
AddOrUpdate  
(  !
email! &
,& '
invite( .
,. /
(0 1
k1 2
,2 3
v4 5
)5 6
=>7 9
invite: @
)@ A
;A B
return 
code 
; 
}   	
public"" 
static"" 
bool"" 
ValidateInvite"" )
("") *
string""* 0
email""1 6
,""6 7
string""8 >
code""? C
,""C D
out""E H
string""I O
matchId""P W
)""W X
{## 	
matchId$$ 
=$$ 
null$$ 
;$$ 
if%% 
(%% 
_invites%% 
.%% 
TryGetValue%% $
(%%$ %
email%%% *
,%%* +
out%%, /
var%%0 3
invite%%4 :
)%%: ;
)%%; <
{&& 
if'' 
('' 
invite'' 
.'' 
Code'' 
==''  "
code''# '
&&''( *
invite''+ 1
.''1 2

Expiration''2 <
>''= >
DateTime''? G
.''G H
UtcNow''H N
)''N O
{(( 
matchId)) 
=)) 
invite)) $
.))$ %
MatchId))% ,
;)), -
_invites** 
.** 
	TryRemove** &
(**& '
email**' ,
,**, -
out**. 1
_**2 3
)**3 4
;**4 5
return++ 
true++ 
;++  
},, 
}-- 
return.. 
false.. 
;.. 
}// 	
}00 
}11 Ÿﬂ
úC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\BusinessLogic\AuthenticationLogic.cs
	namespace 	
GuessMyMessServer
 
. 
BusinessLogic )
{ 
public 

class 
AuthenticationLogic $
{ 
private 
static 
readonly 
ILog  $
_log% )
=* +

LogManager, 6
.6 7
	GetLogger7 @
(@ A
typeofA G
(G H
AuthenticationLogicH [
)[ \
)\ ]
;] ^
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
;= >
private 
readonly 
IPlayerRepository *
_playerRepository+ <
;< =
private 
readonly 
IMatchRepository )
_matchRepository* :
;: ;
private 
readonly 
IEmailService &
_emailService' 4
;4 5
public 
AuthenticationLogic "
(" #
IPlayerRepository 
playerRepository .
,. /
IMatchRepository 
matchRepository ,
,, -
IEmailService 
emailService &
)& '
{ 	
_playerRepository 
= 
playerRepository  0
;0 1
_matchRepository 
= 
matchRepository .
;. /
_emailService 
= 
emailService (
;( )
} 	
public!! 
async!! 
Task!! 
<!! 
OperationResultDto!! ,
>!!, -

LoginAsync!!. 8
(!!8 9
string!!9 ?
emailOrUsername!!@ O
,!!O P
string!!Q W
password!!X `
)!!` a
{"" 	
if## 
(## 
string## 
.## 
IsNullOrWhiteSpace## )
(##) *
emailOrUsername##* 9
)##9 :
||##; =
string##> D
.##D E
IsNullOrWhiteSpace##E W
(##W X
password##X `
)##` a
)##a b
{$$ 
ThrowServiceFault%% !
(%%! "
ServiceErrorType%%" 2
.%%2 3
InvalidCredentials%%3 E
,%%E F
$str%%G r
)%%r s
;%%s t
}&& 
Player(( 
player(( 
;(( 
if)) 
()) 
InputValidator)) 
.)) 
IsValidEmail)) +
())+ ,
emailOrUsername)), ;
))); <
)))< =
{** 
player++ 
=++ 
await++ 
_playerRepository++ 0
.++0 1!
GetPlayerByEmailAsync++1 F
(++F G
emailOrUsername++G V
)++V W
;++W X
},, 
else-- 
{.. 
player// 
=// 
await// 
_playerRepository// 0
.//0 1$
GetPlayerByUsernameAsync//1 I
(//I J
emailOrUsername//J Y
)//Y Z
;//Z [
}00 
if22 
(22 
player22 
==22 
null22 
)22 
{33 
_log44 
.44 
Info44 
(44 
$"44 
$str44 8
{448 9
emailOrUsername449 H
}44H I
$str44I U
"44U V
)44V W
;44W X
ThrowServiceFault55 !
(55! "
ServiceErrorType55" 2
.552 3
InvalidCredentials553 E
,55E F
$str55G _
)55_ `
;55` a
}66 
if88 
(88 
player88 
.88 
is_verified88 "
==88# %
$num88& '
)88' (
{99 
_log:: 
.:: 
Info:: 
(:: 
$":: 
$str:: 0
{::0 1
player::1 7
.::7 8
username::8 @
}::@ A
$str::A [
"::[ \
)::\ ]
;::] ^
ThrowServiceFault;; !
(;;! "
ServiceErrorType;;" 2
.;;2 3
AccountNotVerified;;3 E
,;;E F
$str;;G k
);;k l
;;;l m
}<< 
if>> 
(>> 
!>> 
PasswordHasher>> 
.>>  
VerifyPassword>>  .
(>>. /
password>>/ 7
,>>7 8
player>>9 ?
.>>? @
password>>@ H
)>>H I
)>>I J
{?? 
_log@@ 
.@@ 
Info@@ 
(@@ 
$"@@ 
$str@@ R
{@@R S
player@@S Y
.@@Y Z
username@@Z b
}@@b c
$str@@c e
"@@e f
)@@f g
;@@g h
ThrowServiceFaultAA !
(AA! "
ServiceErrorTypeAA" 2
.AA2 3
InvalidCredentialsAA3 E
,AAE F
$strAAG _
)AA_ `
;AA` a
}BB 
constDD 
intDD 
StatusOnlineDD "
=DD# $
$numDD% &
;DD& '
constEE 
intEE 
StatusInGameEE "
=EE# $
$numEE% &
;EE& '
ifGG 
(GG 
playerGG 
.GG #
UserStatus_idUserStatusGG .
==GG/ 1
StatusOnlineGG2 >
||GG? A
playerGGB H
.GGH I#
UserStatus_idUserStatusGGI `
==GGa c
StatusInGameGGd p
)GGp q
{HH 
_logII 
.II 
WarnII 
(II 
$"II 
$strII 0
{II0 1
playerII1 7
.II7 8
usernameII8 @
}II@ A
$strIIA X
"IIX Y
)IIY Z
;IIZ [
returnJJ 
newJJ 
OperationResultDtoJJ -
{JJ. /
SuccessJJ0 7
=JJ8 9
falseJJ: ?
,JJ? @
MessageJJA H
=JJI J
$strJJK `
}JJa b
;JJb c
}KK 
playerLL 
.LL #
UserStatus_idUserStatusLL *
=LL+ ,
StatusOnlineLL- 9
;LL9 :
tryNN 
{OO 
awaitPP 
_playerRepositoryPP '
.PP' (
SaveChangesAsyncPP( 8
(PP8 9
)PP9 :
;PP: ;
_logQQ 
.QQ 
InfoQQ 
(QQ 
$"QQ 
$strQQ "
{QQ" #
playerQQ# )
.QQ) *
usernameQQ* 2
}QQ2 3
$strQQ3 L
"QQL M
)QQM N
;QQN O
returnRR 
newRR 
OperationResultDtoRR -
{RR. /
SuccessRR0 7
=RR8 9
trueRR: >
,RR> ?
MessageRR@ G
=RRH I
playerRRJ P
.RRP Q
usernameRRQ Y
}RRZ [
;RR[ \
}SS 
catchTT 
(TT 
	ExceptionTT 
exTT 
)TT  
{UU 
_logVV 
.VV 
ErrorVV 
(VV 
$"VV 
$strVV F
{VVF G
playerVVG M
.VVM N
usernameVVN V
}VVV W
$strVVW X
"VVX Y
,VVY Z
exVV[ ]
)VV] ^
;VV^ _
ThrowServiceFaultWW !
(WW! "
ServiceErrorTypeWW" 2
.WW2 3
DatabaseErrorWW3 @
,WW@ A
$strWWB g
)WWg h
;WWh i
returnXX 
nullXX 
;XX 
}YY 
}ZZ 	
public\\ 
async\\ 
Task\\ 
<\\ 
OperationResultDto\\ ,
>\\, -
RegisterPlayerAsync\\. A
(\\A B
UserProfileDto\\B P
userProfile\\Q \
,\\\ ]
string\\^ d
password\\e m
)\\m n
{]] 	%
ValidateRegistrationInput^^ %
(^^% &
userProfile^^& 1
,^^1 2
password^^3 ;
)^^; <
;^^< =
await__ #
CheckUserExistenceAsync__ )
(__) *
userProfile__* 5
)__5 6
;__6 7
stringaa 
verificationCodeaa #
=aa$ %
_randomaa& -
.aa- .
Nextaa. 2
(aa2 3
$numaa3 9
,aa9 :
$numaa; A
)aaA B
.aaB C
ToStringaaC K
(aaK L
$straaL P
)aaP Q
;aaQ R
awaitcc &
SendVerificationEmailAsynccc ,
(cc, -
userProfilecc- 8
,cc8 9
verificationCodecc: J
)ccJ K
;ccK L
returnee 
awaitee $
CreateAndSavePlayerAsyncee 1
(ee1 2
userProfileee2 =
,ee= >
passwordee? G
,eeG H
verificationCodeeeI Y
)eeY Z
;eeZ [
}ff 	
publichh 
asynchh 
Taskhh 
<hh 
OperationResultDtohh ,
>hh, -
VerifyAccountAsynchh. @
(hh@ A
stringhhA G
emailhhH M
,hhM N
stringhhO U
codehhV Z
)hhZ [
{ii 	
ifjj 
(jj 
stringjj 
.jj 
IsNullOrWhiteSpacejj )
(jj) *
emailjj* /
)jj/ 0
||jj1 3
stringjj4 :
.jj: ;
IsNullOrWhiteSpacejj; M
(jjM N
codejjN R
)jjR S
)jjS T
{kk 
ThrowServiceFaultll !
(ll! "
ServiceErrorTypell" 2
.ll2 3
OperationFailedll3 B
,llB C
$strllD b
)llb c
;llc d
}mm 
varoo 
playeroo 
=oo 
awaitoo 
_playerRepositoryoo 0
.oo0 1!
GetPlayerByEmailAsyncoo1 F
(ooF G
emailooG L
)ooL M
;ooM N
ifqq 
(qq 
playerqq 
==qq 
nullqq 
)qq 
{rr 
ThrowServiceFaultss !
(ss! "
ServiceErrorTypess" 2
.ss2 3
NotFoundss3 ;
,ss; <
$strss= c
)ssc d
;ssd e
}tt 
ifvv 
(vv 
playervv 
.vv 
is_verifiedvv "
==vv# %
$numvv& '
)vv' (
{ww 
ThrowServiceFaultxx !
(xx! "
ServiceErrorTypexx" 2
.xx2 3
OperationFailedxx3 B
,xxB C
$strxxD g
)xxg h
;xxh i
}yy 
if{{ 
({{ 
player{{ 
.{{ 
verification_code{{ (
!={{) +
code{{, 0
||{{1 3
player{{4 :
.{{: ;
code_expiry_date{{; K
<{{L M
DateTime{{N V
.{{V W
UtcNow{{W ]
){{] ^
{|| 
ThrowServiceFault}} !
(}}! "
ServiceErrorType}}" 2
.}}2 3
InvalidCredentials}}3 E
,}}E F
$str}}G n
)}}n o
;}}o p
}~~ 
player
ÄÄ 
.
ÄÄ 
is_verified
ÄÄ 
=
ÄÄ  
$num
ÄÄ! "
;
ÄÄ" #
player
ÅÅ 
.
ÅÅ 
verification_code
ÅÅ $
=
ÅÅ% &
null
ÅÅ' +
;
ÅÅ+ ,
player
ÇÇ 
.
ÇÇ 
code_expiry_date
ÇÇ #
=
ÇÇ$ %
null
ÇÇ& *
;
ÇÇ* +
player
ÉÉ 
.
ÉÉ %
UserStatus_idUserStatus
ÉÉ *
=
ÉÉ+ ,
$num
ÉÉ- .
;
ÉÉ. /
try
ÖÖ 
{
ÜÜ 
await
áá 
_playerRepository
áá '
.
áá' (
SaveChangesAsync
áá( 8
(
áá8 9
)
áá9 :
;
áá: ;
_log
àà 
.
àà 
Info
àà 
(
àà 
$"
àà 
$str
àà <
{
àà< =
player
àà= C
.
ààC D
username
ààD L
}
ààL M
$str
ààM O
"
ààO P
)
ààP Q
;
ààQ R
return
ââ 
new
ââ  
OperationResultDto
ââ -
{
ââ. /
Success
ââ0 7
=
ââ8 9
true
ââ: >
,
ââ> ?
Message
ââ@ G
=
ââH I
$str
ââJ s
}
âât u
;
ââu v
}
ää 
catch
ãã 
(
ãã 
	Exception
ãã 
ex
ãã 
)
ãã  
{
åå 
_log
çç 
.
çç 
Error
çç 
(
çç 
$"
çç 
$str
çç ?
{
çç? @
player
çç@ F
.
ççF G
username
ççG O
}
ççO P
$str
ççP Q
"
ççQ R
,
ççR S
ex
ççT V
)
ççV W
;
ççW X
ThrowServiceFault
éé !
(
éé! "
ServiceErrorType
éé" 2
.
éé2 3
DatabaseError
éé3 @
,
éé@ A
$str
ééB g
)
éég h
;
ééh i
return
èè 
null
èè 
;
èè 
}
êê 
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
ìì, -
LoginAsGuestAsync
ìì. ?
(
ìì? @
string
ìì@ F
email
ììG L
,
ììL M
string
ììN T
code
ììU Y
)
ììY Z
{
îî 	
if
ïï 
(
ïï  
GuestInviteManager
ïï "
.
ïï" #
ValidateInvite
ïï# 1
(
ïï1 2
email
ïï2 7
,
ïï7 8
code
ïï9 =
,
ïï= >
out
ïï? B
string
ïïC I

matchIdStr
ïïJ T
)
ïïT U
)
ïïU V
{
ññ 
string
óó 
uniqueSessionId
óó &
=
óó' (
$"
óó) +
$str
óó+ 1
{
óó1 2
Guid
óó2 6
.
óó6 7
NewGuid
óó7 >
(
óó> ?
)
óó? @
.
óó@ A
ToString
óóA I
(
óóI J
)
óóJ K
.
óóK L
	Substring
óóL U
(
óóU V
$num
óóV W
,
óóW X
$num
óóY Z
)
óóZ [
}
óó[ \
"
óó\ ]
;
óó] ^
bool
òò 
	isPrivate
òò 
=
òò  
false
òò! &
;
òò& '
if
öö 
(
öö 
int
öö 
.
öö 
TryParse
öö  
(
öö  !

matchIdStr
öö! +
,
öö+ ,
out
öö- 0
int
öö1 4
matchId
öö5 <
)
öö< =
)
öö= >
{
õõ 
	isPrivate
úú 
=
úú 
await
úú  %
_matchRepository
úú& 6
.
úú6 7!
IsMatchPrivateAsync
úú7 J
(
úúJ K
matchId
úúK R
)
úúR S
;
úúS T
}
ùù 
return
üü 
new
üü  
OperationResultDto
üü -
{
†† 
Success
°° 
=
°° 
true
°° "
,
°°" #
Message
¢¢ 
=
¢¢ 
uniqueSessionId
¢¢ -
,
¢¢- .
Data
££ 
=
££ 
new
££ 

Dictionary
££ )
<
££) *
string
££* 0
,
££0 1
string
££2 8
>
££8 9
{
§§ 
{
•• 
$str
•• #
,
••# $

matchIdStr
••% /
}
••0 1
,
••1 2
{
¶¶ 
$str
¶¶ #
,
¶¶# $
$str
¶¶% +
}
¶¶, -
,
¶¶- .
{
ßß 
$str
ßß %
,
ßß% &
	isPrivate
ßß' 0
.
ßß0 1
ToString
ßß1 9
(
ßß9 :
)
ßß: ;
}
ßß< =
}
®® 
}
©© 
;
©© 
}
™™ 
else
´´ 
{
¨¨ 
ThrowServiceFault
≠≠ !
(
≠≠! "
ServiceErrorType
≠≠" 2
.
≠≠2 3 
InvalidCredentials
≠≠3 E
,
≠≠E F
$str
≠≠G j
)
≠≠j k
;
≠≠k l
return
ÆÆ 
null
ÆÆ 
;
ÆÆ 
}
ØØ 
}
∞∞ 	
public
≤≤ 
async
≤≤ 
Task
≤≤ 
LogOutAsync
≤≤ %
(
≤≤% &
string
≤≤& ,
username
≤≤- 5
)
≤≤5 6
{
≥≥ 	
const
¥¥ 
int
¥¥ 
StatusOffline
¥¥ #
=
¥¥$ %
$num
¥¥& '
;
¥¥' (
try
µµ 
{
∂∂ 
var
∑∑ 
player
∑∑ 
=
∑∑ 
await
∑∑ "
_playerRepository
∑∑# 4
.
∑∑4 5&
GetPlayerByUsernameAsync
∑∑5 M
(
∑∑M N
username
∑∑N V
)
∑∑V W
;
∑∑W X
if
∏∏ 
(
∏∏ 
player
∏∏ 
!=
∏∏ 
null
∏∏ "
)
∏∏" #
{
ππ 
player
∫∫ 
.
∫∫ %
UserStatus_idUserStatus
∫∫ 2
=
∫∫3 4
StatusOffline
∫∫5 B
;
∫∫B C
await
ªª 
_playerRepository
ªª +
.
ªª+ ,
SaveChangesAsync
ªª, <
(
ªª< =
)
ªª= >
;
ªª> ?
_log
ºº 
.
ºº 
Info
ºº 
(
ºº 
$"
ºº  
$str
ºº  &
{
ºº& '
username
ºº' /
}
ºº/ 0
$str
ºº0 =
"
ºº= >
)
ºº> ?
;
ºº? @
}
ΩΩ 
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
¿¿ 
_log
¡¡ 
.
¡¡ 
Warn
¡¡ 
(
¡¡ 
$"
¡¡ 
$str
¡¡ >
{
¡¡> ?
username
¡¡? G
}
¡¡G H
$str
¡¡H I
"
¡¡I J
,
¡¡J K
ex
¡¡L N
)
¡¡N O
;
¡¡O P
}
¬¬ 
}
√√ 	
private
≈≈ 
void
≈≈ '
ValidateRegistrationInput
≈≈ .
(
≈≈. /
UserProfileDto
≈≈/ =
userProfile
≈≈> I
,
≈≈I J
string
≈≈K Q
password
≈≈R Z
)
≈≈Z [
{
∆∆ 	
if
«« 
(
«« 
userProfile
«« 
==
«« 
null
«« #
||
««$ &
string
««' -
.
««- . 
IsNullOrWhiteSpace
««. @
(
««@ A
password
««A I
)
««I J
)
««J K
{
»» 
ThrowServiceFault
…… !
(
……! "
ServiceErrorType
……" 2
.
……2 3
OperationFailed
……3 B
,
……B C
$str
……D m
)
……m n
;
……n o
}
   
if
ÃÃ 
(
ÃÃ 
string
ÃÃ 
.
ÃÃ  
IsNullOrWhiteSpace
ÃÃ )
(
ÃÃ) *
userProfile
ÃÃ* 5
.
ÃÃ5 6
Username
ÃÃ6 >
)
ÃÃ> ?
||
ÃÃ@ B
string
ÕÕ 
.
ÕÕ  
IsNullOrWhiteSpace
ÕÕ )
(
ÕÕ) *
userProfile
ÕÕ* 5
.
ÕÕ5 6
Email
ÕÕ6 ;
)
ÕÕ; <
||
ÕÕ= ?
string
ŒŒ 
.
ŒŒ  
IsNullOrWhiteSpace
ŒŒ )
(
ŒŒ) *
userProfile
ŒŒ* 5
.
ŒŒ5 6
	FirstName
ŒŒ6 ?
)
ŒŒ? @
||
ŒŒA C
string
œœ 
.
œœ  
IsNullOrWhiteSpace
œœ )
(
œœ) *
userProfile
œœ* 5
.
œœ5 6
LastName
œœ6 >
)
œœ> ?
)
œœ? @
{
–– 
ThrowServiceFault
—— !
(
——! "
ServiceErrorType
——" 2
.
——2 3
OperationFailed
——3 B
,
——B C
$str
——D ^
)
——^ _
;
——_ `
}
““ 
if
‘‘ 
(
‘‘ 
!
‘‘ 
InputValidator
‘‘ 
.
‘‘  
IsValidEmail
‘‘  ,
(
‘‘, -
userProfile
‘‘- 8
.
‘‘8 9
Email
‘‘9 >
)
‘‘> ?
)
‘‘? @
{
’’ 
ThrowServiceFault
÷÷ !
(
÷÷! "
ServiceErrorType
÷÷" 2
.
÷÷2 3
OperationFailed
÷÷3 B
,
÷÷B C
$str
÷÷D [
)
÷÷[ \
;
÷÷\ ]
}
◊◊ 
if
ŸŸ 
(
ŸŸ 
!
ŸŸ 
InputValidator
ŸŸ 
.
ŸŸ  
IsPasswordSecure
ŸŸ  0
(
ŸŸ0 1
password
ŸŸ1 9
)
ŸŸ9 :
)
ŸŸ: ;
{
⁄⁄ 
ThrowServiceFault
€€ !
(
€€! "
ServiceErrorType
€€" 2
.
€€2 3
OperationFailed
€€3 B
,
€€B C
$str
€€D s
)
€€s t
;
€€t u
}
‹‹ 
}
›› 	
private
ﬂﬂ 
async
ﬂﬂ 
Task
ﬂﬂ %
CheckUserExistenceAsync
ﬂﬂ 2
(
ﬂﬂ2 3
UserProfileDto
ﬂﬂ3 A
userProfile
ﬂﬂB M
)
ﬂﬂM N
{
‡‡ 	
var
·· 
existingUser
·· 
=
·· 
await
·· $
_playerRepository
··% 6
.
··6 7&
GetPlayerByUsernameAsync
··7 O
(
··O P
userProfile
··P [
.
··[ \
Username
··\ d
)
··d e
;
··e f
if
‚‚ 
(
‚‚ 
existingUser
‚‚ 
!=
‚‚ 
null
‚‚  $
)
‚‚$ %
{
„„ 
ThrowServiceFault
‰‰ !
(
‰‰! "
ServiceErrorType
‰‰" 2
.
‰‰2 3
UserAlreadyExists
‰‰3 D
,
‰‰D E
$str
‰‰F g
)
‰‰g h
;
‰‰h i
}
ÂÂ 
var
ÁÁ 
existingEmail
ÁÁ 
=
ÁÁ 
await
ÁÁ  %
_playerRepository
ÁÁ& 7
.
ÁÁ7 8#
GetPlayerByEmailAsync
ÁÁ8 M
(
ÁÁM N
userProfile
ÁÁN Y
.
ÁÁY Z
Email
ÁÁZ _
)
ÁÁ_ `
;
ÁÁ` a
if
ËË 
(
ËË 
existingEmail
ËË 
!=
ËË  
null
ËË! %
)
ËË% &
{
ÈÈ 
ThrowServiceFault
ÍÍ !
(
ÍÍ! "
ServiceErrorType
ÍÍ" 2
.
ÍÍ2 3$
EmailAlreadyRegistered
ÍÍ3 I
,
ÍÍI J
$str
ÍÍK m
)
ÍÍm n
;
ÍÍn o
}
ÎÎ 
}
ÏÏ 	
private
ÓÓ 
async
ÓÓ 
Task
ÓÓ (
SendVerificationEmailAsync
ÓÓ 5
(
ÓÓ5 6
UserProfileDto
ÓÓ6 D
userProfile
ÓÓE P
,
ÓÓP Q
string
ÓÓR X
code
ÓÓY ]
)
ÓÓ] ^
{
ÔÔ 	
try
 
{
ÒÒ 
var
ÚÚ 
emailTemplate
ÚÚ !
=
ÚÚ" #
new
ÚÚ$ ''
VerificationEmailTemplate
ÚÚ( A
(
ÚÚA B
userProfile
ÚÚB M
.
ÚÚM N
Username
ÚÚN V
,
ÚÚV W
code
ÚÚX \
)
ÚÚ\ ]
;
ÚÚ] ^
await
ÛÛ 
_emailService
ÛÛ #
.
ÛÛ# $
SendEmailAsync
ÛÛ$ 2
(
ÛÛ2 3
userProfile
ÛÛ3 >
.
ÛÛ> ?
Email
ÛÛ? D
,
ÛÛD E
userProfile
ÛÛF Q
.
ÛÛQ R
Username
ÛÛR Z
,
ÛÛZ [
emailTemplate
ÛÛ\ i
)
ÛÛi j
;
ÛÛj k
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
ˆˆ 
_log
˜˜ 
.
˜˜ 
Error
˜˜ 
(
˜˜ 
$"
˜˜ 
$str
˜˜ 5
{
˜˜5 6
userProfile
˜˜6 A
.
˜˜A B
Email
˜˜B G
}
˜˜G H
$str
˜˜H I
"
˜˜I J
,
˜˜J K
ex
˜˜L N
)
˜˜N O
;
˜˜O P
ThrowServiceFault
¯¯ !
(
¯¯! "
ServiceErrorType
¯¯" 2
.
¯¯2 3
OperationFailed
¯¯3 B
,
¯¯B C
$str¯¯D Ä
)¯¯Ä Å
;¯¯Å Ç
}
˘˘ 
}
˙˙ 	
private
¸¸ 
async
¸¸ 
Task
¸¸ 
<
¸¸  
OperationResultDto
¸¸ -
>
¸¸- .&
CreateAndSavePlayerAsync
¸¸/ G
(
¸¸G H
UserProfileDto
¸¸H V
userProfile
¸¸W b
,
¸¸b c
string
¸¸d j
password
¸¸k s
,
¸¸s t
string
¸¸u {
code¸¸| Ä
)¸¸Ä Å
{
˝˝ 	
const
˛˛ 
int
˛˛ 
StatusOffline
˛˛ #
=
˛˛$ %
$num
˛˛& '
;
˛˛' (
const
ˇˇ 
int
ˇˇ %
EmailCodeTimeExpiration
ˇˇ -
=
ˇˇ. /
$num
ˇˇ0 2
;
ˇˇ2 3
var
ÅÅ 
	newPlayer
ÅÅ 
=
ÅÅ 
new
ÅÅ 
Player
ÅÅ  &
{
ÇÇ 
username
ÉÉ 
=
ÉÉ 
userProfile
ÉÉ &
.
ÉÉ& '
Username
ÉÉ' /
,
ÉÉ/ 0
email
ÑÑ 
=
ÑÑ 
userProfile
ÑÑ #
.
ÑÑ# $
Email
ÑÑ$ )
,
ÑÑ) *
password
ÖÖ 
=
ÖÖ 
PasswordHasher
ÖÖ )
.
ÖÖ) *
HashPassword
ÖÖ* 6
(
ÖÖ6 7
password
ÖÖ7 ?
)
ÖÖ? @
,
ÖÖ@ A
name
ÜÜ 
=
ÜÜ 
userProfile
ÜÜ "
.
ÜÜ" #
	FirstName
ÜÜ# ,
,
ÜÜ, -
lastName
áá 
=
áá 
userProfile
áá &
.
áá& '
LastName
áá' /
,
áá/ 0
Gender_idGender
àà 
=
àà  !
userProfile
àà" -
.
àà- .
GenderId
àà. 6
,
àà6 7
Avatar_idAvatar
ââ 
=
ââ  !
userProfile
ââ" -
.
ââ- .
AvatarId
ââ. 6
>
ââ7 8
$num
ââ9 :
?
ââ; <
userProfile
ââ= H
.
ââH I
AvatarId
ââI Q
:
ââR S
$num
ââT U
,
ââU V%
UserStatus_idUserStatus
ää '
=
ää( )
StatusOffline
ää* 7
,
ää7 8
is_verified
ãã 
=
ãã 
$num
ãã 
,
ãã  
verification_code
åå !
=
åå" #
code
åå$ (
,
åå( )
code_expiry_date
çç  
=
çç! "
DateTime
çç# +
.
çç+ ,
UtcNow
çç, 2
.
çç2 3

AddMinutes
çç3 =
(
çç= >%
EmailCodeTimeExpiration
çç> U
)
ççU V
}
éé 
;
éé 
_playerRepository
êê 
.
êê 
	AddPlayer
êê '
(
êê' (
	newPlayer
êê( 1
)
êê1 2
;
êê2 3
try
íí 
{
ìì 
await
îî 
_playerRepository
îî '
.
îî' (
SaveChangesAsync
îî( 8
(
îî8 9
)
îî9 :
;
îî: ;
_log
ïï 
.
ïï 
Info
ïï 
(
ïï 
$"
ïï 
$str
ïï 2
{
ïï2 3
userProfile
ïï3 >
.
ïï> ?
Username
ïï? G
}
ïïG H
$str
ïïH J
"
ïïJ K
)
ïïK L
;
ïïL M
return
ññ 
new
ññ  
OperationResultDto
ññ -
{
óó 
Success
òò 
=
òò 
true
òò "
,
òò" #
Message
ôô 
=
ôô 
$str
ôô 8
}
öö 
;
öö 
}
õõ 
catch
úú 
(
úú 
	Exception
úú 
ex
úú 
)
úú  
{
ùù 
_log
ûû 
.
ûû 
Error
ûû 
(
ûû 
$"
ûû 
$str
ûû 9
{
ûû9 :
userProfile
ûû: E
.
ûûE F
Username
ûûF N
}
ûûN O
$str
ûûO P
"
ûûP Q
,
ûûQ R
ex
ûûS U
)
ûûU V
;
ûûV W
ThrowServiceFault
üü !
(
üü! "
ServiceErrorType
üü" 2
.
üü2 3
DatabaseError
üü3 @
,
üü@ A
$str
üüB g
)
üüg h
;
üüh i
return
†† 
null
†† 
;
†† 
}
°° 
}
¢¢ 	
private
§§ 
void
§§ 
ThrowServiceFault
§§ &
(
§§& '
ServiceErrorType
§§' 7
type
§§8 <
,
§§< =
string
§§> D
message
§§E L
)
§§L M
{
•• 	
var
¶¶ 
fault
¶¶ 
=
¶¶ 
new
¶¶ 
ServiceFaultDto
¶¶ +
(
¶¶+ ,
type
¶¶, 0
,
¶¶0 1
message
¶¶2 9
)
¶¶9 :
;
¶¶: ;
throw
ßß 
new
ßß 
FaultException
ßß $
<
ßß$ %
ServiceFaultDto
ßß% 4
>
ßß4 5
(
ßß5 6
fault
ßß6 ;
,
ßß; <
new
ßß= @
FaultReason
ßßA L
(
ßßL M
message
ßßM T
)
ßßT U
)
ßßU V
;
ßßV W
}
®® 	
}
©© 
}™™ ÑT
êC:\Users\Gabriela\Desktop\Rodrigo\5¬∞Semestre\Tecnolog√≠asParaLaConstruccion\GuessMyMessServerProyect\GuessMyMessServer\AppStart\Bootstrapper.cs
	namespace 	
GuessMyMessServer
 
. 
AppStart $
{ 
public 

static 
class 
Bootstrapper $
{ 
public 
static 

IContainer  
	Container! *
{+ ,
get- 0
;0 1
private2 9
set: =
;= >
}? @
private 
static 
bool 
_isInitialized *
;* +
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
;; <
public 
static 
void 
Init 
(  
)  !
{ 	
if 
( 
_isInitialized 
) 
return  &
;& '
lock 
( 
_lock 
) 
{ 
if 
( 
_isInitialized "
)" #
return$ *
;* +
try 
{ 
var 
builder 
=  !
new" %
ContainerBuilder& 6
(6 7
)7 8
;8 9
RegisterDataAccess &
(& '
builder' .
). /
;/ 0
RegisterUtilities   %
(  % &
builder  & -
)  - .
;  . /!
RegisterBusinessLogic!! )
(!!) *
builder!!* 1
)!!1 2
;!!2 3
RegisterServices"" $
(""$ %
builder""% ,
)"", -
;""- ."
ResetAllUsersToOffline## *
(##* +
)##+ ,
;##, -
	Container$$ 
=$$ 
builder$$  '
.$$' (
Build$$( -
($$- .
)$$. /
;$$/ 0
_isInitialized%% "
=%%# $
true%%% )
;%%) *
}&& 
catch'' 
('' 
	Exception''  
ex''! #
)''# $
{(( 
throw)) 
new)) %
InvalidOperationException)) 7
())7 8
$str))8 f
,))f g
ex))h j
)))j k
;))k l
}** 
}++ 
},, 	
private.. 
static.. 
void.. 
RegisterDataAccess.. .
(... /
ContainerBuilder../ ?
builder..@ G
)..G H
{// 	
builder00 
.00 
RegisterType00  
<00  !!
GuessMyMessDBEntities00! 6
>006 7
(007 8
)008 9
.11 
AsSelf11 
(11 
)11 
.22 !
InstancePerDependency22 &
(22& '
)22' (
;22( )
builder33 
.33 
RegisterType33  
<33  !
PlayerRepository33! 1
>331 2
(332 3
)333 4
.334 5
As335 7
<337 8
IPlayerRepository338 I
>33I J
(33J K
)33K L
;33L M
builder44 
.44 
RegisterType44  
<44  !
MatchRepository44! 0
>440 1
(441 2
)442 3
.443 4
As444 6
<446 7
IMatchRepository447 G
>44G H
(44H I
)44I J
;44J K
builder55 
.55 
RegisterType55  
<55  !
SocialRepository55! 1
>551 2
(552 3
)553 4
.554 5
As555 7
<557 8
ISocialRepository558 I
>55I J
(55J K
)55K L
;55L M
builder66 
.66 
RegisterType66  
<66  !
AvatarRepository66! 1
>661 2
(662 3
)663 4
.664 5
As665 7
<667 8
IAvatarRepository668 I
>66I J
(66J K
)66K L
;66L M
builder77 
.77 
RegisterType77  
<77  !#
SocialNetworkRepository77! 8
>778 9
(779 :
)77: ;
.77; <
As77< >
<77> ?$
ISocialNetworkRepository77? W
>77W X
(77X Y
)77Y Z
;77Z [
builder88 
.88 
RegisterType88  
<88  !
WordRepository88! /
>88/ 0
(880 1
)881 2
.882 3
As883 5
<885 6
IWordRepository886 E
>88E F
(88F G
)88G H
;88H I
}99 	
private;; 
static;; 
void;; 
RegisterUtilities;; -
(;;- .
ContainerBuilder;;. >
builder;;? F
);;F G
{<< 	
builder== 
.== 
RegisterType==  
<==  !
SmtpEmailService==! 1
>==1 2
(==2 3
)==3 4
.==4 5
As==5 7
<==7 8
IEmailService==8 E
>==E F
(==F G
)==G H
.==H I
SingleInstance==I W
(==W X
)==X Y
;==Y Z
}>> 	
private@@ 
static@@ 
void@@ !
RegisterBusinessLogic@@ 1
(@@1 2
ContainerBuilder@@2 B
builder@@C J
)@@J K
{AA 	
builderBB 
.BB 
RegisterTypeBB  
<BB  !
AuthenticationLogicBB! 4
>BB4 5
(BB5 6
)BB6 7
.BB7 8
AsSelfBB8 >
(BB> ?
)BB? @
;BB@ A
builderCC 
.CC 
RegisterTypeCC  
<CC  !
UserProfileLogicCC! 1
>CC1 2
(CC2 3
)CC3 4
.CC4 5
AsSelfCC5 ;
(CC; <
)CC< =
;CC= >
builderDD 
.DD 
RegisterTypeDD  
<DD  !
SocialLogicDD! ,
>DD, -
(DD- .
)DD. /
.DD/ 0
AsSelfDD0 6
(DD6 7
)DD7 8
;DD8 9
builderEE 
.EE 
RegisterTypeEE  
<EE  !
MatchmakingLogicEE! 1
>EE1 2
(EE2 3
)EE3 4
.EE4 5
AsSelfEE5 ;
(EE; <
)EE< =
;EE= >
builderFF 
.FF 
RegisterTypeFF  
<FF  !

LobbyLogicFF! +
>FF+ ,
(FF, -
)FF- .
.FF. /
AsSelfFF/ 5
(FF5 6
)FF6 7
;FF7 8
builderGG 
.GG 
RegisterTypeGG  
<GG  !
	GameLogicGG! *
>GG* +
(GG+ ,
)GG, -
.GG- .
AsSelfGG. 4
(GG4 5
)GG5 6
;GG6 7
}HH 	
privateJJ 
staticJJ 
voidJJ 
RegisterServicesJJ ,
(JJ, -
ContainerBuilderJJ- =
builderJJ> E
)JJE F
{KK 	
builderLL 
.LL 
RegisterTypeLL  
<LL  !!
AuthenticationServiceLL! 6
>LL6 7
(LL7 8
)LL8 9
.MM 
AsMM 
<MM 
	ContractsMM 
.MM 
ServiceContractsMM .
.MM. /"
IAuthenticationServiceMM/ E
>MME F
(MMF G
)MMG H
;MMH I
builderOO 
.OO 
RegisterTypeOO  
<OO  !
UserProfileServiceOO! 3
>OO3 4
(OO4 5
)OO5 6
.PP 
AsPP 
<PP 
	ContractsPP 
.PP 
ServiceContractsPP .
.PP. /
IUserProfileServicePP/ B
>PPB C
(PPC D
)PPD E
;PPE F
builderRR 
.RR 
RegisterTypeRR  
<RR  !
SocialServiceRR! .
>RR. /
(RR/ 0
)RR0 1
.SS 
AsSS 
<SS 
	ContractsSS 
.SS 
ServiceContractsSS .
.SS. /
ISocialServiceSS/ =
>SS= >
(SS> ?
)SS? @
;SS@ A
builderUU 
.UU 
RegisterTypeUU  
<UU  !
MatchmakingServiceUU! 3
>UU3 4
(UU4 5
)UU5 6
.VV 
AsVV 
<VV 
	ContractsVV 
.VV 
ServiceContractsVV .
.VV. /
IMatchmakingServiceVV/ B
>VVB C
(VVC D
)VVD E
;VVE F
builderXX 
.XX 
RegisterTypeXX  
<XX  !
LobbyServiceXX! -
>XX- .
(XX. /
)XX/ 0
.YY 
AsYY 
<YY 
	ContractsYY 
.YY 
ServiceContractsYY .
.YY. /
ILobbyServiceYY/ <
>YY< =
(YY= >
)YY> ?
;YY? @
builder[[ 
.[[ 
RegisterType[[  
<[[  !
GameService[[! ,
>[[, -
([[- .
)[[. /
.\\ 
As\\ 
<\\ 
	Contracts\\ 
.\\ 
ServiceContracts\\ .
.\\. /
IGameService\\/ ;
>\\; <
(\\< =
)\\= >
;\\> ?
}]] 	
private__ 
static__ 
void__ "
ResetAllUsersToOffline__ 2
(__2 3
)__3 4
{`` 	
usingaa 
(aa 
varaa 
contextaa 
=aa  
newaa! $!
GuessMyMessDBEntitiesaa% :
(aa: ;
)aa; <
)aa< =
{bb 
constcc 
intcc 
StatusOfflinecc '
=cc( )
$numcc* +
;cc+ ,
varee 
onlineUsersee 
=ee  !
contextee" )
.ee) *
Playeree* 0
.ff 
Whereff 
(ff 
pff 
=>ff 
pff  !
.ff! "#
UserStatus_idUserStatusff" 9
!=ff: <
StatusOfflineff= J
)ffJ K
.gg 
ToListgg 
(gg 
)gg 
;gg 
ifii 
(ii 
onlineUsersii 
.ii  
Anyii  #
(ii# $
)ii$ %
)ii% &
{jj 
foreachkk 
(kk 
varkk  
userkk! %
inkk& (
onlineUserskk) 4
)kk4 5
{ll 
usermm 
.mm #
UserStatus_idUserStatusmm 4
=mm5 6
StatusOfflinemm7 D
;mmD E
}nn 
contextpp 
.pp 
SaveChangespp '
(pp' (
)pp( )
;pp) *
}qq 
}rr 
}ss 	
}tt 
}uu 