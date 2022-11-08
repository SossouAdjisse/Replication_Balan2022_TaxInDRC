	
* Use analysis data
use "${repldir}/Data/03_clean_combined/analysis_data.dta", clear

* merge information on distance between respondent and collector home
merge m:1 compound1 using  "${repldir}/Data/01_base/admin_data/hh_distances.dta", keep(match)
	
* Max distance to chief home 
su dist_chief if tmt==2

* Define FE	
egen time_FE_tdm_2mo_CvL = cut(today_alt),at(21355 21415 21475 21532) icodes
egen time_FE_tdm_2mo_CvLvCLI = cut(today_alt),at(21363.6 21423.6 21483.6 21524.3) icodes

* label variables
label var dist_col1 "Collector 1 - distance (in km)"
label var dist_col2 "Collector 2 - distance (in km)"
label var dist_col_avg "Dist. btw collectors home and nbhd"

//##########################################

drop _merge

duplicates drop compound1, force 
drop if compound1 == .

	merge m:1 compound1 using "/Users/sossousimpliceadjisse/Documents/myfiles/PaulMoussaReplicationProject/147561-V1/Replication Materials/Data/03_clean_combined/combined_data_ChiefChars_SossouModified.dta", ///
	keepusing(age_chef possessions_nb_chef educ_yrs_chef educ_lvl chef_locality chef_minority_ethnic chef_know_2016tax chef_pprd chef_party chef_udps col_gov_integrity col_view_gov_gen col_view_gov_nbhd  col_trust_dgrkoc col_trust_gov  chef_know_fired chef_gov_job chef_tenure chef_established chef_fam age_chef_hi possessions_nb_chef_hi educ_yrs_chef_hi chef_minority_ethnic chef_locality chef_established chef_fam remoteness_hi chefferie chef_party chef_pprd chef_udps chef_gov_job chef_trust_gov_hi chef_trust_dgrkoc_hi col_view_gov_gen_hi col_view_gov_nbhd_hi col_gov_integrity_hi chef_know_fired chef_know_2016tax tmt_2016 evaluation_hi connections_hi activity_hi) update replace force
	
keep if _merge > 2
drop _merge
gen chef_tenure_hi  = chef_tenure > 10


global chief_chars = "age_chef_hi possessions_nb_chef_hi educ_yrs_chef_hi remoteness_hi chef_trust_gov_hi chef_trust_dgrkoc_hi col_view_gov_gen_hi col_view_gov_nbhd_hi col_gov_integrity_hi tmt_2016 chef_fam chef_tenure_hi"


//##########################################

eststo clear

eststo: reg taxes_paid dist_col_avg $chief_chars i.house i.time_FE_tdm_2mo_CvL  if inlist(tmt,1,3), cluster(a7)
su taxes_paid if e(sample)
estadd local Mean=abs(round(`r(mean)',.001))
estadd scalar Observations = `e(N)'
estadd scalar Clusters = `e(N_clust)'

eststo: reg taxes_paid_amt dist_col_avg $chief_chars i.house i.time_FE_tdm_2mo_CvL if inlist(tmt,1,3), cluster(a7)
su taxes_paid_amt if e(sample)
estadd local Mean=abs(round(`r(mean)',.001))
estadd scalar Observations = `e(N)'
estadd scalar Clusters = `e(N_clust)'

eststo: reg taxes_paid dist_chief $chief_chars i.house  i.time_FE_tdm_2mo_CvL if inlist(tmt,2), cluster(a7)
su taxes_paid if e(sample)
estadd local Mean=abs(round(`r(mean)',.001))
estadd scalar Observations = `e(N)'
estadd scalar Clusters = `e(N_clust)'

eststo: reg taxes_paid_amt dist_chief $chief_chars i.house  i.time_FE_tdm_2mo_CvL if inlist(tmt,2), cluster(a7)
su taxes_paid_amt if e(sample)
estadd local Mean=abs(round(`r(mean)',.001))
estadd scalar Observations = `e(N)'
estadd scalar Clusters = `e(N_clust)'

esttab using "$reploutdir/dist_collectorsR1.tex", scalars(Observations Clusters Mean) sfmt(0 0 3)  nocons noobs l b(3) se(3) compress nogap r2 nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
indicate("Time FE = *time_FE_tdm_2mo_CvL*" "House FE = *house*") ///
nonumbers replace

************************************************************************
* Appendix Table: Local v. Central collectors working near their homes *
************************************************************************

eststo clear

eststo: reg taxes_paid t_l $chief_chars i.house i.time_FE_tdm_2mo_CvL if ((inlist(tmt,1) & (dist_col1<=1.589859 | dist_col2<=1.589859)) | inlist(tmt,2)), cluster(a7)
su taxes_paid if e(sample) & tmt==1
estadd local Mean=abs(round(`r(mean)',.001))
estadd scalar Observations = `e(N)'
estadd scalar Clusters = `e(N_clust)'

eststo: reg taxes_paid_amt t_l $chief_chars i.house i.time_FE_tdm_2mo_CvL if ((inlist(tmt,1) & (dist_col1<=1.589859 | dist_col2<=1.589859)) | inlist(tmt,2)) , cluster(a7)
su taxes_paid_amt if e(sample) & tmt==1
estadd local Mean=abs(round(`r(mean)',.001))
estadd scalar Observations = `e(N)'
estadd scalar Clusters = `e(N_clust)'

eststo: reg taxes_paid t_l $chief_chars i.house i.time_FE_tdm_2mo_CvL  if ((inlist(tmt,1) & (dist_col1>1.589859 & dist_col2>1.589859)) | inlist(tmt,2)) , cluster(a7)
su taxes_paid if e(sample) & tmt==1
estadd local Mean=abs(round(`r(mean)',.001))
estadd scalar Observations = `e(N)'
estadd scalar Clusters = `e(N_clust)'

eststo: reg taxes_paid_amt t_l $chief_chars i.house i.time_FE_tdm_2mo_CvL  if ((inlist(tmt,1) & (dist_col1>1.589859 & dist_col2>1.589859)) | inlist(tmt,2)) , cluster(a7)
su taxes_paid_amt if e(sample) & tmt==1
estadd local Mean=abs(round(`r(mean)',.001))
estadd scalar Observations = `e(N)'
estadd scalar Clusters = `e(N_clust)'

esttab using "$reploutdir/collectors_C_near_homeR1.tex", scalars(Observations Clusters Mean) sfmt(0 0 3)  nocons noobs l b(3) se(3) compress nogap r2 nonotes star(* 0.10 ** 0.05 *** 0.01)  ///
indicate("Time FE = *time_FE_tdm_2mo_CvL*" "House FE = *house*") ///
nonumbers replace

eststo clear

eststo: reg taxes_paid t_l $chief_chars i.house i.time_FE_tdm_2mo_CvLvCLI if ((inlist(tmt,1,3) & (dist_col1<=1.589859 | dist_col2<=1.589859)) | inlist(tmt,2)), cluster(a7)
su taxes_paid if e(sample) & tmt==1
estadd local Mean=abs(round(`r(mean)',.001))
estadd scalar Observations = `e(N)'
estadd scalar Clusters = `e(N_clust)'

eststo: reg taxes_paid_amt t_l $chief_chars i.house i.time_FE_tdm_2mo_CvLvCLI if ((inlist(tmt,1,3) & (dist_col1<=1.589859 | dist_col2<=1.589859)) | inlist(tmt,2)) , cluster(a7)
su taxes_paid_amt if e(sample) & tmt==1
estadd local Mean=abs(round(`r(mean)',.001))
estadd scalar Observations = `e(N)'
estadd scalar Clusters = `e(N_clust)'

eststo: reg taxes_paid t_l $chief_chars i.house i.time_FE_tdm_2mo_CvLvCLI  if ((inlist(tmt,1,3) & (dist_col1>1.589859 & dist_col2>1.589859)) | inlist(tmt,2)) , cluster(a7)
su taxes_paid if e(sample) & tmt==1
estadd local Mean=abs(round(`r(mean)',.001))
estadd scalar Observations = `e(N)'
estadd scalar Clusters = `e(N_clust)'

eststo: reg taxes_paid_amt t_l $chief_chars i.house i.time_FE_tdm_2mo_CvLvCLI if ((inlist(tmt,1,3) & (dist_col1>1.589859 & dist_col2>1.589859)) | inlist(tmt,2)) , cluster(a7)
su taxes_paid_amt if e(sample) & tmt==1
estadd local Mean=abs(round(`r(mean)',.001))
estadd scalar Observations = `e(N)'
estadd scalar Clusters = `e(N_clust)'

esttab using "$reploutdir/collectors_C_CLI_near_homeR1.tex", scalars(Observations Clusters Mean) sfmt(0 0 3)  nocons noobs l b(3) se(3) compress nogap r2 nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
indicate("Time FE = *time_FE_tdm_2mo_CvL*" "House FE = *house*") ///
nonumbers replace


