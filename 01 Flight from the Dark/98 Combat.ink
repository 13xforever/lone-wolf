== FightWith(name, cs, ep, mb_immune, cs_mod, -> on_win)
<h2>{~Encounter|Fight|Combat|Battle|Clash} with {name}</h2>
//~ HANDS = ()
~ temp active_weapon = hands
~ temp wc = GetWeaponCount()

Your {PCS("COMBAT SKILL")} is {PCS(COMBAT_SKILL)}, and your {PE("ENDURANCE")} is {PE(ENDURANCE)}. {wc > 1:You hold {wc} weapons.}
Enemy {PCS("COMBAT SKILL")} is {PCS(cs)}, and {PE("ENDURANCE")} is {PE(ep)}.
{
- cs_mod < 0: <> Your {PCS("COMBAT SKILL")} is reduced by {-cs_mod} point{cs_mod < -1:s}.
- cs_mod > 0: <> Your {PCS("COMBAT SKILL")} is increased by {cs_mod} point{cs_mod > 1:s}.
}

{ wc:
- 0:
    Unfortunately, you do not have any weapons ({PCS("-4 COMBAT SKILL")}).
    -> wow
- 1:
    ~ active_weapon = LIST_MIN(HANDS)
    -> ww
}
* {wc == 2} [Fight with {GetWeaponNameWithBonusDesc(LIST_MIN(HANDS))}]
    ~ active_weapon = LIST_MIN(HANDS)
* {wc == 2} [Fight with {GetWeaponNameWithBonusDesc(LIST_MAX(HANDS))}]
    ~ active_weapon = LIST_MAX(HANDS)
- (ww)
{wc > 0:You fight with {GetWeaponNameWithBonusDesc(active_weapon)}.}
- (wow)

{(DISCIPLINES ? mblst) and (not mb_immune):<> Your {D2N(mblst)} gives you {PCS("+2 COMBAT SKILL")}.}

~ temp ecs = GetTotalCombatSkill(mb_immune, active_weapon)
~ temp cr = ecs - cs
~ temp lw_dam = 0
~ temp e_dam = 0
~ temp rng = 0
~ temp round = 1
Effective {PCS("COMBAT SKILL")}: {PCS(ecs)}, Combat Ratio: {cr>0:+}{cr}
~ cr = ClampAndRed(cr)

- (loop)
<h3>Round {round}</h3>
+ [{RollSyn()}]
-
~ rng = RANDOM(0, 9)
~ e_dam = GetEnemyDam(cr, rng)
~ lw_dam = GetLwDam(cr, rng)
~ ep -= e_dam
~ ENDURANCE -= lw_dam

TODO : check for 0 damage and more flair
{~Enemy|{name}} hits you for {PE(lw_dam)} points, and you hit {~it|{name}|enemy} back for {PE(e_dam)} points.
{ ENDURANCE < 1:
    -> Game_Over
- else:
    {~You’re left with|You have} {PE(ENDURANCE)} points.
}
{ ep < 1:
    You defeat {~the enemy|{name}}.
    -> on_win
- else:
    <> {~The enemy|{name}} {~yet lives|survives} with {PE(ep)} points.
}
~ round++
-> loop









== function GetTotalCombatSkill(mb_immune, active_weapon)
~ temp result = COMBAT_SKILL

{ active_weapon:
- hands: ~ result -= 4
- else:
    { PROFFICIENCY ? active_weapon:
        ~ result += LIST_COUNT(PROFFICIENCY ) * 2
    }
}
{ (DISCIPLINES ? mblst) and (not mb_immune):
    ~ result += 2
}
~ return result

== function ClampAndRed(v)
{
- v < 0: ~ return Clamp((v-1)/2, -6, 0)
- v > 0: ~ return Clamp((v+1)/2, 0, 6)
- else: ~ return 0
}

== function ZeroToTen(v)
{ v:
- 0: ~ return 10
- else: ~ return v
}

== function GetEnemyDam(cr, rng)
~ rng = ZeroToTen(rng)
~ temp s = cr + rng
{
- s < 11: ~ return Clamp(s + 2, 0, 12)
- s < 14: ~ return (s - 4) * 2
- else: ~ return 9999
}

== function GetLwDam(cr, rng)
{ rng:
- 0: ~ return 0
- 9: {
    - cr > -4: ~ return 0
    - else   : ~ return Clamp(-cr-2, 2, 3)
    }
- 8: {
    - cr > -1: ~ return 0
    - else: ~ return Clamp(-cr-1, 1, 4)
    }
- 7: {
    - cr > 2: ~ return 0
    - cr > -1: ~ return 1
    - else: ~ return Clamp(-cr, 2, 5)
    }
- 6: {
    - cr > 2: ~ return 1
    - cr > -2: ~ return 2
    - else: ~ return Clamp(1-cr, 3, 6)
    }
- 5: {
    - cr > 5: ~ return 1
    - cr > -1: ~ return 2
    - cr == -1: ~ return 3
    - else: ~ return Clamp(1-cr, 4, 7)
    }
- 4: {
    - cr > 1: ~ return 2
    - cr > -1: ~ return 3
    - else: ~ return Clamp(2-cr, 4, 8)
    }
- 3: {
    - cr > 3: ~ return 2
    - cr > 0: ~ return 3
    - cr > -2: ~ return 4
    - else: ~ return Clamp(2-cr, 5, 8)
    }
- 2: {
    - cr > 5: ~ return 2
    - cr > 1: ~ return 3
    - cr > -1: ~ return 4
    - cr > -6: ~ return Clamp(3-cr, 5, 8)
    - else: ~ return 9999
    }
- 1: {
    - cr > 4: ~ return 3
    - cr > 1: ~ return 4
    - cr > -2: ~ return 5
    - cr > -4: ~ return 6
    - cr == -4: ~ return 8
    - else: ~ return 9999
    }
}