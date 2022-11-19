=begin comment
#==============================================================================
#
#   QRMon-R actions in Raku Perl 6
#   Copyright (C) 2019  Anton Antonov
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#   Written by Anton Antonov,
#   ʇǝu˙oǝʇsod@ǝqnɔuouoʇuɐ,
#   Windermere, Florida, USA.
#
#==============================================================================
#
#   For more details about Raku (Perl6) see https://rakue.org/ .
#
#==============================================================================
#
#   The actions are implemented for the grammar:
#
#     DSL::English::QuantileRegressionWorkflows::Grammar
#
#   in the file :
#
#     https://github.com/antononcube/ConversationalAgents/blob/master/Packages/Perl6/DSL::English::QuantileRegressionWorkflows/lib/DSL/English/QuantileRegressionWorkflows/Grammar.pm6
#
#==============================================================================
=end comment

use v6.d;

use DSL::Shared::Actions::English::R::PipelineCommand;

class DSL::English::QuantileRegressionWorkflows::Actions::R::QRMon
        is DSL::Shared::Actions::English::R::PipelineCommand {

  # Separator
  method separator() { " %>%\n" }

  # Top
  method TOP($/) { make $/.values[0].made; }

  # workflow-command-list
  method workflow-commands-list($/) { make $/.values>>.made.join(" %>%\n"); }

  # workflow-command
  method workflow-command($/) { make $/.values[0].made; }

  # Load data
  method data-load-command($/) { make $/.values[0].made; }
  method load-data($/) { make 'QRMonSetData( data = ' ~ $<data-location-spec>.made ~ ')'; }
  method data-location-spec($/) { make $<dataset-name>.made; }
  method use-qr-object($/) { make $<variable-name>.made; }
  method use-dataset($/) { make 'QRMonUnit(' ~ $<variable-name>.made ~ ')'; }
  method dataset-name($/) { make $/.Str; }

  # Create commands
  method create-command($/) { make $/.values[0].made; }
  method create-simple($/) { make 'QRMonUnit()'; }
  method create-by-dataset($/) { make 'QRMonUnit( data = ' ~ $<dataset-name>.made ~ ')'; }

  # Data transform command
  method data-transformation-command($/) { make $/.values[0].made; }

  method delete-missing($/) { make 'QRMonDeleteMissing()'; }

  method rescale-command($/) { make 'QRMonRescale(' ~ $/.values[0].made ~ ')'; }
  method rescale-axis($/) { make $/.values[0].made; }
  method axis-spec($/) { make $/.values[0].made; }
  method regressor-axis-spec($/) { make 'regressorAxisQ = TRUE'; }
  method value-axis-spec($/) { make 'valueAxisQ = TRUE'; }

  method rescale-both-axes($/) { make 'regressorAxisQ = TRUE, valueAxisQ = TRUE'; }

  method resample-command($/) { make 'QRMonFailure( \"Resampling is not implemented in QRMon-R.\" )'; }

  method moving-func-command($/) { make 'QRMonFailure( \"Moving mapping is not implemented in QRMon-R.\" )'; }

  # Data statistics command
  method data-statistics-command($/) { make $/.values[0].made; }
  method summarize-data($/) { make 'QRMonEchoDataSummary()'; }

  # Quantile Regression
  method regression-command($/) { make $/.values[0].made; }
  method quantile-regression-spec($/) { make $/.values[0].made; }
  method quantile-regression-spec-simple($/) { make 'QRMonQuantileRegression()'; }
  method quantile-regression-spec-full($/) {  make 'QRMonQuantileRegression(' ~ $<quantile-regression-spec-element-list>.made ~ ')'; }

  method quantile-regression-spec-element-list($/) {

    my $res = $<quantile-regression-spec-element>>>.made.join(', ');

    my @ks = $<quantile-regression-spec-element>>>.keys;

    if @ks.first('knots-spec-subcommand') {
      make $res;
    } else {
      make 'df = 12, ' ~ $res ;
    }
  }

  method quantile-regression-spec-element($/) { make $/.values[0].made; }

  # QR element - list of probabilities.
  method probabilities-spec-subcommand($/) { make 'probabilities = ' ~ $<probabilities-spec>.made ; }
  method probabilities-spec($/) { make $/.values[0].made; }

  # QR element - knots.
  method knots-spec-subcommand($/) { make 'df = ' ~ $<knots-spec>.made; }
  method knots-spec($/) { make $/.values[0].made; }

  # QR element - interpolation order.
  method interpolation-order-spec-subcommand($/) { make 'degree = ' ~ $<interpolation-order-spec>.made; }
  method interpolation-order-spec($/) { make $/.values[0].made; } # make $.<integer-value>.made;

  # Find outliers command
  method find-outliers-command($/) { make $/.values[0].made; }

  method find-outliers-simple($/) {
    if $<compute-and-display><display-directive> {
      make 'QRMonOutliers() %>% QRMonOutliersPlot()';
    } else {
      make 'QRMonOutliers()';
    }
  }

  method find-type-outliers($/) {
    if $<compute-and-display><display-directive> {
      make 'QRMonOutliers() %>% QRMonOutliersPlot()';
    } else {
      make 'QRMonOutliers()';
    }
  }

  method find-outliers-spec($/) {
    if $<compute-and-display><display-directive> {
      make 'QRMonOutliers() %>% QRMonOutliersPlot()';
    } else {
      make 'QRMonOutliers()';
    }
  }

  # Find anomalies command
  method find-anomalies-command($/) { make $/.values[0].made; }

  method find-anomalies-by-residuals-threshold($/) { make 'QRMonFindAnomaliesByResiduals( threshold = ' ~ $<number-value>.made ~ ')'; }
  method find-anomalies-by-residuals-outliers($/) { make 'QRMonFindAnomaliesByResiduals( outlierIdentifier = ' ~ $<variable-name>.made ~ ')'; }

  # Plot command
  method plot-command($/) {
    my Str $opts = 'datePlotQ = FALSE';
    if $/.keys.contains(<date-list-diagram>) { $opts = $<date-list-diagram>.made; }
    make 'QRMonPlot( ' ~ $opts ~ ')';
  }

  method date-list-diagram($/) {
    my Str $opts = '';
    if $/.keys.contains(<date-origin>) { $opts = ', ' ~ $<date-origin>.made; }
    make 'datePlotQ = TRUE' ~ $opts;
  }
  method date-origin($/) { make 'dateOrigin = ' ~ $<date-spec>.made; }
  method date-spec($/) { make "'" ~ $/.Str ~ "'"; }

  # Error plot command
  method plot-errors-command($/) { make $/.values[0].made; }
  method plot-errors-with-directive($/) {
    my $err_type = 'TRUE';
    if $<errors-type> && $<errors-type>.trim eq 'absolute' { $err_type = 'FALSE'  }
    make 'QRMonErrorsPlot( relativeErrorsQ = ' ~ $err_type ~ ')';
  }

  # Pipeline command overwrites
  ## Object
  method assign-pipeline-object-to($/) { make '(function(x) { assign( x = "' ~ $/.values[0].made ~ '", value = x, envir = .GlobalEnv ); x })'; }

  ## Value
  method assign-pipeline-value-to($/) { make '(function(x) { assign( x = "' ~ $/.values[0].made ~ '", value = QRMonTakeValue(x), envir = .GlobalEnv ); x })'; }
  method take-pipeline-value($/) { make 'QRMonTakeValue()'; }
  method echo-pipeline-value($/) { make 'QRMonEchoValue()'; }
  method echo-pipeline-funciton-value($/) { make 'QRMonEchoFunctionValue( ' ~ $<pipeline-function-spec>.made ~ ' )'; }

  ## Context
  method take-pipeline-context($/) { make '(function(x) { x })'; }
  method echo-pipeline-context($/) { make '(function(x) { print(x); x })'; }
  method echo-pipeline-function-context($/) { make 'QRMonEchoFunctionContext( ' ~ $<pipeline-function-spec>.made ~ ' )'; }

  ## Echo messages
  method echo-command($/) { make 'QRMonEcho( ' ~ $<echo-message-spec>.made ~ ' )'; }

  ## Setup code
  method setup-code-command($/) {
    make 'SETUPCODE' => q:to/SETUPEND/
      #devtools::install_github(repo = "antononcube/QRMon-R")
      library(magrittr)
      library(quantreg)
      library(QRMon)
      SETUPEND
  }
}
