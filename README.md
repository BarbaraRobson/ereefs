# ereefs
An R package containing few useful functions to make accessing eReefs and other CSIRO-EMS output files easier. <p>

These functions rely on the netcdf4 package, which works best under Linux or MacOS. The functions provided here should work under Windows for locally-stored files, but will also work for OPeNDAP-served netcdf files under Linux or MacOS. 
They can be made to work for OPenDAP-served files under Windows with a custom-compiled version of the ncdf4 package -- contact me, Barbara Robson (brobson@aims.gov.au) for details.
    <H2>Functions to extract time-series from eReefs netcdf files</H2>
      get_ereefs_ts()<BR>
      get_ereefs_depth_integrated_ts ()<BR>
      get_ereefs_depth_specified_ts()<BR>
   <H2>Functions to produce maps or animations of eReefs model outputs</H2>
      map_ereefs()<BR>
      map_ereefs_movie()<BR>
    <H2>Function to calculate optical plume class from modelled surface reflectances</H2>
      plume_class()<BR>
    <H2>Functions to extract profiles and vertical slices</H2>
      get_ereefs_profile()<BR>
      get_ereefs_slice()<BR>
    <H2>Functions to plot profiles</H2>
      plot_ereefs_profile()<BR>
      plot_ereefs_zvt()<BR>
    <H2>Functions to convert outputs to GIS formats</H2>
      poly2sp()<BR>
      sp2raster()
