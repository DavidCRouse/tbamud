#1001
RW - Droid death load parts~
0 f 80
~
* Instead (or maybe in addition to) carrying coins, after death a droid may have
* usable parts as inventory items. The value and number of parts depends on the
* droid's level. We will have a list of parts by value and then have a percent
* chance by droid level of dropping that item.
* Parts:
* 1003 - Very minor droid part: a port or manipulator ring/sleeve - 1g/1w
* 1004 - Minor droid part: small actuator - 2g/1w
* 1005 - Minor droid part: small manipulator - 2g/1w
* 1006 - Minor droid part: small sensor - 2g/1w
* 1007 - Minor droid part: small logic module - 2g/1w
* 1008 - Droid part: actuator - 15g/5w
* 1009 - Droid part: manipulator - 15g/5w
* 1010 - Droid part: sensor - 15g/5w
* 1011 - Droid part: logic module - 15g/3w
* 1012 - Droid part: large actuator assembly - 40g/10w
* 1013 - Droid part: large manipulator assembly - 40g/10w
* 1014 - Droid part: large logic module assembly - 40g/10w
if %self.level% <= 3
    switch %random.9%
        case 1
            %load% obj 1003
        break
        case 2
            %load% obj 1003
        break
        case 3
            %load% obj 1003
        break
        case 4
            %load% obj 1003
            %load% obj 1004
        break
        case 5
            %load% obj 1005
            %load% obj 1006
        break
        case 6
            %load% obj 1007
            %load% obj 1008
        break
        case 7
            %load% obj 1009 
        break
        case 8
            %load% obj 1010 
        break
        case 9
            %load% obj 1011 
        break
        default
            * Sorry, charlie, nothing
        break
    done
elseif %self.level% >= 4 && %self.level% <= 10
    switch %random.9%
        case 1
            %load% obj 1004
        break
        case 2
            %load% obj 1004
        break
        case 3
            %load% obj 1004
        break
        case 4
            %load% obj 1004
            %load% obj 1005
        break
        case 5
            %load% obj 1006
            %load% obj 1007
        break
        case 6
            %load% obj 1008
            %load% obj 1009
        break
        case 7
            %load% obj 1010 
        break
        case 8
            %load% obj 1011 
        break
        case 9
            %load% obj 1012 
        break
        default
            * Sorry, charlie, nothing
        break
    done
elseif %self.level% >= 11 && %self.level% <= 20
    switch %random.9%
        case 1
            %load% obj 1005
        break
        case 2
            %load% obj 1005
        break
        case 3
            %load% obj 1005
        break
        case 4
            %load% obj 1005
            %load% obj 1006
        break
        case 5
            %load% obj 1007
            %load% obj 1008
        break
        case 6
            %load% obj 1009
            %load% obj 1010
        break
        case 7
            %load% obj 1011 
        break
        case 8
            %load% obj 1012 
        break
        case 9
            %load% obj 1013 
        break
        default
            * Sorry, charlie, nothing
        break
    done
elseif %self.level% >= 21 && %self.level% <= 30
    switch %random.9%
        case 1
            %load% obj 1006
        break
        case 2
            %load% obj 1006
        break
        case 3
            %load% obj 1006
        break
        case 4
            %load% obj 1006
            %load% obj 1007
        break
        case 5
            %load% obj 1008
            %load% obj 1009
        break
        case 6
            %load% obj 1010
            %load% obj 1011
        break
        case 7
            %load% obj 1012 
        break
        case 8
            %load% obj 1013 
        break
        case 9
            %load% obj 1014 
        break
        default
            * Sorry, charlie, nothing
        break
    done
else
    * Should be no levels greater than 30, right?
done
~
#1002
RW - Mouse Droid Emotes~
0 bg 50
~
* Mobile Random - Little mouse droid actions and sounds, based on position
* Positions: Sleeping, Resting, Sitting, Fighting, Standing (Looks like Mortally Wounded works as well)
if %self.pos% == Standing
    * Things to do if in normal position
    switch %random.4%
        case 1
            emote is rolling slowly backward, whistling something complicated.
        break
        case 2
            emote is zipping around the room, as if looking for something.
        break
        case 3
            emote is silently rolling across the room.
        break
        case 4
            emote is beeping and whistling quietly as it rolls across the room.
        break
        default
            emote is still and softly whistling and beeping.
        break
    done
elseif %self.pos% == Fighting
    switch %random.4%
        case 1
            emote is flicking it's tiny, sharp probe arm as it tries to attack.
        break
        case 2
            emote is whistling shrilly as it tries to defend itself.
        break
        case 3
            %zoneecho% %self.vnum% A droid alarm call bleets out. 
        break
        case 4
            * Do nothing 
        break
        default
            * Do nothing
        break
    done
else
    * Things to do if not Standing or Fighting
    break
end
~
#1003
RW - Mob Morale Check on Death~
0 f 100
~
* Run check on mob death, tally total mob levels versus PC levels and assign
* probability of the remaining mobs fleeing. The levels of Mobs that aren't 
* fighting should not be counted and they shouldn't be forced to flee.
* Using code from the "while damage" example tigger to loop through the fight
set room_var %actor.room%
set target_char %room_var.people%
set pclevels 0
set moblevels 0
set mobcount 0
set runaway 0
* Now loop through everyone fighting (and visible) to get MOB and PC total levels
while %target_char%
  * Set the next target before this one perhaps dies.
  set tmp_target %target_char.next_in_room%
  * PCs level totals
  if %target_char.canbeseen% && %target_char.is_pc% && %target_char.fighting%
    eval pclevels (%pclevels% + %target_char.level%)
  * Mob level totals
  elseif !%target_char.is_pc% && %target_char.fighting%
    eval moblevels (%moblevels% + %target_char.level%)
    eval mobcount (%mobcount% + 1)
  end
  * Set the next target.
  set target_char %tmp_target%
  * Loop back.
done
* Compare total mob levels fighting versus PC levels fighting to determine
* if mobs will flee
if (%moblevels% - %pclevels%) > 4
  if %mobcount% > 1
    %echo% Your foes seem confident they will defeat you!
  else
    %echo% Your foe seems confident they will defeat you!
  end
elseif ((%moblevels% - %pclevels%) >= 2) && ((%moblevels% - %pclevels%) <= 4)
  if %mobcount% > 1
    %echo% Your foes fight well.
  else
    %echo% Your foe fights well.
  end
elseif %moblevels% == 0
  * They are all dead!
elseif ((%moblevels% - %pclevels%) >= 0) && ((%moblevels% - %pclevels%) <= 1)
  if %mobcount% > 1
    %echo% You and your foes seem well matched.
  else
    %echo% You and your foe seem well matched.
  end
elseif ((%moblevels% - %pclevels%) <= -1) && ((%moblevels% - %pclevels%) >= -2)
  switch %random.2%
    case 1
      * Time to bolt
      set runaway 1
      if %mobcount% > 1
        %echo% Your foes cast grim glances at their fallen comrades.
      else
        %echo% Your foe casts grim glances at their fallen comrades.
      end
      break
    case 2
      * Maybe hang in one more round
      if %mobcount% > 1
        %echo% Your foes cast uneasy glances at their fallen comrades.
      else
        %echo% Your foe casts uneasy glances at their fallen comrades.
      end
      break
    default
      * Shouldn't reach
  done
elseif ((%moblevels% - %pclevels%) <= -3)
  if %mobcount% > 1
    %echo% Your foes seem panicked by your ferocity in combat!
  else
    %echo% Your foe seems panicked by your ferocity in combat!
  end
  set runaway 1
end
* Now we want to loop through the mobs again and tell the demoralized mobs to flee
set room_var_2 %actor.room%
set target_char_2 %room_var_2.people%
while %target_char_2%
  * Set the next target before this one perhaps dies.
  set tmp_target_2 %target_char_2.next_in_room%
    if !%target_char_2.is_pc% && %target_char_2.fighting% && %runaway% == 1
      %force% %target_char_2% flee
    end
  * Set the next target.
  set target_char_2 %tmp_target_2%
  * Loop back.
done
~
$~
