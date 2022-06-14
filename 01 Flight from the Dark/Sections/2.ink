== s2 ==
As you dash through the thickening trees, the shouts of the Giaks begin to fade behind you. You have nearly outdistanced them completely, when you crash headlong into a tangle of low branches.

+ [RolSyn()]
    {RANDOM(0, 9) < 5:
        -> Heal(-> s343)
    - else:
        -> Heal(-> s276)
    }
