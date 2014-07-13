#!/usr/bin/ruby

def goal
  #'i think that i shall never see'
  "Shall I compare thee to a summers day Thou art more lovely and more temperate Rough winds do shake the darling buds of May And summers lease hath all too short a date Sometime too hot the eye of heaven shines And often is his gold complexion dimmed And every fair from fair sometime declines By chance or natures changing course untrimmed But thy eternal summer shall not fade Nor lose possession of that fair thou owst Nor shall death brag thou wandrest in his shade When in eternal lines to Time thou growst So long as men can breathe or eyes can see So long lives this and this gives life to thee".downcase
end

@gen = '-' * goal.length
@score = 0
@generation = 0
@keep = Hash.new

def evolve gen
  # evolve continues evolving till we get a 'sonnet' with a higher score
  # than the one we started with
  score = 0
  until score > @score do
    gen = randomise @gen
    score = compare(gen)
  end
  @gen = gen
  @score = score
end

def compare attempt
  score = 0
  for i in 0..goal.length - 1 do
    if attempt[i] == goal[i] then
      score += 1
      @keep[i] = 1
    end
  end
  score
end

def randomise thing
  @generation += 1
  pos = get_pos
  char = (rand(27)+97).chr
  char = ' ' if char == '{'
  thing[pos] = char

  thing
end

def get_pos
  pos = nil
  while pos.nil? || @keep.include?(pos) do
    pos = rand(goal.length)
  end
  pos
end

goal.length.times do
  puts "gen #{@generation} score #{@score} - #{@gen}\n\n" if @generation % 50 == 0
  evolve @gen
end

puts @gen
puts "chance to get this completely at random - 27 ** #{goal.length} #{27 ** goal.length}"
# note Anthony Flew (from Gerald Schroeder) gives this as 26 ** 488 (not counting spaces)"
puts "evolutionary generations - #{@generation}"

