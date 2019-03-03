var defaultVerbs = [
  ` searched for $their $object`,
  ` sat down`,
  ` fried $anObject`,
  ` remembered the time $they $verb`,
  ` tripped on $subject`,
  ` fell over`,
  ` triple backflipped over $anObject`,
  ` raced $subject`,
  ` tied $subject up`,
  ` hurled $place`,
  ` dove deep $place`,
  ` switched $anObject with $anObject`,
  ` round-house kicked $subject`,
  ` stabbed $subject`,
  ` got $anObject`,
  ` found $subject`,
  ` farted`,
  ` ate $anObject`,
  ` started touching $subject`,
  ` played with $subject`,
  ` wanted $anObject`,
  ` wished $person $verb`,
  ` became $anObject`,
  ` $was becoming $anObject`,
  ` ironed $subject`,
  ` pretended to be $subject`,
  ` flew away`,
  ` died`,
  ` idolised $person`,
  ` wouldn't give up`,
  ` hung $subject up $place`,
  ` sang about $subject`,
  ` drove around $subject`,
  ` took $subject from $person`,
  ` $was scared`,
  ` $wasn't happy`,
  ` thought about $subject`,
  ` threw $anObject`,
  ` didn't like $their $object`,
  ` traded their $object for $subject `,
  ` threw a tantrum`,
  ` noticed $person's mood abated`,
  ` abode by $person's decision`,
  ` absorbed $subject`,
  ` accepted $anObject`,
  ` accompanied $person $place`,
  ` ached all over`,
  ` achieved more than $subject`,
  ` acquired $anObject`,
  ` acted like $they $verb`,
  ` added $person on Facebook`,
  ` addressed $person $place`,
  ` adjusted $subject`,
  ` admired $subject`,
  ` admitted to the time $they $verb`,
  ` advised $person $they $verb`,
  ` never could have afforded $person's $object`,
  ` agreed $subject $verb`,
  ` alit $place`,
  ` should have allowed that $subject $verb`,
  ` animated $subject`,
  ` announced that $person $verb`,
  ` thought $person answered`,
  ` apologized to $person about the time $they $verb`,
  ` appeared $place`,
  ` $was applauded by $person as $they $verb`,
  ` applied $anObject to $anObject`,
  ` approached $person`,
  ` approved $subject`,
  ` argued with $person`,
  ` arose`,
  ` arranged $subject $place`,
  ` got arrested`,
  ` asked $person for their $object`,
  ` asserted $subject $verb`,
  ` had assorted $anObject`,
  ` astonished $person as $they $verb`,
  ` attacked $anObject`,
  ` attended to $subject's wounds`,
  ` attracted $anObject`,
  ` $was audited by $person`,
  ` avoided $person for a long time`,
  ` awoke $place`,
  ` banged $subject`,
  ` banished $subject $place`,
  ` bashed $subject`,
  ` batted $subject`,
  ` bore into $anObject`,
  ` beat $subject`,
  ` became $anObject`,
  ` watched as tragedy befell $person`,
  ` begged $person for $subject`,
  ` had truely began $their quest as $they $verb`,
  ` never behaved`,
  ` beheld $anObject`,
  ` believed that $person $verb`,
  ` had always belonged to $person`,
  ` bent over $anObject`,
  ` $was left bereft`,
  ` besought $person that $they $verb`,
  ` bet $their $object that $person $verb`,
  ` betrayed $person`,
  ` bade farewell to $person $place`,
  ` bound $subject to $subject`,
  ` bit into $subject`,
  ` bled terribly`,
  ` had been blessed by $subject`,
  ` truely blossomed`,
  ` blew on $anObject`,
  ` noticed $their vision blurred`,
  ` blushed`,
  ` boarded $anObject $place`,
  ` boasted about when $they $verb`,
  ` boiled $anObject $place`,
  ` broiled $anObject $place`,
  ` bowed before $person`,
  ` boxed with $subject`,
  ` broke $their $object`,
  ` breathed deep, ready for when $they $verb`,
  ` bred $anObject with $anObject`,
  ` brought $subject $place`,
  ` broadcast that $person $verb`,
  ` brushed $subject with $anObject`,
  ` built $anObject`,
  ` tried to be like $subject`,
  ` used to have $anObject`,
  ` thought he could have $verb`,
  ` said that $they $verb`,
  ` got $anObject`,
  ` made $anObject`,
  ` went along $place and $verb`,
  ` jogged along`,
  ` ran along`,
  ` saw $subject`,
  ` knew $they once $verb`,
  ` took $anObject from $subject`,
  ` thought long and hard about when $they $verb`,
  ` came`,
  ` gave $anObject to $person`,
  ` looked ugly`,
  ` used $anObject`,
  ` found $anObject`,
  ` wanted $subject`,
  ` told $person about when $they $verb`,
  ` put $anObject on $subject`,
  ` actually meant the time that $they $verb`,
  ` became $anObject`,
  ` left $place`,
  ` worked hard because $they $verb`,
  ` needed $anObject`,
  ` felt $anObject`,
  ` thought $person seemed like someone who $verb`,
  ` asked $person if they $verb`,
  ` decided to show $person $they $verb`,
  ` knew $they needed to try and $verb`,
  ` called $person "$subject"`,
  ` called $person`,
  ` would never keep $anObject`,
  ` always lost track of $their $object`,
  ` provided $subject with $their $object`,
  ` shouted "Hold onto $subject!"`,
  ` turned $subject around`,
  ` had to follow $subject`,
  ` had began to transform into $subject`,
  ` $was bringing $subject to $subject`,
  ` realised $they liked $subject`,
  ` kept going potty $place`,
  ` helped $subject as $they $verb`,
  ` couldn't start`,
  ` ran after $subject`,
  ` had an urge to write about $subject`,
  ` wrote on the back of $subject`,
  ` wrote on the back of $subject`,
  ` ran $place`,
  ` found out $they could set $subject to silent`,
  ` set $subject on $subject`,
  ` moved`,
  ` moved $place`,
  ` played around`,
  ` wouldn't play with $subject`,
  ` paid too much for the time $they $verb`,
  ` couldn't hear`,
  ` wanted to include $subject when $they $verb`,
  ` didn't believe in $subject`,
  ` couldn't believe $subject really $verb`,
  ` wouldn't allow the time $subject $verb`,
  ` met up with $person`,
  ` decided to lead the way to $place`,
  ` led $subject $place`,
  ` wanted to live $place`,
  ` stood on $subject`,
  ` thought the time $subject $verb wouldn't ever happen`,
  ` happened upon $anObject`,
  ` noticed $subject was too heavy to carry`,
  ` talked to $subject`,
  ` appeared before $person`,
  ` produced $anObject $place`,
  ` sat`,
  ` couldn't sit because $they had just $verb`,
  ` offered $subject $subject`,
  ` considered what the world would be like if the time $they $verb never happened`,
  ` offered $their $object to $subject`,
  ` $was offered $anObject`,
  ` considered repeating the time $they $verb`,
  ` expected more from $person`,
  ` suggested $person $verb`,
  ` thought $they let it happen when $person $verb`,
  ` blamed $themself for the time $person $verb`,
  ` read $anObject`,
  ` required $anObject`,
  ` continued the time $they $verb`,
  ` lost $their $object`,
  ` couldn't lose $subject`,
  ` added $anObject to $anObject`,
  ` morphed into $anObject`,
  ` changed in front of $subject`,
  ` changed $subject into $anObject`,
  ` fell over`,
  ` made $subject fall $place`,
  ` remained vigilant`,
  ` remembered when $subject $verb`,
  ` bought $anObject`,
  ` couldn't speak when $subject $verb`,
  ` said $they would never speak again`,
  ` stopped when $they $verb`,
  ` sent $person $anObject`,
  ` received $anObject`,
  ` decided it was best that $subject $verb`,
  ` won`,
  ` couldn't understand`,
  ` understood`,
  ` described the time $subject $verb to $subject`,
  ` bought $anObject, $anObject and $anObject $place`,
  ` developed a new type of $anObject`,
  ` agreed it was awesome that time $person $verb`,
  ` should have opened $anObject for $subject`,
  ` couldn't reach $subject`,
  ` reached over $subject`,
  ` built some kind of $anObject`,
  ` $was involved that time $person $verb`,
  ` spent all $their money on $subject`,
  ` spent too long the time $they $verb`,
  ` screamed at $subject`
];
/*
surround
stab
return
medicate
blindside
boogie
flap
trip
swat
suck in
harass
trap
snoop
explode
sketchy
scatter
challenge
fight
bury
splatter
smack
*/

/*
spend
return
draw
die
hope
create
walk
sell
wait
cause
pass
lie
accept
watch
raise
base
apply
break
explain
learn
increase
cover
grow
claim
report
support
cut
form
stay
contain
reduce
establish
join
wish
achieve
seek
choose
deal
face
fail
serve
end
kill
occur
drive
represent
rise
discuss
love
pick
place
argue
prove
wear
catch
enjoy
eat
introduce
enter
present
arrive
ensure
point
plan
pull
refer
act
relate
affect
close
identify
manage
thank
compare
announce
obtain
note
forget
indicate
wonder
maintain
publish
suffer
avoid
express
suppose
finish
determine
design
listen
save
tend
treat
control
share
remove
throw
visit
exist
encourage
force
reflect
admit
assume
smile
prepare
replace
fill
improve
mention
fight
intend
miss
discover
drop
hit
push
prevent
refuse
regard
lay
reveal
teach
answer
operate
state
depend
enable
record
check
complete
cost
sound
laugh
realise
extend
arise
notice
define
examine
fit
study
bear
hang
recognise
shake
sign
attend
fly
gain
perform
result
travel
adopt
confirm
protect
demand
stare
imagine
attempt
beat
born
associate
care
marry
collect
voice
employ
issue
release
emerge
mind
aim
deny
mark
shoot
appoint
order
supply
drink
observe
reply
ignore
link
propose
ring
settle
strike
press
respond
arrange
survive
concentrate
lift
approach
cross
test
charge
experience
touch
acquire
commit
demonstrate
grant
prefer
repeat
sleep
threaten
feed
insist
launch
limit
promote
deliver
measure
own
retain
assess
attract
belong
consist
contribute
hide
promise
reject
cry
impose
invite
sing
vary
warn
address
declare
destroy
worry
divide
head
name
stick
nod
recognize
train
attack
clear
combine
handle
influence
realize
recommend
shout
spread
undertake
account
select
climb
contact
recall
secure
step
transfer
welcome
conclude
disappear
display
dress
illustrate
imply
organise
direct
escape
generate
investigate
remind
advise
afford
earn
hand
inform
rely
succeed
approve
burn
fear
vote
conduct
cope
derive
elect
gather
jump
last
match
matter
persuade
ride
shut
blow
estimate
recover
score
slip
count
hate
attach
exercise
house
lean
roll
wash
accompany
accuse
bind
explore
judge
rest
steal
comment
exclude
focus
hurt
stretch
withdraw
back
fix
justify
knock
pursue
switch
appreciate
benefit
lack
list
occupy
permit
surround
abandon
complain
connect
construct
dominate
engage
paint
quote
view
acknowledge
dismiss
incorporate
interpret
proceed
search
separate
stress
alter
analyse
arrest
bother
defend
expand
implement
possess
review
suit
tie
assist
calculate
glance
mix
question
resolve
rule
suspect
wake
appeal
challenge
clean
damage
guess
reckon
restore
restrict
specify
constitute
convert
distinguish
submit
trust
urge
feature
land
locate
predict
preserve
solve
sort
struggle
cast
cook
dance
invest
lock
owe
pour
shift
kick
kiss
light
purchase
race
retire
bend
breathe
celebrate
date
fire
monitor
print
register
resist
behave
comprise
decline
detect
finance
organize
overcome
range
swing
differ
drag
guarantee
oppose
pack
pause
relax
resign
rush
store
waste
compete
expose
found
install
mount
negotiate
sink
split
whisper
assure
award
borrow
bury
capture
deserve
distribute
doubt
enhance
phone
sweep
tackle
advance
cease
concern
emphasise
exceed
qualify
slide
strengthen
transform
favour
grab
lend
participate
perceive
pose
practise
satisfy
smoke
sustain
tear
adapt
adjust
ban
consult
dig
dry
highlight
outline
reinforce
shrug
snap
absorb
amount
block
confine
delay
encounter
entitle
plant
pretend
request
rid
sail
trace
trade
wave
cite
dream
flow
fulfil
lower
process
react
seize
allocate
burst
communicate
defeat
double
exploit
fund
govern
hurry
injure
pray
protest
sigh
smell
stir
swim
undergo
wander
anticipate
collapse
compose
confront
ease
eliminate
evaluate
grin
interview
remark
suspend
weigh
wipe
wrap
attribute
balance
bet
bound
cancel
condemn
convince
correspond
dare
devise
free
gaze
guide
inspire
modify
murder
prompt
reverse
rub
slow
spot
swear
telephone
wind
admire
bite
crash
disturb
greet
hesitate
induce
integrate
knit
line
load
murmur
render
shine
swallow
tap
translate
yield
accommodate
age
assert
await
book
brush
chase
comply
copy
criticise
devote
evolve
flee
forgive
initiate
interrupt
leap
mutter
overlook
risk
shape
spell
squeeze
trap
undermine
witness
beg
drift
echo
emphasize
enforce
exchange
fade
float
freeze
hire
in
object
pop
provoke
recruit
research
sense
situate
stimulate
abolish
administer
allege
command
consume
convey
correct
educate
equip
execute
fetch
frown
invent
march
park
progress
reserve
respect
twist
unite
value
assign
cater
concede
conceive
disclose
envisage
exhibit
export
extract
fancy
inherit
insert
instruct
interfere
isolate
opt
peer
persist
plead
price
regret
regulate
repair
resemble
resume
speed
spin
spring
update
advocate
assemble
boost
breed
cling
commission
conceal
contemplate
criticize
decorate
descend
drain
edit
embrace
excuse
explode
facilitate
flash
fold
function
grasp
incur
intervene
label
please
rescue
strip
tip
upset
advertise
aid
centre
classify
coincide
confess
contract
crack
creep
decrease
deem
dispose
dissolve
dump
endorse
formulate
import
impress
market
reproduce
scatter
schedule
ship
shop
spare
sponsor
stage
suck
sue
tempt
vanish
access
commence
contrast
depict
discharge
draft
enclose
enquire
erect
file
halt
hunt
inspect
omit
originate
praise
precede
relieve
reward
round
seal
signal
smash
spoil
subject
target
taste
tighten
top
tremble
tuck
warm
activate
amend
arouse
bang
bid
bow
campaign
characterise
circulate
clarify
compensate
compile
cool
couple
depart
deprive
desire
diminish
drown
embark
entail
entertain
figure
fling
guard
manufacture
melt
neglect
plunge
project
rain
reassure
rent
revive
sentence
shed
slam
spill
stem
sum
summon
supplement
suppress
surprise
tax
thrust
tour
transmit
transport
weaken
widen
bounce
calm
characterize
chat
clutch
confer
conform
confuse
convict
counter
debate
dedicate
dictate
disagree
effect
flood
forbid
grip
heat
long
manipulate
merge
part
pin
position
prescribe
proclaim
punish
rebuild
regain
sack
strain
stroke
substitute
supervise
term
time
toss
underline
abuse
accumulate
alert
arm
attain
boast
boil
carve
cheer
colour
compel
crawl
crush
curl
deposit
differentiate
dip
dislike
divert
embody
exert
exhaust
fine
frighten
fuck
gasp
honour
inhibit
motivate
multiply
narrow
obey
penetrate
picture
presume
prevail
pronounce
rate
renew
revise
rip
scan
scratch
shiver
*/
