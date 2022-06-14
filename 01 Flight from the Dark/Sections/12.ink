== s12 ==
The bodyguard looks at you with great suspicion and then slams the door shut. You can hear the sound of voices inside the caravan. Suddenly the door swings open and the face of a wealthy merchant appears.

He demands 10 Gold Crowns as payment for the ride.

+ {GP >= 10}You pay him[].
    ~ GP -= 10
    -> Heal(-> s262)
+ You do not {GP < 10:have enough Gold Crowns|wish to pay him}[]. -> Heal(-> s247)