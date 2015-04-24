#ifndef __COMMON_INC_APPLICATIONDEF_H__
#define __COMMON_INC_APPLICATIONDEF_H__

typedef enum
{
    eAE_OPOPO_I366                                   = 1000,
    eAE_OPOPO_TexasHoldem                            = 1001,  // Poker Game
    eAE_OPOPO_iDraw                                  = 1002,

    // Add before this line.
    eAE_None
}eAppEnum;


typedef enum
{
    eLeLe_BranchDefault                              = 0,
    eLeLe_BranchLeBoShow                             = 100,

    // Add before this line.
    eLeLe_BranchEnd
}eLeLeBranch;

typedef enum
{
    eACD_Application                                 = 100,
    eACD_Game                                        = 200,

    // Add before this line.
    eACD_End
}eAppCategoryDef;


typedef enum
{
    eFE_LELE_LOTTERY                                 = 10,
    eFE_LELE_SMASH_GOLDEN_EGG                        = 20,

    // Add before this line.
    eFE_END
}eFunctionEnum;

#endif /* __COMMON_INC_APPLICATIONDEF_H__ */

