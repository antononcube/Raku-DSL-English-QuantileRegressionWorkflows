=begin comment
#==============================================================================
#
#   QRMon-WL actions in Raku Perl 6
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

use DSL::Shared::Actions::English::WL::PipelineCommand;

class DSL::English::QuantileRegressionWorkflows::Actions::WL::QRMon
        is DSL::Shared::Actions::English::WL::PipelineCommand {

  # Separator
  method separator() { " \\[DoubleLongRightArrow]\n" }

  # Top
  method TOP($/) { make $/.values[0].made; }

  # workflow-command-list
  method workflow-commands-list($/) { make $/.values>>.made.join(" \\[DoubleLongRightArrow]\n"); }

  # workflow-command
  method workflow-command($/) { make $/.values[0].made; }

  # Load data
  method data-load-command($/) { make $/.values[0].made; }
  method load-data($/) { make 'QRMonSetData[' ~ $<data-location-spec>.made ~ ']'; }
  method data-location-spec($/) { make $<dataset-name>.made; }
  method use-qr-object($/) { make $<variable-name>.made; }
  method use-dataset($/) { make 'QRMonUnit[' ~ $<variable-name>.made ~ ']'; }
  method dataset-name($/) { make $/.Str; }

  # Create commands
  method create-command($/) { make $/.values[0].made; }
  method create-simple($/) { make 'QRMonUnit[]'; }
  method create-by-dataset($/) { make 'QRMonUnit[' ~ $<dataset-name>.made ~ ']'; }

  # Data transform command
  method data-transformation-command($/) { make $/.values[0].made; }

  method delete-missing($/) { make 'QRMonDeleteMissing[]'; }

  method rescale-command($/) { make 'QRMonRescale[' ~ make $/.values[0].made ~ ']'; }
  method rescale-axis($/) { make $/.values[0].made; }
  method axis-spec($/) { make $/.values[0].made; }
  method regressor-axis-spec($/) { make '"Axes"->{True, False}';  }
  method value-axis-spec($/) { make '"Axes"->{False, True}'; }

  method rescale-both-axes($/) { make '"Axes"->{True, True}'; }

  method resample-command($/) { make 'QRMonFailure[ "Resampling is not implemented in QRMon-WL." ]'; }

  method moving-func-command($/) { make 'QRMonFailure[ "Moving mapping is not implemented in QRMon-WL." ]'; }

  # Data statistics command
  method data-statistics-command($/) { make $/.values[0].made; }
  method summarize-data($/) { make 'QRMonEchoDataSummary[]'; }

  # Quantile Regression
  method regression-command($/) { make $/.values[0].made; }
  method quantile-regression-spec($/) { make $/.values[0].made; }
  method quantile-regression-spec-simple($/) { make 'QRMonQuantileRegression[]'; }
  method quantile-regression-spec-full($/) { make 'QRMonQuantileRegression[' ~ $<quantile-regression-spec-element-list>.made ~ ']'; }
  method quantile-regression-spec-element-list($/) { make $<quantile-regression-spec-element>>>.made.join(', '); }
  method quantile-regression-spec-element($/) { make $/.values[0].made; }

  # QR element - list of probabilities.
  method probabilities-spec-subcommand($/) { make $<probabilities-spec>.made; }
  method probabilities-spec($/) { make '"Probabilities" -> ' ~ $/.values[0].made; }

  # QR element - knots.
  method knots-spec-subcommand($/) { make $<knots-spec>.made; }
  method knots-spec($/) { make '"Knots" -> ' ~ $/.values[0].made; }

  # QR element - interpolation order.
  method interpolation-order-spec-subcommand($/) { make '"InterpolationOrder" -> ' ~ $<interpolation-order-spec>.made; }
  method interpolation-order-spec($/) { make $/.values[0].made; } # make $.<integer-value>.made;

  # Find outliers command
  method find-outliers-command($/) { make $/.values[0].made; }

  method find-outliers-simple($/) {
    if $<compute-and-display><display-directive> {
      make 'QRMonOutliersPlot[]';
    } else {
      make 'QRMonOutliers[]';
    }
  }

  method find-type-outliers($/) {
    if $<compute-and-display><display-directive> {
      make 'QRMonOutliersPlot[]';
    } else {
      make 'QRMonOutliers[]';
    }
  }

  method find-outliers-spec($/) {
    if $<compute-and-display><display-directive> {
      make 'QRMonOutliersPlot[]';
    } else {
      make 'QRMonOutliers[]';
    }
  }

  # Find anomalies command
  method find-anomalies-command($/) { make $/.values[0].made; }

  method find-anomalies-by-residuals-threshold($/) { make 'QRMonFindAnomaliesByResiduals[ "Threshold"->' ~ $<number-value>.made ~ ']'; }
  method find-anomalies-by-residuals-outliers($/) { make 'QRMonFindAnomaliesByResiduals[ "OutlierIdentifier"->' ~ $<variable-name>.made ~ ']'; }

  # Plot command
  method plot-command($/) {
    if $/.keys.contains(<date-list-diagram>) {
      make 'QRMonDateListPlot[]';
    } else {
      make 'QRMonPlot[]';
    }
  }

  # Error plot command
  method plot-errors-command($/) { make $/.values[0].made; }
  method plot-errors-with-directive($/) {
    my $err_type = 'True';
    if $<errors-type> && $<errors-type>.trim eq 'absolute' { $err_type = 'False'  }
    make 'QRMonErrorPlots[ "RelativeErrors" -> ' ~ $err_type ~ ']';
  }

  # Pipeline command overwrites
  ## Object
  method assign-pipeline-object-to($/) { make 'QRMonAssignTo[ ' ~ $/.values[0].made ~ ' ]'; }

  ## Value
  method assign-pipeline-value-to($/) { make 'QRMonAssignValueTo[ ' ~ $/.values[0].made ~ ' ]'; }
  method take-pipeline-value($/) { make 'QRMonTakeValue[]'; }
  method echo-pipeline-value($/) { make 'QRMonEchoValue[]'; }
  method echo-pipeline-funciton-value($/) { make 'QRMonEchoFunctionValue[ ' ~ $<pipeline-function-spec>.made ~ ' ]'; }

  ## Context
  method take-pipeline-context($/) { make 'QRMonTakeContext[]'; }
  method echo-pipeline-context($/) { make 'QRMonEchoContext[]'; }
  method echo-pipeline-function-context($/) { make 'QRMonEchoFunctionContext[ ' ~ $<pipeline-function-spec>.made ~ ' ]'; }

  ## Echo messages
  method echo-command($/) { make 'QRMonEcho[ ' ~ $<echo-message-spec>.made ~ ' ]'; }

  ## Setup code
  method setup-code-command($/) {
    make 'SETUPCODE' => q:to/SETUPEND/
    PacletInstall["AntonAntonov/MonadicQuantileRegression"];
    Needs["AntonAntonov`MonadicQuantileRegression`"];
    SETUPEND
  }
}
