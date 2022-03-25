use v6;

use DSL::Shared::Roles::English::PipelineCommand;
use DSL::Shared::Utilities::FuzzyMatching;

# Time series and regression specific phrases
role DSL::English::QuantileRegressionWorkflows::Grammar::TimeSeriesAndRegressionPhrases
        does DSL::Shared::Roles::English::PipelineCommand {

    # Proto tokens
    token absolute-adjective { 'absolute' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'absolute') }> }
    token anomalies-noun { 'anomalies' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'anomalies') }> }
    token anomaly-noun { 'anomaly' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'anomaly') }> }
    token average-adjective { 'average' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'average') }> | 'mean' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'mean') }> }
    token curve-noun { 'curve' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'curve') }> }
    token curves-noun { 'curves' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'curves') }> }
    token date-noun { 'date' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'date') }> }
    token dates-noun { 'dates' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'dates') }> }
    token degree-noun { 'degree' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'degree') }> }
    token error-noun { 'error' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'error') }> }
    token errors-noun { 'error' | 'errors' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'errors') }> }
    token fit-noun { 'fit' }
    token fitted-adjective { 'fitted' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'fitted') }> }
    token hold-verb { 'hold' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'hold') }> }
    token identifier { 'identifier' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'identifier') }> }
    token ingest { 'ingest' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'ingest') }> | 'load' | 'use' | 'get' }
    token interpolation-noun { 'interpolation' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'interpolation') }> }
    token knots-noun { 'knots' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'knots') }> }
    token least-adjective { 'least' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'least') }> }
    token linear-adjective { 'linear' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'linear') }> }
    token map-noun { 'map' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'map') }> }
    token mean-noun { 'mean' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'mean') }> }
    token median-noun { 'median' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'median') }> }
    token moving-adjective { 'moving' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'moving') }> }
    token order-noun { 'order' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'order') }> }
    token origin-noun { 'origin' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'origin') }> }
    token outlier-noun { 'outlier' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'outlier') }> }
    token outliers-noun { 'outliers' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'outliers') }> | 'outlier' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'outlier') }> }
    token probabilities-noun { 'probabilities' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'probabilities') }> }
    token probability-noun { 'probability' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'probability') }> }
    token quantile-noun { 'quantile' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'quantile') }> }
    token quantiles-noun { 'quantiles' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'quantiles') }> }
    token regressand-noun { 'regressand' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'regressand') }> }
    token regression-noun { 'regression' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'regression') }> }
    token regressor-noun { 'regressor' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'regressor') }> }
    token relative-adjective { 'relative' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'relative') }> }
    token residuals-noun { 'residuals' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'residuals') }> }
    token squares-noun { 'squares' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'squares') }> }
    token threshold { 'threshold' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'threshold') }> }
    token x-symbol { 'x' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'x') }> | 'X' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'X') }> }
    token y-symbol { 'y' | 'Y' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'Y') }> }

    # Directives
    token resample-directive { 'resample' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'resample') }> }
    token rescale-directive { 'rescale' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'rescale') }> }

    # Rules
    rule least-squares-phrase { <least-adjective> <squares-noun> }
    rule quantile-regression-phrase { <quantile-noun> <regression-noun> }
    rule qr-object { [ 'QR' | 'qr' | <quantile-regression-phrase> ]? <object-noun> }
    rule the-outliers { <the-determiner> <outliers-noun> }
    rule value-from-left-phrase { 'value' 'from' 'left' }

    rule time-axis-phrase { <time-noun> <axis-noun> }
    rule value-axis-phrase { <value-noun> <axis-noun> }

}

