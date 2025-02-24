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
#1004
RW - Mob Response to Socials~
0 c 100
*~
* say Trigger activated!
if %self.alias% /= %arg%
*  say I'm the target!
*  say the command is %cmd%!
  switch %cmd%
  case aim
    %echo% %actor.name% points their weapon at %self.alias%.
    wait 1 sec
    say Are you threatening me?
    glare %actor.name%
    break
  case battlecry
    %echo% %actor.name% gives a blood-curdling warcry towards %self.alias%.
    wait 1 sec
    say So rude.
    giggle %actor.name%
    break
  case growl
    %echo% %actor.name% growls menacingly at %self.alias%.
    wait 1 sec
    say How dare you gowl at me!
    frown %actor.name%
    break
  case hate
    %echo% %actor.name% stares at %self.alias%, eyes burning with hate.
    wait 1 sec
    say Don't be a hater!
    tongue %actor.name%
    break
  case hiss
    %echo% %actor.name% hisses at %self.alias%, trying to scare them.
    wait 1 sec
    say Wow, you are creepy.
    ignore %actor.name%
    break
  case howl
    %echo% %actor.name% howls at %self.alias%.
    wait 1 sec
    say Are you mental?
    lol %actor.name%
    break
  case roar
    %echo% %actor.name% ROARS aggressively at %self.alias%.
    emote leans away from %actor.name%
    wait 1 sec
    say Just calm down, you!
    lol %actor.name%
    break
  case swear
    %echo% %actor.name% swears at %self.alias% profanely.
    blush
    wait 1 sec
    say What language!
    wince %actor.name%
    break
  done
else
  * Do nothing
end
return 0
~
#1005
RW - Mob Greeting Trigger~
0 g 100
~
* Mob Greeting Trigger, want to have one trigger that covers all mobs in zone 10
* and only fires if they are in their normal room.
*
* Innkeeper
if %self.vnum% == 1012 && %self.room.vnum% == 1012 && %actor.is_pc%
  switch %random.4%
    case 1
      wait 1 sec
      emote stops dusting.
      break
    case 2
      wait 1 sec
      emote closes guest register.
      break
    case 3
      wait 1 sec
      emote checks some settings at a control bank and turns around.
      break
    case 4
      wait 1 sec
      emote stands at the reception desk.
      break
    default
      * Nothing
  done
  if %time.hour% > 0 && %time.hour% < 12
    wait 2 sec
    say Good morning to you.
  elseif %time.hour% > 12 && %time.hour% < 18
    wait 2 sec
    say Hello, good afternoon.
  elseif %time.hour% > 18
    wait 2 sec
    say Good evening.
  else
    wait 2 sec
    say Hello, welcome to the Inn.
  end
  wait 3 sec
  say Use @1help renting@n for information about using the Inn.
* Postmaster
elseif %self.vnum% == 1013 && %self.room.vnum% == 1013 && %actor.is_pc%
  switch %random.3%
    case 1
      wait 1 sec
      emote looks up from a pile of paperwork.
      break
    case 2
      wait 1 sec
      emote turns away from a control station.
      break
    case 3
      wait 1 sec
      emote is standing at the counter, looking at a sheet of stamps.
      break
    default
      * Nothing
  done
  if %time.hour% > 0 && %time.hour% < 12
    wait 2 sec
    say Good morning.
  elseif %time.hour% > 12 && %time.hour% < 18
    wait 2 sec
    say Good afternoon.
  elseif %time.hour% > 18
    wait 2 sec
    say Good evening.
  else
    wait 2 sec
    say Hello.
  end  
  wait 3 sec
  say Use @1help mail@n for instructions on sending and receiving mail.
* Waiter
elseif %self.vnum% == 1018 && %self.room.vnum% == 1018 && %actor.is_pc%
  switch %random.2%
    case 1
      wait 1 sec
      emote walks up from behind the Maitre'D podium.
      break
    case 2
      wait 1 sec
      emote gives a polite cough.
      break
    default
      * Nothing
  done
  if %time.hour% > 0 && %time.hour% < 12
    wait 2 sec
    say Good morning, and welcome to RouseWorld Restaurant.
  elseif %time.hour% > 12 && %time.hour% < 18
    wait 2 sec
    say Good afternoon, welcome to Rouseworld Restaurant.
  elseif %time.hour% > 18
    wait 2 sec
    say Good evening ... welcome to Rouseworld Restaurant.
  else
    wait 2 sec
    say Welcome to Rouseworld Restaurant.
  end
  wait 3 sec
  say Please have a seat wherever you like.
  wait 2 sec
  say Use @1list@n to see a menu.
* Bartender
elseif %self.vnum% == 1019 && %self.room.vnum% == 1019 && %actor.is_pc%
  switch %random.2%
    case 1
      wait 1 sec
      emote looks up while polishing a glass.
      wait 2 sec
      say What will you be drinking?
      break
    case 2
      wait 1 sec
      emote pauses while cleaning the bar with a towel.
      wait 2 sec
      say What'll it be?
      break
    default
      * Nothing
  done
  wait 3 sec
  say Use @1list@n to see our drink menu.
else
  * Nothing
end
~
#1019
RW - Bartener Droid Random Speach and Emotes~
0 b 25
~
* Mobile Random - Bartender droid actions and speach, based on position
* Positions: Sleeping, Resting, Sitting, Fighting, Standing (Looks like Mortally Wounded works as well)
* Maybe add in a check for sleeping mobs/pcs for the sleeping quote
if %self.pos% == Standing
    * Things to do if in normal position
    switch %random.4%
        case 1
            emote is polishing a glass.
            wait 3 sec
            emote stops polishing and stares into the distance.
            wait 8 sec
            emote looks down at the glass.
            emote places the glass back behind the bar.
        break
        case 2
            emote starts pulling down bottles, glasses and equipment.
            wait 8 sec
            emote begins pouring and mixing a drink of some kind.
            wait 8 sec
            emote looks at the drink it just made.
            sigh
            wait 3 sec
            emote pours the drink down drain.
            emote puts up the bottles and equipment.
        break
        case 3
            emote starts pulling down bottles, glasses and equipment.
            wait 8 sec
            emote begins pouring and mixing a drink of some kind.
            wait 8 sec
            %echo% There is a BANG as the drink suddenly goes up in a little smoky fireball.
            wait 4 sec
            sigh
            wait 3 sec
            emote throws the glass in the trash.
            emote puts up the bottles and equipment.
        break
        case 4
            switch %random.6%
                case 1
                    say I laughed at a man with no pants ... 
                    wait 3 sec
                    say Until I realized I have no legs.
                break
                case 2
                    say They say time heals all wounds.
                break
                case 3
                    say Humans. Can't live with them ...
                    wait 2 sec
                    say Can't live without them.
                break
                case 4
                    say Always do sober what you said you'd do drunk.
                    wait 2 sec
                    say That will teach you to keep your mouth shut.
                break
                case 5
                    say The problem with the world is ...
                    say That everyone is a few drinks behind.
                break
                case 6
                    say The hard part about being a bartender ...
                    say Is figuring out who is drunk ...
                    wait 2 sec
                    say And who is just stupid.
                break
        break
        default
            emote is wiping down the bar and quietly beeping to itself.
        break
    done
elseif %self.pos% == Fighting
        default
            * Do nothing
        break
    done
else
    * Things to do if not Standing or Fighting
    break
end
~
$~
