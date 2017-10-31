/*
 * MATLAB Compiler: 4.10 (R2009a)
 * Date: Wed Jul 11 03:32:58 2012
 * Arguments: "-B" "macro_default" "-m" "-W" "main" "-T" "link:exe" "-I" "/"
 * "-d" "./resexe/" "Interface_graphique_ATEO" "filtrageBilaterale"
 * "ADA_TRE_ENT_OPERATOR" "traitement_bordures" "pretraitement_image"
 * "inversion_couleur" "canny_color" 
 */

#include <stdio.h>
#include "mclmcrrt.h"
#ifdef __cplusplus
extern "C" {
#endif

extern mclComponentData __MCC_Interface_graphique_ATEO_component_data;

#ifdef __cplusplus
}
#endif

static HMCRINSTANCE _mcr_inst = NULL;


#ifdef __cplusplus
extern "C" {
#endif

static int mclDefaultPrintHandler(const char *s)
{
  return mclWrite(1 /* stdout */, s, sizeof(char)*strlen(s));
}

#ifdef __cplusplus
} /* End extern "C" block */
#endif

#ifdef __cplusplus
extern "C" {
#endif

static int mclDefaultErrorHandler(const char *s)
{
  int written = 0;
  size_t len = 0;
  len = strlen(s);
  written = mclWrite(2 /* stderr */, s, sizeof(char)*len);
  if (len > 0 && s[ len-1 ] != '\n')
    written += mclWrite(2 /* stderr */, "\n", sizeof(char));
  return written;
}

#ifdef __cplusplus
} /* End extern "C" block */
#endif

/* This symbol is defined in shared libraries. Define it here
 * (to nothing) in case this isn't a shared library. 
 */
#ifndef LIB_Interface_graphique_ATEO_C_API 
#define LIB_Interface_graphique_ATEO_C_API /* No special import/export declaration */
#endif

LIB_Interface_graphique_ATEO_C_API 
bool MW_CALL_CONV Interface_graphique_ATEOInitializeWithHandlers(
    mclOutputHandlerFcn error_handler,
    mclOutputHandlerFcn print_handler
)
{
  if (_mcr_inst != NULL)
    return true;
  if (!mclmcrInitialize())
    return false;
  if (!mclInitializeComponentInstanceWithEmbeddedCTF(&_mcr_inst,
                                                     &__MCC_Interface_graphique_ATEO_component_data,
                                                     true, NoObjectType,
                                                     ExeTarget, error_handler,
                                                     print_handler, 1232284, NULL))
    return false;
  return true;
}

LIB_Interface_graphique_ATEO_C_API 
bool MW_CALL_CONV Interface_graphique_ATEOInitialize(void)
{
  return Interface_graphique_ATEOInitializeWithHandlers(mclDefaultErrorHandler,
                                                        mclDefaultPrintHandler);
}

LIB_Interface_graphique_ATEO_C_API 
void MW_CALL_CONV Interface_graphique_ATEOTerminate(void)
{
  if (_mcr_inst != NULL)
    mclTerminateInstance(&_mcr_inst);
}

int run_main(int argc, const char **argv)
{
  int _retval;
  /* Generate and populate the path_to_component. */
  char path_to_component[(PATH_MAX*2)+1];
  separatePathName(argv[0], path_to_component, (PATH_MAX*2)+1);
  __MCC_Interface_graphique_ATEO_component_data.path_to_component = path_to_component; 
  if (!Interface_graphique_ATEOInitialize()) {
    return -1;
  }
  argc = mclSetCmdLineUserData(mclGetID(_mcr_inst), argc, argv);
  _retval = mclMain(_mcr_inst, argc, argv, "Interface_graphique_ATEO", 1);
  if (_retval == 0 /* no error */) mclWaitForFiguresToDie(NULL);
  Interface_graphique_ATEOTerminate();
  mclTerminateApplication();
  return _retval;
}

int main(int argc, const char **argv)
{
  if (!mclInitializeApplication(
    __MCC_Interface_graphique_ATEO_component_data.runtime_options,
    __MCC_Interface_graphique_ATEO_component_data.runtime_option_count))
    return 0;
  
  return mclRunMain(run_main, argc, argv);
}
