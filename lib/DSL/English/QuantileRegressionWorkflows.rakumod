=begin pod

=head1 DSL::English::QuantileRegressionWorkflows

C<DSL::English::QuantileRegressionWorkflows> package has grammar classes and action classes for the parsing and
interpretation of English natural speech commands that specify Quantile Regression (QR) workflows.

=head1 Synopsis

    use DSL::English::QuantileRegressionWorkflows;
    my $gcode = ToQuantileRegressionWorkflowCode("compute quantile regression with 0.1 amd 0.9; show outliers");
    my $rcode = to_QRMon_R("compute quantile regression with 0.1 amd 0.9; show outliers");

=end pod

unit module DSL::English::QuantileRegressionWorkflows;

use DSL::Shared::Utilities::CommandProcessing;

use DSL::English::QuantileRegressionWorkflows::Grammar;
use DSL::English::QuantileRegressionWorkflows::Actions::Bulgarian::Standard;
use DSL::English::QuantileRegressionWorkflows::Actions::English::Standard;
use DSL::English::QuantileRegressionWorkflows::Actions::Python::QRMon;
use DSL::English::QuantileRegressionWorkflows::Actions::R::QRMon;
use DSL::English::QuantileRegressionWorkflows::Actions::Russian::Standard;
use DSL::English::QuantileRegressionWorkflows::Actions::WL::QRMon;

my %targetToAction{Str} =
    "Bulgarian"        => DSL::English::QuantileRegressionWorkflows::Actions::Bulgarian::Standard,
    "English"          => DSL::English::QuantileRegressionWorkflows::Actions::English::Standard,
    "Python"           => DSL::English::QuantileRegressionWorkflows::Actions::Python::QRMon,
    "Python-QRMon"     => DSL::English::QuantileRegressionWorkflows::Actions::Python::QRMon,
    "R"                => DSL::English::QuantileRegressionWorkflows::Actions::R::QRMon,
    "R-QRMon"          => DSL::English::QuantileRegressionWorkflows::Actions::R::QRMon,
    "Russian"          => DSL::English::QuantileRegressionWorkflows::Actions::Russian::Standard,
    "Mathematica"      => DSL::English::QuantileRegressionWorkflows::Actions::WL::QRMon,
    "WL"               => DSL::English::QuantileRegressionWorkflows::Actions::WL::QRMon,
    "WL-QRMon"         => DSL::English::QuantileRegressionWorkflows::Actions::WL::QRMon;

my %targetToAction2{Str} = %targetToAction.grep({ $_.key.contains('-') }).map({ $_.key.subst('-', '::') => $_.value }).Hash;
%targetToAction = |%targetToAction , |%targetToAction2;

my Str %targetToSeparator{Str} =
    "Bulgarian"        => "\n",
    "English"          => "\n",
    "R"                => " %>%\n",
    "R-QRMon"          => " %>%\n",
    "Mathematica"      => " \\[DoubleLongRightArrow]\n",
    "Python"           => "\n",
    "Python-QRMon"     => "\n",
    "Russian"          => "\n",
    "WL"               => " \\[DoubleLongRightArrow]\n",
    "WL-QRMon"         => " \\[DoubleLongRightArrow]\n";

my Str %targetToSeparator2{Str} = %targetToSeparator.grep({ $_.key.contains('-') }).map({ $_.key.subst('-', '::') => $_.value }).Hash;
%targetToSeparator = |%targetToSeparator , |%targetToSeparator2;

#-----------------------------------------------------------
proto ToQuantileRegressionWorkflowCode(Str $command, | ) is export {*}

multi ToQuantileRegressionWorkflowCode(Str $command, Str :$target = 'R-QRMon', *%args ) {
    return ToQuantileRegressionWorkflowCode($command, $target, |%args);
}

multi ToQuantileRegressionWorkflowCode( Str $command, Str $target = 'R-QRMon', *%args ) {

    my $lang = %args<language>:exists ?? %args<language> !! 'English';
    $lang = $lang.wordcase;

    my $gname = "DSL::{$lang}::QuantileRegressionWorkflows::Grammar";

    try require ::($gname);
    if ::($gname) ~~ Failure { die "Failed to load the grammar $gname." }

    my Grammar $grammar = ::($gname);

    DSL::Shared::Utilities::CommandProcessing::ToWorkflowCode( $command,
                                                               :$grammar,
                                                               :%targetToAction,
                                                               :%targetToSeparator,
                                                               :$target,
                                                               |%args )

}