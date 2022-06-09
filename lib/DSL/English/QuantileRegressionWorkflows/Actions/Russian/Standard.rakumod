
use v6.d;

use DSL::Shared::Actions::Bulgarian::PipelineCommand;
use DSL::Shared::Actions::Russian::Standard::PipelineCommand;

class DSL::English::QuantileRegressionWorkflows::Actions::Russian::Standard
        does DSL::Shared::Actions::Russian::Standard::PipelineCommand
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
  method load-data($/) { make 'загрузить данные: ' ~ $<data-location-spec>.made; }
  method data-location-spec($/) { make $<dataset-name>.made; }
  method use-qr-object($/) { make $<variable-name>.made; }
  method use-dataset($/) { make 'создать объект квантильной регрессии с: ' ~ $<variable-name>.made; }
  method dataset-name($/) { make $/.Str; }

  # Create commands
  method create-command($/) { make $/.values[0].made; }
  method create-simple($/) { make 'создать объект квантильной регрессии'; }
  method create-by-dataset($/) { make 'создать объект квантильной регрессии с данными: ' ~ $<dataset-name>.made; }

  # Data transform command
  method data-transformation-command($/) { make $/.values[0].made; }

  method delete-missing($/) { make 'удалить пропущенные значения'; }

  method rescale-command($/) { make 'перемасштабировать: ' ~ $/.values[0].made; }
  method rescale-axis($/) { make $/.values[0].made; }
  method axis-spec($/) { make $/.values[0].made; }
  method regressor-axis-spec($/) { make 'по оси регрессии'; }
  method value-axis-spec($/) { make 'по оси значений'; }

  method rescale-both-axes($/) { make 'по осям регрессии и значений'; }

  method resample-command($/) { make 'передискретизировать данные'; }

  method moving-func-command($/) { make 'преобразование скользящего среднего'; }

  # Data statistics command
  method data-statistics-command($/) { make $/.values[0].made; }
  method summarize-data($/) { make 'показать сводку данных'; }

  # Quantile Regression
  method regression-command($/) { make $/.values[0].made; }
  method quantile-regression-spec($/) { make $/.values[0].made; }
  method quantile-regression-spec-simple($/) { make 'рассчитать квантильную регрессию'; }
  method quantile-regression-spec-full($/) {  make 'рассчитать квантильную регрессию с параметрами: ' ~ $<quantile-regression-spec-element-list>.made; }

  method quantile-regression-spec-element-list($/) {

    my $res = $<quantile-regression-spec-element>>>.made.join(', ');

    my @ks = $<quantile-regression-spec-element>>>.keys;

    if @ks.first('knots-spec-subcommand') {
      make $res;
    } else {
      make 'степени свободы (узлы): 12, ' ~ $res ;
    }
  }

  method quantile-regression-spec-element($/) { make $/.values[0].made; }
  # рассчитать квантильную регрессию с автоматическими вероятностями
  # QR element - list of probabilities.
  method probabilities-spec-subcommand($/) {
    make $<probabilities-spec>.made ?? 'вероятностями: ' ~ $<probabilities-spec>.made !! 'автоматическими вероятностями';
  }
  method probabilities-spec($/) { make $/.values[0].made; }

  # QR element - knots.
  method knots-spec-subcommand($/) { make 'степени свободы (узлы): ' ~ $<knots-spec>.made; }
  method knots-spec($/) { make $/.values[0].made; }

  # QR element - interpolation order.
  method interpolation-order-spec-subcommand($/) { make 'порядок интерполяции: ' ~ $<interpolation-order-spec>.made; }
  method interpolation-order-spec($/) { make $/.values[0].made; } # make $.<integer-value>.made;

  # Find outliers command
  method find-outliers-command($/) { make $/.values[0].made; }

  method find-outliers-simple($/) {
    if $<compute-and-display><display-directive> {
      make 'найти и показать экстраординарные значения';
    } else {
      make 'найти экстраординарные значения';
    }
  }

  method find-type-outliers($/) {
    if $<compute-and-display><display-directive> {
      make 'найти и показать экстраординарные значения';
    } else {
      make 'найти экстраординарные значения';
    }
  }

  method find-outliers-spec($/) {
    if $<compute-and-display><display-directive> {
      make 'найти и показать экстраординарные значения';
    } else {
      make 'найти экстраординарные значения';
    }
  }

  # Find anomalies command
  method find-anomalies-command($/) { make $/.values[0].made; }

  method find-anomalies-by-residuals-threshold($/) { make 'найти аномалии, используя остатки с порогом: ' ~ $<number-value>.made ~ ')'; }
  method find-anomalies-by-residuals-outliers($/) { make 'найти аномалии, используя остатки с детектором: ' ~ $<variable-name>.made ~ ')'; }

  # Plot command
  method plot-command($/) {
    my Str $opts = '';
    if $/.keys.contains(<date-list-diagram>) { $opts = $<date-list-diagram>.made; }
    make 'показать диаграмму' ~ ( $opts ?? ' с параметрами: ' ~ $opts !! '');
  }

  method date-list-diagram($/) {
    my Str $opts = '';
    if $/.keys.contains(<date-origin>) { $opts = ', ' ~ $<date-origin>.made; }
    make 'использованием оси дат' ~ $opts;
  }
  method date-origin($/) { make 'дата начала: ' ~ $<date-spec>.made; }
  method date-spec($/) { make "'" ~ $/.Str ~ "'"; }

  # Error plot command
  method plot-errors-command($/) { make $/.values[0].made; }
  method plot-errors-with-directive($/) {
    my $err_type = True;
    if $<errors-type> && $<errors-type>.trim eq 'absolute' { $err_type = False  }
    make "показать диаграму на {$err_type ?? 'относительных' !! 'абсолютных'} ошибок";
  }
}
