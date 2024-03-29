# Quantile Regression Workflows 

## In brief

This Raku Perl 6 package has grammar classes and action classes. 
These are used for the parsing and interpretation of spoken commands that specify Quantile Regression (QR) workflows.

It is envisioned that the interpreters (actions) target different
programming languages: R, Mathematica, Python, etc.

The generated pipelines are for the software monads 
[`QRMon-R`](https://github.com/antononcube/QRMon-R) 
and
[`QRMon-WL`](https://github.com/antononcube/MathematicaForPrediction/blob/master/MonadicProgramming/MonadicQuantileRegression.m),
\[AA1, AA2\].
  
## Installation

**1.** Install Raku (Perl 6) : https://raku.org/downloads . 

**2.** You should make sure you have the Zef Module Installer.
 
   - Type in `zef --version` in the command line.
   - Zef Module Installer can be installed from : https://github.com/ugexe/zef .

**3.** Open a command line program. (E.g. Terminal on Mac OS X.)

**4.** Run the commands:

```
zef install https://github.com/antononcube/Raku-DSL-Shared.git
zef install https://github.com/antononcube/Raku-DSL-English-QuantileRegressionWorkflows.git
```


## Examples

Open a Raku IDE or type `raku` in the command line program. Try this Raku code:

```raku
use DSL::English::QuantileRegressionWorkflows;

say ToQuantileRegressionWorkflowCode(
    "compute quantile regression with 16 knots and probabilities 0.25, 0.5 and 0.75",
    "R-QRMon");
# QRMonQuantileRegression(df = 16, probabilities = c(0.25, 0.5, 0.75))
``` 
    
Here is a more complicated pipeline specification:

```raku
say ToQuantileRegressionWorkflowCode(
    "create from dfTemperatureData;
     compute quantile regression with 16 knots and probability 0.5;
     show date list plot with date origin 1900-01-01;
     show absolute errors plot;
     echo text anomalies finding follows;
     find anomalies by the threshold 5;
     take pipeline value;", "R-QRMon")
```

The command above should print out R code for the R package `QRMon-R`, \[AA1\]:

```r
QRMonUnit( data = dfTemperatureData) %>%
QRMonQuantileRegression(df = 16, probabilities = c(0.5)) %>%
QRMonPlot( datePlotQ = TRUE, dateOrigin = '1900-01-01') %>%
QRMonErrorsPlot( relativeErrorsQ = FALSE) %>%
QRMonEcho( "anomalies finding follows" ) %>%
QRMonFindAnomaliesByResiduals( threshold = 5) %>%
QRMonTakeValue
```    

## Versions

The original version of this Raku package was developed and hosted at 
\[ [AA3](https://github.com/antononcube/ConversationalAgents/tree/master/Packages/Perl6/QuantileRegressionWorkflows) \].

A dedicated GitHub repository was made in order to make the installation with Raku's `zef` more direct. 
(As shown above.)

## References

### Packages

\[AA1\] Anton Antonov,
[Quantile Regression Monad in R](https://github.com/antononcube/QRMon-R), 
(2019),
[QRMon-R at GitHub](https://github.com/antononcube/QRMon-R).

\[AA2\] Anton Antonov,
[Monadic Quantile Regression Mathematica package](https://github.com/antononcube/MathematicaForPrediction/blob/master/MonadicProgramming/MonadicQuantileRegression.m), 
(2018),
[MathematicaForPrediction at GitHub](https://github.com/antononcube/MathematicaForPrediction).

\[AA3\] Anton Antonov,
[Quantile Regression Workflows](https://github.com/antononcube/ConversationalAgents/tree/master/Packages/Perl6/QuantileRegressionWorkflows),
(2019),
[ConversationalAgents at GitHub](https://github.com/antononcube/ConversationalAgents).

### Videos

[AAv1] Anton Antonov,
["Simplified Machine Learning Workflows Overview"](https://www.youtube.com/watch?v=Xy7eV8wRLbE), (WTC-2022),
(2022),
[YouTube/Wolfram](https://www.youtube.com/@WolframResearch).

[AAv2] Anton Antonov,
["Natural Language Processing Template Engine"](https://www.youtube.com/watch?v=IrIW9dB5sRM), (WTC-2022),
(2022),
[YouTube/Wolfram](https://www.youtube.com/@WolframResearch).
