***********
* Table 4 *
***********

 * use "${repldir}/Data/03_clean_combined/analysis_data_Sossou1.dta", clear

* Using baseline data and part of the code from the Table3.do file. 

	use "${repldir}/Data/01_base/survey_data/baseline_noPII.dta", clear
	keep if tot_complete==1 
	drop possessions

	* Education variables
	g edu_yrs = .
	replace edu_yrs = 0 if edu==0
	replace edu_yrs = 1 if edu==1
	replace edu_yrs = 6 if edu==2
	replace edu_yrs = 1+edu2 if edu2!=. & edu==2 & edu2<7 // not counting repeating grade
	replace edu_yrs = 13 if edu==3
	replace edu_yrs = 7+edu2 if edu2!=. & edu==3 & edu2<5 // not counting repeating grade
	replace edu_yrs = 17 if edu==4
	replace edu_yrs = 13+edu2 if edu2!=. & edu==4 // allow for higher values for masters/PhD
		
	* Normalized possessions
	global possessions = "possessions_1 possessions_2 possessions_3 possessions_4 possessions_5 possessions_6"
	foreach index in possessions{
	foreach var in $`index'{
	cap replace `var' = `var'_orig
	cap gen `var'_orig = `var'
	sum `var'
	replace `var' = (`var'-`r(mean)')/(`r(sd)') //standardize
	}
	egen `index' = rowtotal($`index'), missing
	sum `index'
	replace `index' = (`index' -`r(mean)')/(`r(sd)')  //standardize index
	}

	foreach var in possessions{
	sum `var', d
	g `var'_norm = (`var'-`r(min)')/(`r(max)'-`r(min)') //normalize variables
	}
	
	* Gender dummy
	gen male = sex
	replace male = 0 if male==2
	
	* log of income
	gen lg_inc_mo = log(inc_mo+1)
	
	* log of transport
	gen lg_transport = log(transport+1)
	
	* trust variables
	revrs trust8 trust4 trust5 trust6
	rename revtrust8 trust_chief
	rename revtrust4 trust_nat_gov
	rename revtrust5 trust_prov_gov
	rename revtrust6 trust_tax_min
	
	duplicates drop compound_code, force 		
	* tempfile 
	tempfile bl
	save `bl'

* Merging the main analysis data with the baseline data.
use "${repldir}/Data/03_clean_combined/analysis_data.dta", clear
rename compound1 compound_code
merge 1:1 compound_code using `bl', force 

keep if _merge > 2
drop _merge




	keep if tmt==1 | tmt==2 | tmt==3
	
	* Define FE
	sum today_alt
	local tdm_min = `r(min)'
	local tdm_max = `r(max)'+1
	
	
	egen time_FE_tdm_2mo_CvL = cut(today_alt),at(21355 21415 21475 21532) icodes
	
**************
* Compliance *
**************

	label var t_l "Local"
	label var trust_chief "Trust Chief"
	gen interaction = t_l*trust_chief
	label var interaction "Local x Trust Chief"

	eststo clear

	* Normal - Compliance - No house FE
	eststo: reg taxes_paid t_l trust_chief interaction i.stratum if inlist(tmt,1,2), cl(a7)
	su taxes_paid if t_c==1
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Compliance - No house FE
	eststo: reg taxes_paid t_l trust_chief interaction i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), cl(a7)
	su taxes_paid if t_c==1 & time_FE_tdm_2mo_CvL!=.
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Compliance - No house FE - Polygon Mean
	preserve
		drop if time_FE_tdm_2mo_CvL==.
		collapse (mean) taxes_paid trust_chief (min) time_FE_tdm_2mo_CvL (max) t_l t_c stratum,by(a7 tmt)
		eststo: reg taxes_paid t_l trust_chief i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), robust
		su taxes_paid if t_c==1 & time_FE_tdm_2mo_CvL!=.
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		*estadd scalar Clusters = `e(N_clust)'
	restore
	
	
	* Month FE - Compliance - House FE
	eststo: reg taxes_paid t_l trust_chief interaction i.stratum i.house i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), cl(a7)
	su taxes_paid if t_c==1 & time_FE_tdm_2mo_CvL!=.
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Compliance - House FE - Condition Exempt
	eststo: reg taxes_paid t_l trust_chief interaction i.stratum i.house i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2) & exempt!=1, cl(a7)
	su taxes_paid if t_c==1 & time_FE_tdm_2mo_CvL!=. & exempt!=1
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	esttab using "${reploutdir}/main_compliance_results4R4_new.tex", ///
	replace label b(%9.6f) p(%9.6f) booktabs ///
	keep (t_l trust_chief interaction) ///
	order(t_l trust_chief interaction) ///
	scalar(Clusters Mean) sfmt(0 3 3) ///
	nomtitles ///
	mgroups("Tax Compliance" "Tax Compliance" "Tax Compliance" "Tax Compliance" "Tax Compliance", pattern(1 1 1 1 1) prefix(\multicolumn{@span}{c}{) suffix(}) span) ///
	indicate("Month FE = *2mo*""House FE = *house*""Stratum FE = *stratum*") ///
	star(* 0.10 ** 0.05 *** 0.001) ///
	nogaps nonotes compress
	
* CSV Format
	esttab using "${reploutdir}/main_compliance_results4R4_new.csv", ///
	replace label b(%9.6f) p(%9.6f) ///
	keep (t_l trust_chief interaction) ///
	order(t_l trust_chief interaction) ///
	scalar(Clusters Mean) sfmt(0 3 3) ///
	mtitles("Tax Compliance" "Tax Compliance" "Tax Compliance" "Tax Compliance" "Tax Compliance") ///
	indicate("Month FE = *2mo*""House FE = *house*""Stratum FE = *stratum*") ///
	star(* 0.10 ** 0.05 *** 0.001) ///
	nogaps nonotes compress

************
* Revenues *
************
	
	eststo clear
	//label var t_l "Local"
	//label var trust_chief "Trust Chief"
	
	* Normal - Revenues - No house FE
	eststo: reg taxes_paid_amt t_l trust_chief interaction i.stratum if inlist(tmt,1,2), cl(a7)
	su taxes_paid_amt if t_c==1
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Revenues - No house FE
	eststo: reg taxes_paid_amt t_l trust_chief interaction i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), cl(a7)
	su taxes_paid_amt if t_c==1 & time_FE_tdm_2mo_CvL!=.
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Revenues - No house FE - Polygon Mean
	preserve
		drop if time_FE_tdm_2mo_CvL==.
		collapse (mean) taxes_paid_amt trust_chief (min) time_FE_tdm_2mo_CvL (max) t_l t_c stratum,by(a7 tmt)
		eststo: reg taxes_paid_amt t_l trust_chief i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), robust
		su taxes_paid_amt if t_c==1 & time_FE_tdm_2mo_CvL!=.
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		*estadd scalar Clusters = `e(N_clust)'
	restore
	
	
	* Month FE - Revenues - House FE
	eststo: reg taxes_paid_amt t_l trust_chief interaction i.stratum i.house i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), cl(a7)
	su taxes_paid_amt if t_c==1 & time_FE_tdm_2mo_CvL!=.
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Revenues - House FE - Condition Exempt
	eststo: reg taxes_paid_amt t_l trust_chief interaction i.stratum i.house i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2) & exempt!=1, cl(a7)
	su taxes_paid_amt if t_c==1 & time_FE_tdm_2mo_CvL!=. & exempt!=1
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	esttab using "${reploutdir}/main_revenues_results4R4_new.tex", ///
	replace label b(%9.6f) p(%9.6f) booktabs ///
	keep (t_l trust_chief interaction) ///
	order(t_l trust_chief interaction) ///
	scalar(Clusters Mean) sfmt(0 3 3) ///
	nomtitles ///
	mgroups("Revenues" "Revenues" "Revenues" "Revenues" "Revenues", pattern(1 1 1 1 1) prefix(\multicolumn{@span}{c}{) suffix(}) span) ///
	indicate("Month FE = *2mo*""House FE = *house*""Stratum FE = *stratum*") ///
	star(* 0.10 ** 0.05 *** 0.001) ///
	nogaps nonotes compress

* CSV Format 
	esttab using "${reploutdir}/main_revenues_results4R4_new.csv", ///
	replace label b(%9.6f) p(%9.6f) ///
	keep (t_l trust_chief interaction) ///
	order(t_l trust_chief interaction) ///
	scalar(Clusters Mean) sfmt(0 3 3) ///
	mtitles("Revenues" "Revenues" "Revenues" "Revenues" "Revenues") ///
	indicate("Month FE = *2mo*""House FE = *house*""Stratum FE = *stratum*") ///
	star(* 0.10 ** 0.05 *** 0.001) ///
	nogaps nonotes compress

