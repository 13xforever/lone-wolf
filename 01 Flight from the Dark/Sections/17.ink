== s17 ==
You raise your weapon to strike at the beast as its razor-fanged mouth snaps shut just inches from your head. Buffeted by the beating of its wings you find it difficult to stand.

-> FightWith("Kraan", 16, 24, false, -1, -> after)

= after
You quickly descend the far side of the hill to avoid the Giaks.

+ [{RollSyn()}]
    ~ temp ch = RANDOM(0, 9)
    {
    - ch == 0: -> s53
    - ch < 3: -> s274
    - else: -> s316
    }
