# Planning


* Groundwork
    * Meetings - start, end, others? Text comms, via what channel?
    * Initial paperwork bits - orientation, planning checklist - do we have this from Tony?
    * Can we create Teams channel with davidm as guest?
    * Alt: phone text for attention
    * Use of AI - suggest no; require human explain/review; who owns code?
    * Software
        * Godot (should agree on version - suggest 4.7.2 as latest stable)
        * Git (suggest install from git-scm.com - standard git)
        * Github accounts for each person - then notify davidm to add to project

* Design discussion
    * Clarification on basics:
        * Players place towers, which auto-fire at enemies when they are in range
        * Enemies move toward some goal; arrival there has negative results for player
    * Theme?
        * Not strictly required but can provide some useful guiderails for what kinds of things we’re doing
        * fantasy, ranged, melee, sci-fi, chemistry, school, etc.
    * Target input methods? Mouse? Target platforms? Web? Windows?
        * Suggest mouse to start
        * May investigate fancy input mapping in Godot (need doc link)
    * Grid path vs. follow shape vs. ? for mobs
    * Grid vs. shape vs. set spot vs. ? for towers
    * Waves: Fixed? Random seeded? Other? Multiple modes?
    * Loss condition: Health? Money? Other?
    * Currency gain: kills, mining, set per level, other? Multiple?
    * Upgrade towers or buy new ones or both?
    * Real-time tower purchase, pause between waves, both, other?
    * Non-tower upgrades (global lift)?
    * Can mobs attack towers or just life?
    * Physics for projectiles or direct damage numbers?
    * Effects - slow, fast, reverse, others?
    * Sound effects? Music? Graphics presentation?
        * Ideally _low_ time spent on these, since programming (and design) focused internship
        * But probably want to at least "sell" this a bit - and these aspects will 100% help
    * What counts as our minimum viable product?
        * N towers?
        * M enemies?
        * P maps?
    * Other aspects we should consider? What's not on this list?

* Approximate flow
    * Phase 1 - fixed tower, fixed enemy, verify tower attack works, enemies can be damaged
        * Initial map setup
        * Initial tower setup
        * Initial mob setup
        * General object finding, interfaces, etc.
    * Phase 2 - moving enemy, single, fixed tower, verify behaviors
        * Moving mob setup
        * Add second/nth fixed towers for additional testing
    * Phase 3 - player ability to place towers (zero cost, debug)
        * Initial UI setup
    * Phase 4 - wave of enemy setup (timing, groups)
