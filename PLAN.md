# Planning


* Groundwork
    * Meetings - start, end, others? Text comms, via what channel?
        * Teams meeting to start and end
        * Need to figure out a way to share screens
        * 2:30 p.m. meeting end of day
        * send text number for instant comms
        * Future: Create channel in Teams - can we invite guest?
    * Initial paperwork bits - orientation, planning checklist - do we have this from Tony?
        * Tabled until we have the documents from Tony
    * Alt: phone text for attention
        * done
    * Use of AI - suggest no; require human explain/review; who owns code?
        * plan: generally no, can do reviews
        * plan: notify and track if ai gen code is used
    * Software
        * Godot (should agree on version - suggest 4.7.2 as latest stable)
            * agreed on this aspect
        * Git (suggest install from git-scm.com - standard git)
            * already in place - may be different than standard client
        * Github accounts for each person - then notify davidm to add to project
            * plan is to use onion-td
            * AsherBean - add as contributor
            * BowedMars374878 - add as contributor

* Design discussion
    * Clarification on basics:
        * Players place towers, which auto-fire at enemies when they are in range
        * Enemies move toward some goal; arrival there has negative results for player
    * Grid path vs. follow shape vs. ? for mobs
        * vote is for path solving, probably gridded, for mobs, rather than fixed path
        * could have environmental obstacles that exist
        * towers produce blocked grid cells
        * terrain that can't be placed? terrain that costs more?
        * could also check only at wave start
    * Theme?
        * Not strictly required but can provide some useful guiderails for what kinds of things we’re doing
        * fantasy, ranged, melee, sci-fi, chemistry, school, etc.
        * dictionary pages for random words
        * goal: discuss at afternoon meeting
    * Target input methods? Mouse? Target platforms? Web? Windows?
        * Suggest mouse to start
        * May investigate fancy input mapping in Godot (need doc link)
        * web, moble, desktop in Godot
        * get it working on one platform - desktop and mouse - can extend later
    * Grid vs. shape vs. set spot vs. ? for towers
        * based on mobs doing gridded pathing, we think towers are free grid placement
        * based on mobs, may have environmental costs or blockages
    * Waves: Fixed? Random seeded? Other? Multiple modes?
        * budget of strength that increases as time goes on
            * randomize units inside that
            * give player some info beforehand to map strategy
            * balancing will be more challenging in this approach
            * could let player know what wave will look like before start
            * could also let them know next N waves
        * seeded random - could display seed and/or allow player to input
            * could provide interesting behavior for cross player competition
    * Loss condition: Health? Money? Other?
        * Life counter - enemies may have differing amounts of damage they do
    * Currency gain: kills, mining, set per level, other? Multiple?
        * killing enemies provides currency
            * approximately should consider scaling currency gain with life damage
            * doesn't have to strictly go that way - could have low damage, high health, high currency mob
        * could also be currency generator towers of some form
    * Upgrade towers or buy new ones or both?
        * Non-tower upgrades (global lift)?
        * table this discussion for future
    * Real-time tower purchase, pause between waves, both, other?
        * allow both - allow purchase between waves, but some during
        * hero system - during wave can run around and attack
    * Can mobs attack towers or just life?
        * towers not killable to start
        * not completely closing the door on this idea though
    * Physics for projectiles or direct damage numbers?
        * visual effect to indicate, but not physics behavior directly
        * may revisit physics idea later
    * Effects - slow, fast, reverse, others?
        * interesting, but upgrades/future things
        * small chance for critical, insta-kill
        * maybe teleport back further in the wave
    * Sound effects? Music? Graphics presentation?
        * Ideally _low_ time spent on these, since programming (and design) focused internship
        * But probably want to at least "sell" this a bit - and these aspects will 100% help
        * maybe some pixel art to start for sprites - but don't go crazy
    * What counts as our minimum viable product?
        * N towers? 2 long range, 2 short range, 2 support - 6-ish towers
        * M enemies? 1 fast weak, 1 generic, 1 slow strong - 3-ish enemies
        * P maps? 1 generic, 1 with obstacles - 2-ish maps
        * grid pathing working
        * input methods working
        * currency working
        * life working (end of game)
        * basic UI in place
    * Other aspects we should consider? What's not on this list?
    * Stretch goal? Playable hero for instant impact
    * Instant abilities for players

* Approximate flow
    * Phase 1 - fixed tower, fixed enemy, verify tower attack works, enemies can be damaged
        * Initial map setup
            * add/remove of child scenes
            * possibly also instantiate
        * Initial tower setup
        * Initial mob setup
        * General object finding, interfaces, etc.
        * General organization in Godot
            * area 2d may be helpful
    * Phase 2 - moving enemy, single, fixed tower, verify behaviors
        * Moving mob setup
        * Add second/nth fixed towers for additional testing
    * Phase 3 - player ability to place towers (zero cost, debug)
        * Initial UI setup
    * Phase 4 - wave of enemy setup (timing, groups)
    * Phase 5 - currency and life

* Action steps
    * Consider ideas for theme for discussion in the afternoon
        * kitchen under attack by baked goods
        * other foods & utensils & pots & pans are the defenders
        * soup pot that splashes with soup - area damage
        * bread enemy - falls into multiple slices
        * toasted status, baking as something
        * fire damage
        * soaking/wet as an effect - slows them down
        * wet = less durable, damage multiplier effect
        * freezing could happen more effectively against soggy
    * Get everyone as a contributor to the github project
        * done
    * Get basic main scene with subfolder nodes in place
        * mentor to do this
        * do as feature branch and do review of PR at start of next work day
    * Work on a basic enemy
        * in progress on this - area2d + damage = done, but older version
        * do not use Godot signals here - the broadcast model doesn't make sense here
        * consider that indicating damage is a structure, not a number
        * once converted to 4.7.2 set up PR and do review
    * Work on a basic tower
        * use a direct call on an enemy to take damage
    * Work on a basic map
        * should define entries and exits for mobs

* Forward looking
    * Random ideas from mentor
        * perhaps with the kitchen/food idea: instead of losing life we gain pounds if something gets through
        * riffing on that idea, perhaps we could also add a way to lose pounds again - treadmill? doesn't quite fit the theme though
        * perhaps food goes either to compost or to be eaten - may form an interesting model for damge (can still be hp on mobs internally)

