=begin comment
#==============================================================================
#
#   Quantile Regression workflows grammar in Raku Perl 6
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
#   For more details about Raku Perl6 see https://perl6.org/ .
#
#==============================================================================
#
#  The grammar design in this file follows very closely the EBNF grammar
#  for Mathematica in the GitHub file:
#    https://github.com/antononcube/ConversationalAgents/blob/master/EBNF/English/Mathematica/QuantileRegressionWorkflowsGrammar.m
#
#==============================================================================
=end comment

use v6;

use DSL::English::QuantileRegressionWorkflows::Grammar::TimeSeriesAndRegressionPhrases;
use DSL::Shared::Roles::English::PipelineCommand;
use DSL::Shared::Roles::ErrorHandling;
use DSL::English::QuantileRegressionWorkflows::Grammarish;

grammar DSL::English::QuantileRegressionWorkflows::Grammar
        does DSL::English::QuantileRegressionWorkflows::Grammarish
        does DSL::English::QuantileRegressionWorkflows::Grammar::TimeSeriesAndRegressionPhrases
        does DSL::Shared::Roles::ErrorHandling {

}
