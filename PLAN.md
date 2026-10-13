# Planning


* Groundwork
  * Meetings - start, end, others? Text comms, via what channel?
  * Can we create Teams channel with davidm as guest?
  * Alt: phone text for attention

* Design discussion
    * Clarification on basics:
        * Players place towers, which auto-fire at enemies when they are in range
        * Enemies move toward some goal; arrival there has negative results for player
    * Theme? Not strictly required but can provide some useful guiderails for what kinds of things we’re doing - fantasy, ranged, melee, sci-fi, chemistry, school, etc.
    * Target input methods? Mouse? Target platforms? Web? Windows?
    * Grid vs. path vs. ? for mobs
    * Grid vs. shape vs. set spot vs. ? for towers
    * Loss condition: Health? Money? Other?
    * Money gain: kills, mining, set per level, other? Multiple?
    * Upgrade towers or buy new ones or both?
    * Non-tower upgrades (global lift)?
    * Use of AI - suggest no; require human explain/review; who owns code?
    * Physics for projectiles or direct damage numbers?
    * Effects - slow, fast, reverse, others?

* Approximate flow
    * Phase 1 - fixed tower, fixed enemy, verify tower attack works
        * Initial map setup
        * Initial tower setup
        * Initial mob setup
    * Phase 2 - moving enemy, single, fixed tower, verify behaviors
        * Moving mob setup
    * Phase 3 - player ability to place towers (zero cost, debug)
        * Initial UI setup
    * Phase 4 - wave of enemy setup (timing, groups)
