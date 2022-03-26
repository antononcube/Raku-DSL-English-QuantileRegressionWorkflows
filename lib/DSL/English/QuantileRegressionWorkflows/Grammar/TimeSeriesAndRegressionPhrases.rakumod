use v6;

use DSL::Shared::Roles::English::PipelineCommand;
use DSL::Shared::Utilities::FuzzyMatching;

# Time series and regression specific phrases
role DSL::English::QuantileRegressionWorkflows::Grammar::TimeSeriesAndRegressionPhrases
        does DSL::Shared::Roles::English::PipelineCommand {

    # Proto tokens

    proto token LeastSquares-name {*}
    token LeastSquares-name:sym<English> { :i 'LeastSquares' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'LeastSquares', 2) }> }

    proto token QuantileRegression-name {*}
    token QuantileRegression-name:sym<English> { :i 'QuantileRegression' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'QuantileRegression', 2) }> }

    proto token QuantileRegressionFit-name {*}
    token QuantileRegressionFit-name:sym<English> { :i 'QuantileRegressionFit' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'QuantileRegressionFit', 2) }> }

    proto token absolute-adjective {*}
    token absolute-adjective:sym<English> { :i 'absolute' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'absolute', 2) }> }

    proto token anomalies-noun {*}
    token anomalies-noun:sym<English> { :i 'anomalies' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'anomalies', 2) }> }

    proto token anomaly-noun {*}
    token anomaly-noun:sym<English> { :i 'anomaly' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'anomaly', 2) }> }

    proto token average-adjective {*}
    token average-adjective:sym<English> { :i 'average' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'average', 2) }> | 'mean' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'mean', 2) }> }

    proto token curve-noun {*}
    token curve-noun:sym<English> { :i 'curve' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'curve', 2) }> }

    proto token curves-noun {*}
    token curves-noun:sym<English> { :i 'curves' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'curves', 2) }> }

    proto token date-noun {*}
    token date-noun:sym<English> { :i 'date' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'date', 2) }> }

    proto token dates-noun {*}
    token dates-noun:sym<English> { :i 'dates' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'dates', 2) }> }

    proto token degree-noun {*}
    token degree-noun:sym<English> { :i 'degree' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'degree', 2) }> }

    proto token error-noun {*}
    token error-noun:sym<English> { :i 'error' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'error', 2) }> }

    proto token errors-noun {*}
    token errors-noun:sym<English> { :i 'error' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'error', 2) }> | 'errors' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'errors', 2) }> }

    proto token fit-noun {*}
    token fit-noun:sym<English> { :i 'fit' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'fit', 1) }> | 'fitting' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'fitting', 2) }> }

    proto token fitted-adjective {*}
    token fitted-adjective:sym<English> { :i 'fitted' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'fitted', 2) }> }

    proto token hold-verb {*}
    token hold-verb:sym<English> { :i 'hold' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'hold', 2) }> }

    proto token identifier {*}
    token identifier:sym<English> { :i 'identifier' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'identifier', 2) }> }

    proto token ingest {*}
    token ingest:sym<English> { :i 'ingest' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'ingest', 2) }> | 'load' | 'use' | 'get' }

    proto token interpolation-noun {*}
    token interpolation-noun:sym<English> { :i 'interpolation' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'interpolation', 2) }> }

    proto token knots-noun {*}
    token knots-noun:sym<English> { :i 'knots' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'knots', 2) }> }

    proto token least-adjective {*}
    token least-adjective:sym<English> { :i 'least' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'least', 2) }> }

    proto token linear-adjective {*}
    token linear-adjective:sym<English> { :i 'linear' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'linear', 2) }> }

    proto token map-noun {*}
    token map-noun:sym<English> { :i 'map' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'map', 1) }> }

    proto token mean-noun {*}
    token mean-noun:sym<English> { :i 'mean' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'mean', 2) }> }

    proto token median-noun {*}
    token median-noun:sym<English> { :i 'median' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'median', 2) }> }

    proto token moving-adjective {*}
    token moving-adjective:sym<English> { :i 'moving' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'moving', 2) }> }

    proto token order-noun {*}
    token order-noun:sym<English> { :i 'order' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'order', 2) }> }

    proto token origin-noun {*}
    token origin-noun:sym<English> { :i 'origin' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'origin', 2) }> }

    proto token outlier-noun {*}
    token outlier-noun:sym<English> { :i 'outlier' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'outlier', 2) }> }

    proto token outliers-noun {*}
    token outliers-noun:sym<English> { :i 'outliers' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'outliers', 2) }> | 'outlier' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'outlier', 2) }> }

    proto token probabilities-noun {*}
    token probabilities-noun:sym<English> { :i 'probabilities' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'probabilities', 2) }> }

    proto token probability-noun {*}
    token probability-noun:sym<English> { :i 'probability' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'probability', 2) }> }

    proto token quantile-noun {*}
    token quantile-noun:sym<English> { :i 'quantile' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'quantile', 2) }> }

    proto token quantiles-noun {*}
    token quantiles-noun:sym<English> { :i 'quantiles' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'quantiles', 2) }> }

    proto token regressand-noun {*}
    token regressand-noun:sym<English> { :i 'regressand' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'regressand', 2) }> }

    proto token regression-noun {*}
    token regression-noun:sym<English> { :i 'regression' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'regression', 2) }> }

    proto token regressor-noun {*}
    token regressor-noun:sym<English> { :i 'regressor' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'regressor', 2) }> }

    proto token relative-adjective {*}
    token relative-adjective:sym<English> { :i 'relative' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'relative', 2) }> }

    proto token residuals-noun {*}
    token residuals-noun:sym<English> { :i 'residuals' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'residuals', 2) }> }

    proto token squares-noun {*}
    token squares-noun:sym<English> { :i 'squares' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'squares', 2) }> }

    proto token threshold {*}
    token threshold:sym<English> { :i 'threshold' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'threshold', 2) }> }

    proto token x-symbol {*}
    token x-symbol:sym<English> { :i 'x' | 'X' }

    proto token y-symbol {*}
    token y-symbol:sym<English> { :i 'y' | 'Y' }

    # Directives

    proto token resample-directive {*}
    token resample-directive:sym<English> { :i 'resample' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'resample', 2) }> }

    proto token rescale-directive {*}
    token rescale-directive:sym<English> { :i 'rescale' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'rescale', 2) }> }

    # Rules

    proto rule least-squares-phrase {*}
    rule least-squares-phrase:sym<English> {  <least-adjective> <squares-noun>  }

    proto rule qr-object {*}
    rule qr-object:sym<English> {  [ 'QR' | 'qr' | <quantile-regression-phrase> ]? <object-noun>  }

    proto rule quantile-regression-phrase {*}
    rule quantile-regression-phrase:sym<English> {  <quantile-noun> <regression-noun>  }

    proto rule regression-known-function-name {*}
    rule regression-known-function-name:sym<English> {  <QuantileRegression-name> | <QuantileRegressionFit-name> | <LeastSquares-name>  }

    proto rule the-outliers {*}
    rule the-outliers:sym<English> {  <the-determiner> <outliers-noun>  }

    proto rule time-axis-phrase {*}
    rule time-axis-phrase:sym<English> {  <time-noun> <axis-noun>  }

    proto rule value-axis-phrase {*}
    rule value-axis-phrase:sym<English> {  <value-noun> <axis-noun>  }

    proto rule value-from-left-phrase {*}
    rule value-from-left-phrase:sym<English> {  <value-noun> <from-proposition> <left-noun>  }

}

