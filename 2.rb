require 'rubygems'
require 'parslet'
require 'pp'

class Parser < Parslet::Parser
  rule(:lparen)       { space? >> str('(') >> space? }
  rule(:rparen)       { space? >> str(')') }
  
  rule(:space)        { match('\s').repeat(1) }
  rule(:space?)       { space.maybe }

  rule(:number)       { match('[0-9]').repeat(1).as(:number) }

  rule(:expression)   { number >> (space >> number).repeat }
  rule(:list)         { lparen >> expression.as(:list) >> rparen }
  rule(:program)      { list.repeat }
  
  root :program
end

parser = Parser.new
source_file = File.open(ARGV[0])
pp parser.parse(source_file.read())
source_file.close()
