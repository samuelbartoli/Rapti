module ObjectiveScoresHelper

#Creates the instances in the ObjectiveScore Model
#to be filled by the users
    def fill_objective_score
        objectives = Objective.all
        dates = ScoreDate.all
        objectives.each{|obj|
            dates.each{|da|
                ObjectiveScore.new(:objective_id => obj.id, :scoredate_id => da.id, :score => rand(100), :redfrom => obj.redfrom, :redto => obj.redto, :yellowfrom => obj.yellowfrom, :yellowto => obj.yellowto, :greenfrom => obj.greenfrom, :greento => obj.greento).save
            }
        }
    end

  def getLastNobjectiveScore(n, objective, date)
      dateObject = Date.new(date.year,date.month,1)        
      dates = []
      dates << date
      n = n-1
      n.times{
          dateObject = dateObject - 1.month
          dates << ScoreDate.find_by_month_and_year(dateObject.month,dateObject.year)
      }
      scores = []
      dates.each{|d|
          scores.unshift(ObjectiveScore.find_by_objective_id_and_scoredate_id(objective.id, d.id))            
      }
      return scores 
  end

  def state(ind,date)
    score = IndicatorScore.find_by_indicator_id_and_scoredate_id(ind.id,date.id).score
    if score >= ind.redfrom && score < ind.redto
      return 'btn btn-danger'
    end
    if score >= ind.yellowfrom && score <= ind.yellowto
      return 'btn btn-warning'
    end
    if score > ind.greenfrom && score <= ind.greento
      return 'btn btn-success'
    end
  end

  def fill_em
    os = ObjectiveScore.all
    os.each{|o|
      o.redfrom = 0
      o.redto = 25
      o.yellowfrom = 25 
      o.yellowto = 75 
      o.greenfrom =75
      o.greento = 100
      o.progress = rand(100)
      o.baseline = rand(100)
      o.growth = rand(100)
      o.goal = rand(100)
      o.save
    }
  end

  def indicatorscorestate(ind)
    score = ind.score
    if score >= ind.redfrom && score < ind.redto
      return 'btn btn-danger'
    end
    if score >= ind.yellowfrom && score <= ind.yellowto
      return 'btn btn-warning'
    end
    if score > ind.greenfrom && score <= ind.greento
      return 'btn btn-success'
    end
  end

end
