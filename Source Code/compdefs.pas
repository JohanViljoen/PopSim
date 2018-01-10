//{$DEFINE OUERS}             //Used to gather statistics on the number of progeny each individual produces
//{$DEFINE ENKELOUER}         //Used to allow single individual to be both parents
//{$DEFINE GESLAGTE}          //Divide the population into male and female, and insist that the parents be of different sexes
{$DEFINE HIDEMULTIPLETYPES} //Hide the controls for Multiple types until we figure out how to use it
//{$DEFINE KLANKE}            //Make diagnostic beeps


(*  What's New
2018-01-09 v1.53
- Fixed a bug that sometimes resulted in graphs being displayed when it should
not have been.
- Activated the stability sensor, to determine when the population levels have
stabilised: this should help to speed up the equilibrium level runs.


2017-12-18 v1.52
- Increased the resolution of the heterozygous step size to 7 decimals.
- Improved error checking on the heterozygous loop iteration computation.



2017-12-05 v1.51
- Changed logarithmic behaviour of Community Size and Heterozygous Advantage to
be consistent. When 'Log' is selected, 'Step Size' now becomes the largest
(final) step. Also improved error checking.
- Set default priority to 'Below Normal'

2017-12-05 v1.50
- Added a control to set the CPU priority of the program; this is especially
 useful when all cores are used, making the computer sluggish if the priorities
 are too high. Current choices are Idle, Below Normal, Normal, Above Normal,
 High, and Realtime.
- Removed diagnostic beeps (compiler directive KLANKE)
- Tweaked screen positions & spelling
- Updated Monte Carlo Community Size options to 4 decimals

2017-11-17 v1.49
- Clear the graphs after a Monte Carlo run if there are too many points, lest it
leads to an out-of-memory error, or slows things down too much, as is its wont.
- Fixed an overflow bug that could occur when changing community size limits
while the logarithmic option is selected.
- Now also allows fractional community sizes (when the Gaussian distribution is
selected). Currently to 3 decimal places - let's see if that is sufficient. 


2017-11-16 v1.48
- Also take into account the homozygotic prevalence before declaring extinction
during Monte Carlo runs.
- Fixed a file access error that could occur when interrupting a Monte Carlo run.
- Added Logarithmic option to the Community size in the Monte Carlo function.
- Improved the ETA estimates - only update at the end of each run, and estimate
in between by subtracting seconds as they elapse.
- Added autoscaling of main window to size until scrollbars disappear. This is
useful when run on a system with a different screen resolution than the one it
was designed on. (Remains messy on a 640x480 screen.)


2017-11-15 v1.47
- Display the total time taken by a Monte Carlo run when it finishes.
- Hide the controls for Multiple types until we figure out how to use it.

2017-11-11 v1.46
- Fixed the Monte Carlo speed indicator (runs/second) to work like the speed
indicator below (v1.44), switching to s/run when dropping below 0.2 runs/s.
- Added an estimate of time to finish (ETA) to the Monte Carlo function


2017-10-14 v1.45
- Resets the time constant of the speed indicator when any of the important
parameters change - this allows the speed to adapt much faster to the new value.
- Tried to fix the habit of the Width and Height to jump to display screen sizes
even when 'Display' is not checked.
- Momentarily disable the 'Run' button while initialising/updating tables, to
prevent it being clicked when the simulation is in an undefined state.


2017-10-12 v1.44
- Increased the maximum population to 10000x10000 = 100 million. It is very slow
when the population is maximal.
- Changed the type counters to type Int64 to prevent numeric overflow when large
populations are used, as made possible above.
- Improved UI responsivity when using large populations, which can take many
seconds per generation.
- Fixed the speed indicator (generations/second) to work better, especially
when the speed is low. Also switch to seconds/generation when the speed drops
below 0.2 gen/s.


2017-09-09 v1.43
- Increased the resolution of the Advantage spinboxes on the main form to 4
decimals.
- Minor layout adjustments on the main form
- Limited the Width and Height on the Monte Carlo screen to the maximum
allowable values.
- Automatically update on the main form the various parameters used by
the Monte Carlo process
- Added a 'Use previous' checkbox for the equilibrium establishment on the
Monte Carlo screen. If checked, the field is only initialised at the start, or
when all carriers have become extinct.


2017-09-05 V1.42
- Changed the 'Initial prevalence' box on the Monte Carlo screen to increment by
0.01% instead of 1% steps.

2017-08-04 v1.41
- Added the GESLAGTE compiler directive to split the population into sexes.
Not to be used in conjunction with ENKELOUER, of course.


2017-07-29 v1.40
- Updated the 'Save' function on the prevalence graph to also save the Wild type


2017-07-08 v1.39
- Added ENKELOUER compiler directive to allow the same individual to be chosen as
both parents (to see if it makes a difference. It does.)
- Fixed the dwNumberOfProcessors value when assigning process to processor (was
using it without initialising


2017-07-07 v1.38
- Added Logarithmic stepping of Heterozygotic Advantage in Monte Carlo. Starts
at max and reduces until < min (which has to be >0)


2017-06-22
- Reduced maksbreedte & makshoogte to 3000
- Made {$MAXSTACKSIZE $01000000} - it was {$MAXSTACKSIZE $018000000} - not sure
what this does
- Always initialize cdf during MC runs, also when using flat distribution

2017-06-20
- Reduced maxcdfstappe to 60k to speed things up
- Set the process affinity on startup to a single core, equal to (one less than)
the number of the specific current instance. This can be changed in the Windows
Task Manager, if desired. Uses JvAppInstances.


2017-06-14
- Fixed display, which did not update changed pixels quite correctly. Seems to
work now.

*)
