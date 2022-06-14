=== function ListWithCommas(list, if_empty)
{LIST_COUNT(list):
- 2:
    	{LIST_MIN(list)} and {ListWithCommas(list - LIST_MIN(list), if_empty)}
- 1:
    	{list}
- 0:
		{if_empty}
- else:
  		{LIST_MIN(list)}, {ListWithCommas(list - LIST_MIN(list), if_empty)}
}

=== function IsAre(list)
{LIST_COUNT(list) == 1:is|are}

=== function NumToWords(x) ===
{
    - x >= 1000:
        {NumToWords(x / 1000)} thousand { x mod 1000 > 0:{NumToWords(x mod 1000)}}
    - x >= 100:
        {NumToWords(x / 100)} hundred { x mod 100 > 0:and {NumToWords(x mod 100)}}
    - x == 0:
        zero
    - else:
        { x >= 20:
            { x / 10:
                - 2: twenty
                - 3: thirty
                - 4: forty
                - 5: fifty
                - 6: sixty
                - 7: seventy
                - 8: eighty
                - 9: ninety
            }
            { x mod 10 > 0:<>-<>}
        }
        { x < 10 || x > 20:
            { x mod 10:
                - 1: one
                - 2: two
                - 3: three
                - 4: four
                - 5: five
                - 6: six
                - 7: seven
                - 8: eight
                - 9: nine
            }
        - else:
            { x:
                - 10: ten
                - 11: eleven
                - 12: twelve
                - 13: thirteen
                - 14: fourteen
                - 15: fifteen
                - 16: sixteen
                - 17: seventeen
                - 18: eighteen
                - 19: nineteen
            }
        }
}

=== function PHTML(el, val)
<{el}>{val}</{el}>

=== function PCS(val)
{PHTML("combat_skill", val)}

=== function PE(val)
{PHTML("endurance", val)}

=== function PD(val)
{PHTML("discipline", "{D2N(val)}")}

=== function PIS(val)
{PHTML("item", val)}
=== function PI(val)
{PIS("{I2N(val)}")}


=== function D2N(val)
{ val:
- camo : Camouflage
- hunt : Hunting
- sixs : Sixth Sense
- track: Tracking
- heal : Healing
- weap : Weaponskill
- mshld: Mindshield
- mblst: Mindblast
- akin : Animal Kinship
- mom  : Mind Over Matter
- else : Unknown discipline {val}
}

=== function W2N(val)
{ val:
- dagger: Dagger
- spear : Spear
- mace  : Mace
- ssword: Short Sword
- hammer: Warhammer
- sword : Sword
- axe   : Axe
- staff : Quarterstaff
- bsword: Broadsword
- else  : Unknown weapon {val}
}

=== function I2N(val)
{ WEAPONS ? val:
    {W2N(val)}
- else:
    { val:
    // backpack items
    - hp: Healing Potion
    // special items
    - map:Map of Sommerlund
    - helmet: Helmet
    - chainmail: Chainmail Waistcoat
    - vordak_gem: Vordak Gem
    - else : Unknown item {val}
    }
}

=== function RollWeapon()
{ RANDOM(0, 9):
- 0: ~ return dagger
- 1: ~ return spear
- 2: ~ return mace
- 3: ~ return ssword
- 4: ~ return hammer
- 6: ~ return axe
- 8: ~ return staff
- 9: ~ return bsword
- else: ~ return sword
}

== function W2I(val)
{ val:
- dagger: # IMAGE: img/dagger.png
- spear : # IMAGE: img/spear.png
- mace  : # IMAGE: img/mace.png
- ssword: # IMAGE: img/ssword.png
- hammer: # IMAGE: img/warhammr.png
- sword : # IMAGE: img/sword.png
- axe   : # IMAGE: img/axe.png
- staff : # IMAGE: img/qstaff.png
- bsword: # IMAGE: img/bsword.png
- else  : Unknown weapon
}

== function KL2N(val)
{ val:
- 1: Novice
- 2: Intuite
- 3: Doan
- 4: Acolyte
- 5: Initiate
- 6: Aspirant
- 7: Guardian
- 8: Warmarn or Journeyman
- 9: Savant
- 10: Master
- else: Unknown Magnakai level {val}
}

== function GetProfDesc(val)
{PROFFICIENCY ? val:, which you’re {~profficient|intimately familiar|well accustomed|very handy} with}

== function GetTotalCombatSkill(mblast_resistant, active_weapon)
~ temp result = COMBAT_SKILL

{ GetWeaponCount():
- 0: ~ result -= 4
- else:
    { PROFFICIENCY ? active_weapon:
        ~ result += LIST_COUNT(PROFFICIENCY ) * 2
    }
}
{ (DISCIPLINES ? mblst) and (not mblast_resistant):
    ~ result += 2
}
~ return result

== function GetTotalBackpack()
~ return LIST_COUNT(BACKPACK_ITEMS) + MEALS

== function GetWeaponCount()
~ return LIST_COUNT(HANDS ^ WEAPONS)

== function HH()
{ENDURANCE < MAX_EP: ({PE("+1 ENDURANCE")})}

== Heal(-> next)
{ ENDURANCE < MAX_EP:
~ ENDURANCE++
You {~heal|recover|restore|mend|regenerate|get} {PE(1)} {PE("ENDURANCE")} point up to {PE(ENDURANCE)}.
}
-> next


== function RightNowSyn(val)
{~Right now|At {~the|this} {~moment|time}|At present|Presently} you {~have|carry} {val==0:none|{NumToWords(val)}}

== function RollSyn()
{~{~Roll|Drop|Flick|Jab|Tap|Twirl} the pencil|{~Consult|Peruse|Point at|Tap} the Random Number Table} {~|again|once {~again|more}|one more time}