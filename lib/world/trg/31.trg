#3101
Chat Trigger DR~
0 d 1
hello hey thanks weather eat meal drink sleep dump junk trash sewer who where what how a an the i and or me you~
* Specific, Random-ish and Random replies to PC's. NPC's can respond in limited way to each other
* Mobile speech trigger, numeric argument 1 so will respond to any of the argument words
* To try and ensure we get the NPC to respond, add "a an the i and or me you" to trigger arguments
* So this trigger argument set is: 
* hello hey thanks weather eat meal drink sleep dump junk trash sewer who where what how a an the i and or me you
* Don't set a trigger to '*' or the NPC reply, or they will never shut up
* We don't want and endless loop of NPCs talking to each other
if %actor.is_pc%
* Specific text to look for
* reminder to self -- '/=' Should be read like 'x contains substring y'
if (%speech% /= hello || %speech% /= hey)
wait 1 sec
say Um, yeah, hi.
break
elseif %speech% /= thanks
wait 1 sec
say No problem.
break
elseif %speech% /= weather
wait 1 sec
say The weather sure has been strange around here lately.
break
elseif (%speech% /= dump || %speech% /= junk/ || %speech% /= trash || %speech% /= sewer) 
wait 1 sec
say Just keep going south from Market Square.
say You'll smell it before you see it.
break
elseif (%speech% /= eat || %speech% /= meal || %speech% /= drink || %speech% /= sleep )
wait 1 sec
say Look for the Grubby Inn, on the east end of Poor Alley.
say That is a good place.
break
* More general text
elseif %speech% /= who 
wait 1 sec
say I don't think I know that person.
break
elseif %speech% /= where
wait 1 sec
say I'm not sure.
break
elseif %speech% /= what 
wait 1 sec
say Yeah, I don't know.
break
elseif %speech% /= how 
wait 1 sec
say I wish I knew.
break
* More random
else
eval max %random.4%
set  txt[1] Hmmm, you don't say?
set  txt[2] Yeah, ahhh.
set  txt[3] Right?
set  txt[4] I guess?
set  reply %%txt[%max%]%%
eval reply %reply%
say %reply%
end
~
$~
