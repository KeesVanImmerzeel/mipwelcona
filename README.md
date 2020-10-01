# Package "mipwelcona"

<!-- badges: start -->
<!-- badges: end -->

The package `mipwelcona` can be used to calculate the development of the concentrations of solvents in pumped groundwater. The package is based on the results of:

* streamline calculations (backwards from well screens) in a [MIPWA](https://oss.deltares.nl/web/imod/mipwa-showcase) groundwater model;
* Initial concentrations in the model layers;
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
- `mw_create_sl_fltr_table()`: Create table with indices linking the streamlines to well filters;
- `mw_example_concentrations()`: Initialise example concentrations in the subsoil. 

## Get help

To get help on the functions in this package type a question mark before the function name, like `?mw_read_streamlines()`

## Files needed

Prepare the following files in order to be able to perform an analysis with `mipwelcona`:

* `iff` streamline file;
* `ipf` well filter file;
* For every layer in the groundwater model: a map with initial concentrations. 


By streamline calculation in MIPWA (backwards from well screens), an `iff` file is created. Here is a screenshot of the top lines in an `iff` file.

![Capture](https://user-images.githubusercontent.com/16401251/94780598-001ad380-03c9-11eb-9558-82b8f4da889c.PNG)

In MIPWA the `ipf` file specifies the well characteristics (location, discharge etc.). Here is a screenshot of the top lines in an `ipf` file.

![Capture2](https://user-images.githubusercontent.com/16401251/94781503-3a38a500-03ca-11eb-96ab-6d6c9ed4637f.PNG)

The initial concentrations in the subsoil must be specified for every layer in the groundwater model in the form of a `RasterLayer`. In `mipwelcona` these raster layers are specified in a single object: a `RasterBrick`. The first `RasterLayer` in the `RasterBrick` represents the concentrations in the top aquifer, the second `RasterLayer` represents the concentrations in the aquifer below the top aquifer etc. An example of a `RasterBrick` with concentrations is supplied using the function `mw_example_concentrations()`.

## Example work flow

# References

The theory behind the concentration calculations is published in [Stromingen 1996](https://edepot.wur.nl/10128), [Stromingen 1996 (2)](https://www.nhv.nu/uploads/fileservice/stromingen/attachment/1996-3_Brieven.pdf).




