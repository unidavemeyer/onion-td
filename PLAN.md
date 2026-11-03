# Planning

* Reminders
    * [https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html]
    * Feature branch development style with PR's back to main

* Action steps
    * finish review
        * should leave PR in state we're at
        * we're on test_enemy.gd for reference, looking at update_path and such
        * covers next three points
    * Consider solution for scaling everywhere
        * Possibility: scale camera (view) so factor is applied one place
        * Possibility: scale images (but has issues with mismatch to bodies, etc.)
        * Possibility: player controlled zoom (would likely require off-screen indicators for things)
        * discussed - work comingled with map work
    * Work on a basic map
        * should define entries and exits for mobs
        * also consider how maps add/remove
        * also consider map features - auto/start towers, say
        * work in progress on this front, comingled with zoom issues
    * How do we enforce tower-to-grid behavior?
        * presumably same grid as pathing for simplicity although not requirement if we have reason to diverge
        * consider grid coordinate system perhaps?
            * single mapping system (class? functions?) from grid coords to pixels
            * store/set tower pos in grid coords instead of pixels?
        * this is in progress and/or done with the map work
    * discuss pathing when things change
        * repath from cur to goal always possible
        * if nobody can be "sat atop of" then could also do nearest point to get segment
        * perhaps this is a reasonable point for a signal - on_path_cells_changed or similar
    * query: should we consider seeking interested parties to provide nicer art?
        * doing this would be side quest for programming I think
        * on the other hand, nicer art would provide a better experience - think playtesting
        * unclear if there are other students that may be interested in volunteering on this
        * is this worth pursuing, or should we leave this as is and not sweat it?
        * if we do this, we should also make crystal clear image formats and sizes and such
        * if we do this, should make clear our licensing and that it works for people
    * query: should we do anything about sound?
        * possible resource: https://en.wikipedia.org/wiki/Wikipedia:Free_sound_resources
        * definitely not something we should spend much time on...but again may help the experience - playtesting
        * another area of: should we open this to volunteer students? not sure if anyone is in this camp
        * if we use "found footage" here (resources linked above) will need to be very clear on licensing
            * ex: can/should we check in to our project, or link to theirs directly? will Godot do that?
            * ex: if we use their asset, does it impact our licensing?
    * Consider Phase 1
        * Once we have map, can set up "real" test of map + tower + mob and prove out these parts
        * Are we basically done?
        * Suggest we label/tag/whatever this in git for progress checking/history/etc.
    * Phase 2 enemy work queue:
        * enemy variety - add second enemy type
        * wave spawning - add some way to spawn waves of enemies
            * recall this will be where random seeds probably fit -- waves = the run, I think?
    * Phase 2 tower work queue:
        * Create second type of tower
            * fast small damage single target?
            * slow large damage single target?
            * slow large damage area-of-effect at projectile?
            * (plenty of other possibilities)
    * Consider Phase 2
        * are we done? If not, what is missing?
    * Phase 3 work items:
        * user placement of towers - UI
        * user placement of towers - mouse input following
        * user placement of towers - allowed/disallowed cells
        * user placement of towers - cell grid snapping
        * response to tower placement - repathing for enemies
    * Phase 4 work items:
        * currency
            * how do players gain this? defeating enemies? other?
            * where (in code) do we track this?
            * where (in ui) do we show this?
            * how do towers properly deduct from this?
            * planning: how do we balance this? what stats do we need? feels like data is important before just diving in...
        * life
            * how much do players start with? map defined? constant?
            * where (in code) do we track this?
            * where (in ui) do we show this?
            * how do enemies properly deduct from this?
    * Phase 5 work status:
        * Goal: 6-ish towers - adjust? keep?
        * Goal: 3-ish enemies - adjust? keep?
        * Goal: 2-ish maps
        * grid pathing working
        * enemy waves working
        * input methods working
        * currency working
        * life working (end of game)
        * basic UI in place

* Roadmap
    * COMPLETE? Phase 1 - fixed tower, fixed enemy, verify tower attack works, enemies can be damaged
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
            * Consider gridded approach and how path finding and path following work in such a model
        * Add second/nth fixed towers for additional testing
            * For parallel dev, maybe second type of tower while mob movement is in process
    * Phase 3 - player ability to place towers (zero cost, debug)
        * Initial UI setup
    * Phase 4 - currency and life
    * Phase 5 - any remaining items for minimum viable product
    * Phase 6 - plan for playtesting (tbd what items ultimately go here)

# Progress 2026-10-29

* Action steps
    * constants.gd missing
        * should repair and PR into main
        * fixed
    * Continue work on grid-based pathing
        * Constraints on mobs
        * Constraints on towers
        * General algorithm
        * Path Following vs. Path Finding
        * reviewed and submitted - this is complete
    * Consider solution for scaling everywhere
        * discussed - work comingled with map work - in review
    * Work on a basic map
        * work in progress on this front, comingled with zoom issues - in review
    * How do we enforce tower-to-grid behavior?
        * this is in progress and/or done with the map work - in review
    * Discuss notion of driving towards a playtest
        * Is this something we'd like to do? Discuss focus tests in professional gamedev.
          * In agreement that this makes sense as goal #2
        * Sync or async? If sync, where/when/who? If async, how do we gate appropriately, and record?
          * async link seems less likely to work
          * sync on specific point test may be better
          * possibly playtest at robotics competitions
        * If we provide web version, could allow subset of students to try it out?
        * Telemetry? How do we record what they did, how they did it, etc.?
          * could do local instead of network as well

# Progress 2026-10-22

* Action steps
    * Notes regarding overall plan and daily action steps
        * Big one: Mentor trying to be ahead, so expect more actions than can fit in a day on purpose
    * Become familiar with the GDScript style guide
        * [https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html]
        * Expectation is that we'll all use this to organize/name things for consistency
    * Consider if there are additional refinements to the design that we need to discuss
        * Random ideas from mentor
            * perhaps with the kitchen/food idea: instead of losing life we gain pounds if something gets through
            * riffing on that idea, perhaps we could also add a way to lose pounds again - treadmill? doesn't quite fit the theme though
            * perhaps food goes either to compost or to be eaten - may form an interesting model for damge (can still be hp on mobs internally)
    * Optional consideration: pair programming
        * Mentor has not experience with this, but has heard good reports from others
    * Work on a basic enemy
        * once converted to 4.7.2 set up PR and do review
    * Work on a basic tower
        * use a direct call on an enemy to take damage
        * once ready set up PR and do review

# Progress 2026-10-15

* Groundwork
    * Meetings - start, end, others? Text comms, via what channel?
        * Teams meeting to start and end
        * Need to figure out a way to share screens
        * 2:30 p.m. meeting end of day
        * send text number for instant comms
        * Future: Create channel in Teams - can we invite guest?
    * Initial paperwork bits - orientation, planning checklist - do we have this from Tony?
        * Tabled until we have the documents from Tony
        * Got documents during day, went through in afternoon session
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
    * Work on a basic enemy
        * in progress on this - area2d + damage = done, but older version
        * do not use Godot signals here - the broadcast model doesn't make sense here
        * consider that indicating damage is a structure, not a number
    * Get basic main scene with subfolder nodes in place
        * mentor to do this
        * do as feature branch and do review of PR at start of next work day
