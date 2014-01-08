![Mersenne Twister](http://i.imgur.com/XBaL6fI.png)

Known Issues
===============

* Doesn't compile when the target is Flash.  (Push requests welcome)
* Float precision is based on the 32-bit implementation, not 53-bit.  Periods will be shorter.
* Java and Cs targets currently only support Single float precision.  (Double coming soon?!)
* IOS is untested, but should work.
* Initializing with the default seed __GetDate()__ is untested on Xna
