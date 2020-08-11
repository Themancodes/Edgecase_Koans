require File.expand_path(File.dirname(__FILE__) + '/neo')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

#conteo returns a count for every number in dice for example
#[1,1,3,5,7]             <-- given this array
#[0,1,2,3,4,5,6,7,8,9]   <-- creates 0-9 array
#[0,2,0,1,0,1,0,1,0,0]   <-- returns this aray

def score(dice)
    
  if dice.empty?
    return 0
  end

  var_score = 0

  conteo = (0..9).to_a.each.map { |x| dice.count(x)} 
  
  #Evaluating 1
  if ( conteo[1] / 3 ) >= 0
    multiplier1 = conteo[1]/3
    var_score += multiplier1 * 1000
  end

  if ( conteo[1] % 3 ) != 0
    var_score += (conteo[1] % 3)*100
  end
  
  #Evaluating 5
  if ( conteo[5] % 3 ) != 0
    var_score += (conteo[5] % 3)* 50
  end

  #Evaluating numbers x 3    
  if (conteo[2..9].count { |x| x >= 3 }) > 0
    triplets = conteo[2..9].map {|x| x / 3}
    array_multiplicator = triplets.each_with_index.select {|num,index| (num > 0)}.map {|x| x[0]}
    product_triplets = triplets.each_with_index.select {|num,index| (num > 0)}.map {|x| x[1]}.map {|x| (x+2)*100}
    var_score += array_multiplicator.zip(product_triplets).map{|x| x.inject(&:*)}.sum
  end

  var_score
end


class AboutScoringProject < Neo::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
    assert_equal 1100, score([1,1,1,1])
    assert_equal 1200, score([1,1,1,1,1])
    assert_equal 1150, score([1,1,1,5,1])
  end

end
