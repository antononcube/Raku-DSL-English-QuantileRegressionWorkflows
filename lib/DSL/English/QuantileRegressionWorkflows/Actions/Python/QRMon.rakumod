use v6.d;

use DSL::Shared::Actions::English::Python::PipelineCommand;

class DSL::English::QuantileRegressionWorkflows::Actions::Python::QRMon
        is DSL::Shared::Actions::English::Python::PipelineCommand {

  # Top
  method TOP($/) { make $/.values[0].made; }

  # workflow-command-list
  method workflow-commands-list($/) { make $/.values>>.made.join("\n"); }

  # workflow-command
  method workflow-command($/) { make $/.values[0].made; }

  # Load data
  method data-load-command($/) { make $/.values[0].made; }
  method load-data($/) { make 'set_data(data = ' ~ $<data-location-spec>.made ~ ')'; }
  method data-location-spec($/) { make $<dataset-name>.made; }
  method use-qr-object($/) { make 'obj = ' ~ $<variable-name>.made; }
  method use-dataset($/) { make 'obj = Regressionizer(' ~ $<variable-name>.made ~ ')'; }
  method dataset-name($/) { make $/.Str; }

  # Create commands
  method create-command($/) { make $/.values[0].made; }
  method create-simple($/) { make 'obj = Regressionizer()'; }
  method create-by-dataset($/) { make 'obj = Regressionizer( data = ' ~ $<dataset-name>.made ~ ')'; }

  # Data transform command
  method data-transformation-command($/) { make $/.values[0].made; }

  method delete-missing($/) { make 'delete_missing()'; }

  method rescale-command($/) { make 'rescale( ' ~ make $/.values[0].made ~ ')'; }
  method rescale-axis($/) { make $/.values[0].made; }
  method axis-spec($/) { make $/.values[0].made; }
  method regressor-axis-spec($/) { make 'regressor = True'; }
  method value-axis-spec($/) { make 'value = True'; }

  method rescale-both-axes($/) { make 'regressor = true, value = true'; }

  method resample-command($/) { make 'failure(\"Resampling is not implemented in QRMon-Py.\" )'; }

  method moving-func-command($/) { make 'failure(\"Moving mapping is not implemented in QRMon-Py.\" )'; }

  # Data statistics command
  method data-statistics-command($/) { make $/.values[0].made; }
  method summarize-data($/) { make 'echo_data_summary()'; }

  # Quantile Regression
  method regression-command($/) { make $/.values[0].made; }
  method quantile-regression-spec($/) { make $/.values[0].made; }
  method quantile-regression-spec-simple($/) { make 'quantile_regression()'; }
  method quantile-regression-spec-full($/) {  make 'quantile_regression( ' ~ $<quantile-regression-spec-element-list>.made ~ ' )'; }

  method quantile-regression-spec-element-list($/) {

    my $res = $<quantile-regression-spec-element>>>.made.join(', ');

    my @ks = $<quantile-regression-spec-element>>>.keys;

    if @ks.first('knots-spec-subcommand') {
      make $res;
    } else {
      make 'knots = 12, ' ~ $res ;
    }
  }

  method quantile-regression-spec-element($/) { make $/.values[0].made; }

  # QR element - list of probabilities.
  method probabilities-spec-subcommand($/) { make 'probs = ' ~ $<probabilities-spec>.made; }
  method probabilities-spec($/) { make $/.values[0].made.subst(/^ 'seq('/, '('); }

  # QR element - knots.
  method knots-spec-subcommand($/) { make 'knots = ' ~ $<knots-spec>.made; }
  method knots-spec($/) { make $/.values[0].made; }

  # QR element - interpolation order.
  method interpolation-order-spec-subcommand($/) { make 'order = ' ~ $<interpolation-order-spec>.made; }
  method interpolation-order-spec($/) { make $/.values[0].made; } # make $.<integer-value>.made;

  # Find outliers command
  method find-outliers-command($/) { make $/.values[0].made; }

  method find-outliers-simple($/) {
    if $<compute-and-display><display-directive> {
      make 'outliers().outliers_plot()';
    } else {
      make 'outliers()';
    }
  }

  method find-type-outliers($/) {
    if $<compute-and-display><display-directive> {
      make 'outliers().outliers_plot()';
    } else {
      make 'outliers()';
    }
  }

  method find-outliers-spec($/) {
    if $<compute-and-display><display-directive> {
      make 'outliers().outliers_plot()';
    } else {
      make 'outliers()';
    }
  }

  # Find anomalies command
  method find-anomalies-command($/) { make $/.values[0].made; }

  method find-anomalies-by-residuals-threshold($/) { make 'find_anomalies_by_residuals( threshold = ' ~ $<number-value>.made ~ ')'; }
  method find-anomalies-by-residuals-outliers($/) { make 'find_anomalies_by_residuals( outlier_identifier = ' ~ $<variable-name>.made ~ ')'; }

  # Plot command
  method plot-command($/) {
    my Str $opts = 'datePlotQ = false';
    if $/.keys.contains(<date-list-diagram>) { $opts = $<date-list-diagram>.made; }
    make 'plot( ' ~ $opts ~ ')';
  }

  method date-list-diagram($/) {
    my Str $opts = '';
    if $/.keys.contains(<date-origin>) { $opts = ', ' ~ $<date-origin>.made; }
    make 'date_plot = True' ~ $opts;
  }
  method date-origin($/) { make 'epoch_origin = ' ~ $<date-spec>.made; }
  method date-spec($/) { make "'" ~ $/.Str ~ "'"; }

  # Error plot command
  method plot-errors-command($/) { make $/.values[0].made; }
  method plot-errors-with-directive($/) {
    my $err_type = 'True';
    if $<errors-type> && $<errors-type>.trim eq 'absolute' { $err_type = 'False'  }
    make 'errors_plot( relative_errors = ' ~ $err_type ~ ')';
  }

  # Pipeline command
  method pipeline-command($/) { make $/.values[0].made; }
  method take-pipeline-value($/) { make 'take_value()'; }
  method echo-pipeline-value($/) { make 'echo_value()'; }

  method echo-command($/) { make 'echo( ' ~ $<echo-message-spec>.made ~ ' )'; }
  method echo-message-spec($/) { make $/.values[0].made; }
  method echo-words-list($/) { make '"' ~ $<variable-name>>>.made.join(' ') ~ '"'; }
  method echo-variable($/) { make $/.Str; }
  method echo-text($/) { make $/.Str; }

  ## Setup code
  method setup-code-command($/) {
    make 'SETUPCODE' => "from Regressionizer import *\n";
  }
}
