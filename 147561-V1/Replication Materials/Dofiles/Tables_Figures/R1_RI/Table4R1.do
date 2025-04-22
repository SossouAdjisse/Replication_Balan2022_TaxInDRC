***********
* Table 4 *
* This table replicates Table 4 using randomized inference approach.
***********

use "${repldir}/Data/03_clean_combined/analysis_data.dta", clear

	* keep if tmt==1 | tmt==2 | tmt==3 // Commented by Sossou
	
	* Define FE
	sum today_alt
	local tdm_min = `r(min)'
	local tdm_max = `r(max)'+1
	
	egen time_FE_tdm_2mo_CvL = cut(today_alt),at(21355 21415 21475 21532) icodes
	
	
	eststo clear
	label var t_l "Local"
	


**************
* Compliance *
**************
// tmt = treatments : Control, Central, Local,  CLI, CXL ----> added by Sossou

	* Normal - Compliance - No house FE
	eststo r11: reg taxes_paid i.tmt i.stratum if inlist(tmt,1,2), cl(a7)  	
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
		matrix pvalues = r(p) // save the p-values from ritest
		mat colnames pvalues = 2.tmt  // name p-values so that esttab knows to which coefficient they belong
		est restore r11 
		estadd matrix pvalues = pvalues
		esttab r11, cells(b p(par) pvalues(par([ ])))
		su taxes_paid if t_c==1
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Compliance - No house FE
	eststo r21: reg taxes_paid i.tmt i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), cl(a7)
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
		matrix pvalues = r(p)
		mat colnames pvalues = 2.tmt
		est restore r21 
		estadd matrix pvalues = pvalues
		esttab r21, cells(b p(par) pvalues(par([ ])))
		su taxes_paid if t_c==1 & time_FE_tdm_2mo_CvL!=.
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Compliance - No house FE - Polygon Mean
	preserve
		drop if time_FE_tdm_2mo_CvL==.
		collapse (mean) taxes_paid (min) time_FE_tdm_2mo_CvL (max) t_l t_c stratum,by(a7 tmt)
		eststo r31: reg taxes_paid i.tmt i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), robust
		ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
			matrix pvalues = r(p)
			mat colnames pvalues = 2.tmt
			est restore r31 
			estadd matrix pvalues = pvalues
			esttab r31, cells(b p(par) pvalues(par([ ])))
			su taxes_paid if t_c==1 & time_FE_tdm_2mo_CvL!=.
			estadd local Mean=abs(round(`r(mean)',.001))
			estadd scalar Observations = `e(N)'
			*estadd scalar Clusters = `e(N_clust)'
	restore

	* Month FE - Compliance - House FE
	eststo r41: reg taxes_paid i.tmt i.stratum i.house i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), cl(a7)
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
		matrix pvalues = r(p)
		mat colnames pvalues = 2.tmt
		est restore r41 
		estadd matrix pvalues = pvalues
		esttab r41, cells(b p(par) pvalues(par([ ])))
		su taxes_paid if t_c==1 & time_FE_tdm_2mo_CvL!=.
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Compliance - House FE - Condition Exempt
	eststo r51: reg taxes_paid i.tmt i.stratum i.house i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2) & exempt!=1, cl(a7)
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
		matrix pvalues = r(p)
		mat colnames pvalues = 2.tmt
		est restore r51 
		estadd matrix pvalues = pvalues
		esttab r51, cells(b p(par) pvalues(par([ ])))
		su taxes_paid if t_c==1 & time_FE_tdm_2mo_CvL!=. & exempt!=1
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		estadd scalar Clusters = `e(N_clust)'
	
* Latex Output
	esttab r11 r21 r31 r41 r51 using "${reploutdir}/main_compliance_results4R1.tex", ///
	replace label booktabs b(%9.3f) se(%9.3f) ///
	keep (2.tmt) ///
	order(2.tmt) /// 
	cells("b(fmt(a3))"  "se(fmt(a3) par)" "pvalues(fmt(%9.3f) par([ ]))") /// 
	scalar(Clusters Mean) sfmt(0 3 3) ///
	nomtitles ///
	mgroups("Tax Compliance" "Tax Compliance" "Tax Compliance" "Tax Compliance" "Tax Compliance", pattern(1 1 1 1 1) prefix(\multicolumn{@span}{c}{) suffix(}) span) ///
	indicate("Month FE = *2mo*""House FE = *house*""Stratum FE = *stratum*") ///
	star(* 0.10 ** 0.05 *** 0.001) ///
	nogaps nonotes compress
	
* CSV  Output 
	esttab r11 r21 r31 r41 r51 using "${reploutdir}/main_compliance_results4R1.csv", ///
	replace label b(%9.3f) se(%9.3f) ///
	keep (2.tmt) ///
	order(2.tmt) /// 
	cells("b(fmt(a3))"  "se(fmt(a3) par)" "pvalues(fmt(%9.3f) par([ ]))") /// 
	scalar(Clusters Mean) sfmt(0 3 3) ///
	mtitles("Tax Compliance" "Tax Compliance" "Tax Compliance" "Tax Compliance" "Tax Compliance") ///
	indicate("Month FE = *2mo*""House FE = *house*""Stratum FE = *stratum*") ///
	star(* 0.10 ** 0.05 *** 0.001) ///
	nogaps nonotes compress



* END REPLICATION * 	
	
************
* Revenues *
************
	
	eststo clear
	label var t_l "Local"
	
	* Normal - Revenues - No house FE
	eststo r12: reg taxes_paid_amt i.tmt i.stratum if inlist(tmt,1,2), cl(a7)  
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
		matrix pvalues = r(p) // save the p-values from ritest
		mat colnames pvalues = 2.tmt  // name p-values so that esttab knows to which coefficient they belong
		est restore r12 
		estadd matrix pvalues = pvalues
		esttab r12, cells(b p(par) pvalues(par([ ])))
		su taxes_paid_amt if t_c==1
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Revenues - No house FE
	eststo r22: reg taxes_paid_amt i.tmt i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), cl(a7) 
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
		matrix pvalues = r(p) // save the p-values from ritest
		mat colnames pvalues = 2.tmt  // name p-values so that esttab knows to which coefficient they belong
		est restore r22
		estadd matrix pvalues = pvalues
		esttab r22, cells(b p(par) pvalues(par([ ])))
		su taxes_paid_amt if t_c==1 & time_FE_tdm_2mo_CvL!=.
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Revenues - No house FE - Polygon Mean
	preserve
		drop if time_FE_tdm_2mo_CvL==.
		collapse (mean) taxes_paid_amt (min) time_FE_tdm_2mo_CvL (max) t_l t_c stratum,by(a7 tmt)
		eststo r32: reg taxes_paid_amt i.tmt i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), robust 
		ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
			matrix pvalues = r(p) // save the p-values from ritest
			mat colnames pvalues = 2.tmt  // name p-values so that esttab knows to which coefficient they belong
			est restore r32 
			estadd matrix pvalues = pvalues
			esttab r32, cells(b p(par) pvalues(par([ ])))
			su taxes_paid_amt if t_c==1 & time_FE_tdm_2mo_CvL!=.
			estadd local Mean=abs(round(`r(mean)',.001))
			estadd scalar Observations = `e(N)'
	* estadd scalar Clusters = `e(N_clust)'
	restore
	
	* Month FE - Revenues - House FE
	eststo r42: reg taxes_paid_amt i.tmt i.stratum i.house i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), cl(a7)
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
		matrix pvalues = r(p) // save the p-values from ritest
		mat colnames pvalues = 2.tmt  // name p-values so that esttab knows to which coefficient they belong
		est restore r42 
		estadd matrix pvalues = pvalues
		esttab r42, cells(b p(par) pvalues(par([ ])))
		su taxes_paid_amt if t_c==1 & time_FE_tdm_2mo_CvL!=.
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Revenues - House FE - Condition Exempt
	eststo r52: reg taxes_paid_amt i.tmt i.stratum i.house i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2) & exempt!=1, cl(a7) 
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
		matrix pvalues = r(p) // save the p-values from ritest
		mat colnames pvalues = 2.tmt  // name p-values so that esttab knows to which coefficient they belong
		est restore r52 
		estadd matrix pvalues = pvalues
		esttab r52, cells(b p(par) pvalues(par([ ])))
		su taxes_paid_amt if t_c==1 & time_FE_tdm_2mo_CvL!=. & exempt!=1
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		estadd scalar Clusters = `e(N_clust)'
		
* Latex Output
	esttab r12 r22 r32 r42 r52 using "${reploutdir}/main_revenues_results4R1.tex", /// 
	replace label booktabs b(%9.3f) se(%9.3f) ///
	keep (2.tmt) ///
	order(2.tmt) /// 
	cells("b(fmt(a3))"  "se(fmt(a3) par)" "pvalues(fmt(%9.3f) par([ ]))") ///
	scalar(Clusters Mean) sfmt(0 3 3) ///
	nomtitles ///
	mgroups("Revenues" "Revenues" "Revenues" "Revenues" "Revenues", pattern(1 1 1 1 1) prefix(\multicolumn{@span}{c}{) suffix(}) span) ///
	indicate("Month FE = *2mo*""House FE = *house*""Stratum FE = *stratum*") ///
	star(* 0.10 ** 0.05 *** 0.001) ///
	nogaps nonotes compress

 * CSV Output
	esttab r12 r22 r32 r42 r52 using "${reploutdir}/main_revenues_results4R1.csv", ///
	replace label b(%9.3f) se(%9.3f) ///
	keep (2.tmt) ///
	order(2.tmt) /// 
	cells("b(fmt(a3))"  "se(fmt(a3) par)" "pvalues(fmt(%9.3f) par([ ]))") ///
	scalar(Clusters Mean) sfmt(0 3 3) ///
	mtitles("Revenues" "Revenues" "Revenues" "Revenues" "Revenues") ///
	indicate("Month FE = *2mo*""House FE = *house*""Stratum FE = *stratum*") ///
	star(* 0.10 ** 0.05 *** 0.001) ///
	nogaps nonotes compress

