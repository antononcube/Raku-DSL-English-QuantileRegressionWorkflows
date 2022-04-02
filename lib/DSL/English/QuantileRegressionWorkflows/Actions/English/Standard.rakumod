
use DSL::Shared::Actions::English::PipelineCommand;
use DSL::Shared::Actions::English::Standard::PipelineCommand;

class DSL::English::QuantileRegressionWorkflows::Actions::English::Standard
        does DSL::Shared::Actions::English::Standard::PipelineCommand
        is DSL::Shared::Actions::English::PipelineCommand {

  # Separator
  method separator() { "\n" }

  # Top
  method TOP($/) { make $/.values[0].made; }

  # workflow-command-list
  method workflow-commands-list($/) { make $/.values>>.made.join(" %>%\n"); }

  # workflow-command
  method workflow-command($/) { make $/.values[0].made; }

  # Load data
  method data-load-command($/) { make $/.values[0].made; }
  method load-data($/) { make 'load the data: ' ~ $<data-location-spec>.made; }
  method data-location-spec($/) { make $<dataset-name>.made; }
  method use-qr-object($/) { make $<variable-name>.made; }
  method use-dataset($/) { make 'create quantile regression object with: ' ~ $<variable-name>.made; }
  method dataset-name($/) { make $/.Str; }

  # Create commands
  method create-command($/) { make $/.values[0].made; }
  method create-simple($/) { make 'create quantile regression object'; }
  method create-by-dataset($/) { make 'create quantile regression object with the data: ' ~ $<dataset-name>.made; }

  # Data transform command
  method data-transformation-command($/) { make $/.values[0].made; }

  method delete-missing($/) { make 'delete missing values'; }

  method rescale-command($/) { make 'rescale: ' ~ $/.values[0].made; }
  method rescale-axis($/) { make $/.values[0].made; }
  method axis-spec($/) { make $/.values[0].made; }
  method regressor-axis-spec($/) { make 'over the regressor axis'; }
  method value-axis-spec($/) { make 'over the value axis'; }

  method rescale-both-axes($/) { make 'over both regressor and value axes'; }

  method resample-command($/) { make 'resample data'; }

  method moving-func-command($/) { make 'transform with moving map function'; }

  # Data statistics command
  method data-statistics-command($/) { make $/.values[0].made; }
  method summarize-data($/) { make 'show data summary'; }

  # Quantile Regression
  method regression-command($/) { make $/.values[0].made; }
  method quantile-regression-spec($/) { make $/.values[0].made; }
  method quantile-regression-spec-simple($/) { make 'compute quantile regression'; }
  method quantile-regression-spec-full($/) {  make 'compute quantile regression with parameters: ' ~ $<quantile-regression-spec-element-list>.made; }

  method quantile-regression-spec-element-list($/) {

    my $res = $<quantile-regression-spec-element>>>.made.join(', ');

    my @ks = $<quantile-regression-spec-element>>>.keys;

    if @ks.first('knots-spec-subcommand') {
      make $res;
    } else {
      make 'degrees of freedom (knots): 12, ' ~ $res ;
    }
  }

  method quantile-regression-spec-element($/) { make $/.values[0].made; }

  # QR element - list of probabilities.
  method probabilities-spec-subcommand($/) {
    make $<probabilities-spec>.made ?? 'probabilities: ' ~ $<probabilities-spec>.made !! 'automatic probabilities';
  }
  method probabilities-spec($/) { make $/.values[0].made; }

  # QR element - knots.
  method knots-spec-subcommand($/) { make 'degrees of freedom (knots): ' ~ $<knots-spec>.made; }
  method knots-spec($/) { make $/.values[0].made; }

  # QR element - interpolation order.
  method interpolation-order-spec-subcommand($/) { make 'interpolation order: ' ~ $<interpolation-order-spec>.made; }
  method interpolation-order-spec($/) { make $/.values[0].made; } # make $.<integer-value>.made;

  # Find outliers command
  method find-outliers-command($/) { make $/.values[0].made; }

  method find-outliers-simple($/) {
    if $<compute-and-display><display-directive> {
      make 'find and show outliers';
    } else {
      make 'find outliers';
    }
  }

  method find-type-outliers($/) {
    if $<compute-and-display><display-directive> {
      make 'find and show outliers';
    } else {
      make 'find outliers';
    }
  }

  method find-outliers-spec($/) {
    if $<compute-and-display><display-directive> {
      make 'find and show outliers';
    } else {
      make 'find outliers';
    }
  }

  # Find anomalies command
  method find-anomalies-command($/) { make $/.values[0].made; }

  method find-anomalies-by-residuals-threshold($/) { make 'find anomalies by using residuals with the threshold: ' ~ $<number-value>.made ~ ')'; }
  method find-anomalies-by-residuals-outliers($/) { make 'find anomalies by using residuals with the outlier identifier: ' ~ $<variable-name>.made ~ ')'; }

  # Plot command
  method plot-command($/) {
    my Str $opts = '';
    if $/.keys.contains(<date-list-diagram>) { $opts = $<date-list-diagram>.made; }
    make 'show plot' ~ ( $opts ?? ' with parameters: ' ~ $opts !! '');
  }

  method date-list-diagram($/) {
    my Str $opts = '';
    if $/.keys.contains(<date-origin>) { $opts = ', ' ~ $<date-origin>.made; }
    make 'use date axis' ~ $opts;
  }
  method date-origin($/) { make 'date origin is: ' ~ $<date-spec>.made; }
  method date-spec($/) { make "'" ~ $/.Str ~ "'"; }

  # Error plot command
  method plot-errors-command($/) { make $/.values[0].made; }
  method plot-errors-with-directive($/) {
    my $err_type = True;
    if $<errors-type> && $<errors-type>.trim eq 'absolute' { $err_type = False  }
    make "show plot of {$err_type ?? 'relative' !! 'absolute'} errors";
  }

  ## Setup code
  method setup-code-command($/) {
    make 'SETUPCODE' => ''
  }
}
