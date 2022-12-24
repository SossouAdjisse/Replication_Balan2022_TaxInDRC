
/*
* Set up data
clear
set obs 1000
gen y = round(uniform())
gen yhat = round(uniform())

* Generate table
tab y, matcell(cell)
matrix results = cell
matrix results = (results - results[1,1])/results[1,1]
eststo clear
eststo: tab yhat if y == 1, matcell(cell1)
matrix results1 = (cell1 - cell1[1,1])/cell1[1,1]
eststo: tab yhat if y == 2, matcell(cell2)
matrix results2 = (cell2 - cell2[1,1])/cell2[1,1]
eststo: tab yhat if y == 3, matcell(cell3)
matrix results3 = (cell3 - cell3[1,1])/cell3[1,1]
eststo: tab yhat if y == 4, matcell(cell4)
matrix results4 = (cell4 - cell4[1,1])/cell4[1,1]

* Save results to .tex file
* "${reploutdir}/campaign_components.tex"
file open results using "${reploutdir}/gpt1_prediction_results.tex", write
//file open results using "prediction_results.tex", write
file write results " \begin{tabular}{lcccc}"
file write results " \hline"
file write results " & \multicolumn{4}{c}{True Y} \\ "
file write results " \cline{2-5} "
file write results "Predicted Yhat & 1 & 2 & 3 & 4 \\ "
file write results " \hline "
file write results "1 & " results1[1,1] " & " results2[1,1] " & " results3[1,1] " & " results4[1,1] " \\ "
file write results "2 & " results1[1,2] " & " results2[1,2] " & " results3[1,2] " & " results4[1,2] " \\ "
file write results "3 & " results1[1,3] " & " results2[1,3] " & " results3[1,3] " & " results4[1,3] " \\ "
file write results "4 & " results1[1,4] " & " results2[1,4] " & " results3[1,4] " & " results4[1,4] " \\ "
file write results " \hline"
file write results " \end{tabular} "
file close results
*/

/*
* Set up data
clear
set obs 1000
gen y = round(uniform())
gen yhat = round(uniform())

* Generate table
tab y, matcell(cell)
matrix results = cell

eststo clear
eststo: tab yhat if y == 1, matcell(cell1)
matrix results1 = cell1
eststo: tab yhat if y == 2, matcell(cell2)
matrix results2 = cell2
eststo: tab yhat if y == 3, matcell(cell3)
matrix results3 = cell3
eststo: tab yhat if y == 4, matcell(cell4)
matrix results4 = cell4

* Calculate proportions
matrix results1 = (results1 - results1[1,1])/results1[1,1]
matrix results2 = (results2 - results2[1,1])/results2[1,1]
matrix results3 = (results3 - results3[1,1])/results3[1,1]
matrix results4 = (results4 - results4[1,1])/results4[1,1]

* Save results to .tex file
file open results using "${reploutdir}/gpt1_prediction_results.tex", write
file write results " \begin{tabular}{lcccc}"
file write results " \hline"
file write results " & \multicolumn{4}{c}{True Y} \\ "
file write results " \cline{2-5} "
file write results "Predicted Yhat & 1 & 2 & 3 & 4 \\ "
file write results " \hline "
file write results "1 & " results1[1,1] " & " results2[1,1] " & " results3[1,1] " & " results4[1,1] " \\ "
file write results "2 & " results1[1,2] " & " results2[1,2] " & " results3[1,2] " & " results4[1,2] " \\ "
file write results "3 & " results1[1,3] " & " results2[1,3] " & " results3[1,3] " & " results4[1,3] " \\ "
file write results "4 & " results1[1,4] " & " results2[1,4] " & " results3[1,4] " & " results4[1,4] " \\ "
file write results " \hline"
file write results " \end{tabular} "
file close results
*/

/*
* Set up data
clear
set obs 1000
gen y = round(uniform())
gen yhat = round(uniform())

* Generate table
tab y, matcell(cell)
matrix results = cell

tab yhat if y == 1, matcell(cell1)
matrix results1 = cell1
tab yhat if y == 2, matcell(cell2)
matrix results2 = cell2
tab yhat if y == 3, matcell(cell3)
matrix results3 = cell3
tab yhat if y == 4, matcell(cell4)
matrix results4 = cell4

* Calculate proportions
matrix results1 = (results1 - results1[1,1])/results1[1,1]
matrix results2 = (results2 - results2[1,1])/results2[1,1]
matrix results3 = (results3 - results3[1,1])/results3[1,1]
matrix results4 = (results4 - results4[1,1])/results4[1,1]

* Save results to .tex file
file open results using "${reploutdir}/gpt1_prediction_results.tex", write
file write results " \begin{tabular}{lcccc}"
file write results " \hline"
file write results " & \multicolumn{4}{c}{True Y} \\ "
file write results " \cline{2-5} "
file write results "Predicted Yhat & 1 & 2 & 3 & 4 \\ "
file write results " \hline "
file write results "1 & " results1[1,1] " & " results2[1,1] " & " results3[1,1] " & " results4[1,1] " \\ "
file write results "2 & " results1[1,2] " & " results2[1,2] " & " results3[1,2] " & " results4[1,2] " \\ "
file write results "3 & " results1[1,3] " & " results2[1,3] " & " results3[1,3] " & " results4[1,3] " \\ "
file write results "4 & " results1[1,4] " & " results2[1,4] " & " results3[1,4] " & " results4[1,4] " \\ "
file write results " \hline"
file write results " \end{tabular} "
file close results
*/

/*
* Set up data
clear
set obs 1000
gen y = round(uniform())
gen yhat = round(uniform())

* Generate table
tab y, matcell(cell)
matrix results = cell

* Generate dummy data for tabulation
gen y1 = 1 in 1/50
tab yhat if y1 == 1, matcell(cell1)
matrix results1 = cell1

gen y2 = 2 in 1/50
tab yhat if y2 == 2, matcell(cell2)
matrix results2 = cell2

gen y3 = 3 in 1/50
tab yhat if y3 == 3, matcell(cell3)
matrix results3 = cell3

gen y4 = 4 in 1/50
tab yhat if y4 == 4, matcell(cell4)
matrix results4 = cell4

drop y1 y2 y3 y4

* Calculate proportions
matrix results1 = (results1 - results1[1,1])/results1[1,1]
matrix results2 = (results2 - results2[1,1])/results2[1,1]
matrix results3 = (results3 - results3[1,1])/results3[1,1]
matrix results4 = (results4 - results4[1,1])/results4[1,1]

* Save results to .tex file
file open results using "${reploutdir}/gpt1_prediction_results.tex", write
file write results " \begin{tabular}{lcccc}"
file write results " \hline"
file write results " & \multicolumn{4}{c}{True Y} \\ "
file write results " \cline{2-5} "
file write results "Predicted Yhat & 1 & 2 & 3 & 4 \\ "
file write results " \hline "
file write results "1 & " results1[1,1] " & " results2[1,1] " & " results3[1,1] " & " results4[1,1] " \\ "
file write results "2 & " results1[1,2] " & " results2[1,2] " & " results3[1,2] " & " results4[1,2] " \\ "
file write results "3 & " results1[1,3] " & " results2[1,3] " & " results3[1,3] " & " results4[1,3] " \\ "
file write results "4 & " results1[1,4] " & " results2[1,4] " & " results3[1,4] " & " results4[1,4] " \\ "
file write results " \hline"
file write results " \end{tabular} "
file close results
*/

* Set up data
clear
set obs 1000
gen y = round(uniform())
gen yhat = round(uniform())

* Generate table
tab y, matcell(cell)
matrix results = cell

* Generate dummy data for tabulation
gen y1 = 1 in 1/50
tab yhat if y1 == 1, matcell(cell1)
matrix results1 = cell1
gen y2 = 2 in 1/50
tab yhat if y2 == 2, matcell(cell2)
matrix results2 = cell2
gen y3 = 3 in 1/50
tab yhat if y3 == 3, matcell(cell3)
matrix results3 = cell3
gen y4 = 4 in 1/50
tab yhat if y4 == 4, matcell(cell4)
matrix results4 = cell4

* Calculate proportions
matrix results1 = (real(results1) - real(results1[1,1]))/real(results1[1,1])
matrix results2 = (real(results2) - real(results2[1,1]))/real(results2[1,1])
matrix results3 = (real(results3) - real(results3[1,1]))/real(results3[1,1])
matrix results4 = (real(results4) - real(results4[1,1]))/real(results4[1,1])

* Save results to .tex file
file open results using "${reploutdir}/gpt1_prediction_results.tex", write
file write results " \begin{tabular}{lcccc}"
file write results " \hline"
file write results " & \multicolumn{4}{c}{True Y} \\ "
file write results " \cline{2-5} "
file write results "Predicted Yhat & 1 & 2 & 3 & 4 \\ "
file write results " \hline "
file write results "1 & " results1[1,1] " & " results2[1,1] " & " results3[1,1] " & " results4[1,1] " \\ "
file write results "2 & " results1[1,2] " & " results2[1,2] " & " results3[1,2] " & " results4[1,2] " \\ "
file write results "3 & " results1[1,3] " & " results2[1,3] " & " results3[1,3] " & " results4[1,3] " \\ "
file write results "4 & " results1[1,4] " & " results2[1,4] " & " results3[1,4] " & " results4[1,4] " \\ "
file write results " \hline"
file write results " \end{tabular} "
file close results


* Set up data
clear
set obs 1000
gen y = round(uniform())
gen yhat = round(uniform())

/*
* Create contingency table
tabulate y yhat, generate(acc_matrix)

* Output LaTeX table
esttab acc_matrix, cells("count")
*/

* Create contingency table
tabulate y yhat, matrix(acc_matrix)

* Output LaTeX table
esttab acc_matrix, cells("count")


/*
* Clear the current dataset
clear

* Create a new dataset with the table data
input y yhat count pct_y pct_yhat pct_total
0 0 234 45.53 50.00 50.00
0 1 280 54.47 52.63 51.40
1 0 234 48.15 50.00 48.60
1 1 252 51.85 47.37 47.37
end

* Set variable labels
label var y "y"
label var yhat "yhat"
label var count "Count"
label var pct_y "Percent of y"
label var pct_yhat "Percent of yhat"
label var pct_total "Percent of Total"

* Create a summary table
tabstat count, s(mean) row

* Output LaTeX table
esttab using "${reploutdir}/mytable.tex", cells("count mean")
*/

* Clear the current dataset

/*
clear

* Create a new dataset with the table data
input y yhat count pct_y pct_yhat pct_total
0 0 234 45.53 50.00 50.00
0 1 280 54.47 52.63 51.40
1 0 234 48.15 50.00 48.60
1 1 252 51.85 47.37 47.37
end

* Set variable labels
label var y "y"
label var yhat "yhat"
label var count "Count"
label var pct_y "Percent of y"
label var pct_yhat "Percent of yhat"
label var pct_total "Percent of Total"

* Create a summary table
tabstat count, statistics(mean sum)

* Output LaTeX table
esttab using "${reploutdir}/mytablegpt1.tex", cells("count mean sum")
*/


* Clear the current dataset
clear

* Create a new dataset with the table data
input y yhat count pct_y pct_yhat pct_total
0 0 234 45.53 50.00 50.00
0 1 280 54.47 52.63 51.40
1 0 234 48.15 50.00 48.60
1 1 252 51.85 47.37 47.37
end

* Set variable labels
label var y "y"
label var yhat "yhat"
label var count "Count"
label var pct_y "Percent of y"
label var pct_yhat "Percent of yhat"
label var pct_total "Percent of Total"

* Calculate summary statistics
eststo: summarize count


* Output LaTeX table
esttab using "${reploutdir}/mytablegpt1.tex", cells("count mean sum")




////////



table yhat, contents(freq rowpct colpct)
tabout y, yhat, cells(freq rowpct colpct)

esttab using "table.tex", replace



*######################################################################
/*
* Generate toy data
clear 
set obs 100
generate y = rbinomial(1, .5)
generate yhat = rbinomial(1, .6)

* Calculate the performance metrics
summarize yhat, detail
summarize y, detail
table y, c(sum)

* Create a prediction matrix
matrix C = (2,2)
matrix C[1,1] = r(N_1_1)
matrix C[1,2] = r(N_1_2)
matrix C[2,1] = r(N_2_1)
matrix C[2,2] = r(N_2_2)

* Calculate the accuracy, precision, recall, and F1 score
matrix C["Accuracy", 1] = (C[1,1] + C[2,2]) / sum(C)
matrix C["Precision", 1] = C[1,1] / (C[1,1] + C[1,2])
matrix C["Recall", 1] = C[1,1] / (C[1,1] + C[2,1])
matrix C["F1 Score", 1] = 2 * (C["Precision", 1] * C["Recall", 1]) / (C["Precision", 1] + C["Recall", 1])

* Display the prediction matrix
matrix list C
*/

/*
* Generate toy data
clear
set obs 100
generate y = rbinomial(1, .5)
generate yhat = rbinomial(1, .6)

* Calculate the performance metrics
summarize yhat, detail
summarize y, detail

* Calculate the count of observations for each combination of predicted and actual values
table yhat, contents(count) by(y)

* Create a prediction matrix
matrix C = (2,2)
matrix C[1,1] = r(N_1_1)
matrix C[1,2] = r(N_1_2)
matrix C[2,1] = r(N_2_1)
matrix C[2,2] = r(N_2_2)

* Calculate the accuracy, precision, recall, and F1 score
matrix C["Accuracy", 1] = (C[1,1] + C[2,2]) / sum(C)
matrix C["Precision", 1] = C[1,1] / (C[1,1] + C[1,2])
matrix C["Recall", 1] = C[1,1] / (C[1,1] + C[2,1])
matrix C["F1 Score", 1] = 2 * (C["Precision", 1] * C["Recall", 1]) / (C["Precision", 1] + C["Recall", 1])

* Display the prediction matrix
matrix list C
*/


* Install estout package if not already installed
// net install estout, from("https://raw.githubusercontent.com/reifjulian/stata-estout/master")

* Load data and fit model
use mydata.dta
logit y x1 x2 x3

* Generate toy data
clear
set obs 100
generate y = rbinomial(1, .5)
generate yhat = rbinomial(1, .6)

* Create prediction matrix
//tabulate yhat, gen(yhat)
//tabulate y, gen(y)

* Calculate true positive, true negative, false positive, and false negative predictions
replace yhat = 1 if yhat >= 0.5
replace yhat = 0 if yhat < 0.5

gen tp = y*yhat
gen tn = (1-y)*(1-yhat)
gen fp = (1-y)*yhat
gen fn = y*(1-yhat)

* Calculate precision, recall, and F1 score
gen precision = tp / (tp + fp)
gen recall = tp / (tp + fn)
gen f1 = 2 * (precision * recall) / (precision + recall)

* Calculate accuracy
gen total = tp + tn + fp + fn
gen accuracy = (tp + tn) / total

* Create table
esttab matrix(tp tn fp fn precision recall f1 accuracy) using mytable.tex, unstack replace

* Open LaTeX table in editor
edit mytable.tex

