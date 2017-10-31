/*
 * MATLAB Compiler: 4.10 (R2009a)
 * Date: Wed Jul 11 03:32:58 2012
 * Arguments: "-B" "macro_default" "-m" "-W" "main" "-T" "link:exe" "-I" "/"
 * "-d" "./resexe/" "Interface_graphique_ATEO" "filtrageBilaterale"
 * "ADA_TRE_ENT_OPERATOR" "traitement_bordures" "pretraitement_image"
 * "inversion_couleur" "canny_color" 
 */

#include "mclmcrrt.h"

#ifdef __cplusplus
extern "C" {
#endif
const unsigned char __MCC_Interface_graphique_ATEO_session_key[] = {
    '5', 'F', '3', '2', 'B', '3', '3', '4', '5', '8', 'D', 'A', '9', '5', 'B',
    '8', '9', 'E', '5', '6', 'D', '6', 'D', '2', '0', 'A', '9', 'C', '6', '2',
    'D', '8', '0', 'A', '0', '7', '1', '0', '8', '8', 'D', '1', '1', '2', 'F',
    '6', '2', 'C', '5', 'F', '6', '5', '9', 'D', '6', '8', 'F', '2', '4', 'B',
    '5', '6', 'D', '2', '8', '3', '6', 'B', '6', '9', 'A', '6', '3', 'E', 'A',
    '2', 'D', '5', '6', 'F', '7', 'D', 'B', '8', 'B', '0', 'C', '8', 'C', '9',
    '9', '8', 'E', '5', 'A', 'E', '7', 'A', 'B', '7', '1', '9', '2', '8', '8',
    '4', 'D', 'A', 'F', 'C', '0', '4', 'A', '1', 'D', '0', '1', '2', '4', '3',
    '5', 'C', '9', '6', '0', '6', '1', 'A', 'D', 'B', '8', '8', 'D', '8', 'A',
    'E', 'E', '1', 'C', '9', '4', '9', '7', 'F', '2', '0', 'C', 'B', 'D', '6',
    'C', '6', 'C', '5', '8', '8', 'C', '3', '4', 'B', 'D', '9', '2', '7', 'A',
    'B', 'D', '8', 'E', '4', '4', '7', '5', '9', 'B', '0', '4', 'B', 'D', '5',
    'E', '0', 'D', '0', '9', '3', 'F', 'C', 'F', '3', '0', '3', '7', '8', '8',
    '3', '5', '6', 'F', 'F', 'C', '0', '8', 'B', '3', '7', '5', '7', 'E', '3',
    'B', '0', 'F', 'D', '1', 'C', 'E', '5', 'F', 'C', '3', 'B', 'D', 'D', '6',
    '0', 'B', '8', '4', '9', 'B', '3', 'D', '4', '6', 'C', '7', '3', '7', '9',
    '4', 'A', '7', '0', '7', 'C', '5', '2', 'C', '2', '2', '1', '3', '3', '4',
    '6', '\0'};

const unsigned char __MCC_Interface_graphique_ATEO_public_key[] = {
    '3', '0', '8', '1', '9', 'D', '3', '0', '0', 'D', '0', '6', '0', '9', '2',
    'A', '8', '6', '4', '8', '8', '6', 'F', '7', '0', 'D', '0', '1', '0', '1',
    '0', '1', '0', '5', '0', '0', '0', '3', '8', '1', '8', 'B', '0', '0', '3',
    '0', '8', '1', '8', '7', '0', '2', '8', '1', '8', '1', '0', '0', 'C', '4',
    '9', 'C', 'A', 'C', '3', '4', 'E', 'D', '1', '3', 'A', '5', '2', '0', '6',
    '5', '8', 'F', '6', 'F', '8', 'E', '0', '1', '3', '8', 'C', '4', '3', '1',
    '5', 'B', '4', '3', '1', '5', '2', '7', '7', 'E', 'D', '3', 'F', '7', 'D',
    'A', 'E', '5', '3', '0', '9', '9', 'D', 'B', '0', '8', 'E', 'E', '5', '8',
    '9', 'F', '8', '0', '4', 'D', '4', 'B', '9', '8', '1', '3', '2', '6', 'A',
    '5', '2', 'C', 'C', 'E', '4', '3', '8', '2', 'E', '9', 'F', '2', 'B', '4',
    'D', '0', '8', '5', 'E', 'B', '9', '5', '0', 'C', '7', 'A', 'B', '1', '2',
    'E', 'D', 'E', '2', 'D', '4', '1', '2', '9', '7', '8', '2', '0', 'E', '6',
    '3', '7', '7', 'A', '5', 'F', 'E', 'B', '5', '6', '8', '9', 'D', '4', 'E',
    '6', '0', '3', '2', 'F', '6', '0', 'C', '4', '3', '0', '7', '4', 'A', '0',
    '4', 'C', '2', '6', 'A', 'B', '7', '2', 'F', '5', '4', 'B', '5', '1', 'B',
    'B', '4', '6', '0', '5', '7', '8', '7', '8', '5', 'B', '1', '9', '9', '0',
    '1', '4', '3', '1', '4', 'A', '6', '5', 'F', '0', '9', '0', 'B', '6', '1',
    'F', 'C', '2', '0', '1', '6', '9', '4', '5', '3', 'B', '5', '8', 'F', 'C',
    '8', 'B', 'A', '4', '3', 'E', '6', '7', '7', '6', 'E', 'B', '7', 'E', 'C',
    'D', '3', '1', '7', '8', 'B', '5', '6', 'A', 'B', '0', 'F', 'A', '0', '6',
    'D', 'D', '6', '4', '9', '6', '7', 'C', 'B', '1', '4', '9', 'E', '5', '0',
    '2', '0', '1', '1', '1', '\0'};

static const char * MCC_Interface_graphique_ATEO_matlabpath_data[] = 
  { "Interface_gr/", "$TOOLBOXDEPLOYDIR/",
    "$TOOLBOXMATLABDIR/general/", "$TOOLBOXMATLABDIR/ops/",
    "$TOOLBOXMATLABDIR/lang/", "$TOOLBOXMATLABDIR/elmat/",
    "$TOOLBOXMATLABDIR/randfun/", "$TOOLBOXMATLABDIR/elfun/",
    "$TOOLBOXMATLABDIR/specfun/", "$TOOLBOXMATLABDIR/matfun/",
    "$TOOLBOXMATLABDIR/datafun/", "$TOOLBOXMATLABDIR/polyfun/",
    "$TOOLBOXMATLABDIR/funfun/", "$TOOLBOXMATLABDIR/sparfun/",
    "$TOOLBOXMATLABDIR/scribe/", "$TOOLBOXMATLABDIR/graph2d/",
    "$TOOLBOXMATLABDIR/graph3d/", "$TOOLBOXMATLABDIR/specgraph/",
    "$TOOLBOXMATLABDIR/graphics/", "$TOOLBOXMATLABDIR/uitools/",
    "$TOOLBOXMATLABDIR/strfun/", "$TOOLBOXMATLABDIR/imagesci/",
    "$TOOLBOXMATLABDIR/iofun/", "$TOOLBOXMATLABDIR/audiovideo/",
    "$TOOLBOXMATLABDIR/timefun/", "$TOOLBOXMATLABDIR/datatypes/",
    "$TOOLBOXMATLABDIR/verctrl/", "$TOOLBOXMATLABDIR/codetools/",
    "$TOOLBOXMATLABDIR/helptools/", "$TOOLBOXMATLABDIR/winfun/",
    "$TOOLBOXMATLABDIR/winfun/net/", "$TOOLBOXMATLABDIR/demos/",
    "$TOOLBOXMATLABDIR/timeseries/", "$TOOLBOXMATLABDIR/hds/",
    "$TOOLBOXMATLABDIR/guide/", "$TOOLBOXMATLABDIR/plottools/",
    "toolbox/local/", "toolbox/shared/dastudio/",
    "$TOOLBOXMATLABDIR/datamanager/", "toolbox/compiler/",
    "toolbox/images/colorspaces/", "toolbox/images/images/",
    "toolbox/images/imuitools/", "toolbox/images/iptformats/",
    "toolbox/images/iptutils/", "toolbox/shared/imageslib/" };

static const char * MCC_Interface_graphique_ATEO_classpath_data[] = 
  { "java/jar/toolbox/images.jar" };

static const char * MCC_Interface_graphique_ATEO_libpath_data[] = 
  { "" };

static const char * MCC_Interface_graphique_ATEO_app_opts_data[] = 
  { "" };

static const char * MCC_Interface_graphique_ATEO_run_opts_data[] = 
  { "" };

static const char * MCC_Interface_graphique_ATEO_warning_state_data[] = 
  { "off:MATLAB:dispatcher:nameConflict" };


mclComponentData __MCC_Interface_graphique_ATEO_component_data = { 

  /* Public key data */
  __MCC_Interface_graphique_ATEO_public_key,

  /* Component name */
  "Interface_graphique_ATEO",

  /* Component Root */
  "",

  /* Application key data */
  __MCC_Interface_graphique_ATEO_session_key,

  /* Component's MATLAB Path */
  MCC_Interface_graphique_ATEO_matlabpath_data,

  /* Number of directories in the MATLAB Path */
  46,

  /* Component's Java class path */
  MCC_Interface_graphique_ATEO_classpath_data,
  /* Number of directories in the Java class path */
  1,

  /* Component's load library path (for extra shared libraries) */
  MCC_Interface_graphique_ATEO_libpath_data,
  /* Number of directories in the load library path */
  0,

  /* MCR instance-specific runtime options */
  MCC_Interface_graphique_ATEO_app_opts_data,
  /* Number of MCR instance-specific runtime options */
  0,

  /* MCR global runtime options */
  MCC_Interface_graphique_ATEO_run_opts_data,
  /* Number of MCR global runtime options */
  0,
  
  /* Component preferences directory */
  "Interface_gr_F2DFB297181B40A62B88AE6153D87979",

  /* MCR warning status data */
  MCC_Interface_graphique_ATEO_warning_state_data,
  /* Number of MCR warning status modifiers */
  1,

  /* Path to component - evaluated at runtime */
  NULL

};

#ifdef __cplusplus
}
#endif


