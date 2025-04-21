
*************
* Table A26 *
*************

	use "${repldir}/Data/03_clean_combined/analysis_data.dta", clear
	
// CvL Compliance and revenues - Figures and Tables
		
	*keep if tmt==1 | tmt==2 | tmt==3
	
	* Outcome
	g taxes_paid_carto = 0 if taxes_paid!=.
	replace taxes_paid_carto = 1 if collect_success==1
	
	g taxes_paid_amt_carto = amt_paid
	replace taxes_paid_amt_carto = 0 if taxes_paid_carto==0
	
	* Define FE
	sum today_alt
	local tdm_min = `r(min)'
	local tdm_max = `r(max)'+1
	
	egen time_FE_tdm_2mo_CvL = cut(today_alt),at(21355 21415 21475 21532) icodes
	egen time_FE_tdm_2mo_CvCLI = cut(today_alt),at(21365.5 21425.5 21485.5 21519) icodes
	egen time_FE_tdm_2mo_LvCLI = cut(today_alt),at(21370.5 21430.5 21490.5 21522) icodes
	egen time_FE_tdm_2mo_CvLvCLI = cut(today_alt),at(21363.6 21423.6 21483.6 21524.3) icodes
	
	eststo clear
	label var t_l "Local"
	
	* No House FE - Compliance during Carto
	eststo r1: reg taxes_paid_carto 2.tmt i.stratum if inlist(tmt,1,2), cl(a7)
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum) nodots: `e(cmdline)'
		matrix pvalues = r(p) 
		mat colnames pvalues = 2.tmt 
		est restore r1
		estadd matrix pvalues = pvalues
		esttab r1, cells(b p(par) pvalues(par([ ])))
	su taxes_paid_carto if t_c==1
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* Normal - Compliance during Carto
	eststo r2: reg taxes_paid_carto 2.tmt i.house i.stratum if inlist(tmt,1,2), cl(a7)
		ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum) nodots: `e(cmdline)'
		matrix pvalues = r(p) 
		mat colnames pvalues = 2.tmt 
		est restore r2
		estadd matrix pvalues = pvalues
		esttab r2, cells(b p(par) pvalues(par([ ])))
	su taxes_paid_carto if t_c==1
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Compliance
	eststo r3: reg taxes_paid_carto 2.tmt i.house i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), cl(a7)
		ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum) nodots: `e(cmdline)'
		matrix pvalues = r(p) 
		mat colnames pvalues = 2.tmt 
		est restore r3 
		estadd matrix pvalues = pvalues
		esttab r3, cells(b p(par) pvalues(par([ ])))
	su taxes_paid_carto if t_c==1 & time_FE_tdm_2mo_CvL!=.
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* No House FE - Revenues
	eststo r4: reg taxes_paid_amt_carto 2.tmt i.stratum if inlist(tmt,1,2), cl(a7)
		ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum) nodots: `e(cmdline)'
		matrix pvalues = r(p) 
		mat colnames pvalues = 2.tmt 
		est restore r4
		estadd matrix pvalues = pvalues
		esttab r4, cells(b p(par) pvalues(par([ ])))
	su taxes_paid_amt_carto if t_c==1
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* Normal - Revenues
	eststo r5: reg taxes_paid_amt_carto 2.tmt i.house i.stratum if inlist(tmt,1,2), cl(a7)
		ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum) nodots: `e(cmdline)'
		matrix pvalues = r(p) 
		mat colnames pvalues = 2.tmt 
		est restore r5
		estadd matrix pvalues = pvalues
		esttab r5, cells(b p(par) pvalues(par([ ])))
	su taxes_paid_amt_carto if t_c==1
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Revenues
	eststo r6: reg taxes_paid_amt_carto 2.tmt i.house i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), cl(a7)
		ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum) nodots: `e(cmdline)'
		matrix pvalues = r(p) 
		mat colnames pvalues = 2.tmt 
		est restore r6
		estadd matrix pvalues = pvalues
		esttab r6, cells(b p(par) pvalues(par([ ])))
	su taxes_paid_amt_carto if t_c==1 & time_FE_tdm_2mo_CvL!=.
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	esttab r1 r2 r3 r4 r5 r6 using "${reploutdir}/pay_registrationR.tex", ///
	replace label b(%9.3f) p(%9.3f) ///
	keep (2.tmt) ///
	order(2.tmt) ///
	cells("b(fmt(a6))"  "p(fmt(a3) par)" "pvalues(fmt(%9.6f) par([ ]))") /// 
	scalar(Clusters Mean) sfmt(0 3 3) ///
	nomtitles ///
	mgroups("Tax Compliance" "Tax Compliance" "Tax Compliance" "Tax Amount" "Tax Amount" "Tax Amount", pattern(1 1 1 1 1 1) prefix(\multicolumn{@span}{c}{) suffix(}) span) ///
	indicate("Month FE = *2mo*""House FE = *house*""Stratum FE = *stratum*") ///
	star(* 0.10 ** 0.05 *** 0.001) ///
	nogaps nonotes compress
