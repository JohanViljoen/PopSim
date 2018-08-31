# PopSim
Code to simulate the establishment, proliferation and equilibrium levels of monogenic mutations in diploid populations.

## System requirements: ##
Operating System: Microsoft Windows (XP, 7, 10 - all versions)

**Installation:** Copy the Popsim*.exe file to any folder; it is suggested that a dedicated folder be created for this purpose. No installation needed, therefore installation time is simply the time needed to copy/move the file, which should be <1s.

**Demo:** As supplied, the software is populated with default parameters. See 'Popsim User manual.pdf' for instructions.  

**Run Time:** Using a population of 1 million individuals, typical run times are <100ms per generation. When the graphical population display is active, the speed is reduced by ~30%. Monte Carlo runs can easily comprise thousands of different scenarios, sometimes running for thousands of generations - the software displays an estimated time to complete, which may run into hours, or even days, depending on the settings.        


Language: Delphi 6.0 (Build 6.240) Update pack 2

v1.58 2018-08-31

----------

***What's New***

2018-08-31 v1.58

- Added functionality to write prevalence graphs to disk before clearing it when
the maximum number of points in the graph is reached (currently 100K).
- Added a header line to the graph files, recording the model parameters.
- Also include the time and date as part of the graph file name, to prevent
overwriting. 

2018-08-09 v1.57

- Increase resolution at which HomAdv and HetAdv is displayed and saved.
- Fixed a bug which resulted in the number of MC runs not always being displayed
correctly.
- Fixed a bug in the template file writing which sometimes resulted in the
wrong mode (establishment/equilibrium) being specified.
- Added an alternative colour scheme for the population display, which can be
selected by right-clicking on the population display itself.
- Changed the key assignment for drawing on the population display: Instead of
the right mouse button (which is now used to select the colour scheme), use
Shift or Ctrl with the left button to erase on the population display. 

2018-07-24 v1.56

- Force redraw on mouse-up when manually drawing on the population display
screen.

2018-06-23 v1.55b

- Licensed using GNU General Public License, version 3 (GPL-3.0). No functional
changes, just added the licensing text to source files and the main program
title header.

2018-03-10 v1.55a

- Fixed a bug which prevented detection of stable population values when doing
Equilibrium Monte Carlo runs using a template file

2018-02-10 v1.55

- Modified the nested loops of the Monte Carlo function to use a precompiled
array of community size, heterozygous advantage, and homozygous advantage
parameters, to iterate through, rather than modifying the parameters on the fly
as was done hitherto.
- Added the option to use a template file (which can and normally would be the
result file of a previous Monte Carlo run). When selected, the template file is
read to determine the vital parameters; only the number of runs can be changed,
if desired, all others are hidden or greyed out.
- When doing the 'normal' establishment or equilibrium Monte Carlo runs, also
precompile an array of all parameter combinations as in the template case above,
and then iterate through this list.
- Write out this array of parameter combinations into a Template file. Both
template files and normal MC result files can be used as templates for future
runs.
- Added a checkbox just below the 'Run' button on the Monte Carlo form to select
the option of randomizing the order in which MC runs are executed. This may help
to improve the accuracy of the ETA estimate, which is still not very accurate,
due to the fact that some parameter combinations result in much longer iteration
times than others.


2018-01-17 v1.54a

- Increase the retries to find a parent from 50 to 1000; this becomes an issue
when using very small community sizes with very large advantages while rare,
which may result in skewed establishment rates.

2018-01-11 v1.54

- Added a compiler directive to control the display of the stability trigger
signals.
- Added the logarithmic option to the homozygous range in the MC function.
- Fixed a bug which prevented negative selective advantage values from stepping
logarithmically.
- Use total prevalence (heterozygotes+homozygotes) as threshold during MC runs,
rather than just the heterozygotes as was done hitherto.

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



