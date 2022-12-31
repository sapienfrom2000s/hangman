# frozen_string_literal: true
require_relative 'choice.rb'
require_relative 'inaugration.rb'
include Inaugration

welcome
instruction
choose = Choice.new
choose.newgame_or_loadgame
