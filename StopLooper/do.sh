#!/bin/bash

RunningJobs=`jobs | grep runStopLooper`
if [[ $RunningJobs == "" ]]; then
    make -j 12 || return $?
else
    echo "Running looper jobs exist, will not re-build the looper."
    read -p "Do append jobs? (use Ctrl-c to break if not) " dummy
    unset dummy
fi

LOGDIR=logs

skimtype=skimmed
# skimtype=merged

OUTDIR18=$OUTDIR

OUTDIR18=output/samp18_v37_s4
OUTDIR17=output/samp17_v37_s4
OUTDIR16=output/samp16_v37_s4
OUTDIRRUN2=output/combRun2_v37_s4

run18data=1
run18bkg=1
run18sig=1

run17data=1
run17bkg=1
run17sig=1

run16data=1
run16bkg=1
run16sig=1

# OUTDIRRUN2=""

function runLooperJobs {
    mkdir -p ${OUTDIR}; mkdir -p ${LOGDIR}
    for SAMPLE in ${Samples[@]}; do
        # ./runStopLooper ${INDIR} ${SAMPLE} ${OUTDIR}
        echo ./runStopLooper ${INDIR} ${SAMPLE} ${OUTDIR} '>&' ${LOGDIR}/log_${SAMPLE}.txt
        eval "nohup nice -n -10 ./runStopLooper ${INDIR} ${SAMPLE} ${OUTDIR} >& ${LOGDIR}/log_${SAMPLE}.txt &"
    done
}

########################
# 2018 Data

INDIR=/nfs-7/userdata/sicheng/stopbabies/$skimtype/data_v30_7
OUTDIR=$OUTDIR18
# INDIR=/nfs-7/userdata/sicheng/stopbabies/merged/data_v30_3/jetht
# OUTDIR=output/jetht_v30
LOGDIR=$OUTDIR/logs

declare -a Samples=(data_2018A data_2018B data_2018C data_2018D)
# declare -a Samples=(data_2018 data_2017 data_2016)

[[ $run18data == 1 ]] && runLooperJobs

########################
# 2018 MC

# INDIR=/nfs-7/userdata/sicheng/stopbabies/$skimtype/f17v2_v30_7
INDIR=/nfs-7/userdata/sicheng/stopbabies/$skimtype/a18v1_v30_7
# OUTDIR=output/samp18_v30
# LOGDIR=$OUTDIR/logs

# # declare -a Samples=(TTJets_amcnlo_0 TTJets_amcnlo_1 TTJets_amcnlo_2)
declare -a Samples=()
Samples+=( TTJets_2lep_a18v1_0 TTJets_2lep_a18v1_1 TTJets_2lep_a18v1_2 )
Samples+=( TTJets_1lep_top TTJets_1lep_tbar )
Samples+=( ST_tW_top ST_tW_tbar ST_schan ST_tchan )   # singleT (missing some)
Samples+=( W1Jets W2Jets W3Jets W4Jets DYJets )       # Vjets : Wjets + DY
Samples+=( TTZToLLNuNu TTWJetsToLNu )      # rare  : ttV
# Samples+=( WZTo1L3Nu WZTo3LNu WZTo2L2Q WWToLNuQQ WWTo2L2Nu )   # diboson
Samples+=( WZTo3LNu ZZTo2L2Nu )   # diboson

[[ $run18bkg == 1 ]] && runLooperJobs

########################
# 2018 Signal <-- use f17v2_ext1 until a18 ones come out

INDIR=/nfs-7/userdata/sicheng/stopbabies/$skimtype/f17v2_v30_8
# declare -a Samples=(T2tt_mStop850_mLSP100 T2tt_mStop650_mLSP350 T2tt_mStop1200_mLSP100)
declare -a Samples=()
Samples+=( SMS_T2tt_mStop1200to2000_f17v2_ext1_0 SMS_T2tt_mStop1200to2000_f17v2_ext1_1 SMS_T2tt_mStop1200to2000_f17v2_ext1_2 )
Samples+=( SMS_T2tt_mStop1200to2000_f17v2_ext1_3 SMS_T2tt_mStop1200to2000_f17v2_ext1_4 )
Samples+=( SMS_T2tt_mStop400to1200_f17v2_ext1_0 SMS_T2tt_mStop400to1200_f17v2_ext1_1 SMS_T2tt_mStop400to1200_f17v2_ext1_2 )
Samples+=( SMS_T2tt_mStop400to1200_f17v2_ext1_3 SMS_T2tt_mStop400to1200_f17v2_ext1_4 SMS_T2tt_mStop400to1200_f17v2_ext1_5 )
Samples+=( SMS_T2tt_mStop400to1200_f17v2_ext1_6 SMS_T2tt_mStop400to1200_f17v2_ext1_7 SMS_T2tt_mStop400to1200_f17v2_ext1_8 )
Samples+=( SMS_T2tt_mStop400to1200_f17v2_ext1_9 )
Samples+=( SMS_T2tt_mStop350to400_f17v2_ext1_0 SMS_T2tt_mStop350to400_f17v2_ext1_1 SMS_T2tt_mStop350to400_f17v2_ext1_2 )
Samples+=( SMS_T2tt_mStop350to400_f17v2_ext1_3 SMS_T2tt_mStop350to400_f17v2_ext1_4 SMS_T2tt_mStop350to400_f17v2_ext1_5 )
Samples+=( SMS_T2tt_mStop350to400_f17v2_ext1_6 )
Samples+=( SMS_T2tt_mStop250to350_f17v2_ext1_0 SMS_T2tt_mStop250to350_f17v2_ext1_1 SMS_T2tt_mStop250to350_f17v2_ext1_2 )
Samples+=( SMS_T2tt_mStop250to350_f17v2_ext1_3 SMS_T2tt_mStop250to350_f17v2_ext1_4 SMS_T2tt_mStop250to350_f17v2_ext1_5 )
Samples+=( SMS_T2tt_mStop150to250_f17v2_ext1_0 SMS_T2tt_mStop150to250_f17v2_ext1_1 SMS_T2tt_mStop150to250_f17v2_ext1_2 )

[[ $run18sig == 1 ]] && runLooperJobs

########################
# 2017 Data

# INDIR=/nfs-7/userdata/haweber/stopbabiesInteractive/2017_5p8fbinv
# INDIR=/nfs-7/userdata/haweber/tupler_babies/merged/Stop_1l/v2017/output/
# INDIR=/nfs-7/userdata/sicheng/stopbabies/$skimtype/data_v30_5s
INDIR=/nfs-7/userdata/sicheng/stopbabies/$skimtype/data_v30_7
OUTDIR=$OUTDIR17
# OUTDIR=output/data17_v30_leptrig
LOGDIR=$OUTDIR/logs

# declare -a Samples=(data_2017F_09May)
declare -a Samples=(data_2017B data_2017C data_2017D data_2017E data_2017F_09May)

[[ $run17data == 1 ]] && runLooperJobs

########################
# 2017 MC

# INDIR=/nfs-7/userdata/sicheng/stopbabies/merged_v25_4
# INDIR=/nfs-7/userdata/sicheng/stopbabies/merged_v28_10
# INDIR=/nfs-7/userdata/sicheng/stopbabies/skimmed_v29_13
# INDIR=/nfs-7/userdata/sicheng/stopbabies/$skimtype/f17v2_v30_3
INDIR=/nfs-7/userdata/sicheng/stopbabies/$skimtype/f17v2_v30_7
# OUTDIR=output/samp17_$output17
LOGDIR=${OUTDIR}/logs

declare -a Samples=()
Samples+=( TTJets_2lep_f17v2_0 TTJets_2lep_f17v2_1 TTJets_2lep_f17v2_2 TTJets_2lep_f17v2_3 )
Samples+=( TTJets_1lep_top TTJets_1lep_tbar )
# Samples+=( TTJets_1lep_top_f17v2_0 TTJets_1lep_top_f17v2_1 TTJets_1lep_tbar_f17v2_0 TTJets_1lep_tbar_f17v2_1 )
Samples+=( ST_tW_top ST_tW_tbar ST_schan )      # singleT (missing some)
Samples+=( W1Jets W2Jets W3Jets W4Jets DYJets )       # Vjets : Wjets + DY
Samples+=( TTZToLLNuNu TTWJetsToLNu TTWJetsToQQ )      # rare  : ttV
Samples+=( WZTo1L3Nu WZTo3LNu WZTo2L2Q WWToLNuQQ WWTo2L2Nu )   # diboson

[[ $run17bkg == 1 ]] && runLooperJobs

########################
# 2017 Signal

INDIR=/nfs-7/userdata/sicheng/stopbabies/$skimtype/f17v2_v30_8
# declare -a Samples=(T2tt_mStop850_mLSP100 T2tt_mStop650_mLSP350 T2tt_mStop1200_mLSP100)
declare -a Samples=()
Samples+=( SMS_T2tt_mStop1200to2000_f17v2_ext0_0 SMS_T2tt_mStop1200to2000_f17v2_ext0_1 SMS_T2tt_mStop1200to2000_f17v2_ext0_2 )
Samples+=( SMS_T2tt_mStop400to1200_f17v2_ext0_0 SMS_T2tt_mStop400to1200_f17v2_ext0_1 SMS_T2tt_mStop400to1200_f17v2_ext0_2 )
Samples+=( SMS_T2tt_mStop400to1200_f17v2_ext0_3 SMS_T2tt_mStop400to1200_f17v2_ext0_4 )
Samples+=( SMS_T2tt_mStop400to1200_f17v2_ext0_5 SMS_T2tt_mStop400to1200_f17v2_ext0_6 )
Samples+=( SMS_T2tt_mStop350to400_f17v2_ext0_0 SMS_T2tt_mStop350to400_f17v2_ext0_1 SMS_T2tt_mStop350to400_f17v2_ext0_2 )
Samples+=( SMS_T2tt_mStop350to400_f17v2_ext0_3 SMS_T2tt_mStop350to400_f17v2_ext0_4 )
Samples+=( SMS_T2tt_mStop250to350_f17v2_ext0_0 SMS_T2tt_mStop250to350_f17v2_ext0_1 )
Samples+=( SMS_T2tt_mStop250to350_f17v2_ext0_2 SMS_T2tt_mStop250to350_f17v2_ext0_3 )
Samples+=( SMS_T2tt_mStop150to250_f17v2_ext0_0 SMS_T2tt_mStop150to250_f17v2_ext0_1 )

[[ $run17sig == 1 ]] && runLooperJobs

########################
# 2016 data

# INDIR=/nfs-7/userdata/stopRun2/analysis2016_SUS-16-051_35p9fbinv/v24/output
# INDIR=/nfs-7/userdata/sicheng/stopbabies/merged_v25_10
# INDIR=/nfs-7/userdata/sicheng/stopbabies/skimmed_v29_14
INDIR=/nfs-7/userdata/sicheng/stopbabies/$skimtype/data_v30_3
OUTDIR=$OUTDIR16
# OUTDIR=output/samp16_v30_s3
# OUTDIR=output/data16_jetht
LOGDIR=${OUTDIR}/logs
# cd ../StopCORE; cp stop_1l_babyAnalyzer.h.old stop_1l_babyAnalyzer.h; cp stop_1l_babyAnalyzer.cc.old stop_1l_babyAnalyzer.cc; mkc; cd -

# declare -a Samples=(all_2016_samples)
declare -a Samples=(data_2016B data_2016C data_2016D data_2016E data_2016F data_2016G data_2016H)
# declare -a Samples=(data_2016)

[[ $run16data == 1 ]] && runLooperJobs

########################
# 2016 MC

# # Moriond17 samples
# INDIR=/nfs-7/userdata/stopRun2/analysis2016_SUS-16-051_35p9fbinv/v22/skim
# declare -a Samples=()
# Samples+=( ttbar_diLept  )    # ttbar
# Samples+=( ttbar_singleLeptFromT_madgraph_pythia8_ext1 ttbar_singleLeptFromTbar_madgraph_pythia8_ext1 )    # ttbar
# Samples+=( t_sch_4f t_tch_4f tbar_tch t_tW_5f t_tbarW_5f ) # singleT
# Samples+=( W1Jets W2Jets W3Jets W4Jets DYJets )            # Vjets : Wjets + DY
# Samples+=( ttWJets ttZJets WW WZ ZZ )                      # rare  : ttV + diboson
# # Samples+=( Signal_T2tt )

# INDIR=/nfs-7/userdata/sicheng/stopbabies/skimmed_v25_9
# INDIR=/nfs-7/userdata/sicheng/stopbabies/skimmed_v29_11
# INDIR=/nfs-7/userdata/sicheng/stopbabies/skimmed/s16v3_v29_14
INDIR=/nfs-7/userdata/sicheng/stopbabies/$skimtype/s16v3_v30_3
# OUTDIR=output/samp16_$output16
# LOGDIR=$OUTDIR/logs

declare -a Samples=()
Samples+=( TTJets_2lep_s16v3_ext0_1 TTJets_2lep_s16v3_ext1_0 TTJets_2lep_s16v3_ext1_1 TTJets_2lep_s16v3_ext1_2 )
Samples+=( TTJets_1lep_top TTJets_1lep_tbar )
Samples+=( ST_tW_top ST_tW_tbar ST_tchan )      # singleT
Samples+=( W1Jets W2Jets W3Jets W4Jets DYJets )       # Vjets : Wjets + DY
Samples+=( TTZToLLNuNu TTWJetsToLNu WZTo1L3Nu WWTo1L1Nu2Q )  # rare  : ttV + diboson
Samples+=( WWTo2L2Nu WZTo1L1Nu2Q WZTo2L2Q WZTo3LNu_amcnlo TTWJetsToQQ TTZToQQ)      # rare : smaller contributions
# Samples+=( TTJets_1lep_tbar_s16v3_ext0_1  TTJets_1lep_tbar_s16v3_ext1_0  TTJets_1lep_tbar_s16v3_ext1_1 )
# Samples+=( TTJets_1lep_top_s16v3_ext0_1  TTJets_1lep_top_s16v3_ext1_0  TTJets_1lep_top_s16v3_ext1_1 )

[[ $run16bkg == 1 ]] && runLooperJobs

########################
# 2016 signal

INDIR=/nfs-7/userdata/sicheng/stopbabies/$skimtype/s16v3_v30_8
# INDIR=/nfs-7/userdata/stopRun2/analysis2016_SUS-16-051_35p9fbinv/v22/skim
# INDIR=/nfs-7/userdata/stopRun2/analysis2016_SUS-16-051_35p9fbinv/v22_usegenMET/skim
# OUTDIR=output/temp12
# LOGDIR=$OUTDIR/logs

declare -a Samples=()
Samples+=( SMS_T2tt_mStop1200to2000_s16v3_0 SMS_T2tt_mStop1200to2000_s16v3_1 SMS_T2tt_mStop1200to2000_s16v3_2 )
Samples+=( SMS_T2tt_mStop400to1200_s16v3_0 SMS_T2tt_mStop400to1200_s16v3_1 SMS_T2tt_mStop400to1200_s16v3_2 )
Samples+=( SMS_T2tt_mStop400to1200_s16v3_3 SMS_T2tt_mStop400to1200_s16v3_4 )
Samples+=( SMS_T2tt_mStop400to1200_s16v3_5 SMS_T2tt_mStop400to1200_s16v3_6 )
Samples+=( SMS_T2tt_mStop350to400_s16v3_0 SMS_T2tt_mStop350to400_s16v3_1 SMS_T2tt_mStop350to400_s16v3_2 )
Samples+=( SMS_T2tt_mStop350to400_s16v3_3 SMS_T2tt_mStop350to400_s16v3_4)
Samples+=( SMS_T2tt_mStop250to350_s16v3_0 SMS_T2tt_mStop250to350_s16v3_1 )
Samples+=( SMS_T2tt_mStop250to350_s16v3_2 SMS_T2tt_mStop250to350_s16v3_3 )
Samples+=( SMS_T2tt_mStop150to250_s16v3_0 SMS_T2tt_mStop150to250_s16v3_1)
# Samples+=( SMS_T2tt_400to1200_80X_0 SMS_T2tt_400to1200_80X_1 SMS_T2tt_400to1200_80X_2 )
# Samples+=( SMS_T2tt_400to1200_80X_3 SMS_T2tt_400to1200_80X_4 )
# Samples+=( SMS_T2bW_80X_0 SMS_T2bW_80X_1 SMS_T2bW_80X_2 SMS_T2bW_80X_3 SMS_T2bW_80X_4 )
# Samples+=( SMS_T2bt_80X_0 SMS_T2bt_80X_1 SMS_T2bt_80X_2 SMS_T2bt_80X_3 )

[[ $run16sig == 1 ]] && runLooperJobs

########################
# Merge output samples with hadd
########################

# Monitor the running
while : ; do
    sleep 5
    RunningJobs=`jobs | grep runStopLooper`
    [[ $RunningJobs == "" ]] && break
done

echo -e 'All looper jobs done!\a'

# pushd output/temp2018data1/
# hadd -f data_2018_all.root  data_2018?.root > /dev/null
# popd > /dev/null
# pushd output/temp2017data1/
# hadd -f data_2017_all.root  data_2017?.root > /dev/null
# popd > /dev/null
# pushd output/temp2016data9/
# # hadd -f data_2016_all.root  data_2016?.root > /dev/null
# cp data_single_lepton_met.root data_2016_all.root
# popd > /dev/null

# Local merge for the v29_11+ babies
pushd ${OUTDIR18}
[[ $run18bkg  == 1 ]] && hadd -f ttbar_18.root    TTJets*.root > /dev/null
[[ $run18bkg  == 1 ]] && hadd -f singleT_18.root  ST_*.root  > /dev/null
[[ $run18bkg  == 1 ]] && hadd -f Vjets_18.root    W?Jets*.root DYJets*.root > /dev/null
# [[ $run18bkg  == 1 ]] && hadd -f rare_18.root     TTZ*.root TTW*.root WZ*.root WW*.root > /dev/null
[[ $run18bkg  == 1 ]] && hadd -f rare_18.root     TTZ*.root TTW*.root WZ*.root > /dev/null
[[ $run18bkg  == 1 ]] && hadd -f allBkg_18.root   ttbar_18.root singleT_18.root Vjets_18.root rare_18.root > /dev/null
[[ $run18data == 1 ]] && hadd -f allData_18.root  data_2018*.root > /dev/null
[[ $run18sig  == 1 ]] && hadd -f SMS_T2tt_18.root SMS_T2tt_*to*.root > /dev/null
popd > /dev/null

# Local merge for the v29_11+ babies
pushd ${OUTDIR17}
[[ $run17bkg  == 1 ]] && hadd -f ttbar_17.root    TTJets*.root > /dev/null
[[ $run17bkg  == 1 ]] && hadd -f singleT_17.root  ST_*.root  > /dev/null
# [[ $run17bkg  == 1 ]] && hadd -f Vjets_17.root    W?Jets*.root DYJets*.root > /dev/null
[[ $run17bkg  == 1 ]] && hadd -f Vjets_17.root    W?Jets*.root > /dev/null
[[ $run17bkg  == 1 ]] && hadd -f rare_17.root     TTZ*.root TTW*.root WZ*.root WW*.root > /dev/null
[[ $run17bkg  == 1 ]] && hadd -f allBkg_17.root   ttbar_17.root singleT_17.root Vjets_17.root rare_17.root > /dev/null
# [[ $run17data == 1 ]] && hadd -f allData_17.root  data_2017?.root > /dev/null
[[ $run17data == 1 ]] && hadd -f allData_17.root  data_2017?.root data_2017F_09May.root > /dev/null
[[ $run17data == 1 ]] && hadd -f data_2017BtoE.root data_2017[B-E].root > /dev/null
[[ $run17sig  == 1 ]] && hadd -f SMS_T2tt_17.root SMS_T2tt_*to*.root > /dev/null
popd > /dev/null

pushd ${OUTDIR16}
[[ $run16bkg  == 1 ]] && hadd -f ttbar_16.root    TTJets*.root > /dev/null
[[ $run16bkg  == 1 ]] && hadd -f singleT_16.root  ST_*.root  > /dev/null
[[ $run16bkg  == 1 ]] && hadd -f Vjets_16.root    W?Jets*.root DYJets*.root > /dev/null
[[ $run16bkg  == 1 ]] && hadd -f rare_16.root     TTZ*.root TTW*.root WZ*.root WW*.root > /dev/null
[[ $run16bkg  == 1 ]] && hadd -f allBkg_16.root   ttbar_16.root singleT_16.root Vjets_16.root rare_16.root > /dev/null
[[ $run16data == 1 ]] && hadd -f allData_16.root  data_2016*.root > /dev/null
[[ $run16sig  == 1 ]] && hadd -f SMS_T2tt_16.root SMS_T2tt_*to*.root > /dev/null
# [[ $run16sig  == 1 ]] && hadd -f SMS_T2bW_16.root SMS_T2bW_*to*.root > /dev/null
# [[ $run16sig  == 1 ]] && hadd -f SMS_T2bt_16.root SMS_T2bt_*to*.root > /dev/null
popd > /dev/null

# Make combined results
if [ ! ${OUTDIRRUN2} == "" ]; then
    mkdir -p ${OUTDIRRUN2}
    cp ${OUTDIR16}/*_16.root ${OUTDIRRUN2}
    cp ${OUTDIR17}/*_17.root ${OUTDIRRUN2}
    cp ${OUTDIR18}/*_18.root ${OUTDIRRUN2}
    pushd ${OUTDIRRUN2}
    rm 1lepFrom*.root ZToNuNu_*.root lostlepton_*.root
    for isamp in *_17.root; do
        jsamp=${isamp%_17.root}
        hadd -f ${jsamp}_run2.root ${jsamp}_16.root $isamp ${jsamp}_18.root > /dev/null
    done
    popd > /dev/null
fi

# # Local merge for the moriond17 samples
# pushd output/samples2016
# hadd -f ttbar_25ns.root    ttbar*Lept*.root > /dev/null
# hadd -f singleT_25ns.root  t_t*_noHadDecays*.root t*_4f_*.root > /dev/null
# hadd -f Vjets_25ns.root    W?Jets*.root DYJets*m10To50*.root > /dev/null
# hadd -f rare_25ns.root     ttZ*.root WZ*.root ttW*.root WW*.root ZZ*.root > /dev/null
# hadd -f allBkg_25ns.root   ttbar_25ns.root singleT_25ns.root Vjets_25ns.root rare_25ns.root > /dev/null
# popd > /dev/null

echo -e 'All merge jobs done!\a'

unset RunningJobs
