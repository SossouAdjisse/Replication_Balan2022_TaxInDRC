***********
* Table 4 *
***********

 use "${repldir}/Data/03_clean_combined/analysis_data_Sossou1.dta", clear


keep if _merge > 2
drop _merge




	keep if tmt==1 | tmt==2 | tmt==3
	
	* Define FE
	sum today_alt
	local tdm_min = `r(min)'
	local tdm_max = `r(max)'+1
	
	
	* egen time_FE_tdm_2mo_CvL = cut(today_alt),at(21355 21415 21475 21532) icodes
	
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
	
	esttab using "${reploutdir}/main_compliance_results4R4_old.tex", ///
	replace label b(%9.6f) p(%9.6f) booktabs ///
	keep (t_l trust_chief interaction) ///
	order(t_l trust_chief interaction) ///
	scalar(Clusters Mean) sfmt(0 3 3) ///
	nomtitles ///
	mgroups("Tax Compliance" "Tax Compliance" "Tax Compliance" "Tax Compliance" "Tax Compliance", pattern(1 1 1 1 1) prefix(\multicolumn{@span}{c}{) suffix(}) span) ///
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
	
	esttab using "${reploutdir}/main_revenues_results4R4_old.tex", ///
	replace label b(%9.6f) p(%9.6f) booktabs ///
	keep (t_l trust_chief interaction) ///
	order(t_l trust_chief interaction) ///
	scalar(Clusters Mean) sfmt(0 3 3) ///
	nomtitles ///
	mgroups("Revenues" "Revenues" "Revenues" "Revenues" "Revenues", pattern(1 1 1 1 1) prefix(\multicolumn{@span}{c}{) suffix(}) span) ///
	indicate("Month FE = *2mo*""House FE = *house*""Stratum FE = *stratum*") ///
	star(* 0.10 ** 0.05 *** 0.001) ///
	nogaps nonotes compress
