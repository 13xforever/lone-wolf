== game_rules ==
LIST DISCIPLINES = camo, hunt, sixs, track, heal, weap, mshld, mblst, akin, mom
LIST WEAPONS = (dagger), (spear), (mace), (ssword), (hammer), (sword), (axe), (staff), (bsword)
LIST BACKPACK_ITEMS = hp
LIST SPECIAL_ITEMS = map, helmet, chainmail

VAR COMBAT_SKILL = 0
VAR ENDURANCE = 0
VAR PROFFICIENCY = ()
VAR HANDS = ()
VAR MEALS = 0
VAR GP = 0

CONST MAX_WEAPONS = 2
CONST MAX_BACKPACK = 8
CONST MAX_GP = 50

# CLEAR
<h1>The Game Rules</h1>
<h2>Basics</h2>
You keep a record of your adventure on the Action Chart.

During your training as a Kai Lord you have developed fighting prowess — {PCS("COMBAT SKILL")} and physical stamina — {PE("ENDURANCE")}. Before you set off on your adventure you need to measure how effective your training has been.

- * [Roll the pencil]
    ~ COMBAT_SKILL = RANDOM(0, 9) + 10
    The first number that you pick is {PCS(COMBAT_SKILL)}, and it represents your {PCS("COMBAT SKILL")}. When you fight, your {PCS("COMBAT SKILL")} will be pitted against that of your enemy. A high score in this section is therefore very desirable.

- * [{RollSyn()}]
    ~ ENDURANCE = RANDOM(0, 9) + 20
    The second number that you pick is {PE(ENDURANCE)}, and it represents your powers of {PE("ENDURANCE")}.
    
    If you are wounded in combat you will lose {PE("ENDURANCE")} points. If at any time your {PE("ENDURANCE")} points fall to zero or below, you are dead and the adventure is over. Lost {PE("ENDURANCE")} points can be regained during the course of the adventure, but your number of {PE("ENDURANCE")} points can never go above the number with which you start your adventure.

- * [Learn disciplines] -> disciplines






== disciplines == //--------------------------------------------------------------------------------------------------------------------------
<h2>Kai Disciplines</h2>
Over the centuries, the Kai monks have mastered the skills of the warrior. These skills are known as the Kai Disciplines, and they are taught to all Kai Lords. You have learnt only five of the skills listed below. The choice of which five skills these are, is for you to make. As all of the Disciplines may be of use to you at some point on your perilous quest, pick your five with care. The correct use of a Discipline at the right time can save your life.

-(choice_loop)
{ LIST_COUNT(DISCIPLINES) == 5:
    
    
    If you successfully complete the mission as set in Book 1 of <em>Lone Wolf</em>, you may add a further Kai Discipline of your choice to your Action Chart in Book 2. This additional skill, together with your five other skills and any Special Items that you have picked up in Book 1, may then be used in the next adventure of the <em>Lone Wolf</em> series which is called <em>Fire on the Water</em>.
    
    -> choose_equipment
- else:
    ~ temp dleft = 5 - LIST_COUNT(DISCIPLINES)
    {dleft < 5: <>} You {~must|should|need to|have to|are required to} learn {NumToWords(dleft)} { dleft < 5:{~more|additional|extra|other|further}} discipline{dleft!=1:s}.
}

-
+ {DISCIPLINES !? camo} [Camouflage]
    <h3>Camouflage</h3>
    This Discipline enables a Kai Lord to blend in with his surroundings. In the countryside, he can hide undetected among trees and rocks and pass close to an enemy without being seen. In a town or city, it enables him to look and sound like a native of that area, and can help him to find shelter or a safe hiding place.
    -> learn(camo, "")

+ {DISCIPLINES !? hunt} [Hunting]
    <h3>Hunting</h3>
    This skill ensures that a Kai Lord will never starve in the wild. He will always be able to hunt for food for himself except in areas of wasteland and desert. The skill also enables a Kai Lord to be able to move stealthily when stalking his prey.
    -> learn(hunt, "No need for a Meal when instructed to eat.")

+ {DISCIPLINES !? sixs} [Sixth Sense]
    <h3>Sixth Sense</h3>
    This skill may warn a Kai Lord of imminent danger. It may also reveal the true purpose of a stranger or strange object encountered in your adventure.    
    -> learn(sixs, "")

+ {DISCIPLINES !? track} [Tracking]
    <h3>Tracking</h3>
    This skill enables a Kai Lord to make the correct choice of a path in the wild, to discover the location of a person or object in a town or city and to read the secrets of footprints or tracks.
    -> learn(track, "")

+ {DISCIPLINES !? heal} [Healing]
    <h3>Healing</h3>
    This Discipline can be used to restore {PE("ENDURANCE")} points lost in combat. If you possess this skill you may restore {PE("1 ENDURANCE")} point to your total for every numbered section of the book you pass through in which you are not involved in combat. (This is only to be used after your {PE("ENDURANCE")} has fallen below its original level.) Remember that your {PE("ENDURANCE")} cannot rise above its original level.
    -> learn(heal, "{PE("+1 ENDURANCE")} point for each section without combat.")

+ {DISCIPLINES !? weap} [Weaponskill]
    <h3>Weaponskill</h3>
    Upon entering the Kai Monastery, each initiate is taught to master one type of weapon. When you enter combat carrying this weapon, you add {PCS("2")} points to your {PCS("COMBAT SKILL")}.
    
    The fact that you are skilled with a weapon does not mean you set out on the adventure carrying that particular weapon. However, you will have opportunities to acquire weapons in the course of your adventures. (This will be explained fully in the Equipment section.)
    
    You cannot carry more than 2 weapons.
    -> learn_weap

+ {DISCIPLINES !? mshld} [Mindshield]
    <h3>Mindshield</h3>
    The Darklords and many of the evil creatures in their command have the ability to attack you using their Mindforce. The Kai Discipline of Mindshield prevents you from losing any {PE("ENDURANCE")} points when subjected to this form of attack.
    -> learn(mshld, "No points lost when attacked by Mindblast.")

+ {DISCIPLINES !? mblst} [Mindblast]
    <h3>Mindblast</h3>
    This enables a Kai Lord to attack an enemy using the force of his mind. It can be used at the same time as normal combat weapons and adds two extra points to your {PCS("COMBAT SKILL")}. Not all the creatures encountered on this adventure will be harmed by Mindblast. You will be told if a creature is immune.
    -> learn(mblst, "{PCS("+2 COMBAT SKILL")} points.")

+ {DISCIPLINES !? akin} [Animal Kinship]
    <h3>Animal Kinship</h3>
    This skill enables a Kai Lord to communicate with some animals and to be able to guess the intentions of others.
    -> learn(akin, "")

+ {DISCIPLINES !? mom} [Mind Over Matter]
    <h3>Mind Over Matter</h3>
    Mastery of this Discipline enables a Kai Lord to move small objects with his powers of concentration.
    -> learn(mom, "")

= learn(dis, flavor)
+ [Learn {PD(dis)}]
    ~ DISCIPLINES += dis
    You {~have learned|are now familiar with|can now use|now know} {PD(dis)}. {flavor != "": {flavor}}
    -> choice_loop
+ [Reconsider]
    -> choice_loop
    
= learn_weap
+ [Learn {PD(weap)}]
    ~ temp w = RollWeapon()
    ~ DISCIPLINES += weap
    ~ PROFFICIENCY += w

    You {~have learned|are now familiar with|can now use|now know} {PD(weap)} in {W2N(w)}. {PCS("+2 COMBAT SKILL")} points if this weapon carried.

    { w == axe: You are lucky enough to be skilled in the one weapon Lone Wolf is carrying from the start of the adventure. }

    {W2I(w)}

    -> choice_loop
+ [Reconsider]
    -> choice_loop





-(choose_equipment) * [Choose your equipment] -> equipment
== equipment == //-----------------------------------------------------------------------------------------------------------------------
<h2>Equipment</h2>
You are dressed in the green tunic and cloak of a Kai initiate. You have little with you to arm yourself for survival.

~ HANDS = (axe)
~ MEALS = 1
All you possess is an Axe and a Backpack containing 1 Meal.
* [{RollSyn()}]
-
~ GP = RANDOM(0, 9)
Hanging from your waist is a{GP==0:n empty} leather pouch containing {GP>0:{GP}|no} Gold Crown{GP!=1:s}.

-
~ SPECIAL_ITEMS = (map)
You discover amongst the smoking ruins of the monastery, a Map of Sommerlund showing the capital city of Holmgard and the land of Durenor, far to the east. You place the Map inside your tunic for safety.

* [{RollSyn()}]
- You also find <>

{ RANDOM(0, 9):
- 0: ~ HANDS += bsword
    Broadsword (Weapons){GetProfDesc(bsword)}.
    # IMAGE : img/bsword.png
- 1: ~ HANDS += sword
    Sword (Weapons){GetProfDesc(sword)}.
    # IMAGE : img/sword.png
- 2: ~ SPECIAL_ITEMS += helmet
    ~ ENDURANCE += 2
    Helmet (Special Items). This adds {PE("2 ENDURANCE")} points to your total.
    # IMAGE : img/helmet.png
- 3: ~ MEALS += 2
    Two Meals (Meals).
    # IMAGE : img/food.png
- 4: ~ SPECIAL_ITEMS += chainmail
    ~ ENDURANCE += 4
    Chainmail Waistcoat (Special Items). This adds {PE("4 ENDURANCE")} points to your total.
    # IMAGE : img/mail.png
- 5: ~ HANDS += mace
    Mace (Weapons){GetProfDesc(mace)}.
    # IMAGE : img/mace.png
- 6: ~ BACKPACK_ITEMS += hp
    Healing Potion (Backpack Item). This can restore {PE("4 ENDURANCE")} points to your total, when swallowed after combat. You only have enough for one dose.
    # IMAGE : img/potion.png
- 7: ~ HANDS += staff
    Quarterstaff (Weapons){GetProfDesc(staff)}.
    # IMAGE : img/qstaff.png
- 8: ~ HANDS += spear
    Spear (Weapons){GetProfDesc(spear)}.
    # IMAGE : img/spear.png
- 9: GP += 12
    12 Gold Crowns (Belt Pouch).
    # IMAGE : img/pouch.png
}
* [Next]

/*
- <h3>How to Carry Equipment</h3
Now that you have your equipment, the following list shows you how it is carried.
<ul>\
<li>Weapons — carried in the hand.</li>\
<li>Helmet — worn on the head.</li>\
<li>Chainmail Waistcoat — worn on the body.</li>\
<li>Backpack Items — carried in the Backpack.</li>\
<li>Gold Crowns — carried in the Belt Pouch.</li>\
</ul>
*/

- <h3>How Much Can You Carry?</h3>
- (hmtc)
* [Weapons] The maximum number of weapons that you may carry is {NumToWords(MAX_WEAPONS)}. {RightNowSyn(GetWeaponCount())}.
* Backpack Items[] must be stored in your Backpack. Because space is limited, you may only keep a maximum of {NumToWords(MAX_BACKPACK)} articles, including Meals, in your Backpack at any one time. {RightNowSyn(GetTotalBackpack())}.
* Special Items[] are not carried in the Backpack. When you discover a Special Item, you will be told how to carry it.
* Gold Crowns[] are always carried in the Belt Pouch. It will hold a maximum of {NumToWords(MAX_GP)} crowns. {RightNowSyn(GP)}.
* Food[] is carried in your Backpack. Each Meal counts as one item. {RightNowSyn(MEALS)}.
- {hmtc < 5: -> hmtc}

Any item that may be of use and can be picked up on your adventure and entered on your Action Chart is given capital letters in the text. Unless you are told it is a Special Item, carry it in your Backpack.

<h3>How to Use Your Equipment</h3>
- (htuye)
* Weapons[] aid you in combat. If you have the Kai Discipline of Weaponskill and the correct weapon, it adds {PCS("2")} points to your {PCS("COMBAT SKILL")}. If you enter a combat with no weapons, deduct {PCS("4")} points from your {PCS("COMBAT SKILL")} and fight with your bare hands. If you find a weapon during the adventure, you may pick it up and use it. (Remember you can only carry {NumToWords(MAX_WEAPONS)} Weapons at once.) You may only use one Weapon at a time in combat.

* [Backpack Items] During your travels you will discover various useful items which you may wish to keep. (Remember you can only carry {NumToWords(MAX_BACKPACK)} items in your Backpack at once.) You may exchange or discard them at any point when you are not involved in combat.

* [Special Items] Each Special Item has a particular purpose or effect. You may be told this when the item is discovered, or it may be revealed to you as the adventure progresses.

* [Gold Crowns] The local currency is the Crown, which is a small gold coin. Gold Crowns can be used on your adventure to pay for transport, food, or even as a bribe! Many of the creatures that you will encounter possess Gold Crowns, or have them hidden in their lairs. Whenever you kill a creature, you may take any Gold Crowns that it has and put them in your Belt Pouch.

* [Food] You will need to eat regularly during your adventure. {DISCIPLINES ? hunt:You have chosen the Kai Discipline of Hunting as one of your five skills, thus you will not need to tick off a Meal when instructed to eat.|If you do not have any food when you are instructed to eat a Meal, you will lose {PE("3 ENDURANCE")} points.}

* Healing Potion[] can restore {PE("4 ENDURANCE")} points to your total when swallowed after combat. It cannot be used to increase {PE("ENDURANCE")} points immediately prior to a combat. There is only enough for one dose. If you discover any other potions during the adventure, you will be told then of their effect. All Healing Potions are Backpack Items.

- {htuye < 6: -> htuye}

























* [Kai Wisdom] -> kai_wisdom