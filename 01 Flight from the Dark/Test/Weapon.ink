== get_weapon_test(-> ret) ==
~ temp w = LIST_RANDOM(LIST_ALL(WEAPONS) - hands)
You see {I2N(w)}.

<- GetWeapon(w, ret)
+ [Return] -> ret