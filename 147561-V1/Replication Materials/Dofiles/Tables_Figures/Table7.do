***********
* Table 7 *
***********
	
	// CvCLI Compliance and revenues

	use "${repldir}/Data/03_clean_combined/analysis_data.dta", clear
	
	keep if tmt==1 | tmt==2 | tmt==3
	
	cap drop visit_post_carto
	gen visit_post_carto=0 if visited==0 | (visits!=0 & visits!=.)
	replace visit_post_carto=1 if visits!=. & visits>1
	
	cap drop nb_visit_post_carto
	gen nb_visit_post_carto=0 if visits!=. | visited==0
	replace nb_visit_post_carto=visits-1 if visits!=. & visits>1
	replace nb_visit_post_carto=. if nb_visit_post_carto==99998
	replace nb_visit_post_carto = . if visit_post_carto==.

	egen time_FE_tdm_2mo_CvCLI = cut(today_alt),at(21365.5 21425.5 21485.5 21519) icodes
	egen time_FE_tdm_2mo_LvCLI = cut(today_alt),at(21370.5 21430.5 21490.5 21522) icodes
	egen time_FE_tdm_2mo_CvLvCLI = cut(today_alt),at(21363.6 21423.6 21483.6 21524.3) icodes
	
	eststo clear
	label var t_cli "Central Plus Local Info"
	
	* Month FE - Compliance
	eststo r1: reg taxes_paid t_cli i.house i.stratum i.time_FE_tdm_2mo_CvCLI if inlist(tmt,1,3), cl(a7)
	su taxes_paid if t_c==1 & time_FE_tdm_2mo_CvCLI!=.
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Revenues
	eststo r2: reg taxes_paid_amt t_cli i.house i.stratum i.time_FE_tdm_2mo_CvCLI if inlist(tmt,1,3), cl(a7)
	su taxes_paid_amt if t_c==1 & time_FE_tdm_2mo_CvCLI!=.
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Visited
	eststo r3: reg visit_post_carto t_cli i.house i.stratum i.time_FE_tdm_2mo_CvCLI if inlist(tmt,1,3), cl(a7)
	su visit_post_carto if t_c==1 & time_FE_tdm_2mo_CvCLI!=.
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Visits
	eststo r4: reg nb_visit_post_carto t_cli i.house i.stratum i.time_FE_tdm_2mo_CvCLI if inlist(tmt,1,3), cl(a7)
	su nb_visit_post_carto if t_c==1 & time_FE_tdm_2mo_CvCLI!=.
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Compliance Conditional on Visited
	eststo r5: reg taxes_paid t_cli i.house i.stratum i.time_FE_tdm_2mo_CvCLI if inlist(tmt,1,3) & visit_post_carto==1, cl(a7)
	su taxes_paid if t_c==1 & time_FE_tdm_2mo_CvCLI!=. & visit_post_carto==1
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Compliance CvLvCLI
	eststo r6: reg taxes_paid t_cli t_l i.house i.stratum i.time_FE_tdm_2mo_CvLvCLI if inlist(tmt,1,2,3), cl(a7)
	test t_cli = t_l
	local p_CLIvC = `r(p)'
	su taxes_paid if t_c==1 & time_FE_tdm_2mo_CvLvCLI!=.
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	estadd local CLIvC_p = `p_CLIvC'
	
	esttab r1 r2 r3 r4 r5 r6 using "${reploutdir}/main_centralwinfo_results.tex", ///
	replace label b(%9.3f) p(%9.3f) booktabs ///
	keep (t_cli t_l) ///
	order(t_cli t_l) ///
	scalar(Clusters Mean CLIvC_p) sfmt(0 3 3 3 3) ///
	nomtitles ///
	mgroups("Tax Compliance" "Tax Amount" "Visited" "Visits" "Compliance" "Compliance", pattern(1 1 1 1 1 1) prefix(\multicolumn{@span}{c}{) suffix(}) span) ///
	indicate("Time FE = *2mo*""House FE = *house*""Stratum FE = *stratum*") ///
	star(* 0.10 ** 0.05 *** 0.001) ///
	nogaps nonotes compress
	
	
	

