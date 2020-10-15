# Package "mipwelcona"

<!-- badges: start -->
<!-- badges: end -->

The package `mipwelcona` can be used to calculate the development of the concentrations of solvents in pumped groundwater. The package is based on the results of:

* streamline calculations (backwards from well screens) in a [MIPWA](https://oss.deltares.nl/web/imod/mipwa-showcase) groundwater model;
* Initial concentrations in specified layers;
* Levels of concentration layer levels; 
* Specified parameters for retardation and decay.

This package is a further development of the program [WELCONA](https://edepot.wur.nl/10147).

## Installation

You can install the released version of menyanthes from with:

`devtools::install_github("KeesVanImmerzeel/mipwelcona")`

Then load the package with:

`library("mipwelcona")` 

## Functions in this package
- `mw_read_streamlines()`: Read streamlines from *.iff file;
- `mw_read_well_filters()`: Read wells from *.ipf file;
- `mw_example_concentrations()`: Initialise example concentrations in the subsoil; 
- `mw_example_conc_layer_levels()`: Initialise example concentration layer levels;
- `mw_init()`: Initialize streamline concentration table;
- `mw_create_sl_fltr_table()`: Create table with indices linking the streamlines to well filters.

## Get help

To get help on the functions in this package type a question mark before the function name, like `?mw_read_streamlines()`

## Files needed

Prepare the following files in order to be able to perform an analysis with `mipwelcona`:

* `iff` streamline file;
* `ipf` well filter file;
* For every concentration layer: a map with initial concentrations; 
* The levels (relative to a reference level) between these concentration layers.


By streamline calculation in MIPWA (backwards from well screens), an `iff` file is created. Here is a screenshot of the top lines in an `iff` file containing the calculated *streamlines*.

![Capture](https://user-images.githubusercontent.com/16401251/94780598-001ad380-03c9-11eb-9558-82b8f4da889c.PNG)

In MIPWA the `ipf` file specifies the *well characteristics* (location, discharge etc.). Here is a screenshot of the top lines in an `ipf` file.

![Capture2](https://user-images.githubusercontent.com/16401251/94781503-3a38a500-03ca-11eb-96ab-6d6c9ed4637f.PNG)

The initial *concentrations* in the subsoil must be specified for every concentration layer. These initial concentrations (maps) have the format of a `RasterLayer`. In `mipwelcona` these raster layers are specified in a single object: a `RasterBrick`. The first `RasterLayer` in the `RasterBrick` represents the concentrations in the top concentration layer, the second `RasterLayer` represents the concentrations in the concentration layer below the first concentration layer etc. An example of a `RasterBrick` with concentrations is supplied using the function `mw_example_concentrations()`.

The concentration layers are separated at *levels* that are also with a `RasterBrick` object. The first `RasterLayer` in this `RasterBrick` represents the levels between the top concentration layer and the concentration layer below the top concentration layer etc. So, if (n) concentration layers are specified, the number of level `RasterLayers` to specify is equal to (n-1). An example of a `RasterBrick` with levels of concentration layers is supplied using the function `mw_example_conc_layer_levels()`.


## Example work flow

`# Read streamlines.`
`fname <- system.file("extdata","streamlines.iff",package="mipwelcona")`
`strm_lns <- mw_read_streamlines(fname)`

`# Read well filters.`
`fname <- system.file("extdata","well_filters.ipf",package="mipwelcona")`
`well_fltrs <- mw_read_well_filters(fname)`

`# Read concentration layer levels (8 rasters layers).`
`conc_l_lev <- mw_example_conc_layer_levels()`

`# Read Initial concentrations of different layers in the subsoil (9 raster layers).`
`conc_l <- mw_example_concentrations()`

`# Initialize base streamline concentration table.`
`conc_strm_lns <- mw_init(strm_lns, conc_l_lev, conc_l)`

`# Create table with indices linking the streamlines to well filters.`
`# sl_fltr_table <- mw_create_sl_fltr_table(strm_lns, well_fltrs, maxdist=100)`

# References

The theory behind the concentration calculations is published in [Stromingen 1996](https://edepot.wur.nl/10128), [Stromingen 1996 (2)](https://www.nhv.nu/uploads/fileservice/stromingen/attachment/1996-3_Brieven.pdf).




