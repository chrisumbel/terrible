require 'rubygems'
require 'parslet'
require 'pp'
require 'java'
require 'bitescript'

class Parser < Parslet::Parser
  rule(:space)        { match('\s').repeat(1) }
  rule(:space?)       { space.maybe }

  rule(:lparen)       { space? >> str('(') >> space? }
  rule(:rparen)       { space? >> str(')') }
    
  rule(:number)       { match('[0-9]').repeat(1).as(:number) }

  rule(:list)         { lparen >> number >> rparen }
  rule(:program)      { list.repeat }
  
  root :program
end

parser = Parser.new
source_file = File.open(ARGV[0])
pp parser.parse(source_file.read())
source_file.close()
