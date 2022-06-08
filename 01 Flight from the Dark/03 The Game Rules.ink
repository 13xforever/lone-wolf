== game_rules ==
LIST DISCIPLINES = camo, hunt, sixs, track, heal, weap, mshld, mblst, akin, mom
LIST WEAPONS = dagger, spear, mace, ssword, hammer, sword, axe, staff, bsword
LIST ITEMS = backpack

VAR COMBAT_SKILL = 0
VAR ENDURANCE = 0
VAR PROFFICIENCY = ()
VAR INVENTORY = (axe, backpack)
VAR MEAL = 1
VAR GP = 0

# CLEAR
<h1>The Game Rules</h1>
<h2>Basics</h2>
You keep a record of your adventure on the Action Chart.

During your training as a Kai Lord you have developed fighting prowess — {PCS("COMBAT SKILL")} and physical stamina — {PE("ENDURANCE")}. Before you set off on your adventure you need to measure how effective your training has been.

- * [Roll the pencil]
    ~ COMBAT_SKILL = RANDOM(0, 9) + 10
    The first number that you pick is {PCS(COMBAT_SKILL)}, and it represents your {PCS("COMBAT SKILL")}. When you fight, your {PCS("COMBAT SKILL")} will be pitted against that of your enemy. A high score in this section is therefore very desirable.

- * [Roll the pencil {~again|once more|one more time}]
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
    
    * [Choose your equipment] -> equipment
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






== equipment == //-----------------------------------------------------------------------------------------------------------------------
<h2>Equipment</h2>
You are dressed in the green tunic and cloak of a Kai initiate. You have little with you to arm yourself for survival.

- * [Roll the pencil]
    ~ GP = RANDOM(0, 9)

All you possess is an Axe and a Backpack containing 1 Meal. Hanging from your waist is a{GP==0:n empty} leather pouch containing {GP>0:{GP}|no} Gold Crown{GP!=1:s}.

-
* [Kai Wisdom] -> kai_wisdom