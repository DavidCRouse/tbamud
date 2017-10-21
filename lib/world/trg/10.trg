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
$~
