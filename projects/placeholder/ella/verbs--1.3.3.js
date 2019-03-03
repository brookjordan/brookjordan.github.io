var defaultVerbs = [
  ` searched for $their $object`,
  ` sat on $anObject`,
  ` fried $anObject`,
  ` remembered the time $they $didSomething`,
  ` tripped on $subject`,
  ` fell over`,
  ` triple backflipped over $anObject`,
  ` raced $subject`,
  ` tied $subject up`,
  ` hurled $place`,
  ` re-enacted the time $person $didSomething`,
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
  ` wished $person $didSomething`,
  ` became $anObject`,
  ` $was becoming $aSentientObject`,
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
  ` threw $anInanimateObject`,
  ` didn't like $their $object`,
  ` traded $their $object for $subject`,
  ` threw a tantrum`,
  ` noticed $person's mood abated`,
  ` abode by $person's decision`,
  ` absorbed $subject`,
  ` accepted $anObject from $person`,
  ` accompanied $subject $place`,
  ` ached all over`,
  ` achieved what $person couldn't: $they $didSomething`,
  ` acquired $anObject`,
  ` acted like $they $didSomething`,
  ` added $person on Facebook`,
  ` addressed $subject $place`,
  ` adjusted $subject`,
  ` admired $subject`,
  ` admitted to the time $they $didSomething`,
  ` advised $person $they $didSomething`,
  ` never could have afforded $person's $object`,
  ` agreed $subject $didSomething`,
  ` alit $place`,
  ` should have allowed that $subject $didSomething`,
  ` animated $subject`,
  ` announced that $person $didSomething`,
  ` thought $person answered`,
  ` apologized to $person about the time $they $didSomething`,
  ` appeared $place`,
  ` $was applauded by $person as $they $didSomething`,
  ` approached $person`,
  ` approved $subject`,
  ` argued with $person`,
  ` arose`,
  ` arranged $subject $place`,
  ` got arrested`,
  ` asked $person for $their $object`,
  ` claimed that $subject $didSomething`,
  ` had assorted $anObject`,
  ` stole $person's $object`,
  ` astonished $person as $they $didSomething`,
  ` attacked $aSentientObject`,
  ` attended to $subject's wounds`,
  ` attracted $aSentientObject`,
  ` $was audited by $person`,
  ` avoided $person for a long time`,
  ` awoke $place`,
  ` banged $subject`,
  ` banished $subject $place`,
  ` bashed $subject`,
  ` batted $subject`,
  ` bore into $anInanimateObject`,
  ` beat $subject`,
  ` became $anObject`,
  ` watched as tragedy befell $person`,
  ` begged $person for $subject`,
  ` had truely began $their quest as $they $didSomething`,
  ` never behaved`,
  ` beheld $anObject`,
  ` believed that $person $didSomething`,
  ` had always belonged to $person`,
  ` bent over $subject`,
  ` bent $subject over`,
  ` $was left bereft`,
  ` besought $person that $they $didSomething`,
  ` bet $their $object that $person $didSomething`,
  ` betrayed $person`,
  ` bade farewell to $person $place`,
  ` bound $subject to $subject`,
  ` bit into $subject`,
  ` bled terribly`,
  ` had been blessed by $subject`,
  ` truely blossomed`,
  ` blew $subject`,
  ` noticed $their vision blurred`,
  ` blushed`,
  ` boarded $anInanimateObject $place`,
  ` boasted about when $they $didSomething`,
  ` boiled $anInanimateObject $place`,
  ` broiled $anInanimateObject $place`,
  ` bowed before $person`,
  ` boxed with $subject`,
  ` broke $their $inanimateObject`,
  ` breathed a sigh of relief, because $they $didSomething`,
  ` bred $aSentientObject with $aSentientObject`,
  ` brought $subject $place`,
  ` broadcast that $person $didSomething`,
  ` brushed $subject with $anInanimateObject`,
  ` built $anInanimateObject`,
  ` tried to be like $subject`,
  ` used to have $anObject`,
  ` thought he could have $didSomething`,
  ` said that $they $didSomething`,
  ` got $anObject`,
  ` made $anInanimateObject`,
  ` went along $place and $didSomething`,
  ` jogged along`,
  ` ran along`,
  ` saw $subject`,
  ` knew $they once $didSomething`,
  ` took $anObject from $subject`,
  ` thought long and hard about when $they $didSomething`,
  ` came`,
  ` gave $anObject to $person`,
  ` looked ugly`,
  ` used $anInanimateObject`,
  ` found $anObject`,
  ` wanted $subject`,
  ` told $person about when $they $didSomething`,
  ` put $anObject on $subject`,
  ` actually meant the time that $they $didSomething`,
  ` became $aSentientObject`,
  ` left $place`,
  ` worked hard because $they $didSomething`,
  ` needed $anObject`,
  ` felt $anObject`,
  ` thought $person seemed like someone who $didSomething`,
  ` asked $person if they $didSomething`,
  ` decided to show $person $they $didSomething`,
  ` knew $they needed to try and $didSomething`,
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
  ` helped $subject as $they $didSomething`,
  ` couldn't start`,
  ` ran after $subject`,
  ` had an urge to write about $subject`,
  ` wrote on the back of $subject`,
  ` wrote on the back of $subject`,
  ` ran $place`,
  ` found out $they almost $didSomething`,
  ` set $subject to silent`,
  ` set $subject on $subject`,
  ` moved`,
  ` moved $place`,
  ` played around`,
  ` wouldn't play with $subject`,
  ` paid too much for the time $they $didSomething`,
  ` couldn't hear`,
  ` wanted to include $subject when $they $didSomething`,
  ` didn't believe in $subject`,
  ` couldn't believe $subject really $didSomething`,
  ` wouldn't allow the time $subject $didSomething`,
  ` met up with $person`,
  ` decided to lead the way to $place`,
  ` led $subject $place`,
  ` wanted to live $place`,
  ` stood on $subject`,
  ` thought the time $subject $didSomething wouldn't ever happen`,
  ` happened upon $anObject`,
  ` noticed $subject was too heavy to carry`,
  ` talked to $subject`,
  ` appeared before $person`,
  ` produced $anObject $place`,
  ` sat`,
  ` couldn't sit because $they $didSomething`,
  ` considered what the world would be like if the time $they $didSomething never happened`,
  ` offered $their $object to $person`,
  ` $was offered $anObject`,
  ` considered repeating the time $they $didSomething`,
  ` expected more from $person`,
  ` suggested $person $didSomething`,
  ` thought $they let it happen when $person $didSomething`,
  ` blamed $themself for the time $person $didSomething`,
  ` read $anInanimateObject`,
  ` required $anObject`,
  ` continued the time $they $didSomething`,
  ` lost $their $object`,
  ` couldn't lose $subject`,
  ` added $anInanimateObject to $anInanimateObject`,
  ` morphed into $anObject`,
  ` changed in front of $subject`,
  ` magically turned $subject into $anObject`,
  ` dressed up as $subject`,
  ` fell over`,
  ` made $subject fall $place`,
  ` remained vigilant`,
  ` remembered when $subject $didSomething`,
  ` bought $anObject`,
  ` couldn't speak when $subject $didSomething`,
  ` said $they would never speak again`,
  ` stopped when $they $didSomething`,
  ` sent $person $anObject`,
  ` received $anObject`,
  ` decided it was best that $subject $didSomething`,
  ` won`,
  ` couldn't understand`,
  ` understood`,
  ` described the time $subject $didSomething to $subject`,
  ` brought $anObject, $anObject and $anObject $place`,
  ` developed a new type of $anInanimateObject`,
  ` agreed it was awesome that time $person $didSomething`,
  ` should have opened $anInanimateObject for $subject`,
  ` couldn't reach $subject`,
  ` reached over $subject`,
  ` built some kind of $anInanimateObject`,
  ` $was involved that time $person $didSomething`,
  ` spent all $their money on $subject`,
  ` spent too long the time $they $didSomething`,
  ` screamed at $subject`,
  ` surrounded $subject with $objects`,
  ` stabbed $subject`,
  ` returned $place`,
  ` medicated`,
  ` becamse blindsided by the time $they $didSomething`,
  ` boogied $place`,
  ` boogied on down, $place`,
  ` flapped $anInanimateObject`,
  ` tripped $place`,
  ` swatted $subject`,
  ` sucked in $anObject`,
  ` kept harassing $subject`,
  ` was harassed by $subject`,
  ` trapped $subject $place`,
  ` snooped around $place`,
  ` exploded`,
  ` sketched $subject`,
  ` scattered $objects $place`,
  ` challenged $person about when they $didSomething`,
  ` fought with $subject`,
  ` buried $subject $place`,
  ` got splattered by $subject`,
  ` smacked $subject`,
  ` smooched $subject`,
];

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
