== s20 ==
It seems that whoever lived here left in a great hurry — and they must have left quite recently. A half-eaten meal still remains on the table, and a mug of dark jala is still warm to the touch.

Searching a chest and small wardrobe, you find a Backpack, food (enough for {PIS("two Meals")}), and a {PI(dagger)}.

TODO : what about backpack
- (loop)
<- GetBackpackItem(hp, -> loop)
<- GetWeapon(dagger, -> loop)
+ [Continue]
-
You continue your mission.
-> Heal(-> s273)