********************************************************************************
* Program: 0_Master.do
* Author: Gabriel Tourek
* Created: 6 Aug 2021
* Modified: 		
* Purpose: Replication of "Local Elites as State Capacity: How City Chiefs Use 
*          Local Information to Increase Tax Compliance in the D.R. Congo" by
*		   Balan et al. (2021).
********************************************************************************

	clear all
	set more off
	
	
	set timeout1 32000
	set timeout2 32000
	set maxvar 30000

	
* 1. Set up your user specific root directory to Replication Materials folder

		* gl stem "Your Directory/Replication Materials"
		 gl stem "/Users/sossousimpliceadjisse/Documents/myfiles/PaulMoussaReplicationProject/147561-V1/Replication Materials"
		
	
* 3. Route file paths

		global repldir "${stem}"
		
		// Dofiles
		global repldodir "${stem}/Dofiles"
		
		global repldodir1 "${stem}/Dofiles/Tables_Figures"
		
		// Output
		global reploutdir "${stem}/Output"

* 4. Run replication files

	do "$repldodir/1_Package_Setup.do"
	do "$repldodir/2_Data_Construction.do"
	do "$repldodir/3_Main_Tables_Figures.do"
	do "$repldodir/4_Appendix_Tables_Figures.do"
	
	* R1
	run "${repldodir1}/R1_pvalue/Table4R1.do"
	run "${repldodir1}/R1_pvalue/Table5R1.do"
	run "${repldodir1}/R1_pvalue/Table6R1.do"
	run "${repldodir1}/R1_pvalue/Table7R1.do"
	run "${repldodir1}/R1_pvalue/Table8R1.do"
	run "${repldodir1}/R1_pvalue/Table9R1.do"
	
	* R2
	run "${repldodir1}/R2_pvalue/Table4R2.do"
	run "${repldodir1}/R2_pvalue/Table6R2.do"
	run "${repldodir1}/R2_pvalue/Table7R2.do"
	run "${repldodir1}/R2_pvalue/Table8R2.do"

	* R3
	run "${repldodir1}/R3_pvalue/Table8R2R3.do"
	run "${repldodir1}/R3_pvalue/Table8R3.do"

	* R4
	run "${repldodir1}/R4_pvalue/Table4R4.do"
	run "${repldodir1}/R4_pvalue/Table6R4.do"
	run "${repldodir1}/R4_pvalue/Table7R4.do"
	run "${repldodir1}/R4_pvalue/Table8R4.do"
	run "${repldodir1}/R4_pvalue/Table8R5.do"

	
	
cap log close main
cap log off main
	
