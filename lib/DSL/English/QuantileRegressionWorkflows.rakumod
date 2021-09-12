=begin pod

=head1 DSL::English::QuantileRegressionWorkflows

C<DSL::English::QuantileRegressionWorkflows> package has grammar classes and action classes for the parsing and
interpretation of English natural speech commands that specify Quantile Regression (QR) workflows.

=head1 Synopsis

    use DSL::English::QuantileRegressionWorkflows;
    my $rcode = to_QRMon_R("compute quantile regression with 0.1 amd 0.9; show outliers");

=end pod

unit module DSL::English::QuantileRegressionWorkflows;

use DSL::Shared::Utilities::MetaSpecsProcessing;

use DSL::English::QuantileRegressionWorkflows::Grammar;
use DSL::English::QuantileRegressionWorkflows::Actions::Python::QRMon;
use DSL::English::QuantileRegressionWorkflows::Actions::R::QRMon;
use DSL::English::QuantileRegressionWorkflows::Actions::WL::QRMon;

my %targetToAction =
    "Python"           => DSL::English::QuantileRegressionWorkflows::Actions::Python::QRMon,
    "Python-QRMon"     => DSL::English::QuantileRegressionWorkflows::Actions::Python::QRMon,
    "Python::QRMon"    => DSL::English::QuantileRegressionWorkflows::Actions::Python::QRMon,
    "R"                => DSL::English::QuantileRegressionWorkflows::Actions::R::QRMon,
    "R-QRMon"          => DSL::English::QuantileRegressionWorkflows::Actions::R::QRMon,
    "R::QRMon"         => DSL::English::QuantileRegressionWorkflows::Actions::R::QRMon,
    "Mathematica"      => DSL::English::QuantileRegressionWorkflows::Actions::WL::QRMon,
    "WL"               => DSL::English::QuantileRegressionWorkflows::Actions::WL::QRMon,
    "WL-QRMon"         => DSL::English::QuantileRegressionWorkflows::Actions::WL::QRMon,
    "WL::QRMon"        => DSL::English::QuantileRegressionWorkflows::Actions::WL::QRMon;

my %targetToSeparator{Str} =
    "R"                => " %>%\n",
    "R-QRMon"          => " %>%\n",
    "R::QRMon"         => " %>%\n",
    "Mathematica"      => " \\[DoubleLongRightArrow]\n",
    "Python"           => "\n",
    "Python-QRMon"     => "\n",
    "Python::QRMon"    => "\n",
    "WL"               => " \\[DoubleLongRightArrow]\n",
    "WL-QRMon"         => " \\[DoubleLongRightArrow]\n",
    "WL::QRMon"        => " \\[DoubleLongRightArrow]\n";


#-----------------------------------------------------------
sub has-semicolon (Str $word) {
    return defined index $word, ';';
}

#-----------------------------------------------------------
proto ToQuantileRegressionWorkflowCode(Str $command, Str $target = 'R-QRMon' ) is export {*}

multi ToQuantileRegressionWorkflowCode ( Str $command where not has-semicolon($command), Str $target = 'R-QRMon' ) {

    die 'Unknown target.' unless %targetToAction{$target}:exists;

    my $match = DSL::English::QuantileRegressionWorkflows::Grammar.parse($command, actions => %targetToAction{$target} );
    die 'Cannot parse the given command.' unless $match;
    return $match.made;
}

multi ToQuantileRegressionWorkflowCode ( Str $command where has-semicolon($command), Str $target = 'R-QRMon' ) {

    my $specTarget = get-dsl-spec( $command, 'target');

    $specTarget = $specTarget ?? $specTarget<DSLTARGET> !! $target;

    die 'Unknown target.' unless %targetToAction{$specTarget}:exists;

    my @commandLines = $command.trim.split(/ ';' \s* /);

    @commandLines = grep { $_.Str.chars > 0 }, @commandLines;

    my @cmdLines = map { ToQuantileRegressionWorkflowCode($_, $specTarget) }, @commandLines;

    @cmdLines = grep { $_.^name eq 'Str' }, @cmdLines;

    my Str $res = @cmdLines.join( %targetToSeparator{$specTarget} ).trim;

    return $res.subst( / ^^ \h* <{ '\'' ~ %targetToSeparator{$specTarget}.trim ~ '\'' }> \h* /, ''):g
}

#-----------------------------------------------------------
proto to_QRMon_Python($) is export {*}

multi to_QRMon_Python ( Str $command ) {
    return ToQuantileRegressionWorkflowCode( $command, 'Python-QRMon' );
}

#-----------------------------------------------------------
proto to_QRMon_R($) is export {*}

multi to_QRMon_R ( Str $command ) {
    return ToQuantileRegressionWorkflowCode( $command, 'R-QRMon' );
}

#-----------------------------------------------------------
proto to_QRMon_WL($) is export {*}

multi to_QRMon_WL ( Str $command ) {
    return ToQuantileRegressionWorkflowCode( $command, 'WL-QRMon' );
}
