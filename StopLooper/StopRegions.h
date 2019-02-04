#ifndef STOPREGIONS_H
#define STOPREGIONS_H

#include <string>
#include "TTree.h"
#include "SR.h"

// ivar:         0,        1,        2,        3,        4,        5,        6,        7,        8,        9,
enum Vars {    met,       mt,     nlep,    nvlep, passvetos,    njet,    nbjet,    nbtag,   ntbtag,      mlb,
              tmod, dphijmet, deepttag,  resttag,   bdtttag,  tfttag,
            met_rl,    mt_rl,  tmod_rl,  nlep_rl, dphijmet_rl, mt2_ll,     mll,   mlb_0b,
            lep1pt,   lep2pt,  lep1eta,  lep2eta,   jet1pt,   jet2pt,  jet1eta,  jet2eta,
            j1passbtag, dphilmet, dphilmet_rl, shapecut, passlep1pt, metphi,
            nvtx, ht, nak8jets, chi2, binttag, leadbpt, mllbbmet, mtttbar, ptttbar, ptll,
            nvars };
// vector<std::string> varnames_ = { "met",};

// std::string GetVarName(Vars var) { return varnames_.at(var); }

std::vector<SR> getStopControlRegionsNoBTags(std::vector<SR>&& SRvec);
std::vector<SR> getStopControlRegionsDilepton(std::vector<SR>&& SRvec);

std::vector<SR> getStopSignalRegionsTopological();
std::vector<SR> getStopControlRegionsNoBTagsTopological();
std::vector<SR> getStopControlRegionsDileptonTopological();

std::vector<SR> getStopSignalRegionsNewMETBinning();
std::vector<SR> getStopControlRegionsNoBTagsNewMETBinning();
std::vector<SR> getStopControlRegionsDileptonNewMETBinning();

std::vector<SR> getStopSignalRegionsRun2();
std::vector<SR> getStopControlRegionsNoBTagsRun2();
std::vector<SR> getStopControlRegionsDileptonRun2();

std::vector<SR> getStopSignalRegionsAddResTagBin();
std::vector<SR> getStopControlRegionsNoBTagsAddResTagBin();
std::vector<SR> getStopControlRegionsDileptonAddResTagBin();

std::vector<SR> getStopSignalRegionsAddTopTagBins();
std::vector<SR> getStopControlRegionsNoBTagsAddTopTagBins();
std::vector<SR> getStopControlRegionsDileptonAddTopTagBins();

std::vector<SR> getStopSignalRegionsBinInResolvedTag();
std::vector<SR> getStopControlRegionsNoBTagsBinInResolvedTag();
std::vector<SR> getStopControlRegionsDileptonBinInResolvedTag();

std::vector<SR> getStopSignalRegionsBinInMergedTag();
std::vector<SR> getStopControlRegionsNoBTagsBinInMergedTag();
std::vector<SR> getStopControlRegionsDileptonBinInMergedTag();

std::vector<SR> getStopSignalRegionsBooleanTopTags();
std::vector<SR> getStopControlRegionsNoBTagsBooleanTopTags();
std::vector<SR> getStopControlRegionsDileptonBooleanTopTags();


std::vector<SR> getStopCrosscheckRegionsEMu();
std::vector<SR> getStopCrosscheckRegionsEMuRun2();
std::vector<SR> getStopInclusiveRegionsTopological();
std::vector<SR> getStopInclusiveControlRegionsNoBTags();
std::vector<SR> getStopInclusiveControlRegionsDilepton();

#endif // STOPREGIONS_H
