== game_rules ==
VAR COMBAT_SKILL = 0
VAR ENDURANCE = 0
LIST DISCIPLINES = camo, hunt, sixs

# CLEAR
<h1>The Game Rules</h1>
<h2>Basics</h2>
You keep a record of your adventure on the Action Chart.

During your training as a Kai Lord you have developed fighting prowess — {PCS("COMBAT SKILL")} and physical stamina — {PE("ENDURANCE")}. Before you set off on your adventure you need to measure how effective your training has been.
-> roll_combat_skill

= roll_combat_skill
* [Roll the pencil]
    ~ COMBAT_SKILL = RANDOM(0, 9) + 10
    The first number that you pick is {PCS(COMBAT_SKILL)}, and it represents your {PCS("COMBAT SKILL")}. When you fight, your {PCS("COMBAT SKILL")} will be pitted against that of your enemy. A high score in this section is therefore very desirable.
    -> roll_endurance

= roll_endurance
* [Roll the pencil again]
    ~ ENDURANCE = RANDOM(0, 9) + 20
    The second number that you pick is {PE(ENDURANCE)}, and it represents your powers of {PE("ENDURANCE")}.
    
    If you are wounded in combat you will lose {PE("ENDURANCE")} points. If at any time your {PE("ENDURANCE")} points fall to zero or below, you are dead and the adventure is over. Lost {PE("ENDURANCE")} points can be regained during the course of the adventure, but your number of {PE("ENDURANCE")} points can never go above the number with which you start your adventure.
    -> go_disciplines

= go_disciplines
* [Learn disciplines...]
-> disciplines

== disciplines ==
<h2>Kai Disciplines</h2>
Over the centuries, the Kai monks have mastered the skills of the warrior. These skills are known as the Kai Disciplines, and they are taught to all Kai Lords. You have learnt only five of the skills listed below. The choice of which five skills these are, is for you to make. As all of the Disciplines may be of use to you at some point on your perilous quest, pick your five with care. The correct use of a Discipline at the right time can save your life.

-> choice_loop
= choice_loop
{ LIST_COUNT(DISCIPLINES) == 5:
    -> equipment
- else:
    ~ temp dleft = 5 - LIST_COUNT(DISCIPLINES)
    You should learn {NumToWords(dleft)} more discipline{dleft!=1:s}.
    -> pick
}
= pick
+ {DISCIPLINES !? camo} [Camouflage]
    <h3>Camouflage</h3>
    This Discipline enables a Kai Lord to blend in with his surroundings. In the countryside, he can hide undetected among trees and rocks and pass close to an enemy without being seen. In a town or city, it enables him to look and sound like a native of that area, and can help him to find shelter or a safe hiding place.
    -> learn(camo, "")
+ {DISCIPLINES !? hunt} [Hunting]
    <h3>Hunting</h3>
    This skill ensures that a Kai Lord will never starve in the wild. He will always be able to hunt for food for himself except in areas of wasteland and desert. The skill also enables a Kai Lord to be able to move stealthily when stalking his prey.
    -> learn(hunt, "No need for a Meal when instructed to eat.")
+ {DISCIPLINES !? sixs } [Sixth Sense]
    <h3>Sixth Sense</h3>
    This skill may warn a Kai Lord of imminent danger. It may also reveal the true purpose of a stranger or strange object encountered in your adventure.    
    -> learn(sixs, "")

= learn(dis, flavor)
+ [Learn {PD(dis)}]
    ~ DISCIPLINES += dis
    You {~have learned|are now familiar with|can now use|now know} {PD(dis)}. {flavor != "": {flavor}}
    <> -> choice_loop
+ [Reconsider]
    -> choice_loop

== equipment ==


-> kai_wisdom