
use v6.d;

use DSL::Shared::Actions::Bulgarian::PipelineCommand;
use DSL::Shared::Actions::Bulgarian::Standard::PipelineCommand;

class DSL::English::QuantileRegressionWorkflows::Actions::Bulgarian::Standard
        does DSL::Shared::Actions::Bulgarian::Standard::PipelineCommand
        is DSL::Shared::Actions::Bulgarian::PipelineCommand {

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
  method load-data($/) { make 'зареди данните: ' ~ $<data-location-spec>.made; }
  method data-location-spec($/) { make $<dataset-name>.made; }
  method use-qr-object($/) { make $<variable-name>.made; }
  method use-dataset($/) { make 'създай обект за квантилна регресия с: ' ~ $<variable-name>.made; }
  method dataset-name($/) { make $/.Str; }

  # Create commands
  method create-command($/) { make $/.values[0].made; }
  method create-simple($/) { make 'създай обект за квантилна регресия'; }
  method create-by-dataset($/) { make 'създай обект за квантилна регресия с данните: ' ~ $<dataset-name>.made; }

  # Data transform command
  method data-transformation-command($/) { make $/.values[0].made; }

  method delete-missing($/) { make 'премахни либсващи стойности'; }

  method rescale-command($/) { make 'премащабирай: ' ~ $/.values[0].made; }
  method rescale-axis($/) { make $/.values[0].made; }
  method axis-spec($/) { make $/.values[0].made; }
  method regressor-axis-spec($/) { make 'по регресионната ос'; }
  method value-axis-spec($/) { make 'по стойностната ос'; }

  method rescale-both-axes($/) { make 'по регрессионната и стойностната оси'; }

  method resample-command($/) { make 'ресемплирай данните'; }

  method moving-func-command($/) { make 'преобразувай с движещ се прозорец'; }

  # Data statistics command
  method data-statistics-command($/) { make $/.values[0].made; }
  method summarize-data($/) { make 'покажи обобщение на данните'; }

  # Quantile Regression
  method regression-command($/) { make $/.values[0].made; }
  method quantile-regression-spec($/) { make $/.values[0].made; }
  method quantile-regression-spec-simple($/) { make 'изчисли квантилна регресия'; }
  method quantile-regression-spec-full($/) {  make 'изчисли квантилна регресия с параметерите: ' ~ $<quantile-regression-spec-element-list>.made; }

  method quantile-regression-spec-element-list($/) {

    my $res = $<quantile-regression-spec-element>>>.made.join(', ');

    my @ks = $<quantile-regression-spec-element>>>.keys;

    if @ks.first('knots-spec-subcommand') {
      make $res;
    } else {
      make 'степени на свобода (възли): 12, ' ~ $res ;
    }
  }

  method quantile-regression-spec-element($/) { make $/.values[0].made; }

  # QR element - list of probabilities.
  method probabilities-spec-subcommand($/) {
    make $<probabilities-spec>.made ?? 'вероятности: ' ~ $<probabilities-spec>.made !! 'автоматични вероятности';
  }
  method probabilities-spec($/) { make $/.values[0].made; }

  # QR element - knots.
  method knots-spec-subcommand($/) { make 'степени на свобода (възли): ' ~ $<knots-spec>.made; }
  method knots-spec($/) { make $/.values[0].made; }

  # QR element - interpolation order.
  method interpolation-order-spec-subcommand($/) { make 'интерполационна степен: ' ~ $<interpolation-order-spec>.made; }
  method interpolation-order-spec($/) { make $/.values[0].made; } # make $.<integer-value>.made;

  # Find outliers command
  method find-outliers-command($/) { make $/.values[0].made; }

  method find-outliers-simple($/) {
    if $<compute-and-display><display-directive> {
      make 'намери и покажи извънредните стойности';
    } else {
      make 'намери извънредните стойности';
    }
  }

  method find-type-outliers($/) {
    if $<compute-and-display><display-directive> {
      make 'намери и покажи извънредните стойности';
    } else {
      make 'намери извънредните стойности';
    }
  }

  method find-outliers-spec($/) {
    if $<compute-and-display><display-directive> {
      make 'намери и покажи извънредните стойности';
    } else {
      make 'намери извънредните стойности';
    }
  }

  # Find anomalies command
  method find-anomalies-command($/) { make $/.values[0].made; }

  method find-anomalies-by-residuals-threshold($/) { make 'намери аномалии чрез използване на остатъци с прага: ' ~ $<number-value>.made ~ ')'; }
  method find-anomalies-by-residuals-outliers($/) { make 'намери аномалии чрез използване на остатъци с детектора: ' ~ $<variable-name>.made ~ ')'; }

  # Plot command
  method plot-command($/) {
    my Str $opts = '';
    if $/.keys.contains(<date-list-diagram>) { $opts = $<date-list-diagram>.made; }
    make 'покажи диаграма' ~ ( $opts ?? ' с параметри: ' ~ $opts !! '');
  }

  method date-list-diagram($/) {
    my Str $opts = '';
    if $/.keys.contains(<date-origin>) { $opts = ', ' ~ $<date-origin>.made; }
    make 'използвайки ос от дати' ~ $opts;
  }
  method date-origin($/) { make 'отправна дата: ' ~ $<date-spec>.made; }
  method date-spec($/) { make "'" ~ $/.Str ~ "'"; }

  # Error plot command
  method plot-errors-command($/) { make $/.values[0].made; }
  method plot-errors-with-directive($/) {
    my $err_type = True;
    if $<errors-type> && $<errors-type>.trim eq 'absolute' { $err_type = False  }
    make "покажи диаграма на {$err_type ?? 'относителните' !! 'абсолютните'} грешки";
  }

  ## Setup code
  method setup-code-command($/) {
    make 'SETUPCODE' => ''
  }
}
