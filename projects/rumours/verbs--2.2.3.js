var defaultVerbs = [
  ` $didSomething because $person $didSomething`,
  ` drew $person as $anObject`,
  ` $was applauded by $person as $they $didSomething`,
  ` $was audited by $person`,
  ` $was becoming $aSentientObject`,
  ` $was bringing $subject to $subject`,
  ` $was involved that time $person $didSomething`,
  ` $was left bereft`,
  ` $was offered $anObject`,
  ` $was scared`,
  ` $wasn’t happy`,
  ` regretted having $didSomething`,
  ` abode by $person’s decision`,
  ` absorbed $subject`,
  ` accepted $anObject from $person`,
  ` accompanied $subject $place`,
  ` ached all over`,
  ` achieved what $person couldn’t: $they $didSomething`,
  ` acquired $anObject`,
  ` acted like $they $didSomething`,
  ` purposefully $didSomething`,
  ` accidentally $didSomething`,
  ` added $anInanimateObject to $anInanimateObject`,
  ` added $person on Facebook`,
  ` addressed $subject $place`,
  ` adjusted $subject`,
  ` admired $subject`,
  ` admitted that $they’d $didSomething`,
  ` took the blame for when $person $didSomething`,
  ` confessed that $subject $didSomething`,
  ` agreed it was awesome that time $person $didSomething`,
  ` alit $place`,
  ` always lost track of $their $object`,
  ` animated $subject`,
  ` announced that $person $didSomething`,
  ` apologized to $person about the time $they $didSomething`,
  ` appeared $place`,
  ` appeared before $person`,
  ` approached $person`,
  ` approved $subject`,
  ` argued with $person`,
  ` arose`,
  ` arranged $subject $place`,
  ` asked $person for $their $object`,
  ` asked $person if $they $didSomething`,
  ` astonished $person as $they $didSomething`,
  ` ate $anObject`,
  ` attacked $aSentientObject`,
  ` attended to $subject’s wounds`,
  ` attracted $aSentientObject`,
  ` avoided $person for a long time`,
  ` awoke $place`,
  ` bade farewell to $person $place`,
  ` banged $subject`,
  ` banished $subject $place`,
  ` bashed $subject`,
  ` batted $subject`,
  ` beat $subject`,
  ` beat $subject up`,
  ` became $anObject`,
  ` became $aSentientObject`,
  ` became blindsided by the time $they $didSomething`,
  ` begged $person for $subject`,
  ` beheld $anObject`,
  ` believed that $person $didSomething`,
  ` bent $subject over`,
  ` bent over $subject`,
  ` besought $person that $they $didSomething`,
  ` bet $their $object that $person $didSomething`,
  ` betrayed $person`,
  ` bit into $subject`,
  ` blamed $themself for the time $person $didSomething`,
  ` bled terribly`,
  ` blew $subject`,
  ` blushed`,
  ` boarded $anInanimateObject $place`,
  ` boasted about when $they $didSomething`,
  ` boiled $anInanimateObject $place`,
  ` boogied $place`,
  ` boogied on down $place`,
  ` bore into $anInanimateObject`,
  ` bought $anObject`,
  ` bound $subject to $subject`,
  ` bowed before $person`,
  ` boxed with $subject`,
  ` breathed a sigh of relief, because $they $didSomething`,
  ` bred $aSentientObject with $aSentientObject`,
  ` broadcast that $person $didSomething`,
  ` broiled $anInanimateObject $place`,
  ` broke $their $inanimateObject`,
  ` brought $anObject, $anObject and $anObject $place`,
  ` brought $subject $place`,
  ` brushed $subject with $anInanimateObject`,
  ` built $anInanimateObject`,
  ` built some kind of $anInanimateObject`,
  ` buried $subject $place`,
  ` called $person "$subject"`,
  ` called out for help`,
  ` came`,
  ` challenged $person about when they $didSomething`,
  ` changed in front of $subject`,
  ` claimed that $subject $didSomething`,
  ` considered repeating the time $they $didSomething`,
  ` considered what the world would be like if the time $they $didSomething never happened`,
  ` continued the time $they $didSomething`,
  ` couldn’t believe $subject really $didSomething`,
  ` couldn’t hear`,
  ` couldn’t lose $subject`,
  ` couldn’t reach $subject`,
  ` couldn’t sit because $they $didSomething`,
  ` couldn’t speak when $subject $didSomething`,
  ` couldn’t start`,
  ` couldn’t understand`,
  ` created $anInanimateObject`,
  ` decided it was best that $subject $didSomething`,
  ` decided to lead the way $place`,
  ` decided to show $person $they $didSomething`,
  ` described the time $subject $didSomething to $subject`,
  ` developed a new type of $anInanimateObject`,
  ` didn’t believe in $subject`,
  ` didn’t like $their $object`,
  ` died`,
  ` passed out`,
  ` dressed up as $subject`,
  ` drove around $subject`,
  ` expected more from $person`,
  ` exploded`,
  ` farted`,
  ` fell over`,
  ` felt $anObject`,
  ` flapped $anInanimateObject`,
  ` flew away`,
  ` fought with $subject`,
  ` found $anObject`,
  ` found $subject`,
  ` found out $they almost $didSomething`,
  ` fried $anObject`,
  ` gave $anObject to $person`,
  ` gave $person a virus`,
  ` caught a deadly virus`,
  ` got $anObject`,
  ` got arrested`,
  ` got splattered by $subject`,
  ` had always belonged to $person`,
  ` had an urge to write about $subject`,
  ` had assorted $objects`,
  ` had been blessed by $subject`,
  ` had began to transform into $subject`,
  ` had to follow $subject`,
  ` had truely began $their quest as $they $didSomething`,
  ` happened upon $anObject`,
  ` helped $subject as $they $didSomething`,
  ` hoped $aSentientObject $didSomething`,
  ` hung $subject up $place`,
  ` hurled $place`,
  ` idolised $person`,
  ` ironed $subject`,
  ` jogged along`,
  ` kept going potty $place`,
  ` kept harassing $subject`,
  ` knew $they needed to try… and $didSomething`,
  ` knew $they once $didSomething`,
  ` led $subject $place`,
  ` left $place`,
  ` looked ugly`,
  ` lost $their $object`,
  ` made $anInanimateObject`,
  ` made $subject fall $place`,
  ` magically turned $subject into $anObject`,
  ` medicated`,
  ` met up with $person`,
  ` morphed into $anObject`,
  ` moved $place`,
  ` moved`,
  ` needed $anObject`,
  ` never behaved`,
  ` never could have afforded $person’s $object`,
  ` noticed $person’s mood abated`,
  ` noticed $subject was too heavy to carry`,
  ` noticed $their vision blurred`,
  ` offered $their $object to $person`,
  ` paid too much for the time $they $didSomething`,
  ` played around`,
  ` played with $subject`,
  ` pretended to be $subject`,
  ` produced $anObject $place`,
  ` provided $subject with $their $object`,
  ` put $anObject on $subject`,
  ` raced $subject`,
  ` ran $place`,
  ` ran after $subject`,
  ` ran along`,
  ` re-enacted the time $person $didSomething`,
  ` reached over $subject`,
  ` read $anInanimateObject`,
  ` realised $they liked $subject`,
  ` received $anObject`,
  ` remained vigilant`,
  ` remembered when $subject $didSomething`,
  ` dwelled upon the time $they $didSomething`,
  ` required $anObject`,
  ` returned $place`,
  ` round-house kicked $subject`,
  ` said $they would never speak again`,
  ` said that $they $didSomething`,
  ` sang about $subject`,
  ` sat on $anObject`,
  ` sat`,
  ` saw $subject`,
  ` scattered $objects $place`,
  ` screamed at $subject`,
  ` searched for $their $object`,
  ` sent $person $anObject`,
  ` set $subject on $subject`,
  ` set $subject to silent`,
  ` shot $subject`,
  //` should have allowed that $subject $didSomething`, // normally makes for weird sentences
  ` should have opened $anInanimateObject for $subject`,
  ` shouted "Hold onto $subject!"`,
  ` sketched $subject`,
  ` smacked $subject`,
  ` smoked $anObject`,
  ` smooched $subject`,
  ` snooped around $place`,
  ` sold many $objects`,
  ` spent all $their money on $subject`,
  ` spent too long the time $they $didSomething`,
  ` spent too much on $anObject`,
  ` stabbed $subject`,
  ` started touching $subject`,
  ` stole $person’s $object`,
  ` stood on $subject`,
  ` stopped when $they $didSomething`,
  ` sucked in $anObject`,
  ` suggested $person $didSomething`,
  ` surrounded $subject with $objects`,
  ` swatted $subject`,
  ` switched $anObject with $anObject`,
  ` talked to $aSentientObject`,
  ` thought $person answered`,
  ` thought $person seemed like someone who $didSomething`,
  ` thought $they let it happen when $person $didSomething`,
  ` thought about $subject`,
  // ` thought he could have $didSomething`, // sentences are generally rather contrived
  // ` thought long and hard about when $they $didSomething`, // sentences are generally rather contrived
  // ` thought the time $subject $didSomething wouldn’t ever happen`, // sentences are generally rather contrived
  ` threw $anInanimateObject`,
  ` threw $their $inanimateObject away`,
  ` threw a tantrum`,
  ` tied $subject up`,
  ` told $person about when $they $didSomething`,
  ` took $anObject from $subject`,
  ` took $subject from $person`,
  ` traded $their $object for $subject`,
  ` trapped $subject $place`,
  ` tried to be like $subject`,
  ` triple backflipped over $anObject`,
  ` tripped $place`,
  ` tripped on $subject`,
  ` truely blossomed`,
  ` turned $subject around`,
  ` understood`,
  ` used $anInanimateObject`,
  ` used to have $anObject`,
  ` waited while $person $didSomething`,
  ` walked $place`,
  ` wanted $anObject`,
  ` wanted $subject`,
  ` wanted to include $subject when $they $didSomething`,
  ` wanted to live $place`,
  ` was harassed by $subject`,
  ` watched as tragedy befell $person`,
  ` watched on as $person $didSomething`,
  ` went along $place and $didSomething`,
  ` wished $person $didSomething`,
  ` won`,
  ` worked hard because $they $didSomething`,
  ` would never keep $anObject`,
  ` wouldn’t allow the time $subject $didSomething`,
  ` wouldn’t give up`,
  ` wouldn’t play with $subject`,
  ` wrote on the back of $subject`,
  ` lied, $they really $didSomething`,
  ` raised awareness of $anObject`,
  ` couldn’t explain why… $they just $didSomething`,
];

/*
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
