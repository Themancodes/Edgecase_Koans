# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
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


def score(dice)
    
  if dice.empty?
    return 0
  end

  var_score = 0

  #returns a count for every number in dice for example
  #[1,1,3,5,7]             <-- given this array
  #[0,1,2,3,4,5,6,7,8,9]   <-- creates 0-9 array
  #[0,2,0,1,0,1,0,1,0,0]   <-- returns this aray

  conteo = (0..9).to_a.each.map { |x| dice.count(x)} 
  
  #Evaluating 1
  if ( conteo[1] % 3 ) == 0
    multiplier1 = conteo[1]/3
    var_score += multiplier1 * 1000
  end

  if ( conteo[1] % 3 ) != 0
    var_score += (conteo[1] % 3)*100
  end
  
  #Evaluating 5
  if ( conteo[5] % 3 ) != 0
    var_score += conteo[5] * 50
  end

  #Evaluating numbers x 3    
  if (conteo[2..9].count { |x| x >= 3 }) > 0 
    var_score += conteo[2..9].each.map.sum {|x| x >= 3 ? x*100 : 0 }

    tmult [1,1,2]
    base [300,500,800]
    tmult.zip(base).map{|x| x.inject(&:*)}.sum



  end

  var_score
end


p score([2,2,2,4])
