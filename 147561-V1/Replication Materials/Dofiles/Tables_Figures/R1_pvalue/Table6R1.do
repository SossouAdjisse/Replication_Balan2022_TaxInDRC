***********
* Table 6 *
***********

	* Load data and define variables
	use "${repldir}/Data/03_clean_combined/analysis_data.dta", clear
	*keep if tmt==1 | tmt==2 | tmt==3

	cap drop visit_post_carto
	gen visit_post_carto=0 if visited==0 | (visits!=0 & visits!=.)
	replace visit_post_carto=1 if visits!=. & visits>1
	
	cap drop nb_visit_post_carto
	gen nb_visit_post_carto=0 if visits!=. | visited==0
	replace nb_visit_post_carto=visits-1 if visits!=. & visits>1
	replace nb_visit_post_carto=. if nb_visit_post_carto==99998
	replace nb_visit_post_carto = . if visit_post_carto==.
	
	gen visits_other_dummy=visits_other1a
	replace visits_other_dummy=visits_other2a if visits_other1a==. & visits_other2a!=. 
	label var visits_other_dummy "Talked to collectors about Property Tax"
	gen visits_other_nb=visits_other1b
	replace visits_other_nb= visits_other2b if visits_other_nb==.
	replace visits_other_nb=0 if visits_other_dummy==0
	label var visits_other_nb "Talked to collectors about Property Tax  Nb of times"
	
	egen time_FE_tdm_2mo_CvL = cut(today_alt),at(21355 21415 21475 21529) icodes
	egen time_FE_tdm_2mo_CvCLI = cut(today_alt),at(21365.5 21425.5 21485.5 21515.5) icodes
	
	eststo clear
	label var t_l "Local"
	
	* Visits - Extensive CvL

	eststo r1: reg visit_post_carto i.tmt i.house i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), cl(a7)
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
		matrix pvalues = r(p) // save the p-values from ritest
		mat colnames pvalues = 2.tmt  // name p-values so that esttab knows to which coefficient they belong
		est restore r1 
		estadd matrix pvalues = pvalues
		esttab r1, cells(b p(par) pvalues(par([ ])))
		su visit_post_carto if t_c==1 & time_FE_tdm_2mo_CvL!=.
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		estadd scalar Clusters = `e(N_clust)'
	
	* Visits - Intensive CvL
	eststo r2: reg nb_visit_post_carto i.tmt i.house i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), cl(a7)
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
		matrix pvalues = r(p) // save the p-values from ritest
		mat colnames pvalues = 2.tmt  // name p-values so that esttab knows to which coefficient they belong
		est restore r2 
		estadd matrix pvalues = pvalues
		esttab r2, cells(b p(par) pvalues(par([ ])))
		su nb_visit_post_carto if t_c==1 & time_FE_tdm_2mo_CvL!=.
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		estadd scalar Clusters = `e(N_clust)'
		
	* Visits Other Contact - Extensive CvL
	eststo r3: reg visits_other_dummy i.tmt i.house i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), cl(a7)
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
		matrix pvalues = r(p) // save the p-values from ritest
		mat colnames pvalues = 2.tmt  // name p-values so that esttab knows to which coefficient they belong
		est restore r3 
		estadd matrix pvalues = pvalues
		esttab r3, cells(b p(par) pvalues(par([ ])))
		su visits_other_dummy if t_c==1 & time_FE_tdm_2mo_CvL!=.
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		estadd scalar Clusters = `e(N_clust)'
	
	* Visits Other Contact - Intensive CvL
	eststo r4: reg visits_other_nb i.tmt i.house i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), cl(a7)
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
		matrix pvalues = r(p) // save the p-values from ritest
		mat colnames pvalues = 2.tmt  // name p-values so that esttab knows to which coefficient they belong
		est restore r4 
		estadd matrix pvalues = pvalues
		esttab r4, cells(b p(par) pvalues(par([ ])))
		su visits_other_nb if t_c==1 & time_FE_tdm_2mo_CvL!=.
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		estadd scalar Clusters = `e(N_clust)'
	
	* Latex output
	esttab r1 r2 r3 r4 using "${reploutdir}/main_visits_results6R1_pv.tex", ///
	replace label booktabs b(%9.3f) p(%9.3f) ///
	keep (2.tmt) ///
	order(2.tmt) /// 
	cells("b(fmt(a3))"  "p(fmt(a3) par)" "pvalues(fmt(%9.3f) par([ ]))") /// 
	scalar(Clusters Mean) sfmt(0 3 3) ///
	nomtitles ///
	mgroups("Visited Post Carto" "Visits Post Carto" "Visited Other Contact"  "Visits Other Contact", pattern(1 1 1 1) prefix(\multicolumn{@span}{c}{) suffix(}) span) ///
	indicate("Month FE = *2mo*""House FE = *house*""Stratum FE = *stratum*") ///
	star(* 0.10 ** 0.05 *** 0.001) ///
	nogaps nonotes compress

	* CSV Output
	esttab r1 r2 r3 r4 using "${reploutdir}/main_visits_results6R1_pv.csv", ///
	replace label b(%9.3f) p(%9.3f) ///
	keep (2.tmt) ///
	order(2.tmt) /// 
	cells("b(fmt(a3))"  "p(fmt(a3) par)" "pvalues(fmt(%9.3f) par([ ]))") /// 
	scalar(Clusters Mean) sfmt(0 3 3) ///
	mtitles("Visited Post Carto" "Visits Post Carto" "Visited Other Contact"  "Visits Other Contact") ///
	indicate("Month FE = *2mo*""House FE = *house*""Stratum FE = *stratum*") ///
	star(* 0.10 ** 0.05 *** 0.001) ///
	nogaps nonotes compress

