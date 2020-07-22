use v6;

use DSL::Shared::Roles::English::CommonParts;
use DSL::Shared::Utilities::FuzzyMatching;

# Time series and regression specific phrases
role DSL::English::QuantileRegressionWorkflows::Grammar::TimeSeriesAndRegressionPhrases
        does DSL::Shared::Roles::English::CommonParts {

    # Proto tokens
    token absolute { 'absolute' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'absolute') }> }
    token anomalies { 'anomalies' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'anomalies') }> }
    token anomaly { 'anomaly' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'anomaly') }> }
    token average { 'average' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'average') }> | 'mean' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'mean') }> }
    token curve { 'curve' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'curve') }> }
    token curves { 'curves' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'curves') }> }
    token date { 'date' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'date') }> }
    token dates { 'dates' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'dates') }> }
    token degree { 'degree' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'degree') }> }
    token error { 'error' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'error') }> }
    token errors { 'error' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'error') }> | 'errors' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'errors') }> }
    token fit { 'fit' }
    token fitted { 'fitted' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'fitted') }> }
    token hold-verb { 'hold' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'hold') }> }
    token identifier { 'identifier' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'identifier') }> }
    token ingest { 'ingest' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'ingest') }> | 'load' | 'use' | 'get' }
    token interpolation { 'interpolation' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'interpolation') }> }
    token knots { 'knots' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'knots') }> }
    token least { 'least' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'least') }> }
    token linear { 'linear' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'linear') }> }
    token map-noun { 'map' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'map') }> }
    token mean { 'mean' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'mean') }> }
    token median { 'median' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'median') }> }
    token moving { 'moving' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'moving') }> }
    token order { 'order' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'order') }> }
    token origin { 'origin' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'origin') }> }
    token outlier { 'outlier' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'outlier') }> }
    token outliers { 'outliers' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'outliers') }> | 'outlier' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'outlier') }> }
    token probabilities { 'probabilities' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'probabilities') }> }
    token probability { 'probability' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'probability') }> }
    token quantile { 'quantile' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'quantile') }> }
    token quantiles { 'quantiles' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'quantiles') }> }
    token regressand { 'regressand' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'regressand') }> }
    token regression { 'regression' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'regression') }> }
    token regressor { 'regressor' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'regressor') }> }
    token relative { 'relative' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'relative') }> }
    token residuals { 'residuals' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'residuals') }> }
    token squares { 'squares' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'squares') }> }
    token threshold { 'threshold' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'threshold') }> }
    token x-symbol { 'x' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'x') }> | 'X' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'X') }> }
    token y-symbol { 'y' | 'Y' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'Y') }> }

    # Directives
    token resample-directive { 'resample' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'resample') }> }
    token rescale-directive { 'rescale' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'rescale') }> }

    # Rules
    rule least-squares-phrase { <least> <squares> }
    rule quantile-regression-phrase { <quantile> <regression> }
    rule qr-object { [ 'QR' | 'qr' | <quantile-regression-phrase> ]? <object> }
    rule the-outliers { <the-determiner> <outliers> }
    rule value-from-left-phrase { 'value' 'from' 'left' }

    rule time-axis-phrase { <time-noun> <axis-noun> }
    rule value-axis-phrase { <value-noun> <axis-noun> }

}

